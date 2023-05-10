from flask import render_template, request, redirect, url_for
from controller import bp_main as main
from controller import db_controller

db = db_controller
app = db.init_database( )
mysql = db.init(app)

# 마스터페이지 -> 여기 의미 없는 페이지라 나중에 메인페이지로 변경하면 될듯
@main.route('/', methods=['get','post'])
def home():
    popular_doges =  db.take_popular_dog( app, mysql, 3 )
    return render_template( 'main.html' , dogs=popular_doges) # dog_image_address는 강아지 사진 주소를 프론트엔드로 보낼때 사용하는 함수

# 메인페이지
@main.route('/mainpage', methods=['get','post'])
def mainpage():
    main_dogs_id =  [dog[0] for dog in db.main_dog( app, mysql, 3 , 'animal_id') ]
    main_dogs_name = [dog[0] for dog in db.main_dog( app, mysql, 3 , 'animal_name') ]
    main_dogs_age =  [dog[0] for dog in db.main_dog( app, mysql, 3 , 'age') ]
    main_dogs_img = [dog[0] for dog in db.main_dog( app, mysql, 3 , 'propile') ]
    return render_template( 'mainpage.html' , main_dogs_id=main_dogs_id, main_dogs_img=main_dogs_img, main_dogs_name=main_dogs_name, main_dogs_age=main_dogs_age)

# 소개페이지
@main.route('/introduction/<intro_input_dog_id>', methods=['get','post'])
def introduction(intro_input_dog_id):
    intro_dogs_id = intro_input_dog_id
    intro_dogs_name = [dog[0] for dog in db.intro_dog( app, mysql, intro_input_dog_id , 'animal_name') ]
    intro_dogs_age = [dog[0] for dog in db.intro_dog( app, mysql, intro_input_dog_id , 'age') ]
    intro_dogs_img = [dog[0] for dog in db.intro_dog( app, mysql, intro_input_dog_id , 'propile') ]
    return render_template( 'introduction.html' ,intro_dogs_id=intro_dogs_id, intro_dogs_name=intro_dogs_name, intro_dogs_age=intro_dogs_age, intro_dogs_img=intro_dogs_img)

# # 멍bti 시작 페이지
# @main.route('/mungbti_start', methods=['get','post'])
# def mungbti_start():
    
#     return render_template('mungbti_start.html')

# # 멍bti 검사 페이지
# @main.route('/mungbti_ing', methods=['get','post'])
# def mungbti_ing():
    
#     return render_template('mungbti_ing.html')

# # 멍bti 고른거 전송 라우트
# @main.route('/res2', methods=['get','post'])
# def res2():
#     if request.method == 'POST':
#         data = request.get_json()

#         return data

# # 채팅 페이지
# @main.route('/chat', methods=['get','post'])
# def chat():
    
#     return render_template('chat.html')