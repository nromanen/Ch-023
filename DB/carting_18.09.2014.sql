-- MySQL dump 10.13  Distrib 5.5.25a, for Win64 (x86)
--
-- Host: localhost    Database: carting
-- ------------------------------------------------------
-- Server version	5.0.67-community-nt

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Not dumping tablespaces as no INFORMATION_SCHEMA.FILES table on this server
--

--
-- Table structure for table `admin_settings`
--

DROP TABLE IF EXISTS `admin_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_settings` (
  `id` int(11) NOT NULL auto_increment,
  `feedback_email` varchar(255) NOT NULL,
  `parental_permission_years` int(11) NOT NULL,
  `points_by_places` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_settings`
--

LOCK TABLES `admin_settings` WRITE;
/*!40000 ALTER TABLE `admin_settings` DISABLE KEYS */;
INSERT INTO `admin_settings` VALUES (1,'softserve.karting@gmail.com',18,'20,15,12,10,8,6,3,3,1');
/*!40000 ALTER TABLE `admin_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `car_class_competition`
--

DROP TABLE IF EXISTS `car_class_competition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `car_class_competition` (
  `id` int(11) NOT NULL auto_increment,
  `circle_count` int(11) NOT NULL,
  `first_race_time` time NOT NULL,
  `percentage_offset` int(11) NOT NULL,
  `second_race_time` time NOT NULL,
  `car_class_id` int(11) NOT NULL,
  `competition_id` int(11) NOT NULL,
  `firstStartStatement_id` int(11) default NULL,
  `secondStartStatement_id` int(11) default NULL,
  `maneuverStatement_id` int(11) default NULL,
  `personalOffset_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car_class_competition`
--

LOCK TABLES `car_class_competition` WRITE;
/*!40000 ALTER TABLE `car_class_competition` DISABLE KEYS */;
INSERT INTO `car_class_competition` VALUES (1,6,'16:05:00',75,'12:40:00',7,1,NULL,NULL,NULL,NULL),(2,6,'15:20:00',75,'12:00:00',6,1,NULL,NULL,NULL,NULL),(3,10,'15:00:00',75,'11:40:00',3,1,NULL,NULL,NULL,NULL),(5,7,'11:30:00',75,'14:00:00',3,2,NULL,NULL,NULL,NULL),(6,7,'12:30:00',75,'15:30:00',7,2,NULL,NULL,NULL,NULL),(8,4,'15:30:00',75,'16:20:00',1,2,NULL,NULL,NULL,NULL),(9,5,'11:00:00',80,'12:00:00',1,1,NULL,NULL,NULL,NULL),(10,5,'11:00:00',80,'12:00:00',2,1,NULL,NULL,NULL,NULL),(11,1,'12:01:00',75,'12:50:00',1,4,NULL,NULL,NULL,NULL),(12,1,'12:01:00',75,'12:50:00',2,4,NULL,NULL,NULL,NULL),(13,1,'12:01:00',75,'12:50:00',3,4,NULL,NULL,NULL,NULL),(14,1,'12:01:00',75,'12:50:00',4,4,NULL,NULL,NULL,NULL),(15,1,'12:01:00',75,'12:50:00',6,4,NULL,NULL,NULL,NULL),(16,1,'12:01:00',75,'12:50:00',7,4,NULL,NULL,NULL,NULL),(17,1,'12:01:00',75,'12:50:00',8,4,NULL,NULL,NULL,NULL),(18,1,'12:01:00',75,'12:50:00',9,4,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `car_class_competition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `car_class_competition_results`
--

DROP TABLE IF EXISTS `car_class_competition_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `car_class_competition_results` (
  `id` int(11) NOT NULL auto_increment,
  `absolute_place` int(11) default NULL,
  `absolute_points` int(11) default NULL,
  `comment` varchar(255) default NULL,
  `race2_points` int(11) default NULL,
  `racer_competition_carclass_number_id` int(11) NOT NULL,
  `maneuver_time` double default '0',
  `qualifying_racer_time` int(11) default NULL,
  `qualifying_racer_place` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK706F8784CA0A6B84` (`racer_competition_carclass_number_id`),
  CONSTRAINT `FK706F8784CA0A6B84` FOREIGN KEY (`racer_competition_carclass_number_id`) REFERENCES `racer_competition_car_class_numbers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car_class_competition_results`
--

LOCK TABLES `car_class_competition_results` WRITE;
/*!40000 ALTER TABLE `car_class_competition_results` DISABLE KEYS */;
INSERT INTO `car_class_competition_results` VALUES (7,1,40,'без штрафу',40,13,0,NULL,NULL),(8,4,0,'2 за маневрування',0,15,0,NULL,NULL),(9,2,40,'без штрафу',0,11,0,NULL,NULL),(10,3,24,'без штрафу',24,10,0,NULL,NULL),(11,3,35,'без штрафу',11,12,0,NULL,NULL),(12,4,0,'10 за красивые глаза',0,17,0,NULL,NULL),(13,1,64,'-5 за таран карту №1',24,14,0,NULL,NULL),(14,2,40,'без штрафу',40,19,0,NULL,NULL),(15,1,40,'без штрафу',20,4,10,NULL,NULL),(16,2,35,'без штрафу',15,29,10,NULL,NULL),(17,1,35,'без штрафу',20,6,54,NULL,NULL),(18,3,24,'без штрафу',12,7,10,NULL,NULL),(19,4,20,'без штрафу',10,31,12,NULL,NULL),(20,4,20,'без штрафу',10,32,1,NULL,NULL),(21,5,0,'без штрафу',0,34,19,NULL,NULL),(22,1,40,'без штрафу',20,38,60,NULL,NULL),(23,2,30,'без штрафу',15,36,43,NULL,NULL),(24,6,0,'без штрафу',0,33,10,NULL,NULL),(25,3,24,'без штрафу',12,37,30,NULL,NULL),(26,2,30,'без штрафу',15,39,20,3661010,2),(27,1,40,'без штрафу',20,40,1,1300,1),(28,0,0,'без штрафу',0,42,0,1100,1),(29,0,0,'без штрафу',0,41,0,1123,2);
/*!40000 ALTER TABLE `car_class_competition_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `car_classes`
--

DROP TABLE IF EXISTS `car_classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `car_classes` (
  `id` int(11) NOT NULL auto_increment,
  `lower_years_limit` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `upper_years_limit` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_2` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car_classes`
--

LOCK TABLES `car_classes` WRITE;
/*!40000 ALTER TABLE `car_classes` DISABLE KEYS */;
INSERT INTO `car_classes` VALUES (1,12,'Популярний-Юнаки',17),(2,15,'Кадет',99),(3,15,'Популярний',99),(4,6,'Піонер Н-міні',9),(6,6,'Піонер Б',13),(7,9,'Піонер Н',13),(8,5,'dgfhdsgh',8),(9,16,'ICA',98);
/*!40000 ALTER TABLE `car_classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `competitions`
--

DROP TABLE IF EXISTS `competitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `competitions` (
  `id` int(11) NOT NULL auto_increment,
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
  `absoluteResultsStatement_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `absoluteResultsStatement_id` (`absoluteResultsStatement_id`),
  CONSTRAINT `competitions_ibfk_1` FOREIGN KEY (`absoluteResultsStatement_id`) REFERENCES `files` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `competitions`
--

LOCK TABLES `competitions` WRITE;
/*!40000 ALTER TABLE `competitions` DISABLE KEYS */;
INSERT INTO `competitions` VALUES (1,'2014-06-30','2014-06-28','НК','МИРОНОВ В.І.',0,'2014-06-28','ВСЕУКРАЇНСЬКІ ЗМАГАННЯ З КАРТИНГУ СЕРЕД УЧНІВСЬКОЇ МОЛОДІ 2014 року (фінальний етап)','м.Кам\'янець-Подільський','2014-06-30','НК','РИБАЛКА Л.А.',0,'20,15,12,10,8,6,3,3,1',NULL),(2,'2014-05-29','2014-05-28','НК','МИРОНОВ В.І.',0,'2014-05-28','Чемпіонат Чернівецької області (весна 2014 року)','м. Чернівці','2014-05-28','НК','РИБАЛКА Л.А.',1,'28,15,12,10,9,8,5,4,1',NULL),(3,'2015-07-17','2015-07-16','dsgfsd','Gdsfgdf',0,'2014-06-06','Test','Test','2014-06-07','dfgdsf','Gdgdf',0,'20,15,12,10,8,6,3,3,1',NULL),(4,'2014-09-11','2014-09-11','asd','Asd',0,'2014-09-11','trest','asd','2014-09-11','asd','Asd',0,'20,15,12,10,8,6,3,3,1',NULL);
/*!40000 ALTER TABLE `competitions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documents` (
  `id` int(11) NOT NULL auto_increment,
  `approved` tinyint(1) NOT NULL,
  `checked` tinyint(1) NOT NULL,
  `finish_date` datetime default NULL,
  `name` varchar(255) default NULL,
  `reason` varchar(255) default NULL,
  `start_date` datetime default NULL,
  `type` tinyint(1) NOT NULL,
  `team_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `team_id` (`team_id`),
  CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
INSERT INTO `documents` VALUES (2,0,0,NULL,'1','',NULL,1,1),(3,0,0,'2014-09-11 00:00:00','12','',NULL,2,1),(4,0,0,'2014-09-30 00:00:00',NULL,'',NULL,3,1),(5,0,0,NULL,NULL,'','2014-09-17 00:00:00',4,1);
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files` (
  `id` int(11) NOT NULL auto_increment,
  `document_id` int(11) default NULL,
  `file` longblob,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK5CEBA7717352767` (`document_id`),
  CONSTRAINT `FK5CEBA7717352767` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leaders`
--

DROP TABLE IF EXISTS `leaders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `leaders` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) unsigned NOT NULL,
  `address` varchar(255) NOT NULL,
  `birthday` datetime NOT NULL,
  `document` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `license` varchar(255) default NULL,
  `registration_date` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `leaders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leaders`
--

LOCK TABLES `leaders` WRITE;
/*!40000 ALTER TABLE `leaders` DISABLE KEYS */;
INSERT INTO `leaders` VALUES (1,6,'м.Чернівці, вул.Мамаївська.6','1980-06-23 00:00:00','СЕ123345','Сергий','Пономар',NULL,'2014-06-02 13:30:00'),(2,7,'м. Кам\'янець-Подільський, вул. Грушевського 74/524','1974-06-27 00:00:00','НВ','Руслан','Кагітін',NULL,'2014-06-02 13:30:00'),(3,8,'м. Чернівці, вул. Каспрука 13/9','1980-07-09 00:00:00','кр122312','Петров','Розуменко',NULL,'2014-06-02 13:30:00'),(4,4,'м. Стрий, вул. Бандери 12б кв. 6','1978-05-03 00:00:00','1-СГ№216123','Роман','Шандаревський',NULL,'2014-06-02 13:30:00'),(5,9,'Vfdvdfq','2014-06-03 00:00:00','Vdfvdfvq','Vfsdvfq','Vsfvdfq','Vfdvdfq','2014-06-03 13:30:00'),(8,10,'fgwer y3et erthyetr ','2014-06-04 00:00:00','34GT3RG34','Test','Test','3GF4F34F34','2014-06-04 13:15:23'),(12,13,'123','2014-08-01 00:00:00','123','Alex','Mandryk','123','2014-08-04 16:36:21'),(13,14,'123','2014-08-01 00:00:00','123','Tem','Dem','123','2014-08-04 17:21:17'),(14,15,'123123','2014-07-30 00:00:00','123123','Tarasa','Demoa','123123','2014-08-04 17:48:56'),(15,16,'vul. Geroiv Maidanu 12.4a / 16,7','2014-07-30 00:00:00','151','Tester','Mester','5234','2014-08-05 14:29:47'),(17,18,'123','2014-08-13 00:00:00','123','Qw','Qw','123','2014-08-13 14:19:00');
/*!40000 ALTER TABLE `leaders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs` (
  `LOGGER` varchar(200) NOT NULL,
  `MESSAGE` varchar(1000) NOT NULL,
  `DATE` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` VALUES ('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-03 23:41:28'),('net.carting.web.CarClassCompetitionController','Admin has added race with id=9 race number 2 in car class competition Піонер Б in competition ВСЕУКРАЇНСЬКІ ЗМАГАННЯ З КАРТИНГУ СЕРЕД УЧНІВСЬКОЇ МОЛОДІ 2014 року (фінальний етап)','2014-09-03 23:43:09'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 00:44:37'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 00:48:42'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 02:38:31'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 02:45:51'),('net.carting.web.CarClassCompetitionController','Admin has edited race with id=8 race number 1 in car class competition Піонер Б in competition ВСЕУКРАЇНСЬКІ ЗМАГАННЯ З КАРТИНГУ СЕРЕД УЧНІВСЬКОЇ МОЛОДІ 2014 року (фінальний етап)','2014-09-04 02:46:23'),('net.carting.web.CarClassCompetitionController','Admin has edited race with id=8 race number 1 in car class competition Піонер Б in competition ВСЕУКРАЇНСЬКІ ЗМАГАННЯ З КАРТИНГУ СЕРЕД УЧНІВСЬКОЇ МОЛОДІ 2014 року (фінальний етап)','2014-09-04 02:46:31'),('net.carting.web.CarClassCompetitionController','Admin has edited race with id=8 race number 1 in car class competition Піонер Б in competition ВСЕУКРАЇНСЬКІ ЗМАГАННЯ З КАРТИНГУ СЕРЕД УЧНІВСЬКОЇ МОЛОДІ 2014 року (фінальний етап)','2014-09-04 02:46:41'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 03:12:40'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 03:36:39'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 03:40:56'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 03:42:30'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 03:52:32'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 04:14:12'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 04:16:42'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 04:22:12'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 04:24:11'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 04:29:14'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 14:24:14'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 14:46:16'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 14:55:25'),('net.carting.web.CarClassCompetitionController','Admin has added race with id=10 race number 1 in car class competition Популярний in competition ВСЕУКРАЇНСЬКІ ЗМАГАННЯ З КАРТИНГУ СЕРЕД УЧНІВСЬКОЇ МОЛОДІ 2014 року (фінальний етап)','2014-09-04 15:14:12'),('net.carting.web.CarClassCompetitionController','Admin has added race with id=11 race number 2 in car class competition Популярний in competition ВСЕУКРАЇНСЬКІ ЗМАГАННЯ З КАРТИНГУ СЕРЕД УЧНІВСЬКОЇ МОЛОДІ 2014 року (фінальний етап)','2014-09-04 15:14:25'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 16:12:40'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 16:25:55'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 16:42:30'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 17:18:18'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 17:26:42'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 17:29:55'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 17:40:05'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 17:43:07'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 17:58:45'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 18:00:18'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 18:02:06'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 23:39:58'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 23:45:38'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-04 23:48:36'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-05 00:30:15'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-05 01:11:09'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-05 01:25:25'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-05 01:32:59'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-05 02:25:55'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-05 13:09:09'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-08 16:17:16'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-10 16:07:48'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-11 14:08:00'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-11 14:27:32'),('net.carting.web.CarClassCompetitionController','Admin has edited race with id=10 race number 1 in car class competition Популярний in competition ВСЕУКРАЇНСЬКІ ЗМАГАННЯ З КАРТИНГУ СЕРЕД УЧНІВСЬКОЇ МОЛОДІ 2014 року (фінальний етап)','2014-09-11 14:28:05'),('net.carting.web.CarClassCompetitionController','Admin has edited race with id=11 race number 2 in car class competition Популярний in competition ВСЕУКРАЇНСЬКІ ЗМАГАННЯ З КАРТИНГУ СЕРЕД УЧНІВСЬКОЇ МОЛОДІ 2014 року (фінальний етап)','2014-09-11 14:28:26'),('net.carting.web.CarClassCompetitionController','Admin has edited race with id=8 race number 1 in car class competition Піонер Б in competition ВСЕУКРАЇНСЬКІ ЗМАГАННЯ З КАРТИНГУ СЕРЕД УЧНІВСЬКОЇ МОЛОДІ 2014 року (фінальний етап)','2014-09-11 14:30:14'),('net.carting.web.CarClassCompetitionController','Admin has edited race with id=9 race number 2 in car class competition Піонер Б in competition ВСЕУКРАЇНСЬКІ ЗМАГАННЯ З КАРТИНГУ СЕРЕД УЧНІВСЬКОЇ МОЛОДІ 2014 року (фінальний етап)','2014-09-11 14:30:20'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-11 14:34:29'),('net.carting.web.CarClassCompetitionController','Admin has edited race with id=9 race number 2 in car class competition Піонер Б in competition ВСЕУКРАЇНСЬКІ ЗМАГАННЯ З КАРТИНГУ СЕРЕД УЧНІВСЬКОЇ МОЛОДІ 2014 року (фінальний етап)','2014-09-11 14:45:02'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-11 15:21:01'),('net.carting.web.CompetitionController','Admin has added new competition trest (id = 4))','2014-09-11 15:23:02'),('net.carting.web.CompetitionController','Admin has added car class Популярний-Юнаки to competition with name trest (id = 4)','2014-09-11 15:23:20'),('net.carting.web.CompetitionController','Admin has added car class Кадет to competition with name trest (id = 4)','2014-09-11 15:23:24'),('net.carting.web.CompetitionController','Admin has added car class Популярний to competition with name trest (id = 4)','2014-09-11 15:23:26'),('net.carting.web.CompetitionController','Admin has added car class Піонер Н-міні to competition with name trest (id = 4)','2014-09-11 15:23:29'),('net.carting.web.CompetitionController','Admin has added car class Піонер Б to competition with name trest (id = 4)','2014-09-11 15:23:32'),('net.carting.web.CompetitionController','Admin has added car class Піонер Н to competition with name trest (id = 4)','2014-09-11 15:23:35'),('net.carting.web.CompetitionController','Admin has added car class dgfhdsgh to competition with name trest (id = 4)','2014-09-11 15:23:37'),('net.carting.web.CompetitionController','Admin has added car class ICA to competition with name trest (id = 4)','2014-09-11 15:23:39'),('net.carting.web.CompetitionController','Admin has enabled competition (id = 4)','2014-09-11 15:23:49'),('net.carting.service.UserDetailsServiceImpl','team1 had logged successfully','2014-09-11 15:23:54'),('net.carting.service.RacerCarClassCompetitionNumberServiceImpl','Team Чернівецький ОЦНТТУМ (id = 1) has registered on competition trest (id = 4)','2014-09-11 15:24:28'),('net.carting.web.CarClassCompetitionController','team1 has registered racer Віталій Вахата (id = 2) with number 2 to competition trest (id = 4) to car class Популярний (id = 13)','2014-09-11 15:24:28'),('net.carting.web.CarClassCompetitionController','team1 has registered racer Петро Іванов (id = 21) with number 5 to competition trest (id = 4) to car class Популярний (id = 13)','2014-09-11 15:24:34'),('net.carting.web.CarClassCompetitionController','team1 has registered racer Максим Лелик (id = 1) with number 1 to competition trest (id = 4) to car class Популярний (id = 13)','2014-09-11 15:24:37'),('net.carting.web.CarClassCompetitionController','team1 has registered racer Петро Іванов (id = 21) with number 10 to competition trest (id = 4) to car class Кадет (id = 12)','2014-09-11 15:24:52'),('net.carting.web.CarClassCompetitionController','team1 has unregistered racer(id = 21) from competition trest (id = 4) from car class Кадет (id = 12)','2014-09-11 15:24:57'),('net.carting.service.UserDetailsServiceImpl','team4 had logged successfully','2014-09-11 15:25:07'),('net.carting.web.RacerController','team4 had edited racer Павло Мурзенко (id = 9)','2014-09-11 15:25:38'),('net.carting.web.RacerController','team4 has added car class with Популярний to racer 8 Павло (id = Мурзенко)','2014-09-11 15:25:51'),('net.carting.web.RacerController','team4 had edited racer Сергій Надольський (id = 8)','2014-09-11 15:26:08'),('net.carting.web.RacerController','team4 has added car class with Популярний to racer 10 Сергій (id = Надольський)','2014-09-11 15:26:19'),('net.carting.service.RacerCarClassCompetitionNumberServiceImpl','Team Чернівецькі яструби (id = 3) has registered on competition trest (id = 4)','2014-09-11 15:26:33'),('net.carting.web.CarClassCompetitionController','team4 has registered racer Павло Мурзенко (id = 9) with number 8 to competition trest (id = 4) to car class Популярний (id = 13)','2014-09-11 15:26:33'),('net.carting.web.CarClassCompetitionController','team4 has registered racer Сергій Надольський (id = 8) with number 10 to competition trest (id = 4) to car class Популярний (id = 13)','2014-09-11 15:26:38'),('net.carting.service.UserDetailsServiceImpl','team2 had logged successfully','2014-09-11 15:27:54'),('net.carting.service.RacerCarClassCompetitionNumberServiceImpl','Team Філія ХОЦНТТУМ м. Кам\'янець-Подільський (id = 2) has registered on competition trest (id = 4)','2014-09-11 15:28:15'),('net.carting.web.CarClassCompetitionController','team2 has registered racer Олексій  Зарубайко (id = 7) with number 7 to competition trest (id = 4) to car class Популярний (id = 13)','2014-09-11 15:28:15'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-11 15:28:30'),('net.carting.web.CarClassCompetitionController','Admin has added race with id=12 race number 1 in car class competition Популярний in competition trest','2014-09-11 15:30:13'),('net.carting.service.UserDetailsServiceImpl','team2 had logged successfully','2014-09-11 15:31:18'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-11 15:32:46'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-15 13:18:19'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-15 13:44:05'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-15 13:58:05'),('net.carting.web.CarClassCompetitionController','Admin has edited race with id=12 race number 1 in car class competition Популярний in competition trest','2014-09-15 13:58:29'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-15 15:20:34'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-15 17:23:29'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-15 17:25:27'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-15 18:12:34'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-15 18:15:37'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-16 12:34:37'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-16 12:49:13'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-16 12:53:30'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-16 12:58:16'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-16 12:59:48'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-16 13:29:37'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-16 13:34:25'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-16 13:37:33'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-16 13:40:27'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-16 13:41:31'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-16 13:42:55'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-16 13:54:55'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-16 14:17:23'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-16 14:21:05'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-16 14:25:38'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-16 14:26:45'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-16 14:27:35'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-16 14:29:00'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-16 14:35:38'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-16 14:36:52'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-16 14:46:54'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-16 14:47:30'),('net.carting.web.CarClassCompetitionController','Admin has added race with id=13 race number 2 in car class competition Популярний in competition trest','2014-09-16 14:48:02'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-17 14:59:57'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-17 15:03:36'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-17 15:19:48'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-17 15:23:29'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-17 15:26:11'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-17 15:31:38'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-17 15:39:41'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-17 15:56:31'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-17 15:57:58'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-17 16:01:27'),('net.carting.web.CarClassCompetitionController','Admin has edited race with id=4 race number 1 in car class competition Піонер Н in competition Чемпіонат Чернівецької області (весна 2014 року)','2014-09-17 16:05:03'),('net.carting.web.CarClassCompetitionController','Admin has edited race with id=12 race number 1 in car class competition Популярний in competition trest','2014-09-17 16:10:22'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-17 16:17:01'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-17 16:43:00'),('net.carting.service.UserDetailsServiceImpl','team1 had logged successfully','2014-09-17 16:44:40'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-17 16:45:03'),('net.carting.web.CompetitionController','Admin has enabled competition (id = 4)','2014-09-17 16:45:06'),('net.carting.service.UserDetailsServiceImpl','team1 had logged successfully','2014-09-17 16:45:18'),('net.carting.web.CarClassCompetitionController','team1 has registered racer Петро Іванов (id = 21) with number 10 to competition trest (id = 4) to car class Кадет (id = 12)','2014-09-17 16:45:43'),('net.carting.service.UserDetailsServiceImpl','team2 had logged successfully','2014-09-17 16:46:04'),('net.carting.web.RacerController','team2 had edited racer Максимa Квапиш (id = 5)','2014-09-17 16:47:22'),('net.carting.web.CarClassCompetitionController','team2 has registered racer Максимa Квапиш (id = 5) with number 9 to competition trest (id = 4) to car class Кадет (id = 12)','2014-09-17 16:47:34'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-17 16:47:46'),('net.carting.service.UserDetailsServiceImpl','team2 had logged successfully','2014-09-17 16:50:43'),('net.carting.web.CarClassCompetitionController','team2 has registered racer Даниїл Кукурузов (id = 4) with number 9 to competition trest (id = 4) to car class Піонер Н-міні (id = 14)','2014-09-17 16:51:09'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-17 16:52:14'),('net.carting.service.UserDetailsServiceImpl','team2 had logged successfully','2014-09-17 16:52:21'),('net.carting.service.UserDetailsServiceImpl','team1 had logged successfully','2014-09-17 16:53:05'),('net.carting.web.RacerController','team1 had added racer Tim Roth to team Чернівецький ОЦНТТУМ (id = 1)','2014-09-17 16:54:05'),('net.carting.web.CarClassCompetitionController','team1 has registered racer Tim Roth (id = 23) with number 13 to competition trest (id = 4) to car class Піонер Н-міні (id = 14)','2014-09-17 16:54:15'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-17 16:54:24'),('net.carting.web.CarClassCompetitionController','Admin has added race with id=14 race number 1 in car class competition Кадет in competition trest','2014-09-17 16:56:56'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-17 17:03:14'),('net.carting.web.CarClassCompetitionController','Admin has added race with id=15 race number 2 in car class competition Кадет in competition trest','2014-09-17 17:21:09'),('net.carting.web.CarClassCompetitionController','Admin has edited race with id=12 race number 1 in car class competition Популярний in competition trest','2014-09-17 17:23:51'),('net.carting.web.CarClassCompetitionController','Admin has edited race with id=13 race number 2 in car class competition Популярний in competition trest','2014-09-17 17:24:03'),('net.carting.web.CarClassCompetitionController','Admin has edited race with id=12 race number 1 in car class competition Популярний in competition trest','2014-09-17 17:24:42'),('net.carting.web.CarClassCompetitionController','Admin has edited race with id=13 race number 2 in car class competition Популярний in competition trest','2014-09-17 17:24:50'),('net.carting.service.UserDetailsServiceImpl','team1 had logged successfully','2014-09-17 17:37:34'),('net.carting.web.DocumentController','Leader of team Чернівецький ОЦНТТУМ tried to add document Racer\'s license','2014-09-17 17:37:37'),('net.carting.service.RacerServiceImpl','Leader of team Чернівецький ОЦНТТУМ added \'Racer\'s license\' to racer Tim Roth','2014-09-17 17:37:57'),('net.carting.web.DocumentController','Leader of team Чернівецький ОЦНТТУМ tried to add document Racer\'s insurance','2014-09-17 17:38:04'),('net.carting.service.RacerServiceImpl','Leader of team Чернівецький ОЦНТТУМ added \'Racer\'s insurance\' to racer Tim Roth','2014-09-17 17:38:16'),('net.carting.service.RacerServiceImpl','Leader of team Чернівецький ОЦНТТУМ added \'Racer\'s insurance\' to racer Максим Лелик','2014-09-17 17:38:16'),('net.carting.web.DocumentController','Leader of team Чернівецький ОЦНТТУМ tried to add document Racer\'s medical certificate','2014-09-17 17:38:21'),('net.carting.service.RacerServiceImpl','Leader of team Чернівецький ОЦНТТУМ added \'Racer\'s medical certificate\' to racer Tim Roth','2014-09-17 17:38:31'),('net.carting.web.DocumentController','Leader of team Чернівецький ОЦНТТУМ tried to add document Racer\'s parental permission','2014-09-17 17:38:34'),('net.carting.service.RacerServiceImpl','Leader of team Чернівецький ОЦНТТУМ added \'Racer\'s parental permission\' to racer Tim Roth','2014-09-17 17:38:50'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-17 17:38:57'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-17 18:16:12'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-18 14:26:04'),('net.carting.service.UserDetailsServiceImpl','admin had logged successfully','2014-09-18 15:41:13');
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maneuver`
--

DROP TABLE IF EXISTS `maneuver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maneuver` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maneuver`
--

LOCK TABLES `maneuver` WRITE;
/*!40000 ALTER TABLE `maneuver` DISABLE KEYS */;
INSERT INTO `maneuver` VALUES (1,'Змійка'),(2,'Коридор'),(3,'Квітка'),(7,'Коло ліве'),(9,'Коло праве'),(10,'Колія ліва'),(11,'Колія права');
/*!40000 ALTER TABLE `maneuver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `race_results`
--

DROP TABLE IF EXISTS `race_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `race_results` (
  `id` int(11) NOT NULL auto_increment,
  `car_number` int(11) NOT NULL,
  `full_laps` int(11) NOT NULL,
  `place` int(11) NOT NULL,
  `points` int(11) NOT NULL,
  `race_id` int(11) NOT NULL,
  `racer_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK9D24CC88A1B9B1AD` (`racer_id`),
  KEY `FK9D24CC88EC711227` (`race_id`),
  CONSTRAINT `FK9D24CC88A1B9B1AD` FOREIGN KEY (`racer_id`) REFERENCES `racers` (`id`),
  CONSTRAINT `FK9D24CC88EC711227` FOREIGN KEY (`race_id`) REFERENCES `races` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `race_results`
--

LOCK TABLES `race_results` WRITE;
/*!40000 ALTER TABLE `race_results` DISABLE KEYS */;
INSERT INTO `race_results` VALUES (11,8,6,1,40,4,9),(12,4,4,4,0,4,7),(13,9,5,2,0,4,8),(14,12,4,3,0,4,3),(15,12,7,1,40,5,3),(16,9,6,2,24,5,8),(17,8,5,3,0,5,9),(18,4,2,4,0,5,7),(19,1,9,1,40,6,1),(20,2,8,2,24,6,2),(21,9,7,3,0,6,6),(22,7,5,4,0,6,7),(23,7,10,1,40,7,7),(24,1,10,2,24,7,1),(25,2,9,3,11,7,2),(26,9,1,4,0,7,6),(27,1,2,1,20,8,3),(28,1,1,1,20,9,3),(29,1,1,3,12,10,1),(30,13,1,1,20,10,13),(31,2,1,2,15,10,2),(32,7,1,4,10,10,7),(33,2,2,1,20,11,2),(34,13,2,2,15,11,13),(35,1,2,3,12,11,1),(36,7,2,4,10,11,7),(37,2,1,4,10,12,2),(38,1,0,5,0,12,1),(39,7,1,1,20,12,7),(40,8,1,2,15,12,9),(41,5,0,6,0,12,21),(42,10,1,3,12,12,8),(43,2,1,4,10,13,2),(44,1,0,5,0,13,1),(45,7,1,1,20,13,7),(46,8,1,2,15,13,9),(47,5,0,6,0,13,21),(48,10,1,3,12,13,8),(49,9,1,1,20,14,5),(50,10,1,2,15,14,21),(51,9,1,1,20,15,5),(52,10,1,2,15,15,21);
/*!40000 ALTER TABLE `race_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `racer_car_class_numbers`
--

DROP TABLE IF EXISTS `racer_car_class_numbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `racer_car_class_numbers` (
  `id` int(11) NOT NULL auto_increment,
  `number` int(11) NOT NULL,
  `car_class_id` int(11) NOT NULL,
  `racer_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `racer_id` (`racer_id`,`car_class_id`),
  KEY `FK9F10E05AA1B9B1AD` (`racer_id`),
  KEY `FK9F10E05A1F1B02DE` (`car_class_id`),
  CONSTRAINT `FK9F10E05A1F1B02DE` FOREIGN KEY (`car_class_id`) REFERENCES `car_classes` (`id`),
  CONSTRAINT `FK9F10E05AA1B9B1AD` FOREIGN KEY (`racer_id`) REFERENCES `racers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `racer_car_class_numbers`
--

LOCK TABLES `racer_car_class_numbers` WRITE;
/*!40000 ALTER TABLE `racer_car_class_numbers` DISABLE KEYS */;
INSERT INTO `racer_car_class_numbers` VALUES (1,1,3,1),(2,2,3,2),(3,12,7,3),(4,1,6,3),(5,9,4,4),(6,9,2,5),(7,9,3,6),(8,5,4,6),(9,7,3,7),(10,4,7,7),(11,9,7,8),(12,8,4,8),(13,8,7,9),(14,4,4,9),(15,3,3,10),(16,21,2,11),(17,54,3,11),(19,13,3,13),(21,88,3,15),(22,55,3,16),(29,10,2,21),(30,5,3,21),(31,17,9,22),(32,8,3,9),(33,10,3,8),(34,13,4,23);
/*!40000 ALTER TABLE `racer_car_class_numbers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `racer_competition_car_class_numbers`
--

DROP TABLE IF EXISTS `racer_competition_car_class_numbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `racer_competition_car_class_numbers` (
  `id` int(11) NOT NULL auto_increment,
  `number_in_competition` int(11) NOT NULL,
  `car_class_competition_id` int(11) NOT NULL,
  `racer_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `racer_id` (`racer_id`,`car_class_competition_id`),
  KEY `FKFE2396DA7644F83B` (`car_class_competition_id`),
  KEY `FKFE2396DAA1B9B1AD` (`racer_id`),
  CONSTRAINT `FKFE2396DA7644F83B` FOREIGN KEY (`car_class_competition_id`) REFERENCES `car_class_competition` (`id`),
  CONSTRAINT `FKFE2396DAA1B9B1AD` FOREIGN KEY (`racer_id`) REFERENCES `racers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `racer_competition_car_class_numbers`
--

LOCK TABLES `racer_competition_car_class_numbers` WRITE;
/*!40000 ALTER TABLE `racer_competition_car_class_numbers` DISABLE KEYS */;
INSERT INTO `racer_competition_car_class_numbers` VALUES (4,1,2,3),(6,2,3,2),(7,1,3,1),(10,9,6,8),(11,8,6,9),(12,2,5,2),(13,12,6,3),(14,1,5,1),(15,4,6,7),(17,9,5,6),(19,7,5,7),(29,13,3,13),(31,7,3,7),(32,2,13,2),(33,5,13,21),(34,1,13,1),(36,8,13,9),(37,10,13,8),(38,7,13,7),(39,10,12,21),(40,9,12,5),(41,9,14,4),(42,13,14,23);
/*!40000 ALTER TABLE `racer_competition_car_class_numbers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `racer_document`
--

DROP TABLE IF EXISTS `racer_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `racer_document` (
  `racer_id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  PRIMARY KEY  (`racer_id`,`document_id`),
  KEY `FKADCD1BD917352767` (`document_id`),
  KEY `FKADCD1BD9A1B9B1AD` (`racer_id`),
  CONSTRAINT `FKADCD1BD917352767` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`),
  CONSTRAINT `FKADCD1BD9A1B9B1AD` FOREIGN KEY (`racer_id`) REFERENCES `racers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `racer_document`
--

LOCK TABLES `racer_document` WRITE;
/*!40000 ALTER TABLE `racer_document` DISABLE KEYS */;
INSERT INTO `racer_document` VALUES (23,2),(1,3),(23,3),(23,4),(23,5);
/*!40000 ALTER TABLE `racer_document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `racers`
--

DROP TABLE IF EXISTS `racers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `racers` (
  `id` int(11) NOT NULL auto_increment,
  `address` varchar(255) NOT NULL,
  `birthday` datetime NOT NULL,
  `document` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `registration_date` datetime NOT NULL,
  `sports_category` tinyint(1) NOT NULL,
  `team_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FKC80DE8D25CF956A7` (`team_id`),
  CONSTRAINT `FKC80DE8D25CF956A7` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `racers`
--

LOCK TABLES `racers` WRITE;
/*!40000 ALTER TABLE `racers` DISABLE KEYS */;
INSERT INTO `racers` VALUES (1,'м.Чернівці, вул.Комарова 31Г,22','1994-07-16 00:00:00','КР №772048','Максим','Лелик',1,'2014-05-15 10:24:29',4,1),(2,'м.Чернівці, вул.Головна, 285, кв.28','1986-06-26 00:00:00','КР №772048','Віталій','Вахата',1,'2014-05-15 10:27:53',4,1),(3,'м.Чернівці, вул.Сторожинецька, 60','2001-09-26 00:00:00','І-МИ № 078300','Андрій','Балашев',1,'2014-05-15 10:31:16',1,1),(4,'м. Кам\'янець-Подільський, вул. кн.Корыатовычыв 68/54','2006-02-10 00:00:00','1-БВ №023157','Даниїл','Кукурузов',1,'2014-05-15 10:36:33',0,2),(5,'м. Кам\'янець-Подільський, вул. Гагаріна 69/35','1999-01-05 00:00:00','І-БВ','Максимa','Квапиш',1,'2014-05-15 10:43:35',4,2),(6,'м. Чернівці, вул. Переяслівська 6/11 ','2009-11-19 00:00:00','КР233423','Василь','Ющенко',1,'2014-05-15 11:56:04',0,2),(7,'вул. Небесної сотні 14а','1981-03-05 00:00:00','КР3431234','Олексій ','Зарубайко',1,'2014-05-15 11:58:22',5,2),(8,'м. Чернівці, вул. Шевченко, 25','1996-11-28 00:00:00','ра12342','Сергій','Надольський',1,'2014-05-28 10:55:14',1,3),(9,'м. Чернівці, вул. Ентузіастів, 5','1995-08-18 00:00:00','ке342344545','Павло','Мурзенко',1,'2014-05-28 10:57:24',2,3),(10,'м. Стрий, вул.1 Листопада 16А, кв. 3','1993-08-19 00:00:00','КС 729066','Олег','Карман',1,'2014-05-28 18:19:02',1,4),(11,'м. Стрий, вул. Б. Хмельницького, 21, 3','1998-07-08 00:00:00','1-СГ №158340','Марко','Лисак',1,'2014-05-28 18:20:26',0,4),(13,'Vsdf','2014-06-02 00:00:00','Vdf','Vfvdfv','Vdfsvdfv',1,'2014-06-03 13:59:02',2,5),(15,'пПвапва','1990-01-23 00:00:00','Пвапва','Піап','Пвапвап',1,'2014-06-04 13:26:17',0,13),(16,'Gdsfgfs','1992-03-12 00:00:00','Gdfgfds','Fsdggg','Gsfgfdsgds',1,'2014-06-04 14:04:40',1,13),(21,'м. Чернівці','1995-07-12 00:00:00','97NYY7MNH','Петро','Іванов',1,'2014-06-13 17:17:53',1,1),(22,'uu','2012-12-01 00:00:00','uuu','Dima','Pima',1,'2014-08-05 14:32:52',5,14),(23,'Chernivtsi','2007-06-12 00:00:00','8675970','Tim','Roth',1,'2014-09-17 16:54:05',0,1);
/*!40000 ALTER TABLE `racers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `races`
--

DROP TABLE IF EXISTS `races`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `races` (
  `id` int(11) NOT NULL auto_increment,
  `number_of_laps` int(11) NOT NULL,
  `number_of_members` int(11) NOT NULL,
  `race_number` int(11) NOT NULL,
  `result_sequance` varchar(255) NOT NULL,
  `car_class_id` int(11) NOT NULL,
  `car_class_competition_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK6740FC27644F83B` (`car_class_competition_id`),
  KEY `FK6740FC21F1B02DE` (`car_class_id`),
  CONSTRAINT `FK6740FC21F1B02DE` FOREIGN KEY (`car_class_id`) REFERENCES `car_classes` (`id`),
  CONSTRAINT `FK6740FC27644F83B` FOREIGN KEY (`car_class_competition_id`) REFERENCES `car_class_competition` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `races`
--

LOCK TABLES `races` WRITE;
/*!40000 ALTER TABLE `races` DISABLE KEYS */;
INSERT INTO `races` VALUES (4,7,4,1,'12 4 8 9 8 4 8 9 12 12 4 8 9 8 9 8 9 12 4',7,6),(5,7,4,2,'12 9 8 4 12 9 8 8 12 9 4 8 12 9 12 8 12 9 12 9',7,6),(6,10,4,1,'1 7 2 9 2 9 1 7 2 1 9 7 2 9 1 2 9 1 7 2 9 2 9 1 1 1 1 2 7',3,5),(7,10,4,2,'2 9 1 7 1 2 7 1 2 7 1 2 7 7 2 1 7 2 1 7 2 7 2 1 7 2 1 1 7 1',3,5),(8,2,1,1,'1 1',6,2),(9,1,1,2,'1',6,2),(10,1,4,1,'13 2 1 7',3,3),(11,2,4,2,'13 2 1 7 2 13 1 7',3,3),(12,1,6,1,'7 8 10 2',3,13),(13,1,6,2,'7 8 10 2',3,13),(14,1,2,1,'9 10',2,12),(15,1,2,2,'9 10',2,12);
/*!40000 ALTER TABLE `races` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(6) unsigned NOT NULL auto_increment,
  `role` varchar(25) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'ROLE_ADMIN'),(2,'ROLE_TEAM_LEADER');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team_in_competition`
--

DROP TABLE IF EXISTS `team_in_competition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `team_in_competition` (
  `id` int(11) NOT NULL auto_increment,
  `competition_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `team_id` (`team_id`,`competition_id`),
  KEY `FK6C8DF3C7ED6F4EAD` (`competition_id`),
  KEY `FK6C8DF3C75CF956A7` (`team_id`),
  CONSTRAINT `FK6C8DF3C75CF956A7` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`),
  CONSTRAINT `FK6C8DF3C7ED6F4EAD` FOREIGN KEY (`competition_id`) REFERENCES `competitions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_in_competition`
--

LOCK TABLES `team_in_competition` WRITE;
/*!40000 ALTER TABLE `team_in_competition` DISABLE KEYS */;
INSERT INTO `team_in_competition` VALUES (2,2,1),(11,4,1),(10,1,2),(3,2,2),(13,4,2),(1,2,3),(12,4,3),(7,2,4),(8,1,5);
/*!40000 ALTER TABLE `team_in_competition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teams`
--

DROP TABLE IF EXISTS `teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teams` (
  `id` int(11) NOT NULL auto_increment,
  `address` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `leader_id` int(11) NOT NULL,
  `license` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK69209B64530F7E7` (`leader_id`),
  CONSTRAINT `FK69209B64530F7E7` FOREIGN KEY (`leader_id`) REFERENCES `leaders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams`
--

LOCK TABLES `teams` WRITE;
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
INSERT INTO `teams` VALUES (1,'м.Чернівці, вул.Мамаївська.6','Чернівецький ОЦНТТУМ',1,NULL),(2,'м. Кам\'янець-Подільський, вул. Грушевського 74/524','Філія ХОЦНТТУМ м. Кам\'янець-Подільський',2,NULL),(3,'м. Чернівці','Чернівецькі яструби',3,NULL),(4,'м. Стрий, вул. Бандери, 12 , кв.6','Львівський ОЦНТТУМ',4,NULL),(5,'Adress','My Team',5,'E565'),(13,'пПапвап','АПП',8,'Пвапвап'),(14,'fafa','Super Command',15,'123412'),(16,'Чернівці, вул Комарова 19/21, кв. №56','Com',14,'AS №123456');
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `username` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `password` varchar(255) default NULL,
  `role_id` int(11) unsigned NOT NULL,
  `email` varchar(45) NOT NULL,
  `reset_pass_link` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK_users_roles` (`role_id`),
  CONSTRAINT `FK_users_roles` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin',1,'8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918',1,'',NULL),(4,'roman',1,'4eaae75f1df2f52bda44f6b18a400542d51c81bd7c00b0e720be5dc2c997575d',2,'',NULL),(6,'team1',1,'03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4',2,'',NULL),(7,'team2',1,'03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4',2,'',NULL),(8,'team4',1,'03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4',2,'',NULL),(9,'test',1,'0ffe1abd1a08215353c233d6e009613e95eec4253832a761af28ff37ac5a150c',2,'',NULL),(10,'test1',0,'0ffe1abd1a08215353c233d6e009613e95eec4253832a761af28ff37ac5a150c',2,'',NULL),(13,'alex',0,'96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e',2,'',NULL),(14,'tem',0,'96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e',2,'',NULL),(15,'demo',1,'96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e',2,'',NULL),(16,'tester',1,'96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e',2,'',NULL),(18,'kolio',0,'5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5',2,'kolio5991@gmail.com','682c5d12b454444f10e3660f3e1317434e93eabc9b58747552d05a642cdb45bc');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-09-18 15:45:22
