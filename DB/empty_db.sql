CREATE DATABASE  IF NOT EXISTS `carting` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `carting`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: localhost    Database: carting
-- ------------------------------------------------------
-- Server version	5.6.16-log

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
-- Table structure for table `admin_settings`
--

DROP TABLE IF EXISTS `admin_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `feedback_email` varchar(255) NOT NULL,
  `parental_permission_years` int(11) NOT NULL,
  `points_by_places` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `circle_count` int(11) NOT NULL,
  `first_race_time` time NOT NULL,
  `percentage_offset` int(11) NOT NULL,
  `second_race_time` time NOT NULL,
  `car_class_id` int(11) NOT NULL,
  `competition_id` int(11) NOT NULL,
  `firstStartStatement_id` int(11) DEFAULT NULL,
  `maneuverStatement_id` int(11) DEFAULT NULL,
  `secondStartStatement_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_nb274j9dtxiirc0brf8kloo8e` (`car_class_id`),
  KEY `FK_6r7hpfh61mlpg6s4oupe0t93j` (`competition_id`),
  KEY `FK_86vgt7gayxcp27iyvrjoa4kyv` (`firstStartStatement_id`),
  KEY `FK_fxmxj9djp8kkv67us4ympkfa5` (`maneuverStatement_id`),
  KEY `FK_15djw7l2spkwebv78rmuyvfh6` (`secondStartStatement_id`),
  CONSTRAINT `FK_15djw7l2spkwebv78rmuyvfh6` FOREIGN KEY (`secondStartStatement_id`) REFERENCES `files` (`id`),
  CONSTRAINT `FK_6r7hpfh61mlpg6s4oupe0t93j` FOREIGN KEY (`competition_id`) REFERENCES `competitions` (`id`),
  CONSTRAINT `FK_86vgt7gayxcp27iyvrjoa4kyv` FOREIGN KEY (`firstStartStatement_id`) REFERENCES `files` (`id`),
  CONSTRAINT `FK_fxmxj9djp8kkv67us4ympkfa5` FOREIGN KEY (`maneuverStatement_id`) REFERENCES `files` (`id`),
  CONSTRAINT `FK_nb274j9dtxiirc0brf8kloo8e` FOREIGN KEY (`car_class_id`) REFERENCES `car_classes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car_class_competition`
--

LOCK TABLES `car_class_competition` WRITE;
/*!40000 ALTER TABLE `car_class_competition` DISABLE KEYS */;
/*!40000 ALTER TABLE `car_class_competition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `car_class_competition_results`
--

DROP TABLE IF EXISTS `car_class_competition_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `car_class_competition_results` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `absolute_place` int(11) DEFAULT NULL,
  `absolute_points` int(11) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `race2_points` int(11) DEFAULT NULL,
  `racer_competition_carclass_number_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_h7fd0yi3mxkajhqmqoninig8l` (`racer_competition_carclass_number_id`),
  CONSTRAINT `FK_h7fd0yi3mxkajhqmqoninig8l` FOREIGN KEY (`racer_competition_carclass_number_id`) REFERENCES `racer_competition_car_class_numbers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car_class_competition_results`
--

LOCK TABLES `car_class_competition_results` WRITE;
/*!40000 ALTER TABLE `car_class_competition_results` DISABLE KEYS */;
/*!40000 ALTER TABLE `car_class_competition_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `car_classes`
--

DROP TABLE IF EXISTS `car_classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `car_classes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lower_years_limit` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `upper_years_limit` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_61vwd433ui2o72tn7klmw4fi4` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car_classes`
--

LOCK TABLES `car_classes` WRITE;
/*!40000 ALTER TABLE `car_classes` DISABLE KEYS */;
/*!40000 ALTER TABLE `car_classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `competitions`
--

