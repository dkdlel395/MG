-- 테이블 순서는 관계를 고려하여 한 번에 실행해도 에러가 발생하지 않게 정렬되었습니다.
CREATE DATABASE dog_db;
USE dog_db;
-- species_information Table Create SQL
-- 테이블 생성 SQL - species_information
CREATE TABLE species_information
(
    `no`            int(11)     NOT NULL    AUTO_INCREMENT COMMENT '유기동물품종(번호)', 
    `species_name`  CHAR(10)    NOT NULL    COMMENT '유기동물품종(텍스트)', 
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
    `profile_image`       VARCHAR(300)            NULL        DEFAULT NULL COMMENT '원본이미지', 
    `diffusion_profile_image`       VARCHAR(300)           NULL        DEFAULT NULL COMMENT '생성이미지', 
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
    `species_one_photo`      VARCHAR(300)    NULL        COMMENT '품종사진1', 
    `species_two_photo`      VARCHAR(300)    NULL        COMMENT '품종사진2', 
    `mbti_introduction`  VARCHAR(300)    NULL COMMENT 'mbti소개', 
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
        REFERENCES species_information(no) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Foreign Key 삭제 SQL - species_for_mbti(species_one)
-- ALTER TABLE species_for_mbti
-- DROP FOREIGN KEY FK_species_for_mbti_species_one_abandoned_animal_species;

-- Foreign Key 설정 SQL - species_for_mbti(species_two) -> abandoned_animal(species)
ALTER TABLE species_for_mbti
    ADD CONSTRAINT fk_species_for_mbti_species_two FOREIGN KEY (species_two)
        REFERENCES species_information(no) ON DELETE RESTRICT ON UPDATE RESTRICT;

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

-- 강아지 품종
INSERT INTO `species_information` (`no`, `species_name`) VALUES (1, '말티즈');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (2, '푸들');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (3, '웰시코기');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (4, '골든 리트리버');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (5, '닥스훈트');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (6, '치와와');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (7, '진돗개');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (8, '시츄');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (9, '보더콜리');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (10, '셰틀랜드 쉽독');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (11, '래브라도 리트리버');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (12, '골든 리트리버');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (13, '닥스훈트');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (14, '코카 스패니얼');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (15, '웰시코기');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (16, '치와와');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (17, '셰퍼드');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (18, '도베르만');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (19, '프렌치 불독');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (20, '보스턴테리어');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (21, '퍼그');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (22, '시츄');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (23, '올드 잉글리쉬 쉽독');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (24, '사모예드');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (25, '시베리안 허스키');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (26, '알래스칸 말라뮤트');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (27, '비숑 프리제');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (28, '포메라니안');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (29, '슈나우저');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (30, '페키니즈');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (31, '시바견');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (32, '스피츠');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (33, '잭 러셀 테리어');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (34, '말티즈');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (35, '비글');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (36, '풍산개');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (37, '푸들');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (38, '요크셔테리어');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (39, '진돗개');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (40, '그레이 하운드');

--mgti 정보
INSERT INTO `species_for_mbti` (`mbti_type`, `species_one`, `species_two`, `species_one_photo`, `species_two_photo`, `mbti_introduction`) VALUES ('enfj', 23, 24, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%98%AC%EB%93%9C%20%EC%9E%89%EA%B8%80%EB%A6%AC%EC%89%AC%20%EC%89%BD%EB%8F%85.jpg?alt=media&token=a9e4d211-5c80-4fe5-be2c-fc3753a427ea', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%82%AC%EB%AA%A8%EC%98%88%EB%93%9C.jpg?alt=media&token=325721c3-c7e5-4ca7-942b-8d8ffa548040', '친화력이 좋지만 겁 많고 주인 껌딱지에 규칙적인 멍친구들');
INSERT INTO `species_for_mbti` (`mbti_type`, `species_one`, `species_two`, `species_one_photo`, `species_two_photo`, `mbti_introduction`) VALUES ('enfp', 21, 22, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%ED%8D%BC%EA%B7%B8.jpg?alt=media&token=862c29b2-207b-4e2c-b652-e4f22e9a0434', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%8B%9C%EC%B8%84.jpg?alt=media&token=e5cc9b25-eed5-4f91-87c0-00d90f88601d', '친화력이 좋지만 겁 많고 주인 껌딱지에 자유로운 멍친구들');
INSERT INTO `species_for_mbti` (`mbti_type`, `species_one`, `species_two`, `species_one_photo`, `species_two_photo`, `mbti_introduction`) VALUES ('entj', 17, 18, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%85%B0%ED%8D%BC%EB%93%9C.jpg?alt=media&token=c8fada5e-866e-4395-8832-f11c3db96d6e', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EB%8F%84%EB%B2%A0%EB%A5%B4%EB%A7%8C.jfif?alt=media&token=e085a7a3-2e73-4c26-8e66-c84156d68701', '친화력이 좋지만 겁 많고 독립적이고 규칙적인 멍친구들');
INSERT INTO `species_for_mbti` (`mbti_type`, `species_one`, `species_two`, `species_one_photo`, `species_two_photo`, `mbti_introduction`) VALUES ('entp', 19, 20, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%ED%94%84%EB%A0%8C%EC%B9%98%20%EB%B6%88%EB%8F%85.jpg?alt=media&token=f94b4efa-f209-404a-b400-297b6992706b', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EB%B3%B4%EC%8A%A4%ED%84%B4%20%ED%85%8C%EB%A6%AC%EC%96%B4.jpg?alt=media&token=51229737-c89a-4a2b-85ed-a9609e0648c1', '친화력이 좋지만 겁 많고 독립적이고 자유로운 멍친구들');
INSERT INTO `species_for_mbti` (`mbti_type`, `species_one`, `species_two`, `species_one_photo`, `species_two_photo`, `mbti_introduction`) VALUES ('esfj', 13, 14, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EB%8B%A5%EC%8A%A4%ED%9B%88%ED%8A%B8.png?alt=media&token=c7a45a83-4b9f-42b5-bf08-f080bfdc8b65', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%BD%94%EC%B9%B4%20%EC%8A%A4%ED%8C%A8%EB%8B%88%EC%96%BC.png?alt=media&token=1fc3c013-1f25-4afb-92d4-71e7b08f88ec', '친화력이 좋고 겁 없고 주인 껌딱지에 규칙적인 멍친구들');
INSERT INTO `species_for_mbti` (`mbti_type`, `species_one`, `species_two`, `species_one_photo`, `species_two_photo`, `mbti_introduction`) VALUES ('esfp', 15, 16, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%9B%B0%EC%8B%9C%EC%BD%94%EA%B8%B0.jpg?alt=media&token=6e619b33-7cfd-4218-b4f8-92683a39b791', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%B9%98%EC%99%80%EC%99%80.jpg?alt=media&token=069fa569-92f8-4101-a294-218ede09a215', '친화력이 좋고 겁 없고 주인 껌딱지에 자유로운 멍친구들');
INSERT INTO `species_for_mbti` (`mbti_type`, `species_one`, `species_two`, `species_one_photo`, `species_two_photo`, `mbti_introduction`) VALUES ('estj', 9, 10, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EB%B3%B4%EB%8D%94%EC%BD%9C%EB%A6%AC.jfif?alt=media&token=ca4befda-8340-4018-a2cc-2b02da954721', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%85%B0%ED%8B%80%EB%9E%9C%EB%93%9C%20%EC%89%BD%EB%8F%85.jpg?alt=media&token=cb62b67e-725d-40b7-8be1-af7dfc30a107', '친화력이 좋고 겁 없고 독립적이고 규칙적인 멍친구들');
INSERT INTO `species_for_mbti` (`mbti_type`, `species_one`, `species_two`, `species_one_photo`, `species_two_photo`, `mbti_introduction`) VALUES ('estp', 11, 12, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EB%9E%98%EB%B8%8C%EB%9D%BC%EB%8F%84%20%EB%A6%AC%ED%8A%B8%EB%A6%AC%EB%B2%84.jpg?alt=media&token=d5503d5e-4882-4ec7-8f2e-7a1d5675f669', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EA%B3%A8%EB%93%A0%20%EB%A6%AC%ED%8A%B8%EB%A6%AC%EB%B2%84.jfif?alt=media&token=93b3a95d-d913-49f7-a2a2-683bc3180649', '친화력이 좋고 겁 없고 독립적이고 자유로운 멍친구들');
INSERT INTO `species_for_mbti` (`mbti_type`, `species_one`, `species_two`, `species_one_photo`, `species_two_photo`, `mbti_introduction`) VALUES ('infj', 39, 40, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%A7%84%EB%8F%97%EA%B0%9C.jpg?alt=media&token=55483b48-b6e9-4812-a40b-fdf62bceca8b', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EA%B7%B8%EB%A0%88%EC%9D%B4%20%ED%95%98%EC%9A%B4%EB%93%9C.png?alt=media&token=6843e1be-931d-4530-9aa9-4bee36a14f91', '처음엔 낯을 가리고 겁이 많지만 주인 껌딱지에 규칙적인 멍친구들');
INSERT INTO `species_for_mbti` (`mbti_type`, `species_one`, `species_two`, `species_one_photo`, `species_two_photo`, `mbti_introduction`) VALUES ('infp', 37, 38, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%ED%91%B8%EB%93%A4.jpeg?alt=media&token=53eea887-baa0-4f74-826a-a2d386598a93', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%9A%94%ED%81%AC%EC%85%94%ED%85%8C%EB%A6%AC%EC%96%B4.jfif?alt=media&token=5aaca5b8-0893-405a-a118-dfd7261d1c28', '처음엔 낯을 가리고 겁이 많지만 주인 껌딱지에 자유로운 멍친구들');
INSERT INTO `species_for_mbti` (`mbti_type`, `species_one`, `species_two`, `species_one_photo`, `species_two_photo`, `mbti_introduction`) VALUES ('intj', 33, 34, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%9E%AD%20%EB%9F%AC%EC%85%80%20%ED%85%8C%EB%A6%AC%EC%96%B4.jfif?alt=media&token=8d842ccc-6773-4eec-bdce-55cbb55d2cf6', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EB%A7%90%ED%8B%B0%EC%A6%88.jpg?alt=media&token=3ba7fd1f-0eea-48b1-bec5-0228a4d181fc', '처음엔 낯을 가리고 겁 많고 독립적이고 규칙적인 멍친구들');
INSERT INTO `species_for_mbti` (`mbti_type`, `species_one`, `species_two`, `species_one_photo`, `species_two_photo`, `mbti_introduction`) VALUES ('intp', 35, 36, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EB%B9%84%EA%B8%80.jfif?alt=media&token=3dd48536-47f2-4a60-a0f8-7866616bd8fa', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%ED%92%8D%EC%82%B0%EA%B0%9C.jpg?alt=media&token=94e24d05-c35a-4c27-a8e6-7a2323d64db7', '처음엔 낯을 가리고 겁 많고 독립적이고 자유로운 멍친구들');
INSERT INTO `species_for_mbti` (`mbti_type`, `species_one`, `species_two`, `species_one_photo`, `species_two_photo`, `mbti_introduction`) VALUES ('isfj', 29, 30, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%8A%88%EB%82%98%EC%9A%B0%EC%A0%80.jfif?alt=media&token=1e7bc701-e1c0-4fa4-8843-8e52f01d1ec3', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%ED%8E%98%ED%82%A4%EB%8B%88%EC%A6%88.png?alt=media&token=b97f739e-be19-43aa-8133-f5273bd17ef3', '처음엔 낯을 가리지만 겁 없고 주인 껌딱지에 규칙적인 멍친구들');
INSERT INTO `species_for_mbti` (`mbti_type`, `species_one`, `species_two`, `species_one_photo`, `species_two_photo`, `mbti_introduction`) VALUES ('isfp', 31, 32, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%8B%9C%EB%B0%94%EA%B2%AC.jfif?alt=media&token=97690d83-23c5-43db-a937-15da9c1e61cb', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%8A%A4%ED%94%BC%EC%B8%A0.jfif?alt=media&token=018bb89b-8d88-4df4-adbd-b2250d550e6a', '처음엔 낯을 가리지만 겁 없고 주인 껌딱지에 자유로운 멍친구들');
INSERT INTO `species_for_mbti` (`mbti_type`, `species_one`, `species_two`, `species_one_photo`, `species_two_photo`, `mbti_introduction`) VALUES ('istj', 25, 26, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%8B%9C%EB%B2%A0%EB%A6%AC%EC%95%88%20%ED%97%88%EC%8A%A4%ED%82%A4.jfif?alt=media&token=ba20f26d-20cb-47d8-89bb-f61c652c3eb6', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%95%8C%EB%9E%98%EC%8A%A4%EC%B9%B8%20%EB%A7%90%EB%9D%BC%EB%AE%A4%ED%8A%B8.jfif?alt=media&token=39e47be9-6af4-4b4c-a172-c8d5c073af1e', '처음엔 낯을 가리지만 겁 없고 독립적이고 규칙적인 멍친구들');
INSERT INTO `species_for_mbti` (`mbti_type`, `species_one`, `species_two`, `species_one_photo`, `species_two_photo`, `mbti_introduction`) VALUES ('istp', 27, 28, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EB%B9%84%EC%88%91%20%ED%94%84%EB%A6%AC%EC%A0%9C.jpg?alt=media&token=22d2705d-ea7f-49b7-ae4d-4b590aa184bc', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%ED%8F%AC%EB%A9%94%EB%9D%BC%EB%8B%88%EC%95%88.jpg?alt=media&token=b78d80eb-ec49-44f4-9552-79ae3e18a28d', '처음엔 낯을 가리지만 겁 없고 독립적이고 자유로운 멍친구들');


--유기견 정보
INSERT INTO `abandoned_animal` (`animal_id`, `animal_name`, `species`, `gender`, `age`, `weight`, `personality`, `reason_for_abandonment`, `potty_training`, `abuse`, `disease`, `shyness`, `loneliness`, `introduction`, `location`, `shelter_name`, `increased_friends`, `total_friends`, `upload_status`, `registration_date`, `profile_image`, `diffusion_profile_image`) VALUES ('abc000', '티몽', 2, '수컷', 3, 5.14, '내향적', '주인사망', b'0', b'0', '없음', 5, 10, '겁많고 소심하지만, 사람만큼은 최고로 좋아하는 강아지 티몽.', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2022-12-02', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%8B%B0%EB%AA%BD.JPG?alt=media&token=97095a31-edfb-43f0-87c2-e6fab1e98871', '1');
INSERT INTO `abandoned_animal` (`animal_id`, `animal_name`, `species`, `gender`, `age`, `weight`, `personality`, `reason_for_abandonment`, `potty_training`, `abuse`, `disease`, `shyness`, `loneliness`, `introduction`, `location`, `shelter_name`, `increased_friends`, `total_friends`, `upload_status`, `registration_date`, `profile_image`, `diffusion_profile_image`) VALUES ('abc001', '로렌', 1, '암컷', 4, 3.83, '외향적', '파양', b'0', b'0', '심한 호흡기 감염, 유선종양', 0, 0, '귀여운 외모와 애교 만점의 활발하고 앙증맞은 외모의 로렌은 사람을 좋아하는 말티즈 아이입니다.', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2023-04-03', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%EB%A1%9C%EB%A0%8C.JPG?alt=media&token=1a3123e3-05e4-4187-bf2f-98bad2ce3b3c', NULL);
INSERT INTO `abandoned_animal` (`animal_id`, `animal_name`, `species`, `gender`, `age`, `weight`, `personality`, `reason_for_abandonment`, `potty_training`, `abuse`, `disease`, `shyness`, `loneliness`, `introduction`, `location`, `shelter_name`, `increased_friends`, `total_friends`, `upload_status`, `registration_date`, `profile_image`, `diffusion_profile_image`) VALUES ('abc002', '버터', 1, '암컷', 10, 3.95, '외향적', '파양', b'0', b'0', '귓병, 당뇨병', 10, 10, '분리불안이 있고 하루 한번 인슐린 주사를 맞아야 되기 때문에 집에 항시 사람이 있는\r\n다인 가족이 적합합니다.', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2022-06-10', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%EB%B2%84%ED%84%B0.JPG?alt=media&token=161b827c-83e2-4138-b6f3-3eccc9a50eeb', NULL);
INSERT INTO `abandoned_animal` (`animal_id`, `animal_name`, `species`, `gender`, `age`, `weight`, `personality`, `reason_for_abandonment`, `potty_training`, `abuse`, `disease`, `shyness`, `loneliness`, `introduction`, `location`, `shelter_name`, `increased_friends`, `total_friends`, `upload_status`, `registration_date`, `profile_image`, `diffusion_profile_image`) VALUES ('abc003', '초코쿠키', 3, '암컷', 4, 12, '외향적', '파양', b'0', b'0', '없음', 0, 0, '사람을 너무 좋아하는 애교둥이 귀여운 빵댕이 초코쿠키예요~.', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2021-11-19', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%EC%B4%88%EC%BD%94%EC%BF%A0%ED%82%A4.PNG?alt=media&token=441c431b-4b49-48ef-99e3-82b9da047c1a', NULL);
INSERT INTO `abandoned_animal` (`animal_id`, `animal_name`, `species`, `gender`, `age`, `weight`, `personality`, `reason_for_abandonment`, `potty_training`, `abuse`, `disease`, `shyness`, `loneliness`, `introduction`, `location`, `shelter_name`, `increased_friends`, `total_friends`, `upload_status`, `registration_date`, `profile_image`, `diffusion_profile_image`) VALUES ('abc004', '토니', 1, '수컷', 5, 2.65, '외향적', '파양', b'1', b'0', '슬개골 탈구, 외이염', 10, 10, '너무 깜찍하고 귀여운 외모의 작은 친구, 토니!', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2022-12-29', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%86%A0%EB%8B%88.JPG?alt=media&token=c0ffd6a8-1959-4818-b71e-532c81b16381', NULL);
INSERT INTO `abandoned_animal` (`animal_id`, `animal_name`, `species`, `gender`, `age`, `weight`, `personality`, `reason_for_abandonment`, `potty_training`, `abuse`, `disease`, `shyness`, `loneliness`, `introduction`, `location`, `shelter_name`, `increased_friends`, `total_friends`, `upload_status`, `registration_date`, `profile_image`, `diffusion_profile_image`) VALUES ('abc005', '다기', 5, '수컷', 9, 6, '외향적', '주인사망', b'1', b'0', '없음', 10, 10, '패드배변도 잘하고 장난감도 좋아하는 매력적인 우리 친구 다기!', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2022-02-18', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%EB%8B%A4%EA%B8%B0.jpg?alt=media&token=b5ae48e6-7561-4874-bf29-127dd4894399', NULL);
INSERT INTO `abandoned_animal` (`animal_id`, `animal_name`, `species`, `gender`, `age`, `weight`, `personality`, `reason_for_abandonment`, `potty_training`, `abuse`, `disease`, `shyness`, `loneliness`, `introduction`, `location`, `shelter_name`, `increased_friends`, `total_friends`, `upload_status`, `registration_date`, `profile_image`, `diffusion_profile_image`) VALUES ('abc006', '태리', 1, '수컷', 8, 4.4, '내향적', '파양', b'1', b'1', '없음', 5, 5, '사랑스러운 태리의 마지막 가족이 되어주세요.', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2021-12-02', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%83%9C%EB%A6%AC.JPG?alt=media&token=70ed3f62-e176-4965-bfcb-460c0e328ed1', NULL);
INSERT INTO `abandoned_animal` (`animal_id`, `animal_name`, `species`, `gender`, `age`, `weight`, `personality`, `reason_for_abandonment`, `potty_training`, `abuse`, `disease`, `shyness`, `loneliness`, `introduction`, `location`, `shelter_name`, `increased_friends`, `total_friends`, `upload_status`, `registration_date`, `profile_image`, `diffusion_profile_image`) VALUES ('abc007', '딸기', 6, '수컷', 3, 5.14, '내향적', '주인사망', b'0', b'0', '없음', 5, 10, '겁많고 소심하지만, 사람만큼은 최고로 좋아하는 강아지 딸기.', '서울', '서울동물복지센터 구로', 0, 0, '보호중', '2022-12-22', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%EB%94%B8%EA%B8%B0.jpg?alt=media&token=81c513e6-5773-4364-ba74-28a56d64559b', NULL);
INSERT INTO `abandoned_animal` (`animal_id`, `animal_name`, `species`, `gender`, `age`, `weight`, `personality`, `reason_for_abandonment`, `potty_training`, `abuse`, `disease`, `shyness`, `loneliness`, `introduction`, `location`, `shelter_name`, `increased_friends`, `total_friends`, `upload_status`, `registration_date`, `profile_image`, `diffusion_profile_image`) VALUES ('abc008', '뾰롱이', 7, '수컷', 3, 15, '내향적', '주인사망', b'0', b'0', '없음', 5, 10, '겁많고 소심하지만, 사람만큼은 최고로 좋아하는 강아지 딸기.', '서울', '서울동물복지센터 구로', 0, 0, '보호중', '2022-12-22', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%EB%BE%B0%EB%A1%B1%EC%9D%B4.jpg?alt=media&token=9650ded2-db73-4320-aca2-d653f8f6e6e7', NULL);
INSERT INTO `abandoned_animal` (`animal_id`, `animal_name`, `species`, `gender`, `age`, `weight`, `personality`, `reason_for_abandonment`, `potty_training`, `abuse`, `disease`, `shyness`, `loneliness`, `introduction`, `location`, `shelter_name`, `increased_friends`, `total_friends`, `upload_status`, `registration_date`, `profile_image`, `diffusion_profile_image`) VALUES ('abc009', '뿡뿡이', 8, '수컷', 3, 5.14, '내향적', '주인사망', b'0', b'0', '없음', 5, 10, '겁많고 소심하지만, 사람만큼은 최고로 좋아하는 강아지 딸기.', '서울', '서울동물복지센터 구로', 0, 0, '보호중', '2022-12-22', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%EB%BF%A1%EB%BF%A1%EC%9D%B4.jfif?alt=media&token=fd194666-ec19-46b9-a3e2-082b9c62d97e', NULL);




