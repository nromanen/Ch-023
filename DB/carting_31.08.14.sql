-- --------------------------------------------------------
-- Host:                         localhost
-- Server version:               5.5.5-10.0.13-MariaDB-log - MariaDB Server
-- Server OS:                    Linux
-- HeidiSQL Version:             8.3.0.4694
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping database structure for carting
DROP DATABASE IF EXISTS `carting`;
CREATE DATABASE IF NOT EXISTS `carting` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `carting`;


-- Dumping structure for table carting.admin_settings
DROP TABLE IF EXISTS `admin_settings`;
CREATE TABLE IF NOT EXISTS `admin_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `feedback_email` varchar(255) NOT NULL,
  `parental_permission_years` int(11) NOT NULL,
  `points_by_places` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Dumping data for table carting.admin_settings: ~0 rows (approximately)
DELETE FROM `admin_settings`;
/*!40000 ALTER TABLE `admin_settings` DISABLE KEYS */;
INSERT INTO `admin_settings` (`id`, `feedback_email`, `parental_permission_years`, `points_by_places`) VALUES
	(1, 'softserve.karting@gmail.com', 18, '20,15,12,10,8,6,3,3,1');
/*!40000 ALTER TABLE `admin_settings` ENABLE KEYS */;


-- Dumping structure for table carting.car_classes
DROP TABLE IF EXISTS `car_classes`;
CREATE TABLE IF NOT EXISTS `car_classes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lower_years_limit` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `upper_years_limit` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_2` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- Dumping data for table carting.car_classes: ~8 rows (approximately)
DELETE FROM `car_classes`;
/*!40000 ALTER TABLE `car_classes` DISABLE KEYS */;
INSERT INTO `car_classes` (`id`, `lower_years_limit`, `name`, `upper_years_limit`) VALUES
	(1, 12, 'Популярний-Юнаки', 17),
	(2, 15, 'Кадет', 99),
	(3, 15, 'Популярний', 99),
	(4, 6, 'Піонер Н-міні', 9),
	(6, 6, 'Піонер Б', 13),
	(7, 9, 'Піонер Н', 13),
	(8, 5, 'dgfhdsgh', 8),
	(9, 16, 'ICA', 98);
/*!40000 ALTER TABLE `car_classes` ENABLE KEYS */;


-- Dumping structure for table carting.car_class_competition
DROP TABLE IF EXISTS `car_class_competition`;
CREATE TABLE IF NOT EXISTS `car_class_competition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `circle_count` int(11) NOT NULL,
  `first_race_time` time NOT NULL,
  `percentage_offset` int(11) NOT NULL,
  `second_race_time` time NOT NULL,
  `car_class_id` int(11) NOT NULL,
  `competition_id` int(11) NOT NULL,
  `firstStartStatement_id` int(11) DEFAULT NULL,
  `secondStartStatement_id` int(11) DEFAULT NULL,
  `maneuverStatement_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKC7F8C1CDED6F4EAD` (`competition_id`),
  KEY `FKC7F8C1CD1F1B02DE` (`car_class_id`),
  KEY `first_race_start` (`firstStartStatement_id`),
  KEY `second_race_start` (`secondStartStatement_id`),
  KEY `maneuver_statement` (`maneuverStatement_id`),
  CONSTRAINT `FKC7F8C1CD1F1B02DE` FOREIGN KEY (`car_class_id`) REFERENCES `car_classes` (`id`),
  CONSTRAINT `FKC7F8C1CDED6F4EAD` FOREIGN KEY (`competition_id`) REFERENCES `competitions` (`id`),
  CONSTRAINT `FK_car_class_competition_files` FOREIGN KEY (`firstStartStatement_id`) REFERENCES `files` (`id`),
  CONSTRAINT `FK_car_class_competition_files_2` FOREIGN KEY (`secondStartStatement_id`) REFERENCES `files` (`id`),
  CONSTRAINT `FK_car_class_competition_files_3` FOREIGN KEY (`maneuverStatement_id`) REFERENCES `files` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- Dumping data for table carting.car_class_competition: ~8 rows (approximately)
DELETE FROM `car_class_competition`;
/*!40000 ALTER TABLE `car_class_competition` DISABLE KEYS */;
INSERT INTO `car_class_competition` (`id`, `circle_count`, `first_race_time`, `percentage_offset`, `second_race_time`, `car_class_id`, `competition_id`, `firstStartStatement_id`, `secondStartStatement_id`, `maneuverStatement_id`) VALUES
	(1, 6, '16:05:00', 75, '12:40:00', 7, 1, NULL, NULL, NULL),
	(2, 6, '15:20:00', 75, '12:00:00', 6, 1, NULL, NULL, NULL),
	(3, 10, '15:00:00', 75, '11:40:00', 3, 1, NULL, NULL, NULL),
	(5, 7, '11:30:00', 75, '14:00:00', 3, 2, NULL, NULL, NULL),
	(6, 7, '12:30:00', 75, '15:30:00', 7, 2, NULL, NULL, NULL),
	(8, 4, '15:30:00', 75, '16:20:00', 1, 2, NULL, NULL, NULL),
	(9, 5, '11:00:00', 80, '12:00:00', 1, 1, NULL, NULL, NULL),
	(10, 5, '11:00:00', 80, '12:00:00', 2, 1, NULL, NULL, NULL);
/*!40000 ALTER TABLE `car_class_competition` ENABLE KEYS */;


-- Dumping structure for table carting.car_class_competition_results
DROP TABLE IF EXISTS `car_class_competition_results`;
CREATE TABLE IF NOT EXISTS `car_class_competition_results` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `absolute_place` int(11) DEFAULT NULL,
  `absolute_points` int(11) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `race2_points` int(11) DEFAULT NULL,
  `racer_competition_carclass_number_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK706F8784CA0A6B84` (`racer_competition_carclass_number_id`),
  CONSTRAINT `FK706F8784CA0A6B84` FOREIGN KEY (`racer_competition_carclass_number_id`) REFERENCES `racer_competition_car_class_numbers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- Dumping data for table carting.car_class_competition_results: ~9 rows (approximately)
