from flask import render_template, request, redirect, url_for
from controller import bp_main as main
from controller import db_controller
import json

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
    dogs=[db.main_dog( app, mysql, 3 , 'animal_id, animal_name, age, diffusion_profile_image')]

    main_dogs_id = list()
    main_dogs_name = list()
    main_dogs_age = list()
    main_dogs_img = list()
    
    for dog1 in dogs:
        for dog in dog1:
            main_dogs_id.append(dog[0]) 
            main_dogs_name.append(dog[1])
            main_dogs_age.append(dog[2])
            main_dogs_img.append(dog[3])

    return render_template( 'mainpage.html' , main_dogs_id=main_dogs_id, main_dogs_img=main_dogs_img, main_dogs_name=main_dogs_name, main_dogs_age=main_dogs_age)

# 소개페이지
@main.route('/introduction/<intro_input_dog_id>', methods=['get','post'])
def introduction(intro_input_dog_id):
    intro_dogs_id = intro_input_dog_id
    intro_dogs_name    = [dog[0] for dog in db.intro_dog( app, mysql, intro_input_dog_id , 'animal_name') ]
    intro_dogs_age     = [dog[0] for dog in db.intro_dog( app, mysql, intro_input_dog_id , 'age') ]
    intro_dogs_img     = [dog[0] for dog in db.intro_dog( app, mysql, intro_input_dog_id , 'diffusion_profile_image') ]
    intro_dogs_species = [dog[0] for dog in db.species_dog(app, mysql, intro_input_dog_id , 'species_name')]

    if request.method == 'GET':
        return render_template( 'introduction.html' ,intro_dogs_id=intro_dogs_id, intro_dogs_name=intro_dogs_name, intro_dogs_age=intro_dogs_age, intro_dogs_img=intro_dogs_img, intro_dogs_species=intro_dogs_species)
    else:
        dogid = request.form.get('dogid')
        return redirect(url_for('appeal_bp.load_chat_page', dogid=dogid))