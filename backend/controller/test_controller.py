from flask import render_template, request, redirect, url_for
from controller import bp_test as test
import json
import requests
import logging
import environment as env
import time
import datetime


# 마스터페이지 -> 여기 의미 없는 페이지라 나중에 메인페이지로 변경하면 될듯
@test.route('/sim', methods=['GET','post'])
def sim():
  from pymysqlpool.pool import Pool
  pool = Pool(
            host        = env.db_ip,
            port        = env.db_port,
            user        = env.db_user_id,
            password    = env.db_user_pw,
            database    = env.db_name,
        )
        
  pool.init()

  connection = pool.get_conn()
  cur = connection.cursor()

  
  #트라이캐치 붙히기
  # args는 튜플로 구성
  chat_date = str(datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'))
  cur.execute("""INSERT INTO chat ( friend_list_no, chat_content, sent_or_received, chat_date, suitability_type, suitability ) VALUES ( 1, %s, 1, %s, null, null  );""", 
              args=('안녕하세요. 나는 테스트입니다', chat_date))

  connection.commit()
  cur.execute("SELECT LAST_INSERT_ID();")
  _, result = next(iter(cur.fetchone().items()))
  return str(result)


    