DELETE FROM `car_class_competition_results`;
/*!40000 ALTER TABLE `car_class_competition_results` DISABLE KEYS */;
INSERT INTO `car_class_competition_results` (`id`, `absolute_place`, `absolute_points`, `comment`, `race2_points`, `racer_competition_carclass_number_id`) VALUES
	(7, 2, 40, 'без штрафу', 40, 13),
	(8, 4, 0, '2 за маневрування', 0, 15),
	(9, 1, 40, 'без штрафу', 0, 11),
	(10, 3, 24, 'без штрафу', 24, 10),
	(11, 3, 35, 'без штрафу', 11, 12),
	(12, 4, 0, '10 за красивые глаза', 0, 17),
	(13, 1, 64, '-5 за таран карту №1', 24, 14),
	(14, 2, 40, 'без штрафу', 40, 19),
	(15, 1, 0, 'без штрафу', 0, 4);
/*!40000 ALTER TABLE `car_class_competition_results` ENABLE KEYS */;


-- Dumping structure for table carting.competitions
DROP TABLE IF EXISTS `competitions`;
CREATE TABLE IF NOT EXISTS `competitions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_end` date NOT NULL,
  `date_start` date NOT NULL,
  `director_category_judicial_license` varchar(255) NOT NULL,
  `director_name` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `first_race_date` date NOT NULL,
  `name` varchar(255) NOT NULL,
  `place` varchar(255) NOT NULL,
  `second_race_date` date NOT NULL,
  `secretary_category_judicial_license` varchar(255) NOT NULL,
  `secretary_name` varchar(255) NOT NULL,
  `calculate_by_table_b` tinyint(1) NOT NULL,
  `points_by_places` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Dumping data for table carting.competitions: ~3 rows (approximately)
DELETE FROM `competitions`;
/*!40000 ALTER TABLE `competitions` DISABLE KEYS */;
INSERT INTO `competitions` (`id`, `date_end`, `date_start`, `director_category_judicial_license`, `director_name`, `enabled`, `first_race_date`, `name`, `place`, `second_race_date`, `secretary_category_judicial_license`, `secretary_name`, `calculate_by_table_b`, `points_by_places`) VALUES
	(1, '2014-06-30', '2014-06-28', 'НК', 'МИРОНОВ В.І.', 1, '2014-06-28', 'ВСЕУКРАЇНСЬКІ ЗМАГАННЯ З КАРТИНГУ СЕРЕД УЧНІВСЬКОЇ МОЛОДІ 2014 року (фінальний етап)', 'м.Кам\'янець-Подільський', '2014-06-30', 'НК', 'РИБАЛКА Л.А.', 0, '20,15,12,10,8,6,3,3,1'),
	(2, '2014-05-29', '2014-05-28', 'НК', 'МИРОНОВ В.І.', 1, '2014-05-28', 'Чемпіонат Чернівецької області (весна 2014 року)', 'м. Чернівці', '2014-05-28', 'НК', 'РИБАЛКА Л.А.', 1, '28,15,12,10,9,8,5,4,1'),
	(3, '2015-07-17', '2015-07-16', 'dsgfsd', 'Gdsfgdf', 0, '2014-06-06', 'Test', 'Test', '2014-06-07', 'dfgdsf', 'Gdgdf', 0, '20,15,12,10,8,6,3,3,1');
/*!40000 ALTER TABLE `competitions` ENABLE KEYS */;


-- Dumping structure for table carting.documents
DROP TABLE IF EXISTS `documents`;
CREATE TABLE IF NOT EXISTS `documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `approved` tinyint(1) NOT NULL,
  `checked` tinyint(1) NOT NULL,
  `finish_date` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `type` tinyint(1) NOT NULL,
  `team_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `team_id` (`team_id`),
  CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- Dumping data for table carting.documents: ~0 rows (approximately)
DELETE FROM `documents`;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;


-- Dumping structure for table carting.files
DROP TABLE IF EXISTS `files`;
CREATE TABLE IF NOT EXISTS `files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `document_id` int(11) DEFAULT NULL,
  `file` longblob,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK5CEBA7717352767` (`document_id`),
  CONSTRAINT `FK5CEBA7717352767` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- Dumping data for table carting.files: ~0 rows (approximately)
DELETE FROM `files`;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
/*!40000 ALTER TABLE `files` ENABLE KEYS */;


