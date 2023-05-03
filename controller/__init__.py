from flask import Blueprint

# 메인서비스페이지 - A 개발자 담당 -> 모든  url은 ~/main/~
bp_db = Blueprint('db_bp',  # 별칭, 해당 블루프린트 밑에서 정의된 
                                # 라우트및함수를 url_for('main_bp.home') 로 지칭할때 사용
                    __name__,   # 고정
                    url_prefix='/db',             # 모든 URL 앞에 /main이 추가된다
                    template_folder='../templates/db', # html이 위치하는 폴더 지정
                    static_folder='../static'       # 정적데이터의 위치 폴더 지정
                    )

bp_main = Blueprint('main_bp',  # 별칭, 해당 블루프린트 밑에서 정의된 
                                # 라우트및함수를 url_for('main_bp.home') 로 지칭할때 사용
                    __name__,   # 고정
                    url_prefix='/main',             # 모든 URL 앞에 /main이 추가된다
                    template_folder='../templates/main', # html이 위치하는 폴더 지정
                    static_folder='../static'       # 정적데이터의 위치 폴더 지정
                    )

bp_appeal = Blueprint('appeal_bp',  # 별칭, 해당 블루프린트 밑에서 정의된 
                                # 라우트및함수를 url_for('main_bp.home') 로 지칭할때 사용
                    __name__,   # 고정
                    url_prefix='/appeal',             # 모든 URL 앞에 /main이 추가된다
                    template_folder='../templates/appeal', # html이 위치하는 폴더 지정
                    static_folder='../static'       # 정적데이터의 위치 폴더 지정
                    )
