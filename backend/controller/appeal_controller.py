from flask import render_template, request, Flask, jsonify, session, make_response
from controller import bp_appeal as appeal
from controller import db_controller as db
from chat_gpt import gpt_plugin
import json
import jwt
import logging
import urllib


app = db.init_database()
mysql = db.init(app)

###
# 로깅 레벨 설정
app.logger.setLevel(logging.DEBUG)

# 로깅 핸들러 추가
stream_handler = logging.StreamHandler()

messages = []  # 채팅 기록 저장


@appeal.route('/', methods=['GET', 'POST'])
def home():
    return 'appeal'

@appeal.route("/answer", methods=["POST"]) 
def answer():
    user_msg = json.loads(request.data.decode('utf-8'))
    
    query = user_msg["chat"][-1]["content"]
    app.logger.info("=======================")
    app.logger.info(user_msg["chat"])
    app.logger.info(user_msg["chat"][-1])
    app.logger.info("=======================")
    user_id = user_msg['userId']
    dog_id = user_msg['dogId']
    frend_number = 1
    
    db.save_chat_content( app, mysql, frend_number, query , 0, 'NULL' , 'NULL' )

    # GPT 프롬프트 엔지니어링 부분 모듈 로드
    answer = gpt_plugin.gpt(user_msg, app=app)

    answer_date = db.save_chat_content( app, mysql, frend_number , answer , 1, 'NULL' , 'NULL' )
    

    message = {                       # 주고받는 메세지의 속성값을 저장한다
        'message_type': 'bot', 
        'dog_name': '뽀또',
        'message_content': answer,
        'time': answer_date
    }
    

    return jsonify(message) # message 안에는 (messsagetype(사용자인지,봇인지 판단), 강아지 이름, 강아지 채팅 내용, 시간) 으로 이루어져있다.


# 채팅 페이지
@appeal.route("/load_chat_page", methods=["GET", "POST"])
def load_chat_page():
    
    dog_id = request.args.get('dogid')             # 멍소개 페이지에서 보낸 유기견의 id를 받아온다
    user_id = 'yc'
    friend_number = 1

    
    
    dog_info = db.get_dog_info(app, mysql, dog_id) # 이 함수의 결과는 (' 결과 ',)로 나온다
    dog_info = [t for t in dog_info[0]]
    dog_info_json = {"dog_id":dog_id,"dog_name":dog_info[0], "img_src":dog_info[1],"user_id":user_id}

    return render_template("chat.html", dog_info=dog_info_json)

@appeal.route("/load_before_chat", methods=["POST"])
def load_before_chat():
    friend_number = request.get_data(as_text=True).strip()

    # 추후에 바꿔야함
    user_id = 'yc'
    dog_id  = 'abc000'

    # 데이터베이스 채팅 10개 가져오기
    cookie_name = f'{friend_number}_friend_chat_list'
    chat_info = db.load_chat(app,mysql,friend_number)
    
    chat_contents = [{ "no":idx, "content":urllib.parse.quote(content.encode("utf-8")),"send":int.from_bytes(send), "date":str(date) } for idx, (content, send, date) in enumerate(chat_info)]
    current_chat_list = {
            "user_id" : user_id,
            "dog_id"  : dog_id,
            "chat": chat_contents
        }

    resp = make_response('쿠키가 설정되었습니다')
    app.logger.info(chat_contents)

    resp.set_cookie(cookie_name, json.dumps(current_chat_list).encode('utf-8'))

    return resp


@appeal.route('/mgti_start', methods=['GET', 'POST'])
def mgti_start():
    return render_template("mgti_start.html")

# MGTI 진행 페이지


@appeal.route('/mgti_ing', methods=['GET', 'POST'])
def mgti_ing():
    return render_template("mgti_ing.html")


# MGTI 결과 페이지
@appeal.route('/mgti_res', methods=['GET', 'POST'])
def mgti_res():
    return render_template("mgti_res.html")

# MGTI 고른거 전송 라우트


@appeal.route('/res2', methods=['get', 'post'])
def res2():
    if request.method == 'POST':
        I, E, S, N, T, J, F, P = 0, 0, 0, 0, 0, 0, 0, 0
        data = request.get_json()       # mgti_res페이지에서 보낸 mgti결과 딕셔너리를 받는다
    for key, value in data.items():
        if key == '0' or key == '1' or key == '2':
            if value == '0':
                I += 1
            elif value == '1':
                E += 1
        elif key == '3':
            if value == '0':
                I += 2 
            elif value == '1':
                E += 2
        elif key == '4' or key == '6' or key == '7':
            if value == '0':
                N += 1
            elif value == '1':
                S += 1
        elif key == '5':
            if value == '0':
                N += 2
            elif value == '1':
                S += 2
        elif key == '9' or key == '10' or key == '11':
            if value == '0':
                T += 1
            elif value == '1':
                F += 1
        elif key == '8':
            if value == '0':
                T += 2
            elif value == '1':
                F += 2
        elif key == '12' or key == '13' or key == '14':
            if value == '0':
                J += 1
            elif value == '1':
                P += 1 

    if I > E:
        A = "I"
    elif E > I:
        A = "E"
    else:
        A = ""

    if N > S:
        B = "N"
    elif S > N:
        B = "S"
    else:
        B = ""

    if T > F:
        C = "T"
    elif F > T:
        C = "F"
    else:
        C = ""

    if J > P:
        D = "J"
    elif P > J:
        D = "P"
    else:
        D = ""      # 받아온 딕셔너리의 내용을 바탕으로 mgti를 도출하는 용도

    mgti = f"{A}{B}{C}{D}"
    mgti_info = db.mgti_commantary(app,mysql,mgti) # mgti_commantary는 db에 접근해 mgti관련 정보를 가져오는 함수이다
    fl_info = list(mgti_info[0])
    fl_info.append(mgti) # fl_info에 mgti_commantary 결과값과 mgti를 넣는다(html에서 한번에 리스트로 받기 위함)
    if None not in fl_info:
        fl_info.append(mgti_info[1][4]) # 디퓨전 프사가 없다면 null값일수 있음
        fl_info.append(mgti_info[1][9])
    return fl_info