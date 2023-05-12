from flask import render_template, request, Flask, jsonify
from controller import bp_appeal as appeal
from controller import db_controller
import time


db = db_controller
app = db.init_database()
mysql = db.init(app)

appeal_app = Flask(__name__)

messages = []  # 채팅 기록 저장

@appeal.route('/', methods=['GET', 'POST'])
def home():
    from chat_gpt import gpt_plugin

    text = gpt_plugin.gpt('안녕')

    return text    


# 프론트에서 쓰여진 채팅 받아오는 함수
@appeal.route("/upload_text", methods=["POST"])
def upload_text():
    user_name = "user_name"
    data = request.data.decode('utf-8')
    current_time = time.time()
    message = {
        'message_type': 'chat',
        'user_name': user_name,
        'message_content': data,
        'time': current_time
    }
    messages.append(message)
    print(messages)
    return jsonify(message)  # message 안에는 (messsagetype(사용자인지,봇인지 판단), 사용자 이름, 사용자 채팅 내용, 시간) 으로 이루어져있다.

# 챗봇 응답 처리
@appeal.route("/answer", methods=["POST"])
def answer():
    data = request.data.decode('utf-8')

    from chat_gpt import gpt_plugin
    text = gpt_plugin.gpt(data)

    current_time = time.time()
    message = {
        'message_type': 'bot',
        'dog_name': '뽀또',
        'message_content': text,
        'time': current_time
    }
    messages.append(message)
    return jsonify(message) # message 안에는 (messsagetype(사용자인지,봇인지 판단), 강아지 이름, 강아지 채팅 내용, 시간) 으로 이루어져있다.


# 채팅 페이지
@appeal.route("/chat", methods=["GET", "POST"])
def chatting():
    user_input = request.form.get("msg")
    
    response = answer()
    chat_get_dog_info = db.chat_get_dog_info(app,mysql,1111111111) 
    chat_user_id_name_pic = db.chat_user_id_name_pic()
    return render_template("chat.html", user_input=user_input, response=response, messages=messages,chat_get_dog_info=chat_get_dog_info,chat_user_id_name_pic=chat_user_id_name_pic)

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
@appeal.route('/res2', methods=['get','post'])
def res2():
    if request.method == 'POST':
        data = request.get_json()
        
        return data['0']