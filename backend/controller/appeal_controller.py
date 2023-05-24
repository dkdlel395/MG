from flask import render_template, request, Flask, jsonify, session
from controller import bp_appeal as appeal
from controller import db_controller
import time


db = db_controller
app = db.init_database()
mysql = db.init(app)


messages = []  # 채팅 기록 저장


@appeal.route('/', methods=['GET', 'POST'])
def home():
    return 'appeal'




@appeal.route("/answer", methods=["POST"]) 
def answer():
    data = request.data.decode('utf-8')

    from chat_gpt import gpt_plugin   # GPT 프롬프트 엔지니어링 부분 모듈 로드
    text = gpt_plugin.gpt(data)

    current_time = time.time()
    message = {                       # 주고받는 메세지의 속성값을 저장한다
        'message_type': 'bot',
        'dog_name': '뽀또',
        'message_content': text,
        'time': current_time
    }
    messages.append(message)
    return jsonify(message) # message 안에는 (messsagetype(사용자인지,봇인지 판단), 강아지 이름, 강아지 채팅 내용, 시간) 으로 이루어져있다.


# 채팅 페이지
@appeal.route("/chat", methods=["GET", "POST"])
def chat():
    dogid = request.args.get('dogid')             # 멍소개 페이지에서 보낸 유기견의 id를 받아온다
    user_input = request.form.get("msg")
    response = answer()
    chat_dog_name = db.chat_get_dog_name(app, mysql, dogid)[0] # 이 함수의 결과는 (' 결과 ',)로 나온다
    clean_dog_name =f"{chat_dog_name}"[2:-3]      # 문자열로 변환 시켜서 ( , ' 를 없앤다
    chat_dog_pic = db.chat_get_dog_pic(app,mysql,dogid)
    clean_dog_pic = f"{chat_dog_pic}"[2:-3]
    return render_template("chat.html", user_input=user_input, response=response, messages=messages, chat_dog_name=clean_dog_name,chat_dog_pic=clean_dog_pic, dogid=dogid)

# MGTI 시작 페이지


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
    return fl_info