DROP TABLE IF EXISTS `competitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `competitions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `calculate_by_table_b` tinyint(1) NOT NULL,
  `date_end` date NOT NULL,
  `date_start` date NOT NULL,
  `director_category_judicial_license` varchar(255) NOT NULL,
  `director_name` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `first_race_date` date NOT NULL,
  `name` varchar(255) NOT NULL,
  `place` varchar(255) NOT NULL,
  `points_by_places` varchar(255) NOT NULL,
  `second_race_date` date NOT NULL,
  `secretary_category_judicial_license` varchar(255) NOT NULL,
  `secretary_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `competitions`
--

LOCK TABLES `competitions` WRITE;
/*!40000 ALTER TABLE `competitions` DISABLE KEYS */;
/*!40000 ALTER TABLE `competitions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documents` (
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
  KEY `FK_fjxkebr8fk99f0sudys50iusg` (`team_id`),
  CONSTRAINT `FK_fjxkebr8fk99f0sudys50iusg` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file` tinyblob NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `document_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_a3tl842t0adqnii9pa90qmixn` (`document_id`),
  CONSTRAINT `FK_a3tl842t0adqnii9pa90qmixn` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) NOT NULL,
  `birthday` datetime NOT NULL,
  `document` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `registration_date` datetime NOT NULL,
  `license` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_gouit62378kdl0ewg2tgwyp2u` (`user_id`),
  CONSTRAINT `FK_gouit62378kdl0ewg2tgwyp2u` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leaders`
--

LOCK TABLES `leaders` WRITE;
/*!40000 ALTER TABLE `leaders` DISABLE KEYS */;
/*!40000 ALTER TABLE `leaders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs` (
  `message` varchar(255) NOT NULL,
  `date` varchar(255) DEFAULT NULL,
  `level` varchar(255) DEFAULT NULL,
  `logger` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`message`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qualifying`
--

DROP TABLE IF EXISTS `qualifying`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qualifying` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `racer_number` int(11) DEFAULT NULL,
  `racer_place` int(11) DEFAULT NULL,
  `racer_time` time DEFAULT NULL,
  `car_class_competition_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_40ao1aa17ay9o5kkxvgdnyety` (`car_class_competition_id`),
  CONSTRAINT `FK_40ao1aa17ay9o5kkxvgdnyety` FOREIGN KEY (`car_class_competition_id`) REFERENCES `car_class_competition` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qualifying`
--

LOCK TABLES `qualifying` WRITE;
/*!40000 ALTER TABLE `qualifying` DISABLE KEYS */;
/*!40000 ALTER TABLE `qualifying` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `race_results`
--

DROP TABLE IF EXISTS `race_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `race_results` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `car_number` int(11) NOT NULL,
  `full_laps` int(11) NOT NULL,
  `place` int(11) NOT NULL,
  `points` int(11) NOT NULL,
  `race_id` int(11) NOT NULL,
  `racer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_pg060edhuojls2imlle6vfvgx` (`race_id`),
  KEY `FK_bnlwrwxe21okoqsi2fa2i9ejn` (`racer_id`),
  CONSTRAINT `FK_bnlwrwxe21okoqsi2fa2i9ejn` FOREIGN KEY (`racer_id`) REFERENCES `racers` (`id`),
  CONSTRAINT `FK_pg060edhuojls2imlle6vfvgx` FOREIGN KEY (`race_id`) REFERENCES `races` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `race_results`
--

LOCK TABLES `race_results` WRITE;
/*!40000 ALTER TABLE `race_results` DISABLE KEYS */;
/*!40000 ALTER TABLE `race_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `racer_car_class_numbers`
--

DROP TABLE IF EXISTS `racer_car_class_numbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `racer_car_class_numbers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` int(11) NOT NULL,
  `car_class_id` int(11) NOT NULL,
  `racer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_itokcl59838mv57q0at9t7ds5` (`racer_id`,`car_class_id`),
  KEY `FK_jf41xfqi8tu4myqd5ogjt7g5r` (`car_class_id`),
  CONSTRAINT `FK_dq7i7gr689hgn6g9etcyjl2n3` FOREIGN KEY (`racer_id`) REFERENCES `racers` (`id`),
  CONSTRAINT `FK_jf41xfqi8tu4myqd5ogjt7g5r` FOREIGN KEY (`car_class_id`) REFERENCES `car_classes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `racer_car_class_numbers`
--

LOCK TABLES `racer_car_class_numbers` WRITE;
/*!40000 ALTER TABLE `racer_car_class_numbers` DISABLE KEYS */;
/*!40000 ALTER TABLE `racer_car_class_numbers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `racer_competition_car_class_numbers`
--

DROP TABLE IF EXISTS `racer_competition_car_class_numbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `racer_competition_car_class_numbers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number_in_competition` int(11) NOT NULL,
  `car_class_competition_id` int(11) NOT NULL,
  `racer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_189a1jno6ncsmry4i5pmuukv4` (`racer_id`,`car_class_competition_id`),
  KEY `FK_rohkqpg2aofiufrt1ntbcdy9b` (`car_class_competition_id`),
  CONSTRAINT `FK_s6ejila4cdbi1qfad9gokrqx9` FOREIGN KEY (`racer_id`) REFERENCES `racers` (`id`),
  CONSTRAINT `FK_rohkqpg2aofiufrt1ntbcdy9b` FOREIGN KEY (`car_class_competition_id`) REFERENCES `car_class_competition` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `racer_competition_car_class_numbers`
--

LOCK TABLES `racer_competition_car_class_numbers` WRITE;
/*!40000 ALTER TABLE `racer_competition_car_class_numbers` DISABLE KEYS */;
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
  PRIMARY KEY (`racer_id`,`document_id`),
  KEY `FK_mm7myrk983fepbkqtcwkuqbvs` (`document_id`),
  CONSTRAINT `FK_lkysh75dxs6o00cvf4p1pqeli` FOREIGN KEY (`racer_id`) REFERENCES `racers` (`id`),
  CONSTRAINT `FK_mm7myrk983fepbkqtcwkuqbvs` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `racer_document`
