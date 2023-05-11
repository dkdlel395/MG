-- 테이블 순서는 관계를 고려하여 한 번에 실행해도 에러가 발생하지 않게 정렬되었습니다.

-- species_information Table Create SQL
-- 테이블 생성 SQL - species_information
CREATE TABLE species_information
(
    `no`            int(11)     NOT NULL    COMMENT '유기동물품종번호', 
    `species_name`  CHAR(10)    NOT NULL    COMMENT '유기동물품종이름', 
     PRIMARY KEY (no)
);


-- auth Table Create SQL
-- 테이블 생성 SQL - auth
CREATE TABLE auth
(
    `no`    VARCHAR(2)    NOT NULL    DEFAULT '' COMMENT '유저구분(번호)', 
    `auth`  CHAR(6)       NOT NULL    DEFAULT '' COMMENT '유저구분(텍스트)', 
     PRIMARY KEY (no)
);


-- abandoned_animal Table Create SQL
-- 테이블 생성 SQL - abandoned_animal
CREATE TABLE abandoned_animal
(
    `animal_id`               CHAR(15)        NOT NULL    COMMENT '유기동물아이디', 
    `animal_name`             CHAR(10)        NOT NULL    COMMENT '유기동물이름', 
    `species`                 int(11)         NOT NULL    COMMENT '유기동물품종번호', 
    `gender`                  CHAR(2)         NOT NULL    COMMENT '유기동물성별', 
    `age`                     int(11)         NOT NULL    COMMENT '유기동물나이', 
    `weight`                  FLOAT           NOT NULL    COMMENT '유기동물몸무게', 
    `personality`             VARCHAR(300)    NULL        DEFAULT NULL COMMENT '유기동물성격', 
    `reason_for_abandonment`  VARCHAR(300)    NULL        DEFAULT NULL COMMENT '유기사유', 
    `potty_training`          BIT(1)          NULL        DEFAULT b'0' COMMENT '배변교육여부', 
    `abuse`                   BIT(1)          NULL        DEFAULT b'0' COMMENT '학대여부', 
    `disease`                 VARCHAR(100)    NULL        DEFAULT NULL COMMENT '질병', 
    `shyness`                 int(11)         NULL        DEFAULT NULL COMMENT '낯가림', 
    `loneliness`              int(11)         NULL        DEFAULT NULL COMMENT '외로움', 
    `introduction`            VARCHAR(500)    NULL        DEFAULT NULL COMMENT '소개글', 
    `location`                CHAR(64)        NULL        DEFAULT NULL COMMENT '지역', 
    `shelter_name`            CHAR(20)        NULL        DEFAULT NULL COMMENT '보호소이름', 
    `increased_friends`       int(11)         NULL        DEFAULT NULL COMMENT '증가한친구수', 
    `total_friends`           int(11)         NULL        DEFAULT NULL COMMENT '전체친구수', 
    `upload_status`           CHAR(10)        NULL        DEFAULT NULL COMMENT '업로드상태', 
    `registration_date`       DATE            NULL        DEFAULT NULL COMMENT '등록날짜', 
     PRIMARY KEY (animal_id)
);

-- Index 설정 SQL - abandoned_animal(species)
CREATE INDEX fk_abandoned_animal_species_information
    ON abandoned_animal(species);

-- Foreign Key 설정 SQL - abandoned_animal(species) -> species_information(no)
ALTER TABLE abandoned_animal
    ADD CONSTRAINT fk_abandoned_animal_species_information FOREIGN KEY (species)
        REFERENCES species_information (no) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Foreign Key 삭제 SQL - abandoned_animal(species)
-- ALTER TABLE abandoned_animal
-- DROP FOREIGN KEY fk_abandoned_animal_species_information;


-- user Table Create SQL
-- 테이블 생성 SQL - user
CREATE TABLE user
(
    `user_id`          CHAR(15)      NOT NULL    COMMENT '유저아이디', 
    `user_pw`          CHAR(64)      NOT NULL    COMMENT '유저비밀번호', 
    `user_name`        CHAR(6)       NOT NULL    COMMENT '유저이름', 
    `user_nickname`    CHAR(15)      NOT NULL    COMMENT '유저닉네임', 
    `identity_number`  CHAR(13)      NOT NULL    COMMENT '유저주민번호', 
    `phone`            CHAR(11)      NOT NULL    COMMENT '유저전화번호', 
    `address`          CHAR(64)      NOT NULL    COMMENT '유저주소', 
    `business_number`  CHAR(10)      NULL        DEFAULT NULL COMMENT '사업자번호', 
    `auth`             VARCHAR(2)    NULL        DEFAULT '' COMMENT '유저구분(번호)', 
     PRIMARY KEY (user_id)
);

-- Index 설정 SQL - user(auth)
CREATE INDEX auth
    ON user(auth);

-- Foreign Key 설정 SQL - user(auth) -> auth(no)
ALTER TABLE user
    ADD CONSTRAINT fk_user_auth FOREIGN KEY (auth)
        REFERENCES auth (no) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Foreign Key 삭제 SQL - user(auth)
-- ALTER TABLE user
-- DROP FOREIGN KEY fk_user_auth;


-- friend_list Table Create SQL
-- 테이블 생성 SQL - friend_list
CREATE TABLE friend_list
(
    `no`         int(11)     NOT NULL    AUTO_INCREMENT COMMENT 'no', 
    `user_id`    CHAR(15)    NULL        DEFAULT NULL COMMENT '유저아이디', 
    `animal_id`  CHAR(15)    NULL        DEFAULT NULL COMMENT '유기동물아이디', 
     PRIMARY KEY (no)
);

