-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.10.2-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- dog_db 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `dog_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `dog_db`;

-- 테이블 dog_db.abandoned_animal 구조 내보내기
CREATE TABLE IF NOT EXISTS `abandoned_animal` (
  `animal_id` char(15) NOT NULL COMMENT '유기동물아이디',
  `animal_name` char(10) NOT NULL COMMENT '유기동물이름',
  `species` int(11) NOT NULL COMMENT '유기동물품종번호',
  `gender` char(2) NOT NULL COMMENT '유기동물성별',
  `age` int(11) NOT NULL COMMENT '유기동물나이',
  `weight` float NOT NULL COMMENT '유기동물몸무게',
  `personality` varchar(300) DEFAULT NULL COMMENT '유기동물성격',
  `reason_for_abandonment` varchar(300) DEFAULT NULL COMMENT '유기사유',
  `potty_training` bit(1) DEFAULT NULL COMMENT '배변교육여부',
  `abuse` bit(1) DEFAULT NULL COMMENT '학대여부',
  `disease` varchar(100) DEFAULT NULL COMMENT '질병',
  `shyness` int(11) DEFAULT NULL COMMENT '낯가림',
  `loneliness` int(11) DEFAULT NULL COMMENT '외로움',
  `introduction` varchar(500) DEFAULT NULL COMMENT '소개글',
  `location` char(64) DEFAULT NULL COMMENT '지역',
  `shelter_name` char(20) DEFAULT NULL COMMENT '보호소이름',
  `increased_friends` int(11) DEFAULT NULL COMMENT '증가한친구수',
  `total_friends` int(11) DEFAULT NULL COMMENT '전체친구수',
  `upload_status` char(10) DEFAULT NULL COMMENT '업로드상태',
  `registration_date` date DEFAULT NULL COMMENT '등록날짜',
  `profile_image` varchar(300) DEFAULT NULL COMMENT '원본이미지',
  `diffusion_profile_image` varchar(300) DEFAULT NULL COMMENT '생성이미지',
  PRIMARY KEY (`animal_id`),
  KEY `fk_abandoned_animal_species_information` (`species`),
  CONSTRAINT `fk_abandoned_animal_species_information` FOREIGN KEY (`species`) REFERENCES `species_information` (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 dog_db.abandoned_animal:~10 rows (대략적) 내보내기
/*!40000 ALTER TABLE `abandoned_animal` DISABLE KEYS */;
INSERT INTO `abandoned_animal` (`animal_id`, `animal_name`, `species`, `gender`, `age`, `weight`, `personality`, `reason_for_abandonment`, `potty_training`, `abuse`, `disease`, `shyness`, `loneliness`, `introduction`, `location`, `shelter_name`, `increased_friends`, `total_friends`, `upload_status`, `registration_date`, `profile_image`, `diffusion_profile_image`) VALUES
	('abc000', '티몽', 2, '수컷', 3, 5.14, '내향적', '주인사망', b'0', b'0', '없음', 5, 10, '겁많고 소심하지만, 사람만큼은 최고로 좋아하는 강아지 티몽.', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2022-12-02', 'https://d1jcaoors7xd2v.cloudfront.net/ori_img/1티몽.png', 'https://d1jcaoors7xd2v.cloudfront.net/ori_img/1티몽.png'),
	('abc001', '로렌', 1, '암컷', 4, 3.83, '외향적', '파양', b'0', b'0', '심한 호흡기 감염, 유선종양', 0, 0, '귀여운 외모와 애교 만점의 활발하고 앙증맞은 외모의 로렌은 사람을 좋아하는 말티즈 아이입니다.', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2023-04-03', 'https://d1jcaoors7xd2v.cloudfront.net/ori_img/2로렌.png', 'https://d1jcaoors7xd2v.cloudfront.net/diffusion_img/2로렌.png'),
	('abc002', '버터', 2, '암컷', 10, 3.95, '외향적', '파양', b'0', b'0', '귓병, 당뇨병', 10, 10, '분리불안이 있고 하루 한번 인슐린 주사를 맞아야 되기 때문에 집에 항시 사람이 있는\r\n다인 가족이 적합합니다.', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2022-06-10', 'https://d1jcaoors7xd2v.cloudfront.net/ori_img/3버터.png', 'https://d1jcaoors7xd2v.cloudfront.net/diffusion_img/3버터.png'),
	('abc003', '초코쿠키', 3, '암컷', 4, 12, '외향적', '파양', b'0', b'0', '없음', 0, 0, '사람을 너무 좋아하는 애교둥이 귀여운 빵댕이 초코쿠키예요~.', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2021-11-19', 'https://d1jcaoors7xd2v.cloudfront.net/ori_img/4초코쿠키.png', 'https://d1jcaoors7xd2v.cloudfront.net/diffusion_img/4초코쿠키.png'),
	('abc004', '토니', 1, '수컷', 5, 2.65, '외향적', '파양', b'1', b'0', '슬개골 탈구, 외이염', 10, 10, '너무 깜찍하고 귀여운 외모의 작은 친구, 토니!', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2022-12-29', 'https://d1jcaoors7xd2v.cloudfront.net/ori_img/5토니.png', 'https://d1jcaoors7xd2v.cloudfront.net/diffusion_img/5토니.png'),
	('abc005', '다기', 5, '수컷', 9, 6, '외향적', '주인사망', b'1', b'0', '없음', 10, 10, '패드배변도 잘하고 장난감도 좋아하는 매력적인 우리 친구 다기!', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2022-02-18', 'https://d1jcaoors7xd2v.cloudfront.net/ori_img/6다기.png', 'https://d1jcaoors7xd2v.cloudfront.net/diffusion_img/6다기.png'),
	('abc006', '태리', 1, '수컷', 8, 4.4, '내향적', '파양', b'1', b'1', '없음', 5, 5, '사랑스러운 태리의 마지막 가족이 되어주세요.', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2021-12-02', 'https://d1jcaoors7xd2v.cloudfront.net/ori_img/7태리.png', 'https://d1jcaoors7xd2v.cloudfront.net/diffusion_img/7태리.png'),
	('abc007', '딸기', 6, '수컷', 3, 5.14, '내향적', '주인사망', b'0', b'0', '없음', 5, 10, '겁많고 소심하지만, 사람만큼은 최고로 좋아하는 강아지 딸기.', '서울', '서울동물복지센터 구로', 0, 0, '보호중', '2022-12-22', 'https://d1jcaoors7xd2v.cloudfront.net/ori_img/8딸기.png', 'https://d1jcaoors7xd2v.cloudfront.net/diffusion_img/8딸기.png'),
	('abc008', '뾰롱이', 7, '수컷', 3, 15, '내향적', '주인사망', b'0', b'0', '없음', 5, 10, '겁많고 소심하지만, 사람만큼은 최고로 좋아하는 강아지 딸기.', '서울', '서울동물복지센터 구로', 0, 0, '보호중', '2022-12-22', 'https://d1jcaoors7xd2v.cloudfront.net/ori_img/9뾰롱이.png', 'https://d1jcaoors7xd2v.cloudfront.net/diffusion_img/9뾰롱이.png'),
	('abc009', '뿡뿡이', 8, '수컷', 3, 5.14, '내향적', '주인사망', b'0', b'0', '없음', 5, 10, '겁많고 소심하지만, 사람만큼은 최고로 좋아하는 강아지 딸기.', '서울', '서울동물복지센터 구로', 0, 0, '보호중', '2022-12-22', 'https://d1jcaoors7xd2v.cloudfront.net/ori_img/10뿡뿡이.png', 'https://d1jcaoors7xd2v.cloudfront.net/diffusion_img/10뿡뿡이.png');
/*!40000 ALTER TABLE `abandoned_animal` ENABLE KEYS */;

-- 테이블 dog_db.auth 구조 내보내기
CREATE TABLE IF NOT EXISTS `auth` (
  `no` int(11) NOT NULL COMMENT '유저구분(번호)',
  `auth` char(6) NOT NULL COMMENT '유저구분(텍스트)',
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 dog_db.auth:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `auth` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth` ENABLE KEYS */;