--

LOCK TABLES `racer_document` WRITE;
/*!40000 ALTER TABLE `racer_document` DISABLE KEYS */;
/*!40000 ALTER TABLE `racer_document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `racers`
--

DROP TABLE IF EXISTS `racers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `racers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) NOT NULL,
  `birthday` datetime NOT NULL,
  `document` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `registration_date` datetime NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `sports_category` tinyint(1) NOT NULL,
  `team_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_l8yl7g3yflhvexq5af3rpwha2` (`team_id`),
  CONSTRAINT `FK_l8yl7g3yflhvexq5af3rpwha2` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `racers`
--

LOCK TABLES `racers` WRITE;
/*!40000 ALTER TABLE `racers` DISABLE KEYS */;
/*!40000 ALTER TABLE `racers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `races`
--

DROP TABLE IF EXISTS `races`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `races` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number_of_laps` int(11) NOT NULL,
  `number_of_members` int(11) NOT NULL,
  `race_number` int(11) NOT NULL,
  `result_sequance` varchar(255) NOT NULL,
  `car_class_id` int(11) NOT NULL,
  `car_class_competition_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_k83g02okn2ly90b5to6m4pq6l` (`car_class_id`),
  KEY `FK_gcj8me386df0r4dluqvgpmf4f` (`car_class_competition_id`),
  CONSTRAINT `FK_gcj8me386df0r4dluqvgpmf4f` FOREIGN KEY (`car_class_competition_id`) REFERENCES `car_class_competition` (`id`),
  CONSTRAINT `FK_k83g02okn2ly90b5to6m4pq6l` FOREIGN KEY (`car_class_id`) REFERENCES `car_classes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `races`
--

LOCK TABLES `races` WRITE;
/*!40000 ALTER TABLE `races` DISABLE KEYS */;
/*!40000 ALTER TABLE `races` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `competition_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_2sct8f05ky4httfye2m8n8dip` (`team_id`,`competition_id`),
  KEY `FK_2kbi18om02a4qymq4yn2v4ho2` (`competition_id`),
  CONSTRAINT `FK_arymsm29jr70sjthn096oagii` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`),
  CONSTRAINT `FK_2kbi18om02a4qymq4yn2v4ho2` FOREIGN KEY (`competition_id`) REFERENCES `competitions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_in_competition`
--

LOCK TABLES `team_in_competition` WRITE;
/*!40000 ALTER TABLE `team_in_competition` DISABLE KEYS */;
/*!40000 ALTER TABLE `team_in_competition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teams`
--

DROP TABLE IF EXISTS `teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) NOT NULL,
  `license` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `leader_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_4vcar0vmlgrql0w7fob2t33so` (`leader_id`),
  CONSTRAINT `FK_4vcar0vmlgrql0w7fob2t33so` FOREIGN KEY (`leader_id`) REFERENCES `leaders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams`
--

LOCK TABLES `teams` WRITE;
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `reset_pass_link` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_krvotbtiqhudlkamvlpaqus0t` (`role_id`),
  CONSTRAINT `FK_krvotbtiqhudlkamvlpaqus0t` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'',1,'8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918',NULL,'admin',1);
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

-- Dump completed on 2014-09-01 15:26:02
