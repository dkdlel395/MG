from controller import bp_db as db
from flask import Flask, render_template, request, redirect, url_for, flash
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text
import pymysql
import datetime
import logging

def init_database( ):   # DB접근을 위한 함수
    app = Flask(__name__)
    username = 'root'
    password = '1234'
    host     = '172.17.0.1'
    db_name  = 'dog_db'

    app.config['SQLALCHEMY_DATABASE_URI'] = f'mysql+pymysql://{username}:{password}@{host}/{db_name}'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

    ###
    # 로깅 레벨 설정
    app.logger.setLevel(logging.DEBUG)

    # 로깅 핸들러 추가
    stream_handler = logging.StreamHandler()
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

# 강아지 정보 가져오기(이름)
def get_dog_info(app,mysql,selec_id): 
    try:
        dog_name=list()
        with app.app_context():
            cur = mysql.session.execute(text(f"""
                                                SELECT animal_name, profile_image
                                                FROM abandoned_animal 
                                                WHERE animal_id = '{selec_id}' 
                                            """))
            dog_name = cur.fetchall()
            return dog_name
    except Exception as e:
        print(e)

# 채팅 페이지 로드시 content, send, date를 받아온다
def load_chat(app,mysql, friend_number):
    try:
        dog_name=list()
        with app.app_context():
            cur = mysql.session.execute(text(f"""
                                                SELECT chat_content, sent_or_received, chat_date
                                                FROM chat
                                                WHERE friend_list_no = '{friend_number}'
                                                ORDER BY chat_date DESC
                                                LIMIT 10;
                                            """))
            dog_name = cur.fetchall()
            return dog_name
    except Exception as e:
        print(e)


# 채팅 방에서 표시될 사용자 id,이름,사진을 받아오는 함수 (추후엔 db에 접근해야 되니 dbcontroller에 넣었다,지금은 사용안하고 있음)
def chat_user_id_name_pic():
    user_info = ["1","user name","www.userimage.com"]
    return user_info

def save_chat_content( app, mysql, friend_list_no, chat_content, sent_or_received, suitability_type, suitability ):
    chat_date = str(datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'))

    try:
        with app.app_context():
            
            mysql.session.execute(text(f"""
                INSERT INTO chat( friend_list_no, chat_content, chat_date, sent_or_received, suitability_type, suitability )
                VALUES          ( {friend_list_no}, '{chat_content}', '{chat_date}', {sent_or_received}, NULL, NULL );
            """))

            mysql.session.flush()
            mysql.session.commit()

        return chat_date

    except Exception as e:
        print(e)
        return chat_date


# mgti를 받아 종,종의 사진,mgti설명을 받아오는 함수
def mgti_commantary(app,mysql,mgti_type):
    try:
        with app.app_context():
            cur = mysql.session.execute(text(f"""
            SELECT s.mbti_introduction,
                s.species_one,
                s.species_two,
                a.species AS abandoned_species,
                a.diffusion_profile_image,
                s.species_one_photo,
                s.species_one_photo_two,
                s.species_two_photo,
                s.species_two_photo_two
            FROM species_for_mbti s
            LEFT JOIN abandoned_animal a ON s.species_one = a.species OR s.species_two = a.species
            WHERE s.mbti_type = '{mgti_type}'

            """))
            mgti_commant = cur.fetchall()
            return mgti_commant#len(mgti_commant[0])
    except Exception as e:
        print(e)