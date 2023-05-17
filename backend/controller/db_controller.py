from controller import bp_db as db
from flask import Flask, render_template, request, redirect, url_for, flash
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text
import pymysql

def init_database( ):
    app = Flask(__name__)
    username = 'root'
    password = '1234'
    host     = '172.17.0.1'
    db_name  = 'dog_db'

    app.config['SQLALCHEMY_DATABASE_URI'] = f'mysql+pymysql://{username}:{password}@{host}/{db_name}'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    return app

def init(app):
    return SQLAlchemy(app)

# 인기있는 강아지의 id를 반환해준다
def take_popular_dog( app, mysql, limit:int ):
    dog_ides = list()

    try:
        with app.app_context():
            cur = mysql.session.execute(text(
                f"""
                    SELECT animal_id FROM abandoned_animal
                    ORDER BY increased_friends DESC
                    LIMIT {limit};
                """
                ))

            for dog_id in cur.fetchall():
                dog_ides.append( dog_id[0] )
                
    except Exception as e:
        print(e)

    print('db_controller파일에서 dog_ides : ', dog_ides)
    return dog_ides

# main : 강아지의 반환
def main_dog( app, mysql, limit:int ,info):
    dog_info = list()
    try:
        with app.app_context():
            cur = mysql.session.execute(text(
                f"""
                    SELECT {info}
                    FROM abandoned_animal
                    ORDER BY increased_friends DESC
                    LIMIT {limit};
                """
                ))
            for dog_id in cur.fetchall():
                dog_info.append( dog_id )
    except Exception as e:
        print(e)
    return dog_info

# 멍소개 : 멍소개 ID 전달
def intro_dog( app, mysql, id, info ):
    dog_info = list()
    try:
        with app.app_context():
            cur = mysql.session.execute(text(
                # abc001
                f"""
                    SELECT {info}
                    FROM abandoned_animal 
                    WHERE animal_id = '{id}'
                """
                ))
            for dog_id in cur.fetchall():
                dog_info.append( dog_id )
    except Exception as e:
        print(e)
    return dog_info

# 소개페이지(품종 : 품종번호->품종이름으로 전달)
def species_dog(app, mysql, id, species_name):
    species_info = list()
    try:
        with app.app_context():
            cur = mysql.session.execute(text(
                f"""
                SELECT {species_name}
                FROM species_information
                WHERE no = (
                    SELECT species
                    FROM abandoned_animal
                    WHERE animal_id = '{id}'
                )
                """
            ))

            for row in cur.fetchall():
                species_info.append(row)

    except Exception as e:
        print(e)
    
    return species_info

################ 종현이 영역 #######################

# 강아지 정보 가져오기
def chat_get_dog_info(app,mysql,selec_id):   # 이 함수는 인자로 준 id의 이름과 사진을 가져온다
    try:
        dog_info = list()
        with app.app_context():
            cur = mysql.session.execute(text(f"""SELECT animal_name,profile FROM abandoned_animal WHERE animal_id = {selec_id} """))
            dog_info = cur.fetchall()
            return dog_info
    except Exception as e:
        print(e)

def chat_user_id_name_pic(): # 채팅 방에서 표시될 사용자 id,이름,사진을 받아오는 함수 (추후엔 db에 접근해야 되니 dbcontroller에 넣었다)
    user_info = ["1","user name","www.userimage.com"]
    return user_info