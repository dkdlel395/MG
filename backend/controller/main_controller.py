from flask import render_template, request, redirect, url_for
from controller import bp_main as main
from controller import db_controller

db = db_controller
app = db.init_database( )
mysql = db.init(app)

# 마스터 페이지
@main.route('/', methods=['get','post'])
def home():
    popular_doges =  db.take_popular_dog( app, mysql, 3 )
    return render_template( 'main.html' , dogs=popular_doges) # dog_image_address는 강아지 사진 주소를 프론트엔드로 보낼때 사용하는 함수

# 메인 페이지
@main.route('/mainpage', methods=['get','post'])
def mainpage():
    main_dogs_id =  [dog[0] for dog in db.main_dog( app, mysql, 3 , 'animal_id') ]      # 친구수가 많은 순 3마리의 ID를 DB에서 가져오기
    main_dogs_name = [dog[0] for dog in db.main_dog( app, mysql, 3 , 'animal_name') ]   # TOP3 이름 
    main_dogs_age =  [dog[0] for dog in db.main_dog( app, mysql, 3 , 'age') ]           # TOP3 나이
    main_dogs_img = [dog[0] for dog in db.main_dog( app, mysql, 3 , 'propile') ]        # TOP3 사진 링크
    return render_template( 'mainpage.html' , main_dogs_id=main_dogs_id, main_dogs_img=main_dogs_img, main_dogs_name=main_dogs_name, main_dogs_age=main_dogs_age)

# 소개 페이지
# intro_input_dog_id -> URL을 통해 ID를 받아 사용
@main.route('/introduction/<intro_input_dog_id>', methods=['get','post'])
def introduction(intro_input_dog_id):
    intro_dogs_id = intro_input_dog_id  # URL을 통해 얻은 유기견 ID
    # intro_dog() 함수의 인자값으로 DB에서 정보를 가져옴
    intro_dogs_name = [dog[0] for dog in db.intro_dog( app, mysql, intro_input_dog_id , 'animal_name') ]    # ID에 해당하는 유기견 이름 DB에서 가져오기
    intro_dogs_age = [dog[0] for dog in db.intro_dog( app, mysql, intro_input_dog_id , 'age') ]             # 유기견 나이
    intro_dogs_img = [dog[0] for dog in db.intro_dog( app, mysql, intro_input_dog_id , 'propile') ]         # 유기견 사진
    return render_template( 'introduction.html' ,intro_dogs_id=intro_dogs_id, intro_dogs_name=intro_dogs_name, intro_dogs_age=intro_dogs_age, intro_dogs_img=intro_dogs_img)