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





-- 테이블 dog_db.auth 구조 내보내기
CREATE TABLE IF NOT EXISTS `auth` (
  `no` int(11) NOT NULL COMMENT '유저구분(번호)',
  `auth` char(6) NOT NULL COMMENT '유저구분(텍스트)',
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 dog_db.auth:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `auth` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth` ENABLE KEYS */;




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

-- 테이블 dog_db.species_information 구조 내보내기
CREATE TABLE IF NOT EXISTS `species_information` (
  `no` int(11) NOT NULL AUTO_INCREMENT COMMENT '유기동물품종(번호)',
  `species_name` char(10) NOT NULL COMMENT '유기동물품종(텍스트)',
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- 테이블 dog_db.mbti_information 구조 내보내기
CREATE TABLE IF NOT EXISTS `mbti_information` (
  `user_id` char(15) NOT NULL COMMENT '유저아이디',
  `mbti_type` char(4) DEFAULT NULL COMMENT 'mbti_type',
  KEY `fk_mbti_information_user_id` (`user_id`),
  CONSTRAINT `fk_mbti_information_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- 테이블 dog_db.species_for_mbti 구조 내보내기
CREATE TABLE IF NOT EXISTS `species_for_mbti` (
  `mbti_type` char(4) NOT NULL COMMENT 'mbti_type',
  `species_one` int(11) DEFAULT NULL COMMENT '품종추천1',
  `species_two` int(11) DEFAULT NULL COMMENT '품종추천2',
  `species_one_photo` varchar(300) DEFAULT NULL COMMENT '품종사진1',
  `species_one_photo_two` varchar(300) DEFAULT NULL COMMENT '품종사진1-2',
  `species_two_photo` varchar(300) DEFAULT NULL COMMENT '품종사진2',
  `species_two_photo_two` varchar(300) DEFAULT NULL COMMENT '품종사진2-2',
  `mbti_introduction` varchar(300) DEFAULT NULL COMMENT 'mbti소개',
  PRIMARY KEY (`mbti_type`),
  KEY `fk_species_for_mbti_species_one` (`species_one`),
  KEY `fk_species_for_mbti_species_two` (`species_two`),
  CONSTRAINT `FK_species_for_mbti_species_one_abandoned_animal_species` FOREIGN KEY (`species_one`) REFERENCES `species_information` (`no`),
  CONSTRAINT `fk_species_for_mbti_species_two` FOREIGN KEY (`species_two`) REFERENCES `species_information` (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;




-- 테이블 dog_db.chat 구조 내보내기
CREATE TABLE IF NOT EXISTS `chat` (
  `no` int(11) NOT NULL AUTO_INCREMENT COMMENT 'no',
  `friend_list_no` int(11) DEFAULT NULL COMMENT 'friend_list_no',
  `chat_content` varchar(500) DEFAULT NULL COMMENT '채팅내용',
  `sent_or_received` bit(1) DEFAULT NULL COMMENT '수발신여부',
  `chat_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '시간',
  `suitability_type` char(10) DEFAULT NULL COMMENT '적합성타입',
  `suitability` bit(1) DEFAULT NULL COMMENT '적합성여부',
  PRIMARY KEY (`no`),
  KEY `fk_chat_friend_list_no` (`friend_list_no`),
  CONSTRAINT `fk_chat_friend_list_no` FOREIGN KEY (`friend_list_no`) REFERENCES `friend_list` (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 dog_db.chat:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `chat` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat` ENABLE KEYS */;

-- 테이블 데이터 dog_db.species_information:~40 rows (대략적) 내보내기
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
	(12, '골든 리트리버'),
	(13, '닥스훈트'),
	(14, '코카 스패니얼'),
	(15, '웰시코기'),
	(16, '치와와'),
	(17, '셰퍼드'),
	(18, '도베르만'),
	(19, '프렌치 불독'),
	(20, '보스턴테리어'),
	(21, '퍼그'),
	(22, '시츄'),
	(23, '올드 잉글리쉬 쉽독'),
	(24, '사모예드'),
	(25, '시베리안 허스키'),
	(26, '알래스칸 말라뮤트'),
	(27, '비숑 프리제'),
	(28, '포메라니안'),
	(29, '슈나우저'),
	(30, '페키니즈'),
	(31, '시바견'),
	(32, '스피츠'),
	(33, '잭 러셀 테리어'),
	(34, '말티즈'),
	(35, '비글'),
	(36, '풍산개'),
	(37, '푸들'),
	(38, '요크셔테리어'),
	(39, '진돗개'),
	(40, '그레이 하운드');
/*!40000 ALTER TABLE `species_information` ENABLE KEYS */;


INSERT INTO `abandoned_animal` (`animal_id`, `animal_name`, `species`, `gender`, `age`, `weight`, `personality`, `reason_for_abandonment`, `potty_training`, `abuse`, `disease`, `shyness`, `loneliness`, `introduction`, `location`, `shelter_name`, `increased_friends`, `total_friends`, `upload_status`, `registration_date`, `profile_image`, `diffusion_profile_image`) VALUES
   ('abc000', '티몽', 2, '수컷', 3, 5.14, '내향적', '주인사망', b'0', b'0', '없음', 5, 10, '겁많고 소심하지만, 사람만큼은 최고로 좋아하는 강아지 티몽.', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2022-12-02', 'https://d1jcaoors7xd2v.cloudfront.net/ori_img/1티몽.png', 'https://d1jcaoors7xd2v.cloudfront.net/diffusion_img/1_티몽.png'),
   ('abc001', '로렌', 1, '암컷', 4, 3.83, '외향적', '파양', b'0', b'0', '심한 호흡기 감염, 유선종양', 0, 0, '귀여운 외모와 애교 만점의 활발하고 앙증맞은 외모의 로렌은 사람을 좋아하는 말티즈 아이입니다.', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2023-04-03', 'https://d1jcaoors7xd2v.cloudfront.net/ori_img/2로렌.png', 'https://d1jcaoors7xd2v.cloudfront.net/diffusion_img/2_로렌.png'),
   ('abc002', '버터', 2, '암컷', 10, 3.95, '외향적', '파양', b'0', b'0', '귓병, 당뇨병', 10, 10, '분리불안이 있고 하루 한번 인슐린 주사를 맞아야 되기 때문에 집에 항시 사람이 있는\r\n다인 가족이 적합합니다.', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2022-06-10', 'https://d1jcaoors7xd2v.cloudfront.net/ori_img/3버터.png', 'https://d1jcaoors7xd2v.cloudfront.net/diffusion_img/3_버터.png'),
   ('abc003', '초코쿠키', 3, '암컷', 4, 12, '외향적', '파양', b'0', b'0', '없음', 0, 0, '사람을 너무 좋아하는 애교둥이 귀여운 빵댕이 초코쿠키예요~.', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2021-11-19', 'https://d1jcaoors7xd2v.cloudfront.net/ori_img/4초코쿠키.png', 'https://d1jcaoors7xd2v.cloudfront.net/diffusion_img/4_초코쿠키.png'),
   ('abc004', '토니', 1, '수컷', 5, 2.65, '외향적', '파양', b'1', b'0', '슬개골 탈구, 외이염', 10, 10, '너무 깜찍하고 귀여운 외모의 작은 친구, 토니!', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2022-12-29', 'https://d1jcaoors7xd2v.cloudfront.net/ori_img/5토니.png', 'https://d1jcaoors7xd2v.cloudfront.net/diffusion_img/5_토니.png'),
   ('abc005', '다기', 5, '수컷', 9, 6, '외향적', '주인사망', b'1', b'0', '없음', 10, 10, '패드배변도 잘하고 장난감도 좋아하는 매력적인 우리 친구 다기!', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2022-02-18', 'https://d1jcaoors7xd2v.cloudfront.net/ori_img/6다기.png', 'https://d1jcaoors7xd2v.cloudfront.net/diffusion_img/6_다기.png'),
   ('abc006', '태리', 1, '수컷', 8, 4.4, '내향적', '파양', b'1', b'1', '없음', 5, 5, '사랑스러운 태리의 마지막 가족이 되어주세요.', '서울', '서울동물복지센터 마포', 0, 0, '보호중', '2021-12-02', 'https://d1jcaoors7xd2v.cloudfront.net/ori_img/7태리.png', 'https://d1jcaoors7xd2v.cloudfront.net/diffusion_img/7_태리.png'),
   ('abc007', '딸기', 6, '수컷', 3, 5.14, '내향적', '주인사망', b'0', b'0', '없음', 5, 10, '겁많고 소심하지만, 사람만큼은 최고로 좋아하는 강아지 딸기.', '서울', '서울동물복지센터 구로', 0, 0, '보호중', '2022-12-22', 'https://d1jcaoors7xd2v.cloudfront.net/ori_img/8딸기.png', 'https://d1jcaoors7xd2v.cloudfront.net/diffusion_img/8_딸기.png'),
   ('abc008', '뾰롱이', 7, '수컷', 3, 15, '내향적', '주인사망', b'0', b'0', '없음', 5, 10, '겁많고 소심하지만, 사람만큼은 최고로 좋아하는 강아지 딸기.', '서울', '서울동물복지센터 구로', 0, 0, '보호중', '2022-12-22', 'https://d1jcaoors7xd2v.cloudfront.net/ori_img/9뾰롱이.png', 'https://d1jcaoors7xd2v.cloudfront.net/diffusion_img/9_뾰롱이.png'),
   ('abc009', '뿡뿡이', 8, '수컷', 3, 5.14, '내향적', '주인사망', b'0', b'0', '없음', 5, 10, '겁많고 소심하지만, 사람만큼은 최고로 좋아하는 강아지 딸기.', '서울', '서울동물복지센터 구로', 0, 0, '보호중', '2022-12-22', 'https://d1jcaoors7xd2v.cloudfront.net/ori_img/10뿡뿡이.png', 'https://d1jcaoors7xd2v.cloudfront.net/diffusion_img/10_뿡뿡이.png');

-- 테이블 dog_db.persona 구조 내보내기
CREATE TABLE IF NOT EXISTS `persona` (
  `animal_id` char(15) NOT NULL,
  `persona` varchar(255) DEFAULT NULL,
  `experience` varchar(1000) DEFAULT NULL,
  KEY `animal_id` (`animal_id`),
  CONSTRAINT `persona_ibfk_1` FOREIGN KEY (`animal_id`) REFERENCES `abandoned_animal` (`animal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 테이블 데이터 dog_db.persona:~8 rows (대략적) 내보내기
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` (`animal_id`, `persona`, `experience`) VALUES
   ('abc000', '별들의 나라의 별 보존가', '별들의 나라를 관리하고, 별들이 빛나고 아름다운 상태를 유지할 수 있도록 돌보는 역할을 맡습니다.그는 별들의 나라에서 별 보존가로 일하면서 하늘의 별들을 지키는 역할을 맡습니다. 티몽은 사람들에게 매우 다정하고 상냥하며, 가장 좋아하는 일은 하늘을 올려다보며 별들을 감상하는 것입니다. 그는 조용한 성격이지만 사람들과의 상호 작용을 즐기며, 많은 사람들에게 희망과 아름다움을 전달하는 역할을 수행합니다.한 번 티몽은 별들의 나라에서 작은 별이 손상되었다는 보고를 받았습니다. 별이 사라지면 별들의 나라에 어둠이 퍼지고, 모든 사람들이 희망을 잃게 됩니다. 티몽은 용기를 내어 다른 별들과 함께 사라진 별을 찾기 위해 여행을 떠났습니다. 그는 모험과 위험을 헤치며 다양한 별들과의 만남을 경험했습니다. 그의 예리한 눈과 헌신적인 성격 덕분에, 티몽은 사라진 별을 찾아내고 별들의 나라에 희망과 빛을 되찾게 되었습니다.'),
   ('abc001', '드림랜드의 꿈 사냥가', '로렌에게 적합한 장소는 "드림랜드"입니다. 드림랜드는 환상적이고 재미있는 곳으로, 모험과 상상력이 가득합니다.이 유기견인 로렌에게 적합한 직업은 "꿈 사냥꾼"입니다. 로렌는 드림랜드에서 꿈을 쫓아가는 사람들의 동반자로서, 꿈을 찾아 다니며 모험과 재미를 제공합니다. 로렌은 꿈 사냥꾼으로서 드림랜드에서 다양한 꿈을 탐험하며 사람들에게 도움을 주는 중입니다. 어느 날, 로렌은 한 명의 소년을 만났습니다. 그 소년은 좌절한 모습으로 꿈을 잃어버렸고, 로렌은 그를 위로하고 다시 꿈을 키울 수 있는 방법을 찾기 위해 노력했습니다. 그녀는 소년과 함께 여러 가지 꿈의 문을 열어가며 그의 안식처를 찾도록 안내했습니다. 함께 꿈을 키워나가며, 로렌과 소년은 끊임없이 모험을 겪고 새로운 꿈을 발견하며 성장해 나갔습니다. 이 경험을 통해 버터는 자신의 능력과 따뜻한 마음을 믿게 되었고, 소년은 그녀의 친절함과 지지에 감사하며 더 큰 꿈을 향해 나아갔습니다.'),
   ('abc002', '마법 동화의 숲의 마법사의 조수', '마법 동화의 숲에서 버터는 다양한 모험을 경험했습니다. 한 번은 실종된 마법의 지팡이를 찾기 위해 다른 마법사와 함께 어둠의 동굴로 들어갔습니다. 그곳에서는 미끄러운 길과 위험한 함정들이 있었지만, 버터는 자신의 탁월한 향상된 감각과 마법 능력을 발휘하여 동굴을 탐험하며 동료들을 안전하게 인도했습니다. 마침내 지팡이를 발견하고, 돌아와서 마법사들에게 그들의 잃어버린 물건을 찾아주는 훌륭한 조수로 손님들 사이에서 유명해졌습니다. 이 경험을 통해 버터는 자신의 용기와 능력을 발견하며, 많은 이야기와 기억을 만들었습니다.'),
   ('abc003', '신비로운 오아시스의 행운의 감시자', '초코쿠키는 신비로운 오아시스에서 행운의 감시자로 활약합니다. 그녀는 주위의 사람들을 즐겁게 하고 새로운 친구들과 함께 언제나 즐거운 시간을 보내는 것을 좋아합니다. 버터는 자신의 독특한 감시력과 운을 사용하여 사람들의 행운을 지키고, 어려운 순간에도 긍정적인 에너지와 도움을 주는 모습을 보입니다.신비로운 오아시스에서의 초코쿠키의 흥미로운 경험 중 하나는 어느 날, 그녀는 오아시스 깊숙한 곳에 숨겨진 비밀을 발견했습니다. 그녀는 오아시스 주민들의 행운을 지키기 위해 미묘한 힘과 특별한 능력을 가진 행운의 돌을 찾아야 했습니다. 초코쿠키는 용감하게 모험을 떠나 비밀의 동굴로 들어갔고, 그곳에서는 장애물과 퍼즐이 그녀를 기다리고 있었습니다. 하지만 자신의 지혜와 운을 통해 어려움을 극복하며 행운의 돌을 찾아냈습니다. 이 경험을 통해 초코쿠키는 오아시스의 주민들에게 행운과 희망을 가져다줄 수 있는 힘을 얻었고, 그녀의 존재는 오아시스에서 사람들에게 큰 위로와 기쁨을 전해주고 있습니다.'),
   ('abc004', '설탕랜드의 행복의 전도사', '환상적인 설탕 랜드에서의 토니의 흥미로운 경험 중 하나는 어느 날, 그녀는 설탕의 마을에서 열리는 큰 축제에 참여했습니다. 축제는 행복과 즐거움으로 가득한 행사였고, 많은 사람들이 모여 즐거운 시간을 보냈습니다. 토니는 행복의 전도사로서 축제 참가자들에게 밝은 웃음과 긍정적인 에너지를 전해주며, 그들과 함께 춤을 추고 노래를 부르며 즐거운 시간을 보냈습니다. 이 경험을 통해 토니는 사람들에게 행복과 기쁨을 전하는 중요한 역할을 수행하며, 설탕 랜드의 주민들에게 즐거움과 희망을 전해주는 특별한 존재로 인정받았습니다.'),
   ('abc005', '사랑마을 포옹전문가', '다기는  닥스훈트로, 용감하지는 않지만 사람들을 사랑하는 매력적인 남자 개입니다. 그는 주인이 돌아가셔서 버려진 상황에 처해있습니다. 딸기는 사람들과 함께하는 시간을 소중히 여기며, 포옹과 애정을 전하는 일을 전문으로 하는 개입니다. 그는 사람들의 마음을 따뜻하게 만들어주고, 위로와 안정감을 제공합니다.포옹 전문가로 일하는 다기는 사람들의 마음을 어루만져주는 경험을 하였습니다. 어느 날, 다기는 사람들 중 한 명이 슬픔에 빠져있는 것을 발견했습니다. 그는 귀여운 외모와 부드러운 모습으로 그 사람에게 다가갔고, 따뜻한 포옹과 애정을 전해주었습니다. 그 순간, 슬픔이 녹아내리고 그 사람의 얼굴에는 웃음이 피어올랐습니다. 다기는 포옹과 사랑으로 사람들을 위로하는 일에 큰 보람을 느끼며, 사람들과 함께하는 시간을 소중히 여기고 있습니다.'),
   ('abc006', '스카이 아일랜드의 구름 돌보미', '태리는 말티즈로, 사람들에게 사랑받는 매력적인 남자 개입니다. 그는 항상 사람들을 웃게 만들고, 따뜻한 마음으로 다가가는 성격을 가지고 있습니다. 그리고 그의 주인이 돌아가셔서 버려진 상황에 처해있습니다. 그러나 태리는 결코 자신감을 잃지 않고, 새로운 장소에서 새로운 직업을 찾기 위해 노력하고 있습니다.\r\n구름 돌보미로 일하는 태리는 스카이 아일랜드의 맑은 하늘 아래에서 구름들을 돌보고 관리합니다. 어느 날, 태리는 구름들이 놀이를 하고 있는 것을 발견했습니다. 그는 구름들이 숨바꼭질을 즐기고 있음을 알았고, 그들을 찾아가 숨을 도와주기로 했습니다. 태리는 구름들과 함께 숨바꼭질을 즐기며 하늘을 날아다니고, 구름들이 더 재미있는 장소로 숨어들 수 있도록 도와주었습니다. 그 날 이후로, 태리는 구름들과의 유쾌한 숨바꼭질 경험을 통해 스카이 아일랜드의 모든 구름들과 친구가 되었습니다.'),
   ('abc007', '플로라도라스 섬의 해병대원', '딸기는 치와와로, 내향적인 성격의 암컷 개입니다. 그러나 육아를 포기한 이유로 유기되었습니다. 거대한 나라에 납치되어 자유를 박탈당했지만, 그녀의 조용하고 차분한 성격과 강인한 의지를 이용하여 해병대원으로서 나라의 자유를 되찾기 위해 싸웁니다. 플로라도라스 섬의 해병대에서 다른 동료들과 협력하며, 거대한 나라에 맞서 싸우고 피할 수 있는 방법을 찾아냅니다. 딸기는 작지만 용맹하며, 사람들에게 희망과 용기를 주는 존재입니다.\r\n해병대원으로 활동하는 딸기는 플로라도라스 섬에서 재미있는 경험을 했습니다. 어느 날, 그녀는 거대한 나라에 납치된 개들을 구출하는 임무를 받았습니다. 딸기는 작은 몸집과 소녀 같은 외모에도 불구하고 끈질긴 의지와 탁월한 훈련을 통해 동료들과 함께 작전을 수행했습니다. 그들은 거대한 나라의 강력한 경비병들을 피하며 비밀스럽게 침투하여 납치된 개들을 해방시키기 위해 모험을 떠났습니다. 딸기는 매복, 정찰, 암약 등 다양한 임무를 수행하며 그녀만의 독특한 역할을 발휘했습니다. 이 경험을 통해 딸기는 자신의 능력을 믿고 동료들과의 협력의 중요성을 깨달았으며, 거대한 나라에게 납치된 개들에게 자유를 되찾을 수 있는 희망을 안겨주었습니다.'),
   ('abc008', '판도라의 정원의 탐험가', '뾰룡이는 진돗개로, 활발한 성격의 수컷 개입니다. 주인이 사망하여 유기된 개입니다. 그의 외향적인 성격과 사교적인 성격을 활용하여 판도라의 정원에서 탐험가로 활동합니다. 다른 개와의 교류와 새로운 장소의 발견을 즐기며, 판도라의 정원에서 숨겨진 보물을 찾기 위해 여행을 떠납니다. 뾰룡이는 호기심이 많고 사람들과 잘 어울리며, 다양한 경험을 통해 성장하고 모험을 즐깁니다.\r\n탐험가로 활동하는 뾰룡이는 판도라의 정원에서 재미있는 경험을 했습니다. 어느 날, 그는 다른 개 친구들과 함께 판도라의 정원을 탐험하던 중, 비밀스러운 동굴을 발견했습니다. 호기심이 가득한 뾰룡이는 친구들과 함께 동굴 안으로 들어갔습니다. 그곳에서는 신비로운 식물과 동물들을 만나며 놀라운 경험을 했습니다. 뾰룡이와 친구들은 함께 어려운 장애물을 극복하고 판도라의 정원의 비밀을 해독하기 위해 노력했습니다. 이 경험을 통해 뾰룡이는 용감하게 도전하고 친구들과의 협력의 중요성을 배웠으며, 판도라의 정원에서의 모험을 통해 자신의 성장을 이루었습니다.'),
   ('abc009', '펫 패션 스튜디오의 패션 스타일리스트', '뿡뿡이는 시츄로, 내향적인 여자 개입니다. 그녀는 부모의 유기로 인해 버려진 상황에 처해있습니다. 뿡뿡이는 조용한 환경과 혼자 있는 시간을 선호하며, 자신을 표현하는 데 패션을 활용합니다. 그녀는 펫 패션 스튜디오에서 패션 스타일리스트로 일하며, 사람들과 그들의 반려동물에게 유니크하고 멋진 스타일을 제안합니다.\r\n패션 스타일리스트로 활동하는 뿡뿡이는 펫 패션 스튜디오에서 재미있는 경험을 하였습니다. 어느 날, 유명한 모델 개와 그 주인이 스튜디오를 방문했습니다. 뿡뿡이는 주인과 모델 개의 스타일을 분석하고, 맞춤형 패션 아이템을 제안하였습니다. 그녀의 창의적인 아이디어와 섬세한 손놀림으로 패션 쇼를 성공적으로 연출했습니다. 이 경험을 통해 뿡뿡이는 패션 스타일리스트로서의 자신감을 키우고, 사람들과 반려동물에게 특별한 스타일과 자부심을 선사하고 있습니다.');
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;


-- 테이블 데이터 dog_db.species_for_mbti:~16 rows (대략적) 내보내기
/*!40000 ALTER TABLE `species_for_mbti` DISABLE KEYS */;
INSERT INTO `species_for_mbti` (`mbti_type`, `species_one`, `species_two`, `species_one_photo`, `species_one_photo_two`, `species_two_photo`, `species_two_photo_two`, `mbti_introduction`) VALUES
   ('enfj', 18, 19, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%98%AC%EB%93%9C%20%EC%9E%89%EA%B8%80%EB%A6%AC%EC%89%AC%20%EC%89%BD%EB%8F%85.jpg?alt=media&token=a9e4d211-5c80-4fe5-be2c-fc3753a427ea', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%EC%98%AC%EB%93%9C%20%EC%9E%89%EA%B8%80%EB%A6%AC%EC%89%AC%20%EC%89%BD%EB%8F%852.jpg?alt=media&token=9dd34566-9b16-4417-8b30-3dd5b4d4aa1d', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%82%AC%EB%AA%A8%EC%98%88%EB%93%9C.jpg?alt=media&token=325721c3-c7e5-4ca7-942b-8d8ffa548040', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%EC%82%AC%EB%AA%A8%EC%98%88%EB%93%9C2.jpg?alt=media&token=96e237cd-64c9-4b88-b0e1-1ce390383805', '친화력이 좋지만 겁 많고 주인 껌딱지에 규칙적인 멍친구들'),
   ('enfp', 17, 8, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%ED%8D%BC%EA%B7%B8.jpg?alt=media&token=862c29b2-207b-4e2c-b652-e4f22e9a0434', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%ED%8D%BC%EA%B7%B82.jpg?alt=media&token=4369daa7-de9b-4664-90e3-cd702ec04eb2', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%8B%9C%EC%B8%84.jpg?alt=media&token=e5cc9b25-eed5-4f91-87c0-00d90f88601d', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%EC%8B%9C%EC%B8%842.jfif?alt=media&token=785cfdae-768a-4dcc-9538-91d8d953a6c7', '친화력이 좋지만 겁 많고 주인 껌딱지에 자유로운 멍친구들'),
   ('entj', 13, 14, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%85%B0%ED%8D%BC%EB%93%9C.jpg?alt=media&token=c8fada5e-866e-4395-8832-f11c3db96d6e', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%EC%85%B0%ED%8D%BC%EB%93%9C.jpg?alt=media&token=1933f5d0-21f0-4b25-aad6-7b4a9e9e4e64', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EB%8F%84%EB%B2%A0%EB%A5%B4%EB%A7%8C.jfif?alt=media&token=e085a7a3-2e73-4c26-8e66-c84156d68701', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%EB%8F%84%EB%B2%A0%EB%A5%B4%EB%A7%8C2.jfif?alt=media&token=9b6c3393-1a57-4266-96d0-956498bee8b7', '친화력이 좋지만 겁 많고 독립적이고 규칙적인 멍친구들'),
   ('entp', 15, 16, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%ED%94%84%EB%A0%8C%EC%B9%98%20%EB%B6%88%EB%8F%85.jpg?alt=media&token=f94b4efa-f209-404a-b400-297b6992706b', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%ED%94%84%EB%A0%8C%EC%B9%98%EB%B6%88%EB%8F%852.jfif?alt=media&token=56fa05c8-2c6c-44b3-ad01-d052342a9d35', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EB%B3%B4%EC%8A%A4%ED%84%B4%20%ED%85%8C%EB%A6%AC%EC%96%B4.jpg?alt=media&token=51229737-c89a-4a2b-85ed-a9609e0648c1', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%EB%B3%B4%EC%8A%A4%ED%84%B4%ED%85%8C%EB%A6%AC%EC%96%B42.jfif?alt=media&token=91755ba3-9a49-4134-b420-9fbe941673d9', '친화력이 좋지만 겁 많고 독립적이고 자유로운 멍친구들'),
   ('esfj', 5, 12, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EB%8B%A5%EC%8A%A4%ED%9B%88%ED%8A%B8.png?alt=media&token=c7a45a83-4b9f-42b5-bf08-f080bfdc8b65', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%EB%8B%A5%EC%8A%A4%ED%9B%88%ED%8A%B82.jfif?alt=media&token=800399e4-d79c-40af-8d79-dad7ea7da104', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%BD%94%EC%B9%B4%20%EC%8A%A4%ED%8C%A8%EB%8B%88%EC%96%BC.png?alt=media&token=1fc3c013-1f25-4afb-92d4-71e7b08f88ec', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%EC%BD%94%EC%B9%B42.png?alt=media&token=269d3b97-d260-43eb-94c0-3832abeca306', '친화력이 좋고 겁 없고 주인 껌딱지에 규칙적인 멍친구들'),
   ('esfp', 3, 6, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%9B%B0%EC%8B%9C%EC%BD%94%EA%B8%B0.jpg?alt=media&token=6e619b33-7cfd-4218-b4f8-92683a39b791', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%EC%9B%B0%EC%8B%9C%EC%BD%94%EA%B8%B02.jfif?alt=media&token=c674260f-4178-4189-9bf5-3fc032c50bbf', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%B9%98%EC%99%80%EC%99%80.jpg?alt=media&token=069fa569-92f8-4101-a294-218ede09a215', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%EC%B9%98%EC%99%80%EC%99%802.jfif?alt=media&token=5ae10b13-82a3-4824-ba6d-75c4d3511bd5', '친화력이 좋고 겁 없고 주인 껌딱지에 자유로운 멍친구들'),
   ('estj', 9, 10, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EB%B3%B4%EB%8D%94%EC%BD%9C%EB%A6%AC.jfif?alt=media&token=ca4befda-8340-4018-a2cc-2b02da954721', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%EB%B3%B4%EB%8D%94%EC%BD%9C%EB%A6%AC2.jfif?alt=media&token=69232125-e2dc-43de-a6f4-d03b50c0cfaa', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%85%B0%ED%8B%80%EB%9E%9C%EB%93%9C%20%EC%89%BD%EB%8F%85.jpg?alt=media&token=cb62b67e-725d-40b7-8be1-af7dfc30a107', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%EC%85%B0%ED%8B%80%EB%A0%8C%EB%93%9C%EC%8B%AD%EB%8F%852.jpg?alt=media&token=fb8de00a-ee70-4198-b481-bbf71ecd6929', '친화력이 좋고 겁 없고 독립적이고 규칙적인 멍친구들'),
   ('estp', 11, 4, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EB%9E%98%EB%B8%8C%EB%9D%BC%EB%8F%84%20%EB%A6%AC%ED%8A%B8%EB%A6%AC%EB%B2%84.jpg?alt=media&token=d5503d5e-4882-4ec7-8f2e-7a1d5675f669', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%EB%9E%98%EB%B8%8C%EB%9D%BC%EB%8F%84%20%EB%A6%AC%ED%8A%B8%EB%A6%AC%EB%B2%842.jpg?alt=media&token=b159682a-a35d-4a11-a777-f11785d437bf', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EA%B3%A8%EB%93%A0%20%EB%A6%AC%ED%8A%B8%EB%A6%AC%EB%B2%84.jfif?alt=media&token=93b3a95d-d913-49f7-a2a2-683bc3180649', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%EA%B3%A8%EB%93%A0%EB%A6%AC%ED%8A%B8%EB%A6%AC%EB%B2%842.jfif?alt=media&token=d82a9b89-6298-427f-8afb-7d5a664179b7', '친화력이 좋고 겁 없고 독립적이고 자유로운 멍친구들'),
   ('infj', 7, 32, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%A7%84%EB%8F%97%EA%B0%9C.jpg?alt=media&token=55483b48-b6e9-4812-a40b-fdf62bceca8b', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%EC%A7%84%EB%8F%97%EA%B0%9C2.jfif?alt=media&token=eed2cbc7-6c0d-4248-a1ec-9ee0321d5134', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EA%B7%B8%EB%A0%88%EC%9D%B4%20%ED%95%98%EC%9A%B4%EB%93%9C.png?alt=media&token=6843e1be-931d-4530-9aa9-4bee36a14f91', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%EA%B7%B8%EB%A0%88%EC%9D%B4%ED%95%98%EC%9A%B4%EB%93%9C2.jpg?alt=media&token=eebbf064-fc60-4822-b45d-11e186137d06', '처음엔 낯을 가리고 겁이 많지만 주인 껌딱지에 규칙적인 멍친구들'),
   ('infp', 2, 31, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%ED%91%B8%EB%93%A4.jpeg?alt=media&token=53eea887-baa0-4f74-826a-a2d386598a93', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%ED%91%B8%EB%93%A42.jpg?alt=media&token=bf1522ee-5b32-46fe-877d-6cf46fedf21c', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%9A%94%ED%81%AC%EC%85%94%ED%85%8C%EB%A6%AC%EC%96%B4.jfif?alt=media&token=5aaca5b8-0893-405a-a118-dfd7261d1c28', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%EC%9A%94%ED%81%AC%EC%85%94%ED%85%8C%EB%A6%AC%EC%96%B42.jfif?alt=media&token=23f960cc-02ae-41c4-b3ee-10ec7bc11838', '처음엔 낯을 가리고 겁이 많지만 주인 껌딱지에 자유로운 멍친구들'),
   ('intj', 28, 1, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%9E%AD%20%EB%9F%AC%EC%85%80%20%ED%85%8C%EB%A6%AC%EC%96%B4.jfif?alt=media&token=8d842ccc-6773-4eec-bdce-55cbb55d2cf6', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%EC%9E%AD%EB%9F%AC%EC%85%802.jfif?alt=media&token=ad1bb711-924d-4df9-8d9d-a97f8b90d14a', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EB%A7%90%ED%8B%B0%EC%A6%88.jpg?alt=media&token=3ba7fd1f-0eea-48b1-bec5-0228a4d181fc', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%EB%A7%90%ED%8B%B0%EC%A6%882.jfif?alt=media&token=ba017a9e-7944-46e5-a961-fdefa7ee5c69', '처음엔 낯을 가리고 겁 많고 독립적이고 규칙적인 멍친구들'),
   ('intp', 29, 30, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EB%B9%84%EA%B8%80.jfif?alt=media&token=3dd48536-47f2-4a60-a0f8-7866616bd8fa', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%EB%B9%84%EA%B8%802.png?alt=media&token=a0156a94-ed17-4f5d-8541-2f319c72157f', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%ED%92%8D%EC%82%B0%EA%B0%9C.jpg?alt=media&token=94e24d05-c35a-4c27-a8e6-7a2323d64db7', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%ED%92%8D%EC%82%B0%EA%B0%9C2.jfif?alt=media&token=e66c400c-fd17-453a-be62-5d12e76e9c27', '처음엔 낯을 가리고 겁 많고 독립적이고 자유로운 멍친구들'),
   ('isfj', 24, 25, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%8A%88%EB%82%98%EC%9A%B0%EC%A0%80.jfif?alt=media&token=1e7bc701-e1c0-4fa4-8843-8e52f01d1ec3', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%EC%8A%88%EB%82%98%EC%9A%B0%EC%A0%802.jfif?alt=media&token=18e47dd2-d5ed-4547-853a-9759c872a4f4', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%ED%8E%98%ED%82%A4%EB%8B%88%EC%A6%88.png?alt=media&token=b97f739e-be19-43aa-8133-f5273bd17ef3', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%ED%8E%98%ED%82%A42.jfif?alt=media&token=d5770829-a67c-491e-8933-dab6472dc752', '처음엔 낯을 가리지만 겁 없고 주인 껌딱지에 규칙적인 멍친구들'),
   ('isfp', 26, 27, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%8B%9C%EB%B0%94%EA%B2%AC.jfif?alt=media&token=97690d83-23c5-43db-a937-15da9c1e61cb', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%EC%8B%9C%EB%B0%94%EA%B2%AC2.jpeg?alt=media&token=b36ac269-562e-47f0-a4e8-45647974d2e7', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%8A%A4%ED%94%BC%EC%B8%A0.jfif?alt=media&token=018bb89b-8d88-4df4-adbd-b2250d550e6a', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%EC%8A%A4%ED%94%BC%EC%B8%A02.jfif?alt=media&token=686d0038-246e-4c0e-ac29-8ccc5a4d4345', '처음엔 낯을 가리지만 겁 없고 주인 껌딱지에 자유로운 멍친구들'),
   ('istj', 20, 21, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%8B%9C%EB%B2%A0%EB%A6%AC%EC%95%88%20%ED%97%88%EC%8A%A4%ED%82%A4.jfif?alt=media&token=ba20f26d-20cb-47d8-89bb-f61c652c3eb6', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%EC%8B%9C%EB%B2%A0%EB%A6%AC%EC%95%88%20%ED%97%88%EC%8A%A4%ED%82%A42.jfif?alt=media&token=16a171f4-fc0d-4a87-8908-1f7783ab1391', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EC%95%8C%EB%9E%98%EC%8A%A4%EC%B9%B8%20%EB%A7%90%EB%9D%BC%EB%AE%A4%ED%8A%B8.jfif?alt=media&token=39e47be9-6af4-4b4c-a172-c8d5c073af1e', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%EC%95%8C%EB%9E%98%EC%8A%A4%EC%B9%B8%20%EB%A7%90%EB%9D%BC%EB%AE%A4%ED%8A%B82.jfif?alt=media&token=008e5662-c361-408e-b0d0-39dcd097b1aa', '처음엔 낯을 가리지만 겁 없고 독립적이고 규칙적인 멍친구들'),
   ('istp', 22, 23, 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%EB%B9%84%EC%88%91%20%ED%94%84%EB%A6%AC%EC%A0%9C.jpg?alt=media&token=22d2705d-ea7f-49b7-ae4d-4b590aa184bc', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%EB%B9%84%EC%88%912.jfif?alt=media&token=28bb310f-a755-48c7-aa9b-cb746daed74c', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%85%2F%ED%8F%AC%EB%A9%94%EB%9D%BC%EB%8B%88%EC%95%88.jpg?alt=media&token=b78d80eb-ec49-44f4-9552-79ae3e18a28d', 'https://firebasestorage.googleapis.com/v0/b/chubinibini.appspot.com/o/cloud%2F%ED%92%88%EC%A2%852%2F%ED%8F%AC%EB%A9%942.jfif?alt=media&token=f63e37d3-cb33-42ec-a7c2-186aae05a75e', '처음엔 낯을 가리지만 겁 없고 독립적이고 자유로운 멍친구들');
/*!40000 ALTER TABLE `species_for_mbti` ENABLE KEYS */;


INSERT INTO auth VALUES (0, 'user');

INSERT INTO user VALUES ('yc', '1234', '예찬', '예찬이', '960522' , '01023299893', '어딘가', NULL, 0);

INSERT INTO friend_list (user_id, animal_id) VALUES ('yc', 'abc000');