-- Index 설정 SQL - friend_list(animal_id)
CREATE INDEX fk_friend_list_animal_id
    ON friend_list(animal_id);

-- Index 설정 SQL - friend_list(user_id)
CREATE INDEX fk_friend_list_user_id
    ON friend_list(user_id);

-- Foreign Key 설정 SQL - friend_list(animal_id) -> abandoned_animal(animal_id)
ALTER TABLE friend_list
    ADD CONSTRAINT fk_friend_list_animal_id FOREIGN KEY (animal_id)
        REFERENCES abandoned_animal (animal_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Foreign Key 삭제 SQL - friend_list(animal_id)
-- ALTER TABLE friend_list
-- DROP FOREIGN KEY fk_friend_list_animal_id;

-- Foreign Key 설정 SQL - friend_list(user_id) -> user(user_id)
ALTER TABLE friend_list
    ADD CONSTRAINT fk_friend_list_user_id FOREIGN KEY (user_id)
        REFERENCES user (user_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Foreign Key 삭제 SQL - friend_list(user_id)
-- ALTER TABLE friend_list
-- DROP FOREIGN KEY fk_friend_list_user_id;


-- species_for_mbti Table Create SQL
-- 테이블 생성 SQL - species_for_mbti
CREATE TABLE species_for_mbti
(
    `mbti_type`      CHAR(4)    NOT NULL    COMMENT 'mbti_type', 
    `species_one`    int(11)    NULL        COMMENT '품종추천1', 
    `species_two`    int(11)    NULL        COMMENT '품종추천2', 
    `species_photo`  BLOB       NULL        COMMENT '품종사진', 
     PRIMARY KEY (mbti_type)
);

-- Index 설정 SQL - species_for_mbti(species_one)
CREATE INDEX fk_species_for_mbti_species_one
    ON species_for_mbti(species_one);

-- Index 설정 SQL - species_for_mbti(species_two)
CREATE INDEX fk_species_for_mbti_species_two
    ON species_for_mbti(species_two);

-- Foreign Key 설정 SQL - species_for_mbti(species_one) -> abandoned_animal(species)
ALTER TABLE species_for_mbti
    ADD CONSTRAINT FK_species_for_mbti_species_one_abandoned_animal_species FOREIGN KEY (species_one)
        REFERENCES abandoned_animal (species) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Foreign Key 삭제 SQL - species_for_mbti(species_one)
-- ALTER TABLE species_for_mbti
-- DROP FOREIGN KEY FK_species_for_mbti_species_one_abandoned_animal_species;

-- Foreign Key 설정 SQL - species_for_mbti(species_two) -> abandoned_animal(species)
ALTER TABLE species_for_mbti
    ADD CONSTRAINT fk_species_for_mbti_species_two FOREIGN KEY (species_two)
        REFERENCES abandoned_animal (species) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Foreign Key 삭제 SQL - species_for_mbti(species_two)
-- ALTER TABLE species_for_mbti
-- DROP FOREIGN KEY fk_species_for_mbti_species_two;


-- mbti_information Table Create SQL
-- 테이블 생성 SQL - mbti_information
CREATE TABLE mbti_information
(
    `user_id`    CHAR(15)    NOT NULL    COMMENT '유저아이디', 
    `mbti_type`  CHAR(4)     NULL        DEFAULT NULL COMMENT 'mbti_type'
);

-- Index 설정 SQL - mbti_information(user_id)
CREATE INDEX fk_mbti_information_user_id
    ON mbti_information(user_id);

-- Foreign Key 설정 SQL - mbti_information(user_id) -> user(user_id)
ALTER TABLE mbti_information
    ADD CONSTRAINT fk_mbti_information_user_id FOREIGN KEY (user_id)
        REFERENCES user (user_id) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Foreign Key 삭제 SQL - mbti_information(user_id)
-- ALTER TABLE mbti_information
-- DROP FOREIGN KEY fk_mbti_information_user_id;


-- chat Table Create SQL
-- 테이블 생성 SQL - chat
CREATE TABLE chat
(
    `no`                int(11)         NOT NULL    AUTO_INCREMENT COMMENT 'no', 
    `friend_list_no`    int(11)         NULL        DEFAULT NULL COMMENT 'friend_list_no', 
    `chat_content`      VARCHAR(500)    NULL        DEFAULT NULL COMMENT '채팅내용', 
    `sent_or_received`  BIT(1)          NULL        DEFAULT b'0' COMMENT '수발신여부', 
    `chat_date`         DATE            NULL        DEFAULT NULL COMMENT '시간', 
    `suitability_type`  CHAR(10)        NULL        DEFAULT NULL COMMENT '적합성타입', 
    `suitability`       BIT(1)          NULL        DEFAULT b'0' COMMENT '적합성여부', 
     PRIMARY KEY (no)
);

-- Index 설정 SQL - chat(friend_list_no)
CREATE INDEX fk_chat_friend_list_no
    ON chat(friend_list_no);

-- Foreign Key 설정 SQL - chat(friend_list_no) -> friend_list(no)
ALTER TABLE chat
    ADD CONSTRAINT fk_chat_friend_list_no FOREIGN KEY (friend_list_no)
        REFERENCES friend_list (no) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Foreign Key 삭제 SQL - chat(friend_list_no)
-- ALTER TABLE chat
-- DROP FOREIGN KEY fk_chat_friend_list_no;


