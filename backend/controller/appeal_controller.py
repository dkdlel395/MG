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


# 프론트에서 쓰여진 채팅 받아오는 함수
@appeal.route("/upload_text", methods=["POST"])
def upload_text():
    user_name = "user_name"
    message_content = request.form.get('msg')
    current_time = time.time()
    message = {
        'message_type': 'chat',
        'user_name': user_name,
        'message_content': message_content,
        'time': current_time
    }
    messages.append(message)
    # message 안에는 (messsagetype(사용자인지,봇인지 판단), 사용자 이름, 사용자 채팅 내용, 시간) 으로 이루어져있다.
    return jsonify(message)

# 챗봇 응답 처리


@appeal.route("/answer", methods=["POST"])
def answer():
    answer = "gpt답변"
    current_time = time.time()
    message = {
        'message_type': 'bot',
        'dog_name': '뽀또',
        'message_content': answer,
        'time': current_time
    }
    messages.append(message)
    # message 안에는 (messsagetype(사용자인지,봇인지 판단), 강아지 이름, 강아지 채팅 내용, 시간) 으로 이루어져있다.
    return jsonify(message)


# 채팅 페이지
@appeal.route("/chat", methods=["GET", "POST"])
def chatting():
    user_input = request.form.get("msg")
    response = answer()
    chat_get_dog_info = db.chat_get_dog_info(app, mysql, 1111111111)
    chat_user_id_name_pic = db.chat_user_id_name_pic()
    return render_template("chat.html", user_input=user_input, response=response, messages=messages, chat_get_dog_info=chat_get_dog_info, chat_user_id_name_pic=chat_user_id_name_pic)

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
        data = request.get_json()
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
        D = ""

    mgti = f"{A}{B}{C}{D}"
    return mgti