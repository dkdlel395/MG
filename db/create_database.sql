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

INSERT INTO `species_information` (`no`, `species_name`) VALUES (1, '말티즈');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (2, '푸들');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (3, '웰시코기');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (4, '골든 리트리버');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (5, '닥스훈트');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (6, '치와와');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (7, '진돗개');
INSERT INTO `species_information` (`no`, `species_name`) VALUES (8, '시츄');

INSERT INTO `abandoned_animal` (`animal_id`, `animal_name`, `species`, `gender`, `age`, `weight`, `personality`, `reason_for_abandonment`, `potty_training`, `abuse`, `disease`, `shyness`, `loneliness`, `introduction`, `location`, `shelter_name`, `increased_friends`, `total_friends`, `upload_status`, `registration_date`, `profile_image`, `diffusion_profile_image`) VALUES ('abc000', '티몽', 2, '수컷', 3, 5.14, '내향적', '주인사망', b'0', b'0', '없음', 5, 10, '겁많고 소심하지만, 사람만큼은 최고로 좋아하는 강아지 티몽.', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2022-12-02', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%8B%B0%EB%AA%BD.JPG?alt=media&token=97095a31-edfb-43f0-87c2-e6fab1e98871', '1');
INSERT INTO `abandoned_animal` (`animal_id`, `animal_name`, `species`, `gender`, `age`, `weight`, `personality`, `reason_for_abandonment`, `potty_training`, `abuse`, `disease`, `shyness`, `loneliness`, `introduction`, `location`, `shelter_name`, `increased_friends`, `total_friends`, `upload_status`, `registration_date`, `profile_image`, `diffusion_profile_image`) VALUES ('abc001', '로렌', 1, '암컷', 4, 3.83, '외향적', '파양', b'0', b'0', '심한 호흡기 감염, 유선종양', 0, 0, '귀여운 외모와 애교 만점의 활발하고 앙증맞은 외모의 로렌은 사람을 좋아하는 말티즈 아이입니다.', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2023-04-03', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%EB%A1%9C%EB%A0%8C.JPG?alt=media&token=1a3123e3-05e4-4187-bf2f-98bad2ce3b3c', NULL);
INSERT INTO `abandoned_animal` (`animal_id`, `animal_name`, `species`, `gender`, `age`, `weight`, `personality`, `reason_for_abandonment`, `potty_training`, `abuse`, `disease`, `shyness`, `loneliness`, `introduction`, `location`, `shelter_name`, `increased_friends`, `total_friends`, `upload_status`, `registration_date`, `profile_image`, `diffusion_profile_image`) VALUES ('abc002', '버터', 1, '암컷', 10, 3.95, '외향적', '파양', b'0', b'0', '귓병, 당뇨병', 10, 10, '분리불안이 있고 하루 한번 인슐린 주사를 맞아야 되기 때문에 집에 항시 사람이 있는\r\n다인 가족이 적합합니다.', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2022-06-10', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%EB%B2%84%ED%84%B0.JPG?alt=media&token=161b827c-83e2-4138-b6f3-3eccc9a50eeb', NULL);
INSERT INTO `abandoned_animal` (`animal_id`, `animal_name`, `species`, `gender`, `age`, `weight`, `personality`, `reason_for_abandonment`, `potty_training`, `abuse`, `disease`, `shyness`, `loneliness`, `introduction`, `location`, `shelter_name`, `increased_friends`, `total_friends`, `upload_status`, `registration_date`, `profile_image`, `diffusion_profile_image`) VALUES ('abc003', '초코쿠키', 3, '암컷', 4, 12, '외향적', '파양', b'0', b'0', '없음', 0, 0, '사람을 너무 좋아하는 애교둥이 귀여운 빵댕이 초코쿠키예요~.', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2021-11-19', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%EC%B4%88%EC%BD%94%EC%BF%A0%ED%82%A4.PNG?alt=media&token=441c431b-4b49-48ef-99e3-82b9da047c1a', NULL);
INSERT INTO `abandoned_animal` (`animal_id`, `animal_name`, `species`, `gender`, `age`, `weight`, `personality`, `reason_for_abandonment`, `potty_training`, `abuse`, `disease`, `shyness`, `loneliness`, `introduction`, `location`, `shelter_name`, `increased_friends`, `total_friends`, `upload_status`, `registration_date`, `profile_image`, `diffusion_profile_image`) VALUES ('abc005', '토니', 1, '수컷', 5, 2.65, '외향적', '파양', b'1', b'0', '슬개골 탈구, 외이염', 10, 10, '너무 깜찍하고 귀여운 외모의 작은 친구, 토니!', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2022-12-29', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%86%A0%EB%8B%88.JPG?alt=media&token=c0ffd6a8-1959-4818-b71e-532c81b16381', NULL);
INSERT INTO `abandoned_animal` (`animal_id`, `animal_name`, `species`, `gender`, `age`, `weight`, `personality`, `reason_for_abandonment`, `potty_training`, `abuse`, `disease`, `shyness`, `loneliness`, `introduction`, `location`, `shelter_name`, `increased_friends`, `total_friends`, `upload_status`, `registration_date`, `profile_image`, `diffusion_profile_image`) VALUES ('abc006', '다기', 5, '수컷', 9, 6, '외향적', '주인사망', b'1', b'0', '없음', 10, 10, '패드배변도 잘하고 장난감도 좋아하는 매력적인 우리 친구 다기!', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2022-02-18', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%EB%8B%A4%EA%B8%B0.jpg?alt=media&token=b5ae48e6-7561-4874-bf29-127dd4894399', NULL);
INSERT INTO `abandoned_animal` (`animal_id`, `animal_name`, `species`, `gender`, `age`, `weight`, `personality`, `reason_for_abandonment`, `potty_training`, `abuse`, `disease`, `shyness`, `loneliness`, `introduction`, `location`, `shelter_name`, `increased_friends`, `total_friends`, `upload_status`, `registration_date`, `profile_image`, `diffusion_profile_image`) VALUES ('abc007', '태리', 1, '수컷', 8, 4.4, '내향적', '파양', b'1', b'1', '없음', 5, 5, '사랑스러운 태리의 마지막 가족이 되어주세요.', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2021-12-02', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%83%9C%EB%A6%AC.JPG?alt=media&token=70ed3f62-e176-4965-bfcb-460c0e328ed1', NULL);
INSERT INTO `abandoned_animal` (`animal_id`, `animal_name`, `species`, `gender`, `age`, `weight`, `personality`, `reason_for_abandonment`, `potty_training`, `abuse`, `disease`, `shyness`, `loneliness`, `introduction`, `location`, `shelter_name`, `increased_friends`, `total_friends`, `upload_status`, `registration_date`, `profile_image`, `diffusion_profile_image`) VALUES ('abc008', '딸기', 6, '수컷', 3, 5.14, '내향적', '주인사망', b'0', b'0', '없음', 5, 10, '겁많고 소심하지만, 사람만큼은 최고로 좋아하는 강아지 딸기.', '서울', '서울동물복지센터 구로', 0, 0, '보호중', '2022-12-22', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%EB%94%B8%EA%B8%B0.jpg?alt=media&token=81c513e6-5773-4364-ba74-28a56d64559b', NULL);
INSERT INTO `abandoned_animal` (`animal_id`, `animal_name`, `species`, `gender`, `age`, `weight`, `personality`, `reason_for_abandonment`, `potty_training`, `abuse`, `disease`, `shyness`, `loneliness`, `introduction`, `location`, `shelter_name`, `increased_friends`, `total_friends`, `upload_status`, `registration_date`, `profile_image`, `diffusion_profile_image`) VALUES ('abc009', '뾰롱이', 7, '수컷', 3, 15, '내향적', '주인사망', b'0', b'0', '없음', 5, 10, '겁많고 소심하지만, 사람만큼은 최고로 좋아하는 강아지 딸기.', '서울', '서울동물복지센터 구로', 0, 0, '보호중', '2022-12-22', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%EB%BE%B0%EB%A1%B1%EC%9D%B4.jpg?alt=media&token=9650ded2-db73-4320-aca2-d653f8f6e6e7', NULL);
INSERT INTO `abandoned_animal` (`animal_id`, `animal_name`, `species`, `gender`, `age`, `weight`, `personality`, `reason_for_abandonment`, `potty_training`, `abuse`, `disease`, `shyness`, `loneliness`, `introduction`, `location`, `shelter_name`, `increased_friends`, `total_friends`, `upload_status`, `registration_date`, `profile_image`, `diffusion_profile_image`) VALUES ('abc010', '뿡뿡이', 8, '수컷', 3, 5.14, '내향적', '주인사망', b'0', b'0', '없음', 5, 10, '겁많고 소심하지만, 사람만큼은 최고로 좋아하는 강아지 딸기.', '서울', '서울동물복지센터 구로', 0, 0, '보호중', '2022-12-22', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%EB%BF%A1%EB%BF%A1%EC%9D%B4.jfif?alt=media&token=fd194666-ec19-46b9-a3e2-082b9c62d97e', NULL);




