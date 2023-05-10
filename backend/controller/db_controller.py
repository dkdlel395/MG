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
                f"""
                    SELECT {info}
                    FROM abandoned_animal 
                    WHERE animal_id = {id}
                """
                ))
            for dog_id in cur.fetchall():
                dog_info.append( dog_id )
    except Exception as e:
        print(e)
    return dog_info