-- Dumping structure for table carting.leaders
DROP TABLE IF EXISTS `leaders`;
CREATE TABLE IF NOT EXISTS `leaders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `address` varchar(255) NOT NULL,
  `birthday` datetime NOT NULL,
  `document` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `license` varchar(255) DEFAULT NULL,
  `registration_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `leaders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- Dumping data for table carting.leaders: ~11 rows (approximately)
DELETE FROM `leaders`;
/*!40000 ALTER TABLE `leaders` DISABLE KEYS */;
INSERT INTO `leaders` (`id`, `user_id`, `address`, `birthday`, `document`, `first_name`, `last_name`, `license`, `registration_date`) VALUES
	(1, 6, 'м.Чернівці, вул.Мамаївська.6', '1980-06-23 00:00:00', 'СЕ123345', 'Сергий', 'Пономар', NULL, '2014-06-02 13:30:00'),
	(2, 7, 'м. Кам\'янець-Подільський, вул. Грушевського 74/524', '1974-06-27 00:00:00', 'НВ', 'Руслан', 'Кагітін', NULL, '2014-06-02 13:30:00'),
	(3, 8, 'м. Чернівці, вул. Каспрука 13/9', '1980-07-09 00:00:00', 'кр122312', 'Петров', 'Розуменко', NULL, '2014-06-02 13:30:00'),
	(4, 4, 'м. Стрий, вул. Бандери 12б кв. 6', '1978-05-03 00:00:00', '1-СГ№216123', 'Роман', 'Шандаревський', NULL, '2014-06-02 13:30:00'),
	(5, 9, 'Vfdvdfq', '2014-06-03 00:00:00', 'Vdfvdfvq', 'Vfsdvfq', 'Vsfvdfq', 'Vfdvdfq', '2014-06-03 13:30:00'),
	(8, 10, 'fgwer y3et erthyetr ', '2014-06-04 00:00:00', '34GT3RG34', 'Test', 'Test', '3GF4F34F34', '2014-06-04 13:15:23'),
	(12, 13, '123', '2014-08-01 00:00:00', '123', 'Alex', 'Mandryk', '123', '2014-08-04 16:36:21'),
	(13, 14, '123', '2014-08-01 00:00:00', '123', 'Tem', 'Dem', '123', '2014-08-04 17:21:17'),
	(14, 15, '123123', '2014-07-30 00:00:00', '123123', 'Tarasa', 'Demoa', '123123', '2014-08-04 17:48:56'),
	(15, 16, 'vul. Geroiv Maidanu 12.4a / 16,7', '2014-07-30 00:00:00', '151', 'Tester', 'Mester', '5234', '2014-08-05 14:29:47'),
	(17, 18, '123', '2014-08-13 00:00:00', '123', 'Qw', 'Qw', '123', '2014-08-13 14:19:00');
/*!40000 ALTER TABLE `leaders` ENABLE KEYS */;


-- Dumping structure for table carting.logs
DROP TABLE IF EXISTS `logs`;
CREATE TABLE IF NOT EXISTS `logs` (
  `LOGGER` varchar(200) NOT NULL,
  `LEVEL` varchar(45) NOT NULL,
  `MESSAGE` varchar(1000) NOT NULL,
  `DATE` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table carting.logs: ~144 rows (approximately)
DELETE FROM `logs`;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` (`LOGGER`, `LEVEL`, `MESSAGE`, `DATE`) VALUES
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-19 18:58:18,544'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-19 19:03:25,116'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-19 19:03:25,116'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-19 19:08:25,170'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-19 19:08:25,170'),
	('net.carting.web.CompetitionController', 'INFO', 'Admin has disabled competition (id = 1)', '2014-08-19 19:08:31,771'),
	('net.carting.web.CompetitionController', 'INFO', 'Admin has disabled competition (id = 1)', '2014-08-19 19:08:31,771'),
	('net.carting.web.CompetitionController', 'INFO', 'Admin has enabled competition (id = 1)', '2014-08-19 19:09:07,312'),
	('net.carting.web.CompetitionController', 'INFO', 'Admin has enabled competition (id = 1)', '2014-08-19 19:09:07,312'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-19 19:10:03,276'),
	('net.carting.web.CompetitionController', 'INFO', 'Admin has disabled competition (id = 1)', '2014-08-19 19:10:08,122'),
	('org.springframework.web.context.ContextLoader', 'ERROR', 'Context initialization failed', '2014-08-20 04:52:28,833'),
	('org.springframework.web.context.ContextLoader', 'ERROR', 'Context initialization failed', '2014-08-20 04:52:47,178'),
	('org.springframework.web.context.ContextLoader', 'ERROR', 'Context initialization failed', '2014-08-20 04:53:36,557'),
	('org.springframework.web.context.ContextLoader', 'ERROR', 'Context initialization failed', '2014-08-20 04:58:21,716'),
	('org.springframework.web.context.ContextLoader', 'ERROR', 'Context initialization failed', '2014-08-20 04:59:06,103'),
	('org.springframework.web.context.ContextLoader', 'ERROR', 'Context initialization failed', '2014-08-20 05:00:29,564'),
	('org.springframework.web.context.ContextLoader', 'ERROR', 'Context initialization failed', '2014-08-20 05:02:58,740'),
	('org.springframework.web.context.ContextLoader', 'ERROR', 'Context initialization failed', '2014-08-20 05:04:10,765'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-20 05:06:58,167'),
	('org.hibernate.engine.jdbc.spi.SqlExceptionHelper', 'WARN', 'SQL Error: 1054, SQLState: 42S22', '2014-08-20 05:06:58,821'),
	('org.hibernate.engine.jdbc.spi.SqlExceptionHelper', 'WARN', 'SQL Error: 1054, SQLState: 42S22', '2014-08-20 05:10:05,352'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-20 05:12:06,094'),
	('org.hibernate.engine.jdbc.spi.SqlExceptionHelper', 'WARN', 'SQL Error: 1054, SQLState: 42S22', '2014-08-20 05:12:06,492'),
	('org.hibernate.engine.jdbc.spi.SqlExceptionHelper', 'WARN', 'SQL Error: 1054, SQLState: 42S22', '2014-08-20 05:12:12,092'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-20 05:14:36,849'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-20 05:16:57,202'),
	('org.hibernate.engine.jdbc.spi.SqlExceptionHelper', 'WARN', 'SQL Error: 1054, SQLState: 42S22', '2014-08-20 05:16:57,496'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-20 05:21:26,029'),
	('org.hibernate.engine.jdbc.spi.SqlExceptionHelper', 'WARN', 'SQL Error: 1054, SQLState: 42S22', '2014-08-20 05:21:26,304'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-20 05:22:57,508'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-20 05:37:21,193'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-20 05:48:32,837'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-20 05:49:34,265'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-21 14:23:08,497'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-21 14:25:05,364'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-21 14:41:21,485'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-22 11:51:20,422'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-22 12:28:58,366'),
	('org.springframework.web.context.ContextLoader', 'ERROR', 'Context initialization failed', '2014-08-22 13:16:59,050'),
	('org.springframework.web.context.ContextLoader', 'ERROR', 'Context initialization failed', '2014-08-22 14:19:49,032'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-22 15:27:10,036'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-22 15:29:35,819'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-22 16:18:08,675'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-22 16:20:23,329'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-22 16:22:43,102'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-22 16:27:47,684'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-22 16:28:39,712'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-22 16:31:49,093'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-22 16:32:22,387'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-22 16:35:17,074'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-22 16:37:55,311'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-22 16:40:35,817'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-22 16:48:09,794'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-22 16:51:31,850'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-22 16:53:21,993'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-22 17:10:40,461'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-22 18:19:06,582'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'team1 had logged successfully', '2014-08-22 18:26:22,416'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-22 18:27:18,203'),
	('org.hibernate.engine.jdbc.spi.SqlExceptionHelper', 'WARN', 'SQL Error: 1054, SQLState: 42S22', '2014-08-22 18:35:08,492'),
	('org.hibernate.engine.jdbc.spi.SqlExceptionHelper', 'WARN', 'SQL Error: 1054, SQLState: 42S22', '2014-08-22 18:35:25,529'),
	('org.hibernate.engine.jdbc.spi.SqlExceptionHelper', 'WARN', 'SQL Error: 1054, SQLState: 42S22', '2014-08-22 18:35:55,177'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'team1 had logged successfully', '2014-08-22 18:36:56,168'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'team1 had logged successfully', '2014-08-22 18:43:22,647'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-22 18:44:10,963'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'team1 had logged successfully', '2014-08-22 18:45:55,253'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'team1 had logged successfully', '2014-08-22 18:54:33,548'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-22 19:01:08,277'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'team4 had logged successfully', '2014-08-22 19:17:27,794'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'team1 had logged successfully', '2014-08-22 19:17:58,633'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-22 19:18:25,297'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-22 19:19:31,123'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-24 21:01:14,355'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-24 21:09:03,807'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-24 21:09:53,734'),
	('net.carting.service.UserDetailsServiceImpl', 'INFO', 'admin had logged successfully', '2014-08-24 21:11:15,803'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'team1 had logged successfully', '2014-08-26 14:50:54,698'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'team1 had logged successfully', '2014-08-26 14:51:20,153'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'team1 had logged successfully', '2014-08-26 15:17:56,979'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'team1 had logged successfully', '2014-08-26 15:33:03,872'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-26 15:34:37,018'),
	('net.carting.service.LeaderServiceImpl', 'TRACE', 'Registrated new leader with login selenium', '2014-08-27 13:19:11,668'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'team1 had logged successfully', '2014-08-27 13:22:36,464'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'team1 had logged successfully', '2014-08-27 13:33:29,375'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'team1 had logged successfully', '2014-08-27 13:33:40,393'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'team1 had logged successfully', '2014-08-27 13:33:55,801'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'team1 had logged successfully', '2014-08-27 13:34:16,449'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'team1 had logged successfully', '2014-08-27 13:34:29,299'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-27 13:49:24,132'),
	('net.carting.web.AdminController', 'TRACE', 'Admin has deleted leader Fname Lname', '2014-08-27 13:49:39,607'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-27 13:56:35,385'),
	('net.carting.service.LeaderServiceImpl', 'TRACE', 'Registrated new leader with login selenium', '2014-08-27 14:01:08,048'),
	('net.carting.web.AdminController', 'TRACE', 'Admin has deleted leader Fname Lname', '2014-08-27 14:01:25,851'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'team1 had logged successfully', '2014-08-27 16:21:49,708'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-27 16:22:15,738'),
	('net.carting.web.CompetitionController', 'TRACE', 'Admin has enabled competition (id = 1)', '2014-08-27 16:22:21,680'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'team1 had logged successfully', '2014-08-27 16:22:31,582'),
	('net.carting.service.RacerCarClassCompetitionNumberServiceImpl', 'TRACE', 'Team ???????????? ??????? (id = 1) has registered on competition ????????????? ???????? ? ???????? ????? ?????????? ?????? 2014 ???? (????????? ????) (id = 1)', '2014-08-27 16:22:40,286'),
	('net.carting.service.RacerCarClassCompetitionNumberServiceImpl', 'TRACE', 'Racer ????? ?????? of team ???????????? ??????? had registered on competition in car class ??????????', '2014-08-27 16:22:40,326'),
	('net.carting.service.RacerCarClassCompetitionNumberServiceImpl', 'TRACE', 'Racer ?????? ??????? of team ???????????? ??????? had registered on competition in car class ?????? ?', '2014-08-27 16:22:40,366'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-27 23:47:35,993'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 00:30:29,848'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 01:44:48,115'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 01:48:57,709'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 01:50:23,266'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 03:17:08,730'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 03:24:36,253'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 03:41:38,880'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 03:57:14,516'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 04:02:44,394'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 04:03:58,981'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 04:07:10,849'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 04:08:58,969'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 04:09:05,098'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 04:09:23,386'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 04:09:24,686'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 04:09:28,262'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 04:12:56,186'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 04:14:59,543'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 04:16:06,397'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 04:16:41,280'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 04:31:45,483'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 04:37:26,568'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 04:51:37,670'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 05:11:51,490'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 05:15:55,553'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 05:19:31,916'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 05:23:08,536'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 05:25:36,160'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 05:27:28,383'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 05:35:35,657'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 14:19:46,157'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 14:21:32,870'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 14:21:56,253'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 14:22:34,240'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 14:23:21,547'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 14:27:06,675'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 14:27:38,302'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 14:28:11,643'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 14:28:22,556'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 14:28:52,857'),
	('net.carting.web.AdminController', 'TRACE', 'Admin has changed points by places to 20,15,12,10,8,6,3,3,1', '2014-08-28 14:54:16,944'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'team1 had logged successfully', '2014-08-28 14:55:08,160'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 14:55:44,318'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 15:02:21,749'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 16:04:10,114'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 16:25:07,789'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 16:25:09,846'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 16:25:11,561'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 17:21:28,500'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 17:40:24,369'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 17:42:21,462'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-28 18:04:30,907'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-29 11:15:48,496'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-29 12:38:58,729'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-29 14:33:55,037'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-29 14:47:50,721'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-30 13:10:55,454'),
	('net.carting.service.UserDetailsServiceImpl', 'TRACE', 'admin had logged successfully', '2014-08-30 13:51:35,613');
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;


-- Dumping structure for table carting.qualifying
DROP TABLE IF EXISTS `qualifying`;
CREATE TABLE IF NOT EXISTS `qualifying` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `car_class_competition_id` int(11) NOT NULL,
  `racer_number` int(11) DEFAULT NULL,
  `racer_place` int(11) DEFAULT NULL,
  `racer_time` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `car_class_competition_id` (`car_class_competition_id`),
  CONSTRAINT `qualifying_ibfk_1` FOREIGN KEY (`car_class_competition_id`) REFERENCES `car_class_competition` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table carting.qualifying: ~0 rows (approximately)
DELETE FROM `qualifying`;
/*!40000 ALTER TABLE `qualifying` DISABLE KEYS */;
/*!40000 ALTER TABLE `qualifying` ENABLE KEYS */;


-- Dumping structure for table carting.racers
DROP TABLE IF EXISTS `racers`;
CREATE TABLE IF NOT EXISTS `racers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) NOT NULL,
  `birthday` datetime NOT NULL,
  `document` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `registration_date` datetime NOT NULL,
  `sports_category` tinyint(1) NOT NULL,
  `team_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKC80DE8D25CF956A7` (`team_id`),
  CONSTRAINT `FKC80DE8D25CF956A7` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- Dumping data for table carting.racers: ~16 rows (approximately)
DELETE FROM `racers`;
/*!40000 ALTER TABLE `racers` DISABLE KEYS */;
INSERT INTO `racers` (`id`, `address`, `birthday`, `document`, `first_name`, `last_name`, `enabled`, `registration_date`, `sports_category`, `team_id`) VALUES
	(1, 'м.Чернівці, вул.Комарова 31Г,22', '1994-07-16 00:00:00', 'КР №772048', 'Максим', 'Лелик', 1, '2014-05-15 10:24:29', 4, 1),
	(2, 'м.Чернівці, вул.Головна, 285, кв.28', '1986-06-26 00:00:00', 'КР №772048', 'Віталій', 'Вахата', 1, '2014-05-15 10:27:53', 4, 1),
	(3, 'м.Чернівці, вул.Сторожинецька, 60', '2001-09-26 00:00:00', 'І-МИ № 078300', 'Андрій', 'Балашев', 1, '2014-05-15 10:31:16', 1, 1),
	(4, 'м. Кам\'янець-Подільський, вул. кн.Корыатовычыв 68/54', '2006-02-10 00:00:00', '1-БВ №023157', 'Даниїл', 'Кукурузов', 1, '2014-05-15 10:36:33', 0, 2),
	(5, 'м. Кам\'янець-Подільський, вул. Гагаріна 69/35', '2000-05-12 00:00:00', 'І-БВ', 'Максимa', 'Квапиш', 1, '2014-05-15 10:43:35', 4, 2),
	(6, 'м. Чернівці, вул. Переяслівська 6/11 ', '2009-11-19 00:00:00', 'КР233423', 'Василь', 'Ющенко', 1, '2014-05-15 11:56:04', 0, 2),
	(7, 'вул. Небесної сотні 14а', '1981-03-05 00:00:00', 'КР3431234', 'Олексій ', 'Зарубайко', 1, '2014-05-15 11:58:22', 5, 2),
	(8, 'м. Чернівці, вул. Шевченко, 25', '2008-11-12 00:00:00', 'ра12342', 'Сергій', 'Надольський', 1, '2014-05-28 10:55:14', 1, 3),
	(9, 'м. Чернівці, вул. Ентузіастів, 5', '2007-07-11 00:00:00', 'ке342344545', 'Павло', 'Мурзенко', 1, '2014-05-28 10:57:24', 2, 3),
	(10, 'м. Стрий, вул.1 Листопада 16А, кв. 3', '1993-08-19 00:00:00', 'КС 729066', 'Олег', 'Карман', 1, '2014-05-28 18:19:02', 1, 4),
	(11, 'м. Стрий, вул. Б. Хмельницького, 21, 3', '1998-07-08 00:00:00', '1-СГ №158340', 'Марко', 'Лисак', 1, '2014-05-28 18:20:26', 0, 4),
	(13, 'Vsdf', '2014-06-02 00:00:00', 'Vdf', 'Vfvdfv', 'Vdfsvdfv', 1, '2014-06-03 13:59:02', 2, 5),
	(15, 'пПвапва', '1990-01-23 00:00:00', 'Пвапва', 'Піап', 'Пвапвап', 1, '2014-06-04 13:26:17', 0, 13),
	(16, 'Gdsfgfs', '1992-03-12 00:00:00', 'Gdfgfds', 'Fsdggg', 'Gsfgfdsgds', 1, '2014-06-04 14:04:40', 1, 13),
	(21, 'м. Чернівці', '1995-07-12 00:00:00', '97NYY7MNH', 'Петро', 'Іванов', 1, '2014-06-13 17:17:53', 1, 1),
	(22, 'uu', '2012-12-01 00:00:00', 'uuu', 'Dima', 'Pima', 1, '2014-08-05 14:32:52', 5, 14);
/*!40000 ALTER TABLE `racers` ENABLE KEYS */;


-- Dumping structure for table carting.racer_car_class_numbers
DROP TABLE IF EXISTS `racer_car_class_numbers`;
CREATE TABLE IF NOT EXISTS `racer_car_class_numbers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` int(11) NOT NULL,
  `car_class_id` int(11) NOT NULL,
  `racer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `racer_id` (`racer_id`,`car_class_id`),
  KEY `FK9F10E05AA1B9B1AD` (`racer_id`),
  KEY `FK9F10E05A1F1B02DE` (`car_class_id`),
  CONSTRAINT `FK9F10E05A1F1B02DE` FOREIGN KEY (`car_class_id`) REFERENCES `car_classes` (`id`),
  CONSTRAINT `FK9F10E05AA1B9B1AD` FOREIGN KEY (`racer_id`) REFERENCES `racers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- Dumping data for table carting.racer_car_class_numbers: ~23 rows (approximately)
DELETE FROM `racer_car_class_numbers`;
/*!40000 ALTER TABLE `racer_car_class_numbers` DISABLE KEYS */;
INSERT INTO `racer_car_class_numbers` (`id`, `number`, `car_class_id`, `racer_id`) VALUES
	(1, 1, 3, 1),
	(2, 2, 3, 2),
	(3, 12, 7, 3),
	(4, 1, 6, 3),
	(5, 9, 4, 4),
	(6, 9, 2, 5),
	(7, 9, 3, 6),
	(8, 5, 4, 6),
	(9, 7, 3, 7),
	(10, 4, 7, 7),
	(11, 9, 7, 8),
	(12, 8, 4, 8),
	(13, 8, 7, 9),
	(14, 4, 4, 9),
	(15, 3, 3, 10),
	(16, 21, 2, 11),
	(17, 54, 3, 11),
	(19, 13, 3, 13),
	(21, 88, 3, 15),
	(22, 55, 3, 16),
	(29, 10, 2, 21),
	(30, 5, 3, 21),
	(31, 17, 9, 22);
/*!40000 ALTER TABLE `racer_car_class_numbers` ENABLE KEYS */;


-- Dumping structure for table carting.racer_competition_car_class_numbers
DROP TABLE IF EXISTS `racer_competition_car_class_numbers`;
CREATE TABLE IF NOT EXISTS `racer_competition_car_class_numbers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number_in_competition` int(11) NOT NULL,
  `car_class_competition_id` int(11) NOT NULL,
  `racer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `racer_id` (`racer_id`,`car_class_competition_id`),
  KEY `FKFE2396DA7644F83B` (`car_class_competition_id`),
  KEY `FKFE2396DAA1B9B1AD` (`racer_id`),
  CONSTRAINT `FKFE2396DA7644F83B` FOREIGN KEY (`car_class_competition_id`) REFERENCES `car_class_competition` (`id`),
  CONSTRAINT `FKFE2396DAA1B9B1AD` FOREIGN KEY (`racer_id`) REFERENCES `racers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- Dumping data for table carting.racer_competition_car_class_numbers: ~13 rows (approximately)
DELETE FROM `racer_competition_car_class_numbers`;
/*!40000 ALTER TABLE `racer_competition_car_class_numbers` DISABLE KEYS */;
INSERT INTO `racer_competition_car_class_numbers` (`id`, `number_in_competition`, `car_class_competition_id`, `racer_id`) VALUES
	(4, 1, 2, 3),
	(6, 2, 3, 2),
	(7, 1, 3, 1),
	(10, 9, 6, 8),
	(11, 8, 6, 9),
	(12, 2, 5, 2),
	(13, 12, 6, 3),
	(14, 1, 5, 1),
	(15, 4, 6, 7),
	(17, 9, 5, 6),
	(19, 7, 5, 7),
	(29, 13, 3, 13),
	(31, 7, 3, 7);
/*!40000 ALTER TABLE `racer_competition_car_class_numbers` ENABLE KEYS */;


-- Dumping structure for table carting.racer_document
DROP TABLE IF EXISTS `racer_document`;
CREATE TABLE IF NOT EXISTS `racer_document` (
  `racer_id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  PRIMARY KEY (`racer_id`,`document_id`),
  KEY `FKADCD1BD917352767` (`document_id`),
  KEY `FKADCD1BD9A1B9B1AD` (`racer_id`),
  CONSTRAINT `FKADCD1BD917352767` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`),
  CONSTRAINT `FKADCD1BD9A1B9B1AD` FOREIGN KEY (`racer_id`) REFERENCES `racers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table carting.racer_document: ~0 rows (approximately)
DELETE FROM `racer_document`;
/*!40000 ALTER TABLE `racer_document` DISABLE KEYS */;
/*!40000 ALTER TABLE `racer_document` ENABLE KEYS */;


-- Dumping structure for table carting.races
DROP TABLE IF EXISTS `races`;
CREATE TABLE IF NOT EXISTS `races` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number_of_laps` int(11) NOT NULL,
  `number_of_members` int(11) NOT NULL,
  `race_number` int(11) NOT NULL,
  `result_sequance` varchar(255) NOT NULL,
  `car_class_id` int(11) NOT NULL,
  `car_class_competition_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6740FC27644F83B` (`car_class_competition_id`),
  KEY `FK6740FC21F1B02DE` (`car_class_id`),
  CONSTRAINT `FK6740FC21F1B02DE` FOREIGN KEY (`car_class_id`) REFERENCES `car_classes` (`id`),
  CONSTRAINT `FK6740FC27644F83B` FOREIGN KEY (`car_class_competition_id`) REFERENCES `car_class_competition` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- Dumping data for table carting.races: ~5 rows (approximately)
DELETE FROM `races`;
/*!40000 ALTER TABLE `races` DISABLE KEYS */;
INSERT INTO `races` (`id`, `number_of_laps`, `number_of_members`, `race_number`, `result_sequance`, `car_class_id`, `car_class_competition_id`) VALUES
	(4, 7, 4, 1, '12 4 8 9 8 4 8 9 12 12 4 8 9 8 9 8 9 12 4 4', 7, 6),
	(5, 7, 4, 2, '12 9 8 4 12 9 8 8 12 9 4 8 12 9 12 8 12 9 12 9', 7, 6),
	(6, 10, 4, 1, '1 7 2 9 2 9 1 7 2 1 9 7 2 9 1 2 9 1 7 2 9 2 9 1 1 1 1 2 7', 3, 5),
	(7, 10, 4, 2, '2 9 1 7 1 2 7 1 2 7 1 2 7 7 2 1 7 2 1 7 2 7 2 1 7 2 1 1 7 1', 3, 5),
	(8, 6, 1, 1, '1 1 1', 6, 2);
/*!40000 ALTER TABLE `races` ENABLE KEYS */;


-- Dumping structure for table carting.race_results
DROP TABLE IF EXISTS `race_results`;
CREATE TABLE IF NOT EXISTS `race_results` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `car_number` int(11) NOT NULL,
  `full_laps` int(11) NOT NULL,
  `place` int(11) NOT NULL,
  `points` int(11) NOT NULL,
  `race_id` int(11) NOT NULL,
  `racer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9D24CC88A1B9B1AD` (`racer_id`),
  KEY `FK9D24CC88EC711227` (`race_id`),
  CONSTRAINT `FK9D24CC88A1B9B1AD` FOREIGN KEY (`racer_id`) REFERENCES `racers` (`id`),
  CONSTRAINT `FK9D24CC88EC711227` FOREIGN KEY (`race_id`) REFERENCES `races` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- Dumping data for table carting.race_results: ~17 rows (approximately)
DELETE FROM `race_results`;
/*!40000 ALTER TABLE `race_results` DISABLE KEYS */;
INSERT INTO `race_results` (`id`, `car_number`, `full_laps`, `place`, `points`, `race_id`, `racer_id`) VALUES
	(11, 8, 6, 1, 40, 4, 9),
	(12, 4, 5, 3, 0, 4, 7),
	(13, 9, 5, 2, 0, 4, 8),
	(14, 12, 4, 4, 0, 4, 3),
	(15, 12, 7, 1, 40, 5, 3),
	(16, 9, 6, 2, 24, 5, 8),
	(17, 8, 5, 3, 0, 5, 9),
	(18, 4, 2, 4, 0, 5, 7),
	(19, 1, 9, 1, 40, 6, 1),
	(20, 2, 8, 2, 24, 6, 2),
	(21, 9, 7, 3, 0, 6, 6),
	(22, 7, 5, 4, 0, 6, 7),
	(23, 7, 10, 1, 40, 7, 7),
	(24, 1, 10, 2, 24, 7, 1),
	(25, 2, 9, 3, 11, 7, 2),
	(26, 9, 1, 4, 0, 7, 6),
	(27, 1, 3, 1, 0, 8, 3);
/*!40000 ALTER TABLE `race_results` ENABLE KEYS */;


-- Dumping structure for table carting.roles
DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `role` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table carting.roles: ~2 rows (approximately)
DELETE FROM `roles`;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`, `role`) VALUES
	(1, 'ROLE_ADMIN'),
	(2, 'ROLE_TEAM_LEADER');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;


-- Dumping structure for table carting.teams
DROP TABLE IF EXISTS `teams`;
CREATE TABLE IF NOT EXISTS `teams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `leader_id` int(11) NOT NULL,
  `license` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK69209B64530F7E7` (`leader_id`),
  CONSTRAINT `FK69209B64530F7E7` FOREIGN KEY (`leader_id`) REFERENCES `leaders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- Dumping data for table carting.teams: ~8 rows (approximately)
DELETE FROM `teams`;
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
INSERT INTO `teams` (`id`, `address`, `name`, `leader_id`, `license`) VALUES
	(1, 'м.Чернівці, вул.Мамаївська.6', 'Чернівецький ОЦНТТУМ', 1, NULL),
	(2, 'м. Кам\'янець-Подільський, вул. Грушевського 74/524', 'Філія ХОЦНТТУМ м. Кам\'янець-Подільський', 2, NULL),
	(3, 'м. Чернівці', 'Чернівецькі яструби', 3, NULL),
	(4, 'м. Стрий, вул. Бандери, 12 , кв.6', 'Львівський ОЦНТТУМ', 4, NULL),
	(5, 'Adress', 'My Team', 5, 'E565'),
	(13, 'пПапвап', 'АПП', 8, 'Пвапвап'),
	(14, 'fafa', 'Super Command', 15, '123412'),
	(16, 'Чернівці, вул Комарова 19/21, кв. №56', 'Com', 14, 'AS №123456');
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;


-- Dumping structure for table carting.team_in_competition
DROP TABLE IF EXISTS `team_in_competition`;
CREATE TABLE IF NOT EXISTS `team_in_competition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `competition_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `team_id` (`team_id`,`competition_id`),
  KEY `FK6C8DF3C7ED6F4EAD` (`competition_id`),
  KEY `FK6C8DF3C75CF956A7` (`team_id`),
  CONSTRAINT `FK6C8DF3C75CF956A7` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`),
  CONSTRAINT `FK6C8DF3C7ED6F4EAD` FOREIGN KEY (`competition_id`) REFERENCES `competitions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- Dumping data for table carting.team_in_competition: ~6 rows (approximately)
DELETE FROM `team_in_competition`;
/*!40000 ALTER TABLE `team_in_competition` DISABLE KEYS */;
INSERT INTO `team_in_competition` (`id`, `competition_id`, `team_id`) VALUES
	(2, 2, 1),
	(10, 1, 2),
	(3, 2, 2),
	(1, 2, 3),
	(7, 2, 4),
	(8, 1, 5);
/*!40000 ALTER TABLE `team_in_competition` ENABLE KEYS */;


-- Dumping structure for table carting.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role_id` int(11) unsigned NOT NULL,
  `email` varchar(45) NOT NULL,
  `reset_pass_link` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_users_roles` (`role_id`),
  CONSTRAINT `FK_users_roles` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- Dumping data for table carting.users: ~12 rows (approximately)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `username`, `enabled`, `password`, `role_id`, `email`, `reset_pass_link`) VALUES
	(1, 'admin', 1, '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 1, '', NULL),
	(4, 'roman', 1, '4eaae75f1df2f52bda44f6b18a400542d51c81bd7c00b0e720be5dc2c997575d', 2, '', NULL),
	(6, 'team1', 1, '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 2, '', NULL),
	(7, 'team2', 1, '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 2, '', NULL),
	(8, 'team4', 1, '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 2, '', NULL),
	(9, 'test', 1, '0ffe1abd1a08215353c233d6e009613e95eec4253832a761af28ff37ac5a150c', 2, '', NULL),
	(10, 'test1', 0, '0ffe1abd1a08215353c233d6e009613e95eec4253832a761af28ff37ac5a150c', 2, '', NULL),
	(13, 'alex', 0, '96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e', 2, '', NULL),
	(14, 'tem', 0, '96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e', 2, '', NULL),
	(15, 'demo', 1, '96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e', 2, '', NULL),
	(16, 'tester', 1, '96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e', 2, '', NULL),
	(18, 'kolio', 1, '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', 2, 'kolio5991@gmail.com', '682c5d12b454444f10e3660f3e1317434e93eabc9b58747552d05a642cdb45bc');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