-- 테이블 dog_db.chat 구조 내보내기
CREATE TABLE IF NOT EXISTS `chat` (
  `no` int(11) NOT NULL AUTO_INCREMENT COMMENT 'no',
  `friend_list_no` int(11) DEFAULT NULL COMMENT 'friend_list_no',
  `chat_content` varchar(500) DEFAULT NULL COMMENT '채팅내용',
  `sent_or_received` bit(1) DEFAULT NULL COMMENT '수발신여부',
  `chat_date` timestamp DEFAULT NULL COMMENT '시간',
  `suitability_type` char(10) DEFAULT NULL COMMENT '적합성타입',
  `suitability` bit(1) DEFAULT NULL COMMENT '적합성여부',
  PRIMARY KEY (`no`),
  KEY `fk_chat_friend_list_no` (`friend_list_no`),
  CONSTRAINT `fk_chat_friend_list_no` FOREIGN KEY (`friend_list_no`) REFERENCES `friend_list` (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 dog_db.chat:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `chat` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat` ENABLE KEYS */;

-- 테이블 dog_db.friend_list 구조 내보내기
CREATE TABLE IF NOT EXISTS `friend_list` (
  `no` int(11) NOT NULL AUTO_INCREMENT COMMENT 'no',
  `user_id` char(15) DEFAULT NULL COMMENT '유저아이디',
  `animal_id` char(15) DEFAULT NULL COMMENT '유기동물아이디',
  PRIMARY KEY (`no`),
  KEY `fk_friend_list_animal_id` (`animal_id`),
  KEY `fk_friend_list_user_id` (`user_id`),
  CONSTRAINT `fk_friend_list_animal_id` FOREIGN KEY (`animal_id`) REFERENCES `abandoned_animal` (`animal_id`),
  CONSTRAINT `fk_friend_list_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 dog_db.friend_list:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `friend_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `friend_list` ENABLE KEYS */;

-- 테이블 dog_db.mbti_information 구조 내보내기
CREATE TABLE IF NOT EXISTS `mbti_information` (
  `user_id` char(15) NOT NULL COMMENT '유저아이디',
  `mbti_type` char(4) DEFAULT NULL COMMENT 'mbti_type',
  KEY `fk_mbti_information_user_id` (`user_id`),
  CONSTRAINT `fk_mbti_information_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 dog_db.mbti_information:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `mbti_information` DISABLE KEYS */;
/*!40000 ALTER TABLE `mbti_information` ENABLE KEYS */;

-- 테이블 dog_db.species_for_mbti 구조 내보내기
CREATE TABLE IF NOT EXISTS `species_for_mbti` (
  `mbti_type` char(4) NOT NULL COMMENT 'mbti_type',
  `species_one` int(11) DEFAULT NULL COMMENT '품종추천1',
  `species_two` int(11) DEFAULT NULL COMMENT '품종추천2',
  `species_one_photo` varchar(300) DEFAULT NULL COMMENT '품종사진1',
  `species_two_photo` varchar(300) DEFAULT NULL COMMENT '품종사진2',
  `mbti_introduction` varchar(300) DEFAULT NULL COMMENT 'mbti소개',
  PRIMARY KEY (`mbti_type`),
  KEY `fk_species_for_mbti_species_one` (`species_one`),
  KEY `fk_species_for_mbti_species_two` (`species_two`),
  CONSTRAINT `FK_species_for_mbti_species_one_abandoned_animal_species` FOREIGN KEY (`species_one`) REFERENCES `species_information` (`no`),
  CONSTRAINT `fk_species_for_mbti_species_two` FOREIGN KEY (`species_two`) REFERENCES `species_information` (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 dog_db.species_for_mbti:~16 rows (대략적) 내보내기
/*!40000 ALTER TABLE `species_for_mbti` DISABLE KEYS */;
INSERT INTO `species_for_mbti` (`mbti_type`, `species_one`, `species_two`, `species_one_photo`, `species_two_photo`, `mbti_introduction`) VALUES
	('enfj', 18, 19, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%98%AC%EB%93%9C%20%EC%9E%89%EA%B8%80%EB%A6%AC%EC%89%AC%20%EC%89%BD%EB%8F%85.jpg?alt=media&token=a9e4d211-5c80-4fe5-be2c-fc3753a427ea', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%82%AC%EB%AA%A8%EC%98%88%EB%93%9C.jpg?alt=media&token=325721c3-c7e5-4ca7-942b-8d8ffa548040', '친화력이 좋지만 겁 많고 주인 껌딱지에 규칙적인 멍친구들'),
	('enfp', 17, 8, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%ED%8D%BC%EA%B7%B8.jpg?alt=media&token=862c29b2-207b-4e2c-b652-e4f22e9a0434', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%8B%9C%EC%B8%84.jpg?alt=media&token=e5cc9b25-eed5-4f91-87c0-00d90f88601d', '친화력이 좋지만 겁 많고 주인 껌딱지에 자유로운 멍친구들'),
	('entj', 13, 14, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%85%B0%ED%8D%BC%EB%93%9C.jpg?alt=media&token=c8fada5e-866e-4395-8832-f11c3db96d6e', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EB%8F%84%EB%B2%A0%EB%A5%B4%EB%A7%8C.jfif?alt=media&token=e085a7a3-2e73-4c26-8e66-c84156d68701', '친화력이 좋지만 겁 많고 독립적이고 규칙적인 멍친구들'),
	('entp', 15, 16, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%ED%94%84%EB%A0%8C%EC%B9%98%20%EB%B6%88%EB%8F%85.jpg?alt=media&token=f94b4efa-f209-404a-b400-297b6992706b', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EB%B3%B4%EC%8A%A4%ED%84%B4%20%ED%85%8C%EB%A6%AC%EC%96%B4.jpg?alt=media&token=51229737-c89a-4a2b-85ed-a9609e0648c1', '친화력이 좋지만 겁 많고 독립적이고 자유로운 멍친구들'),
	('esfj', 5, 12, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EB%8B%A5%EC%8A%A4%ED%9B%88%ED%8A%B8.png?alt=media&token=c7a45a83-4b9f-42b5-bf08-f080bfdc8b65', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%BD%94%EC%B9%B4%20%EC%8A%A4%ED%8C%A8%EB%8B%88%EC%96%BC.png?alt=media&token=1fc3c013-1f25-4afb-92d4-71e7b08f88ec', '친화력이 좋고 겁 없고 주인 껌딱지에 규칙적인 멍친구들'),
	('esfp', 3, 6, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%9B%B0%EC%8B%9C%EC%BD%94%EA%B8%B0.jpg?alt=media&token=6e619b33-7cfd-4218-b4f8-92683a39b791', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%B9%98%EC%99%80%EC%99%80.jpg?alt=media&token=069fa569-92f8-4101-a294-218ede09a215', '친화력이 좋고 겁 없고 주인 껌딱지에 자유로운 멍친구들'),
	('estj', 9, 10, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EB%B3%B4%EB%8D%94%EC%BD%9C%EB%A6%AC.jfif?alt=media&token=ca4befda-8340-4018-a2cc-2b02da954721', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%85%B0%ED%8B%80%EB%9E%9C%EB%93%9C%20%EC%89%BD%EB%8F%85.jpg?alt=media&token=cb62b67e-725d-40b7-8be1-af7dfc30a107', '친화력이 좋고 겁 없고 독립적이고 규칙적인 멍친구들'),
	('estp', 11, 4, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EB%9E%98%EB%B8%8C%EB%9D%BC%EB%8F%84%20%EB%A6%AC%ED%8A%B8%EB%A6%AC%EB%B2%84.jpg?alt=media&token=d5503d5e-4882-4ec7-8f2e-7a1d5675f669', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EA%B3%A8%EB%93%A0%20%EB%A6%AC%ED%8A%B8%EB%A6%AC%EB%B2%84.jfif?alt=media&token=93b3a95d-d913-49f7-a2a2-683bc3180649', '친화력이 좋고 겁 없고 독립적이고 자유로운 멍친구들'),
	('infj', 7, 32, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%A7%84%EB%8F%97%EA%B0%9C.jpg?alt=media&token=55483b48-b6e9-4812-a40b-fdf62bceca8b', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EA%B7%B8%EB%A0%88%EC%9D%B4%20%ED%95%98%EC%9A%B4%EB%93%9C.png?alt=media&token=6843e1be-931d-4530-9aa9-4bee36a14f91', '처음엔 낯을 가리고 겁이 많지만 주인 껌딱지에 규칙적인 멍친구들'),
	('infp', 2, 31, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%ED%91%B8%EB%93%A4.jpeg?alt=media&token=53eea887-baa0-4f74-826a-a2d386598a93', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%9A%94%ED%81%AC%EC%85%94%ED%85%8C%EB%A6%AC%EC%96%B4.jfif?alt=media&token=5aaca5b8-0893-405a-a118-dfd7261d1c28', '처음엔 낯을 가리고 겁이 많지만 주인 껌딱지에 자유로운 멍친구들'),
	('intj', 28, 1, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%9E%AD%20%EB%9F%AC%EC%85%80%20%ED%85%8C%EB%A6%AC%EC%96%B4.jfif?alt=media&token=8d842ccc-6773-4eec-bdce-55cbb55d2cf6', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EB%A7%90%ED%8B%B0%EC%A6%88.jpg?alt=media&token=3ba7fd1f-0eea-48b1-bec5-0228a4d181fc', '처음엔 낯을 가리고 겁 많고 독립적이고 규칙적인 멍친구들'),
	('intp', 29, 30, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EB%B9%84%EA%B8%80.jfif?alt=media&token=3dd48536-47f2-4a60-a0f8-7866616bd8fa', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%ED%92%8D%EC%82%B0%EA%B0%9C.jpg?alt=media&token=94e24d05-c35a-4c27-a8e6-7a2323d64db7', '처음엔 낯을 가리고 겁 많고 독립적이고 자유로운 멍친구들'),
	('isfj', 24, 25, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%8A%88%EB%82%98%EC%9A%B0%EC%A0%80.jfif?alt=media&token=1e7bc701-e1c0-4fa4-8843-8e52f01d1ec3', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%ED%8E%98%ED%82%A4%EB%8B%88%EC%A6%88.png?alt=media&token=b97f739e-be19-43aa-8133-f5273bd17ef3', '처음엔 낯을 가리지만 겁 없고 주인 껌딱지에 규칙적인 멍친구들'),
	('isfp', 26, 27, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%8B%9C%EB%B0%94%EA%B2%AC.jfif?alt=media&token=97690d83-23c5-43db-a937-15da9c1e61cb', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%8A%A4%ED%94%BC%EC%B8%A0.jfif?alt=media&token=018bb89b-8d88-4df4-adbd-b2250d550e6a', '처음엔 낯을 가리지만 겁 없고 주인 껌딱지에 자유로운 멍친구들'),
	('istj', 20, 21, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%8B%9C%EB%B2%A0%EB%A6%AC%EC%95%88%20%ED%97%88%EC%8A%A4%ED%82%A4.jfif?alt=media&token=ba20f26d-20cb-47d8-89bb-f61c652c3eb6', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%95%8C%EB%9E%98%EC%8A%A4%EC%B9%B8%20%EB%A7%90%EB%9D%BC%EB%AE%A4%ED%8A%B8.jfif?alt=media&token=39e47be9-6af4-4b4c-a172-c8d5c073af1e', '처음엔 낯을 가리지만 겁 없고 독립적이고 규칙적인 멍친구들'),
	('istp', 22, 23, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EB%B9%84%EC%88%91%20%ED%94%84%EB%A6%AC%EC%A0%9C.jpg?alt=media&token=22d2705d-ea7f-49b7-ae4d-4b590aa184bc', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%ED%8F%AC%EB%A9%94%EB%9D%BC%EB%8B%88%EC%95%88.jpg?alt=media&token=b78d80eb-ec49-44f4-9552-79ae3e18a28d', '처음엔 낯을 가리지만 겁 없고 독립적이고 자유로운 멍친구들');
/*!40000 ALTER TABLE `species_for_mbti` ENABLE KEYS */;

-- 테이블 dog_db.species_information 구조 내보내기
CREATE TABLE IF NOT EXISTS `species_information` (
  `no` int(11) NOT NULL AUTO_INCREMENT COMMENT '유기동물품종(번호)',
  `species_name` char(10) NOT NULL COMMENT '유기동물품종(텍스트)',
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 dog_db.species_information:~41 rows (대략적) 내보내기
/*!40000 ALTER TABLE `species_information` DISABLE KEYS */;
INSERT INTO `species_information` (`no`, `species_name`) VALUES
	(1, '말티즈'),
	(2, '푸들'),
	(3, '웰시코기'),
	(4, '골든 리트리버'),
	(5, '닥스훈트'),
	(6, '치와와'),
	(7, '진돗개'),
	(8, '시츄'),
	(9, '보더콜리'),
	(10, '셰틀랜드 쉽독'),
	(11, '래브라도 리트리버'),
	(12, '코카 스패니얼'),
	(13, '셰퍼드'),
	(14, '도베르만'),
	(15, '프렌치 불독'),
	(16, '보스턴테리어'),
	(17, '퍼그'),
	(18, '올드 잉글리쉬 쉽독'),
	(19, '사모예드'),
	(20, '시베리안 허스키'),
	(21, '알래스칸 말라뮤트'),
	(22, '비숑 프리제'),
	(23, '포메라니안'),
	(24, '슈나우저'),
	(25, '페키니즈'),
	(26, '시바견'),
	(27, '스피츠'),
	(28, '잭 러셀 테리어'),
	(29, '비글'),
	(30, '풍산개'),
	(31, '요크셔테리어'),
	(32, '그레이 하운드');
/*!40000 ALTER TABLE `species_information` ENABLE KEYS */;


-- 테이블 dog_db.user 구조 내보내기
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` char(15) NOT NULL COMMENT '유저아이디',
  `user_pw` char(64) NOT NULL COMMENT '유저비밀번호',
  `user_name` char(6) NOT NULL COMMENT '유저이름',
  `user_nickname` char(15) NOT NULL COMMENT '유저닉네임',
  `identity_number` char(13) NOT NULL COMMENT '유저주민번호',
  `phone` char(11) NOT NULL COMMENT '유저전화번호',
  `address` char(64) NOT NULL COMMENT '유저주소',
  `business_number` char(10) DEFAULT NULL COMMENT '사업자번호',
  `auth` int(11) DEFAULT NULL COMMENT '유저구분(번호)',
  PRIMARY KEY (`user_id`),
  KEY `auth` (`auth`),
  CONSTRAINT `fk_user_auth` FOREIGN KEY (`auth`) REFERENCES `auth` (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 dog_db.user:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
