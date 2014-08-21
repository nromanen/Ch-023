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
-- Table structure for table `authorities`
--

DROP TABLE IF EXISTS `authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authorities` (
  `username` varchar(255) NOT NULL,
  `authority` varchar(255) default NULL,
  PRIMARY KEY  (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authorities`
--

LOCK TABLES `authorities` WRITE;
/*!40000 ALTER TABLE `authorities` DISABLE KEYS */;
/*!40000 ALTER TABLE `authorities` ENABLE KEYS */;
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
  PRIMARY KEY  (`id`),
  KEY `FKC7F8C1CDED6F4EAD` (`competition_id`),
  KEY `FKC7F8C1CD1F1B02DE` (`car_class_id`),
  CONSTRAINT `FKC7F8C1CD1F1B02DE` FOREIGN KEY (`car_class_id`) REFERENCES `car_classes` (`id`),
  CONSTRAINT `FKC7F8C1CDED6F4EAD` FOREIGN KEY (`competition_id`) REFERENCES `competitions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car_class_competition`
--

LOCK TABLES `car_class_competition` WRITE;
/*!40000 ALTER TABLE `car_class_competition` DISABLE KEYS */;
INSERT INTO `car_class_competition` VALUES (1,6,'16:05:00',75,'12:40:00',7,1),(2,6,'15:20:00',75,'12:00:00',6,1),(3,10,'15:00:00',75,'11:40:00',3,1),(5,7,'11:30:00',75,'14:00:00',3,2),(6,7,'12:30:00',75,'15:30:00',7,2),(8,4,'15:30:00',75,'16:20:00',1,2),(9,5,'11:00:00',80,'12:00:00',1,1),(10,5,'11:00:00',80,'12:00:00',2,1);
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
  PRIMARY KEY  (`id`),
  KEY `FK706F8784CA0A6B84` (`racer_competition_carclass_number_id`),
  CONSTRAINT `FK706F8784CA0A6B84` FOREIGN KEY (`racer_competition_carclass_number_id`) REFERENCES `racer_competition_car_class_numbers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car_class_competition_results`
--

LOCK TABLES `car_class_competition_results` WRITE;
/*!40000 ALTER TABLE `car_class_competition_results` DISABLE KEYS */;
INSERT INTO `car_class_competition_results` VALUES (7,2,40,'Ğ±ĞµĞ· ÑˆÑ‚Ñ€Ğ°Ñ„Ñƒ',40,13),(8,4,0,'2 Ğ·Ğ° Ğ¼Ğ°Ğ½ĞµĞ²Ñ€ÑƒĞ²Ğ°Ğ½Ğ½Ñ',0,15),(9,1,40,'Ğ±ĞµĞ· ÑˆÑ‚Ñ€Ğ°Ñ„Ñƒ',0,11),(10,3,24,'Ğ±ĞµĞ· ÑˆÑ‚Ñ€Ğ°Ñ„Ñƒ',24,10),(11,3,35,'Ğ±ĞµĞ· ÑˆÑ‚Ñ€Ğ°Ñ„Ñƒ',11,12),(12,4,0,'10 Ğ·Ğ° ĞºÑ€Ğ°ÑĞ¸Ğ²Ñ‹Ğµ Ğ³Ğ»Ğ°Ğ·Ğ°',0,17),(13,1,64,'-5 Ğ·Ğ° Ñ‚Ğ°Ñ€Ğ°Ğ½ ĞºĞ°Ñ€Ñ‚Ñƒ â„–1',24,14),(14,2,40,'Ğ±ĞµĞ· ÑˆÑ‚Ñ€Ğ°Ñ„Ñƒ',40,19),(15,1,0,'Ğ±ĞµĞ· ÑˆÑ‚Ñ€Ğ°Ñ„Ñƒ',0,4);
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
INSERT INTO `car_classes` VALUES (1,12,'ĞŸĞ¾Ğ¿ÑƒĞ»ÑÑ€Ğ½Ğ¸Ğ¹-Ğ®Ğ½Ğ°ĞºĞ¸',17),(2,15,'ĞšĞ°Ğ´ĞµÑ‚',99),(3,15,'ĞŸĞ¾Ğ¿ÑƒĞ»ÑÑ€Ğ½Ğ¸Ğ¹',99),(4,6,'ĞŸÑ–Ğ¾Ğ½ĞµÑ€ Ğ-Ğ¼Ñ–Ğ½Ñ–',9),(6,6,'ĞŸÑ–Ğ¾Ğ½ĞµÑ€ Ğ‘',13),(7,9,'ĞŸÑ–Ğ¾Ğ½ĞµÑ€ Ğ',13),(8,5,'dgfhdsgh',8),(9,16,'ICA',98);
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
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `competitions`
--

LOCK TABLES `competitions` WRITE;
/*!40000 ALTER TABLE `competitions` DISABLE KEYS */;
INSERT INTO `competitions` VALUES (1,'2014-06-30','2014-06-28','ĞĞš','ĞœĞ˜Ğ ĞĞĞĞ’ Ğ’.Ğ†.',0,'2014-06-28','Ğ’Ğ¡Ğ•Ğ£ĞšĞ ĞĞ‡ĞĞ¡Ğ¬ĞšĞ† Ğ—ĞœĞĞ“ĞĞĞĞ¯ Ğ— ĞšĞĞ Ğ¢Ğ˜ĞĞ“Ğ£ Ğ¡Ğ•Ğ Ğ•Ğ” Ğ£Ğ§ĞĞ†Ğ’Ğ¡Ğ¬ĞšĞĞ‡ ĞœĞĞ›ĞĞ”Ğ† 2014 Ñ€Ğ¾ĞºÑƒ (Ñ„Ñ–Ğ½Ğ°Ğ»ÑŒĞ½Ğ¸Ğ¹ ĞµÑ‚Ğ°Ğ¿)','Ğ¼.ĞšĞ°Ğ¼\'ÑĞ½ĞµÑ†ÑŒ-ĞŸĞ¾Ğ´Ñ–Ğ»ÑŒÑÑŒĞºĞ¸Ğ¹','2014-06-30','ĞĞš','Ğ Ğ˜Ğ‘ĞĞ›ĞšĞ Ğ›.Ğ.',0,'20,15,12,10,8,6,3,3,1'),(2,'2014-05-29','2014-05-28','ĞĞš','ĞœĞ˜Ğ ĞĞĞĞ’ Ğ’.Ğ†.',1,'2014-05-28','Ğ§ĞµĞ¼Ğ¿Ñ–Ğ¾Ğ½Ğ°Ñ‚ Ğ§ĞµÑ€Ğ½Ñ–Ğ²ĞµÑ†ÑŒĞºĞ¾Ñ— Ğ¾Ğ±Ğ»Ğ°ÑÑ‚Ñ– (Ğ²ĞµÑĞ½Ğ° 2014 Ñ€Ğ¾ĞºÑƒ)','Ğ¼. Ğ§ĞµÑ€Ğ½Ñ–Ğ²Ñ†Ñ–','2014-05-28','ĞĞš','Ğ Ğ˜Ğ‘ĞĞ›ĞšĞ Ğ›.Ğ.',1,'28,15,12,10,9,8,5,4,1'),(3,'2015-07-17','2015-07-16','dsgfsd','Gdsfgdf',0,'2014-06-06','Test','Test','2014-06-07','dfgdsf','Gdgdf',0,'20,15,12,10,8,6,3,3,1');
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
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
INSERT INTO `documents` VALUES (10,1,1,'2014-08-29 00:00:00','werwer','',NULL,2);
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
  `document_id` int(11) NOT NULL,
  `file` longblob,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK5CEBA7717352767` (`document_id`),
  CONSTRAINT `FK5CEBA7717352767` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
INSERT INTO `files` VALUES (8,10,'‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0ò\0\0\0ôE`\0\0ÿÿIDATxÚì]€EŸ}qwtÇİÒ¶”¨p„…‚\"J7R*¨t+HªŸt[((r\\ĞÍåÛı&vgggg÷í{wÇ²åİììôNşæ÷Ÿ‘Ö¯û\0E’$\0ERà?øP\0~D–Ø\n=@tç‘ # ¿Ø`+,\nr*á ` ğQ!–è†£ =\näE‚Ç ¬¨‰Qğ3ñF’…âÇITk&5ñœ­QB²··4¿ÕrªCzêÀ¡\Z»MÙò±¡az¸_.af›0D˜GşW–eş‹~p]Dõ°¾I¶rÙFk>9²š£%/òe“œ²AEÇØÀÎ„-UÜI¨nH! öS¡ÅåõxPEÀƒº,­ÛjG—«v[°Š67s3Ì¨¯š8é²\\É?B¿—ÄXÑGÚrĞÚ6ĞÔ¶­ôV©6eu&`ìµ`©¦­¶mÕLæ(´?‘$‹ˆtQÛŒmdªÙ”=ÿÚÄHäPQ)s‡æ\\hëgÒ‡l ƒ¢bšíÍB“ ÷µú\'£å¦çK+nº`UI¸l³NL_CÒg 4“@ïøÔ<ÚˆÌ¸Ğ?% _†fÜ8—¡	¨Sf,bµÿ´™*S ‚\"ú†êw2Õ@cõWÈl€ÍºšJ èAhş\r¥i¨kŸ¶„(|{0§’Ë˜>Sç*Û\'p¿à:rcÈ¶šT\rf÷öfÉ©ogì($Á[‹g‰{©ÕuÅÊ¯MÑ©ÿÌó`Q¾Ñ±Ö bÂ\n°,‚•[HåoÈdÊ£¨§–€°\n(Ü(hG´èÌ1\Z»#ÉÔiA+ÁòJÉ…Pª¡¶Ó°WâAµ´êTm:[®7vb–D=<}„R®\\¹ñCú._¾üäÉ“fØÄ>a\\ğ·xñâ‹-êß¿RR’8ıtò¢Ú3SE0dÁ\0?eB‡^ı.ı=÷Bö^µ)>ìÌƒÿ@ö LZÕBa&äü_ÆaP3ü\r`/2~ÄíK\n( à\r•F½ôÒËsmÛ¶Yşé((uÎ9\Z‰OøXGğ< ArZ¿¢M	â¦:C¿\Z§9ÂÓ\'ÀZÒœ)Ì¬LQ•”¥Ä6TZêŠîQØfxkEĞÖm=ˆ,mÆ<¡eP÷Î±¼ ¡QØ}eÕ8…bß	Ñ:ó¯/0B#rÒß	f²€ÿ²22²ÒRSÓ22™€\"“™¹æÒ08’üiÙœhÏã¢Fì†Ì½©–ë«”B¡\rlµ¹év¨ÚÃ0%¦­ÕÖ¯B¯ßWòxıŞ¨ˆˆ¨\"\"|×ëñXÁvùğ²AğÍ¿ù-ñWM®áehe{­ˆÄü£6!\0ŠtğKudµp7„Æo(Z9Ñ®ìt¼Î Œ;Àâ-zŸƒ%8àK`rÈaB4Âq6 :&Ú_°Ññ,İÌÀ=Ú³6é2ïyè‚ƒ˜Küâ˜]‘Òù\Z»hâa#Ñ*Z°Ş¦Ùc{ºà˜^êˆyiaX‚2°™<c0^Áw%%aÑç*\\ş¸E½·Ñ*¨wßÆ”áGõÑP.Ü²™/Tc\'iZ¢VÙX×~Ce4\"Âé¨¹³rœ¯$Ÿ­a¬h„³wûÉ|Æ§4¡İŞKºRÓæ\0ŸGıd§BÔ½‹E±3IÜø †& DÌÙtö±Œ›Mg,@ùÍÅŒˆ¡?‘LÏvÅdğî°ÚÙT3Š`ØSÉ±O-mk2•­Gg!A~fXü–)SfÂ°g—/_~âÄ	6p‚Ù±€İÂ…Ÿ{î9\nØ1›±hi©Í	õ\00Š _:„Ò×0ÀÏ¦¾×»ï¥¿{„Í!ï2Áì´G\ná!‹ò¡8Ã¢Œ®¨	NGÆVÕ!ğNÁ@\'ê†*#&M~mÁb°ûò{\nØA“‡ÏÔ(¤®“ÉÌ…ĞL@ö(‘µŠß‘W²¢Ö9\nÒiS&\\á¯¬ĞHÖxyÄ-yQNÅjàgBY[q2°±66ÚuŠ-ÏìØ‰35Øà›>N¹9;Â4æ‹¶0„õ(c	—\\‰ğGÔ»µfíj•‹)\\¨pAŸÇã÷Ã¯9;®Íuk+OffV–,_¾tåÂ¥Ëñ‡şÙ÷ÛŸ™…,T¨¡va‹È?Ssac´yÌoéIòá\"-·VQÚƒ]+ÂÎ­6}M,Ì\r%ãñm·ÄÄ©Cd¨ùÂ¹‡À:§;[W˜#[‰ƒëŒ(“¤ï0°¹Ô .Ò,Â„”&ÿvŸÀŒ˜3ò·tò \"¨c¤“YMñ_Tƒ\\õ¹2»c-L“(µ á*ÖŒ*ÀrÇ¾ôOæô¿ÌDÜ0IU#ë>_aXeê¢dÁ;æŸè“ğ1\ZjâR‹]…±€Ÿb™;ì\'_b@ËÙ8«4dÁ†ègh†HmóÎ•¹\0¨71;l>SŞJşXƒnóÛ8:…°Ï~ö¿—\0âº=K¶¾,Ü›2hø,‘Bì~‚vÀ1f‚Ãvêªß`gŒ+›€)_ŠÀ¬8ş4¯vuF8¶æƒî%Ça;³HÎÆÌÙØ£xæN¾téÒ5À‚t¦|Y…\n„a/^|Ş¼y/¼ğBbb\";ÿ\"›¶_|õÃÎ]¿ËªQÃ[¸ÿnãÎàú—FÇõéá÷}ĞRé<*Î‹+^¼ZKğJ†T±‰`”FÒÆP™@j\ZH§¨Ü:L©#àŒùwz,\\é¦áS&¿¾xùö­°ûæëï°G´Ñ­h³K…âÍÚ•’üõFM°=£“4Sö*Ì†¤@]*«ã<-~ªÓbPG{YÛ@*ÑÏĞkèŸV’ØÙŒ¤PG\Z³Øì#±}ˆhü£E¥\r3<8/mÖ3¡ÚÛÄeX¼`;À,hømºlNkh€@ÖåË©.\\ˆ.ßæ&c¢QKcfVF[<ù\nåJ^	®Ûóõû°Í^I:–œòÍÛ%/R¤H¡B¼^_~Æìl¶ÄÍPÃ­rZ8y¹ë]à\'ÈÊ\nø|ŞÜ«lÜGÎf<&”‚‡¿˜õ70¢s:4GÑ3ÇFT¹E€Zd:sü²PN3\"vÀØñQ1èg.Œ()ÏªğÌÉp.ÆU‹,Šÿc³k]®u¦LqscîGr3TÃC€¡ä’/K5v€Ãë€ÁÚâë™–taÈÁ³Ô#õ¢Wl«,	ÑA&f®4ŒÙã>*ÅWÙ_&{:¶h €\Z–ßŠf·4İ+aëàî\"Á–YàŠ!`Ì5,_PùdbRòœ/—BšBä¬peÖRì”}r€–‰}[´İ8£< ;$˜\Zˆ¶]Áøô/â.\'H^m;#(H1S ìT“bzÁÅª›)Ã ¢yRôÍ˜EAˆ°»üØ“„Ú¿]ØÎæUH^XÀnÂ°~K–,III±J¶	¶ö—,YrşüùÏ?ÿ|bb\"Ğ¦„\r€ÿM™öŞª\nK©Ë£}ÇéIv2Ù¶$ö%J”øßK#Û÷pö—*0\'©d:¤âtD+[*X%VÂG¯H+ş<ñsâÎŠ=^³üGR6;¯Ù}´z9e¨$;U–bvèQ£ÚIømÁ*5GNòæ²*`÷Ã·	\"‡š³dØ\nÕ[7nx|–“!nôÀ;`˜tcüJRÁ8@»•5 kä=Òâğ\0€Ï­Ì|Û\0­¥iD÷GIL\n¯~@§,\0€0#¨ˆ_…”u\Z¸¹cP_P{¡q¦0ÔÒŠÑcæÖ¥Ú…-$ğ@ ëì¹óW®¤v»ÿ¦*³š¶„¨ÚBù)fäÑµ¹ÎmØêA*êÖâó€Ãÿ$|´şë¨¨È’%Š1»ü3/ölÿ=z]ş—œ_@J 3#Ëásªõ‘£â¼—Rš=à00†X&™ôD\r˜š†g•H.:f’gE©3“ëŒ”`C<à` `ZÜ˜\0ƒ%œƒÚPAlê•-EBÏuÆÔ3t²İ˜‘‘éğ3>Ãz“ã\n¿²EúÃ_vr	lÜñ¡\Z§c¶l3#ÙÎÄ,4ƒH¦Â,ö÷y˜úÃeG ªXÄf]„æ¶hà¶	\0;İØ±+[¶¦³0£€*£E	˜\nÅ¡æ)Â?VÀ”»€£!Dñ„¾òäóáÕ!3Î~qÕ`;«Ù\\fl%Ë7ÀÎ›Sc_¯H²Í2 EìÇn7€Íì\\ç–€]p´NœM1æf.2ÁÀ¤<ô<)@äÔ„ái&áj7Xfò“„ÑÅ9\'åX¡VÂ@è€©ogK•*5qX¿…;vÌ*yÌ&¬£¼—)SfŞ¼yü÷ß±\r:áş~ûı–½ûâ­<®Zña—Gû\ZŞÃu2&rÈd:ùå‹ÃÛ÷pfÏ6I«(>ü‡Àvºb¬ŠÖ©\Z²01ƒ¶&R|†GLáŸ“.±63›W ¨Áì0T‡9m€U‰Eø¼\nW«3bêÔ¯Ş¾m²Ûøãfê!ÑZ¡¿Ñ¡Şó€íYçÜ1ßŸG:9JUk¥çÙQÔÏ0P4K í”¬B«=ãğÉÖ;¤ÚÌlÂ‹èd‹V~$)èX²ä8û )¶\nÖÆ£S$ŞÂL–­¡º°x\Z,NŸ>Mıê\\¨p‘ôÌ\0¢ªz½\\ÈÂ1\\†\\×`Ì0køào¤ß{åò¥®VP]ÂãñæÃµ›#ó£‹Ùq’o¿ e‚”™ét|NKşÈ3‚\Z:^eĞ‡Õ÷ù˜&i„ˆt1ÃdšÉ®dz¦QÓ­D#ÖbC12\0^ú>ã“Yšaµ38•3qT5Ø©‘Ñl:(ÆZÇ¯8y`Å’öÁ„i5IRÿˆQ½„A¯4;J·Óæ€ºÆ¤×\')ü§€¡t¸óäølĞì¨Çlk*Åê;î£XìU¡¸“?ÓİÂÒT@r¤©TLMK’¹ĞøïÌ­\ZôñP5\\s}xş\'ˆ[xÜº°§Î¿¬dù …dá!”ªc†\Z°µaĞX˜ HIìLÃ®Bm-N¡:q’¬; jü¼½bå˜±`;N½ûæÆnÎÁ§÷ÚéCÂîîBbÛ	-mğ8³=B\'´$¿¥J•š0´ïìÙ³9BéAÔ¥Çãa¦ot[×DÔ4ö9åË—Ÿ?ş Aƒ>LÁâ}÷ıå6Ü:Ø\rz¾;>_Vñ:”$P¶lÙ¯ÇíĞà‰­é…^J¦ó\0UI–(Ã³$©ÇØ­IJİr*“EèXs‹ÒbHÆffÕÉ˜U§ÈH– oEëÜ6jÚ´wÖ|¾mÛV„®mÚ¸\r` 05Y‘1OŠà@\" #µ–F 5zª‡¢‚j^:KWÔ‰‘†\0êw¼¼pV[#6aÀĞ‹¬¾Ğ0CBûb6wJì—L½Ù.–(|ÊRkp°>2Q¤p‹®Àá¦–VÅ<» bp©OÙ,³i¶Uÿq§Ç#‚ä\03oË-’] uîüÅ‹.\rèõH¡ÂE˜U´…P¥ˆÂÜ™K©U®kÃÚb&‡ùz=+—.¾;Eá\"…‹+âõú‚·»<{ÌNhp˜~w”‡;±ôôŒÈÈJÎÏÿb+ :`\0¯ôLıçÑyo&œ1XÃ‚ŸÆ®GÃg¡:jR\rŒ-Iv%¡ÃvŒ%çCU@\r,À#Xîp™=a1z£‘ë0˜0Rëø[ë0T«Tˆ»ñv`xùT<bÁ9Ó?E~L@`¿;_BŠñğq~ÜE6LE1ù0ÜÅÄLÀ€›)”^XƒÑ½\0Õ+ Å\'À˜\róüh@)Mq¢Ç–âYŠ™…a~äçOÉƒ0’˜Ë«?va\"°´¶\n¶â\"aò.0Y¦5°,HVEÀí‚ğ,€53ò¥d±ÃjÙš\Z??Šša<‘Uh\"™º÷°%¼\'ŒfjD!àİ¡vN\0½´¹W/Y²ä„¡}ß{ï½¿ÿşÛè†\\&Á°y´M\\BÁQïˆ0°é5ïÑÑÑ,4hĞÁƒ%¬‹#÷z?˜½2(`7àÙ®@@Ãì|òB\0¿7¸ısƒNlúh·Áz<ğMË}šb,ùÕ\0;É£Í5×¦dl9“ÅE\rãj^Ê×©|”‚p:õÔØeá<!¨NAf”OÙ#cìş¿µş¨iÓf­ûrÛv¬»õçíğU\0â’aaÊ=*‚†Û(*L²/‰ŠJ»S¡Ü8Û©\'ëáƒ5l%¢!+rÎÑ‡U(ä¥©¢kki †­	ù:’z…êŒİ¶76L§Ï`¸=R¾A‡ŒÙ9á^³UDŠhª\'læ9I›Mj\\i˜4aGe¦Ú™-C)6AÄ™™‰ÉÉOtjW±B¬¢íÈÂf4,6QYCñÔJ¢á¶©qm\\Z£H…¡–¶ƒ-!1)yÉªÏc££ışœZäê4×<Ÿ¢uù|9‘K’ŸxfÕòÊ•Ô‚\\C€!Ái‡\Z5©Ó<^\r£q›L\"ØNĞ*Ã‚Á¦õLKÆu†1ÓF&I‰Tÿá&¶á³xa—\r3êÄdÆ#y._¾R¨PA8÷ã)6Ô»R³N)\0E±XCÙ¸˜Óg&Â™‘^´¹¤±ì%ş‰?Ú\\@ã\nH¯›‡ŸôPcPÌÎ¢°äXˆÖ±P~ÉkXƒ‹1;‘š{3äÈ|C†™Lxu–±ôõ¥pxmõäÙ”«0X£Î‚¦*,x„ÔıY87İü›`a:ò4w9×Ù¦<–gkÍly	cç‘;j–BÖ*ƒ¦Í~”à‡(ã³ì3Ø×(ã~¢xû%J6û=+ïa xö^œ`vPJ”(1ahßwŞyçĞ¡CÆWˆ]G 6ø‹Í‰Áy4$«æ¼9(±±±°;pà\0	ÉƒñúæÌ_½pŞĞÁÓ½†RÇÔ\Zào¿g¡€üKêFLLÌ·cv0$å§ï€°“‚v(ÙkOfm=\'Ï›=DÚ«ÏˆæÅ=ÊùIZ6tÀÍ½TÀN¦€4Ã«×pÔ´—ßÿlƒ\nØmÛ¼h·Ûf¡U¬,)Ä»Dˆo¸ØÅŸ3‡fZRX\"ªhÃ6J³¢A¥êU¯€vD1áBúP?†Zì’J½Ã`!õ¶Œa@…v‰ª‚-W)DËTmN#$É¼… °3*ÅT™¹ŸÅødİ+Šö¬Lh#§Æ@2®Ÿ²X¡bJ°¾ÈÜÃáŒ‹báCg\'¿l	Û\0v¬cç}ªÜÀÉ“§ªÜ{ßÍ¢\n$8‹@VC$Ià—¿ÿîÜçŸ¹÷¾\"-[IQQ£så¿-´AY)ÆbŠSÚ÷?m=t$¡L™Ò°š	ÃÙz¢æ?Ë;Œ´r‘”feäF^„6Ñ:«Iöuµ.Êo«ß¥+W\nã^ÎŞåß‡şº{û‘C/^8‹-^é¦\Z·6hRå¦\ZW3Ábz0Pä¸ûa)€&é?@?ŞNØé\"ìØ_\Z ªÀhVÔ\nª¡j~â2óéD¸HHs^Ä1SH­j…”NX“§‚}/d±±8ÓÙNØ´d±5—w\Za¼+‘@¯Ö€}¯@Vx—\0âå¯>…¦Cœ6X–wh€ígg»\r­%\"˜>¬;*åˆ8áìm,sJ¤`ÎHvf£Ä…]PdM\nJ—$4:É‡ 5„b8Ò!ÕÎ§³î¯Ì	“L–v	0OI®]	µ÷êŞ!Zg¶´Gô¸Gag^¢D‰‰Ãú1bË–-”U‡^«KL¾pérºMÊ‹)pS•rb£½P­Zµ–.]\nÃüá‡Òçõú¼¾ˆÿ¦­ñï¿;:xvÀ¸¸öwy=Õë~ 6Ğ\0ïºı–¬¬¬@\0ş„¬kÔ¨±gh¯ö#\'X:ß	‹P9/Q†õ@ƒâ²sÒ|¿Cê±úÊ†ÂUöDFÏz{Iás/¼X?=¥Íå(H\"õŞ	v™ó\n\0o\0HÚH°S€T¡uûÑ3Ş\\¾;v;ÉàO8Â×ƒBÓbèÁ€J/ì0h\"a­[Û‡Ñº9ïJJ¾´>ÅDëõxS<–ë­í´k%$ qø$­…«å!Ä°ø%*Ö1v\\E#4?}Ô0[Åˆ1.Š\r9¯ø-]`éÕ»9¥öKÃ´ÔvZÄm-ˆû3Ç3t±NväXÀÎ>p.ĞWzzú‘#	}Ÿê\\ºLYî‹°°4û|>kZjÒğ¡`ùrù±Ç*¼û~VJŠ·dIOd$’R–ksıØª’…/Ö¡^íÜC 5ù3§N½¿ğ“J•*FFF\nÛİ²Cw†TŸ¸iãU&ÙYY\n¯ùÏ/ÛàTãâÅKEŠ–+7°£[³tîo{wßŞR¯q§\'{³U:·…Ãì8nOXŒU‰¥Œt8-,Óç6Q¤Ô-B#ÃìX~ŸîÔ2clÜ¸¬Ù²97séŒ·òì)™•{â¼‰KÒ…‹—Š-¬eÌ%O<OÓ¦r(Év|\n†Î¸‰»UKßYôvêÇ1mÛrY³ŞØ°Ô0D”£gªí6½œY\nOò€_…Ë8›ëªhbíÙv&†A´s‚bvAç¿\'yÂ³:Ug2è xvÀN¶Fá”àÎC¯ZR0£V6!‡^\"l,½Kåº-SJ%£Aóï ôéB0ïXì)˜I¸Ì_!bg•.Û÷ÿ‘®C=Bã¾Ø8ƒm\'´>rı9fØõ:tèæÍ›Î­ó`Vïá#ç¬”X‰ty´ïm7W„+8Â‰#ššuêÜ¼té’‘#G~÷İw88¯ßï÷ùı;vıõö[ ¯¿ô@Ûæ¯ôÙÿ6Sh€¿Í\Z×ÀH]eRªµk×Ş3øé£&í_ô!Øù\0vß¯¾·`…oŒgS>hèäz©‰­ÎıI¦\'˜^ÇvR\0x@Ê2vï=ã­÷ı¹mÇ6ô¼mó{¨÷d€€0ùh¿RğWÒà3‰ÜHK\\ ¨¸^›ĞçÎfÊÊLÚëVE¿’`\\•|\'k#?¡˜©÷P\0­ƒ6ä^±šŠ€_çtà#\nÌÂÁBŒˆéİx‡ŸAÙ¥ƒå¯ñ×¨Ùï4ê³$a§äìÚÃ6m€88ÀLš5Ï¬Ê*—/ES]4GŒn†=s¶x‘ÂíhÉº§¿™IIÇ§¿ûÊôŸà_ûÉyŸ$•-_ªÛSg?YQeİç¾ØXÖ%Ùº6ÿmVïÕPß‡Ü±•\n\Zàx°ö³¯Ï]¼T¢$º}Â\\-—ı\"`WmcHîŠÍdÚ	lçJ.	[—¨¥¹ï2‹Ïç;{î|‰âÅ`\r:€õyöŒ—“şc{ô\r•û\ZÛ˜‡w™Q0mºT,h*±’A	Öğuê4*\'ºŸU0têé2¤İ(†µ‚Å=—\0˜;C”Ú³°˜rú‹ĞÙ—T}ÓÂÂ#œz=¡Dñ¢\nì‚-Î¢\"üZù(i™9–c¬ÂBİ%kèè•q\"ÄL©˜]_•‡,%Î H#SÛê…jâ½b6¶x¯q·˜ÆfBë‚›zs‰\Zbæ`;\0¸u?7ËÃvLªØøu\0£Oƒ%›\Z~Ş\n¿s%›b3°ê¸}P\'¡9Iô\'ˆcËçğtSƒ„Ì•dm¥•R6âµ|¥ ^LxÕ6‰dQ¾âWAâäÆS\0¸şÀzƒ!Tá6#rJö?¹1ÇÎf×Ô»\'œ•\rgÖ»!°Û´	vXïU½ÔÎ~93çƒWl’úL¿Qõn½133++EF@jíÚµ–-[6bÄˆï¾ûFCó!ñïÜsèÍ×ÆB_C†O¥!Ph€¿M\ZÕÀÀä\0œüY¤£ƒîÒ#nÔ¤øE³=°“ˆê«âC ì•¿Øy€İ·Å«ï+ûÚ+£HtÃG½Âšë¥&¶<ÿ—¢éÃbVÈ„KN4ŒKŒÙe¡+b%Y½\nVªxûQ3f|´÷à¶í[‘¾ê–MÛ1 ‚°2°C×Oà#şHYc†ÑĞÅ/V™údA=‡–Å’#æ\".Z(rP¦\ro‰¹|%óø©Kƒ¦~-v¯¡M¡$¼‚	Aœ—vw5¤{õ×¥«¢÷#Š6×–4OU%ĞõK#®eÓYWFÇT\0‚µ«¤eÙ´º´½ıùïtzÏîÜªŠüòÃãŞh/˜\nZ»dXÿ˜›·k^¦ÛmØŠ†\nÆ½Âm`J3³k#\"ÖÑT`´×!ìCÆ/û¨ˆUqAVfæÑ„¤Öw7­S§›<ISl$J‹gÏiÓ²h‡¸¨ÆÍ¯ôìè«âKşMrqIJëĞ±â‡s$ŸWË&|gÿ+\rn{…Ü]kü¶İ/Ö¼jèRü¤¦\rVÅíşmT-Æ\r²\\·û—‘5óÿZÕ£Ğ¤š»U+ïÑ·PmôY¦Ö_\nCèK\\s \r6¸\ZÿçWßo®X!Úa®–Kş¼„\"Oš\0»Ìøùû\r¬ÍcİŸiı`Ç Aõ|¤İ´™sÊGÇR«i´ÍüûxJÒø!ıˆùÆÊ7™òFHÙJß\':L~óƒ²å¢í8L£†âÄ+ùÙ¦ Ñ˜Iö]h_GeÙ³ƒ³Œ3gÏ•,QÜ\n°[±àıß÷íªxc•6qş²g4GE¢úyöÌé;Z¶»©Fío?]•ğïß7×møhgm9mÜĞ#ÿ\r•ªT#_¿O×öğ[”+ãÄ×ìåŸr6/Œ˜pK½†¿ïİ5súKäÕ ‘o­ßˆöÖ¿îÙµkÇæŞıwïÜ–ødÏ~tx˜Àw=t/µ=ñÕú›‚`+#‡b¢GÀ³˜Œ!ˆ£¡c›e‰˜ÂäéRÆ8DÑåL}Æ}°©uŠõætvúìÙR%K\rXóÜˆŒğuïÑ\Z/˜ë°³¦p…œOÍ—\"P|Õ!<ö&2.ü>¥€lŸ\03.ÈAV@¼Œ3FÎÍïø‚eÒ?ZG1;Q¡\Z¶XÍ´\"É0£uüu´¼\r§l}ë‰±Åéœ>òƒäÿ±ğ`» ŞƒfÜş{IlôáV\nÉ¹)\\!KÔ%%ˆÛ/ˆ…ÖÈ¾9ß‚uµ§ÓL<ÉrÌ°k#$S?W¶Ïò…8é£uVtÑô·xñâ/é3|øÈM›62˜¤!v>Ÿÿ¯¿OÎ|óE›Ô2©Ş­•1!N&¨ìsj×©M\0»ï`‡N$‡iø³c÷ŸÓ_)gÄèWº\\¢ÄÊbMXíX¢[³æîa=;tpÙ\\àQO©ói°èÄ:¸vô!¹\"eğõâÍ^2ŒÄ2zÜëõ3ïñ—cm†Ÿß†;ÕÁ¥\0bØ!Ø\rB\0êvè0;\\E’tc«G¼şÖG»÷oÛ¾¡z›~ÚÆîš©WNĞ­3‰àaÑàıKXa‡T}}ßOzc±`çdŸw7©Lïïµ•ûS*ş¢\0Â­ƒA#¥Ú¶wÔŸ·lmt…ŠtÔ§x”¾Q¬ŞÑªùgÿàwğ7î¾&³}B7`˜H]†`€]›ï,XA½KšŸ g¢í{×x¶M¸36Écº:.‰ÂcLÌıšÍT‹ãÖ	áW†kÑ_¿óö&>|ÿfV kã¦í·İR»Dñb²Å´ --õÈ‘cO=]¾CÅ`.ÆÎäÓ§/oÙT´}Ü?O?S[YyôXDÊÎ@Áê±ÑïÍ)ˆ~A$~rÓF“k-ÉXĞQ}|åÀøQÁÁ“ìÈê…\'ÕØùË¨ZA-óVòa’œŠ‚OÖ<’¸á‡Mİí… ´´ŒÅ+Ö¶¾çö+Äx=L¥‚¿\'Nœœ¿|M¥J¢¢\n˜¡%o\'†ïÆ²IÀ}Ó.Ã“Õ¶rÓóáû§½=—àìEèŞªÛÒëZ7¸ïä·>$HÙâÙïtïó|öK»o×ö4L9q<ù«õ«HŒ½°’?Whœx=³çÎÿöÇÛ›7òb†f@lÚ²ó–:5a_°>ŸÎ3N>SºTI!`wäğŸóf¢íÇzÍîèôxØ7ÂÒˆŒD”vh†ø¸æ£{·¢ÊÖkà¨JU«›!_ÿyŒ¯‘ÇÉIĞÜçñ‡à·°ì¾ıb]Ò±øá¨á÷}»ËFÇ@/¿íİõö«ç~üùñãIåË£š	mf¼2aş\'_P-×—F¾ğìàÑÑ1±İ:¶~ııEĞ\0_tmß=­Úõ8š}àî™s—ÅÄTLN>öB¯®«¾ÜhJ³µ¼KÛ;Ş™ÿQ£Mô$óXiÒN5ŒTyè&,Y[Ñ#3ö™wğ%³1.a”9$^I:qêô]ûÚ´ºËïC¸Ì¬Ì¯¿ù©qÃºeK—\nX¯¥á¤ùä©ÓeJ—RhÍÖÊ¢üşQcÆÇËÓ&¥ÛvN²©Øzmšq:jàÈ_À·q İ½5Dc»%kJk2LÁŒ˜d…ÖIâ¹\ZË±ÓÑ:èfô\"æ…*B¢Œ	·3;±!lÌÎ†j,ó‰üç»0ìA0dDrdÅÛæ\r`—#h-Ğaÿ\ZÖWÁ\\¿D\Z¨èèU;ÚëÊB–ùË“nY\'’e×•;ÈZ.‘òòƒ8ìs¶ã¶^J”(1~PïÑ£ÇmŞ²•Xª˜Ñâ“Ï\\ºdw†]±b«VÁJ¬2VôDU¥NZK—,AgØıˆˆXÁÖwìŠŸ6y¨0œ1ãß¸ëzøôº\0¹k‚êÃB©Y³úöa½:ô×\'K%I½tBeØ!@]ßJ¸u>L:¢;(ßù*ìó”&æzÊ©VrÊ7è½R)bSW9Õ2+\0 ß8!#„šˆºä	È¶“‰J¬„în;òÕ×–íüuÛ6Ømüa«ÚJp{PğE­ËJ#8h†¾hÀFÀ¤×6Íêw)X bĞ„e;÷¡{|‹–Fàİ §k£[\'<t²ä!µ¾½ŞüÖE£é²¤»/TL²f€qî£Ğ¤fÖÔá^ØÅÄV®]YÚó€I1Å,4ášÙì\0 |)Òè‘€U,ö¹eLc)éjÇ†xù|Úï¶YAu@cü°qy¼÷Îæğ÷{íñ;›Ã6cî`:{æLTdÄ½w¶ˆ‰.GÂ!ªµô2¢öHkÌßí¬_}crRÔ©M™r‹û*­\\{âµWµ¸½`³æ$Ä½±C‰¹ş­Çf.è¤çİä&Çms­Æ®_G×fİ:Ûo#jävìÎm`’&×Ø¹oTí|’lH}şpÑGÄ¦Û£áÈ°ğ£Õ¤\"õéş˜„¹u’V+p-Uo&:qòä×ßmLKÏ(Q²¤ùê	\nØ9{ÀîåwæÙ3›ºwÛM7ä¡Î]	^‚Ì°C˜¾E|ˆü¶wWJRB«::÷rÍ‰×ëùiÓ6b¾çfğ÷‡Ÿ·’Ç»noŠçbñûı\'Nœ,[¶Lf¦\0Y¹ğƒßö £ëúW±Ra‡î_4ëuh¸¥~ãGîgv\0¿~û.OÜ\\·gô[P\'\'ÔwÎÇŸ±0TïÇœ:sNyè]Ã!z>ÒnÁ\'_’]Ç””¤/Ö¬ì=`|z²c«7>XÇVhNIIÜ§ÛŠÿıİ<Òî®·ç-Ácn—ûïD`œ†š	¥s›Ûß¥nº…6|7K´`ÀîÃ%«¸¨™•†‹sQ.ëHÊ`ßåõ|şå·äñÁ6ˆ®øù×ß«÷·D=¤ÕòÖã9qüD¹reÍÛfVhiT„òËè´ñ£FX2ìr|íÃi]r?õŒÎR­f¯Òe¸V™ÆÙßñS¯5\"SbU\n™3qëæ¡0.ÜÌóÊ‘r¨›³cR ¾†‚5\0€Õ:TÀ.¢u XıÉoâC\nù 	…2TŠæÌ¿Ì˜dˆE˜Bt+fª(€Û,ğHò`ó\rL¤bN„µWBî³²!ôT…·Ï=Iör\Zr¬¼8éxmlØ¼D‰“†?;bÄè]»÷‘ÃÄÈNÂª¬>í®XÕVÁ\ZŸSÃë_C„¸\ZÕ/Y<røğ?#HÁ£É?ÿ&&\'Ÿæ(6¶lµª7â›aä\'¨HBõê7mÖ«Ó‹“º¾ €‘èÈ±\nÁïàºĞƒÏ³ˆ|\'yL™¥YQ4–•ú“…MY($ø—ŸêavX1¹;|¾ò-î5qÚâí»UÀîÇo7«p:á›à»^e­aË\ZÜÍöIH)VÂ÷rJ@AĞ‹Wüe.š/ç=	[uŸãó –ƒ{Ô‘0HèÔ\ZãP­ZÜ6ÿãõ1n Ù‚E8ãÕIş·>¶n×á…ãI†‡ô{ê¯ƒû¡éÅio5lv{â±£ÏvëLB^ÿZÒt¸¯ñ‹ÓŞœ4f4?İ÷…ö‡†¤Ä„=!ÎÆMy£^#´”JN:F-ÇN~½~ãæ\nìš¿3œµwnÓ¼eÛ‡<\Z0Ó2`1§aÅNÇ½b‚6Î)\r>ğAxatC¢é¬Xğ7’l€QQ_|ıÈmîIMËÈÀ.+331)¹Nõª×/\\¨ Ñ^dgÃT1ÊÑîO×ô¬‰¬)ÿ½Á—üGTùIã.Ì_à©zÓ\rËW ö˜šê)X+|éÀ”föºôQjCÃŒŸÜ¬ÑäƒØØAåßaÆÙâÎë»O9ˆ-GÆßÖ|\ZÒ¤­1fßÖ1µ9š%PöOjŞx\nªó‚K]Ö~|=‰¢ãGg–\0è¥æÎ4â-kìØ7²I¡–ŒÅéó;Â®A^ÆÔ~u\Z‚ŸjŒŞ»ulc¾öOoTïÕjÊçÇ)ë»Gö\\Kï¬(«z™:‚õkk/0ä=şÕ†uU(®ÕĞYÍ¿Àd¬ïÑƒ	F¡»D…³Ÿõ¸ “Ä—³tµmÃ.-=mÑò5\\=yºkçˆˆº¾b»WRÍÒÒÒ·nßùûÃ±1Ñ^¬OÍÊ’?CcØu«¾ÉÊM‡Û¾üö<Ê˜[ğş[¿ÿ\Z\Zî¼·MgCÃK£?rõ«ƒGOºµ~cê\ZˆÖÁ-õ\ZqEŒBJrâ¸Á}æ|ô¹ÙÙ‰ãÉğ1¿0bÂÍuš-IøÇS’ˆåÃOöúdé¼)oÍ.W>æ™Ç$ú\n‘Å³ß†/	Gè…ÆBßBÃ÷´>úïßº<A^ı¶wçúUËÆM_İXå&h ~7üo-M94@jóÎôÿ>DÓ±nˆ˜mì–§Ïë…}İWßüÄ½º¿Õ]°¯ËÂ÷ıúı)Ç—/W.33Ãüöµ	ÃÎŸ=\r+ëñ¯”*]VÂÙÓ§Ş˜4ÎgŠ•(5ü¥×¹·¤LÌ…dsàÈ‰3_Ítëİª]œÙ[zSgÌ!f	;ûé/N›	´Ñüëÿ­IN8Ú£ÿ`Â°ûê³5±n¸­Ah~\"®å›,‰‰‰%3‡Ñƒû>ödOX%nwç;ócnÏÎmÛ7ÿÔğ(vğzï­—¿ı\n%»eÛûİ©MbŸÃ£3ióq­›¿8õIcÑ¶ê‹Sß<–pdşoCsÏ~ã†s\0éİ×§nøéó¶¾¿ıóÃÇB›ÁÏ>uè êÀ\'¾üÖÄÑƒI°­Ûµ~ØØÄc	ıºw!6Ÿ}·ş>t_è†ğÙ÷ÛÍL:ŠÑ=pwÃŞıÏ}ï-ø\0\r}Z¶»«A›:|ı¿õ_ş´ûØ±„gPKxÒô·5iá°v1bX‘Ns×}ö5ç®ãCmĞ-†VŒgäM>]¾<œ¾2¹ÜJ)Âoè_}ãMø;rèÖRÈ¶3/gYGh×Uğ\'¥Y0Î´Æ§@ ŞüŠ51@î9‹Ë\'˜€{Ì49Â¬Í¿$íNÓ¡q”QÈçÖ–³bñI¬B¬ÍŒBêIaSÀ¿W¸ôB°çÙÙƒw®ä”ä-`ÂÜÄ°‚E$j\ná±êLv\0>‡¹UB´²~iEV±M¬ğ»HÁ\nB2vò\\RÄ¬:ÛK\'D±äÏî:è^²©$kõ–³´êº‰Jìk†\Z<,>şÏÔÔ4bO±9Åêt OR‡@m”Wd‚¯éÛŞÕ«ß´xÉâÃ†mŞ²]Rù$Gã¡jph*ÓI\"·.ÈD©–ât€éĞnº©Ê¦a½™0åÈ†O%•\"¥ø‘(ï<èê	ŒÙÉ/ºÜ´/ŸwİÈzä1€3Cô^áŠS½}B†f)ûÌÂ›·@á\"u›NŸ:ùío6n%€İ÷~V°Æ\">¥Î+y4ÀO´I¹\nB-vER°{ÚáÒ!ËäisãÙÏF :V¥\\xf,š.íu+w¼.™™Ü×ìêxòkï6lÚ‚–c»;ëÏ^º&¦Â\rƒûv¿ó¾6ºtEéÂ	jO£–¬‰‰­¸{ûæ„£Gà«÷5®Z½æï-J:v´ÿÓÏZˆÔc;µn6~ê›pm@»w¬Œ­Ø¹u3ŞAËç{>Jq:h˜ñÊ„Çºõ®ß¸9÷9…#•`<†.Ñbx³¹8i@\\èÙEmãô¬3I.E„açóù¢\"|Ÿ~ù-ÅSÚßß.`ñ/Š°;ü÷‘;š5lÚ¸>a?‘0	JÕa„•]’Î¯ü8ò¶ºÕk${©ÒÑ™EZÉÛFû²2•\0DÁ†4``¹	/%öëí)Z4zú›l^Q€ñ“›uv§‡ÖiïW÷(ü¸´$s~Gì¦Ñª8„[­îYøñu5Çoî×>^²Ûê\Zcöm[GYóXIB¾¯õÄÁR,Y€µ7‹¿uL¼nƒ1¾š;U{õÓ…&Õd-wı:²æ*  p! ŠgÒÚ®%º)tÓòÿJƒÛÖuR±B`È×ãÆpnşxµa]êÛ¬\"îq’Œ6/¹¦ËÙ¥]Ô×¢G”ÓáÄye£êb{¤ôô´ËVIÚ1v=è¥(êvTÖ£îHÛ¹{ß›vT­RÉç÷s5sñÁĞØİkl7(EéñpÛWŞ™oÆƒˆı‰äÄ]Û6äµÿ`ÆËí~K½F¿íİÉ9\0Æ>€3#låíWÇO›	Íß|±nå’¹ĞâbGN¼¹nCë8±$!p€5ü¾oWrÒ1ú™2vĞ3Ï`Q3›X¦÷ğ“ğmÏ-İû¼\00ê»ehI\0;\Z ´ÿù‡\rVÉ 0ÑÀub&b¶±Ò×ùış‘şÏ¾úöuµ½/5=Š¢Xö²ĞWbrJlty!ÃnìÀ°Ê.Vbô”·lğò¸Á—ÎŸ…õ~êÌùÜ+úõÍ¾z?ö\0,Iø\nÖ¨™H¿õ4;dªPKh†eR>:†L\'Øñá\'o­ßš_\ZıÂ‘Ãİuo›ı‡PuónZ-[÷-]àØüÖ‡K°*+’Qƒú<öd¯úšui§Ÿ¹æk|ƒ˜:Ş±M‹YV@ïª!¶œÅµj~\Z÷ìÙ±õ¥1Czö{!®K×İ;¶@ó§ßmgı¡û“.ùXÂ–Ÿx~Ø8İşŞÆ.YMvÈ¼xUL8¯Øç0(è«×³ã~B\0Õ}™óÀİ\rÛ<Ğaàğñ»¶o~qäÀ/~Ú\r-ÛİÕ ÷sƒ;?‚&E÷ßÕ\0ãt·\'&íİ5nîòu±x“R«CÆoã`wğé-^iõú/i­ëÒáş¬€’…¶‘-kô•˜T16î)YÆá÷õèİ\'*\n©`-Z´Ò7BÃ‘ÿ½pá@JÙiæÎNÏÈ*ReGxôÍ¨i©ÂvÆë˜šóóË\nfÏ£{ú_üEÉ„3Ã,HüiyímÉx£1:Û_¦.˜rŒ ©ß1Of‚Œ€ÎŸ3ÆgÈ®\0¶£eb\"Ûq™³ãk´LDÎşÛrÕX{W¿“DBá­¤Ğ¼Ø»r†ÿ‰îBª¸‹DÅÙ³bm!QI|¢­êÖéç€¸+0>aØY²]ššõh%aN²!Î{›¼åØæ ·Î‰› hk(R¤ÈúeDFF¶jı@Â±Ä´´t…¨gJ€bv¿Sé`’Dw~ã D‚­vSå…\r>lû4Ñ‚>5\"™>Tšx¢i#h,: ¦j•7ïİyü”c?n@Ô4 “Sê<ä<;	gçp0†ÂôbÍTS1˜±Jà#o<²‚µ_³z,L%¾zdüNå\"®XyÿùÔC[7õzãmÛ·\"ÀîÛ/\"D9µ¼\0_+¡`q&«ÚÂ¸\r »€â+t	`‡^L™ı;›&3`·lí¶¥Ÿ#FÃğŞuU%F.¹UQîmvË¢•ŸEk;X¤;¶ı<a¸zÄÒì¥kàoŸ\';}úıN 5ÏäÄ„~\Z½JËûÛ:6®e“Y?!ÓîYoNkÚâîò±ôxdÍU5	Z6»ır1±Ï÷|tõ×[Hhï¿õ\ntY¯QÓ.m[T­Vóö»[>„©yT…î¶sv¹`j£D È 8·yçV±‰‚ß^gûE~õ!ŒX1ÏƒÑëØGXYàÂ\06o¿ÿ‰.\'ZŞ{¬<øBe~6\rßf¤g8øWÇ‡ZÕ®UƒU{¤ª‹!ÏÊòúıÇíã-T¸üko4<öĞìÒqò_‹|	¿zKWóûR2¼ÃÆ•êÓçpóÆ•øÙ_\n©—³\Z”ÒÉÍ\ZÆ¸¸,c±şñR‹Æñ#1mÖwó¯‹KŸßi\rÚ°Š(VkÕğµ_^ã“^E&KİW­)Í5Š’ËO/‘Dá¨@¿²¬…&7o?êòGá4¯ï±¾SÆ‚N«‘—ûF\"ï¬/œ¯xèeÿ¨Ëw`sºöñRİVãèkàãÒÜÄâÂi¾di]W\ZÂHh#Ãò™ÆìÛ2¦6tR³†“É£^†l9_u›\0¦2AczzúÂ¥+%¢F-ËO?ùHDD¬x°#@0W»àïƒ‡V¯ÿªfj‘\\å¤€]0ìXÀî×=;ßzY½ÚÃßQÏ÷|¬û3mêLİWªR­éíw›ã)Iœ s£_èEç­ø‚µ;è‚¼¶I€-h`¹W‹f¿]¿Qó²Ñ1BË¹ï¼6vªŠq8	‡¦äö{Z?…!6\"0v³_aÔ·ÔC`ÌiãæwıYâ8›:v0	Ú<òd¯¤ÄQ¶]‰vÂd@ÇlÉCg„ØØû±X3u0päK0ì[\'B ŸÏëÔ÷?şL+Õ½wß†ä¬,è$\"ÂŸp,©b…˜Siü Şr Ë5ñµ÷-)BŠ2qhß¬Ì×7yÆ\\î-áWRÜ®¸2„^HG**Ø-üÁ=ú\rb†_÷îzsÚ¸Å«7Àdş²ggò±£íâ&iÖ\0»Š„Ô?z`Ÿ£&DÇTPv±ç½çcïÎÿ˜ß$Ÿ»wl›2^=dÖüÑ±:µi1k>ìtjbØ½·p%ôÍZ5{Î* @:´lúş¢Obc+îF@Šn°xüí×½K¯~/txø	bÙş¾&Ğ†\0+¥×AiÕ®ıóCÇ’·±š.ùG0>q{ğFp®Bl¸»!1cÃÚ\n*&&&<óDG‚âA™9}r‹;ï%{“a©up6GÄÏ¿Ø@kİƒíZ{=>t	š`ç9šxCÅXY¶[fDú}#Æ¾X¦\Z@#£¢Š+\rçÎŸOOKƒ†“\'OMŸ:)=#+wØ\"õKJ`£WÂ¼å“©Ø%CG8PËDÍ!Ï@%ŠÁê´Y6 Á³yßÁgÆ`gr°FÉ\\|VJ¾ú?CR„>Xo\\øŠ®©\'ZûÙkÅ‚°¨WA®-ÅXû;?ØÎBÿGQË>°fç!;Û¡ùt\nÔq;Ô\"rBx“àYYXD¡.Å¹TÛ|7K¦£\"›‹\\Ø¦§RœÔg$íìôaû½Ê@ö{Âğ;{v]æ÷û###_7ğæ›oîØ©sñâè¼fÖíóÉphŸêøÃ>˜<yÒ±Ä$v45®Õ\'Óî–\"ö›O<şÎü‡`EX…øÅf@ ?ŸG¦6@<°Z)€6Iëˆe@ñ^\\€„æ<•–øÈúåK\',\\vşüùS§O¡Ø¿ıêGEâ$ÉKô\\Ub4ËêŞ¥Œİ`ÔC\0;„íy°|!*‰ïıÂ¦ìÂ©àïæõhıÙ¢ÃdøQ°xTÁĞ0¬÷mÖª%-’6ïûšŞL\0;æ;úoÏÇúòç½°X>óäˆ§BË>Ovüô‡Ú£ç÷ıºu^ÿıºÃ\n%®e“÷Ğdıh3¬ÿÓ]Ÿî[>¶ÂsO?L»÷Şz™¢x°£–õ7ëÜ¦yÕj5+U­öì Q¢öEÁ‡´ÎÑ³ÿî–^l¤ÒÕ1Lp[çœÄ¨XLÍ8Àh3jŸ×›üğÓO\\°÷Ş}\'\\Q˜ÕÄ —Ë—.\'%%µ°u•o çˆQ`…åC¥ÿõçÉ;ZD^¬ÛS‡ïlY£î‘’ı2½Ç6{ŠVçK‰‡ËªT&óâ¥ª›vH\n\0^ö¿Ú¨îÁ1ó¹[&â\'7o¼äE•¹¶¾{ÄúXEtR\ZH\'0³–ZÈ5\rAa	êW3ƒ’!H¹Ñ&éq°˜‹ËÚ£ 4ôúÀ´ÛZ¼ßa±ZzÜcŞ\n!¥¦¥/\\ö1µÃ¿ÒS])k‚VåØJEÁ¾„cI«×]¸Ha®r.:Ğ<¤”<Us‹å«Î­_}wJR’Gè±h5º=vâˆı&ö_}ºê£E³‡Œ™r[ƒÆĞ}åªÕ+VªÒ«¿®ŒFÜZ_ Ë=ö|äşi3çRˆ°×£í¦Î˜\rÈ6G-a	,üp&±œóöôñ/Ïd½Ãt²áPˆ“\rŸ£—Öv2GM½ÀX\Z4nqK½†ğm¥*Õ`NŸî;õN„İÀ¼Ìù*Lôx‡‡Çì\rmà+hà’A“Œ5ÿ¶w×º•K`°ì[‡µöuYşq#5ğ=wİá‘¼6*±‘GUªX!=C ;}âğs§N@ÃÏ¼Pç¶ÂöÿºgélôiŠ—*3Â¤eòèqt£\'-ÖcŸ#á‡†µ–íü•_Â<|ıùš¤Ä£=ú\rÖÑ:‰\0q [§Ö¯¿·°|L…‡önØ8thzì=3f/%˜ZrRâÏt]õ%:á±Ëıw yÃôz¼û3\rš4#Q\'%&<×ãÑµP#\Zş\\ÏÁc^‚Ş;¶n>kÁ\nívu•\'é ¹=6CgÏ>ÕåS¬Ü:äÙ§‡›L’±î“åó>˜9aÚŒ†Mš=¤Ar‰°#\ZPßjØùŠ2€™?R¨€ÂéÚİİpÎ²µĞ2ñØÑÜ\0ìàD,3+ë‹¯•Xœ¾Ú¶öyıÂC\'ˆÀêúÏÑ„Ê7Ü6QDúıE\në£çÌ÷Q+ølojsñ¢f\'vdÿ± ‘…2¬\\ÌJ]l!êq;7†ˆi\"’,‡ÀœÈhD9Š›iÍ¼.¶ˆ×˜A™›2\Z„dgø@\'Â”:8ÉNP<bW®„,ÎºğÜÛK0–Ó¯ëÀwht0¡ÓÉyÁÃ1-÷¬‘6âœMGÆ\0b\n:3•–doo_Î@º0`-	„ã+x°×k·b™q.pH²3[²[/HÓ.*jÃšE‡:wîœV3¡u64>ôÉ¾F:}èßTŠş{ßÙ\0õ	mê±q84Dâ“4ÔŒÜÀ Q·zµÔßMbPñ*E´YŠOéS ƒr…ÖªY«íØ©Ç/^¼D®—¾ûz£\nc{ÊÔ¸ó°Ä™J[$Iôx5î\"¦×aÈ¹Ÿğî/æ¬¹–Êğ>õĞYyE«\nX%–0ìV|S±¢$˜î[6.÷œßK8Òç‰pâ[>¦âg»İyo›ö»j%ˆkÙôé~/`%YU:b›öO†sı§YóÍVX[7;õúš%#•ØGWa½›.mZŒ™ò:±|¾çcÔòù¯]±´Â•êô˜\Z¨iP\ni\0³Òr‰/§mğ&¨°lUÎ\\Nløæ;b×ş~ø»îÓ/ÉcëV÷™oN”åÀ‰§\nGEİ{O‹²¥KÉ²Œ	zŠöV¿zâøÔ)‹ß8)ÏH“Ê?S½­,Éşç“\"ä9ı¼ôërŸ÷\nÈ,SªÊ¦íŞR¥èáwŠvõ°²¦ké§V“³ŞÍşI¯ÆÙiMÏ\"]>\rŸ@?òâò8rxÜÎ_FÔ„ŞVõ*:…˜É¡r5¶ïYù:€•3úBú§[F×Òb†ƒÎ•«±c	˜GÕF~Á¢´ù$zÜ^{e•öVRÖÉ×ÓÕ[×qïæÑµT›5—šV{óÎq5öOnÑdu-øW\ZÖ]ßqÏ–1u4-_Ÿ !ÔBiXÕåTõuğåº=”å4®ø©·õ”>brÊ”óÕµXÓÖìÄ¦÷SÃ>jÎ‚å¤z?ûÌS¸/óĞë&håğñô¹sß|³ñRZZÙ²¥1ñX—Eñ*`gfØQV+OÕ²ì:µ>kA9Ìı²gÇÚO|íİãÉ‰#ëAí¡|ù)bİß¾qÿùš1o€4â -Ã³35Cµy~\r=/š3o¥\nfõz¤İ´™s`DĞ0pôK·Ökt!2Ïö–0¨•‹çRïÔğH÷Şm4TøŠÆë$jøöËõ«¢+T$¡Á·³g¢£îûAJºyùí¹{w¡’%<İo ±)[>ÆœúÊ‰ù×½;×¯X:ş•™ì[‡âóz¿ùV=ï¿ÃCmáïúÏ¾\"­ZŞ›0Â\"Loñ÷‘£U*İ@;v2»zÉÜ[7>s¦xÑbı‡¯\\­&ï‘C—Îy÷Ê%¤¢X¿ù]èeNÛoûvÍ˜öâ 1“n!g¦$OI‚f«\Z…°¹„£=D=Ÿô.¢_}›CëPMŞ»síòE“Ş˜?Ùg«WôyaÕzxìAØEÇVğE£\'M¯ß¨)|ƒ\0»yE#†]Â€¿»@ï ìŞ¹uÅÂ¹ÓgÍC£yÇf-ø:ëÔº1h)Dÿ:¶jşŞÂ˜š\'Åµj†Øv¼‹kÙìıE+“}´pÎëïÍ‡á<ûÔ#Ğ&FƒŞÖ}²9{¸k‡û´§B~÷5íÑïhIKÚ|°ø“hó	Tn4›‡îÁzµ8d^º:6öL»[Mb|ğîF_Ñ°I‹¤cGû<ÙùówÚœT9Øºá»ş3•¦úHçöğwåêOµJø ìÌş$R]ÿ>òo•Ê7\'qŞÍšø¿ÏõéiÒ(+Fg\n¿Ôc8ÀN¸Gh<Í<Ø±èì²ÏŠ¿b\r¶/5.’õG\'(Ó…)Öê©œæ­µÂ/ˆÔbñ,W4Æ´Îh\0‚©Ÿøà;6AöĞª§ËŞ2Ì„J#-m@xàI¬3üÁsè¾œÇ(…ôR@ğ•,C±`Ğ)AíløtF _¸`’#„=Å;|oÅ‡m‹Ùãî\0°™\ZlDÃ–`×]\'â¬\'\rªógo)QHKBg¿DDD˜oóË….İ$7é°–îT\"Dï\0:ù\r­\rñ‰mrÁÖ,Å7¦¢wÄê×%ÎàQ‘J€Ùmä9ŒşH‘òà0³-Tq¤jzğ¿„£	§OŸÚ}°Òßm\"™ğ¢ë8¼À£àk\'T~:bÖáKšIÎ0V‡ãÁü:øß´¨vãßŞc.0!`7ì™zÓuiÍOº¯iE+ÿgºdòB¯\'ş<ğGµšH÷oèø)±±e´¿W%’ŒŸúfƒ&ÍñAuêÅ-ïoÿÜĞÑ[6ƒ†oññÒã¦!`åÙç~”8›µpE4¾Cƒw*$÷.^\0 “_ÚÜşÎ|´x9\0­y^}wö¹1Ã¼uâÀäŞĞY²SØœ¦nS\Z\\‡D³YÑ9YV‡g\\}/^¸°eëö¸öí2²ĞÂ Âç]÷éÍ›5)R´¨ù~ºÌÌŒ#GêŞ\\£aƒz‘¸mE2^	*+rb¿ço:·<PJIKRJ?({[g‚j@>	¤sùs¯÷8º+òÄ&É{O³VJ>û\'ßŞdŠªµZsÜ¦ãk ãí¦h–µFìØ7¼&ôµºwÑ)5°YÅÔ0t…™h“k\"{„¾Iè2tc‡Åésãp\\¦´h¬…ßqÙÉE?}*ª×Zd>µX¢á¬ï‰-—Ÿ\\¤ oÇ¾µ\0“6”d£¬‚É¨¾}ï¤x»¦W‘ÉÕ±w&_0=]Ér­=ûâ§7ª7ı\0Ì\Z\\Éí¯±‹\"_$ä\'Èİ0ñó:Ò|ı1½qı×´j.Ş7<¾k™§ˆ†lçy–uX÷DéîÚãÅåí­Êù*Úà‹Á¿G}ùõ7=Ÿz\"2*ÚgfdÌ[´¼]›–7T¬ àãNiu¥º±¤²AÃö»÷ü\Z_©RE8¾°•sşïMCjX=oŞ&´‡Ñu‹kõúû)07aØsú³ÊMÕ¡¹ÿĞ1)É‰¯O\ZK^-Y÷\rü¥î¡KøØ©ëSœ\'íô—=;Şœ¢*Ş>ötŸ¶©péî\0îñH’„–Ğû[S_$~?^8›Ø?İ¹-1°^î¼¯mÏşƒˆ:é]Í±Ğ\0_\ZD˜0ıTòï¡û%Ø0iìƒÇNº­~c›dĞW¬G³™M›/çŸŒ—.^„}]‡‡î§}İúÏ¾„}]á\"Edën?22ê¯Ã‡«U©’!¸ÛşØ¿ÿLqä¥ÔËQQR¯\\†urÔ¤éUªÕ€¯üñë¬×§ˆĞ[4~Z{,\Z#)IÇhÉT®Zmâkï·Ù,/ieÍ¬L>àŸÃQ/ä‘¾6~Êšı}HµYşéwp¬úbİªØŠ7ÔkØT¹$éÑvwS/ïÌ[Fn„‡­¶sı;‚Ä±3­áÏõ:ôç›ª#ŒrÈ˜‰ğí¬7^ùö«ÏZ¶}hÀPréú‰kÙüıE+H˜¤Ó 7Õ<ôÙ4œaã&%%&L\Z­jÚ~új¤ï¼>í›/?muûç‡IJ<Ú¯»:¯@6ÃÇ´¿·é‹W2+îğU³KWgİİx66?¨ eÒ±„>OªØ:Fñ*›ÏÜa6ˆ¾¡`^‡Æ³gÎlÜ´¹K§öD·N,W­ùôÎÛ[”(UÒ¦Öù|ş¿ª^µjV ËIõ°{÷CØ\rèËv¹´ü1§=ó;†€›uc\0+§Š…•ÑB•‰(ì²3V\'8ÃNHW3”ŸNñÑ|¢Ñ­$k¿<™Î`fqIÆ’}ÃÁ‡A˜5\\XğìşÃr•5ìB¢„C²³àÁ…Hp[[Ì.œPqâ_r’¹‹b÷¬Ø\ZívÖx!3+Ãf³•	÷ò—úøõĞ“ä@Ş©«\nM0Cğìâ±}§ †º…-t{‰\\(¡æ!G‹0¸·6ÁÃd8I[Zâ¿êE¬’z·,q•Fñ{Iá\r¤(!I` °3\0\Z8RÇÅÜ;-lEÚüóv-]Šóş\0a»5	jÊ=D…q\0	t\'ák8TzgìŒ]æbv#úÔÃAËjn0.Hï4\r\0ÂÔÎ\'ÁÿáVtÍıŒaRÆÜÌÉc¤1#bN022¹eÂ¸Ep°ú“»½šÄ|\0¢JF±|‹›ßç+yùJ\ZQ½ñz¼…\nF¥¦¥gšÎuÂÀJæïÄwéĞ¶jÕÊ¬::[ÈÄşøóK}2¨Lë,täàL¥°\"ey[_ÖŸo·ïÌéˆ„ÅæP´ó£ÆçÆÕê¡o#jæxÈ®M˜—N m¼`•eÙ‡.!’H•£zÖÀÔó“çÈ‘W¬ùâæ:µü~ÖÁÜß\ZƒP¤÷-;BrŸMQÌ‹-ÂÊ½s9œ8ü¹‹×lpâ¸{§Ö¯1œA±e°hŞ¬7\Z5½ãÖÊ?O¦]´¯+X êÒåTÚ×.TàJjZ¦ív‘‘‘şu¸FµªiééB+ÏÙ±é‡!ã¦%$ÙúÓwO>3 t™rĞşß¿½>yt¤v;Jó{Útzü©ÜÈ ¢6’ñü7fp¿—ßúĞˆC	}7‘á…°ãé	A\"ÿ!d>ÔèÂQ¬\nCğ>0ğy}‘‘şÔÔbŒ®-X \r°›Z‡.ƒ\"µVN‡ÑEFú^›ù4Ø?=İÚ—˜-nÉ™Ş%Ú.¤/Œh¶gı`‹³1i©\nzYCíeÏ%Q?Œ.:16çX×Œ¨=±Ä^\'Ò¤„«ğq*f{=\\Ë}].Q\":£E+%›Ä‡Ş¨ğ8t9áVu„w/|èËŠ\n×YodO¾á6=¬v\0[7\\ºÍ=ÅĞ£¢u\\²‘SE6>Z¾‘(GAXbvÂ\0ÂÛ‰	–½Šéá(Ú‘aê™p€Ü,«¡x\nğk4ç*ò…©e¤ÃÖêXör\'éñÓú€Yuğ±Fä%IÌ¸OH\'øB	ÒüdrSÄ®{µi\r&ªàµÑ1ôæ*r/)È€Ï°Sï¨P`t£ßÜL\"ìFõ©§A”(>™€’ø?”D¬Ì‹ÑEd¡hGÕ\"“¬0Zo€ÎÂTìéÜbro²Aè€óæ\Z6±\\œlA\"ƒ€·cR;€¦uX\Z§¢ğ7Nóç/OIy¸c»reË’›\\è…¬GhÈ<{îX›\r$€vŠÜ5CÊô¨íĞ¯H#A¼rögï_Ş;*¯_íñù4Ã4Ù¶Yİ«èäêÛí.gCvmB¶¡Ú²œÂ¿£Ç r•ŠÖ·“\'O­Xóy¹òåŠ+Êò·?Ü\'>AÌJúÖİmï š½ã.NqÜfƒÊœwß8úÏáÉo¼G\nÏŞñî}ãıÅoËliÓ%\'&ÎzcÊ”7ßÏ~iåªh}`–å~Zø“\"##âşY«FõtÀÊŒ©ã’“šôzDTB…Tì´ÔÔ±ƒzËp©}[ƒg^‘ÓyRq4aúYŒMÌ8\"00C¼“Œ›ú¢‘*8ê&Ù¼»0KEË¡#g!§,	e„eÅçóÅÿ‰j]–=`Ç+j‘Bè<»‹—SÓÓ3,‹ƒ.Üùã!Ë°CJ÷;Íè.ëÛ2¦7æ$ÙØ\'‹ê²€/1±ã~ø˜M&[pÈ›1Ö‹lÃÆ ëæ’ppb-`Ç”’İZïzCírh‘à)q@5²øÊFOç!ø`UU$„¾ »R–ô8‘…\0œSœBvÈ.ÇJ)”ŞÉ©ó’3}Dø¡XìØä¹˜Q³0½ÛytÔaKÖHV#·}ˆÖY•´(ˆ¡ñÀ;@^‘cÍ©Š+™Diê«ÃÔ+h E÷E±ò, çÛ1±«ËO•iFN Ã48ò—é$a‡ş8-I18\'ış[¼6Hc;Zµ7…¤àÔç˜±\"«k^	³Õ”È\nxwÙ¯	ÉW¸b2v1ev‹«®¦_S‡E˜3Ç	¨€œ„Q:Ü“•¿\00Y†¼ŞiAšD›*HVtŸ¶ã““Å­¨NOŠÍL0,	\Z^ˆM\"ø	?Í	ÉÊÊüçŸ«ŞÛ´Iã¢¼âõz‰2,ùôª#´ñx.ïûåòÈ¾•oÜ_`D&¸Y~œ–]e?ñwï¹Ê]ÊLİ[´˜ıº%‡v5¶#ÅUWò›P}j\n³\ZÖD%şåkDóÌÊÜ¼yÛ¡#Ç*W¾ÑçÓõ\rßÛ]7¤xû7Ø—ÛY³ÙV\0¢i·UWdR[ÏØA}ÿ¥ªwü¿Ÿ˜7¹(cp¤3æ,‹6©jfC²•êïK\"ü‘8P§fÍŒÌtg-üpó\n(8fÚ[%J¢[;Ï9ı\"¾Ñµe»¸vËádÙ‚	[3òí\0O(0‰¸WúÓº ;´\ní`é•ÓQ†™ 0Ãòû|¿Ç¼¹V\rç»¼%8NåP‘Á2ïAé*Š…=òÜø¤ö6½5e0õø†ĞØ+ÈèDODYbÃ’³\\‡\\Z¹¥R,0-Ğ,\0NW¬%È&tŸ-ªµX3Îru•-³İ£É~\n‹¿Öî\'Îl²“‹å–İnÛÌäìˆ„“éël#À¡„‡ñ	k,‡»ÃS/2˜	h‡/ruAë¼t§Ú¼U‘ÑR’:O±V){’C—ÏM+’\0\r›Sİc\\MU–@{@\\Ö\nP’ú‡°×¨\Z,z\":ªºæ,\nVÑ\"–õ<=™‡öÕPÃ8?‡~Ñ£¬ˆAI&Êiš\Z«\ndÏˆõ\'Ó‰™TÅaz“T,Oo0 u¨7vÆ¤ˆ]Ñ ˜š=Ä‹í>¯dvªˆvºôİgÓÈP@aD¶À¯™ššºsçŞ~=+]¶,`\Z˜~™\0ÆS€Ö*`•ÊºxéâÂ%Êæõ^ÿŸRä…@š/p&Fº©iD§Ç‹İ{W>QÒtmòÖ†\"¶ŠvË­Et€;ïôÉïÏÿ¸Qãz¢\nĞü›Ãœ.œIÍRg[U=æĞqŠ°ãâ:gæÕšÀäh<Á™YùE\"\"\"ûcÿ-ujgd¤Û»üjıª}{v6®p‘¢ğñÊåKŞ{³Nİ†w·jwÓk·)ÊoªZ8óõ¬IÎÕøÆq2¿Õ pÄïóÿúÇş[ëÔÎÌÊ{‘}´DÆit×BT),ÌÀ‚·fã2øşdXèBñÛş’ÓšãP‡Q&LFÄX@g\rÕ‰QJY®°<¸¾$8ÿÂ•$¸N°¥¤Z.’¬×å9óñ¬x;9U0<.Äu®Ù#œÛ£y•IqRJ2`¶Ê¡~+xÂì®	9ßÙ¨ÔV»81¡D4d\Z&¯k¥\"BŠŠÖ©Ø>Íº÷GÓ‹%\'Ã2vÆæ°c•o‡0HçQˆn*¹±BÕ§¥WR¦(“ZöÈm°’tôh\"\0\Zh—Ê’zË,i@\n:TNRÔDS¥ZÉ‹ÛÃx úPğ_\\XoU!È‚±8¢Í\Zeíä9UF4:YÓ!B\0Õ&&L*\r³SÈN[ğõ·”®k¹\nf‘ySÏB[»şŞv$£(–&n~t}dÚ^¥ÖˆMQØæÃ°Y›•øûŸ#Ê—¾û®Û½>ÁVØ‹&\0C•Ú‘Uo”ŒSpî]›ëÖ†‚q?—â¿´êUNV¾ÿá§„”ÓUªÜèóú®µM7#NÇlVğH&È¡	R(ÅsMÂ¹™Ùˆÿ¾_÷×½µvFF¦çùD„0\\—6p\\P¿¼m^¶H§[»ùYü~ß¾_ÿ¨{kÌÌüÌ°SEĞU™N‹%8Öså	Svî&‰¥r„É®‹¹3Î\"Ut¦oğÒ°ÉWPı’PÖä†Ù%û#.¤ëvÑ“BEÖ£	ØÁä!íú‡¼±æì{s•­ÀC•°CuÔœƒqKÂ–£n²’ctA8´LYf%4Œ.ç2xMIxx«_A¶UµÃ03Ÿ}ç‡ÒÊ5¼L¡GØi4:Íüu„=\'yÔd%¢‹ş“Ô3ìTmXíP´Ãã@B@a*\ZØ§†=x	`§éëâPèè.©à^bÒq §‡qRO’ÃW`È8å˜ã†.—*)‘Ãç0+Ù2]@ÖÂÃWäÊ˜3‡‰u\nCeá‘\0%Õµ‚µbeŠçaÑxvjéb´PÑt‡\r‡‡“D‡¿+Ç9£şõÄšÇËû	V¡Ìyâ‹iÃ#Ä$ˆ¶^qùpÍá[ÿrš\'\r?X H9~<!!±ÿÓúF]»Ç“T! Ñë(+\nhÇÛ‘SÉ8È0¼*×æ:·¡•„TLÕÉ\\å²R/½·`eÅŠ±åË—óz½×fÇv*LÁlr\\/?¹J\\ºœ)§&aø#\"öıò{İÛnÎÈÈÈ­ÔæDşËW’İKÎ©¤%Y&ñÁf»¬s¨\\C]@PñGø÷îû½^İ›3s\0&ÎfÁØ­ğ­—mV@BĞˆD/BEåì\\…Ú™r˜µÓYší°Óì„FŞ³ÀA8÷‡\0]±¸à]¶Å¢+¶vÁÈRÎºïĞ?YN’¤ûÎn2sL‚²|Â$Ò<x+|³\n¶Ä\r5Ã6¤Û\\çØ…	ùæÿÎ%gK.ÜüfkC;J]4Ğíè½gTKU¢œ6@ßc(M=™_`ˆµV5¬‚ß\"\r_UTd\\Ñª‚mê¯ @šÊ4Â—Ëªd=ÂE#4$’NFJÊ	òRÕd•]\'ãõª@÷_|¾Æù’‘Z¬¢átDmÖ#ÔƒÅdªK”_2	›¼Q²ÆæÃZ²²¬Ñ=…GY!\n¹Š’+a1­Ï£î5R¦™¿m@¾ŒËTñÚ@2H¦À%«F`Zõò³IĞÃ‘Lh*È|0Š!İÔ}X<;=Ñqà„qÉ<±[·Š`6\Z..s¾-\nVˆ¬ÌÌ\'OÇÇÿÙ§{§ò±³²Lá®š¢(ªÛH\0øèõzYZ×à\ZXbÁã¸Gäe½JåóyO$\'~¸hUíZ5Ê”)í÷nŒÍß\"Ø¼)“Y²d#W£Â£¯•O#ÈˆÈ]ûö5¬[7=˜JlHhå*…€óùtşşÈ×Vº#üş]û~iX÷¶ŒÌ<çu\ZÖõáôJFwSmN†³	<¤(l¢“ÄõŞD#Ë®ê§À3Œ’±t¬ƒ\n©ĞL¹çÍ .?6´kK¬>½Ş´$É\ZŞfÖÜ\ZÇ’IÖ\'Á“§lÅ˜½¬a	¢§¬)áyãó©hKV\\Â&£„\Z*Z#OÆı{§¾„v¹K–ÌÉeØ.÷ûX§¼½Ò£š\'B;ÃÇÈáuŸvEP•aÕÃæ0Ï;ñjGÔá_Ìà@ÈšÇCn|E<¤Ó¸w^¯¤!t’&¨õ`0\r†B¢€°öè‘_(Òó¨°]JÊI°dM•ÀwÄ`vJY#Š«’Í©7ÙÊøx<@oŠ ¬:EeÏa¡ïä€¢Ñë0á•ğ¥Î­Cåå!a“\"UÃ$@>ó\"wøµş1H§›€Š” Íù~¦FŒÍzæfjÏüõxZúe«ZNÕõ³rú†\'G¶¡Ô éñ‡ü|H†Æ„Ñ,²\0¢‰Åt”ÑûMõâ_TÕ2³²şı7ñÜ¹sİ:ß_á†Ò2¤RÓ\0XŒ‘ŞãÉ\"/fİXcœ®ÍõnC9tÎ˜º4j¹ç„lDEx]²æ«%Šßxc¿Ïçñz=êîÁµ±6P;ó´[Ä½ËÉ½clò±ON\"#\"vìÙ×¸~İôüÄ°Ë=±›ê3ÃœÅ¶şµÑîrRr\'Çş»iÔà¶ü¢ˆÍL{œ÷Ha£hAµ8M.Cë$ë€Tá¦_º½í%ËÙç\0ePà3Ôb´ã09°coÖ½ş:„«\"6\0ŠMİo&!…ó.;ÀKP?9P©²Dˆ=N(¢¤šeÅ*†!ÚW§Š`ì_«Ş!;óR«Crí²,WrI«¾ˆ¦%·¾j;I2¢¤#—3ÈêÉtèˆ;	¯øJ©Svõ´:ôÑçIÎ£ÚàsäëN]/âƒå<^ª>‹£Åª³\Z<‡Oºc¦½À.9™\0vŠÔ;#²‚€ÀyÓP$u\Z¥j\'d’® rü\ràL¢‹ÂÇ>i4Ò†õ0÷OÖi\0\nU…Õøhšr/ œ+ öv]Ã”A¾ÌœÅny`Õqˆ?n,¨*Ì6 ´3…Ã¢bŠÂ-¥j\\Úì˜kâÎNÒ+“<Kï*çOaXŠÆ€ƒ¶¾;W”¬@\0®KSSS/^¼tñÂÅ´ôÌ›kWm{W)¢@jF€:$H\nEXXÌ…¬\"Ï?8‘k“ßlˆPJ/‡öü—Õ¹†R Â«d¦møiÛoü] @DÑ¢E-\\0**22Òëõæë1İjîÃöæìêRìrl¹u5èû¹•¾ˆÈÈ»ö4nX?#=ÿ1ì\"À„o‚”‡:6ØLÖ®]·ü:±DDDnß½§IƒúA¯:¹:ÂN @!D€›ĞÙºG‘IâV†™•f\0†öp#mÒ¨Ø»áƒU¬C2?8ì$¬bÙ‰¨•f¬+ám\"*¦ıÇ±©˜$ÈÉ9Éo–B²Î3	µƒ²µb‰“:µÂŠhbáØuë¦*ÄXdg\'Y°ÕÚwÍÆ|Şm‡ 9¼ëeHı3>(û ·ÁQô{`	ÃPâT,ŠœT§H/9‡N…ñ°ò+¡ÈÁWØ/Æì<!yÂ³ó¨\Z¢\nQí\"Á¢ct”µ§ró08H8j*a\ZŒ†UO%¬Š%«WC Z]  .ÕP¾›B±;Vj%‚Èq,­KúÈ‰xØF;àçŸ\0‚HiWFÀ£¢¢§– zFÎ¾ŸC¢Š­’‡v+×\r(ì¿lí÷°¡	0>p‚ÆM$DórÚ@kTJØ\'²çÓÏøkX…ËÅ©°ûLÂ:“²Ïï­Qé†è²¥o©uSí\Z•*’–…Ï@Ô€9X§	ÃIŠŠgR^)Õ™e9FkãÚ\0\r¡#%­6¬ü%;Zá/ì¢£|Rêå‹ûşóëşCÇOşóÈÑÌ,õİ9+Wk´N@şI^Ï´íã/T¸àß©R¥ÒåKWò8¡$7jÍõB“ÉO¹,TH«u—óG­\r±-Ü°V³Î3IÀN’…}Î‹ƒs6Š(ìÂ±*»bÉO­,·$OÇn²˜Ì†êº­„õùÂ\\ö_\"î²„´w%/†f1Fq048Héõ2ÓÈ·’íâ·Ç7P4ˆ(hRÕ75€K»:V†ËF‚s©J¬jl\Z_H=éaA‘W\r+c‰Q*pFî£Ğ‡1„Î)èÀ9Ò£Å[‡51P.¤^Wƒ¹òŸÓ0kÀãMKÏÈR<T\r–RçØ¦EùP€3Y†ñ8Ç®k#i7Æ²ğ.qÀÖ(ï\ZÌGÕc}’ÈÃ’7]a!¹Ûú®¸âŠ+®¸âŠ+®¸âŠ+ÿ=	doó3BéäE°sÅW\\qÅW\\qÅW\\qÅW\\qÅ$\0©ié¢\"óÖ,¿?N\ZvÅW\\qÅW\\qÅW\\qÅW\\qÅ•¼Iç/^.V¤P^^ÎwüÂuq!+®¸âŠ+®¸âŠ+®¸âŠ+®¸âŠ+®N9W¦dq9»”óN;YV._¾|æÜ…ÔŒŒÌŒÌ¬L¤Këõy#\"#\nDD/V¤HáÂêå³®¸âŠ+®¸âŠ+®¸âŠ+®¸âŠ+®¸r\rŠ×#%¦œŒ-_&wˆ#•Ø¬Ì¬¤§N>S®dùRÅ\nˆôy=^|º@–³ò•´Œ”Sç’Ÿ)U²xl¹2>¿/¯òãŠ+®¸âŠ+®¸âŠ+®¸âŠ+®¸âŠ+a‹×#ı“\\¹btşìEI>~êÌ™³Õ*Ç–-YÔ#(ğŸÌ¸ñàøşZpêÜ¥øCGK•*]®4{Q£+®¸âŠ+®¸âŠ+®¸âŠ+®¸âŠ+®äñy¤?ÿI¨^¹bVvÉÖ*±—®\\9qòLÉ¢…*Ç”’$#¬Î6,\0ëNQşI:}æÂå²eJŒŠòxòò\\W\\qÅW\\qÅW\\qÅW\\qÅW\\q.~¯ôëÃ·Ö¬šÈCÀîœ°KMKûûHBÍªJ+,+Ày%|8ß™ó—ÿ<’xúì…ˆ¿KµsÅW\\qÅW\\qÅW\\á¤pÁ‚±Ñe‹.ÄÙ_ºråXâqø›×	tÅWrX¬Z½+ùMü^i÷oÜR#O»ó•X86$&¯U%¶há¨ Ä:A ˜jw95ıèÑ„JÊuë¢+®¸âŠ+®¸âŠ+®¸âŠQ’N?ğïñ[jUãì?ğWÍËE—.–×	tÅWrX¬Z½+ùM\"¼Ò¶½4­W\'#_v™™	ÉÇo,_²t‰ÂYrX¡bñz@ÚåË)§ÎT©áÏ«ºâŠ+®¸âŠ+®¸âŠ+®äCQeİ{š5¸³ßºû—¸»ë»ŠJ®¸òß«VŸKâ÷ªİHÒÄ®Q‰ğI?mßwW“ºYyØ%™Tb“RNˆôV©P&P²“.X/\"}RòÉS@cÊæU]qÅW\\qÅW\\qÅWò§¬ı~WSÓÒ}Ûî_:ŞÛ0¯“æŠ+®äŠ[}.	:ˆ-şğ­µòò ¶kT\"}Ò·›vµ¼½azv‰FÀîrjêéÓ§kÜíğMÔºõŸú¼¾lgå\0İ7!g%$Ÿ¨P¾tá‚ò*“®¸âŠ+®¸âŠ+®¸âŠ+ùPÖX\0vÀnûá¬×?Ï8s9ø¢±d!iØƒMªúò:[®¸âŠ¥¬É`÷Ò„	’^œø’Ç!vsg{÷é›×%”/$ÊïÙ°qgë;¥efCó4{\"%3¨Ä&$¦”-Y¨lÉb`Išùö;«Ö¬SĞ¯O¯\'ŸèjåÌï—.^¼xùJåŠÑB©©©ÿüóÏñãÇ/_¾*T®\\¹Ê•+(à|®¸âŠ+®¸âŠ+®¸âÊYÖ~¿Û‚a×€>><óŠ´HÉBÒ\'æu¶\\qåz”¤s©_ı‘²ùĞéƒÉjDmqS©¶uÊÇç‘\ra«w(:t04¼5cfµjÕƒºwØÍ›;gíšÕĞĞ±Sç^½ŸÉ¥\"zîÙ¾ñññ&wÉr­Zµf½ÿa.ÅE¢˜ùÖ›Ğ0pğ©s‰òK\Z`¼ûıà½wW¯úDV€ıQŠ¢À÷]º<Ü¯ÿ€ÿ³w€QkŸİ+¹»\\z!=!„Jh‚t”¤\"(*Ò‹\nv@}JQTP¤#R¤#P’Fzïíúí¾İ»äre¯„ä’€ßO^ŞŞììì7³;³;ÿıfÆ°l-ÁN.W$$§>N]uÌ´Eë×o8qò´«›;A(òrÏœŠ6fFß\"d\\BJ‡@.GÿSOvvvLLŒ³³3O…D\"qppxøğ!U”ááá>>>O~e\0\0\0\0\0\0\0\0\0Z×îÆõêªø»Án¬–`÷âWÕÚ{qîÎ¡şöfuôe»-¿–¬¼ùX©‰pö#Xô\0ššœ2ñÏç’OÅæi\ró˜=(HO³û½‚İçË?ËÌÊ¦6|}¼?[ù¹Ùø\nvÛ·şrâ¯î­h/«‚üÜ—F¼ô†u4»Ñ#_vkåÁb±¨m¥RY˜ŸwôÏãÖ8…D*ùßç+cîŞ¥¶;‡‡²|Ï†gùáõì^~)ÂÍ­•Ù˜R©¤¬´äÈZbƒ`WZV¡THÛø¶2í^·~Ã†¿NñğòâñUU•ãF3f´‰ø*(,òù.NöÚáYYY>ìÖ­ŸÏONN¦~’$éââRPPÀf³©‹GíÍ\0\0\0\0\0\0\0€§±DzínÜãŒ©Lîh/ôjåú\\çv÷âSîÆ&Í™¦ßozÁnÖ‹Ü’*2êºÇĞ¯ñ*ˆ/Hµ#€`\0MÏö‹É›Î%¿ÒÅ{zß6ŞNüìRñÎË)ÜÍ~gPĞıƒ´c>±`—ú8uÙÒ÷|üHeg¤}½fM›À6¦1!Ø]½rù›5«+*+¸®½ƒ£«{+[¡^]UYT_Q^&“Ëìíìß[º¬wŸ¾UJS&¿êíã§ö÷\"I2;+cï¾ıÖ¸e¥¥}¸,?/oÖìÙÔé6mÜØÊÃã«¯W;:9Y˜B½»İ»v\\ºr…Í2?B!ï×·ï´×fXb–UZ7‡]zf‡‹›³aÜ\r?şı÷™V^Ş|¾@,ªıòğÑ¯Œ4½8õ ©ª¬‹Å~^š@‘HtæÌ™¾}û:88P×‰Ú{ïŞ½‚‚õ^@àåå•šš:dÈj[+±¨	ØŠĞ‡±+Âê{½ShxRÚÄE­ŒŠ£7ÜÌ™3ĞÚ(<¿qã…Bj#4ryd¨¥q´Ò‹\r«\rÓDÓ:ÔBèCãBëw£\r\r,œónOfƒ%nšr0(/\0\0\0\0\0\0\0h~2rò©>Dª3Q8c„ª‹5oúX½ø‡Ï2Ïa7îÅº9ìô»£‹NÉÎÆ*¨íaØ‡ÛŒX£¡‚]ãv‹ZT†:DE6B¾´û¢jC—×¤ÜK¯šôŸ`æ–+²Ê~_4ĞÇ¹¦f•Tış|GÇmo÷ÑÉXëÍRXP°yóÏ§½8øEŒ$Ïœı\'0ÀoÖì¹nî¦Vø4!ØM8‘Ë³as¸l‹kÃÃ0*UÚu‹ …œ‚nÄ”J¥L\"İwà@c•Òô×¦zùøi~ædeìÜµ§Ñ¯EVfæÇ-%Iìİ%ïŞ¸yƒ\néÑ£Çºuë¨,şï«5>¾¾–$R¯9ìpŒúgéºŞUĞ–Mr€e•ÖyØ%>NoĞŠ/à6üøÓß§ÎxxùØ\n…Ô%|iø‹/ˆ0»”,e¶R&ÎÍ/k 	¼ÿ~IIIŸ>ô[YYyşüyê¶Ğ>*$$$)))((¨S§NZÁ-A°c8°N‘ªİBç7n,¸<2´°vÃ’8µéQQ(R¥p©Ä:·È:íî|áÀf´ªdz64”ÚSk	•w·t\"´ò‰@²\0\0\0\0\0\0¬GaqÉ?¯9::²Ø,íp…\\Q^^>ô…¾Nöz‡ˆ$Ò½¿ÿ-–Ê‚}{u	s´VV‰~?y¡¼²FP[ğúx½CŸ½mD°3êa÷û\"Á¥åwÑ´W]gÖÂaÜ7¶ˆµ#4«`×˜,+üÇ2ôµÄÀ¦1ÛÚy\ZŞŸı)W7ş7J3]I’Ï}|ŒÃÆ¯~>R;&c­gäü?g¯_ÿ7+“ş H\'g—³êëU8ÎZºl©\\&+-)ÆqÌ×Ç××Ï·g¯ŞÒKÁ„`7uò$gW÷óçRÛ«W¯ùuûvCŞ™=»¬´dÏ¾ß\Z«”fLŸæí[\'ØegfìØ¹»q/ÄÃ‡V.ÿÔÓÓsÎÜyûÛŸö8•\nl=yÒ¤Ÿ~ú)\'7gÅÊ/;tèh6zyØY	»¸„ä.¡­9læõa7ü¸ñÔ™³´Zg‡ã¸L*-**()*‹D¤J´#¢]HÛmÛ¶êŸƒÖeå™á¡m5ÑÑÑ­Zµrww/))IKK“H$zGQÆàààøøøˆˆ­à–)ØéêkôfX¬F‚«Qã˜S«@Q?Ï»ÏaØa!!ØÕÙĞp\Zfƒ%¢H\0\0\0\0\0\0€)Æ\'É”ÈÖV İ¯¬ª¶å±Û·\r4ŒæòÍ‡	Cı\"=¯¹|óŞ­û4Íœ¨wÈxØ½ÒóÎ‹Ü‡%qÙÄÌÜ“÷årt\\@°kÔcûOĞ©ÁîçõÏ=È(9²t˜¯«P’YT5fÍßıœ§££Yîa9n‡k#°µÅqœÇxzºwêĞñå‘£H„¢O¹/7·@\"!ª®V*d¢~×KÁ„`7sæ¶vv³gÍ¢Z·/¾ø‚qhêœ9s¤RÉ¶mÛQ#ñÆŒŞ~şšŸÙéÛwìhÄ«páÜ¹ïÖ}Óã¹ç¨RÚúËV¹B¡çËápŞœùÆñãÇoŞ¸¾xÉ{\r2T½<ì6ÿüóÑ#‡TÂ˜i?;’Ú=zìøY³g[’,SK°»—Ğ·K;‚d8Á¡C‡wîÙëã Vë¨B©”Ê¨ÿ¤d­gœ’ òr²N;jx8\'%&÷èÔNràÀ;;;¹\\.‹\rãÛÚÚ†……988œ9sfâDí§šVëC×X©\ZaŠ\"’#ÕêBÕuË5‘tÛÖƒ‘Qèè\ZŸf¦dµÓ<ˆ&Ô:BS»W \Zá¨Æç+,¶ÆõK[Qªİ.´ J²D¯Ó¯­J§€BQ\\\\a]$zŠª3ñ¼Û\0·èÃêFÖÖ·u@í‹c°A;RíÙŒŸ]í¨_Ç¹P÷@½˜…†ƒ^ôºFtş\0\0\0\0\0\0\0#Pİà1±NNÎš©Ä%ieyY·ğPÆÑO[ö­‰ßœ<Ê^HKf—nÄÜŒ‰×°äíWõ¡ºî=\rºî×M\nv!x{oÖ¼¡Ü¯ÿªÇÆj£ìJJJ,XàääÄb±”Jeiiéúõëu£[Ú-¢âEEªûGº²•a±51­A£êc˜»ljŒw²hc:qˆ²¡¦/¡—\"TÜ\n²Î\nÚº°•Zı>¦c“\0g®ÿÈ(Ø™/=ËJ¦60tùò°•QºÆ‡©-f°MÿìfMÒ\\Ïº”u®ğDlŒ~°ítìè3^lïã\"Ì*®Úq6şèõÇ³#:¾9DG=e¬õŒÄ>¼¿eóVŸß©SØô×¦“ªoêÑ”8F/HJ5C¿îÜñğAœD$zgÎ¬ö¡ôRàÖ\nv2Áîí7ß´wtÊÉÊ¤¶y|^IQQeE¹v;{‡€6A¢ªª-[·¢FbÖ[oyz×HÍÍÎÜüË/•xÔßvlß6fÜ¸Ö~;Èãñ…ööÑÑòÊÊ\n‰X4abdzjÚáCQ¯Ï|3râ$©ÕK°;úO/ßlL©X\\\\TpàĞaKr¤/ØõoG2)‚{öì=ıÏ…V^,¶ÑYô¨çYFjÊş½;\rwá™”¤/ØQÏÍO6›­P(lmm©[®ªªªsçÎê¡²“&i¢ÎHİ´Ôy$›˜¨À°U5šê¬.1¦dãêMºIiëlz³ÑiOÿ¦‰dI¤3uœye*NK‹*¬‘á¥@•VV§·!½-•qh€¡\r¦¦Ác<»a|C‡8-S{š<†YóƒÌë\0\0\0\0\0\0\0êMyEÕ£”WWµæUT\\ÖÖ_h+`Œ¼nË>ª;ıî¬)–§ÿd‚¢]\"PÔBAFñÙai¹H§+®íaW^^¾{÷nww÷‚‚‚iÓ¦988¤TÿnQÔ„°±(ò ºFÅÓêé©Z†]6­ˆÆ:Y:¶Õõİbµ)½˜ºj¢jÓì±Æ¶\rOmzH¬e¥f¶dêUÚ\ZZ®o<s±Ôœ]7&“jÏN]¾ØåªËi˜2ğ„”WKß^ºR,Ë/i‡ï0÷åp/¡v å‚†¡û1w·ïØ%ª®î×¯ïÔi¯éEØµcÇ•«W¶¶o¾ñz‡Nç+3!Ø½3k–ƒ£Ó[o¾Nm¯^µö×_·\Z°`ÑbêÔ›6o~â’¡šÄ‰ãÆTTTà8ngïàíàèT÷Í ¬´$;#­²¢\\©$¼¼½~mØ|vê‰ä’œ:eª{+Ğ­¥_)\nQUeA~Ş½{ÔÑLO$W/Áî·½{®İ¼¥M#—Ézöìşêä©–äË(Ñ\Z›˜Ü©­Ÿ\rgx™©¼lÚôKRjº@`‹©<ìèÙ¥RêdYëa§T8m¿şêKıs`H&•äåæh‰ıóÏ?©‡µÑºukê±!\n³²²Äbq÷îİíìì\n333GÔï]ÛĞ ı(t£ªXwDÍgM£eü‰ÑdkÚKt†ÄÖJHu®vz’ÕHšS£¶m,¨åşfD›ªóUS{Ëó×‹Óñ°ÓDÚ‚`}l0qv†ø:)ëˆtdB=ÕP}h%š3Ãüu\0\0\0\0\0\0@S‘˜’&–T‡¥²²ÂŞ–èïc,æÏ»WTU¿=e´áôvÆ8Duİ»\Zvwî7.Øõ\nb…û³ŠªHêÊ©–’ïî•UÖuáô†ÄVVVîÚµëµ×^£zXL&Ô§[¤çâ&„ÅFFF­ ¶#£ôô:ıQ‰hºj±&;YF;qÈ¸´§Qi9*ÌŒgœñmSıGÍ¢\Z¯8‹K/Ò\\É„jkŸF†Üš*¦é˜´²ÎÃPßÁhåÕÒÙëÿ~”Qìæ x©g›ÛIy2‹Ûùºôëà;¢g —‹~½c¬õÆÀ0tëÆ;wM2ùå‘¯hv;zä·¿¹º¹¿>}z×îİW0!ØÍ™ı½ı¯¿!ìëU_ıºc—áá‹/–JÄŞÔò¹{ëæ–_~álmx<>_Àæp4»ô˜K‘„B$Z°`^û0óSËYÂÛoÍôóÄY,…B!Qé¤NÌf³	¥2#ıñ–_¶Y’¿V°[¾è„%ËNõYtB[°K|œŞÆÇÍŞNÈ¼IlÙº=ñqš@ Äpœ*Ò±/ëı|O(ô¹L¯ªªª(/Õ^tâöíÛ±±±^^^İºuS±‰D<ÈËË£Áqwwwj;44´{÷îZ‰ÕS°«k\n5ß~ê/ØEÖ¦´2®ÖŸY¯iÓóG‹B‘´o±Öª…iyÎlµ£›¶OÅ!~#\nvº6š`úì&;ÄœMµç¡öØÚŸú†à\\\0\0\0\0\0\041TçêÖİXR.ënJŞ8uáÚíûñ!müÇxA;\\®PpŒTª¯`÷êóœ.¬JäªÑJnvØšÉ¼™Äº¿¤š8†sØUTTØÛÓ-ï©»T+â&Ä.§¥º•aTLO¯³\\°SÁÜÉ2Õ‰CF»š¨ôØÚ\Z‹H°CöŸ ô\Z,Ø™)Ínó&X<9åÕ’wÖE?Ê(òp¶ıué(]g:Fê%Ø!•f·{çk×oèß/rbİ°úƒ¿í¿xéRïçŸŸ2mš±µ@MvóæÍuttÎÊ ×dà	ÅåeÚìÛ†TWWıøãO\r)\"ÊşØöìûÍV(d´„\n…\\TUùúŒémCÚ™]ÑÔBæÌ~Ç¿u¤òà[»fµñşÒÔ}é©)êõì¬„`—•cËcøx*É}$ñË¶É©[¡T*ÉËÊœòê„¿hú,ËÊÊp±6şŞšÀêêê#G(ŠnİºùøÔ|¤JOOOLL‰D‡ËåJ¥Ò1cÆØÚj?oŒ\r‰Õ´\\ºÖšè®ÈÆæ 0L¶†XÍ\'%ı!±îç5^_µ’’›ş\n°(Ê|œP†	Û´F²Ò¨W‰EÚ£lÕÃOŸH°sc\Z‹ôl0â\ZgúìÆ‡Ä\ZXw=²fYmK`©	\0\0\0\0\0\0 9¨ª]½Ó¯gW>Ÿg\"ZeUõ–İ‡¥2ypÿş½ºº»:çæ]¾~7¿¨xèÀçƒı\r©¯`·{6ÿÛŠC7äš±=8Áøªc¦;“Ô£[Dwˆ¢f0ìÊ¸°ØĞåFFk\"ƒŸc¡T0t²LuâQ¥‰N(\n‹ŒÕó}3v¬–Mš§qöŸ ôÌ–Œ±!±¦‹¥vX«Ñ6´xBÊ«$ï|óg|z‘‡³ğ×F{ºØYrT};Šï¾ı6=3ãÕ‰{>ßûÎÍ›Çºvë~åòÅ¨C‡[ûû/\\¼ÄØ&»óç9:»NŸ6™Úşvİ÷[6ÿlxøûË>¬®¬X¿áÇ†¡„ø¸{ö	í´5;¹\\.ª¬œùúkAmK­£˜;on@`µ‘•‘öÃ÷?P-ôñ 6Ò\'ÿd™şX/Ánë–ÍÇµÌÁ\Z5úÍ·gYTniÅu-{iYE~AŞsÛ. ¢•<±ı×)i™6|~EYiFZêÛo¾1xÈç ×%‰}èãê¬3cÂãÇÏŸ?okk;xğ`õºKJ¥òôéÓNNN8ççç÷íÛ70Poõ%ÆE\'BµZ½IB5óvFRí^¨Y;Æd™æU?¨ê¨[,A³ZBİjZB–™8ÌK³jXSs`h(*tÓ÷°«xj¸èÓ\\õUÍ¢z*ÒJé-\raäìñ\rfñÓXhQë§›‘…/N\0\0\0\0\0\0€Õ‘Éå\\­‘\\ÆHÍÌ>xì”\\®³„\r—3ñ•á~Ş†ñ¡ºîô¯ß¹?a0³`·bœ¿+şÁo’ürºËÆf¡•ãxûÿ•?Ì¬›¼1;#½-m	#ó‡×õ•t–Ve˜‡ÍX\'K=\'s\'Îàu¨NV·‚³Ğ¦s¬Æ†ÈÈÈ¨XfAÿñIJÏ|ÉÔÚ£·è„¶Âhh›f=Úò0k‰m”ñú—¿ßOÎóp±ûõã±®©uÈH­7ÍG,UäÈ—Fœ9u*>^Ê¦}XèàÁCÿ<q‚ËfùÕ×Æä²k;…¾È³xÑB;{‡©S¦`úö›o6maXüáÃ>HÄß©4¯B%9!aÏŞı¶ööêQ±r¹¼º²üÓı[6¢ZG±hÁü€ `j#-9ñûõCÌR/ÁnÊ«}üüy|éa±$\"%\"Q~nöİ{-*´ôâ:;¹L~íÎıa}»\"7U^$±}çîÔŒ,>¿¤¸8=%ñpT”Ñ`ôj×oÇéÓ…ËÕÂ¥¤¤\\ºtÉÑÑÑÓÓS©Tæååá8aXiii¿~ıÚ´iÓĞõ”a0a[S¢ºÛŒ6´œÒ\0\0\0\0\0\0\0€\'¢¼¢ŠêU¥¤eR¾Ş>­ºvj¯^7Ö¨3Ìv‘F;!›Ö‡Ó7„]&\"sJ	‰ı}_ñ0K©}x=; åaÜ!Qğ’kf®ÜKûzçù_>\Zg¹Z‡ŒÔz(äŠw/tñğ,+.”Édvv´#Tee9—Ëutv),Èÿşûõ,‹ñX‚İ‡.å	ì\nòr0ãñÅùåe¥Úì}åRÉªUk\Z¥¸0=NIŞµgŸ­..QuÕëÓ§ùù4®ZG±hñ¢@•<÷89ñûï¾g1K½»ÃQ¿ÅÜÈ±á™v²£2J•gx§ã\"\'ZTbÚ‚EFv.¡tn£0=	IìØµ;95S.—wéØ^w!WØ8—œâå$ôóbŒPUU—‘‘QQQAı´··÷óó\r\r\nÍı\Zíu^\0\0\0\0\0\0\0h,ì\"•T[Ú£u²Å-Xh™DYº€+vÍ’ XªIù-§¾‚]ffÆºuëÜ=½Ä••]»†GDDñWttLÌ}¾]~NÖÒ¥xy1ë-&»‡÷cıC,•ac±X2™T¡Ğq\rÆY¸ĞÖvìèW:t\no¬âÂ0”–ºgï^jkúÔ©>¾ş-ÖÑÌšõ¦o\0µ‘•™¶yóVÆ³Ô{Ñ	Ü’±4añ¢iº‚]µH÷(±KX[;cKOh ‰¿ş:I]ÂÃŒº••U	)Éıº„ÚÙÂc£¢=ÎÆ˜\0\0\0\0\0\0@“rĞˆ`§=$öz²bí	Y©š«[2‚Û3ˆm6&ĞòĞ³jÎ½`÷”r°‚]vvÖšÕ_÷íÛ7bx„½ƒ£Z~aa¨´´ääÉ“W¯^ıàÃ<<ë-Øa•ˆzr2£$R’dãzÀ©Ï‹h­³Ñ]ëjà°êr¥ğÍ0Ä,|væò­Á}»‹åV2Ó‚²Òì(RÓ³**Kûtï¬ Ì\\µ€hB­cãØõÛ÷ƒ¼]ƒ}›+‡\0\0\0\0\0\0\0\0\0-K;\0\0%ê+Øa±XI’JO/NíÅL(_&;À4<vázÌ€á’fìR\r;¹L~?>ÁÙ^Ğ©]…Ò##Ÿœ*W÷ë\Zj8{\0\0\0\0\0\0\0\0ÀªëşœA×ıv\0ğìÂXë­—]ãY‚]}á±±kwc{u	“4_Ña©E2ÃĞj‘èú­{á¡mü¼=ÌúÙ1$ªò­ËÍ+ŒOJŞ¯‹±	V\0\0\0\0\0\0\0\0ş³¤å–Ä>Îk×V/<>!)¬‡_+çæ6\0€F&-¯8.%?Ô Ö-\r6vûAB·!Òfì3	vb‰äÂ¥ë!m|ÂBI„[8%RO¶‡¡¸ÄÇñ)™6›Ëåš\r\0\0\0\0\0\0\0\0ğßÃN(ô÷µ³Ó_m¯ªªêqZfE•¨¹\r\0 ‘±\nZûûØÙÕcUY Y G?JéÔ®9Gc‹¤ÆöUTVÆ<|Äe³úöãÙğåæ\\í0qpL*“^ºq_*Wvéê`o‹×sÁ\0\0\0\0\0\0\0\0€ÿ¤j6wÃ>Fû@€Ó\0<“Ğ+„Zkµ ñà°°ÄÔÌàÖ¾\r™)®˜ìêû(éA\\BÇĞ naÁ\\‡2•PÍhHı~†`ô_ÇX’Ëå÷RnÇÄwêĞ>¬][p¬\0\0\0\0\0\0\0\0\0\0\0\0.8,,53·µ¯gs\nv)…R³‘¤2YÌÃG’½=İÚø{{º»òl¸>Ú%K$RY~aqRZVVna» Ö]:‡Ùp¹Í•\0\0\0\0\0\0\0\0\0\0\0\0\0xbØ8–Wèíá¦°|†¸ÆÆ\"ÁN\rA9¹¹i™9E%e‰D,–P<\rŸÏwqvğõööôÄqğª\0\0\0\0\0\0\0\0\0\0\0\0VX8VXRææì¨lFÁ.ÙbÁ\0\0\0\0\0\0\0\0\0\0\0\0\0mp•WV;ØÙ6Ÿ^‚\0\0\0\0\0\0\0\0\0\0\0\0\0Ô‚aH,‘òy6Í¸B–\\\0‚\0\0\0\0\0\0\0\0\0\0\0\0\0Ô T,ŞŒ`I Ø\0\0\0\0\0\0\0\0\0\0\0\0@‹;\0\0\0\0\0\0\0\0\0\0\0\0\0hA€`\0\0\0\0\0\0\0\0\0\0\0\0\0-ì\0\0\0\0\0\0\0\0\0\0\0\0\0 ‚\0\0\0\0\0\0\0\0\0\0\0\0\0´ @°\0\0\0\0\0\0\0\0\0\0\0\0€„`ç-¨Ğl‹ÅUê\r…\\ZÁnİÜv6?²ÂdWW×\nÌ±^Gå¤%æ¤\'•æiBœÜ<¼üÛz›8ª­;Ÿ$•Ô†aê\r„êÖ&Õ¿kvQÿÏ ºvoëNÇÁqU\n¤±Q{	·“õvÙ²äåI1U%Å$f2‡)‰\\»\ræLÄb!“\nX<$ÂH©Œd‹”öÒ–Àí\ZãâXDzªäü©âwªÊËê§£Ş¡‹İ‹Ã|üù&ª^¯³Ø%œltËÛ¸r´Êş:Q9~¿­UøÕ)9ö¿ÿn3<B;BJ‘ÜDj6•·m³÷ÚæıÃ)KE2$·i]íşBu›)R÷nn9#UÜÔ‚J>ÙØÒ÷¶´š 6â3m+Åzo®¨æŞN,|Â35˜›ñŠ]§Å	„^¸R©P(å6Üº;\'Äm¿G{vÓÉ>ÿı’ù:ATår‹…¤2ÊV½ø%wb›ŞÈ–C[wÃÀ”¯QëÈÏğ Ï\rwYé›+g5&J0„(½–5S!µtóŞ,€UO£=O»Í`d¡åÜ­j&AN›ËÚ&;éÓu-€&£NëÑVë._½œ™=vÔKH%Ø¤²ŠdIrŸ½;%%Çl´6m¼>ûpZsçİR±\nWWWjãüùómÚ´\n…Å\n[³G‰«+c®©*/aÜ+tpï=˜oË,WÕ	v8§šË¢ş©»İ,„8TgœJç„Ô˜`7 ¼uii)I’<O¢–íÔ\nZÈ£6\n›Í–Éd÷ÓËôR(ºvüÆŞŸ\n\'\"ãzŸ\Z™DâÔq`äûŒE`‘e^B)#1RARQM*E)£~TÊmËØ]0ŒcìØœ¬Œ«ÏçççÎ_²lÃºÕTÈÈ1ã©¿9DıU¶jåÙ»ÿ@/?c‰(äÄ®-9gş*!}õÇÉ¡#]§½éÉb3“â>“E5…£Ä¤ªìØ¨·1ÇÓÒRÙ®ü+¿™½7êKW½Qu{b;nÃE‰ˆ$”Ô_eµDşÚBÛWÆ`ªL$ÊÓÁ±sÚG™?#9IgE¢º±¨r„¬¢ıì¢^_‘¾Åv=!u‚‹\"·˜˜C‹\\Î(>\r‹Í Ş}•åâ„Ù*Jâ3éZè\\Y0Dbm“Œ1î£â}„¾\\‚ éòVÒ/ü“Z”YâíjSÍæ‡†zlm”J²(O‘ÿXzø+—¦7R_°£ê¶·—Íì·X;J7lRüsÉu\\+	vRU›\0FÁNy­«×5ÆøÖrBO˜Ñºû,•¶Šè¯0$¡j£•ªö#I\"=f\'\nÙÑlÅÔÂÍ{z³\0V=ö<í6ƒm…–op´ªš9m.k›ì¤O×µ\0š\nÁnïSS©íìœ\\:ÄËS½kîÛ¯‹ym-Inö»»ØÙh\n¹äço_³F~‰¸ê“…dj’\"!)Œqğ¶¡8—Ã\n®İlIšxe–Gô-Ùå»û¿V‡¤¦¦r8‰»±CÄÕ•×ÎUÈe&’es¸½fÔìÔ]Jª²’¸}¦²|ü»GŠÙ>\"œvîÎŠ¬Cß¾âÇr@DÆjØ¥ìÜªOŸ>‘‘‘‹-R*•b±˜2ØÆÆF*•²X,ê\'—Ëurr¢Bòóó%IBX/…‡{¾¹²u­¤²ÜlùÈ	Äöì¸è¯›Œ{X‡jh8ªü(IBDÊËyRTÒùC²\n%¿ˆ=gqß±åÇˆ—GøûK¤JS“«”K‹ş«LKO>~lÆÛóSPÈ‰ÕËÓÜ­ÆYØÃœuôğ¢‹77[zîTÙ…Ó¥JÙ©«pé\n67<\\Ü{¢¢˜.)‚¢>$d²Ô)ß˜Üõí~~Ë—§Ì^P~,N-á!“‚];OÙ’Tó(W¤¢ö°+èÛÇ­£©$î]ˆq^ºÜ÷õ×©À´Ÿ®úauh×Dùr¯1;Bì?TPq“–~e$’\"L¬Òì¤´`‡Q—H‰$NÏåL8emÍÎı4ïq‰]{ßê-\'£ïÔøù¹bEäŒéK›¹Ú£~arOŸìVII-3¥åµvä}0¸MCLº8{ÄD%uÛ*I¥Q“K<QÙŞCX8¶îPöÆÓÕíÚyÓ»dÂ½²³ë}¬ZtŒèvjµîí™ÜW#1eÜ#É·?(.\\B²º¶ÈJ‚]Ã«jÓÀ(Ø‘Å]ºv¾{7‹!>£`·ç¯hO7uDc¸2nzPÏwHB¬z	£^ÇÕkAR$©Ä+õŞ!VèÎæ*¥nŞÓ›°êi´çi·lƒ,´|ƒ[ U-Ğ$ÈisYÛd\'}º®Ğd0vÙ9¹j©N#ÛY.ØÍÿà a ½­Í¢×{uïèU-’çU-ú=fpÃª	ÖÈOå·+D[Ö[Yğö»wW˜ˆÀåÚÙÙñùüê~o©´ç îæäúè÷åË—OŸ>°3Ú9ÿ÷ô‘ªòWW×áÃé•\'O,**¢6ôB„ÎÏcxx`ÇrIP}ÿbÇWŠ	¸J‘=Yâ\"ÏŠZgF°ëäïøÁ¼÷Ş{­Zµ’H$#FŒxûí·©[[Ûµk×şûï¿«W¯îÔ©Ó?ş8tèĞÜÜÜÄ|}áãÁîµW·®UJ+VMrjàF¡¢b4çšŸè‹ÿarqZ…-<yÛ0#¤4»µ«\'ˆÅÃX|úS²‚²|$/A¤Œj‹Ø¨ªTjWb7Ã|Ü~únõÂw? LzùáöÃ·«æ.föşe}ÖÙèRGgö²•­ƒô¥¨ÔdñªÏÒÊKC^r™9ÏËğpmÁ®[ÁYBTu§õËl¡ <ı4;lœôf±ÆÉíâÀ¿z€ÑŒ†vAnÜ’o¿qL¼HÿHÈí´X@ªPZşÑ#n»7PÕƒÇ;Í_Àèa‡¥}lŸÿ£=’±éf_PêùA…ï[Ôqx´ÕùÖ×HRMŠ)Få]æ–\\g¡©O†Z°£6>Úû¹ba~xQÊ/#Z9âê¿Ô®›É´Ø³d,Ş¯]yfoc:RJ~+a–åÆvôĞÆ¹!¦š›<h¤¯ZS*I¥]¿úÓ¬›£û”R{o\'Ù¾°¬GÇĞÖj-/;¥ğÂ&‹ÚÉÆEG°ãr9C^°Y²\0÷ñÆø|¢¤D~ò´tã2#SßJ‚]Ã«jÓ n]ËD™_«%Ô6q«7òç\"r:îşº:NÕ$ÜXßJ‚ôş´v}æ’ÊjõTÕ;™RõBFm+¨w²ä;¿ÛtÚİ\\¥ÔÂÍ{z³\0V=ö<í6ƒm…–op´ªš9m.k›ì¤O×µ\0šı!±÷ââ~Ş´yñ’Enö‚ÿızÂ&b©zo®UKEYrAF%í¼s}s¯ŒQ°[övŸ=ëfÁ‹˜¹ìÒbıCÂ%ù‰y%Uí»jÓâïx8y­ôg‚Ë3HW—Æå¯Û±nøqŠaÊìĞğVGÎ+\Z´ÀÛÛûÆ¼Ÿ~÷<qCè¸ÿëÑßñÊ+£^ûº±sÒco]¢6¦NjgGEEEQQQÔFdd¤ztmeeå=t9„uïg8ŸÕ¥TUNç¸%(Š&¾wJŠó~]ÓŸ:’Jên²b\\’¤uÆ!±½Ã|=jooÿÅ_…ÂmÛ¶8qbúôé.\\£\"œ:ujÇûöíÛ¾}ûÌ™3\rSPv’*ú®ˆOöï‡.ÆÙØ ysHwwôãF”™©ò£1\"Ø)©/FÀr#1ÆvÄ¸´7¯¼˜äÒ\\R–)ıİ\0ç`’Ä,şL%7Ğ°0ùLª03&—Â†‰åÑ2Ò$Kg\'q8èË‚ü[ó¯^(İ¹9¯¼´FãqpboŞ×>-EüñÂª)\\³±­á|vZ‚¼sb!‘Ät`ÛÕ/ìô¡Ç‹íş—C\nëî(ëv®lâ­‘TÓ÷8×+Ø‡¨®&¶GÏ˜>¾:txÿı÷é{ìü9çõŸcJ‚û×UC;YÕ£ªØÉBTbªìl;´?‰±ê<aI…ÄsïP~òu’º R,oñi€Ş|v‡¸OÖH[¥ëG©¶MnûæaÕÖ¸õû\"t¢µŸ)fACíşä!>ÿÂŞ³Äóéñ°\'¯±ªyâÆ÷ÇJÊÑKYÛÑw”~®ØoWì(6]Î¾›WÆ¸«‹‡ã;}½-,scô{ëAAm\nR#Ø—Š\"Â¯¬N·íu¹7Í£ıïTš›se{Gƒrû\"¨¦âÖ÷ë²!d_ÒÖq\r´J\ZÁÇ1g\'L($JJ8ƒ_°™9ƒÕ1LöûQÙ/¿™Ù˜“#‘›§ö³3&ØÅçHÿM•ò8ØÀ`—#KÎMÌ\\M%9,Qÿ ¹¯“13\ZXUU¨ŠH=wGÈ\']ú´şò§v3£ì† ?^(m•”Š9v,W7¢¤\0\"¡ŸèÁyû·ÊHBNµ¿Èœ`·bú+5;ÿ0ü‰ŒvUw¦v0TVª¤weÍ;¡TıU ŒõèÖÂ®{ê]\0D‹0/á‹ˆ~‡#L^Í–…d•©ªa-«ê® ÁÙM^Ü†Ùc¾¨Ï–¦ÖĞ2¤\näM´jô4õ.n«ÙfMZ²mÏjš©~5c1>¡ÍOİ•}b®œ6ÔZºç§ßCalÜ\"¢Ÿz_&«·¿â6Â‰Ìåx\Z©Ózœ±š¹ç/ûØÛË3°uëÒğWs”5ş)z‚2¢Ù1\nv‡œ às-ß{3æ1õÓŞ•ï»ë§¢>|¨8sÉÊ”‡7ÏŸ:>pèËm:ô BÔ?ÃŸëÛ­ï½Èé=Û’eEšŸ,{û>‰é„H”øŞ¢‚ß£ô3ïèê=ÉDé|YĞç_QQQ¯¬>—WánNü™£÷Ø‹ƒ‚‚ü;õ3vÔ­\'Ô«LX\"Ø9¹ytğ’^\njÁöGa»>RM~ï/ãî\\;Ø*=ªÿL\"6†4«Iìú÷ïïŞ=…B±wïŞ^½zNš4iÕªUš8cÇ\rc³Ù+V¬0-ØK€æ/Äp½5“ôõ¥Õº¼¼\Z‡8c‚K‘çoOàÎˆeƒsœ0¶-Ø)JU‚])+@¤œ‡‰q(1ë!sf¸%~únõü%æıq6¬[Íè¶³cSÎÉ?Š#F»LŸE{ÏÍš¯QëÔüİÑ0š6jÁ¤\'SvN:LˆE1\'Øißî·&M¯>•Š#6ÕˆâÔA¸…‚İ®Ã\'Ÿëİ_?k¿üiİWˆI°~ó‰[A,QY¾køŒ¡;Ö{‡(*«û§T«§lÛ¶mEeÅÈQ£Ú.]Ò³{XA—ş²÷¾ĞK!-m{iŞq;$â¤{·£8KÜ:)—ø/õÆÄUH†Ê_œ[6EÏÉNëu‡~ Z£Ÿ=ñh~­OøtÁ¨ºhIkÃGÇø@²û“\'·w}”¢<t‘ß»t[8?sE¹ã,±å}NQ41‡ì¥øh7Ş#ˆõîK%¦ç°[~2%¯J?‚‡·rxƒÃªé=ıfH÷µZ—]XXT\"ÓšÎÉÅEÈµgãªîH$*N¿¶»‡±r‹~Óf}Èİè÷Cn•´`÷îÜ×‡9„ô»\rx»`ŞüÙ¬ç{Êví“íØ99qßzCqî‚âüE$—3\nv«O–l½VsãñXè‹—Gw¡•hçŸ.:o¹Zs“°±Â¥/VLìÎhF«ªúU¦­F®¹£ê[	vDáŸ¸ÛÈÊ=!B¯²ÜÄ|a`7»çˆ‚Ø;ÅRìÄv&²~Æ}f#«	vå7\'‡šO(+j¾ \nºÍW½©ŞÉØn·í¼gQsĞÂÍ{z³Ğ|V™ª\ZÖ·ª~æ†ÙÓpÁN;KSkxÒÍµñHû“X#Ñ2ëBË·íYÍB3Õ¯f´ê	m~ê®ìótå´Öª?œ‹8§{?Ä­srô1dâaC‹H÷Uô›“ÑÖ}Ö8‘yF»ÛwcöüF«KÎïìU‡äJĞÛ^ÙÔÆw©NWKj†GZ.ØEo›JıòÚ/l­¹±»KÇ÷&&&Î\\²Òp×ıëço^9×ïÅˆàÎ½¶­[Ò±[ß!o4	!Î˜ö˜,;û¾i‡\rÃò£$¼ŒÔõíIIĞ_BY’zÛ!ºL^T(Ï9Wrä|÷Òıû÷‡şp,è³¹¶#úŠwÏĞáşıû¡Ï]<ôô¡mê\rWW×AƒQçÎÓ‰Õ¡KfüL½ê†Ä²]É\'¾wZ„;ş²¦‡BÔ?„ªiâv){µ÷*..æp8,«sçÎvvvIII·nİRË….\\ğóó›7oŞ_ı¥ş,ì&¿J¶\r¢Õºââº³ì8’+^ì’ãã6Û±U+u(*IY!Ë\'å¥Hıé\0ã•÷$\nn±ÏÃÂl \n°ø­ÄÜ,é—ß…ĞgŸñ\0ÕŠtÚ$\'ˆ>Y”âëÏ]»I¿yÓv&O<¢(/»ûÜ8ß÷\'ù,ûøáÀ±ÒûE8›ÓjiPùÅ<Ñ¥\n®›“%sØÕW°“»ÓÓ%ÚÅÆôŸñ6õs?QáåãFpñÓû0yÒ«êhÇ¿ÿ® OêBÚ\\Í¿cÖŠÅ¹l$ïàà5‚ÑB‡?¿±ßÿ1íIèÓ>ï=_W¦LÂä¶kÛëJrõsÜOó¾=á<5ûv¿2ÌŸò2îäˆÎ^V®ûv¸jİ»+İÍÊ(\"{±æ¼,®\\jâÒÓcïæj+v<„Æviè`X5ÏM¹ìªT­5‘œ–œ²u‡Ÿ[•fïtüdÏG!½†IÈ«‹Soî×Óñk\n!âXøˆ„Oİ·N\rûâ9‡¯?·™ûçåá²ƒ‡¥«¾ÅœYİ»âş~Ê;÷”âmZÖK/è¼fâÂÅ’›ôR8W=÷ N!óX(zn«àøL¯9:M:ÉÆ2÷Ï·24£aU•~‹J~¿áİT‹»ÊínvoĞKWíóD¬\\©m;çş¶ˆÛq!¾«<ô¾Ã<’ˆ{ıYM°+¾öj÷ÁEYÍ‡Óš·1©”\"IÊ“ÓÓ2ä„mÀk6nX(O@7ïéÍBóYeªjXßªúu˜fOóv-ó~Û m°µ;kZõ„6?uWö‰yºrÚ`k\rî‡c“#Ú·]{ØÄMÒ°“Öã·¡¹³ /ÀÓˆ¾`W^QúË¯{Õ³×IgÔvİlK¦{¤rwÇªdÚeL\\^p´›arz‚ZªÓ&+¯â­!#‚İ™ÃÛÓÓÓg.Y·Æ§£}—Şš½±·.]»x¦ÿşm»¿h,?ƒuGlÙÙõºQ#=`VxìhòÒ%Úû;$êky	7úöí;ğV]:®S–ü¸eË¯{öìi²`şü‡öîİ[.ğd´A#ØiÓ½;í–rëÖ-Ã]¦;–Ë#EÑø÷ÏUã.$9(ŠéÇ¾›ng`WUUÅbÑãÚÄb1I’vvv.\\èÒ¥Ë†\r,X°|ùr*|Íš5|>ŸÚ°D°ûû\Z6•”¢Ÿ~B…æ»V¢İ²cÛc7·¡Ç`’„jÑ‰RRV‚èá—ª%o”eé\rñòZï7,œ³›1ö¡DLîø½=O½Tv\ZÚØ¬ú‘\\]¥˜Ï`¿î —‚fH,‰ˆĞ[[xÁ¢¤8AÛPñã„øî³¹¾îğõP2·èN×#\\=ì®_¹¨–çC;wê†°‰\rˆTwÆ®¢µ-AF*\n\n\nÔÑN=aï gì¾»ö³‚ ÄZØc:ÏÈšXE©ç8ê¶\"¹¼œãz‹èzØÕètô\0Ø¤÷µ½Æ,ìv^rVxUO`çj4ÓØQ¨š[ÈÿhB™‰!±j¾?Ÿ_T\'Ùµwå-\Zh‰{õı²í%æo\\jºMøÇÅ¯#¡šïµ¼ª$ÈıÁ¼a7f¼§Ş»hç°_\nIB^õ/Îu½}ğ†r{?tÃ1meS×q-šo¢‹¨åBoÌí‚}ñ‚ÓÎÍ¶{E)İ³Oºê[½x»`ÁúoYíB¤¿’|º²äß;z(:¯ï¥øÉPû÷ÿ¾dT_İ+™Õ»d¾ÜŒ\ZXUµ½5\r\nBÑÇB×ìCoÚ,8¦\n¥Y\\7ŠVU>Ú]îÉÑ£ «[WñOBş\\Z{Unce*ı\'#vÄûšÌø\0oı3®8;…ı\"ı´P°ÓÃ¬`—ybÏaó	ª1TJêŸB¢Ú!R±ââÙyÕí{½vëün>†ct†¨×?Wå}ë¸è7é&HS1n!­ÃŒËh°yu–P\'ŸPã:dÜ*İ×ÙšF&tCEP¾×»îÖ(aÓY`¬°Ma•¦:Dè—	íÆ«_Ajã½ÿ‰‰7ø†XE4z”æ¾Òº^kC£·\"	LS1‘‰.t#^;¦[ÎXq©ü4¹_míĞØi˜š5lÖ(XTy“ZÅÆµÍXAéİü†­ŠÖÆ§È°BKhY£ÇülÕD«I*ÚêÅ[¯,è;õLÔ”pÍšÂ`‹ê—AˆnóÕ˜Vi•¡*×Ìw¬¾ÍMò1ÿ¦Çp#˜ŠÎÀ~¦wl‹´^N›w†!ºÒÔ\ršAÑ©ûã¢Mªº\r:©ÑWÜFÏa^êõ>6n½eFMO`g¯HÍ)©èñ«ó¥‰Ù•e%n^Ş«JzTKé®òâÖ¥UÔ^>»û-ZÑxbÁnï‘k{Ów£`÷çŸ\n\n\nf.Yyé´º¾¢~Znt1ÿşsû_zÌnÏşÄÄİ¶Ú?I¡]÷‹ÿª·K32..^à“š¬¡K’şX\\q··÷˜V=(Íôşdšç»óçÏß±·ÀÑåÅÏyzï¼áyçÎç‡Od´¡Q»šá®l×xEQ¤J°#0ä (vVfh;CbC½…jµÃá¸¸¸TTTP|õÕWG			¹zõêâÅ‹?úè£Ã‡«—µD°+*B»÷bÆ“B!úö;¬´Vê4&ØyTnb“¥¤¼´Åhß]LåÓ+EŠjzö=a”ù„BYr“$è%8Ú6,œø‡÷Â:vFæˆ}p¯}†hÓ^‰•Ë³‚¨ZñÆøxÛñ;³`G\"ZB\n»»ÍÆ¿MÅ¥³öı^¬ºsíÑw1‚Ëò`¬êVòwzéş<Ë=ìê%Ø±İy<DÚUU…¶¯y’,X°hØÎÍ~ÁÕRI¯û©êÀûcÓe9\\Í¥ÿş)%ØRR°ªGoGb¤¬Ô} b#Ü†—wÅP°Óyª\r¯yã1|¡4=$6Wd·)šÅhEFéçŠ©  ¶—ŒÅŞÈ5{,;\Z[¦\ZëÌc£F‡™_k¼Á®ËøS^	…X!«$ä¢Òê’½olœ~Q½·ß†5÷3BÅy7åbÚQWèÕÿî¡¡Œå¦û:¨õúÒï‹¤aT°£GêcOùD{Ø­şoÉ|öàA²‡h;g\'Vx\'Ì£ñ Nù(¡ÆÃgIÖı øûLÉÍûz)Ìÿ­ğä#ı{æÃ!ö;gw2^/¼ô^Å\Z–UƒªªÑi›Ea¤§D2”Œé7`c35«ÄÊ¯L½xdÏÀQ]_º4#”´éŒ„Kq^géNd3½.¾•»ìó‘ÏŸ+¯JT}D¥G:Ô~GUàl¤ôõNÒeÈÍ‹\'¼Fm¼Ã\\×ÕÌfx™w7h°yµ–¨¦¹¬y/ÔŒ¦GLV%Ln{lœºm©Õ€˜<è¯ÇŸD‡|©‰Ü|Y`r:¶¾UI†½5u™0|8©+g¨q­:V›kÊŒµqÔ‚²„:İDmÄë^AíŠiê&lÔkgp½L£‡ajÖ«ÑzË+¯õÊ“ÉH“½ñZ¨ö™²ßLƒc¥–Ğ\\¹{¶Rå7_ûSÕ‹÷É²`öãh“Ô/FÛjêW<SˆáÓÜ\ZÅÈxÇ\ZØÜÍµ…ozÆ·µŠÎT™‚©­”ScÍ;SË\\ Ms$^óC¦ß‹\ZtR­WÜÚ©Ú[óqŒŒ?ÂL¾Ìè?„`çı-[½¶ö¶xù!İïõáˆ~	M»š-KaùwL_ğ8äl*-ÕX\"ØUÑRÂ•?>¥şöy…W‹+pä	hç5FÁîĞ¶uåååŒCbo^üûş­«ÁlllÜîÔ½wşÃ£İv\"µ†Ä’Ba×Sç©ø“Ñ—¾ş²½L\"ÔrLÃ0ì9;(×ßßvüàç‡mÏşê|÷Òşı””òÒòGrù½1ÜuçFgVlllÏ¡‘ŒeÚ(Cb5‚İ#zÑ‰Ó\"–ı/«{ê\r‰5!Ø…xğ9µK\"‘<x°G<èÚµkttôàÁƒ¯^½Ú¯_?*‚RIë’–vŸ­ E:{{´ô=² \0­ÿÑÌvXñ~<F)«D„çyb7„s¡ š@RHIi²ü)±l<ÄrnIØ¯†…Ù(Cb¿ø.°m;SCbã«>[’êãÇıf³Ñ!±ôvÉ‡eewz	Ùü©ËØI÷;gWáˆ­^Ç¨Ëåh\rÁ®ÄİÆ!»»×:Œªy·¸tùJÿ~}÷gdáÔMÕÚã-~]İ¹+ï…Á•ˆô1¸šÜ‰M¤íë­=\'ø0{Ø±·ş \\»Ç‘2¸}ùF†Ä\"¦ÏDu³i+6ú¡F[°kåˆ¿5÷öDQ\'”ê5(¼Ü1©}´Qæ‡· /İÇ¦}ŸÃhğô’çükÆ½ş@¯KmŒíè9,ÄÙ0‚Ú3¿ª0ö}µË¸¿96ÜòìÕÓ’}ò?ÕÍ–V3•îôÙQIv¼RZ³X³À­ûİÃz’æÓ–ö{RMa¶]k=ŠzÅ1pO Q=ËuK[Ë“E÷ÂÿÇş½x€?÷Õ‰¤HDÏa×¾oŞ,Vî²=ûe;÷b.Î6³ß’_¼¬øû’Éç°‹ºUñÑñ\níI™åşÜ¤V×‹œµıUI7Ã²jPU5éa§ó^U³È	Cùhâ\'…Ä£QF{\ZÁNMùˆc‡øº’ÂşH$óúÏ›ÎëÄ·’`—~v|ßa3å¢Çª÷°Ú×2Õ›‹z\'+O¡ŞÉ‚Âºİ¸rÕÿÅCG›ï0×Ü-!Œ·yÁÎ\næ!cÍˆ–U‡#Ô¯tŸYíÃ«‰¯UaGíKz?\nAï›šÒºY1–¯¦²*Á LT’™~©ÓÁM]ôYUÛI~3<iÔ¸èµÔö¸h}¥Æ°bZÍ£·œ¹â\n1yqÍ\rm›u\nÈ²Ê«Ÿ‹F·\r1”_}ù ¶F7õµ6Wn	F­†İ]«o½²P«â™¸-›Ô`í\rC­[ãÌ\"h•ñª­os4×æßôŒ«`,:íûAç}ÛÒ­’SƒæİhaP MŞ é/gş»BCOªÿŠk¥&‘1/–¼<–GÖÓ~u¦öÌ%Òˆ{tÅ›Üªd²[î/qòÛ¬àõ	w‹±©1´Tg‰`§Fíg§^V£`·wã×‰dÀğ1ÚA¡á×Îı{÷ºW@pÄØ)TÈÅ¿&ÅŞ\rl×iĞı»êßîA\n­E\'H¾ Ó\'Î®]]ıW×séa;º>+Y/G¬‚Ëå8q‚Çã…\rk,Ÿ3gNAùøsWƒFOÕ_üØ}Ò¤Iï¿¿ÌÁÙ‘§Q¨ÑãTCb\'¿wR‰X»¾¢^t‚ên²Ì\r‰\rñàÓ# \nŞ¶m›——×o¿ı–0jÔ¨yóæeddÄÄÄìÚµëøñã®úY/Æ9ìÔ»ëAN›Š6nBññ¦V‰%J¯J¶É(;•2Dˆé¥2Xv8. 	‚”U‘Ò\"RV‰C6,[¿BÔ^\Z¼Ø°0eÑ‰¡/;½1×©;õÊ°zÑ¶ı˜sú„©E\'z•Xõ¢á\\\"{´ùù§ÔeK‹·^a‘6u‚¹E\'æ.ùhşûŸ -ıÎ0ÄP°#¿[Îız•}ßvRËqW²X,ww÷µ7nqrp¦älÎÌvAˆ¿lïİÏõ‹1¹øp®\\I\n¹˜àxoªÄq}ûdR,ÜËFZÅÆ‘bÚ\\ÉgF¨uĞyÅ¡?Ñs´!³B\0R\r‰}\\R#Ø½¡LÌa¿4õï]z»-ïsÄòä²•ùÏ=ò«9lyEµ±9ì–OYırİĞ×M—Sâi¯»ìhìjSŞv–‰=\'-OP­\0Cµ‚„·ß›«Ş•Xà¾öeî5Mdcèíƒƒ˜Ë-AÛ5£VÅ;Æ8d™{k×7²n•Xw7ÌŞHLb=ß“÷ñ2v§Ò{¥?şLVVáŞ^DF&’Ò\rã¢s÷œJ”i~.d7g€µáñşá©ºÑ\Z¥Óz¿Ç<#uæ°Ó{‹U—FíK	³`79)¤}rˆÑõ;\nâJ{ÌÖ‰\\Ê²mßJsØ=>5¶ÿğ©òê²öm¬fRaúÌVZ™®~\'û÷âåÀ¡¿mVBª-Ï\'ì¬`2{c«Û–õhrmcò;Aí—jcj»u³`|š³&²ÊPãf¬ –	v\r³J}ºO“éeéÆEÓoÚ¯¯9¯‡‹nÅ´=æo9æâj˜`×6ë=ê\'<irÑØ¶™*(c5B…ÎìÍv­ë%ØéGFÖ/Şz¶ê±l*Œi=Mi0óƒÆ°„ÍVùÆ´ÊÌ«ó²aõæÚ’7=£Ñd™kİÒ5kš:lÙÖÈ©‰æ]·‰0U MsšÇ(¡Z¯Ö «=JÌ~J±ìá´Htœ³4š]ü2ßà\'ÆĞ—ïlXŒ›½@&¯éË•‹Sn»§•?œÖÎ0¹\nv{6­•Šªôg.Y™|ûŸ¸äŒQghGí\nğríĞGúü›£V>¬s¢úÙWeŠ¶l–Î®Cx£çõ¥ôâ2%%%‹/0aâæÍ›z±qrÂºvæèÍşBqQQ‘Ğ›ù³LNZbì­KÈ2Á.¬{?¯€`½êº”ªE\'¦¼w\'Ño_ö¤lÖ\\9“‚İŒ1/,Z´èàÁƒ½{÷Ş¸q£P(¤NG—ËMOO?¨‚ÊZhhè„	V¬X1uîGz)\nvc*\rÙØ /?\'ÑÖm¦;¹(Ï\'iË­\"äH)£G½*©\rê¯RµM\"%A5G¸C;NyIVàRÂ]o…MšÎa—‘&ù`n\"†á_mhãßš?krüs½fÎÓQåÒRÄ-L¡ºíßüâå«ß™×ò°#:\'RVU>èú\ZÛ]ºââ™Ä1Ë1’å8Ş£òR©2_jv;g(Ï™ìÚ¸rRqê@nWÏ‘¡]HT8õ—º\rbœ©#m}]E™EÔ\rß‹ RŠäz)<ªT¼#Ç>.ç„rß÷%¸Z5‚I«&áÅ\\·ÁÃäG¯ºé&À8şë‹õ!ŸjŞT#ãÍ\n¨V°ûh7-\Zª—…-ª¦}{×ıNDteµr\"5úİWÓOAeåHæUbgŠ51]zb»Íã$ØõœzMZ™V{“9¿5ìÁw~Qÿ:x«ïÌmo•šÈ<‡ k»ôVPe#¬~¦ZâÓ¡7.†ù™Z#ØÕÂêŞ•÷Á{¬Ğö˜Ğ–ÈÎ‘:\"Û³ŸÌ/ĞD`ì(N>¨¾’&ã`äğPşsun˜¶gÙş›J²ğêmE}•U«ªú³j„ş*±:¾ú5İ¿º‘Æ†ÄÒŸp­Ék(ØQHşá\rK@LXI°K:9fà°	rQ¦f¼ƒÖ;™PV­~\'»|şRÛáG6z·Ô8ª»[o!ó‚ÌCæolÚW+¾-õ¶pIKÚÖËšLßš$ZúÖÓ~Ëo*«tË„¡‚X:$¶aV©ò{iÃnHM\nùDwÜ®aÅ4uZ·v˜*®\'ì\Zl3ãCÁ\\åeÈEcÛfª 	ÁNkaôf¸Öæ\Z=cqt]¬_¼õj!ÍÕ$÷2ú 1˜ÑØÄÇÖ,F#-¡Íµçµbsmá›2Ó¶-s]ÁaĞ±©Œ7záiŞu&›*¦¹İŠV½?ÕàPÏöÖÊ²àYò~´(t»nàD9=²Œ¬¢geziæ`µWİ¦DÚ¦·«r´ühgU,n\rÁ®á$¬Y‘¾å;#û¿½8dé\n½@gVUii)›ÍV(7nÜğõõ½råÊ”)S¦Íl[ïPã¥wöìYÿNıŒ¥üïé#Uå%®®®Ã‡Ó‹É<yR3$V;Dèàüü1†‡ë\r‰5&Ø©âÆ2ìRşúıÊÿıïÔÆÜ¹s7nÜèîî¾gÏiÓ¦Qg?uêÔ/¼pàÀ°°°Ë—/_»vmØ°a	yb½Ô‚RZ±úk’S;éÙ¡ßÑ…´Ğ³h!ÙFÕsß¼İ}€1\nv6¾÷Êß(ñA,)´Z§P’J)•r‡Ç-QT#çâ¾[pœanµzØ¡Z\';Ggö²•­ƒôGƒ¦&‹W}–V^ªxy¬ëÔ·VÑÃ®kÎ_\nQUL[ú’u¼³ËÆ¿Ím§A‘nm6ŒT$çŞëÍuu´ÄÃN³ ,cˆ¡`äÆMŞ°A²`““ëd·¾ê«¯‘íî¹¹	i@ä¶a}Ğ¼ùÉ…2C¾OFGÒ9¸T‰UI…¢â7Ú’C»8“RYöÑÓß­v¯L²\'EDr¦ÏÁV\ZÖ Z{\nİ ?±y!\0©;[ü«ƒ7“éu\'^èŒÅ¦cê\'Ô]í‘zIŠw_eÙËŠ	vÅR;F´ó|¥ƒş¸×?–üõ(—‡Ğã-œÏ™ŞoÜSˆk¤.Œç¶yîáñ=k¦¡üôÀ˜ŸşìŒdu#IÙÏ«Ûôæ@Ôˆ± áu¹LDeâ[«ÚYİèw?=ÁóñáÍ{‡3~4Æå*’$ß­Wœ=¯ö­ScL°k \r¯ª:#Aj¦-×ÿ>LÏÍ2.ÅmÕÿ:ª»è„*2bXQQ°+9ØŞ¾Ïl¶÷Ã]Vì=høXEu¦ê#ª’ú‹Õr`Ô;G(åSïdş!á×®Üf8ÊŞh‡Y5¥w<ÒåÍp™¯§V0Ypc«®ZÈ>†¯ôÚ÷ÕÚŒ:\\;jÆèĞ{«gA3rgÔ¸ˆcqµ´Mf•A™lmÏPAj4½èDÃ¬ÒLoF0ıöMS1\r§	³òµ3_\\:`µidötkØÌ4;¡ùÊËØ*6®mq&\nÊ„‡¯VókÕr³°y1°A?sŠº’dõâ}²G¿±ª	î³šÚBı3#0\ZØ\niÕYæª­oó±&h®-~Ó3Ó¶#¦2?Ì0EZïflŞ…!cB¿µo`í•pôİ:lÕû“¦î–3µ\0H#œ¨~‚SåZú‚zC­Ö©IùŸï¬Ù—E5]âÂS¨¿/9¶LÁN)?üxQUò#j»üaŒa~`®€V½Üúš¿çrM\'ÈªÊV*•b±8((hÒ¤IŞŞŞ|>_ 8Ğ„`\'®®¼væ¨B.3‘2›Ãí5x4ßÖÎpW`ÇrÈP–¿¶x\'F¢]ßOwVÍ^§Æ´`×Éß±]»vãÆ›;wnxxxQQQ¯^½.\\¸àééImSÇŠD¢;w¾öÚkûöí›2eŠa\n÷w­¾ºíiU¥Ù2—ˆåºøï;†»„Ò&ö¿”Uv¾,[>ÂY´É\n)”H“\nGTYiTŞoÆwfL|×ÖŸ\rğohÂ€ôÔÇçÎD¿öæ\\æ[BA®^vÿNÎÂ^æ4p¨£_kzhsúcÉ¹SeN—R:uµ]¶2€ÅÆ\r×ì‚Ï¬\"e²¤Ÿ˜ÜcÉ0¯…M#ÏÌïtä¥œßâóÖ<²p•XÓ0\nvˆ$ÿ8ĞãâEªüìÂ[?ıœ0‘vá¯ò/WÄ<&VÙ¯÷°‹—©øŒ‚D‰_ç<Ê—àÕÕÜò\"·ü\\—‚Ï’ÇY‰î¥¹îÒdg²TØ©‹àÀ)œÇ·ÄÎ\'FíagëÈİMª„Ukvjı.£¨Æı*¢+kB1ŸaìÄdç–Ixla°j6]Î–($¼‰áŞ¨ô›•DÈkª\0Æâï]°æíSîÕÔÏÈÏ\'^ºí@µÎŒ†³í.m²jÑ1¢\'Ø!Çülf¿w•ı¼U~ê’è •»†WÕ¦ÁP°S\\ï%+‘rC:aé×Yƒéíµ’`ûç+/IÈ*è	JT¯bªE´UT¸z\'Ë.B¾áól[=oYÎ,’Ë-Ä\næ55-3`ÕÓhÏÓn3Øf\Z÷:ÆŸOE,¥e\ZÜ­j1&=ñÃİÒ[LN-¢Y¬m²“>]×h2ô×+ĞÓì¸=¨¿¸‹:¨,ÖÄdì¾ıéLZf‰^ ¡`àëüîÜÁÍ÷zP•wúôiww÷>}úğx<…Bakk[L\"®®Œ¹z¦ª¼„q¯ĞÁ9¼÷`Fµét)9Õ¤L5Ââ©f¯Sƒ«†Äªµ\rÃ.e;OR©tppèÙ³ç•+WD\"I’l6›\nd±Xjç¬Î;Oœ8qçÎ	v×~^yyë\ZR©4]2”•2Ò®UèÒsw#(2nÂî	›pi‰sHz\"A‘Ô?†±«İ{—÷üÚ˜ZG‘“™z*úDuuõü%Ë6¬[M…Œ3úûçz®Mu u-†F¼äåÛÚX\"\n9±kKÎ™¿JBd4“CGºN{Ó“ÅÆ÷™¤(ªYJX‰I1’…#zü&µEÀÒ\\0\r³`§\"ó£y£Ç°TÎtTå%Tëw“!xôw¿WjfàbìJ³ÛzOöGL)¿¬Øµ0Ï¡$Ó­<Ã7?Í¥8ßMœÙzòç?³¶Z‡j;jÃÓEQ¡¸8a©Òvãêñ°ù¥XQ\nó\'t”ä³+	vMÀËK3+«ÕÅ¬*qœÑ7°ªêQOBkè1Æ²³Å¯ñmz#õ;Dß‹H(Ä¸\\²¢Éôo+	vRU›\0=ÁN¶•)ÜÆŒ–^:Á´Kqm¢ÍÀí¦;³ìÒ®~XUhêB]ƒ}{|ÆâÚ[œ³Æì¬`^SÓ2³\0V=ö<í6ƒmğä‚]‹É‚¥´Lƒ[ U-Æ$«v-&§Ñ,Ö6ÙIŸ®k4co„\"xÁÉÄõÃ_‰Î­–i-º*¯‘uÎocIêÏQnaa¡³³3açS¯sÒsÒ“ÔkP¨qróğòok8o6Ú]JíEoQí´eÈœ`×Ş‹^U©TRñY,–ö„w\ZŠ\ZÉ‰ÍfÇçTëíM¿zñĞ§ó¼Î´PˆgÃë3bÌĞ/¾5‡VË«OÉÇØ¢RÊ¹Ç»?téÚg™rrÄ1ÄfÑÖK¤JS“+éLsXô¶:vÚS’„¹é³ÒS%çOß»]]˜GW+OnÇ®v/wòñ7%QU†GõÁ.á$cx£vêÂÌŠ>?r¤==¡ VcOüé3,BûìÔ$H/İ/L»›.}œìRÄ‡´óÖË®sÔ$T ×«ñÔx®åŠìèm~İUà“5íŒZ×N,l\ZÃ¹|_üí²ò*Ó•€¾(ÎB´x’CßNV—;\rÁŠŠXï[_1ğk˜ÑˆUÕª0‰5•»²ÒâŠòr¥ñ/\"|¾€/Øğ(,¼©\ZS°³‚yMMËÌXõ4Úó´Û¶AZ¾Á-Ğªc’Õ»“S‹hk›ì¤O×µ\0š£‚\0\0\0\0\0\0\0\0\0\0\0\0\0\0Mv\0\0\0\0\0\0\0\0\0\0\0\0\0Ğ‚\0Á\0\0\0\0\0\0\0\0\0\0\0\0\0Z Ø\0\0\0\0\0\0\0\0\0\0\0\0@;\0\0\0\0\0\0\0\0\0\0\0\0\0hA`ÏÜmn\0\0\0\0\0\0\0\0\0\0\0\0\0\0¨#I²¹m\0\0ëÂçó½¼¼šÛ\n\0\0\0\0\0\0\0\0\0À(999b±¸¹­\0\0« •JÙl6—ËÅq\\a´.GıÕ¡H$ ØÏ> Ø\0\0\0\0\0\0\0\0´p@°a@°\0@°\0\0\0\0\0\0\0\0há€`<Ã€`\0€`\0\0\0\0\0\0\0\0ĞÂÁx†Á\0\0Á\0\0\0\0\0\0\0\0 …‚ğ‚\00\0‚\0\0\0\0\0\0\0\0@;à;\0`\0;\0\0\0\0\0\0\0\0€vÀ3Œ1Á\n¡~¡T*Õ! Øÿ!@°\0\0\0\0\0\0\0\0há€`<Ã0\nv,½zõºvíšF³Áø‚\0\0\0\0\0\0\0\0@;àÆP°S«uíÛ·oÕªUppğ–-[ÔšvÀì\0\0\0\0\0\0\0\0\0Z8 ØÏ0z‚Z­ëĞ¡C»víÂÃÃ]\\\\d2ÙÂ…	 Øÿ@°\0\0\0\0\0\0\0\0há€`<Ãè	vÔß3f;99ñù|GİÿP( Øÿ@°\0\0\0\0\0\0\0\0há€`<Ã0zØF;à¿v\0\0\0\0\0\0\0\0\0-ì€gc«Äb­ËQµC@°ş+€`\0\0\0\0\0\0\0\0ĞÂÁx†Á\0h,ÁÎ¾Uûv^âwÓš;C\0\0\0\0\0\0\0\0\0Ï\Z ØÏ0 Ø\0\"Ø¹t7ºç­ƒ{ïäT4w†\0\0\0\0\0\0\0\0\05@°a@°\0\Z.ØÙº†¾:õÿìİ	xUÕ¡÷ÿ‰$„„Â		d`ÂŒSĞ¶Zê„VÛúÖ{ßÿc{kkûüß>ÿÛ§÷}zÿOµÕ¶¾··öo‹T­Û*Š¶¶ÊX†ªTÄ0		f$üsÎÎÚ{¯µÏ9;Ó9›ïç}ûì³÷Úk­s‚;¿®áÆ¼¶O_|réŞnpÙH8ïú9SÇäff\\h=ùñ?Ö½¹fk{o×	\0\0\0İ„ÀF`Ht:°Ëºé®{®(xîxÃ²_¾ĞÜÛÍ.cçÜtãÜ+Ò#.~¸ö××mïíz\0\0 [Ø!Àì\0‰NvyÃ¦|éŞÏähšØ\r®˜<*çÄ†öôvË€\0+¼ó_—öÏ;^¿ì—/š\0\0ŒÀèd`7îªÏİ<£ºãEÛùÃ/=ñÌ\'¡c#¾üo·5mşó^ƒ}F=øİEÇ·­~qåëĞw=8¡$ÿ²ÍûêW®ÿÑ>ÿ4æóßıl•¦íø“yà2b´]wYö€—ò¿ûÅ|çÁ–—ôT]Wİ!ÔÿZlİŞqêì#ÏüzÍáŞî\0\0€à\"°C€Øìf-¼kşø’ğË¶×¾öúºZMK]¸økã†e¬}õåõµMŠëœÖiŒ»ĞËÙG.Ï¤*ÔöÊfÊ®\'$T`\0\0€nG`‡\0#°$:ØÕÜxÇ•Fê¯ÛÛN¯ıë¶ï¿é®¯•kxéé—š.J×Á·v…³ß6_»Ü£:]$°s&á\0¯0ü²y½˜eUÙ Ùi‘jö²m?Ù¶™ØÎè… ÑŞ+q·×v0|,¾nQw—½·„Ï¥»u.°“7_lOóúõGfÏÖÌ¾ªÜú±Ê8{G•qVäë¡°¿øÓÎÊÏê…÷\\w\0\0\0ŒÀğØåÍ>{´ùôùS¯½ãÚ©i‘wÚO=Ş\'??3µã7êÒö¿¿öê»Ò‰±¶ÀnÖÂ;ç²zÅ²\r»\"yİ¨Ù7.š7Áú±>2Ï¸vó±|ó„súµzğ—åºYxÔŞæ/|w‘ÖğÏ§^xC,¿Å8ZlˆvHHCw1Ï½Ã‘®YşÆúnZ¤ÏŒ¦š©˜-%Fœ¹&ÍÚ¸£¸Q¨ĞU;œ)ğÒÈzztjgÛk¯§Åİ-1ï¹‰¡Ãî}èÎa}3ÄCÎˆm§fUóÅnbPıô™FN»HxÊ¸H\0\0€.D`‡\0#°$|v…w|máæ_=W§iËkñÊlíbk«–™™î8ïôáİ¿yæ÷\'$%ˆÂ^©ãšzáüÖ††ş%%B6Êìvi1vF—˜]xx’=³/m\'d.á;vTi;¬,¯ãuU•l2c,CÆ„I»1ŸÿjásìU÷t³ÊUboøj¯3°‹·[ÇJÏ®ä6ÿs÷Ìª.4Önxş«}uqä«dlg5Ó–kÎ×¶ÀNksæÌ™;w®ãæk×®]·n]t\0\0@r#°C€Ø>»±n¹yfÙ»//ÛXw$5½âkßº­¿vvËÚÆÎÚ75Å~®j^$°¯^—e^§ï€ynùÒS1}èÜ9{|ffmFº×b‹üÜ! íˆÆØ9\"Ånc†@ZdàSˆ3²\"¨Âp(ò\'í³ú°¸ğø¸Ÿl“iÅy›â@)‘0¥´ãZk•#°k÷Õ9Í¿ÍˆìÑÕÍ„ÈhŒŸöÊ»Ø»EuÜµÒ^n½0øî½{D^¦şCë‰O~ûß¿ı4ËÍovt’GÚZ)62¾ÀNsev¤u\0\0\0±#°C€Ø>;}‰ºCuï¿üòßª®½ùÚ©•)ánZåµ®aqgß	çz®2\"cÖ¢í29³EˆÏ²ìW…S?Í\nø¢vz\\¸­ÿøñZÂv»&Ázv¡UÅB	–Ï\Z	ÔŒP¦924†EÙªv¸S1ïòÕÂuÖ={r;‚ÎµW6%6nñÊ¡lËÁõà¢mÃÇÎ¾åúÙy}ŒùèmçO¬óÕõÛ÷Çp©¼ù=ØiBfGZ\0\0; `Wx×¿,.éï˜x\Z\ZIw ÿØû¿vsÛ »“¯ıò™Ÿsb°ûTÏã“L¥«Ñ™Ñj\n­¸\nW`×qòŒš}’¬>¦Ï9›¶¥W;Û\"`ŞSbÿdDWÆÀ3Í¤8.R\'PÒ<Æx¹~ıÀÍ¿–m‡Ñ3İ\"vñµ×ØÅİ-Ş3ˆÍTµ§FØeôò™›oW64ÕùN{ÓŞV½öçCg.x]¯j¾×”Ø.ì´pf×ñIë\0\0\0âB`‡\0#°$âìŞñµÅ#d‹‡ÌéxÎ,O½\n¾s\r»|sãë]}Tä‰£ê:Øı~KËâÛæï«=˜èÙym:aÅ-ÆzÿÒÆ	¦«òH¦\"Y#°«Rl¦Ú-ì¸¦ÄÆÙ^ÍØÅİ-Òãöır{\"°K­œ2ïêùÓú»Ö‹´\\l=¾eõ_×¼·³]u†²ùôQÜt¢+;\0\0\0ø@`‡\0#°$|L‰]ğù{gVÙ.1W»·-ª¥y­‚oÛ%Ö¾a«1¼n§0æN?¢	ï)±\rZIeÿã®à/§ÄZ?ÎÖ\"£ìŒÉ—‘©—²TÉ•´…íøSdî¨4X	½[å®Ñ}<›ŸõLc›kjßt\"Şö:g{ÆÕ-ÊÀ®YølŒãİØÍ¸á‹WN,O‰~â¥º­ï¼¼j“êmEóÅNo^¿ŞÜZ„À\0\0 Ø!Àì\0	]~ÉÔÅw\\ÓÏœúz±µùÕg—í<~.¿dÚ½w]Ó×<­íüÑ7–şö£æÓ²2l5ÀMOgßbB³Ü‰Sbó#›ÆÆ±éDÖñãZÿÌMÆ@¼Äìz‘$p\"rI(³Ş5|I,g6l[ı‚ñË\0\0€  °C€Ø>;MKrÕÍWÍ“®iím§×¾¶|CmSÇÑùŸ»gVu±~Æ¥ö3›şüú;ìQ”àì¬EëZÂ£ääTÏÙFØ×ú‹g´Ãë4U`\'î-K`çB`\0\0\0$(; á+°2j|UqÿÆî9t¢ãÇ¬È—ZÕıí·v†+8;Í9P.²Œ^Ş.Ú&”d…W©ë¯Çg©×Í› É÷™UvçëÜØ\0\0\0H\\v0;@Âw`ç0|ò•Ÿ›;æpÃ¾÷·lÚÕx¤;«L|\0\0\0àòB`‡\0#°$º*°ëAv\0\0\0\0./v0;@‚À\0\0\0\0ŒÀ °\0\0\0€G`‡\0#°$’0°\0\0\0€ËŒÀ °\0\0\0€G`‡\0#°$ì\0\0\0\0 ÁØ!Àì\0	;\0\0\0\0Hpv0;@‚À\0\0\0\0ŒÀ °\0\0\0€G`‡\0#°$ì\0\0\0\0 ÁØ!Àì\0	;\0\0\0\0Hpv0;@‚À\0\0\0\0ŒÀ °\0\0\0€G`‡\0#°$òòò\n\n\nÒÒÒz»\"\0\0\0\0\0‰¶¶¶–°Ş®Ğ-ì\0‰1cÆ=z´_¿~½]\0\0\0\0€Ä©S§\r\Z´mÛ¶Ş®Ğ-ì\0‰7^}õÕ999}ûöeœ\0\0\0\0$¶¶¶³gÏ:uê7Ş˜?~oWèv€ÜÆï¿ÿşO>ù¤ã?½]\0\0\0\0€!##£¤¤ä¿øiŒÀ\0\0\0\0\0\0H v\0\0\0\0\0\0@!°\0\0\0\0\0\0\0\0\0\0\0\0@ì\0\0\0\0\0\0€B`\0\0\0\0\0\0$;\0\0\0\0\0\0 Ø\0\0\0\0\0\0	„À\0\0\0\0\0\0H v\0\0\0\0\0\0@!°\0\0\0\0\0\0\0\0\0\0\0\0@ì\0\0\0\0\0\0€B`\0\0\0\0\0\0$;\0\0\0\0\0\0 Ø\0\0\0\0\0\0	„À\0\0\0\0\0\0H v\0\0\0\0\0\0@!°\0\0\0\0\0\0\0\0\0\0\0\0@ì\0¹sç/j>ÒvşœÖŞŞÛu^jZZŸÌ!…³údÄuİşıû{»ê\0\0\0HJÃ‡ïí*\0İˆÀ8wşÂÆÆ¶ÌœK}új©i½] áµ·¥?›zşÔ°aÅqevû÷ïçI\0\0\0ñâ1G`HÔh:¯¥]ÊÊííŠ\0É$åÜÉ>Z[é°¡±_Â“\0\0\0|à1G`HÔíÛw±ß ÆÖñioK?Õ\\>²4ö+xÒ\0\0€<F\"ğì\0‰ººº‹ùÃz»@òIo9P^^ûù<i\0\0À#xv€à\0\0\0z\0‘<;@‚Àğ‡À\0\0\0=€ÇH A`øC`\0\0€Àc$À °ü!°\0\0@à1G`HØşØ\0\0 ğ‰À#°$ì\0ì\0\0\0ĞxŒDàØv€?v\0\0\0è<F\"ğì\0	;À;\0\0\0ô\0#xv€à\0\0\0z\0‘<;@‚Àğ‡À\0\0\0=€ÇH A`øC`\0\0€Àc$À °ü!°\0\0@à1G`H,°kŞ¹åÿ~iËIáÈÌÉÓşíæi½]¯„³æµ?ş×û­e½´ï;ÿ{UƒùÃmWİpûÜ‘Ò¢~·tÙŠ}\'só‹şß‡>W(¿›QTÉÈÊGï½º·›Şeì\0\0\0ĞxŒDàØA\nìôäÈ}Ü3Kº5ÿôÉ?ı½å¼ã¨˜¦¹sOM}Ö­ıëÿúÛNÍ³“­Ï…À\'-\0\0\0Ä‹ÇH ˜ÀÎJ¤gg±:ÊŠÏ¬@Í\ZFgÉıÏÿgq¹ëG‹˜ë©;ñ;´\0\0\0/#xv€D`;+u“£ íê³Oúü_w|v^e¨Ÿ¬LÍì%çV+ã\'Æ:&Õ*;Ûh¾€}\nv\0\0\0è<F\"ğì\0‰Àvš!±r(Mˆ¢¬vVÌä\n˜\"K¶‰ÃñÓlí‘“m•7“1Í5«´X1«\ZBfe[F	±œ£¹‚3EU½8;+³úÁ•èIfK;½n¹ùı´–S\'	ìxÒ\0\0@üxŒDàØA\nì\\ŒxKÌ’„xK i‘ J¾Ö›Pš2°Óós­è­«;‰À±§cÖô†Ëîk´Ôj»0IvÎ/ío	ô«úÜsÕè?şm;OZ\0\0\0ğÇH ÈÀNŒ±«×‰ÁœÙ²9ı×<Pë+ésÆX&gPè^6®«;÷òsîÑpŞÄ‘€z!1vT…;VÕ	Fİ::óJ-®*%;\0‰iwËîG7?zèô¡öKí½] n¯ŞújoWH8<F\"ğì\0‰Àvaª	¤òé«ª*\\«¿)³*wˆÖÕÇ‚t^¤»FÄØ	äo™A¨yqfˆÉ‚À@Úİ²ûÛï~;#=£OZŸÔ”ÔÎô¤–3-v€‘<;@\"ÅÊIYn~ÁpíÔÇ-çÅ1eÖAw`gO\0ã\nìä».¨sv±œã±ŞœŠ=¦ŒD~]Ø­ÖKˆwĞ_² °€¾öç¯;,+=«·+øA`Hñ‰À#°$‚Øi®1hf6Wô¹2íù÷†#¤	zº4sòXmïî¿{k…°èkÇ	C—vª…ö´èé˜m>éö¯¾;½«vºîÒ:üÂ/k8ÑªÿP2nŞ]7Ïßn¿p|ÓêõÛ÷ì=qêLë…6MË_ôİGõ|Ç¡‹íyêGË[ÌôÏ}ık/¬ùÈúı|Ğ{Ö½¾|í‡q–Ÿ9ïÖÅ³+…_Û¾cWÌ]tÓ¾A	çóø|NVcë¤ì\0); ¤ÀîwK—ı¹¥Ÿt%5w`÷ÈõÅ…R¤ÜGî¨úeèEÇ	şñæ»V`\'æeztó”ØH¦¿¥uÛ”X4ÚóLÇ”i&\'ŒmÔ»”¢N5ã8é$W`wöØŞW~÷ê\'-g…ó	ì‚À6·¼rK~ßüŞ®à E`‡À#°$‚ØE(1T’,[\nN—æ<Î•Šóû5¶œ„¥‘îh,ÆÀ.–À«;aºn¬Æ‰#i´¶®ı7$=O`UvŠF]¹`neéĞğOgW½øÛ­õÍöó³\']{õ¬©ãóz´ÛĞålş¹7ø7!°‹|Ğ¾»ôQjæÎ™>4/ÓñV>iş¼Y¥Cù%;$5;@ŠÀG`H%°ó@ê^Ã.”.pn&;ò§’ÀÎˆç„\\,ÖÀÎ¼i$Àê†À.RxŒÆyl¡k1=ÇÖ¶a}¦èù1%V×‹İÁm«_\\¹AÏPSÓ³FVT—¦…~Ê¬ °Kz=Øuhİ¹­ödëEı½Ââ\n»DC`‡¤F`HØ!ğì\0‰Àv»œ»Äšé’5.OÏà4!°›æ‘\0š	Zô)±ÎzxíÄê\'°sïª5S,Ì§I)Ò=»Xõ^`wöÕ¥K¶8>œ:¼bbué@ó»\0hxæ‰—Ÿo×V>©fÆÄŒ¼¼z«ş“’ÒwÒ5WÍtvéY¦ÍÚO^fóº¿|`NŸ&°K2vHjv€ÀP`âNÙ1“=°3Ò+óÇf1°s”›ÊõpÊ¢oÅJµëÂEÙ–ÒÓ:ØåEbµH\"-S†‰šó[\0*›k+À.ªŞ\nìÕo^úâ_õğ%­Oÿ©ó§ç§g(\\Ë¢ôpöÏıº¶étøuú¨	Ó&Œ­\ZxqßÒåïê_…Œì‚isfMê²À‰ÀIÀ\"°CàØì€“,İê?>¿¡¶Q?8°¸rò˜ÒA%%ƒrÅ+í{xqí3Ğ¾çÃM[ŞÛŞt¬å\\ëıPZFf^şÀQÕWÌŸ=)CVˆµ_íÑã§ÚÚCÿÍÈÌÊ0tì”i3®[Œ(ÎwEhÿ`Í›ëşññ©peìµ½ğÁúÕÖî9Òr\"¼I®æqßÃ;×/{eŞ•ù#®xğîvücí¦­µ‡¶\\h»”’šÖ`ÑÄé3­«Äó½eæ•,ş×»u¢÷ÜŞyåÙ;?\r¿ÌtíœêĞ¨·–§éÈ…Ğ°»¾Å³§N®œ2.×ØÕ\\såôñ•²Nì^å\ZvÒM\'.œiZı×\r{\ZöŸ8}6üá¦dfõ+\ZY6iêôªáÎHßŞoÎ]P¼ßípæøş5ï¬Û³ïà©s­¡;¥eä’vØğğ¾Óß{÷¯ìØ£;.TT:¹fÎ¤ÑCcëò„F`‡¤F`HØ!ğì\0	;ÀŸ¤ìŠûşÍ’7N„C±””¬±³j†÷P5¡*Û~¥ßÀîô/¾øa}³ê¿”9e_¸QQ†-‚;øñßÿôÖú–sdW¤WßzÇÍ…QS;y`·}İë¯¯ı°ÍUÛö—/ùıŞ£§¥¥–^qç7æX]iìÆ”¤–53ehùäE_üLÏÀÎOïIíZóêŠõÛ5cĞ\\MUEõĞ¼öÏ<½ëğ™ƒÃFÏ˜2¡z\\Ef·víïıíµw¶Ô^h—¶)eØèIŸıìµı…u\"°kß¾á/Y÷ÁÙ6É½²ó†]{ëgÇíiĞğc§¤7í}ÒFO{ëu3“}ä)’\Z E`‡À#°$ì\0>°+ŸX5¬ş£î=¬¯^§õ8¢frUş ’Ñ%ƒWÆØ‰ƒşıõ—V¸Ïû?“Ãªgİû¹ù‘*îüû\\}¶İë¢¥ßyC¶æMš(}şÿ¼Øx:²¥YÛÙ&¹)cf.üì‚qf=#QQèù@ù4R\\]s÷ç‰9°³b²÷ãï=uµMÇôÊZ—ğôövèyVV^á¸ŠR­«;û.±íë^ûİºê½[”7hôçï½ÕJ!í‘œsÛbwÉ¬[ZæÀ›ß5v‘ÁŠ\r×û×¥ŒyÓ-ÆÇÒç	‹ÀIÀ\"°CàØv€?	Ø9ôé;pRÍ¤¼ô¬ò+ÆÈHs¼+vÙ†Í™:VxóÔ?Ön9vÎØdÀÊhÚ/ì}öÿü¾ù¼™¤Z:¶²,»Oê‰£M;?ŞÙrÖ@—‘=èö‡¾<ÜøOì±å¿^¶§ù´ùV~å˜Ê¡yÎ¶ìØ¶ıĞñ3V×Î¸é®«®ğşwI’(µíİğÒªá§3¾,¼naqE^ëk?MK-\ZYYQVÜ\'­ıhÓşÚÚ=g.\ZÛ5ô-,û×¯Ş®w¥3€KÉ-RV^68?çtKÓÎÚİGN³j[³ğî+ÇµhªİÕ¨wSsİöê˜\'„¦©ŠsAÓ3s+«2~wïy9Ş´owã½ğj#ƒk««İ~,_æ¯(¢ug`·oË_–¿ı3AKÉÎ-(¯şpOÔ×íÙßt´Í| \Z>vÎ]·Ì•M%5°;{ìãç—¬<jô^êÀ¢£ÊKó²3:zoÏÎ=ÖG3 dâwİ ßÈµ=nÊÀ!#ÊFÌÏÎhùtÿ{¬m4RRúİô?¾2~@´Ä8ÅØ-øöõL4hªÿ÷Gj÷övºDG»n>¸á‘e\'’¢Ø^úhÛÖÆwüß{ÜØåå—-÷Euq”L`HØ!ğì\0	;ÀŸ$\nìRÓ³‹KG.+ÎÍ\\=j„;şñØiZ{sSıæuß×t¸õRÎÔY“úZõØóÑÖ½ÖŞ/Ù³n_4¿,ôÌÁm«_\\¹Aÿ–’’5¦fÆ°~}ô“.µÙ¸öÃöÌ¾ıû8hPIùè±¥išI¢TûöKw†î›ÕhÍôñú*fámL³÷ïÙ±iÓû›hYƒj¦T[=P·mK]“QLzÖ€k¾øÅIÃh®À.+oÈŒWô1¼Ôvâ½\rïY}’;¤òÁûo½O`W=~ôÉ8{¯Kt[`wìåÿoiİQ#Í0lêÔ±}„âšê¶o¯;Ğn~ôón¿wÖÈÍo`·yÕËİZ§Í\\:}B…õ^jkÙ¼îıF–—9÷/Í	ßÈØõ<rÚ„ÑÖUçOÜ²ùã3mFt;´bÖ}·Å4°11ÅØå-~lÖ\r‡\"1M8¼;üô½ï½ÛÛ@0„Òºúj[ã‰	ì\0); A`ø“D]XJ¿ÂÒ;¿rû@Ùp-G`wõ•óÇW–J‹U]ºtòã­»¬EÄr•š‘–²ÿŸûİ›Í5ê²§.¼a^8úûë/½ûá>ë.³§í“•[2²¤NVû…3õu{E†­¥ª\Z–ï1ÊÉ™(Í®üÆs\nYKV>alyQQYùPs\'Üó§×Ö6˜UJ8¬dÄĞ‚´”KÛßşÃ«[v¥d\r˜}ãõ³Â\r·GE©#*\'W•Èê7`Äˆâ¼¾™­gZÖ¾ş§-{ŒX--£ÿg¾rßD¡¶öxÈ™Céâí½.ÑMİá–½²Úì®ŒÊ)ÓK\núfåô/1<üák:P»êOm>c4kHù´û¾xMŠÏÀîÄò_?·§Y™V:fJEñ€ş…ƒ‡š•‘zîôñ?ÿáåíû\Z5¬˜yÏmRœŸHŸªé3FôÏî—?hDÉ°¾©gNyã•å»›ëogæİñÀâ¢ÏÄ8ÅØ…Â”I‡íCêŠ¿½tüU~¡Må,6gVıûše{ÃŸµ7‡Ä„Çmû`Òxı­­O¿ùãwÍ°FRˆø–qÄH#»~X¹¡üù…âP8Û(ÂHÉÒj\'ëMĞ‰G„b­ûºekïúÙ1\r1“W²¬ú±ÿ(÷B1+ú¤&Úo´Ì16rÁ”¥Š¡3C\'}n”äYÅB§i‘`7TÉ¾¯9r^£æg¶nÕ&jŒ°:ÀG`HØş$x`7 hÔØ‘ıwo¯¦š¦Œš|õ¢ë¦¹¯ôØiÚ¥óçN9|äø©S.edí¯Û»ÿ“††ÆCç.XË‹ER˜×ûÔ‡Ÿ´XÕ›:¾ªlÜ˜‚L}j(Àªıg]{ŸÌ~ıòòóóssûz®ıoK”ÊÇMÈ<ÓT»÷@Ç³SÓr&ÎŸ9¬ÿÀ1UeBâÒ~æäÉ£G<uJËÌÉÏº´wÏ¾OöÕ7n¾`Ffb€åˆŠ&^5»8¯`LuyºYÜ§;V?ÿ‡\rf¬–9ùú…Ÿ™çK`oïu‰n\nì¶ıí+7ÕZÅN›;uPnaeeiºPâÛ/?³¥î°Ñªüâ;î¹}HNŸØ7ëºbï¯{ùX{LgyƒË¿xçç³3l\rÏÌŸ:oÚĞC«Ê‹­l×»¯¬øûNıuZFŞ¼E‹j\\K=&‹X;!¦QsÌ\0Õ§O\ZáK8Ü±b¬HÈNjÙ/±p°uÚˆ{B…äXQ YŸÈkÕ\r±](vÓ7‡¯’&E5Ì|*’\ZÑ˜#°³*æÎ=%í-°sW2Ü™ƒ>2Í¢×Ì×Ä\Z–tv¡jkOÛNVt¦Õi¹îK‹®l`Yõâ’Úeï2%è\"v<;@‚Àğ\'ñ»©ãÊ.µİ¸æƒSæ2m))}¯ûòW&\rÊq\\é7°ÓÎß¿åï[w××=~ªM¡(»Ù3§«,¾<›œ˜(‰R\n‡WLª.	Ï„µÅ\\Íûw¼ÿÁö½\rû[N‘VÔ#°›tíÜ±¥U#\nÅ~Ûóß?Zné£§Ì»ñ33¬±5±vñõ^—è¦ÀÎ5¥zbIuõ œ>ö[¿¶|íGÖ­¯¼õÖ©%ƒ|vª^vÍ€a7/¼¹¼x€£áÓæÎ7vLav†ufGMe¹_IöôÏİ¼ º<I‡ØÅ\ZØÙ2Ï%ÛŠ¥ù¦I~\n‰¤Nö“OJs·ê5°î‰œTÕĞS­Ã[\'j›­,oº¶uâ ÍØåzô¯ÀNZIU`ç¨¼4°³ÕG¶>Õ™’Ş.‘WL~‚Ğ5ìxv€àOâvW.˜[V”»ş?nªı¤İ<©ÿ°±_»÷Çà5_]û‡«Wıyã¶QÆ:)»êUÚ¦zÅEÚdö+¨;fğ€‚Š‰cr#ÿ]¿°öµë?Š²%«g`wõÌ)ãúÛfïùå–7/5aÖ5×ÖX»yÄØÅİ{]¢g»³kª]ÅîZú¬[Ï¾ñº™•#›»?°»îÚ««Ë‹\rŸqõ•Ó¯¨ÌÎt|âSn¼nÎ„ê¾±İ%Ñt`\'Î‘tM\rq:³¿ëL—Ì“ÌgkÚ·¿pßQ`Ÿæi^hì&j¿ßÑ6FLZÚs}XYx|Ù6íñ¶Ànı0!G‹Òi©²M«¤¨´’ÊvöVvú¼Ô(iìœ—(*f½–Î‡«@`t	; A`ø“]eéĞK—\ZŸûÅË‡NÇSR2gŞvÏüÑâ.~»Ã;ÿşÂWŸ5ó¦”Ô´ì¾9¹¹¹ıóôK=óÏêŒ]şĞò«®œ×å]¸&}ÆÎºáæ¹c¬#;6¬zuõVk–ijZzßœ~¹¹yù¦ŸnúĞÜáAØõ©š>÷ê«§‹©™kÎìüIÕcÂ‘V¸rÑ;½×%º)°s…qÆR€¢u¯.[»}¿Ñ*3Ô;áFm»sœútï–îqu…£nÓÊ÷óhrfnaÇ—YlxjZ¿i7|f¶½á®9³s¦t]·÷°ÎM‰-+ËÛ»×6ÒÊ9%v¢ŠÙFØuI`gÕÇ6ŞMvGUCÄÍ›v\\5d³#fŠØİ»yÈÒé‡îı±¾öĞô¥ì\"‰•±J lğ »’ÊÀNÓËÛÉÖ°êãÙ™Ş#ì3+óûáQò8; kØ!ğZ[[?üğÃúúú#GˆÇİ]~~şèÑ£;~#ì|v€?ÉØu¼şğ/¿_õİÖ »Åc¿zÏ-ât?İ_^~ææ’d}r\n§Î˜˜“füwôXÃ÷wZcú\"‘“¸éDfŞkoºa|×vé£&LI;¶o÷\'Ÿê7MëSpÓ=w5fşŠ{h¹‡O\\mÍÕü¤öƒû›R”]ÊĞ‘o½ãz1¾Ù½îõk?ÔÒ2ò¦,˜=¶¢:öÀÎGïu‰îÛtâùWV›óI3ÆÎ½ş–9ãìÚ¶‘-^5mâX¿İ‘—Zº¯E¿Hß`Äk±9w`×ñ‰š8ï–jÄ†oxí…Õæ¯@Ç—sæŒicØI7ì«ÎÚºoJ¬U·“_PÜQ³×Ùua(w3nº`ÊÒ›ÏÍŒuJì6#ª{Z{ÀˆíÆwÕ”Xy€%¯¤G`\'~RQ¦Äš…«:SİZõQUÌhÈáUCJ=æÃjv@W!°Càµ¶¶¾öÚk3gÎ,((ĞèqÜ¹sçÚÛ;^·wüØÖÖvşüù––ã{öìš7o‚Àğ\'‰;MûäéŸ¾t¤Õd–’’=ÿûg‹Ä«^üÕÖúcúë¾ÅW-˜5°s—›6¾<%5-3+«oßœúÖl¬ıÄ¼<9Ü¶ú·+7˜ùKÆWŞ|SM¥yÚÙW—şfßÉ”¡ÅÅ#KË*++ú÷ÍĞ¼¸‡YõùpÓ¦C\'Œ}f”L|à®R]õ/*›8nÔ Ô´´pM³ÿ¹z•µ£¨:°ëx«à¦¯|iL®•ğ[şëe{šOë?ô8bæä	£…9³Q;½×%º)°ëøl—üü·‡Î\ZŸmNAÉİÿã®¡¸íë^}í‡mÆ×/kì¬š‘CŠ:¾c¾v‰ÕVÿqÉ†ÚCÆ×({àu÷,_à±¡°ûÑúæ¿óÁÅVÎ×~aß’ÿZ~Øü)^5uÂØjûœÙ$s`g„>Z½8î‰‘íA5I`g¥TÆDT}‚§mÓ	aY!±l:¡	©™üVxŒ°³İ=ÆM\'„ñháFIÆFBI×œP#ìT•´nŸkU^\ZØ	I_´ÎÔŒ†\rÊ*:;sˆŸíãF`t\r;^kkë³Ï>{ß}÷iá¨®­­½ıRèÿ:uº­-ôSÛÅ¶³çÎ8q2¿Şê5ï|qÑ	ì|v€?IØi›W¾ğ·m\rÖÒ\nFŒàî…z¼Ô~áğò%/ì5G?éÛAD\rìÄŒ/5=kÔøé7^7ëÒ‰C›Ö¬ŞòÑŞ¶H­ÄæØoÿû7Ÿ˜™ZZŸÜy7}vzÕğ¶3ÍëşúWñªâêY÷|n¾gcİ‰ÒÔæ÷Ş\\µq‡YHÆô›ï¾z\\Gó¼ôÔóûZŒ›¦gæ]1sŞÕ3ÇŸn®_û—¿~Tÿ©Õ\']‡¬¼¢ko¼nÌÈ¡\'›ëßyãÍÚÇ´Èİ§*R%,y5°óÕ{] Û;mÛ;¯¼±q§900%wPé‚«tt×¹ãM›Ö¬yïã½æj})Ee“Ç•ç.=¢Ğ_`wúğ{¿~ö/gÍ\'´œ#®¾éº±Ã/œ9şÁæµş±3+¿ ¸¸´lôèŠQÃ3$ŸH¨\ZyCFßtó5¥…¹Mû>~ûÍ·÷·ßÿÔ´¾ãj¦4xlà70ˆ+š9VÓÜkØ…·Õ_n}úÍÍÓ5\n—äœé^OXÖÍ:Ù¾)î(ÔQ~¡~Ó×ŠfEZ§9Ï‘UC(ÛÕ±—…~_Ç²zŞkØ	ûÏÊ>¡’«VåÜĞqaä|3°k%eÚ*å,c×}½;32¶Ñq‰¦¨˜8+V)E`t\r;Ø}éK_êxİŞŞŠèÂ?yñâÅ¶ÛNŸ9Óz®µÿÜuë×Øá²@`ø“\\]û…Ú_şìÕ“mF¢’š–sÕ}÷Ÿßøª5Ö”:¢ròÄñã*¢vû¶üåå·ÿÑ­Nà~ô·ß½¾ùœçN©yWŞvÛ¤ƒ2ÒRÕgI¥“Ïı×Ò¦SÆÔÌ~…å_şê;şöÜòÖïşúşŞ¨ÿ9—6sL‰MIÑÏFüÔ7ğØQ#\"•‹Øùë½Îë¾ÀNÓü~Éò=‡Z¼û9gÀ°©SÇöIÉ,¿bÌ€Œ4]‡?¿¼äıºCŞ÷JËxÓâ»ô™ÑbÃ=>ÎoÁ°ò±cË‡öç‰]Ôë=-ÎÀ®K(ö!í}’M3ÃÄ@ÂV2ZÅ¢ìë E`‡À³;}x]xP](¶k9~üâ…‹a¡ù°§õïŸ»~ÃZ;\\ì\0’+°ëğÖ‹O¿_YÃuHù´ÊìO]FvÁÔ9SŠ\n‹…UÍéK–î>tÜõŸÉ”¼Âá¹)Çëä9€;¿ù/¯oøçî³Ú4™´Œ¾£ÇO10§_AQU™Ç?MòD©öW^ŒóJåÖ”µ_hxşé?<qÖUHÊ áe—N46­‹,mæˆŠ*ÆÕ¼÷¼3gLÉ8|Òäª>ZzqeõĞÈ„ÙXv‰õ×{ÕvüĞ¿üùİ½šÛáæ€!%W\\QÑ§ãÏüÂâÑ¥CS<#9Íóİ‹­Í¯-ÿÓîFÕ½´´>9ã§/˜5qTnnßTWÃGeïİwĞumê áåªG¦¦e•«ÎÏHÒvvŠ%f–•ŒR±²êÇş§öûÌ.@`HØ!ğì\0	;ÀŸ¤ìN}ºù™%³&¦¦åV¼»vßùpv–’šÖ·ß€ÑcÇê—9¸´jDa´X1£9Õ\\¿víÆºOœ>{¾ıÒ¥ğV§¹ÃJF–+l®ÛşÏºú2úúü÷–gkÒ?İ\\ûñ]»êššœ	_Øq0-=#3«oá¢‘%Å}ÒRRÓ³ËÇVõ÷JLT‰Òg~şâá³ô7²óGÜÿàİu=üIíºõ›?9Ø|¶õü¥ğF±9¹†—–ÊÛûÑ?ö4f§ö8òKÜ‘+‰Šæô;Ù¼{W]óñSÛÚÅ–¦ñS¤rÑ;Ÿ½×Iİ\ZØiÚÅÆººÆCM\rûê59{î|[(âLIÏè“W0pøˆÒÁù¡/UvnaeeiºşİòØu8Ô°{÷=uõ\rG<ş‚±ˆë‹TV]™Ÿ™îhø´yÓÚ?İ¿{oÃñSg:*)~:¾…Åe¥C{8ğêJvèvút`¯­iı#°¤ìxv€àOâvZwn«=Ùj¬ıŸk(r`ïƒGOY?öTÒïÒ±Ææ“â9YyUã*2ÕÅW˜ÍÅOöìş´å´»Yı\nr3Z3Ş*(*/6Àz÷ìñCuû»¨d—5|ôèÂœL-ŠÛş±ËLsÒ‹ÍMZOnØÕpØüwÚĞ²Êâ‚¾—.­«İÓr¦ÕUHJnÁà´Öc-§õ‰´iE£ª†åg»£¢)£Ü{ğ‚k2oNşàÑ£F¤»+×T¿«±Ùü)³B²ÏŞë$±bé™¹ÕòÀNÙ½ê/ƒ®½©aoSsK›üé©£·‡”—‹İÕz¢©vW£¹‰³£<ß½tè“ºƒ‡U÷\n}‘ŠF–éÚÂTVÌ<p°Ùumjşàaå#†¤hI¬7; ËØRv<;@‚Àğ\'»‹­G?şhïyó¿l)iÙƒ\n2=y±Íd—•İoDÙÈÜÌtbíÍ¥ÍM…F®µ_ÒÂ[ö-Z4x@îI!ÊÈî_=vt¡ÄK—.|ÚxğèñãçZ™¦iáÁQù…C¤¥Ä˜Ä”(õÉ0¦º<Üöæƒûiim½d\ZÑ6¸¨¸ 7«©~§•Zf÷4ftI³llWö¹“û[Nm²³Z*­kÿŞëŒnìÂİÖzøà¡£ÇO´×Ùiié}ròú2$¯¯ónìB.œ;yğ`Ó‰“gÎ_¸h²“}‘¤C/<º¿±éÔÙsáAv‘ïCõt¯!°CR#°¤ìxv€D]]]oWHV‰Ø¡kxOÆDÒ‰y.pØ!©ØR<F\"ğì\0‰ººº¸B\0ºxwxÒJ\"vC`$;@ŠÇH A`øC``vC`$;@ŠÇH A`øC``vsYvŸÿÃçs²rRSR{»\"€v€‘<;@‚Àğ‡À.Ø¢nw€äónIï·8qşDfFPÛ‡€#°¤xŒDàØv€?vÁF`0—O`·ãèGV?’™‘Ù\'­ãìtì\0)#xv€à€Ä´ãèÇ¶<vøÌáöKí½] nv€‘<;@‚Àğ‡À@¢¹å•[z»\n@ÜÒSÓ‡äùö´oÎİÛu‘<;@‚Àğ‡À@¢a‹X$£öKí.^h½ØúèüG«\nªz»:@\"â1G`HØş$^`wø…ÿ^Öp¢5ö®˜»è¦9£ÌŸö<õ£å-æ%ãæİuóìõ¯½°æ£óXş¢ï>8*öÒô8;$¯sÏ\rè3àWŸùUoWHDv<;@‚Àğ‡À@¢!°Còj¿Ô~öüÙŸ]ÑÛÀ °ü	@`7¬|Òüy³J‡êÛŸÚ»E£®\\0·ùÃ¿	]ö¤k¯Åf©@#°CRc‹X@…ÀG`HØşØH4vHjv€\nÀ °üIğÀn@Ñ¨©ãÊ¢^SX\\av\rÏ<ñÒáóíúñaå“jfLÌ8ğÁË«·êÿ!LIé;éš«fØ	ŒÀIÀP!°CàØv€?ìÎşñ¹_×6¿N5aÚ„±U/î[ºü]½ÄŒì‚isfM\"°’\Z B`‡À#°$ì\0?°»rÁÜÊÒ¡±_ÿÎ+ÏnÜùiøeö¤kçT‡²¼–§éÈ…Ğ°»¾Å³§N®œ2.·;Û\0 3ìÔì\0; á?°Û¿â‘‡_¬Ÿ÷­ß=TcÛøäí?Y£¿´¿!¹Ò}–pµ×åª»¨ŠUÖV,Íë~ÒšG©#‚/xİ®5¯®X¿½ãEzÖ€iskª*ª‡æµ¯xæé]‡Ït,6zÆ”	Õã*2»³\r\0:ƒÀIÀP!°CàØş»Hd&„VbŞæ|Oz­í,×Õ¥w>şØmÃ£^®º^Z1wÌ÷¢‡oá°N*¾”Ğîò¼À®Cc]mÓ1}Vlf…1ûõôövœmı×0+¯p\\Eiw6@§Ø!©Ø*v<;@\"şÀÎeVZZZ__/]zô¥ÇlÆ9’4Ëö0¸M?n„tbQ»+îR¬(VY[±2!Ñ‚·Ğ©f9+º“fÜ¾qQ¸„p™%Ö½k„;)‚H$ìR2³²òò•VŒ™?{R†ëíãMûv7éx‘™[=¾2<˜®­®vû±Óç;^å¯(ÒM\0Ğ)vHjv€\nÀğØıLûÆc·5Ú§’Ú7=3“ESö	¨‘Ó4w`\'ËĞTwiT;\\QÛHYóî¼³áEùdYÇ}DNz<’Øm|ò‘å\rÚ¬[ï¨Æòb£mVØ\'Oş„’3°‹ÈÎvı¢Ûªåtg•\0ô¨8»ß¾ş‰æMõÿşHíŞŞnA—èh×Í7<²ìDRÛ‹B_\0mÛÓÚøÿ{ï»¸dó«µõé7ünl—Ø*v<;@Âÿ\Zvk¿E!g½#gŠ>×T¼‹ºXUm­·6ªV·³ß+œ½\rW½Ñ	ç^i,Y£Íˆ„xš1O\\kOş!É${`×!;¿ô‹_¹½(#µ;k çÄØå-~lÖ\r‡\"1M8a9üô½ïÅ­\0*¡ïÒ3ÿ-«~ì?JÅ˜ÙØ*v<;@¢ë;cU83=s¸c‹\ZV$kEèŒs—Û‹Š7°³Áë‚À.nšJçiœ1kÃrí¿>Rl\"İMA’\n@`×aHeÍı·^ÙµĞsbìÊÏûI‡íCêŠ¿½tüU~¡MüúÚO?³êß×,ÛÎø¬u1·\Za_xÜÙ¶&×ßÒ‡S…Ê—\"¾e1ÒÃÈŠ›Vn(¿£@~¡8Î6Š0R²´\ZÆÉâˆ0ñˆP¬u_w£lí]?{ŞÕE¼&¯d8ê×!5+ú¤&Úo´Ì16rÁ”¥Š¡3C\'}n”äYÅB§i‘`7TÉ¾¯ÙrŞPõ4{Æ:2‘ÀP!°CàØ]Ø™ñšGÉ;ÉÜUÛ”Uaâ«&	ì$wQÍ´.­í~Y†uc[¯)±5ÆLáoh?{¥ø±›nß4ãñâåáÉ¸\Zs`*Á»E£¦+ß¾Ôv¾åØÑ¦ƒš>=Öfş×-5=ïóÿKEJJÏv€nk`\'Ä4jœEŸ>idOápÇŠ±\"!—k8•£p°uÚˆ{B…äXQ YŸÈkÕ\r±](vÓ7‡¯’&E5Ì|*’\ZÑ˜#°³*æÎ=%í-°sW2Ü™ƒ>2Í¢×Ì×Ä\Z–tv‘ÈÌ:YÑ™V§åº/QTÌ–ÇÅĞÀ˜¾l;@…ÀG`Hta`gÆ`ƒÕT›NÈ5iAò»¨Š•×6şÀÎ±ôœ1œ®f£0ÛµãŒW´Y\r´o<6cÓ#?Óf•lĞn5WäÓØL6x’.°³4|üşÎğÎaécfßøÙyc{ Ç\0t·X;ç()ÏQÅÒ|GÓ$?\n…DR\'ûÉ\'¥¹[u\ZØ	wŒDNªjè©Öá­µÍV–7]Û:qfìr=zÏW`\'­¤*°sT^\ZØÙê#[ŸÎêLIo—È+&?AÁ–FE`¨Ø!ğì\0‰®ìSZC<¸sä¾<¦«­óÅªjÓ”Xó<Í>ëÖ=ÊÏ\\Rï‘å\rõ%‹¬(Ïqe3b ñ»+Ì­´M§Ò:şówöÔ©ß}ã¬Ä:}Ô¤97^?“½\'€\0èşÀÎ½™€$¢Ùßu¦KæÉf‹³5íÛ_xn_`Ÿæi^hì&j¿ßÑ6FLZÚs}XYx|Ù6íñ¶Ànı0!G‹Òi©²M«¤¨´’ÊvöVvúŒÚ(iìœ—(*f½–Ì‡µW!®´N#°Ôìxv€D—v’$M5dMà&YgÎóR¯»¨Š•ÕÖU›è£æ¶¥ó´È\Z%&dKñ!‰%c`§ÛğÚ«?j0J5¡fîœéCó2{¦ß\0tŸÎM‰-+ËÛ»×6ÒÊ9%v¢ŠÙFØuI`gÕÇ6ŞMvGUCÄÍ›v\\5d³#fŠØİ»yÈÒé‡îı±¾öĞô¥ì\"#ìŒUeƒİ•TvšæXŞN¶†PÏÎôa§¨˜Y™ß÷?ÎRµ8·&°Tìxv€„ÿÀº+VßF\0wJÂÀ®½¹iÿ¶-ßòÑŞ6óPJJö„+çOªC`@§6ì«ÎÚºoJ¬U·“_PÜQ³×Ùua(w3nº`ÊÒ›ÏÍŒuJì6#ª{Z{ÀˆíÆwÕ”XùYy%=;ñ“Š2%Ö,\\Õ™²èÖªªbFC¯\ZRª˜«Š&£!°Tìxv€àO‚v1ê7pDÍäqÃ+ª	ì€\0ˆ9°s€\nÀ:,Î^tvVJeLDÕ\'xÚ66pË¦ššÉïèh…Ç;ÛİcÜtBn”d,a$”tÍ	õ1ÂNUI{áö)±‘y¦²ÀNHú¢u¦ft 0lP6PÑØ™CüË¦»Æ³Ë„ B`‡À#°$ì\0Ø¥¦çŒŸ1mpN¿ŠÉãòØ(H~qv!âŠf•ã4÷\Zvá­Eõ—[Ÿ~sótÇF\rƒÂ%9§gºÂ–u³N¶/EgÅ@Š;\nu”_¨ßôµ¢Y‘ÖiÎsdÕ†Ê6Euìe¡ß×±¬÷\ZvÂş³²@¨äªU97t\\9ßì\ZBI™¶J9ËØu_ïÎŒŒmt\\¢)*&ÎŠÇc\n÷§ë*.G`¨Ø!ğì\0	;ÀŸdìÒ2rª&O\Z–—İ7põ¨Äu@\0ÄØu	Å>¤½O²i†c˜XHØJF«Xôıaı °Tìxv€àO’v©ié™Y‡–*ÍNKIMÏ.[Õ?#­\'º@7#°³W,1³°¤¨d”Š•U?ö?µ_Äµ¡D,ì\0; A`ø“x]‡ÖÛjO¶^Œñì´ôìÒªŠYİ\\+\0=„ÀİNŸìµ5­v€\nÀ °üIŞÀ.5--##3¯AQñà–®¤7; ËØ*v<;@‚Àğ\'!;\0—5;$5;@…ÇH A`øC` ÑØ!©Ø*<F\"ğì\0	;À;\0‰†ÀIÀPá1G`HØşØH4vHjv€\n‘<;@‚Àğ‡À@¢!°Còj¿Ô~öüÙŸ]ÑÛ‘<;@‚Àğ‡À@¢!°Còj½ĞšŸ™ÿ«Ïüª·+$\"#xv€à€DC`‡dÔ~©ıÂÅç.ûáÜ^QxEoWHD<F\"ğì\0	;À;\0‰æ–Wnéí*\0qKOMÔwĞC“\"­TxŒDàØuuu½] YØ\0\0 »ñ‰À#°$aøÃ;\0\0\0ô\0#xv€à\0\0\0z\0‘<;@‚Àğ‡À\0\0\0=€ÇH A`øC`\0\0€Àc$À °ü!°\0\0@à1G`HØşØ\0\0 ğ‰À#°$ì\0ì\0\0\0ĞxŒDàØv€?v\0\0\0è<F\"ğì\0	;À;$˜}Ï-^T÷àãÚÃkoùÁüŞ®€nÁo:p9â1G`HØşØ\0€€Yııio_³åó÷=·ø{Ú—İ7²·+„0#xv€àO‚v;¿ÿÍ×_Õ*xbáãHó’GŸÿùAñbÔñ×ÊÃ+mGÚ²ØN¨zh¹ùûBıÚ/ï]¼è­ë–;ÿîé8ı©òåË¼\Z/cŞÀ(£ãªkŞv•&Ö#4ÌæÉ¶šé#oBŒ¢#7Œ¼åİçyû[V=——?%½Âv«šúQG*šâ8dswoèÙùàİ?²	}­1tšy@QmÉçú¹\ZoŞUò©…JÙ­×Ù£±Ò.­ªªÚ¡)¿®î?ŞãıuĞû_õİö¸Jö®ós	µHõ»öøuo=,vSä\\uÙ¾3şşYˆÿwJú=[*/2Æ_.u±Ñ{Ø×µÊÏ—×Pök§îOÅ‡ß“Ì¨+j­”¿N	ÁúöüÎÄî™^E`‡À#°$ì\0ì‚+ôg¤8×LÈ>Œ¿dFGŞ\rÿÍiüUã¼Ğ^¦ãï8I$`/ÜUš­áÉJŒ”WbÄ¤WØÿFu„G»«vŒ~ĞÎ}ï-ÍvLÖ:¯ºIÏ÷ØIş¾–ş	©lc¥ÚŸ»´~®Ñ“ª˜;EÚªúºº¿ş~Tmô¸ÊõIÈÿ´WV>zv.°óõÏBü¿SÎ¬ŸÍüJØEıåò,6Jû½V/ÊúOì÷o•‘$Ér$ı-i²ŞCä\rM€1É0°OÀG`HØş$Y`·uå”%»Ì“~ı;÷Ş_~ypÃİn¬µÔ/´•^}Ã=¿½¾Pó(GäQæä›ŞûR¥~Ö»¿ùé7ßïøÿ½k¨·Ë>Yz¦~Ó¢šß™5Ò¸ş–Gpéî44MĞ¬?&{Å–58ÿ‰üm«ŠÜ¥	w×ßnªS åİ„˜Â[Í<®_úTùC£Ÿ¬‹$*o>«]·ûI¡ië<î$?ß_`\'»K,c>Ô¬Ëó¯j«?w-–ÀÎìä·Êıv_Wgë|ı:x´±¡Ó²òÚs]ØÅüÏBü¿SŠŒ\'rTØyşrE+Ö«‡;q­´¶’üÓú„ûE\ZY]ÕÂ…ÚJMö›ö½ºÑÚÊİ²hÌ\Z`©ÛSŒ7Œd}¶ª?©=ÔÑ©O\n•U|¢ö¤Ø,8\\ßİ£;şÏÊÂ=¬[¨ÿÕ·gT¼´Şñß¥å»ş7RRÕqÉW×ŞoêÉò†¸Î·Îe”À °üIªÀÎ{išlÉâ0Y`g¾¥*Ç]U™V\rGb¯aÅ_¥gvg`ù;,ÊX‰Ø9¼…^—H†Ø¸C\r{à¤¹¢œhT”&Ä.8êC`çšù`İ\"ë/ÛP¤PöCÛ¼ZÅßî^3ë¢ü­¯ê?É[>»(#ìJ$øª«­üÜÍŸ¼;£Ø²gÍ:û	ìÔ_WGãüı:x´±ó#ì”•wÖ·Ó#ìbûgÁßï”¬@ë¸¦ì<~¹¢;Róİ:sm,™¾ØŠ…mâs\r÷İ\'ÿÒêíµïÉ?ÛdaÅh>Ù,òó3á£pOoc+Å¹àÖaïÀÎvÜ9bÓjeL£e£•o¶¨:®üÔ]_\rÇo“ª!®s\\DbçB`‡À#°$ì\02°ss§QBJª¦wÃ5G²æL§H»<ÊÔV<Rqÿ¿ı`¢> n·Vt¤ö g\r•™šëL?Šd­ÈäB¯eËo-”ı‰oûkDµ\\zÚ ğØşâôZoË,?JÜ£$ªl³ÖÜõôükÜ¬‡¸™‘&EÂgË–‰“÷)ZCld??¾5Ô4ÉßóB3Ô=ºÚ(íO×»Õö?%Ö\Z]©³Gc£}x’¯«£åş~¢L‰UşÉ†Ê?iå=é}Sçò€¾ÿYˆÿwJY ùF‰G`§şåŠZì|MºÅr­êÓ‰ØE~Ô¡ªíd{qæ—^S%§Ú«ºÑ:M¯z(ÿ3ßV7S“UÔ™»:ˆa„G7wi`·úû‹÷–[cUÇÕİÇ¯¥s\\ª2°#±“!°CàØş»ı+yøÅúyßúİC5QJ.¿´¶ñÉÛ²Æxíu½pxšªØ(µÒKóºŸ´æQêˆËBvâ9’ãæ¼WÏ)±^åHêc+S«ùúĞ?×B³b÷½¹ô¶­£C?¾ï]CU`ç:32×\"vÍq“ı9ò¤öPÔézÑşp7ÿ°|°n‘xšùw‹&[!ÊvÕË0j\0\0®#IDAT¹0õÈ¾xšë/Iõˆ¡Â×jhö™}zÆ0|Æ>ßÊØhC•Œ?µ…7”­‹õeEô ÅÖ?Š®—o:!o£¬?®wµåŸ»ôJ{í…fØ;#ìT_WAÇ;E=#WŞEv×ğ3Â.æâÿê\\`§üåJĞÀÎõ?:ÄØEf@ïóìœÃöBçEF¡:nÖàÜFh§z>¬}|š{$¡ûwÁy[Ç¾Û~¡dåß¥gË–…¶8Ò<;>0×V5Qæ³ºâØÅ2,ó²C`‡À#°$üv‘ÔLÈ­¤•jâ™ÎÃZé?vÛğ¨—«®±Væ{ÑÃ·pX§	•\n_JhwYKÈÀN1%VfIc2õ”XqÚ©²w}ìej5+®?zÛí‰\'jö>úü[ïyğĞóÆ<eÉ®v©ÎŒ\'°S®¾gpÿm*ş,YÇiß¾‘#Gj1vÒr©GZÙŠ°sîÆï”X«	ÒÑ+ÎixŠa}\\¦jV–`\rQ\r‚JéRXŠóıvÎõõc\Zí!íY¯W]mÏo‘:Â°mªĞbßQïÇôëàï­8çÍyWŞV_kØÅúÏ‚¿ß)ßSbÕ¿\\İ=%VõéD™¬§#éø ì×Øfˆ[ve`ça§Ü¹Dz‹x;Õ¸•²b\Za§ZJÒ5Âîš·ïı²:«+¾/ò_<ç”XYC¢vlÕá@`‡À#°$âìŒf¥¥¥õõõfÖ%=¨ºT[Ü¦7B:ı¸4±ßÊ*Vë]+Ï1yîzo˜å¬PèNšqûÆE‘n(±îm\\#Ü)Ò¬ƒ?Óf•¼øâ\Ze<‰Ä–D]é›Ko[uÄVf[¡ãZxÛ‡[ÂsT÷…Ï	¿vÎ!µŞúr“¼1°{×£L­fÅ½Úÿzt÷u÷~kÉîë¾soÙŸ9³ª\Zº»}ª3c+ÔJÕ™ê¿Ì¥òFşÔ!°“dâß-âœ=EiòÚYSe}m:aŸ‘5\\°ÕÓ_`§şyğº·2Ç©¹‡#‰wò:ßw`gOë´®	ìœkdyUÛ_`÷¸ö°°æ}—vQZîû×Ág`\'‰U½>—h[Wvó»úwJÑ‘ÛìóìT¿\\Q‹uwšğSÔk•Ÿ×dM×ºÑQÚÎör…´ş¦Ä:âªğ}¯{È¶=êÎ‘ÁñO‰U/Û”XÅ?©Àî¡‡v×•-s.®\'=®îNïß;eCa7; á+°û™öÇnkg“JºØ\' †\ngUš;°“aËõ„ËÅ÷¨•1KöÎ;^ôÂkœk$rÒã‘Änã“,oĞfuÜrxG5–m³Â>gŠ§‘Ô%±$\nììÛªêäÇ…ÀÎyƒĞ[š¢ñ€G™ZÍŠïT¼óèóoikµÑ+¾3«ŞZäNUCw»TgF	ì­ÑßŠuÓ	×Hâ1Ü‰Ø)ÖKad„ªrb#K=)¯&Ä0}ÏQOé`ûŸâî)±÷™{\n:Ïi^ã9$wòê\rçòõ±v’A9ÇKÚFõn^Rö¬wµıv¡ı3å#•üv1.>ÿ¯ƒ¿·d_Nu\"[åıv1ÿ³ÿïÔHÍ\Z‡6?á(ü—K\ZF‹Å®^½z~É^u^æY%OGZ[å*ñ7)–H/–2mƒ-ÿkƒ×¦#İòÅ˜MÇ½]#å¬ÿª;çv±²Ï³s#ì\"P£w}FšøU?%W`\'okØÅÀG`Hø_ÃN\Z¬mŒØYÃÉ$cáLÑçšŠƒíÔÅªje¸µ1Úš{úÙáìm¸êÆH8÷JcÉ\ZmF$ÄÓŒaxâZ{ápO>jI$™;sà›^¾í?µ7¬!fúp3ısĞ™,ášZxNS—#R–\nìfiÂ9aW\nUÉ’LM~æà8;s\r;¯ÀN½¨ó„*Ç_é®ÏÆ¾ÍÁÂ(™Näo!ÏTg¤«ˆ¿—[{­Æ6åSÒ„(äKêiŸ7æ¨“Y’lr©{pN¨şêÖ¹\'£y÷Æ–kŞ?°Ól„ğKÿx”·1Ú‡»C“.‰\'TÛW`§©BF?úëêæã×!®åíô«×–—v|¬•?°óõÏBü¿SÒ¿2Ñ;Ï‘oQ*ZõWl¢¸Vş©$›Eê92.ò¦léHŸ¶páÊ•+]…\n±5G6°P‘ÊË«ù]-•8z¡¶råûÒrQ6út¡ùÏBèŸH[f¨\\ÃN¹Ùƒ¹İ¶Ğû¸¤¹æíª¼ÿ÷\rYC\\#Oãší~¹\"°CàØİØ‰9\\é/j|X‘¬9¡3Îq\\n_@.r(ŞÀÎ>¯»Pd¸iF({¤qÆ¬\rËµo<VüJøH±=ˆš¢)†í!i$X`\0&ÿ‰s‰!Á?X+ˆA”ö(B&Vc‹y‘<;@¢ç;ÉÜUçìZsâ«&	ìÌ\"…\0O5Óv¸´Vûešç ¾hSbkŒÁßĞ~öJñc36İ¾iÆãÅËÃ“q5å8ºıvÉÀ\0zJ‚GB—¹ÿtº&°÷·PukDµ£/W<F\"ğì\0‰«ÚtB¨IË0Ã6û›ªbåµŠ?°sl:a§«Ù(Ìví8ãmVÃíÍØŞMbƒv«¹\"Ÿ¦j\n]R#°\0 áu:°“ÌV\'›ıK`;F×)ñ‰À#°$z4°ÓœS_Í3‡ù™û4ùŒÚØkÓ”Xó<Í>ëÖ=ÊÏ\\Rï‘å\rõ%‹¬(Ïqeƒ5—À.©Ø\0\0 ğ‰À#°$z8°³\rp“¬3§¹ßpn7ï[B.V¯¸ºó£æ¶¥ó´È\Z%&\\KñØ%=;\0\0\0ô\0#xv€„ÿÀ6®XQ|½^ì\0\0\0ĞxŒDàØv€?v\0\0\0è<F\"ğì\0	;À;\0\0\0ô\0#xv€à\0\0\0z\0‘<;@‚Àğ‡À\0\0\0=€ÇH A`øC`\0\0€Àc$À °ü!°\0\0@à1G`HØşØ\0\0 ğ‰À#°$ì\0ì\0\0\0ĞxŒDàØv€?v\0\0\0è<F\"ğì\0	;ÀŸ„ìn¸ûÑµƒE5+¾3kd/tO€„;¶âşûÁÄßÿæë»n¸ç·×vÿ]÷=·xQİƒ[~0_<ğäëıª‡–/»o¤óªÕßŸöğJãõÂÇ#WG.–_k9Âqñ°¬òÒÛ	×{TÄ_+\\=f{ç­ëbi7\0\0	‰ÀG`HØşØ¡ÛÉ”-[ııio_£ÎÈô3Şm&Yá\"F‡^ÚÏéD9˜òv?<Un^zG“e~şZ!ë1Û[±•\0\0$$; A`ø“ •Ğ9~ÜºrÊ’]æ©¿ş{ï/\n{ÕVDøø§î3e7r_>mß›Ko[uD?zKhTšş²yÉ£Ïÿü`Å÷kß4\n¯xâ‰…B/ôj„ë¬¿|Ó{_ªÔ‹K®ss´Â(Vq²ª!B3·J›/TRu¡æêÏPC*ŞÑ®_.¼ÚsŒ‘<U-\\¨­Ô´m“æu‘Ì™ïhölÍ›É¨Êi{C9mŸâv1s‹¿ª³ªó½ºÑÚÊİŒ°\0$/; A`ø“ •pÙ;i–4ğYI`W³÷Q÷™ö1zêÀîİßüô›ïÛŞ0Ã)=°³WØV·(»dÍxKØiÊ“EÒ¤OÚQöJ*\"BI·„¯ÕÂÑ¡]†[!Ë@û{®á¾ûæ;±Pîô–¶c‡>\'6–ábV@Ö`OèÔ3G£”32¶v«·‹\Zúm…¢Ç¬nÓ~øCí{L‰\0$3; A`ø“p>4LØ‰ìƒÅôå3ggšl%ëI\\8„Òw4GÕ….7;3¿32¯[Ì…á¢vFæï&*éu²³»ôú„s4W3%!]øµêÂğ}5±Î†,GÛEáˆŸì“@õÊ+€Š„kÎh-¾İÄÎ¬Gxy9ÕvªÛ-x7ôÿ?~İ[ñy­ç«îÀÎì&5ì\0\0ÉÀG`HÔÕÕõv€d•€]dº¥$°‡†yvÒ3MªÀÎ6—Ö¢\'eÍ¬JŸ²\Z®íÑè#‹4/wæ}B?(Nv÷šÑRû4UwóİÙ¥ëB[ÿ‹½\Zn»fi”Œõ“ò§\\ÎºÖJÙ:Ø9Ò:ç‚tÒ\ZxvâJrŞ-ğÓ\ngERM6\0\0$9; Á;ÀŸDa§O\ZÄRîğËvº\"°ó:ÓÄÀN+ i¾2°s¬šgŞÅÖ«á·´¯ß?ú­%Ö¼¨¼;ïQŸÔÄ)³«}M‰©œHgœ³ğñ-×¼-½]‰343Şøò^ûå‘òâm…ı8‘À\0äìxv€àO‚vŠ™¡Â2jÆà/#“’vû¼Î4Å:%V”pSbÅ|ÓÊÚ¾Ü¤j~ä.šìÂLt$’ª4Êv{ü¤ÜÂ~‘tX÷äÚ¨kÉIËQvÎ‚T·sŞWúl…íc\'\n»Xfá\0€ìxv€àO\"vîı^“ozoâ.×Ø7E´´u¥úL“*°“m:¡ÙN“¾­ò1m:a«ä»±l:áji(wÓTÍw®ag¿ğ&m‰¢	Æ}ÍæËÓL)÷¦öüÎº)Ç‘‰sK¥a˜ûti9®)±ò‚T·ó ;ß\nïQ‡Œ°\0$1; A`ø“Lİ—*­«ú†{şS{C5ySÒ.×™&u`§9Â2÷÷kßÔÓ®È[1vš9úO-,9\'ßCq²xÕFEómwq]¨n‚#pŒu;M?Yû=Øv‰µ²;Ï1e‘7£n0ëY¼eØÏË–wëD+ì\0\0E`‡À#°$ì\0.°“„Aªã=¯9\rR“N¨Ÿw9cÁp“‡\Zï¹\0\0€; A`øC`Ë<°vó\0@÷\"°CàØv€?‰Ø%¾Ë7±²æÏ2¼\0\0øsy?Fâ²@`HØşØ\0\0 ğ‰À#°$ì\0ì\0\0\0ĞxŒDàØv€?v\0\0\0è<F\"ğì\0	;À;\0\0\0ô\0#xv€à\0\0\0z\0‘<;@‚Àğ‡À\0\0\0=€ÇH A`hûW<òpã¢oi?ù‰ö­ß=TÓÛÕ	;\0\0\0ô\0#xv€à\0\0\0z\0‘<;@Â_`·ñÉÛ²F9O¹%¶w\rûz±^rVäúÒ;ì6Õ”wWySV)½´yQ ‰M“6Ğv‚P}÷…úµ·6>òğ†Y®Vvœ¾¼øñÇfl\nŒ3o`”ÑqÕŒM®ÒÜ]`«™>Æ.tÀ(:rÃÈ[ŞMpçèVI=/^®º\"@ì\0\0\0ĞxŒDàØ>;W¥D®ÃŠĞÍy/©Çvw¯Ë#o¹Ë4ß‹%°ÓÙdƒÙÀpNVâ¸¡P/MÙ”M3lïXù—„Ù\nw•f«Gø‡ÒÒzMcì¼š[`\'–àqE€Ø\0\0 ğ‰À#°$âìôˆKOãŒAm¡`§8üÒéÄsìWWÔØ·©^ÇswÉåÆ9¥¥¥õõõÎ\"=Çä¹ïëJÊ4ëÎ±r‘Í#°]ù3í‘#‘š-f®w—&Ü]34ºM¨NLwb\nìl5#°“áI\0\0\0>ğ‰À#°$âìö‹Áœ…ĞÜ]ô	¨‘Ë­WÃıÜ½QQìp3kt×È˜?zç\r/Ê\'Ë:ëíagŒ“…]ºŞµB4ç€·ĞëbÉÀ7w`gä4[…b	ì¢4!†ÀÎQO;´\0\0\0à‘<;@¢S›NØÒ	ãÕBäØF[0‰ï´ğñyó´5kêÕW+ï®*¶Æ~²k¬±˜\\lcñ8!œôØ‚U¶†İ<YògËÓ¬¾”¬”\'Ÿ+Ät¶é­ö1p²Õôª‰ÒÇ«	³õ$°“éö\'­ƒî~tc­ã`QÍŠïÌ\ZÙİ“œÂ}Xqÿ¿ı`âÎïóõ]7ÜóÛë»ÿ®û[¼¨îÁ-?˜oYııi¯4^/|\\|Ç~Õ“;B¯ªZ¾ì¾‘Ñ{İ]?ß~«ËQ&´Á£\0UK½ïîî1ñ·®‹¥İ\0\0$; á?°3òŸÈ¨8G d¼!¦=‡5>¬ìì7g@Ë­A`»ÇØÙÇàÅØiÎí4sp_”ÀNó*\\êá43ñÒ„¥ä$}lïæÈ 9á¦±Œ°‹!°³ÅoîÙ²zØÉØAÆH¦„°*”aí6SªğÛ£]™xX<_u\\)t’¦Ÿ/f]1–£<­ã‡§ÊÍK„{¸o.k©÷İİ=æèÌØ‚J\0\0’ÀğØ™1šk7Ta›cæª&	ìTSbí—‹‹Ó™—Û†ò©îîˆïTÕsµÊ+´sgZæ‘bé|Rë¿ªQ;i¾h_^.2ÙTUšlô\\©cºx§ÄZMpÇoÖš¼v2=ØY	ãÇ­+§,Ùe:ğëß¹÷ş¢Ğ ²WmE„ê>Ó}3×µÆš—<úüÏV<q¿öM£Š\'X¸À:zmT¦:4~í¨½ã„}o.½mÕıPud˜ÛÎxN–u£E[¥-ÕïbVUz¡¼ùïÈÛ¨£g$OUj+5k¼˜3ŞŠd_‘WqdÖªã^5ˆœù)Ærb¬†Šª¥šòîòªó½ºÑÚÊİŒ°\0ÀğØ™q×<W~%KÜj¤»v‡°sóØuB~wå^^ÕsòØIã®H|C`çÒl‰—¸¬¢4yí¬©²¾6ˆ4!¦ÀÎVO;™\nì&ßôŞ—*#?\Z9š4`\Zø¬$°«Ùû¨4‰“İKršÌÙO¿¥…cµ[B³MµwóÓo¾/\r\rCi—z×^‚Ñ¨¸NI“>Uæ(vòˆPÕ|E•ŸØ¾çk¸ï¾ù<5ÅOG‚f :ÓH¸SŒåÄXY÷oPŞİ«ÇBqöÃjßcJ,\0 pìxv€„ß]bm¬…ĞÖ¸G½ŞÒE»\\uwe±¶ëdEúŸkE\\‘ù±Âx?£Äè,İ²‹¶ç¬ì¨YÁ›bì¼›Ã”XG=5;‰nÒÒÇ‹É;‘}™ş£|æ¬ãLA¸pÍ>&–`vÕâ[šÊ°[yb0ÚÎu#sŒwÓ½OvöŒ^¥pæn‘;¤¿V]¨jşAi£òÈÕä3b!ùó‚wåÇ£¥Wæ‚qUÂÄÚÊñ®Æã×½õ°lm<¯:„[\ZÃİİ=¦Çu®Ñy\0\0Àˆ;°óÚDA|o^L›È†Áy]îuwe±‘;ØyÆ‘¶\\“uì!£ûæŒÌŠÓŠ_QGs=^r/%°ójB”M\'$õü†ö3;—	ì\"s0%8^Ì;°“©º—;°‹\\¢ÏW\rŸ©…ŞÒÌ‘}¶AsÂ-±£YÂ-æF1Ÿìî £Qöiªî–ºcJ×…ŞÍw¶1*U`§X¿®ë;“9Gµ¤ó¸’œr\r;yK}vf\\7’M\'\0\0D`‡À#°$:µK,pK´À.<L‹dUb`\'ÙBØyaÏÅbì\nÃ¯µ¯ß?ú­%öái=Ø-R¶TØ9VÍ“5_“µ1*ÅÏEOjªİºeJ¬p&/§$²¡lxØÜ5o+O³…fÆ_Şk¿\\¯—»¥Ñ[a?‰ëØ%\0Lv<;@‚Àğ\'Á;ÅtQam5cD˜TÉ»}^gZ©\\lSb\'J7pè‰)±b”iem_nRµ4rMvá&z4_µI…7W\"uWÇ¶İdÇUw–lû`\r±‹¡Õíœç«ƒCiK£·ÂvÆ>1F4Å2\0€dA`‡À#°$ì\0)°sï÷*˜|Ó{w	Û¡êy“mãTÇ™ÑîY»Í~<2ßÖÜ’\"rD²LŞ»Q6ˆñd«Q¡ÜMSµÔ¹†ıÂ›´%Í¯”µ1*×x±ècÄÄ9¤bè¥:Û­íÛĞÆPW5ê”ûŞŠWK[\Zõîêv\0€ \"°CàØv€?ÉØ}©Ò\n¶ªo¸ç?µ7T3:5!sí^âf÷kßÔ£.{neÉÔäûZèÃÙô×Â’sql#c5GÑRÛ]\\z7¿RÖÆ¨b/fj9±Ê–g©{İİ¸¡í‚Ë‰^\rÕp7Ï‘qŞw\'°\0\\^ìxv€àOÂv’„Hu¼³÷ÚåÌÅÂÃÊ†FßÕs¹¤àİüÊ@´\0\0$; A`øC`\'Œ1°köó’AÔÀ.\0m\0\0‰…ÀG`HØş$R`—8”q•5·4ÀCÏ.‡6\0€wy<Fâ²F`HØşØ\0\0 ğ‰À#°$ì\0ì\0\0\0ĞxŒDàØv€?v\0\0\0è<F\"ğì\0	?İÆ\'oÿÉ\Zó‡yßúİC5‘£Öºı+yøÅzÛAÉ!ã˜ã6Æ)²ó;îµ¼øñÇn.Ğ¸(tŠÇ[Š•Ş)îÙF‘­\\óüÈ™ŠjG\nµŠ¾µQÒxó®ö»X¥4èuöh¬´KKKKëµY®æºŠ‘VXè\'ICÌ¶ËÛ®¿ÇU²w¥ŸK\"!°\0\0@à1G`HÄØ…‚ \rVæã\ZJëKÙÃ¹ŸmĞlÇÂW8s#I,¥yï3°³×]^’g\'	å¾XâÊædÕş‰&æ(ZR?WÏè¹ViL¬K;.Ù4ÃªJÎt6*|c#^s5Äşy)Úèq•ë“Pfˆ	„ÀÀÿÏŞ½@[R†¯î>\rİ\r-M7¯ö4İ<Eb$Wé‹ŞÖ;f|…ëÌ•K\\$ÄËò2—YIœè2&1K£NÆK\\HĞËrXÃõ5q®ôRÒ˜7*áÙØÍK\Zh¡OıšıŞõøj?jŸ³kï:¿_ÖJÎÙ»ªví:ô9µÿù¾*\0§‘T`£N‰M•²‹6Ş´³›ƒjOŞ\Z÷àM±ÔŒ6×ÎŞœ(SùÁ.¼|±`z•AÂPxï/™Q¹»Z0™èú»öA¾c¶h°kDÔèŠñ3ÊÙ•ÁÒ[÷¸S°s¦\0À°œFRy‚Œì2Ó3/ÜùÎ\0®z¯›½böæäÌÑF‡‰’=(·.å,?Ö`×g„İlvx]İÄ¬î.õv­ÍÎŞÚŞç\"Á.ù{¯»ã¼Üã2t°k¼„vÎ´\0\0šÓH*O°ƒ€ÂÁ®}É±ø5ÈZ5©Uì\Z½îcõ+´µ‹P,%\'\\öÏFÉå‡»†Zòrx{_\r¯ç{Lï\\ã\"q™g{îvñ)±¡qİ}îñf{»Ø¼Ø¼·ß»­_7o¶lr\\^ÎZá¡„‚\0\08¤ò;q„],HµË¹w¶²R«/Õ¾_B.^vò\'†—/|Ó‰Pjêwsƒ@æ‹o7Š]Û­ÿn§^<ùÚ½‚]ìm$‚]vQ;ş]¸ó=9Yn€`×c„]Î{ì¹QÁ\0\0BœFRy‚Œz\r»ÄÊÚÓ@[¡®î¢Ä¥ŞÒ¬Z1\'X—z,_<Ø%o0`\nNMİµçè¿în÷Ê`=‚]|œâ|»œ›úö~ÇİS…¡¦ÄòTæ!Ø\0@ƒÓH*O°ƒ€ùvÍ¡uwÇÍívyW0ëN–Ì¹º\\îò…ƒİ¶ôp¸ùvéKùõÚíbÁî½Ñ5±[»ÎK°ëóÎCo¹&ç?Ø²ª`\0\0N#Y;:Ø%/»–Û¾pÛöÔà¹(Pk:U(ÊÖ¥m½–ßY,ØnC¹ï1JíLrªm}•Ù[{ïv‘`wÓöäÔÙùv}{^ó•£îëÆ[ç¼»Ìîv\0\0Ğà4’Êì  È»ÎíêB“Kãá©™b®½9t×ÑvKÌøl?Ñcùsï>Ø5®5—¹^]^\n¿Çô±}î¬°é¢^»](ØEy‘±H°ëy\'œe6¥â]fé-¾­õŞèšÀã¹~bLX°{üúŞøÉ‡OÿøÇÏUıÛùà»ÿë—kÿwıæ[®Z÷¹ú×§æKó%æ}³ªà>ßşÁ—¾ç¶æ—g¼óæ/¼õ¤²ß\0°˜vT`#O‰……£iÿ1€e›à`—ŠwŒäö¾ôºSÚ•®î¢kÿáC¯,{¯\0€ÅC°£ò;ì(›`7/b‘î·ıÚõw¿øõoùâëi<•VöÀ×şú‚¯îJ®Û7óÅ¶ĞØxô«¿ñ½K¢ähµæêñ\r¶Gùu­{×Uoˆşz˜|Åµ­=¼4zwí‘¼=ï¾ı\'’;P[àôov÷9¾Ã-±ƒÖöÀç/¾ğë¯5ª\0(`Gå	v ØA1“\Zì6ß_ÿbİ»®úK×7ŸšÇ`×Üx”	vÙøÕ©cq‚]ü×f[cÎïyQãM½ñÒßûĞÙÑ·nø‹wÿSóíÿË°Á.ÊÎ–MŒ¯\0(`Gå	v ØA1ìZß4ÓU[ Øµø—Ltëì\ZCÛÚÃĞbë>|ÇotÛOÛ/ÑHfQâ%\ZYí¤î~ì¯ØzÉh¼ĞqˆÂëñ‹¿V÷Ûü6:ëšì®}í×ßó©»\Zœo>,\00f‚•\'ØA€`ÅLd°ëIë=%6?Ø%6šJc\r©ûZ\'áÆƒ]ğU2k¥_1ûšï¥±zT*jßa£^î^\rìúìI=Ø}ê®î&\\Ã\0;ÁÊì @°ƒb&5ØuÆ»u‹vQ”[\ZÚl÷2s/ÊìXÿ`Ûfr­ô³=‚İ1¯£w]zÚ×¯ßeÇ\0&6›ÿ~»ûÙ’¹„]ıû.Wì\0€ñì¨<Á;(frƒ]{Rj\Zh6ø”ØØ’íÅ®Z{]kæé‹zL‰w´¾Sb“ûÓ|Åü)±µu[ûE9¥2±Ù>ï7¶#ékØ	v\0À¸	vT`‚3ÉÁ.J²ëTªî] \n°«/¥oéĞã¦±™³GØ¥^±÷˜¸ö³İG†a—¾ü_”.t¦Ä\0c\'ØQy‚v;nyß{v^øŞèšk¢÷~é›ËŞ&ÕD»Ä »(ìÂI«ï5ìR³_£Tk½b]æµ¯a—zÅö\r%\Zw¢ˆ¢ôÖä¸Â¨H°Ïêm^È®ùµ›N\0\0ã&ØQy‚vPÌ„»Å Ïfsf×\0L7§‘T`CF‡úè³;Î»öc$ÿ`lûÔ›o}ïyw\\³óÂî˜´î²§ã+5±Õí|QßÄ5[İ’ß–X`ÓEÍu7ÜÛîS­\rt6[ö¦í-æl²¹~j¯š‰?˜¿ÙÌ»È,PhİÜ_>¼‡éWè}<s~ø‹–`7v½ƒ]Ÿœ\00¥œFRy‚?ÂnÛ§Ş|ç¹™hµóÂ/½ig²ôìâSPëß?ØîIÄ´±ûl#Eµ\ZÔ`Á®×:ß·ûUn°»ùÁMÛ7ÆŸ¨-ù‰;¢îc=7ÛŞH÷P$¾+ºn~^¿øH,Ó9b7mOWÉØS¡Ä·X	vc—›äšcë¢Àè\0\0¦ÓH*O°ƒ€Sbë‘*º¢›mÚå(ºe>ƒ]ìĞÈ®nk\Z(Ø%·*Ö}4?ØÍ^´ñ¦İ\\Y[ğÖè¼oj.Üo³ñƒ•v#¬ÜÛ@ÿìüb¯Ûd«ÕmÚ²%Ú\ZeŞ|ı‡¾sc´õÁĞ»Î\0Ëæ¸½œñ†İÖ—Øõ›¢‹jõ¦ØÎöø‰NÁ\0€1p\ZIå	vPè\ZvñrÔ­+éæ4ò»Ö@¾>31v³Éáuyì<å»k/ÜùÎ\0Ãz¯›½böæî{é¹Ù\rQÏè6ÊºıúVg;;“?ŠÄÄ[v^pÁæàñl6Ú+¢O„‰ÉÂ9£ùâÃùÚ»¾³ı3Nüğ§¥×	v\0\0ŒƒÓH*O°ƒ€‚7ØK-\0”šaÙı6{}º¨5«×5ìÚC²2cï’’×}‹­{*9Å3wƒí\'f{»ÍŞ\Z+‰·Î~¬3¸ïf7G¹ÑmuS!kˆ`×\rgùQ5±prsí!•Q^9Mí}Şaì,ÖÜõzÿk?ÿ6\'˜`\0À8¤ò;(z—ØfÄ¹pç{)Ï6mÚ´=*<Â®5[²9«_°KìlÙ(yu¸Ñ‚İ¹w¶f·:Víû‰v‰an‚]wôÁ.=l¯¾Üì­É{|˜_âöñ÷9=½N°\0`œFRy‚\rv97Mñ\Zv‰|¸¼[ûÏVpDXzjkÏjÕc½Ôn_®ê:ãÎÆ2%6u	vİê™¾à`şıp“Å/X8ŸÁ.5Â.÷Î%“L°\0`œFRy‚vQ&Ã¥ÌW°–°ä,Ï¾Á.5_78 m ›N\\ÛZwáywÜÜh×^¸Ïf³-ö]ßuwd\'˜övÙ{ÀFùÃôr–ÈÎ7¢l¤-6%65v²ñºç]Ô¾ƒÇì\0\0§‘T`…ƒİ`WN+ì+=Rl[lë\0Sb7§Om¡³ÅöÅïú»VÆj-X¸×f·mÛ¶yvg~/ë¹KÁ·Ù#Øå†‹5$é\r²ÍÄ`ËØFûİtbCö‡¼½×˜Í	#Ø\00N#©<Á\n»öí!ú••áƒ]ò¦©í\'ØÔÍL}n:kOÁìØbß`×sä[ŸİÔc‚jîºÁ»v´RhiÏ‘qİ\'7]…[ ØE[¶lİº5³ÑØ$ŞNh`a¢ïMÁ\0€1p\ZIå	v0Â”XÆ&<ûxbîÏĞç>¾ƒš˜÷3 Á\0€1p\ZIå	v ØMƒEìâ÷·˜\n‚\0\0cà4’Êì @°cd#»Àlá) Ø\00N#©<Á;(F°\0`œFRy‚vPÌ„»ùà»ÿë—S­ß|ËUçÔ}öôüüW•p¨Æoä÷{û_úÛRí?|è•QôÀç/¾ğSwu=ã7á­\'Ån-5zô§g\0\nì¨<Á;(f\n‚]ovWÏw÷´Â\\ı›¿ûõv“k«çº¯¿¶¶ÄƒµE£f².\00,ÁÊì @°ƒb&2ØÅÇ”ÅI=›©{İ®÷øõ½ñ“7MŒP{àk}ÁWw5¿~ñëßòÅ×ª„ëŞuÕï\\º>¸pr—~pÛ¯]wô«¿ñ½K^”ØÀÃwüöG·ı4¶©ºæÂÉ—HíR[öıf_tó»ÙöÉ‡Ûï®ñ`l\'3nï6¸(/ÃÕƒİ}—×ax\00;*O°ƒ\0ÁŠ™`×*qÉg»Q¬­µX¼Ö5µVùÖ\rñîJ¾`½µEÁ`wò7‚¿(¶“›ïo¾P:Ø¥\n`¼¸e÷vØ`×}Ñ[ßV[ñ—şŞ‡În¾µXLëŒ;©ıíû¿İuWsNl{>lv„]ôÁ‹ï›\\\0ÌÁÊì @°ƒb&2Ø¥t:T ØEñQrÍÖ\ny‰HW¯ZÇ5Om-ùmgŒŞÃ=nïÆ¥Ñ»ƒƒÚbƒİ\Z¯½]â4ƒ]³»å(½hs\'ë¹pm£Qæ_í.9¼.5;6~•ºÄ5ì6~şâÏü³a€ù ØQy‚,ò`·íSo¾óÜ/½só[Ş÷‰èŠ]àï ›†`EÁ)±‰I ±Ü–7943}5PÊ:Á®×ÂñìqGˆÖbÉ=	¬;L°K½hc,aTÛçuŸ«=›™Û’\Z^—•îyíGëÃë^õ­Ìm(\0\0†\'ØQy‚víÔ{hÇ-ï{Ïç]›Ê^µo½vR[X}ŸoÚ^ûbË{“of&ûÈĞÏD»Dë‘;»ßÀ´X°\\WnA‚]Y¨Å\Z;œÀ[<Ø¥®½ëÒÓ¾~}g°aFß^×½v]ì±ÖUî¢¾ôºSjëFE\0\0\'ØQy‚võÌµóÂtá\n;òØ7Í¦6Ø=œš;%¶™ÃêÃÜ~åîy{ÕÚëZ3Re0¶Ãİ÷¶GÚ»Ñ™ÊZlJlêEƒw·H¹½ÕÜNŠ?’!›Z¢=K¶Ûé²Ë\0\0A°£ò;(ì’£ëÚƒÔ6mÙm}pcím­wQ«ÜuÆ‘Õ¾¸&êŒc‹×æÖĞë–|¸óL¸&·ÿ.ñxc›{>Û‹Ö{ÊìWç©ğÉ,ß96FÙM³‰vY©€uú7Ã‹5ïÿ°vÈ›N¼¨ûÒİûÌöX¸ÛÑ¢à­wƒ­«Ç¸(ı`”|#ƒ»ô‹¶ï°Ûó”Ğ|×äº`ÑkİDöv#ì\0€y!ØQy‚vÉ`–c[Û™*ñpï`—x¼±‘VéJŒØë¾êÁ®•Î¶ô|<ı^»A˜ªmyo$sÀR+)vÓi\Z‚]ö¦½ƒ]=ÀÅr[\"¨ÅoÉ\Z¸º\\2{å,ëh9Óoã+¶K\\w—j›ú³è+Qu¿]ßx#İ×íìR/ÚÚlîìò†ÆÕ;ŞmÍ/;w‰mï~÷&±]Ã\0…`Gå	v0|°Kf«xoJŒRëÔ«FØÅ¥2Ú¼»mŸzßÎÙ7İÔûñÜMf¦÷Œmİu{;ÅnjMX°P½^İ¾d[c¬Ù	¹İªª’3j\0&ÔdœFÂì `ø`—™I\ZÖùfg<ØmMl*>¢-şlÿv±¦ñ¹·Áí·wxö–÷İ:û±sïL‡¼ôã]¡¹¯}ç³fßHï`—×™t‚İ”K]Ë\0`BMÆi$, Á\n»np\Z6Øå€ÛÚ	aÃ°«/ÿàEL¹=÷Î÷í|Scwú<ŞÕï.\Z)±¡7Ò?Ø¹UÇ4šÎ`G]gâ­áu\0Àäs\ZIå	v0â»ì½#†›!¸Á¦Äv¾íì.ºèÁ³K_\\/øxî{\rŠØ®ç¾#ìªI°\0`œFRy‚Œz\r»œ›N$oÆÚ/Ø¥o»k\'e6ÂnkgúmÿÇÓoö¦(>éöÁ‹òn‘ûF\\Ã®š;\0\0ÆÀi$•\'ØAÀÈw‰]émÓ¦MÛ£[¢­[·\'/-×ç¦±«¾m©OQ­?qíìÍÉû¶æ^Ã.\'¹%Ã\\7³õ<ğvÛ/»~]Û[æ´ê¥»ÄV`\0À8¤ò;(ìr#“«±\rO¯›^‚\0\0cà4’Êì  P°Ë¹îš`7¬ÚûDt…6;\0\0ÆÀi$•\'ØA@±`Nv‚İpŒ®›n‚\0\0cà4’Êì  h°ƒÅN°\0`œFRy‚vPŒ`\0À8¤ò;ì Á\0€1p\ZIå	v ØA1‚\0\0cà4’Êì @°ƒb;\0\0ÆÀi$•\'ØA€`Åv\0\0ŒÓH*O°ƒ\0ÁŠ™È`÷/|÷ırç»õ›o¹ê¼“bO?ğµ¿¾à«»bœşñŸÿª1¬)Ö<¤%¨Û?øÒ÷ÜÖüòŒwŞü…·ÔcÙ>ñ…÷]şzeâ‘OİÕøòükãO\0\0SG°£ò;ì ˜‰vßñÛİöÓô£ëŞuÕï\\º¾şÕ·nø‹wÿSâ¹¿ş-_|İ1ã9\\åö¾ôºSÚ•®î¢üêÖjsñ.[£şì×_Û\'ø\0“L°£ò;ì ˜	v_ÿÑ?ùpıêo|ï’5jºÖ8»ÆH±Ì˜»>ëÆF–ÅGç½ñÒßûĞÙİÅ\ZßÆF¢ıà¶_»şîÎø¾àŠ­¼ØZ¦¹¶å<¾>C£ŞºÕ²[*£æş´ÄÏ˜vÍŒ°Ë¼Çö‹¿ÇXí{`s†ï\rÙZ­îŒóÏn‹:#ì’«+v\00í;*O°ƒ\0ÁŠ™¬`—è_©vÏk¯zCô×í2Õ­H\\Õ)GéGòFçÅòÓéßlµ§Í÷7×mìÌö¼a}Ã»ÇâÑ­)ì’3‚Q,&P-Á.ÔÔ:_·ßcãfNûØö=°9Á.1¾®—>ÿùßúÖW¦ÄÆÑë\0`Ê	vT`‚3YÁ.9à«£;.ª-½ñWïşr<-Å»R´îÅï:½9®^Óî‰ÖïúéÃ–”®ÍêÔÊLÍÁeo¼ô7¢ëíéÒèİ×ßªrÉ»öàµÄ¤B¬$æ½ìã©\rÆGö…‚]ö=vî5—i~ÛïÀæü0›íÚ×~ı=ƒ^….ìÚ—±ë{<\0`²	vT`‚3…ÁîîØP¯lWÚü®¶}2ªo¡Şà~pZıÛŠMÿLK%ª¸ö«ôX1Ê^qoØÇóšWk’Wè‹ïd^°K<”?%6ôcG¾]0ïCg÷;°9?Ìfiëv¶>×°‹¢^#ìY\0˜h‚•\'ØAÀ}÷İWö.À´š `7Ğ”Øm?Í\\L-Ş•nyİ\\5ç{~ıì·\\şèï.ìÚOÍc°[?ø-n;ûÊ—X` `—¸ö_ Ø%ßcÏ`—{`s~˜™Y¬­÷¶û;w~Mºëìú<\0L:ÁÊì À;(f²FØ\rxÓ‰#ìnùè?zÏk/=íë×ßóÚ«~çäo´g•†k`•î”Ø«Ö^×)ƒ=Vş¦±4¶68%6– »ÕìmÔ¿HN_í;%6İBSb³ï±×”Øü›÷ÃL_Ã®oqK.Rgˆ\0L7ÁÊì @°ƒb&,ØÅo\Z×½)jŸ{#D›o¹êôÿöÑ¿­ûitZû~¹7huÀnw[÷¹vØŠêçİÚ5»â€Á.Îz]Ã.ş@l.pÜ`#ì¢(7Øõ}ƒØ¼kêõpY©¢—Y}°[X\0\0“I°£ò;ì ˜‰vuÉğ”ÚŸU\Z»Ä[§+}­;-uß†D–jo96¨-Ö’³Dƒ+;Â®1*-êsÓ‰älµ‹ï@mõ?‹¾Ò:—ÜšZûv©÷XôÀæ»¨{Ëˆº7ˆ­î¦\00å;*O°ƒ\0ÁŠ™È`\0@Õ8¤ò;ì Á\0€1p\ZIå	v ØA1‚\0\0cà4’Êì @°ƒb;\0\0ÆÀi$•\'ØA€`Åv\0\0ŒÓH*O°ƒ\0ÁŠì\0\0§‘T`‚#Ø\00N#©<Á;(F°\0`œFRy‚vPŒ`\0À8¤ò;ì Á\0€1p\ZIå	v ØA1“ìûÅsuûïmÿÅî½ûË>6\0\0‹Â±«;ûÄÕ—ı›Ùã^pøÂ½Š`Gå	v ØA1ìûÅsïøÂON\\»bÇ“Ïîzf_ÙÇ\0`QXwäò\rG¯xàñ½yñ™ë×¬X Wì¨<ÁŠ»mŸzó5[›_nyï—Ş¹9ûpâñ”·¼ï=7mÏ,{¸÷r^=g³ñ\'C›ln­Çî¶ÖŞyaò¥î8ïÚ]0Ï7kûróìüo¶Ä÷5îw4Àş\\½÷½Ñ5µÿİë\'>ˆÉ	vµ?UzÛ}OìÙ÷ƒŸ=½Û\0 ‡³O\\½öˆåï?ÿ”%K–,Äö;*O°ƒ€Á.å\Zš±+óğ¦‹‚¡&½\\\'•å>1È«÷Z»ûTv“íç&#Ø[Uß×xLN°«ı1»ğÓ?XsÄòíï-û¨\0\0,:›Y9÷Ü/{ÉÌÌÌBl_°£ò;>Ø5W³ÆµµÕk×lãËV¤‹/“\\;¶Ææäà¶Æ3ÑE}jQÏWl¶µÌ¦M›¶oßÎr=Çä¥÷:7lÅ¶Ò}ÇÙq{½êê·Îx´ÜÍv‡†Å¿Kn²ñ2™W‰ÒµĞûºyö½çİqMó™Dm\ríXûEÉ}é˜à«¤Ãaìûô.ÇşÃhºøG¡Ï_”œœ`Wû{öÚo!¶\0À€¾ò®³;ì°…Ø²`Gå	v0t°ÛsÍ\nÕø&Ê»şP»«oØ‘Wtzõ=6û‰èŠô±mm¹è¢o\nO–M¾l8 eWë›ÖÈ½-‰†Õy Yº™.Y6ÆŞÎƒİ›ÓÅº7^*Õ\nÃóR‹¾¯xcİ˜İœ`×Ş^ÿW!ØÕ~Ğw›Ş»ø1ì\0\0X\0‚&ØAÀH7H¤(¹ÅZZ”Èw™©®}½%_=w³É…3ódk¼igŞÕíR¯õ`wpZçÛ‰N²ÖHV[¶lÎí£;£-[·F»(U¥:,„]zo£A‚]Á÷•<Š=w¬g°Ë}•ÂÁîŠèígwäÃYÁ\0€ù\'ØAa‚v­Â–Ú±)3+±şĞ…;ß,k‰µÙ¹®ñ-†^}Ø`—Ú×¯&sd}†mtŞµ;÷Îì¤ÓhS·x½7º¦9Ü«ŞëÎíŞê _°Û™*l‰Ä•Ÿ5ónúÑëÎÃ¿¯ø¦úîXxJlpPeì©¨w°‹­”ú™\'‡4aı½	v\0\0Ì3Á\nì  X°kW“MÉÁYÉ¹’ÛcSe›«µƒ]hîj`ûõ\'âé(=”/ïÕC›\rì^æ]õv‰ıëZã¹Î½³1A3jÌÓ¬}3Á.oJìÖø¥ğaWä}å»AGØµŸ®m¿ÊÀ#ìº#3#ì;\0\0ÆH°ƒÂ;(ìÚ¹+Ù·BE,PÀòn:‘˜]›¿zŞ«çßË¢Çî¥\rì2“:¯W\"j\r­ke»ƒİ°SbSqjä`×ÿ}2%¶ó2³·æ¼ÊàSbãsuÛ­³¹MSb\0#Á\nì  è]b†º]z¹ÖR™Õ7]”7r-ôêy›M®Ú£§ÄfÖéŞ6¡{oÛÄ€¯nÉŠEÉÁ‚İ°7Ü.65xÈ`×ó}mÿÌúß\r#w„]ë>¶W)<Â.¾nä¦\0\0Œ`…	v0t°³äTÔÔc±nëÌ5„k]ïWÏÛllÅùvÉ×M^R-}×!‚]r³Éëo:;0[Ş›|›zùy_[¶lİºu°_Ã.öƒ¾J!³©§bÿíµßcò8§¡`\0Àì 0ÁFºK,‹NŞi\\ŞİaK$Ø\0Ğ!ØAa‚vC°ëì\0\0èì 0Á;†!Øu	v\0\0tvP˜`‚#Ø\0Ğ!ØAa‚vPŒ`\0@‡`…	v ØA1Õv¯Ørúo^Óùö;Ûîş£­O-ÄN²æKW¾rÏÜ;?ıÏ”½+\0Àˆ;(L°ƒ\0ÁŠ©@°ûğ%ç¼ü¸å©ï¹÷áËoİ±ûI†`\0Õ!ØAa‚vPÌ´»“NÛğ©¿~Utà¦¿ùÉgîÙ|\0€	vP˜`‚3íÁ®9¼.5öíozÉE§®2È\0`X‚&ØA€`ÅLy°[yİïyÚ?põ÷¿{´ì’¯¹ä²Î2ñœ×Xşğ›şæ\'ÑY§ÔVlîNv€^òJyûR/Úwø³±W¯Ï\']zo»{êÍ7ì¨íö£çŞùéûş ½ÿs¡É§ñyÁ©BS†Óï®yÄ:ßÆ·Ğ±¸·¾3w\'_ni{#½§Äfß`ëÈ´ÇB¶Ä^^4»Jê‘äêİŸHçÍ¦ş³i~Ûø)Üİw]\0¨Á\nì `^ƒİ[Ş÷›¶w¾İòŞ/½sóBíø¶O½ùæÙk?vÁ†ğsw»€¯=ÌN^³5p4ºjÓEÙ÷Pvç…¡ı¯?sÇy9ïzaö?÷ 3åÁ. º½,†::Õ¬ì¾sïÜËO]_ úf¯TójèîCöÙö«ìîÙ³üW¯¯Á-t^ã/¶óé”ÙÔIQì~)p¸º?‘±»Öƒ]ç¿™œ`—^\0*C°ƒÂ;˜¿`·ã–÷}\"º¢ü¸“Ÿ»Æ¬^ël÷¸F¢ÛØhv±/“Ëtvÿ¦íÁØÙ|*”øôhNÄOuU(Ø%ÂP¶µÅi¦™T©‰Ò	oU\'{µÇu+Xj€U¶6_tW«5÷­ÕÈ²Çösirì[§¦¥ûÚ®D‡Z+GÁ›æÙ•é\\«’{;b°K=ÛÉaJûÑaƒ]ç‡v¯—\'š½Ö€Êì 0Á\n»ØHºM±\"uëì…Ñ5­eíÇSƒîºÍ’OtûTçñÖ2h=5{kxğWlt]î€¿Ğş^º¹µk¢Îzñïòö?¾#±U»£Õ¢ä(¹Ø ¶Ö&7mÙm2É±ÎvnŒ¶>x^ø]ß<ûŞóî¸¦¹KáÑ|É÷Õ|ÕÆ³ÑEm¼é¦ØÎÆ£§Qvyª\Zìv%[Opá•ÉR³+‡ZU«ñušx{x3â„&áv_b¶Q£â“pCm®W°Ëny]«÷Å¿’kEÍMõvÁ£_e!‚]ğ\"ƒñt¸ğÁ®¾ú“÷>uô©kV‚]T{6Šmªïº\0P‚&ØAÀğÁ.>@,6B¬9ûsKúñDêv DÍj¬Ú\\³óxvòg*…;Rbx]|İ¯w¤÷¨õMğ¥ó‚]Şş÷>l­îLîxlwÜrËÎ.Ø#ØévEô‰ğ”ØÄÑÏÍÎ×>z;Ûy3ñ†’; Øå¨P°ëh•»àM\'’Óc[+”ÛZı¨±‘]ÁI£M±¢×všjÁígå»ƒycñ¾­Ë†­Ô+§ÄæÍÄôØÔäĞìO¬p°öÊø’Ñğ/:T°kØ®ÈtÛÚ»şjtìo^Iœ½Ö€Êì 0Á†véšÔ*=oÚ+C­Çë™çÜ;ƒÁ.©S‹Ò£ÒRõ\rvÉÌv;S/ÑŞ§(øÒù#ìò—Ê;jÍÃ“.‘ËÒeS{bj”w\r»Ô´¿\rÿ°\Zºvôêı/6®½…ÀX±¨b°‹¢ô¸³•9Å-ìOõ£ƒ]3.h°kÜt\"Q…Fv½¯¯×TÕ`×<hßo¤[™™åÏVÎ[\0*C°ƒÂ;:Ø¥ëM+8eÆ~µªO=äå»ô=f{İSa`—ìVÉY«Íù ¡¶õ§rÆ®Å÷°»ŸyûŸìÃÜ\n»îuävôvéa{õåÒó†ÙrköÍtF&záÄ\\pÂT4Ø%¦ÅŠU\'Ä$ŠŞ`Áî`ö¶°9ªeüÁ.3ŸwiöşÍª¿wmgã«/Ä”Øàáj¾Pv3%ö¾—¾æ”ö!\rÌŒ®½ë™Mı¼ú®\0•!ØAa‚ÌW°¶¡ü`×J]›.JÌF`{0‘·b#C/‘“ÂzM‰Íî hµ®Ûğ¶Ü)±ñuºÅoû0ŸÁ.5Â.ñËŒïë½i§Å”»¼h’¾Ê[ÎMSbSSh3Í«×Eßò·PL?^¿!u\r»Wd®jõš%õ\ZvñãvY¿çUì\ZvÍ{·”á`÷G[ŸK%Ú¾ë@evP˜`ó5%6=û²yÂSb³ñm~¦ÄfGØe®V7{ë0ÓZs‚]Şş¶ù`ú¦®©x™ñe†f†ó››š Üxİó.zğ¦‘¶)véÛ¹6´®a¼CkÔ½!i”º†]b–ºlê¦uQ,ugÕ(}ÙÖ.Å[ÏºÄÖêzŞ%6=½·S»\nÜ%6Æš«ÇÚY÷ŞìÊ»Kl} elÂr^°Kß<·ïº\0P‚&ØAÀ¼İt\"çñ(ŸÚÁ.}»ÕM[WDÛ%$*Ñh×°KÎøìyKŞ5#óÒùÁ.¼ÿ¹û’s\0Izƒl3qÓ‰¾?”îM\'²·à¨½•tt\r»°ivy×§‹¬(ç\"nQ*ØíÚ³oİñÅdï¬šZWúF¢©º[È^\'nWxkx„İ®=ÑºØ{œKt¢Äíq³/÷öãe*xd.ØE9Îë“_t]4xšLşXsƒ]¸ÑD¯u 2;(L°ƒ€áƒ]”õ•èT©Çë£ëı\'UÂZ—«=î‰;4·‘êFÅîœ¶%xq»Ø¼tîM\'r÷?pŒ¢Ì.tŸÌt¾¨p°‹¶lÙºuk¿JóñØÑËÄÇzİ`¦?ØÕ¥êOöş°ÉhUÏ._~Fg–kêâeeöe¯X—j[Ù²ÉİHo!¾zğ¶=ï{×%í.¼Ákü\rÎ.—vñO½¯Ú¾İğøÊQf§&å>›ºE|—.Ø%^¯`¿¦ŞeıÖ€Êì 0Á\n»I¶8óRÿûÔ$”\nçD5‚İˆ¼)DVö½ß=Ã\0Ğƒ`…	vP¹`·8¯¸6?Á.~‹ü‡hì\"Á®º;\0–`…	vP½`·(“İÈÁ®9q6=A×èº^»H°«.Á\0†%ØAa‚T1ØÁ8v‘`W]‚\0K°ƒÂ;ì Á\0€Á\nì @°ƒb;\0\0:;(L°ƒ\0ÁŠì\0\0èì 0Á;(F°\0 C°ƒÂ;ì Á\0€Á\nì @°ƒb;\0\0:;(L°ƒ\0ÁŠì\0\0èì 0Á;(F°\0 C°ƒÂ;Ø¾}ûìììÌÌLÙ;Ó¤öã¡‡Ú¸qãà«v\0\0&ØAa‚<úè£‡~øš5kÊŞ˜&O=õTíÆqÇ7ø*‚\0@…	vP˜`µÿğk\0ªıW¿zµqvĞWíŸÌ3Ï<óÔSOÍÎÎ._¾|ğ;\0€\nì 0ÁÂjÿíïÚµëÙgŸ­ı«({_`ÒÍÌÌ¬X±âè£ªÖE‚\0@¥	vP˜`@i;\0€\nì 0Á€Òv\0\0&ØAa‚\0¥ì\0\0*L°ƒÂ;\0J³ĞÁî3¬[ sD\0\0zxşùçß~Ë.Á\nì\0(Í‚İ	\'œPû³UûKVûóæï×|yôÑG?şø²÷`ñò{˜‰µdÉ’¥K—vØaµÿJ;…`@iÆìjŸg}öÙeË–ÕÎkge¿ãŠxä‘GN8á„²÷`ñò{˜‰uèĞ¡FS8ğä“O^ş7O\nvP˜`@iÆìj–,Y²lÙ2µnù P.¿‡™d¸pà¡‡zÇß>-ØAa‚\0¥O°›™™Qëæ—Š\0åò{˜	wèĞ¡;wşîÿ³[°ƒÂ;\0J3†`wÌ1ÇÌÌÌ”ıF«ÆE€rù=ÌäÛ¹sçÿò?%ØAa‚\0¥C°;öØc—-[Vö­\ZÊå÷0“O°ƒ	v\0”F°›R>(”Ëïa&Ÿ`#ì\0(`7¥|P(—ßÃL>ÁF$ØP\ZÁnJù P.¿‡™|‚ŒH° 4‚İ”òA \\~3ù;‘`@i»)åƒ\"@¹üfò	v0\"Á€ÒvSÊE€rù=Ìäì`D‚\0¥ì¦”Š\0åò{˜É\'ØÁˆ;\0J³Xƒİ·ÿì•ğÕ(zıGnÿÃW4yğ—½åº»O¿üÆÏ^¼±ì½€Š”¡õ\')öÏ¿‡cš¿â¿\ršUı~(™`#ì\0(Í\"vQ7ĞÅƒ]§JLn¿óA‘2vĞå÷pŒ`7¡;‘`@i{°ë6¹N°û`ô¡Ú%\'ôÃ†Š”!û™¼¥ùï§ùu8ƒšxc;9§?í\'ÅÆ–Ëİ#Xp~Çôváß‡c«¶ÿB‡×ÍıG>ıAëOºßi‚ŒH°ƒ°Ÿ<ôÌş_ÿüğSsúú˜Y¶tıšUrá/ùÂ#‡Zqq»×_~ù½×]wjãü¾\r>òêoşA+D<<ÀEÊÎcqw¯Oü«\Z9Øu^!ìŞò@æ£>ŒßÃ1}‚]îo‰n‹ë¬›~$»nòÿÓŸ£I°ƒ	vğ“‡ùŸùîÌÌaË[¾dÉ’²w&]íïÂ¾šçŸÿ«ËşÕ¯œø‚ÁW\\äÁî#·¿ê[¯üƒ{»u®ìb%a2S€Š”!ìZ™;Ÿ’›ËœÿW5b°;±û¡<ì\ZÃj|<§,~ÇçËGQüŸyğ·ÄÆÆsÑé§ß}÷©İúßŒjßßùQß`ü/sj»Ù«Ó\"ØÁ¨;xÓ\'¶=şÌşÃ_?-PUÏ?÷ü1GÎÜzÅæÁWYôÁ®9¥îŞöLXSb¡‡P°Ë<,mmÃ»7ıŸõÿûú×õ«_Rî¢‰ıÊbà÷pLÏ`×ã·DóW@tùå§^w]Ôşş›¯®ûÕØºi±Ø—™u+âÇ	v0\"Á^ş¡ÿ¶bÕ*cë`(µ¿Ïíûöşíà«v­ÿı©Ù±n:½”ì\Z¡®öôÜş–?»ÉıGJåù=ÓsJì\0Á®ñO<jÎsÿæ«›ÿà»y ØÁˆ;8÷ƒß\\½zuÙ{Óçé§Ÿ¾óC¯|yÁ.v=ûhŠ>üû HÆ?%¶ş\n\'{®½\\kğ1v”Ãïá˜Á®ÿ”Øæèöo¾º~UŠo¾úÆÏtã+[Á®W„3%¶?ÁF$ØA€`ÅvƒI}´è¤Î@	Mx>(R†ù½éD®Xíëüüv Øİş‡Qı«	ıGJåù=3ÚM\'¢Ú?â-[›×®‹^İ.ôùë&~«Ÿ¢E°ƒ	v ØA1‚İ`ræçvĞK8ØEÉ›5¦¯?Z°KƒM»Wäî,8¿‡cú»(ï·D7Ø%†ä~;ì¢T³ËŞ€¢qÿ™Ôviì`D‚vPŒ`·Hø H5u?¼ûĞÍ¤ó{¸l“|/÷I!ØÁˆ;ì Án‘ğA‘jì˜~—M°ëO°ƒ	v ØA1‚İ\"áƒ\"@¹ü.›`×Ÿ`#ì @°ƒb»EÂE€rù=Ìäì`D‚vPŒ`·Hø P.¿‡™|‚ŒH°ƒ€Eìù³+OŞàÉGÿ×Ï>xWÙ»Å´ì	Êå÷0“O°ƒ	v°¸ƒİúŸİø£O?Òøî¬ıİ¹Ï\nvN°[$|P(—ßÃL>ÁF$ØA€`\nvGüîe¿táÑÇÃî’ƒòî»ÿ×oy¼şÅ	oxËñ³í‡·}í»ø£Ø:ê›š{ë•\'Gõêœñ?œõü«ç®¾ú_¾’\\ğ\r¼ìÊSâ/Ñ|İİ±%“v õ`cÉàbMuv©~^56›÷xóë£’ïk1†NÁn‘ğA \\~3ù;‘`‚]&Ø5ZÛ“­WogGw‚Tm•µ[ÑªşxÔ­i°Õhm©²{•øÂ­|¶;ìÉ¬\n·%òÙQ­—·õíuGğ¥û9l°Ë<¾XG&\nv‹„Š\0åò{˜É\'ØÁˆâÁ.Š–Ô9tèàÁƒ‡ææövâİ3Ï<³k×‚‹Èâ\rvõµâ¿tbY\'<¥O\'¶ÖS±`—‰ÖZ=ìŞpÁY\'=ùÜ…ÿ*Ê°‹Ò/İøâ¾İ›£\':qK´{ó)¡u;;vyû9d°Ë;neÿ<ÇO°[$|P(—ßÃL>ÁFvK—.{Íÿøë/~ñ‹kŸnšÏ®_¿~Ó¦M/ùå³wî|H°cìÒá)] êîÎ»ïÇ—ü{ê«œıiã©L°‹Ï–`„İÏ7Şğò¹Kî^›¬{]Ù²+vşcãu[kİ½®9¾¯1ĞïkÑ•é2˜Üp°Ëîgææ}H°›¬`wÜqÇ-]º´ìS5>(”Ëïa&ßC=tùß<)ØAa©`÷{W¼ë¯xÅš£[™:òÈ#W¯^}ôÑÇv,.‹7Ø¥JÓ Á®öÔéİ1nñ)±›£¨×a·õô³NúÎ>}ì‹ò‚]|áÖ»úZ/Ûr÷wÿ0jìF7öåì@hJlh?‡¿†]»\'¶vÓ5ì#ØM)Êå÷0“O°ƒ™‹6ØÕ“ÓÑw‡È\r0%ö\r¼ì·l,ë»løëìşñÑ\rGÏ]Ò\\·W°ë¼âÊÖ>4RİÕÑÉ­l×\\7oRÁ.w?‡v«ïíh>e„İÀÆì?şøÚ·K–,)ûØTŠŠ\0åò{˜	wèĞ¡Ú¥ÿéÖ\';(Ì”XX¬Á®>nîÄ;Û5*\Zä¦‰ô–vÉ’5={s¢Ğ¥ƒ]÷î®¡`W/‰§ìn¿bb„]ûî»[®ì‚;e‚]x?‡\rv‰ã#Ø\r¾ü‚]Ô8eŒ4;\0€±¨z5Ï»Ş~Ë.Á\n3%e°Ë^­í¾f‡j4©æ/‡\';µ.´JcùÆW›ßï¾úê\'¶Ä;W(ØmøÇØà#ìb¯~_úF´ÁPŞŸ§¯a—³ŸÃ»ûê“a£›óî-&“ì\0\0?ÁFaJ,,Ö`h-éI²ıVÉ½Q,‹Ã»SN9¥ì£RA÷İwŸP\"¿‡™|µÿJ;…)± ØuvE°[$|P(—ßÃL>ÁF”\nvWì£¿ò+¿ò‚£j>»råÊUu«;—Eì`v‹„Š\0åò{˜É\'ØÁˆL‰…\0ÁŠì	Êå÷0“O°ƒÅƒİ;‘î©İ»÷ïÛßpàùçŸ¯-&Ø±ˆvPŒ`·Hø P.¿‡™|‚ŒH°ƒ\0ÁŠì	Êå÷0“O°ƒ	v ØA1‚İ\"áƒ\"@¹üfò	v0\"Á;(F°[$|P(—ßÃL>ÁF$ØAÀË?ôßV¬ZµdÉ’²w¦Ií¯Ãs{ç¾ı;ø*‚İ”òA \\~3ù;‘`ÿÓÇÿşÉ½èOTUí¯Å1GÌÜzÅæÁWì¦”Š\0åò{˜É\'ØÁˆ;øáÏ~ñŸ>ûË—Vûãì ¯Úß…}5Ï?ÿ¿_úk/=é¨ÁWì¦”Š\0åò{˜É\'ØÁˆ;ûáÏ~ñ¿İüãÇ~±÷àAÿÁC3Ë–ÔÊ÷ÿÏ/ªÖE‚İÔòA \\~3ù;‘`@i»)5u¿ıåïn=ıe¿ÿâ¹/^oôïÎúícÊŞ!€ÑLİïa!ÁF$ØP\ZÁ.æÏ_|á}—ÿÃ‡^Yö`¾>(>øí½íg_óï^öû/÷}ÜõçW?´ñÒv›{|Çå×?|Oí‹3Nù»7®Ë,<÷Åëÿù³\':í¼—\\÷ŠUrø\0F&ØÍ·iú+<-;‘`@i»¶úç„Oİít|T˜§Š»şüêûî?fÅ=ÑÑŸ»tÃÆ2ßP=Ø=ø¯¢,Án^MÙ_ái!ØÁˆ;\0J#ØEO	gœ~t[4%ÿ¿ıùù øÓ»ıo£?¾tå\r×?ùªÎP¸FÅ‹:cîšË\\yú+ÚO}£³zk¬\\c$İ¿;ú[Û@­‰-Üa—Ø`cLßŠö2=ƒ]gt^Ãk›z6¶\\û¥ÃËÇGüÅw)şul ß1ë[3¹µœ‚À¢#ØÍ—iü+<-;‘`@i»¨şQáó¾õ­¯œªÉ8óòAñÛ_şî\rk_rİ+¢/^ÿÏß:½3ÿ´w°{bKãëÚºˆ:Áî¾o´cY¬Ç…‚]+~­&Ø%ö§şºwÅ^ëî£cYmï%­×\r.ß7ØÍÅCwãõ-·ƒfük`qìæË4ş‚ŒH° 4‚]Ì4}T˜‡Š±ö”õ–ìºQ,ìºËw¿\r»oùGÛ×®øìQ0Ø¥®a¾²^lr‚]Şòı‚]O“Q·!#Ø‚İ|›¦¿ÂÓB°ƒ	v\0”F°‹™¦\n£PLÔ®LÀúFbÙØTÓ¿ŞßX%ìb7—ˆ:ãÔö¦ƒİ1;.¿cåu§?‘ìbİµ#ìê¡íÙË’u¿‘ÜŸÁ.»|Ÿ`÷Û»Rlëê7¾8ã‰ø”X·Â\0š»ù6M…§…`#ì\0(`3MFş ˜­r«¶å°«}}÷ÚæÜ\n»-wÿhûygıöãwìÛ©ïj«”õa·+gù‚İİ¡›o$FÕ¥†‹—`7ß¦é¯ğ´ì`D‚\0¥ìb¦é£Â¨š©fİm¹Á®}Í»úø²¡§Ä·şş\'V^W[ş§C»u;ıïWv;Zß`W[ ¼ü°SbÛÁn.y½?`ñìæÛ4ı‚ŒH° 4‚]Ì4}Tñƒb,·u$F´…‚]b$]ŞM\'êïêŒÔë»Îƒ»N@|<u½‡ï‰V\\Ö¹ôŞ/l½‹x°/?ĞM\'>µoÛÙÈ; @°›oÓôWxZv0\"Á€Òv1ÓôQa¤Š9wNhßzbíÖ@°«?øì¦Î8åïŞÕÖk¾q×SõGY».^7Øİß¹ô[~°KŞtbÅeñ8xWóÁ5íİ{ÉÆ¿¯/ß½1Eê†éå›#şBo¡¡½øn´w Uıâoy],z‚İ|›¦¿ÂÓB°ƒ	v\0”F°›Rcÿ ˜ºP]]{]dĞ°	vL>ÁF$ØP\ZÁnJ	v\0åì˜|‚ŒH° 4‚İ”š¤Š.ë,F“ô{Â;‘`@i»)åƒ\"@¹üfò	v0\"Á€ÒvSÊE€rù=Ìäì`D‚\0¥ì¦”Š\0åò{˜É\'ØÁˆ;\0J#ØM)Êå÷0“O°ƒ	v\0”F°›R>(”Ëïa&Ÿ`#ì\0(`7¥|P(—ßÃL>ÁF$ØP\ZÁnJù P.¿‡™|‚ŒH° 4‚İ”òA \\~3ù;‘`@i»)åƒ\"@¹üfò	v0\"Á€ÒvSÊE€rù=Ìäì`D‚\0¥C°+û-\0,R‚ŒB° 4ìşîÊ—•ı\0©_¿ú»‚&ØP\ZÁ\0 ª;…`@i;\0€ªì`‚\0¥ì\0\0ªJ°ƒQv\0”F°\0¨*ÁF!ØP\ZÁ\0 ª;…`@i;\0€ªì`‚\0¥ì\0\0ªJ°ƒQv\0”F°\0¨*ÁF!ØP\ZÁ\0 ª;…`@i;\0€ªì`‚\0¥ì\0\0ªJ°ƒQv\0”F°\0¨*ÁF!ØP\ZÁ\0 ª;…`@i;\0€ªì`‚\0¥ì\0\0ªJ°ƒQv\0”F°\0¨*ÁF!ØPš\rv¿ùŸxİ%/9võ‚œ#\0ĞÃÏŸ~ş_üÉ\ro;S°ƒb;\0J³ ÁîOn»ÿEÇñ[›×—ı.\0ÿ²íá{>wÕkOì Á€Ò,Ü™VíÙCOî}ÇïúÍ—ğº—cœ\0ÀxüüéçÿßïºéÎ‡?ù[gÌ®9|fff!^E°£ò;\0J³pgZ¿jzrïçîxô?{z÷Şıe¿W\0€EáØÕ‡ıòì‘Ÿ{Ü‰kW.mXˆWì¨<Á€Ò,è™V³Ù5ÿ°ùË\00K–,Yºté²†Ú×ô*‚•\'ØPš…>Ój6»Ú¶²ß(\0À\"²´má^B°£ò;\0JãL\0€œFRy‚\0¥q¦\0@N#©<Á€Ò8Ó\0 \0§‘T`@iœi\0P€ÓH*O° 4Î´\0\0(Ài$•\'ØP\ZgZ\0\0à4’Êì\0(3-\0\0\np\ZIå	v\0”Æ™\0\08¤ò;\0JãL\0€œFRy‚\0¥q¦\0@N#©<Á€Ò8Ó\0 \0§‘T`@iœi\0P€ÓH*O° 4Î´\0\0(Ài$•\'ØP\ZgZ\0\0à4’Êì\0(3-\0\0\np\ZIå	v\0”Æ™\0\08¤ò;\0JãL\0€œFRy‚\0¥q¦\0@N#©<Á€Ò,ô™Öc¿xî¯nßñ½í¿Ø½wÙï\0`Q8võagŸ¸ú²3{Ü_¸Wì¨<Á€Ò,è™Öc¿xî_øÉËN~Á½ÍİóØŞ²ß+\0À¢pÚq+O;îˆ;î}ê//>sıšô*‚•\'ØPš…;Óªı©úÓÛî;lfÉ×şû®²ß%\0À¢óº_^÷üşCï?ÿ”%K–,Äö;*O° 4w¦Uûcvá§pæìê¿¿çÉ²ß%\0À¢ó¯O;úŞG÷ÜxÙKfffbû‚•\'ØPš…;Óªı={íÇ¿Wöû\0XÔ¾ò®³;ì°…Ø²`Gå	v\0”F°\0¨0Á\nì\0(`\0Pa‚&ØP\ZÁ\0 Â;(L° 4‚\0@…	vP˜`@i;\0€\nì 0Á€Òv\0\0&ØAa‚\0¥ì\0€I°lÕÌa›Ø¿|‰»YKkÇgÿ¡ç·ï90·Øu;(L° 4‚\0Pºe«f–väªeKW,[ºtIÙ{3yŠ=xhnÿƒ÷=sà™áš`…	v\0”F°\0J·òÌ£[Q¯veïÈD›ÛğùgìıÉî¡Öì 0Á€Òv\0@é–Ÿµfíá3ÆÖõvğPôäsûŸÿÑSC­%ØAa‚\0¥ì\0€ÒÍœµæØ3eïÅøù³û÷v0.‚\0¥ì\0€Ò	vì`œ;\0J3iÁî[NÿãÍkz,0·gîŸşçÆu|&Í‡/9çœ#öµÀš/]yú]Ûîş£­é÷Æa\\}Óßüä3÷ì-{— ?Án@‚Œ“`@i»©²òºß=óè=O¿ù†»£ü*wÒi>õï×¯Šv\0LÁn@‚Œ“`@i&3ØİsïÃ—ßº#ód}@ÙÊEìCêŞş¦—\\têò\\ııoÇ–h×º\ZÁ€©!Ø\rH°ƒqì\0(`7ERCê’Óc£æ#/?nyíØïÚ­;\"ì\0˜‚İ€;\'Á€ÒL{°KN¡İnÖköĞ½äGQ{ĞYÚr}³ëÚß|\'qI¸ÄSÉ—H<•Ül`?£áVµ7^ŸÙzÚã{Û\\`×cO5§»Æ5ŸêqĞš›m¾ß¨ñº—ÕËİÒŞÁ®yèjë~5:¶s¿“¹\"^#œÚ·ÎÎ8ôêGí@åM|îÌwN®AEg8aúGÖŞHöGÅv{ÇP?\0æ`7 ÁÆI° 4SìÚÊ/ÛéDíBôÔÑ§®‰—šx‚	–£Ø«‡ƒ]Z+¶Ù¡ƒ]gë(Á.şÈ‡v?¼÷©ÓN]ßzüà÷>ÂÙkîğ‡ØXøğæºì~¼~Cp³íDC»Ş?\0æ`7 ÁÆI° 4ÓìÚÑ§;æ«ùH\'útšKö‘Ô¨«Xj>’®•™„ÛZ«³“ÁÍì:]¬g\ZèQwƒ»ø‹¶9ÌjyG¸yRC›ßf‡Öyaô\\üg×cXb^°ëhó½‰ÃÕ|ÑÄDàæMÕĞÁ)ö`ŞìV_ùªcÎI>ôı»î¿ú‘²ßÀ¸v0N‚\0¥™Ş`×H*Qh†fkW»£%fq6·–ªBñ™›=&á¦:N|:êC»æº÷4Fºíí•‡úßq¢cğ`7ÚÏæñï{„³»×éw©â–<ªì]¬o°ø\'À¼*ØEñBwÂñ7±ü+ßÛñ…§Ë~c!ØÁ8	v\0”fjƒ]³°,n$~M·Lpénä5ùSMÛ=®ozëˆŸÜË¥…‚]kèÙŸc÷ï÷,P}ï87x°KêØAÛÑ÷Ç·Óü™Ç^±~¢öÛIe¾ƒ]ò5(ìw¸ZÓcSQ²_°ô\'À<*ì¢Ã/>÷…¿ºë¡+ïj_¼aeã±½»ÿèÎ\'î­Ò”÷ÄãoùQ£í­^{õ¯uBûáÖ0½ÄƒsßbÕ9Q{ù(:ùÔ\r^µû-,¯Øsƒ‡ww©£¾oûşCì]Ô7»aßg¾õè·xÿ‚Œ“`@i*ìš«§Fue7Ò#ØÍ\r:V®£`°‹ÚîÑº¼µ ×°0ììâ? x\Z‹<Œ\rĞKÌ‡\n»({Â`Íù¡‚İ ?\0æİˆÁnıƒ=¼±™í‹š	lİ\\»ÙÕVYõİF{ÕY\'¿½àÛ©?¾v®ÌêÑmÕ?uÆëÕ‡ïEí”Ö|¡û¯Ş[¦»|Î»»}ÔÃİa€±…[™oN°ƒ	$ØPš)vóæ„F™i˜Ù¼¦ß¼ËaFØÅ\'„>%ö+ÚÃĞz+5Øõ:ÂIéKÈu¶ÿÙ‡Lı \nL‰Mİ³5ÿ\ZvõÂ˜ºja4D°è\'À¼uJì}oØÅšW;®µŠØò/§ƒ]R\'Ì¥‚]º¬5¶³:ìr6Øİíp°{ÕY6Ì¥v¾ÁÆI° 4SìZ·è{™³(ÿ\ntÁ«ÑõxÅìr^kĞ`÷{÷½<yÅ½ü<4Ä\'¢a‚]êd®a·¼gĞLÈT¶ÖÀº­D¯K^ö®Ğ5ìdWğ\0¯Ó×#Ø\ró`>pÓ‰}_ùŞï·áÃR·5ÙÑp·zíÕgFÙm—	vñ­…FØÅViÍ‡­­›œúÚz•¼\rv»=k¯>iß•?_•¬{½v0N‚\0¥™Ş`—º¥icÄ ¯ÎÍ[SÃ²V%o».9Á3^¬ø.±õ±`©äç¡!î8\ry—Ø{’÷‚è\\-®÷şñú\rÉŞ—½ånëÒu»öD+cóa£…a—½ÇHgdâÀÁn¨Ÿ\0ói„)±uÉ9°I\'ã±sÍH—š{N\'·å°ë¬{jCbÈ^g™Îşäl°»Û`÷İc7lx`Ç8^°ƒÉ$ØPšé\rvQ{]j¡TÓ‰öì‹XŸPšwıµ˜Nô	»ğZ±*4x°ëÖ¥Şyh¨;NDC°Û³oİ‰cÏd=pà2‚©4ÖI™™&˜~¡ù¸†]îe\r‡	vƒşD\0˜_#»L ëzÕY\'¿q®5®ìjËoÜ×\r|=‚]sví®İ\'lhÍ«M»ö-/ö¬	o°»Û™`·c÷	«ö]ÙÜÁ&’`@i¦:ØE™vo@àrÕwö6³QºÜ[êNÉ)¢á`—]«Ç`±¦`°‹¯Õ;%‡Ô%¦Ç\ru—Ø_ºÍkÿ#œjds¡•Ú“ÎÖæBã{»Ä¾å®T³Û÷«ïº$ye½¨g°ü\'Àü\Z5Ø5ÂÙ¢öÍa›¶kİ¢[ÊÁ®ÓÈZS\\ëSk¿®I×¸‹ëòäİ`3#ì¢œ\rv]:ØÓ™3+ØÁ¤ì\0(Í¤»y$¸ôÖ³Î—Å\0ºFvQ«Ù­l~½¯]ëR¼kh¤·Æ\\›ßÏ}æ[s/ë\\T.{‰F€{¤ó¢ÉkØuB^xƒtv;ìNè\\üN°ƒI%ØP\ZÁnÑ\ZC°{{ÿûğ@İÀÁn(©LV—{£Ø^›éŞg¶t‚Œ“`@i»Ek!ƒ]wjêœáu\0`’ƒİÉ§nxGôóØ­`Ë$ØÁ8	v\0”F°[´t„]ûnûzÜÊ\0:&Ø¬9ûuïîğıgË ØÁ8	v\0”¦ÂÁ\0˜\Zì&`ã$ØP\ZÁ\0(`7 ÁÆI° 4‚\0P:Án@‚Œ“`@i;\0 t‚İ€;\'Á€Òv\0@é»	v0N‚\0¥ì\0€Ò-?kÍÚÃg–.){?&ÛÁCÑ“Ïí^°ƒqì\0(`\0”nÅ/uøŠ™UË»^æz~ïş½?Ù=ÔZ‚&ØP\ZÁ\0(İ²#g–|äÊ™¥+–-5Î.ëà¡èÙƒ‡öî;pğşgö?³¨u;(L° 4‚\00	–9³|ãf–ø°›µ´v|öÚ÷³=ÃÖºH°ƒv\0”F°\0¨0Á\nì\0(`\0Pa‚&ØP\ZÁ\0 Â;(L° 4\Zì~ó?ÿğ+g~öÄ³e¿K\0€EçÄu+Ÿ}şÀ\ro;S°ƒb;\0J³ ÁîOn»÷Şı?øÙÓe¿K\0€EçìW¯=bùU¯=Q°ƒb;\0J³pgZµ?f=¹÷_¼ëÔãVíxòÙ]Ïì+û½\0,\në\\¾áè÷>6÷Éß:cvÍá333ñ*‚•\'ØPš…;ÓjüU;ğĞ“{?wÇ£?øÙÓ»÷î/û½\0,\nÇ®>ì—g¼øÜãN\\»riÃB¼Š`Gå	v\0”fAÏ´šÍ®ù‡Í_.\0€ñX²dÉÒ¥K—5Ô¾^ Wì¨<Á€Ò,ô™V³ÙÕş°•ıF\0‘¥m÷‚•\'ØP\ZgZ\0\0à4’Êì\0(3-\0\0\np\ZIå	v\0”Æ™\0\08¤ò;\0JãL\0€œFRy‚\0¥q¦\0@N#©<Á€Ò8Ó\0 \0§‘T`@iœi\0P€ÓH*O° 4Î´\0\0(Ài$•\'ØP\ZgZ\0\0à4’Êì\0(3-\0\0\np\ZIå	v\0”Æ™\0\08¤ò;\0JãL\0€œFRy‚\0¥q¦\0@N#©<Á€Ò8Ó\0 \0§‘T`@iœi\0P€ÓH*O° 4Î´\0\0(Ài$•\'ØP\ZgZ\0\0à4’Êì\0(3-\0\0\np\ZIå	v\0”f¡Ï´ûÅsuûïmÿÅî½ûË~¯\0\0‹Â±«;ûÄÕ—ı›Ùã^pøÂ½Š`Gå	v\0”fAÏ´ûÅsïøÂO^vòî}lîÇö–ı^\0…Ó[yÚqGÜqïSyñ™ë×¬X Wì¨<Á€Ò,Ü™VíOÕŸŞvßa3K¾ößw•ı.\0×ıòºç÷zÿù§,Y²d!¶/ØQy‚\0¥Y¸3­Ú³?ıƒ3gWÿı=O–ı.\0}ÚÑ÷>ºçÆË^233³Ûì¨<Á€Ò,Ü™VíïÙk?ş½²ß\0À¢ö•w}Øa‡-Ä–;*O° 4‚\0@…	vP˜`@i;\0€\nì 0Á€Òv\0\0&ØAa‚\0¥ì\0\0*L°ƒÂ;\0J#Ø\0T˜`…	v\0”F°\0¨0Á\nì\0(`\0L‚e«fÛtÄşåK|ØÍZZ;>û=¿}Ï¹ıÃ®+ØAa‚\0¥ì\0€Ò-[5³ô´#W-[ºbÙÒ¥KÊŞ›ÉsğPôìÁCsû¼ï™Ï×ì;(L° 4‚\0Pº•guØŠzµ+{G&ÚÜşƒÏ?{`ïOvµ–`…	v\0”F°\0J·ü¬5kŸ1¶®·ƒ‡¢\'ŸÛÿü\Zj-Á\nì\0(`\0”næ¬5Ç®˜){/¦ÀÏŸİ¿_°ƒqì\0(`\0”N°`ã$ØPšIv¯Ørúo^Óc¹=sïüô??0®ã3i>|É9ç±¯}Ö|éÊÓïÚv÷mm¸§ŞwbOÀ$ì$ØÁ8	v\0”F°›*+¯ûİ3Şóô›o¸;j«Õ7ıÍO>sÏŞÚ·oÓK.:uUj…]=Õ\\\0&™`7 ÁÆI° 4“ìî¹÷áËoİ‘y²> lå¢v‰!uB·üWÿÛQtÒi>õï×¯Štú]ö\0˜X‚İ€;\'Á€ÒvS$5¤.>=¶yÜRs`›cîr&\0LÁn@‚Œ“`@i¦=Ø%§Ğîk7kj1{èŞ‡?ò£¨1Ö¬.´åúf×µ¿I6¯ÄSÉ—H<•Ül`?›í¬½ñúÌÖÓ8ßÛæÁ¬Á¹®qy×ªëy0»ï«Ñ±c˜İT#œÚ·ÎÎø’s^~ÜÒÔÈ¾Î£¶3yŸ;ó“‡kCÑH˜ş‘µ7’ıQF±İŞ1ÔO€y\'Ø\rH°ƒqì\0(ÍT»FZzÙÔœĞ‡î}êèS×ÄKM<ÁËQìÕÃÁ.\n­ÛìĞÁ®=}5šß`——½âïı‡÷>uÚ©kâ[üŞG8»cÍışŞ\\w‚İ×on¶±h¨`×û\'À¼ì$ØÁ8	v\0”fzƒ];útÇ|5éDŸNsÉ>’\ZuCÍGÃµ2“p[kuv2¸Ù¡‚]§‹õÌC½î8‘·|jÔXöPÇ_´ıÈdVË;ÂÍã\ZrØü6ûÒõG^=ÿÙõ–Ø;5vùŞÄáj¾h?&Í›:ª¡€Å~\"\0Ì›ƒİê+_uÌ9É‡¾×ıW?RöÁÆI° 4Óì\ZI%\nÍĞl\rãjw´Ä,ÎæöãÁRU(>s³Ç$ÜTÇi®ÅJÖàÁ®¹î=‘n{{å¡Ü;N5“Sæ•ê›ñılÿ¾G8»{~—*nÉ£º@ÁnĞÅú»\"\0Ì›¡‚]/t\'ãË¿ò½_xºì÷0‚Œ“`@i¦6Ø5Ë²àFš¡\'§ét7òšü©¦í×7½uÄ‹OîåÒBÁ®5ôìÏ¿±û÷{¨wœÈjÖºŞ·›êØAÛÑ÷Ç·Óü™Ç*Xı Dí·“Ê|»äk.PØïpµ¦Ç¦¢d¿`7èO€yT<ØE‡_|îu×CWŞÕ¾xÃÊÆc{wÿÑOÜ[¥;(ï‰Çßò£FÛ[½öê_;ê„öÃ­az‰ç¾ÿÄªs¢öòQtò©>¼j÷[X_±çïîRG}ßöı‡Ø»¨ovÃ¾Ï|ëÑo\rğş;\'Á€ÒT2Ø5WOêÊn¤G°›t¬\\GÁ`µ3Ü7¢uyjØkØ\rRë¢œËìâ§±øÀÃØ\0½Ä|Ø¨`°‹²(ÖØì‘*Ø\rò`ŞìÖ?øĞÃ›Ùî¹¨™ÀÖÍµ›]m•Ußmä°WuòÛ[.±úãkçêÉ¬İVıSg¼^}ø^ÔNiÍºÿê=±eºËçl°»ÛG=Ü[¸•ùæ;˜@‚\0¥™ò`w°ÇœĞƒ]y—ÃŒ°‹O|JìW´‡¡õ26L°K__¯ï¡îìzá¤ô%ä:ÛÿìÃG¦~¦Ä¦îÙš\r»zaL]µ0\Z\"Ø\rô`Ş:%vÇ¾7lˆbÍ«×ZElù—ÓÁ.©æRÁ.]Ö\ZÛYv9ìîv8Ø½ê¬\ræR;ß‹`ã$ØPš©\rvı¯ÑŒ5ÙkØíêwÙ¸…»†İwîİ÷òä÷òóPÿ;Ndî}1Ğ¡N½‘Ì5ì–¸µ(PÙZë¶>½.yÙ»B×°K,=\\Á¼N_`7ÌO€ù4ÂM\'ö}å{;¾sÜ†oHİÖ<zdGcÀİêµWŸıec´]&ØÅ·\Za[¥5¶¶nrêkëUò6Ø}<ìö¬½ú¤}Wş|U²îõ\"ØÁ8	v\0”fzƒ]ê–¦ƒ¼:+5,kUò&°©ñhñbµÀw‰­Km$?õ½ãDö·êø>¤nÛûÿxı†dïì@óÒu»öD+cóa£…a—½ÇHgdâÀÁn¨Ÿ\0ói„)±uÉ9°I\'ã±sÍH—š{N\'·å°ë¬{jCbÈ^g™Îşäl°»Û`÷İc7lx`Ç8^°ƒÉ$ØPšé\rvQ{]j¡TÓ‰öì‹XŸPšwıµ˜Nô	»ğZ±*4x°ëÖ¥Şy¨ï\'ŞŞÿ\ZáC½kÏ¾uG$a<“õ<ÂË¦ÒX\'efš`ú…æã\Zv¹—5&Ø\rú`~ì2¬ëUgüÆ¹Ö ¸n°«-¿q_7ğõvÍÙµ»vŸ°¡5¯6ìÚ·¼Ø³&¼Áîng‚İİ\'¬Úwesg;˜H‚\0¥™ê`eÚY¼u‚ËUßÙÛÌFQx\0ZâNÉ¼vÙµzk\n»øZ½óPrH]bzlS°¬…ŞQàPßğøÊĞm^ûáT#›¨Tëlm.4n±g°Kì[ÎáJ5»}¸ú®K’WÖ‹z»Á\"\0Ì¯Qƒ]#œ½!jß¶ya»Ö½ º¥,ì:¬5Åµ>µöQàšt»¸.OŞ\r63Â.ÊÙ`·Ğ¥ƒİ99³‚L*Á€ÒLZ°›G‚Ko=Ûè|éQ< kä`µšİÊæ×ûÚµ.uÁ»†FzkÜÈµùıÜg¾5÷²ÎEå²7‘h¸G:/š¼†]\'ä…7øHg·ÓÁî„ÎÅï;˜T‚\0¥ì­1»·÷¿/\0Ô\rì†’Êdu¹7Šíµ™î}fK\'ØÁ8	v\0”F°[´2Øu§¦Î^À\0&9Ø|ê†wD?İ\n¶L‚Œ“`@i»EkAGØµ¯©·/y+[\0[˜`7²æì×½»Ã÷Ÿ-ƒ`ã$ØPš\n;\0`ZLh°›<‚Œ“`@i;\0 t‚İ€;\'Á€Òv\0@é»	v0N‚\0¥ì\0€Ò	vì`œ;\0J#Ø\0¥ì$ØÁ8	v\0”F°\0J·ü¬5kŸYº¤ìı˜lEO>·ÿyÁÆE° 4‚\0Pº¿tÔá+fV-Sìz™;pèù½û÷şd÷Pk	vP˜`@i;\0 tËœYvò‘+g–®X¶Ô8»¬ƒ‡¢gÚ»ïÀÁûŸÙÿÌş¡Öì 0Á€Òv\0À$XväÌòG˜YâÃnÖÒÚñÙhßÏö[ë\"ÁF ØP\ZÁ\0 Â;(L° 4‚\0@…	vP˜`@i;\0€\nì 0Á€Ò,h°ûÍÿüÃ¬œùÙÏ–ı.\0×­|öù7¼íLÁŠì\0(Í‚»?¹íşİ{÷ÿàgO—ı.\0³O\\½öˆåW½öDÁŠì\0(ÍÂiÕş˜=ôäŞw|ñ®S[µãÉgw=³¯ì÷\n\0°(¬;rù†£WÜûØÜ\'ëŒÙ5‡ÏÌÌ,Ä«vT`@iîL«ñWíÀCOîıÜşàgOïŞ»¿ì÷\n\0°(»ú°_=òâs;qíÊ¥\rñ*‚•\'ØPš=Ój6»æ6¹\0\0ÆcÉ’%K—.]ÖPûz^E°£ò;\0J³ĞgZÍfWûÃVö\0XD–¶-ÜKvT`@iœi\0P€ÓH*O° 4Î´\0\0(Ài$•\'ØP\ZgZ\0\0à4’Êì\0(3-\0\0\np\ZIå	v\0”Æ™\0\08¤ò;\0JãL\0€œFRy‚\0¥q¦\0@N#©<Á€Ò8Ó\0 \0§‘T`@iœiÁÿßŞ½\0ÉU¾?š‡#	„dÉ`FÂX\".ÙP(©àx‡l³©Ô&•8‡C(ÊÅµSu£%~\\¼^?âÕ®ïµËå’x—\0Iœ­W¥|±ãë$øvœÂ`.è1á!Ğ˜IóºÓİÓ§Ï9}º§çÌt==¿_ÕjG=ç|çÑNéğ¯ïœ\0à2’\'ØŒ+-\0\0\npIÏì\0Æ•\0\0¸Œ¤ç	v\0ãJ\0€\\FÒó;\0‚q¥\0@.#éy‚\0Á¸Ò\0 \0—‘ô<Á€`\\i\0P€ËHz`@0®´\0\0(Àe$=O° WZ\0\0à2’\'ØŒ+-\0\0\npIÏì\0¦İWZG_<óGßyèĞ‹§Æ\'C+\0ÀŠ°uãêË·o¼ñê·³¦}[ìèy‚\0Á´õJëè‹gn¹ç±+.>çÀÑ±ıGÇC+\0ÀŠ°kÛº]ÛÖ?xàäç¯ß}Á¦µmÚŠ`GÏì\0¦}WZ³ÿT}ü+O®Xõµ}”\0\0+ÎÛ.İrvræÃ¿ğšU«Vµc|Á\'ØLû®´fÿ1ûÕ/<²ûÂßİ\"ôQ\0¬8oÜuŞçFï¾ñõí_°£ç	v\0Ó¾+­ÙÏŞú™‡B\0ÀŠvßû/_½zu;Fìèy‚\0Áv\0\0=L°ƒÂ;\0‚ì\0\0z˜`…	v\0#Ø\0ô0Á\nì\0F°\0èa‚&ØŒ`\0ĞÃ;(L° Á\0 ‡	vP˜`@0‚\0Ğ\rú‡V_´~rp•ÿØ­×7{~&gÎ\Z\Z›\\èº‚&ØŒ`\0×?4Ğ·kÃPßÚş¾¾U¡÷¦ûLÏD§§gÆ&§¦Ÿ|yêå…5;Á\nì\0F°\0‚[·ûÜÕkKÕ.ôtµ±Éé³§§Æ;µ µ;(L° Á\0nğ²M›×˜[×ÜôLtâÌäÙGO.h-Á\nì\0F°\0‚¸lÓÖµ¡÷bxşôä¤`\"ØŒ`\0\'ØµH°ƒNì\0¦Û‚İUoºäc?³©Éc£cïûÂ?ìÔùé6·ß°gÏú‰êØô¥½—<ş½\'nûÖÜ…û«w\rî—.š[vê/¾üØûÇCï2\0ÌO°k‘`$ØŒ`·¬¬»ã½»Ï}é×îz\"š;Wã*—{êHä<\0èZ‚]‹;è$Á€`º3Øí?ğÌÍ=R÷ËÒ„²u+:Ø¥¦ÔİôË¯ÿõƒÙ÷ğwJ¿*µ¼]ëûãBW9“+»o°lv-ì “;\0‚ì–‘Ì”ºäí±•›aÇ¬L¾+«$¼È±\0t?Á®E‚t’`@0Ë=Ø¥ï¨N7+©4¬§<óÉG£øÉny#—†İRıKúÒÔ¯Ò›Hı*=lÎ~–gÃ\rU¯¤´éäŞV8–*n©_59i\rî{ÍÙJı©]÷«ÑÖøÖÕägö-ŞùÛoØså¶¾L(Œ¿ÙÕèÆçx>`útµr*âöe¿²ê õ_e”Øí‘}#\0,9Á®E‚t’`@0Ë:Ø•ÃĞ`f³q\'ª¢“çíÜ”,5É“[[ÏvQŞZ‰aìâ—E,a°›·7Uı‡NîÚ¹)9zòä7?Ãõ;VÙ\\î—X^xMeİ6»_0œ;lyœhAÁ®ù7À’ìZ$ØA\'	v\0³|ƒ]5úÔæ|eÚ7—úO2³®a¨òIjºVİM¸skÅ;™;ì‚‚]ÜÅšæ¡foœÈ,¶k}”?0{ª“­~2•ÎjÎpå<d¦VşZ?¹¯ôÉ«¢3Éï®É´ÄFÁ.Öâ-À•›9«y\0‹}#\0,™–ƒİÆ½×¼bOú£‡jß³¡ S;è$Á€`–o°+\'•(ïÍ¹i\\Õ–º‹³2~r\"X¦\n%ïÜlrn¦ãTÖŠ%«õ`WYwy¦Ûx³<ÔäIµ`5íM¹o¥¨ìgåüÏ{†ëw/îw™â–>«m\nv­.6o°kù`É,(ØEÉBwş+ï~íà}ÜóRècèÁ:I° ˜eìRY*£z\Z4Ú ×6¾Õ´Ú¹æMo±dñiø¸´¼`77õìS_?õ¦ªÉ\'\Z©Lk4Ï.÷T\'NÚÈ¼g89Nå;OT°ÒIˆª‡“É|-»ô6sP8ßéš»=6%çv­~#\0,¡âÁ.Zsı^õ“ÇŞ{ šıáºuåÏÆOİöÇŸJ¬R›”wü…w?Zn{7ïû©sÏ¯~<7M/õáØÃÇ‡öDÕå£èâÃ·z÷ÁÁäŠM\\SÛ¥Xiß&~%q¥a‡\'î¼ÿ¹û[8~Á:I° ˜v•Õ3³ºêiìÆZ++ì¢j†ûz´¥Q*úÒ‰Ì¼¿üS;ÁpŞ`—ü‚’i,9¡/1A/u?lT0ØEõ(Ì­±õg~AÁ®•o€%·È`wÁá§ŸÙQÉvg¢JÛ2Vmv³«}¿œÃ®¹ìâ›æ\\jœÒç›ÇJÉ¬İ†~Ï×+Mß‹ª)­²¡§ö&–©-ß`ÀÚnŸûLm\Z`bá¹Ì7&ØAì\0f™»†¯@ênÃ¬äÚùî»\\È»ä\r¡­ß{ğwªÓĞšL+ì\Z<ƒ/uªçvÍÎpZörñøòÌ†ÌQà–ØÌ;4\Z?Ã®T3O-ŒìZúF\0Xr‹½%vdâºá(Ñ¼ªqm®ˆ\rşM6Ø¥Åa.ì²e­<ÎÆÜ`×`ÀÚnç»k.Ëì|3‚t’`@0Ë6ØÍİï9ïcÎ¢ÆO Ë}\Z]“-ÖĞ`[­»L\\™~â^ã<4Ï\'æ»¿5gÌÜ©{†İ`Ó ™RWÙæ&Ö}ëÙèméÇŞz†]júCË=ØÜçô5	vùF\0XJ‹xéÄÄ}<°møöáÌkÍ£gGÊî6nŞ·;ú|y¶]]°K–7Ã.±ÊÜı°³ë¦o}ÛJ£kŸç»ÑÍû^=±÷ù¡tİkF°ƒNì\0fù»Ì+MË¤&yÅ/oÍLË\ZJ¿vKúÏd±jó[bS/r/ÍûÆ‰Ìûmã³Ñß¨¸Å·²îO¿\"~Z\\ó3üã†Ó½¯ş•»s®;6\Z­KÜµg†]ı;Fâ™‰-»}#\0,¥EÜ[’¾6íüWŞ½u¬é2·Äî‰s[ÃvñÄº“Ã©){ñ2ñş4°¶Û9Áîû[‡‡Ü³ş•‚t\'Á€`–o°‹ª“ì2ešN4:­LŞPÚèùk	qôÉ¿¥4w­Dj=ØÕêR³áæyãDî^Íû–Øc£[Ö§Îa2“5=Ã9Ì¤±8eÖ5Áì†–âv\rk¸`×ê7ÀÒZd°«d5×\\vñ/ÍM‚«»ÙåwLÔ_“`W¹»öØ©ó‡çî«M»ê+/F7åXÛíº`7rêü¡‰½•ì +	v\0³¬ƒ]TW©’\r(.·>0^ÉFQşãŞRo*H®&Ï€K­Õd²XEn°K®Õ<¥§Ô¥nMŠYıÙhrªïza]Şk^ç?Ã™F6–w¢2u,m,oŞbÓ`—Ú·§+Óì&>²ïñÒOÖ‹š»Ö¿\0–Öbƒ]9œ]U_[y°İÜ» j¥,ìâF6w‹kéÖÚ{¢œgÒ•ßâ:˜~lİ»¨Á€µB—\rv{â{f;èV‚\0Át[°[B‚KsMÛèRiöÖ\0ˆ-:ØEsÍn]åç‰j­Ë<ğ®¬œŞÊ/r­ü}ìÎûÇ®ˆ*Wÿ‰r€{6ŞhúvqÈËğÙx·³Áîüøáw‚t+Á€`»«Áî¦ùßÃ\0%-»Éd²’†/Šm6Lí=³Á	vĞI‚\0Áv+V;ƒ]íÖÔ1Óë\0hA7»‹wß=ŸxlH‚t’`@0‚İŠÕÖvÕ·UL¤_e\0ùÚì­r÷ëø©ü÷Ï† ØA\'	v\0ÓÃÁ\0X.º4ØuÁ:I° Á\0N°k‘`$ØŒ`\0\'ØµH°ƒNì\0F°\0‚ìZ$ØA\'	v\0#Ø\0Á	v-ì “;\0‚ì\0€à/Û´yÍ@ßªĞûÑİ¦g¢g&Ï\nvĞ)‚\0Áv\0@pk_wîšµCıŠ]3cS3gÇ\'Ç;µ µ;(L° Á\0®Ã@ÿÅÖ\rô­íï3Ï®ŞôLtzzf|bjú©—\'_\\Ğº‚&ØŒ`\0tƒş\rƒ;ÖO\r¬ò»õúfÏÏäÌÄ‘Ñ…ÖºH°ƒEì\0F°\0èa‚&ØŒ`\0ĞÃ;(L° Á\0 ‡	vP˜`@0m\rvïøÃ³nàÈñÓ¡\0`ÅÙ¾eİé³Sw½g·`Åv\0ÓÖ`÷û_yêÔøä#G^\n}”\0\0+ÎåÛ7n^?xë[·vPŒ`@0í»ÒšıÇìéã·ÜûøÎmC#\'N{y\"ô±\0¬[6Ÿ·öÀÑ±Ï¾óµnZ300Ğ­vô<Á€`Úw¥UşWmêéã_|ğ¹G¼tj|2ô±\0¬[7®¾ôÂ\r×¿aÛöÍëúÊÚ±Á\'ØL[¯´*Í®ò›¹\0\0:cÕªU}}}ıe³?·i+‚=O° ˜v_iUšİì?l¡\0`é«jß&;z`@0®´\0\0(Àe$=O° WZ\0\0à2’\'ØŒ+-\0\0\npIÏì\0Æ•\0\0¸Œ¤ç	v\0ãJ\0€\\FÒó;\0‚q¥\0@.#éy‚\0Á¸Ò\0 \0—‘ô<Á€`\\i\0P€ËHz`@0®´\0\0(Àe$=O° WZ\0\0à2’\'ØŒ+-\0\0\npIÏì\0Æ•\0\0¸Œ¤ç	v\0ãJ\0€\\FÒó;\0‚q¥\0@.#éyq°«tºÉÉÉé²\'NMV˜˜]ì¼Mç\nv\0,%WZ\0\0à2’W	v¿ñ¿199UšMWša73==}üøñòìº©É‰ÒL»‰‰‰Íçmì\0XJ®´\0\0(Àe$=ïÌ™3_şò—¯¾úê7Vn‡™‰fff^zé¥Ù¿–~,Í·+ı1::ºÿÿwíµ×\nv\0,\rWZ\0\0à2’wæÌ™üà‡:vüXó%7»iÛ¶m—_~¹`ÀÒp¥\0@.#éygÎœyşùçV¯^İ××¾jU©ËÍş™üdÖéÓ§;\0–F»¯´¾xæ¾9òĞ¡OO†>V\0€aëÆÕ—oßxãÕn;gMû¶\"ØÑó;\0‚ië•ÖÑÏÜrÏcW\\|Î£cû‡>V\0€a×¶u»¶­ğÀÉÏ_¿û‚MkÛ´Á\'ØLû®´fÿ©úøW\\=°êk?:¶øÑ\0\0X·]ºåìäÌ‡á5É¬°„;z`@0í»ÒšşÕ/<²ûÂßİ\"ôQ\0¬8oÜuŞçFï¾ñõí_°£ç	v\0Ó¾+­©©©·~æ¡ĞÇ\0°¢İ÷şËW¯^İ‘;z`@0‚\0@ì 0Á€`;\0€&ØAa‚\0Áv\0\0=L°ƒÂ;\0‚ì\0\0z˜`…	v\0#Ø\0ô0Á\nì\0F°\0èa‚&ØŒ`\0tƒş¡Õ­Ÿ\\å?vëõÍŸÉ™³‡F§Æ&º®`…	v\0#Ø\0Áõ\rôíÚ0Ôß·¶¿¯oÕâÇë5Ó3Ñéé™±É©é\'_zyaÍN°ƒÂ;\0‚ì\0€àÖí>wõÚRµ½#]mlrúìé©ñÇN-h-Á\nì\0F°\0‚¼lÓæ5æÖ57=83yöÑ“ZK°ƒÂ;\0‚ì\0€à.Û´uí@è½X?=9)ØA§v\0#Ø\0Á	v-ì “;\0‚é¶`wÕ›.ùØÏlj²ÀØèØû¾ğÏ;u~ºÍí7ìÙ³~¢z6}iï%ï‰Û¾u2wÉ+·õıÅ—»sÿxè½€yv-ì “;\0‚ì–•uw¼w÷y£/ıÚ]ODsçjcn’«Æ)Á€eA°k‘`$ØLw»ı¹ù¯Gê~YšP¶nE»Ô”º›~ùõ¿¾sğ#ûşNv±R×Ûµ¾_°`¹ìZ$ØA\'	v\0#Ø-#™)uéÛck*!oÿÑh—[bX&»	vĞI‚\0Á,÷`—¾…v\"9İìÕ»†?÷K<}à™O>\ZÍş0Tş0oäÒ°[ªy õH¸Ô¯Ò›Hı*=lÎ~–#ÚPuğÊ¸éäŞV8vôdåv×¤Ê¯šœ´ä>Wúáï=]üêæÏ°«œºÙu¿\ZmÏáuOÄkr†3ûï|îãóâ¯cöD5ºñ9¾ß9}ºZ9ñ\\ÂìWV¤ş«Œ»=² o€%\'ØµH°ƒNì\0fY»r\ZÌl6îDÕBtò¼›’¥&™`rËQbëùÁ.Ê[+1ì‚ƒ]eW‡Òû¥×mrÒa«4ò«¢3³›¾q¾—NTı‡NîÚ¹)9zòä7?Ãõ;VÙÿÜ/±¼ğšÊºm\nv?¾`8wØò8Ñ‚‚]óo€%\'ØµH°ƒNì\0fù»jô©Íùª|GŸ¸¹Ô’™u•C•ORÓµênÂ[+ŞÉÜaìâ.Ö4ÍÿÆ‰d›÷-±q5‹7šyUÅ|g¸r2S+­ŸBX+‰ó¿åÔIkìb•s>:]•FÉC®œØÌYÍ;3Å¾\0–LËÁnãŞk^±\'ıÑÃ?µïÙĞĞ)‚t’`@0Ë7Ø•“J”w‡æ\\±ªv´Ô]œ•ñ“Á2U(yçf“›p3§²V”(Y­»ÊºûË3İÆ›å¡yŞ8‘Şó¨Å`7–·Ÿ•ó?ï®ß½¸ßeŠ[fßÚìZ]lŞ`×ò7À’YP°‹’…îüWŞıÚÁû\Z¹ç¥ĞÇĞ‚t’`@0Ë6ØÅ/BÍQ	=\ršNmkßjZíqó¦·X²ø4|\\Z^°››zö©¯Ÿú@Ó5ß\'RSØ¢–ƒ]æT\'NÚÈ¼g89Nå;Ol®t¢êád2_‹Á.½ÍœÎwºænÍDÉù‚]«ß\0K¨x°‹Ö\\ÿ†Wıä±§÷ˆf¸n]ù³ñS·ıãñ§«Ô&åáİ–ÛŞÆÍû~êÜó«ÏMÓK}8öğñ¡=Quù(ºxçğíC§Ş}p0¹bÓ×Ôv)VÚ·‰_IEiØá‰;ïîş_°ƒNì\0¦\'ƒ]eõÌ¬®úAš»±VçÊÅ\n»¨šá¾miT Zy†İáW\\˜™øÖb°Ë`8o°K~AÉ4–œx˜˜ —‰…‚]Tÿ€ÂÜ\Z[æìZùF\0Xr‹v~ú™•lw&ª$°-cÕf7»ÊĞ÷Ë9ìšË.¾i.À¥Æ)}¾y¬”ÌJÑmèñ|½Òô½¨šÒ*zjßhb™Úò\r¬íö¹ÏÔ¦&Ë|c‚t!Á€`–y°›ÎÜ°™Ôb°krßåBfØ%omı–Øƒ¿S†ÖdÊXÁîğ¶K/l×Æ²ÏàKêù‚]³3œ–}„\\<şŸ<³!óE¸%6óÎÖÆÏ°ëêZ- Øµô\0°ä{KìÈÄuÃQ¢yUãÚ\\ü›l°K‹Ã\\&ØeËZyœ¹Á®Á€µİÎv×\\6<<–Ùùf;è$Á€`–m°›{-À¼9‹\Z?.÷itM¶X?Bƒmµ\Zì80qeú‰{óPó7N4›oØ<Øe¤îvƒMƒfJ]e››X÷­g£·¥gÿz†]júÓ•{sŸÓ×$Ø-ä`)-â¥÷=4òÀ¶áÛ‡3¯5)O¸Û¸yßîèóåÙvuÁ.9ZŞ»Ä*s÷ÃÎ®›¾õun+¬}ìF7ï{õÄŞç‡Òu¯Á:I° ˜åì2¯4-/šä¿¼53-k(ıØ-é<“ÅªÍo‰-õµÌ óĞ<oœ¨×ú[b÷§ß?-®ùşñÃéŞWÿÊİ¹G×Ö%î‡Ú3Ã®ş#ñÌÄ–ƒİ‚¾\0–Ò\"n‰-Iß›vş+ïŞ:V‰t™[b÷Ä¹­á»xbİÉáÔ”½x™x\ZXÛíœ`÷ı­ÃÃGîYÿJÁº“`@0Ë7ØEÕIv™…2M\'\ZˆÖ&o(môüµ„8úä»üµU¨õ`W«KÍóĞ|oœÈÑb°;6:±e}ê&3YÓ3œ3­/“Æâ”Y×³ZŠgØ5œf¸`×ê7ÀÒZd°«d5×\\vñ/ÍM‚«»ÙåwLÔ_“`W¹»öØ©ó‡çî«M»ê+/F7åXÛíº`7rêü¡‰½•ì +	v\0³¬ƒ]T×Î’\r(.·>0^ÉFQ6Õ†ßT¾E4?ØÕ¯Õd²XEn°K®Õ<¥§Ô¥nm¤õ·ÄŞõÂº¼×¼Î†3,÷ŞÛÌnÄ£åÍ[l\ZìRûÖàtešİÄGö=~CúÉzQÓ`×ú7ÀÒZl°+‡³ë¢êËa+¶›{D­”¥‚]ÜÈænq-İZ{O”óLºò[\\Óoƒ­›a5°Vè²ÁnO|Ï¬`İJ° ˜nvKHpi®i]*MŠ\'\0Ô,:ØEsÍn]åç‰j­Ë<ğ®¬œŞÊ/r­ü}ìÎûÇ®ˆ*Wÿ‰r€{6ŞhúvqÈËğÙx·³Áîüøáw‚t+Á€`»«Áî¦ùßÃ\0%-»Éd²’†/Šm6Lí=³Á	vĞI‚\0ÁtU°ûÆŞ+BŸÈñ–}ß½\0=®›ƒİÅ;‡o‰O¼\n6$Á:I° ˜®\nvKË»æÚ:Ã®ú¶Š‰æ¯²€Šö»E«Üı:~*ÿı³!vĞI‚\0Áôp°\0–‹.\rvİG°ƒNì\0F°\0‚ìZ$ØA\'	v\0#Ø\0Á	v-ì “;\0‚ì\0€à»	vĞI‚\0Áv\0@p‚]‹;è$Á€`;\0 ¸ÁË6m^3Ğ·jñ#õ²é™èÄ™É³‚tŠ`@0‚\0ÜÚ×»fíÀP¿b×ÌØÔÌÙñÉñÇN-h-Á\nì\0F°\0‚ëß0Ğñ†u}kûûÌ³«7=Ÿ˜š~êåÉ—\'´®`…	v\0#Ø\0İ ÃÀàõS«üÇn½¾Ùó393qdt¡µ.ì`;\0‚ì\0\0z˜`…	v\0#Ø\0ô0Á\nì\0F°\0èa‚&ØL[ƒİ;şğ‡ç¬8rütè£\0Xq¶oYwúìÔ]ïÙ-ØA1‚\0Á´5ØışW:5>ùÈ‘—B%\0ÀŠsùö›×ŞúÖí‚#ØLû®´¦§§Ÿ>1~Ë½ïÜ64râô±—\'B+\0ÀŠ°eÃàğykûì;_{á¦5íØŠ`GÏì\0¦}WZ³ÿTMMM=}bü‹>÷È‘—NO†>V\0€aëÆÕ—^¸áú7lÛ¾y]_Y;¶\"ØÑó;\0‚ië•V¥ÙÍšö/\0@g¬Zµª¯¯¯¿,Ù––`GÏì\0¦İWZ•f7==ú@\0V¾ªömB°£ç	v\0ãJ\0€\\FÒó;\0‚q¥\0@.#éy‚\0Á¸Ò\0 \0—‘ô<Á€`\\i\0P€ËHz`@0®´\0\0(Àe$=O° WZ\0\0à2’\'ØŒ+-\0\0\npIÏì\0Æ•\0\0¸Œ¤ç	v\0ãJ\0€\\FÒó;\0‚q¥\0@.#éy‚\0Á¸Ò\0 \0—‘ô<Á€`\\i\0P€ËHz`@0®´\0\0(Àe$=O° WZ\0\0à2’\'ØŒ+-\0\0\npIÏì\0Æ•\0\0¸Œ¤ç	v\0ãJ\0€\\FÒó;\0‚q¥\0@.#éy‚\0Á´ûJëè‹gşè›#zñÔødèc\0X¶n\\}ùö7^}á¶sÖ´o+‚=O° ˜¶^i}ñÌ-÷<vÅÅç8:¶ÿèxèc\0Xvm[·kÛúœüüõ»/Ø´¶M[ìèy‚\0Á´ïJköŸªåÉÕ«¾ö£c¡\0`ÅyÛ¥[ÎNÎ|ø^“Ì\nKH°£ç	v\0Ó¾+­ééé_ıÂ#»/Üøİı\'B%\0ÀŠóÆ]çxnôî_?00Ğñ;z`@0í»Òšššzëg\n}|\0\0+Ú}ï¿|õêÕíY°£ç	v\0#Ø\0ô0Á\nì\0F°\0èa‚&ØŒ`\0ĞÃ;(L° Á\0 ‡	vP˜`@0‚\0@ì 0Á€`;\0€&ØAa‚\0Áv\0@7è\ZX}ÑúÉÁUşc·^ßìù™œ9{htjlr¡ë\nvP˜`@0‚\0\\ÿĞ@ß®\rCı}kûûúV-~¼^3=›œš~òå©—Öì;(L° Á\0nİîsW¯-U»Ğ;ÒÕÆ&§Ï\ZìÔ‚Öì 0Á€`º-Ø}cïoÙ÷}ú³{şı£\0+Âàe›6¯0·®¹é™èÄ™É³\\ĞZ‚&ØL·;è*š@g\\¶iëÚĞ{±<zrR°ƒNì\0¦Û‚>\0+`×\"Á:I° ˜nvW½é’ıÌ¦&Œ½ïÿ|°Sç§ÛÜ~Ã=ë\'ªg`Ó—ö^òø÷¸í[\'ãß^¹m0½ÆÔ_|ù±;÷‡ŞñåJAèÁ®E‚t’`@0İì¾±÷Šæ¬ì`·î÷î>oô¥_»ë‰h.nnLô¸R¿Û’]E°`ìZ$ØA\'	v\0ÓmÁ®2Ãnÿgnşë‘º_–‚ÔºìRSênúå×ÿúÎÁì{ø;åß½z×ğç~é‚§óO™aĞ‚]‹;è$Á€`º-ØUfØ	v¹2SêÒ·ÇÎµÎwÈÀr!ØµH°ƒNì\0¦Û‚İBgØ¥Ÿy7O7‹3Î>ùh4ûÃPùÃ¼‘Sw’¦ƒWıM¦ñ&R¿J›³ŸåÙpCÕÁKw¶îZ?ÜÛÊÇ¬ÜîšTùU““V¶¼ØšÖo€ßW£­ñ9¬ï}MÎpfßâ/?J¯/³\'É	€Tßïœ>]­œŠøÎßìWV$÷~áx·G\Z}#³?˜aĞ‚]‹;è$Á€`º-Ø-h†]ów,TÑÉóvnJ–šdË-G‰­ç»(o­Ä°v•]Jï[”^·ÉI«[>ÑŸoôÕ}ÛßôöØÊ±ÿğÀÉ];7%GO®Õü×ïXeÿs«k²\'¶)Øıø‚áÜaËãD\nvÍ¿\0–œ`×\"Á:I° ˜nv­Ï°«FŸÚœ¯Ê\'qô‰›Kı\'™YW‰0Tù$5]«î&Ü¹µâÌvAÁ.îbMóPó7NTÆìÏ¬ÓdÀ¸šÅËT?™JgµFg¸r2S+­ŸBXúäUÑ™äw×dZb£`«œóñÔÑU6\Z%göUNlæ$äM\0løDfØtDËÁnãŞk^±\'ıÑÃ?µïÙĞĞ)‚t’`@0İìZŸaW™P–w‡æÜ4®jGKİÅYIEÉ‰`™*”~uCÃ›p3\r¨²V”(Y­»ÊºûË3İÆ›»foœ¨K%•êÔ({eúfr?+çŞ3\\¿{q¿Ë·Ì1ÚìZ]lŞ`×ò7À’YP°‹’…îüWŞıÚÁû\Z¹ç¥ĞÇĞ‚t’`@0İìZa—?¡¬¢z\Z4Ú ×6¾Õ´ÚãæMo±dñiø¸´¼`77õìS_?õ¦ªù\'r5¯Z¹§:±ÊÈ¼g89Nå;OT°ÒIˆª›Îd¾ƒ]z›9(œïtÍİ›‰’ó»Ô72d†@GvÑšëßğªŸ<öôŞÑì×­+6~ê¶<şTb•Ú¤¼ã/¼ûÑrÛÛ¸yßO{~õã¹iz©Ç>>´\'ª.Eï¾}èÔ»&Wl:àšÚ.ÅJû6ñ+‰£(\r;<qçıÏİßÂñvĞI‚\0Át[°ky†]³`WY=3««~&Án¬Õ¹r±‚Á.ªf¸¯G[\Z¨Ÿa—÷›fïÕm2ÁpŞ`—ü‚’i,9ñ01A/u?lT0ØEõ(Ì­±õg~AÁ®•o€%·È`wÁá§ŸÙQÉvg¢JÛ2Vmv³«}¿œÃ®¹ìâ›æ\\jœÒç›ÇJÉ¬İ†~Ï×+Mß‹ª)­²¡§ö&–©-ß`ÀÚnŸûLm\Z`bá¹Ì7&ØAì\0¦Û‚İgØMgnØLj1Ø5¹ïr!3ì’7„¶~KìÁß©NCk2e,h°kv†Ó²‹Çÿ“g6d¾ˆ·ÄfŞ¢Ûøv¥Â˜yja´€`—ıFÌ°èŒÅŞ;2qİp”h^Õ¸6WÄÿ&ìÒâ0—	vÙ²Vgcn°k0`m·óƒİ5—\rev¾Á:I° ˜nv|†İà¼9‹\Z?.÷itM¶X?Bƒmµ\Zì80qeú‰{çs5ãÄ¼÷·6¼%6s uÏ°l\Z4Sê*ÛÜÄºo=½-ıØ»BÏ°K-Ph¹›ûœ¾&Án!ß\0Ki/˜¸ï¡‘¶\rß>œy­yôìHyÂİÆÍûvGŸ/Ï¶«vÉÑòfØ%V™»vvİô­¯s[i4`íó¼`7ºyß«\'ö>?”®{ÍvĞI‚\0Át[°[ø[b§êŞ”\Z¥_:e¦e\r¥_»%İ“ÅªÍo‰-ÍËÒ85ãDÔø¥}y/ˆ¨êä>d^Ûüÿø‚átï«åîÜ£ëFë÷ÃFí™aWÿ‘xfbËÁ.ç1Ã 3qKlIúØ´ó_y÷Ö±J¤ËÜ»\'Îm\rgØÅëN§¦ìÅËÄûÓ`ÀÚnç»ïo>8rÏúW\nvĞ;\0‚é¶`×ú»¨:É.³P¦éD£ÑúÁä\r¥¿–GŸü[Js×JT¡Öƒ]­.µ0n7NäîUƒ3Y[şØèÄ–õ©s˜ÌdMÏpÎc3i,n^uM0»¡¥x†]ÃÇ\Z.$Øµú\0°´ìêYÍ5—]ü‹cs“àjÁnvùµÀ×$ØUî®=vêüá¹ûjÓÁ®úÊ‹ÑMùÖv».Øœ:hboeg;èJ‚\0Át[°k}†]rùx‰dŠƒË­ŒW²Q”ÿ¸·Ô›\nÒ·ˆ6y\\j­&“Å*rƒ]r­æy(=¥.u{lRÈêÏF“S}×ëò^ó:ÿÎ4²±¼•©cñhcyó›»Ô¾58]™f7ñ‘}ß~²^Ô4ØÕ#fØtÆbƒ]9œ]U_[y°İÜ» j¥,ìâF6w‹kéÖÚ{¢œgÒ•ßâ:˜~lİ»¨Á€µB—\rv{â{f;èV‚\0Át[°ûÆŞ+–ª˜!Õ\\Ó6ºTš½õ\0b‹vÑ\\³[Wùy¢Zë2¼++§·ò‹\\+»óş±+â‡ÊÕ¿D¢à7š~†]òò|6Şíl°;?~ø`İJ° ˜nvKH°k®Áî¦ùßÃÛí–° ĞDËÁnA2™¬¤á‹b›\rS{Ïlp‚t’`@0]ì*°ƒn£Ù´[7»‹wß=ŸxlH‚t’`@0]ì**sš–äÏ±(ª<ƒl	Çì¥?+\'¼#?pt¢ü¶Š‰(\Zì†#]äŸÿ/`…hO°[´Êİ¯ã§òß?‚`$ØL;\0`¥éÒ`×};è$Á€`;\0 8Á®E‚t’`@0‚\0œ`×\"Á:I° Á\0N°k‘`$ØŒ`\0\'ØµH°ƒNì\0F°\0‚¼lÓæ5}«?R/›‰Nœ™<+ØA§v\0#Ø\0Á­}İ¹kÖõ+vÍŒMÍœŸìÔ‚Öì 0Á€`;\0 ¸ş\rıoX7Ğ·¶¿Ï<»zÓ3Ñéé™ñ‰©é§^|yrAë\nvP˜`@0‚\0Ğ\rú7îX?5°ÊìÖë›=?“3GFZë\"ÁA° Á\0 ‡	vP˜`@0‚\0@ì 0Á€`;\0€&ØAa‚\0Á´5Ø½ãxÎº#ÇO‡>J\0€gû–u§ÏNİõİ‚#ØL[ƒİïå©Sã“y)ôQ\0¬8—oß¸yıà­oİ.ØA1‚\0Á´ïJkzzúéã·ÜûøÎmC#\'N{y\"ô±\0¬[6Ÿ·öÀÑ±Ï¾óµnZ300Ğ­vô<Á€`Úw¥5ûOÕÔÔÔÓ\'Æ¿øàsyéÔødèc\0X¶n\\}é…®Ã¶í›×õ•µc+‚=O° ˜¶^iUšİ¬ééiÿr\0tÆªU«úúúúË’Mai	vô<Á€`Ú}¥UivÓÓÓ¡\0`é«jß&;z`@0®´\0\0(Àe$=O° WZ\0\0à2’\'ØŒ+-\0\0\npIÏì\0Æ•\0\0¸Œ¤ç	v\0ãJ\0€\\FÒó;\0‚q¥\0@.#éy‚\0Á¸Ò\0 \0—‘ô<Á€`\\i\0P€ËHz`@0®´\0\0(Àe$=O° WZ\0\0à2’\'ØŒ+-\0\0\npIÏì\0Æ•\0\0¸Œ¤ç	v\0ãJ\0€\\FÒó;\0‚q¥\0@.#éy‚\0Á¸Ò\0 \0—‘ô<Á€`\\i\0P€ËHz`@0®´\0\0(Àe$=O° WZ\0\0à2’\'ØL»¯´¾xæ¾9òĞ¡OO†>V\0€aëÆÕ—oßxãÕn;gMû¶\"ØÑó;\0‚ië•ÖÑÏÜrÏcW\\|Î£cû‡>V\0€a×¶u»¶­ğÀÉÏ_¿û‚MkÛ´Á\'ØLû®´fÿ©úøW\\=°êk?:ú(\0Vœ·]ºåìäÌ‡á5É¬°„;z`@0í»ÒšşÕ/<²ûÂßİ\"ôQ\0¬8oÜuŞçFï¾ñõí_°£ç	v\0Ó¾+­©©©·~æ¡ĞÇ\0°¢İ÷şËW¯^İ‘;z`@0‚\0@ì 0Á€`;\0€&ØAa‚\0Áv\0\0=L°ƒÂ;\0‚ì\0\0z˜`…	v\0#Ø\0ô0Á\nì\0F°\0èa‚&ØŒ`\0tƒş¡Õ­Ÿ\\å?vëõÍŸÉ™³‡F§Æ&º®`…	v\0#Ø\0Áõ\rôíÚ0Ôß·¶¿¯oÕâÇë5Ó3Ñéé™±É©é\'_zyaÍN°ƒÂ;\0‚ì\0€àÖí>wõÚRµ½#]mlrúìé©ñÇN-h-Á\nì\0F°\0‚¼lÓæ5æÖ57=83yöÑ“ZK°ƒÂ;\0‚ì\0€à.Û´uí@è½X?=9)ØA§v\0#Ø\0Á	v-ì “;\0‚é¶`wÕ›.ùØÏlj²ÀØèØû¾ğÏ;u~ºÍí7ìÙ³~¢z6}iï%ï‰Û¾u2¹À•Û+?ï?ğÌÍ=z—`~‚]‹;è¤\"ÁîÈ‘#¡w\0\0\0\0zÓÖ­[;\0\0\0\0èE‚İèèhèİ\0\0\0€ŞÔßß/Ø\0\0\0@·ì\0\0\0\0 ‹v\0\0\0\0ĞE;\0\0\0\0è\"‚\0\0\0\0tÁ\0\0\0\0ºˆ`\0\0\0\0]D°\0\0\0€.\"Ø\0\0\0@ì\0\0\0\0 ‹v\0\0\0\0ĞE;\0\0\0\0è\"‚\0\0\0\0tÁ\0\0\0\0ºˆ`\0\0\0\0]D°\0\0\0€.\"Ø\0\0\0@ì\0€êğáÃ;vì½Ë‰3\0Ğ‚\0°\\}ç?ûÁ¯VÿòöO~óCWµ¸Â%7òÍ÷Á¿{óİrı‚C-‰Ã÷ÜøîC¿õÍmŸıÿïx¢ş÷ñ./0ÿ~•–KÖïk›†n°µøŒ\\rsÃÍ&¿·äé©­Ÿ·rõ¼_•»İÎ%\0@#‚\0°,•RM\'šr Ù9OĞJ¬’\n3†Z\Zõá(?•vğÀ%—<Í—’z\"Ø•#\\²¾•?§»¥>O|mÉo°~İ¹–—W?+¿jÒ\0:D°\0–£ï|âgÿô¢dXIU·Ä­j~IÌÅºä’Kx¢òÛR¶‰:TùÃÿ½yçw|un´DàËdÁºuZv•ï¾èOç-fÉÕS“ÔæúT:M&şš·pfÜ;Hş®Á¡åSÙ«›+§«üé5÷Ï}õÙ¬úÅ©~_åá£œ9q™ƒ‰×ŒÒç0ñ¿”¹½»äío¾\ZÕÍ°+}©‡vF_=`†\0œ`\0,GMæÁ¥~•œaÕ`†İ<CÅí\'ñ—ò*ÑÍy3ôâ¿4Z73üüÁ®AˆjtV*‹ÔíSeÎZş®6X¸á©hth\rÆIŞĞ[é¦o+aæ€Ê%ô?—sİ\\eK¼û¯i6í1íH:À&Nòá{î9rıõWåŞ[Ùòş‹[b€. Ø\0ËTrÎÜÍ¹&^,ÊÎ/;\\7+o¨ì®xèœÕ£Ú-˜õ,Š\ZE¢yƒ]66½Y·Ñ}«¹ç »‡õ7º•C‹2é2UP£œŸãuJY.Ê©sßiZìjÛÈƒü,XŞË¡°…(\n\0Ğ‚\0°ÜUs[<‡+u‡kî¬³fe+*}çœÜ;4ë3]ãu[l!Ø¥?hÔØ\Z­óN††E±á²CÏwhuãd=KìRE°@°«æº^:\0t	Á\0è	îˆ\\X°K­ñ¦o5Z¨®´Í\r]z6[ÔèvÏü\r5v©·×ÎiòR„ô±~5^6gZ[mWã­ä,œ7tãCk0Î‚]â–Ø¹:WÿIı!×îN¢ºÇæÌÿKTËuŞ\0t‹\"ÁîŸşéŸBï6¤ìŞ½;ô.\0ĞY9Q©úÑöŞÛd¨¨Ñ„¶úT^åæ›ÜQıx¾ÉpùÃ4¾×6±ìSk…ªQµ¬t]fW.œ·gMî¥ÍgÁn!/hp6²gµîõ$™%r\'¾}o\0 ½Š»éééĞ»\r5=ô`°òd\'V%îŠ,ôÒ‰&C¥^.Q«Á¬­;H”Fëf¢Y°ËZ\rîğŒçÕUâTrÍê»Q“ï¸MíjÓ…ó¶ÛàĞ4\'ZH°ËyëEî¹k2.ù?€Ïû¼c\0tT‘`799z·¡æá‡ì\0V¦Ôı¢©Ä”˜5•y¸Z&(½=}Shó¡j¿hô‰Ì+!r×Í¬Ò8Ø5ˆGy¯ˆ7TÛJâˆŞ¾6gˆfg¶ñöZñ¬?´üq¶/,ØeÏ\\ƒ{€›ÎŒ«ı²µówş\0Â)ì&&&Bï6Ô<òÈ#‚\0\0\0Ğ3Š»3gÎ„Şm¨yôÑG;\0\0\0 g	v³ÿ/ônCÍ~ô#Á\0\0\0èE‚İØØXèİ†šÿøÇ‚\0\0\0Ğ3Š»—_~91Âw>qÍ_ıgü®âæGXüP™a?ôµÒ—Ü<7æá{û7Ê~Û\'î¯¾mşeãİMõ³x±Äª-*­úwo.v˜©}XäÉYÜ©Û“íñyH¯Ã÷~âÛWè]G>ñ‰èCK°·‰~èÉúÓı/ÿò/‚\0\0\0Ğ3Š»—^z)1Âw>ùoÿÇEwİ¹˜`W¡ğP9+Ö>ªşİ{Ó\r‡~ó>xÕáê­,SoöƒÛ£ÛÊ›(ıî^óñê/ß{ï‘w½ëªïáÂ%öa±¹?Õ=9rï½ÛßU\Zdv¼G‰SrÓ=İùÁí÷~òÛWp‰úkiÔOŞş÷_‹~®n·üqÁ\0\0\0èE‚İ©S§#<ğ©7ÿÏ‹şÇï,eâ\nU¿âá?¿ùãÑ‡ËŸÌıxÕwnşÍCÿñï>peù“Òï:4ÿ2¥çÆ»÷¢;r~Qx®¶‹·¸ıÉÙ“ê€#Ÿzóÿñ·©…/¹i‘ÇoáæC]|ç?ÔïöO<!Ø\0\0\0=£H°;yòdb„şà-ÿó¢/Şñë¥ìõ7¿çÎıåOßzû7~¯ÚºâO+Î®pÛß&ŠG(ÿpûÏıım¥ÅwİT4wØä˜·G·ÍWúõ›¾Uì¶¨ü÷Òÿ÷{W&ö3ŞâHËTwáÏwÜQÚtiË‡şc|péQ\\Ñ[£¿ıÛıµ…J¿ŠRÇ{Ókî¼³´ZıñîºiöwŸ³-ŸÕòÖ_Sş{fùÚÑÕ­˜Y2»¡º=©îN©xV÷ô¸ò÷fÏîD¿WY*µ3Qv‹9‡S÷Ae›ñ·›:óû÷ïì\0\0\0€Q$Ø?~<1ÂƒŸ¾ö®‹şôÿaûì‰>öõ[ÿMùË÷şÖ?üÛÒ‡µŸê6\\±6Â×wıvz°¼aG>}í·ŞTş(3TòÇÒÒ\\J>×VÇ‰×‰je™ÊÏÕÏg×øDô¡¼ãÉ=!Oıvv·2|ıÚÌQÖ~*ï\\ôÛõûµxVã­×/ŸÜŸô\'™sû`æTç~T\ZÿĞ\rñG~úÓÑ­·ÿå§¸òÖÊ’;S¿«MwïÁO¿÷ğ;¿°ãÏËÛŒêv»äÉ\'Ÿì\0\0\0€‘	vıeõ‹M—Í»^x!ñ«ÿëÛî¾è?ÿkÑ—nùíCïşÚú7ÕO¿}õ×şÓpêÃÚ\ZıË?íºqvÅíÕj?´2ìŸD7Î-Z[¸ÖqÔV+m.úè×®şvvğDŸšw™òÏş×[üúÜèGòhãÊìá|Çû©ès[È>4ÙzÎò©‘S+Fés{$sªÓ{oyöä•†//½?uV~¾ô›ô”³Åôîe†ùùo<xù¤ÔÑ%ì\0\0\0€‘	v³^uÕU£££•_½â¯xİë^÷?ñï}ï{\'\'\'ç‚İì\n‰¾»ïí¶ãÎrv¹éğo|uï«Ÿ~ûê¯î½0õaÉ‘ø“#Õ4U¡öÃ|Ã¾±:ÒŸøùÎş5¹b”·àì†>}ªZÂæöáêoÏ¿Lr?³Òì¸‡“ú¹ÁñÖ¶/Ş‡#:«¹»\\zS›HœÛÌ_3g#_şrÇç÷Fûn9üªËåîLu¨¨ÉáÄ{;WøÊvşVê»:$Ø\0\0\0=#w†İoşæo\r\r½êU¯ºôÒKgÿ|ÃŞša÷ÜsÏ%Føîûw÷ì¸ãsïØ>ûÃÇ¢ü?¿ûÆ(:òWï»ùğõ¥K?}ógK¿Î.^ûMr„Êó;göƒOG·~îÿZ[qn½í_ª[ëÂêÚÕ¢ÿ6ÿ2å#øÒöÏıîSGü±o¼å#Õı8òWõ¯ïxGÔä¸’‡“9´fÇ[\Zé‹Ñ{f?Œ2û° ³š·|¼Â¿Ö¯˜9·ÛS}ãwS{’ÜHmè÷ùµÌ‚ß­û‚’[Ìİ½|OfàÛ›İ·#G;\0\0\0 gÔ?Ã®Òì>úÑşôOÿôÎ;wïŞ====55U{†İ³Ï>›á{ÿıîÙqÇgu8ŠFş×ûoşâÒ‡;ßSùdn}£üÓ[>ò•ÿıgªí|Ë[¢ƒ;n],!1Tóa3CÆÌşíªïÌ­W[«ºP<P¼w-,3û÷/mÿlùW	‰«K69®ÄY(m&šçx«G·ó=ïyõ¿9ûá¿[¿­ŸÕÜåãßÖ­ø¯u&şzaêl$ÏBòÖKîLı®F9ßhrìÚ¸™ƒª~##‚\0\0\0Ğ3*Ánpp0ùÒ‰Ùg¾ï¾û®»îºJ­‹’/xúé§CïvÇ|ï3¿säÿW&uÊÈÿú÷y×ß\\ù@À}è³ÑØìÿ ;\0\0\0 gT‚İÚµk’o‰­4»¸ÖEÕ`7>>¾jdd$ôn¯ÿøşûºáóŸù•ndİæÙgŸì\0\0\0€Q	vë×¯ŸıaÕªUM–¬ü¶ì>z·{Ø¿şß¿û¿ıÙ“•Ÿîƒış7„Ş¡îwôèQÁ\0\0\0è•`·qãÆäôº¨œçfffê^)Ø:t(ônCÍìÿ‚;\0\0\0 gT‚İ¹ç›is‚İØØØªƒ†Şm¨yá…;\0\0\0 gT‚İyç×âò¥`÷ä“O†Şm¨9~ü¸`\0\0\0ôŒJ°[³fMë«üÿuÉ³>0…Jâ\0\0\0\0IEND®B`‚','secondtest');
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
  `user_tmp` varchar(255) default NULL,
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
INSERT INTO `leaders` VALUES (1,6,'Ğ¼.Ğ§ĞµÑ€Ğ½Ñ–Ğ²Ñ†Ñ–, Ğ²ÑƒĞ».ĞœĞ°Ğ¼Ğ°Ñ—Ğ²ÑÑŒĞºĞ°.6','1980-06-23 00:00:00','Ğ¡Ğ•123345','Ğ¡ĞµÑ€Ğ³Ğ¸Ğ¹','ĞŸĞ¾Ğ½Ğ¾Ğ¼Ğ°Ñ€',NULL,'team1','2014-06-02 13:30:00'),(2,7,'Ğ¼. ĞšĞ°Ğ¼\'ÑĞ½ĞµÑ†ÑŒ-ĞŸĞ¾Ğ´Ñ–Ğ»ÑŒÑÑŒĞºĞ¸Ğ¹, Ğ²ÑƒĞ». Ğ“Ñ€ÑƒÑˆĞµĞ²ÑÑŒĞºĞ¾Ğ³Ğ¾ 74/524','1974-06-27 00:00:00','ĞĞ’','Ğ ÑƒÑĞ»Ğ°Ğ½','ĞšĞ°Ğ³Ñ–Ñ‚Ñ–Ğ½',NULL,'team2','2014-06-02 13:30:00'),(3,8,'Ğ¼. Ğ§ĞµÑ€Ğ½Ñ–Ğ²Ñ†Ñ–, Ğ²ÑƒĞ». ĞšĞ°ÑĞ¿Ñ€ÑƒĞºĞ° 13/9','1980-07-09 00:00:00','ĞºÑ€122312','ĞŸĞµÑ‚Ñ€Ğ¾Ğ²','Ğ Ğ¾Ğ·ÑƒĞ¼ĞµĞ½ĞºĞ¾',NULL,'team4','2014-06-02 13:30:00'),(4,4,'Ğ¼. Ğ¡Ñ‚Ñ€Ğ¸Ğ¹, Ğ²ÑƒĞ». Ğ‘Ğ°Ğ½Ğ´ĞµÑ€Ğ¸ 12Ğ± ĞºĞ². 6','1978-05-03 00:00:00','1-Ğ¡Ğ“â„–216123','Ğ Ğ¾Ğ¼Ğ°Ğ½','Ğ¨Ğ°Ğ½Ğ´Ğ°Ñ€ĞµĞ²ÑÑŒĞºĞ¸Ğ¹',NULL,'roman','2014-06-02 13:30:00'),(5,9,'Vfdvdfq','2014-06-03 00:00:00','Vdfvdfvq','Vfsdvfq','Vsfvdfq','Vfdvdfq','test','2014-06-03 13:30:00'),(8,10,'fgwer y3et erthyetr ','2014-06-04 00:00:00','34GT3RG34','Test','Test','3GF4F34F34','test1','2014-06-04 13:15:23'),(12,13,'123','2014-08-01 00:00:00','123','Alex','Mandryk','123',NULL,'2014-08-04 16:36:21'),(13,14,'123','2014-08-01 00:00:00','123','Tem','Dem','123',NULL,'2014-08-04 17:21:17'),(14,15,'123123','2014-07-30 00:00:00','123123','Tarasa','Demoa','123123',NULL,'2014-08-04 17:48:56'),(15,16,'vul. Geroiv Maidanu 12.4a / 16,7','2014-07-30 00:00:00','151','Tester','Mester','5234',NULL,'2014-08-05 14:29:47'),(17,18,'123','2014-08-13 00:00:00','123','Qw','Qw','123',NULL,'2014-08-13 14:19:00');
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
  `LEVEL` varchar(45) NOT NULL,
  `MESSAGE` varchar(1000) NOT NULL,
  `DATE` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` VALUES ('net.carting.service.UserDetailsServiceImpl','INFO','admin had logged successfully','2014-08-19 18:58:18,544'),('net.carting.service.UserDetailsServiceImpl','INFO','admin had logged successfully','2014-08-19 19:03:25,116'),('net.carting.service.UserDetailsServiceImpl','INFO','admin had logged successfully','2014-08-19 19:03:25,116'),('net.carting.service.UserDetailsServiceImpl','INFO','admin had logged successfully','2014-08-19 19:08:25,170'),('net.carting.service.UserDetailsServiceImpl','INFO','admin had logged successfully','2014-08-19 19:08:25,170'),('net.carting.web.CompetitionController','INFO','Admin has disabled competition (id = 1)','2014-08-19 19:08:31,771'),('net.carting.web.CompetitionController','INFO','Admin has disabled competition (id = 1)','2014-08-19 19:08:31,771'),('net.carting.web.CompetitionController','INFO','Admin has enabled competition (id = 1)','2014-08-19 19:09:07,312'),('net.carting.web.CompetitionController','INFO','Admin has enabled competition (id = 1)','2014-08-19 19:09:07,312'),('net.carting.service.UserDetailsServiceImpl','INFO','admin had logged successfully','2014-08-19 19:10:03,276'),('net.carting.web.CompetitionController','INFO','Admin has disabled competition (id = 1)','2014-08-19 19:10:08,122'),('org.springframework.web.context.ContextLoader','ERROR','Context initialization failed','2014-08-20 04:52:28,833'),('org.springframework.web.context.ContextLoader','ERROR','Context initialization failed','2014-08-20 04:52:47,178'),('org.springframework.web.context.ContextLoader','ERROR','Context initialization failed','2014-08-20 04:53:36,557'),('org.springframework.web.context.ContextLoader','ERROR','Context initialization failed','2014-08-20 04:58:21,716'),('org.springframework.web.context.ContextLoader','ERROR','Context initialization failed','2014-08-20 04:59:06,103'),('org.springframework.web.context.ContextLoader','ERROR','Context initialization failed','2014-08-20 05:00:29,564'),('org.springframework.web.context.ContextLoader','ERROR','Context initialization failed','2014-08-20 05:02:58,740'),('org.springframework.web.context.ContextLoader','ERROR','Context initialization failed','2014-08-20 05:04:10,765'),('net.carting.service.UserDetailsServiceImpl','INFO','admin had logged successfully','2014-08-20 05:06:58,167'),('org.hibernate.engine.jdbc.spi.SqlExceptionHelper','WARN','SQL Error: 1054, SQLState: 42S22','2014-08-20 05:06:58,821'),('org.hibernate.engine.jdbc.spi.SqlExceptionHelper','WARN','SQL Error: 1054, SQLState: 42S22','2014-08-20 05:10:05,352'),('net.carting.service.UserDetailsServiceImpl','INFO','admin had logged successfully','2014-08-20 05:12:06,094'),('org.hibernate.engine.jdbc.spi.SqlExceptionHelper','WARN','SQL Error: 1054, SQLState: 42S22','2014-08-20 05:12:06,492'),('org.hibernate.engine.jdbc.spi.SqlExceptionHelper','WARN','SQL Error: 1054, SQLState: 42S22','2014-08-20 05:12:12,092'),('net.carting.service.UserDetailsServiceImpl','INFO','admin had logged successfully','2014-08-20 05:14:36,849'),('net.carting.service.UserDetailsServiceImpl','INFO','admin had logged successfully','2014-08-20 05:16:57,202'),('org.hibernate.engine.jdbc.spi.SqlExceptionHelper','WARN','SQL Error: 1054, SQLState: 42S22','2014-08-20 05:16:57,496'),('net.carting.service.UserDetailsServiceImpl','INFO','admin had logged successfully','2014-08-20 05:21:26,029'),('org.hibernate.engine.jdbc.spi.SqlExceptionHelper','WARN','SQL Error: 1054, SQLState: 42S22','2014-08-20 05:21:26,304'),('net.carting.service.UserDetailsServiceImpl','INFO','admin had logged successfully','2014-08-20 05:22:57,508'),('net.carting.service.UserDetailsServiceImpl','INFO','admin had logged successfully','2014-08-20 05:37:21,193'),('net.carting.service.UserDetailsServiceImpl','INFO','admin had logged successfully','2014-08-20 05:48:32,837'),('net.carting.service.UserDetailsServiceImpl','INFO','admin had logged successfully','2014-08-20 05:49:34,265'),('net.carting.service.UserDetailsServiceImpl','INFO','admin had logged successfully','2014-08-21 14:23:08,497'),('net.carting.service.UserDetailsServiceImpl','INFO','admin had logged successfully','2014-08-21 14:25:05,364'),('net.carting.service.UserDetailsServiceImpl','INFO','admin had logged successfully','2014-08-21 14:41:21,485');
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qualifying`
--

DROP TABLE IF EXISTS `qualifying`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qualifying` (
  `id` int(11) NOT NULL auto_increment,
  `car_class_competition_id` int(11) NOT NULL,
  `racer_number` int(11) NOT NULL,
  `racer_place` int(11) NOT NULL,
  `racer_time` time default NULL,
  PRIMARY KEY  (`id`),
  KEY `car_class_competition_id` (`car_class_competition_id`),
  CONSTRAINT `qualifying_ibfk_1` FOREIGN KEY (`car_class_competition_id`) REFERENCES `car_class_competition` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qualifying`
--

LOCK TABLES `qualifying` WRITE;
/*!40000 ALTER TABLE `qualifying` DISABLE KEYS */;
INSERT INTO `qualifying` VALUES (1,6,12,1,'00:01:12'),(2,6,4,2,'00:01:13'),(3,6,8,3,'00:01:14'),(4,6,9,4,'00:01:15'),(5,5,2,1,'00:01:12'),(6,5,9,2,'00:01:13'),(7,5,1,3,'00:01:14'),(8,5,7,4,'00:01:19');
/*!40000 ALTER TABLE `qualifying` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `race_results`
--

LOCK TABLES `race_results` WRITE;
/*!40000 ALTER TABLE `race_results` DISABLE KEYS */;
INSERT INTO `race_results` VALUES (11,8,6,1,40,4,9),(12,4,5,3,0,4,7),(13,9,5,2,0,4,8),(14,12,4,4,0,4,3),(15,12,7,1,40,5,3),(16,9,6,2,24,5,8),(17,8,5,3,0,5,9),(18,4,2,4,0,5,7),(19,1,9,1,40,6,1),(20,2,8,2,24,6,2),(21,9,7,3,0,6,6),(22,7,5,4,0,6,7),(23,7,10,1,40,7,7),(24,1,10,2,24,7,1),(25,2,9,3,11,7,2),(26,9,1,4,0,7,6),(27,1,3,1,0,8,3);
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `racer_car_class_numbers`
--

LOCK TABLES `racer_car_class_numbers` WRITE;
/*!40000 ALTER TABLE `racer_car_class_numbers` DISABLE KEYS */;
INSERT INTO `racer_car_class_numbers` VALUES (1,1,3,1),(2,2,3,2),(3,12,7,3),(4,1,6,3),(5,9,4,4),(6,9,2,5),(7,9,3,6),(8,5,4,6),(9,7,3,7),(10,4,7,7),(11,9,7,8),(12,8,4,8),(13,8,7,9),(14,4,4,9),(15,3,3,10),(16,21,2,11),(17,54,3,11),(19,13,3,13),(21,88,3,15),(22,55,3,16),(29,10,2,21),(30,5,3,21),(31,17,9,22);
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `racer_competition_car_class_numbers`
--

LOCK TABLES `racer_competition_car_class_numbers` WRITE;
/*!40000 ALTER TABLE `racer_competition_car_class_numbers` DISABLE KEYS */;
INSERT INTO `racer_competition_car_class_numbers` VALUES (4,1,2,3),(6,2,3,2),(7,1,3,1),(10,9,6,8),(11,8,6,9),(12,2,5,2),(13,12,6,3),(14,1,5,1),(15,4,6,7),(17,9,5,6),(19,7,5,7),(29,13,3,13),(31,7,3,7);
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
INSERT INTO `racer_document` VALUES (21,10);
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `racers`
--

LOCK TABLES `racers` WRITE;
/*!40000 ALTER TABLE `racers` DISABLE KEYS */;
INSERT INTO `racers` VALUES (1,'Ğ¼.Ğ§ĞµÑ€Ğ½Ñ–Ğ²Ñ†Ñ–, Ğ²ÑƒĞ».ĞšĞ¾Ğ¼Ğ°Ñ€Ğ¾Ğ²Ğ° 31Ğ“,22','1994-07-16 00:00:00','ĞšĞ  â„–772048','ĞœĞ°ĞºÑĞ¸Ğ¼','Ğ›ĞµĞ»Ğ¸Ğº',1,'2014-05-15 10:24:29',4,1),(2,'Ğ¼.Ğ§ĞµÑ€Ğ½Ñ–Ğ²Ñ†Ñ–, Ğ²ÑƒĞ».Ğ“Ğ¾Ğ»Ğ¾Ğ²Ğ½Ğ°, 285, ĞºĞ².28','1986-06-26 00:00:00','ĞšĞ  â„–772048','Ğ’Ñ–Ñ‚Ğ°Ğ»Ñ–Ğ¹','Ğ’Ğ°Ñ…Ğ°Ñ‚Ğ°',1,'2014-05-15 10:27:53',4,1),(3,'Ğ¼.Ğ§ĞµÑ€Ğ½Ñ–Ğ²Ñ†Ñ–, Ğ²ÑƒĞ».Ğ¡Ñ‚Ğ¾Ñ€Ğ¾Ğ¶Ğ¸Ğ½ĞµÑ†ÑŒĞºĞ°, 60','2001-09-26 00:00:00','Ğ†-ĞœĞ˜ â„– 078300','ĞĞ½Ğ´Ñ€Ñ–Ğ¹','Ğ‘Ğ°Ğ»Ğ°ÑˆĞµĞ²',1,'2014-05-15 10:31:16',1,1),(4,'Ğ¼. ĞšĞ°Ğ¼\'ÑĞ½ĞµÑ†ÑŒ-ĞŸĞ¾Ğ´Ñ–Ğ»ÑŒÑÑŒĞºĞ¸Ğ¹, Ğ²ÑƒĞ». ĞºĞ½.ĞšĞ¾Ñ€Ñ‹Ğ°Ñ‚Ğ¾Ğ²Ñ‹Ñ‡Ñ‹Ğ² 68/54','2006-02-10 00:00:00','1-Ğ‘Ğ’ â„–023157','Ğ”Ğ°Ğ½Ğ¸Ñ—Ğ»','ĞšÑƒĞºÑƒÑ€ÑƒĞ·Ğ¾Ğ²',1,'2014-05-15 10:36:33',0,2),(5,'Ğ¼. ĞšĞ°Ğ¼\'ÑĞ½ĞµÑ†ÑŒ-ĞŸĞ¾Ğ´Ñ–Ğ»ÑŒÑÑŒĞºĞ¸Ğ¹, Ğ²ÑƒĞ». Ğ“Ğ°Ğ³Ğ°Ñ€Ñ–Ğ½Ğ° 69/35','2000-05-12 00:00:00','Ğ†-Ğ‘Ğ’','ĞœĞ°ĞºÑĞ¸Ğ¼a','ĞšĞ²Ğ°Ğ¿Ğ¸Ñˆ',1,'2014-05-15 10:43:35',4,2),(6,'Ğ¼. Ğ§ĞµÑ€Ğ½Ñ–Ğ²Ñ†Ñ–, Ğ²ÑƒĞ». ĞŸĞµÑ€ĞµÑÑĞ»Ñ–Ğ²ÑÑŒĞºĞ° 6/11 ','2009-11-19 00:00:00','ĞšĞ 233423','Ğ’Ğ°ÑĞ¸Ğ»ÑŒ','Ğ®Ñ‰ĞµĞ½ĞºĞ¾',1,'2014-05-15 11:56:04',0,2),(7,'Ğ²ÑƒĞ». ĞĞµĞ±ĞµÑĞ½Ğ¾Ñ— ÑĞ¾Ñ‚Ğ½Ñ– 14Ğ°','1981-03-05 00:00:00','ĞšĞ 3431234','ĞĞ»ĞµĞºÑÑ–Ğ¹ ','Ğ—Ğ°Ñ€ÑƒĞ±Ğ°Ğ¹ĞºĞ¾',1,'2014-05-15 11:58:22',5,2),(8,'Ğ¼. Ğ§ĞµÑ€Ğ½Ñ–Ğ²Ñ†Ñ–, Ğ²ÑƒĞ». Ğ¨ĞµĞ²Ñ‡ĞµĞ½ĞºĞ¾, 25','2008-11-12 00:00:00','Ñ€Ğ°12342','Ğ¡ĞµÑ€Ğ³Ñ–Ğ¹','ĞĞ°Ğ´Ğ¾Ğ»ÑŒÑÑŒĞºĞ¸Ğ¹',1,'2014-05-28 10:55:14',1,3),(9,'Ğ¼. Ğ§ĞµÑ€Ğ½Ñ–Ğ²Ñ†Ñ–, Ğ²ÑƒĞ». Ğ•Ğ½Ñ‚ÑƒĞ·Ñ–Ğ°ÑÑ‚Ñ–Ğ², 5','2007-07-11 00:00:00','ĞºĞµ342344545','ĞŸĞ°Ğ²Ğ»Ğ¾','ĞœÑƒÑ€Ğ·ĞµĞ½ĞºĞ¾',1,'2014-05-28 10:57:24',2,3),(10,'Ğ¼. Ğ¡Ñ‚Ñ€Ğ¸Ğ¹, Ğ²ÑƒĞ».1 Ğ›Ğ¸ÑÑ‚Ğ¾Ğ¿Ğ°Ğ´Ğ° 16Ğ, ĞºĞ². 3','1993-08-19 00:00:00','ĞšĞ¡ 729066','ĞĞ»ĞµĞ³','ĞšĞ°Ñ€Ğ¼Ğ°Ğ½',1,'2014-05-28 18:19:02',1,4),(11,'Ğ¼. Ğ¡Ñ‚Ñ€Ğ¸Ğ¹, Ğ²ÑƒĞ». Ğ‘. Ğ¥Ğ¼ĞµĞ»ÑŒĞ½Ğ¸Ñ†ÑŒĞºĞ¾Ğ³Ğ¾, 21, 3','1998-07-08 00:00:00','1-Ğ¡Ğ“ â„–158340','ĞœĞ°Ñ€ĞºĞ¾','Ğ›Ğ¸ÑĞ°Ğº',1,'2014-05-28 18:20:26',0,4),(13,'Vsdf','2014-06-02 00:00:00','Vdf','Vfvdfv','Vdfsvdfv',1,'2014-06-03 13:59:02',2,5),(15,'Ğ¿ĞŸĞ²Ğ°Ğ¿Ğ²Ğ°','1990-01-23 00:00:00','ĞŸĞ²Ğ°Ğ¿Ğ²Ğ°','ĞŸÑ–Ğ°Ğ¿','ĞŸĞ²Ğ°Ğ¿Ğ²Ğ°Ğ¿',1,'2014-06-04 13:26:17',0,13),(16,'Gdsfgfs','1992-03-12 00:00:00','Gdfgfds','Fsdggg','Gsfgfdsgds',1,'2014-06-04 14:04:40',1,13),(21,'Ğ¼. Ğ§ĞµÑ€Ğ½Ñ–Ğ²Ñ†Ñ–','1995-07-12 00:00:00','97NYY7MNH','ĞŸĞµÑ‚Ñ€Ğ¾','Ğ†Ğ²Ğ°Ğ½Ğ¾Ğ²',1,'2014-06-13 17:17:53',1,1),(22,'uu','2012-12-01 00:00:00','uuu','Dima','Pima',1,'2014-08-05 14:32:52',5,14);
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `races`
--

LOCK TABLES `races` WRITE;
/*!40000 ALTER TABLE `races` DISABLE KEYS */;
INSERT INTO `races` VALUES (4,7,4,1,'12 4 8 9 8 4 8 9 12 12 4 8 9 8 9 8 9 12 4 4',7,6),(5,7,4,2,'12 9 8 4 12 9 8 8 12 9 4 8 12 9 12 8 12 9 12 9',7,6),(6,10,4,1,'1 7 2 9 2 9 1 7 2 1 9 7 2 9 1 2 9 1 7 2 9 2 9 1 1 1 1 2 7',3,5),(7,10,4,2,'2 9 1 7 1 2 7 1 2 7 1 2 7 7 2 1 7 2 1 7 2 7 2 1 7 2 1 1 7 1',3,5),(8,6,1,1,'1 1 1',6,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_in_competition`
--

LOCK TABLES `team_in_competition` WRITE;
/*!40000 ALTER TABLE `team_in_competition` DISABLE KEYS */;
INSERT INTO `team_in_competition` VALUES (2,2,1),(10,1,2),(3,2,2),(1,2,3),(7,2,4),(8,1,5);
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
INSERT INTO `teams` VALUES (1,'Ğ¼.Ğ§ĞµÑ€Ğ½Ñ–Ğ²Ñ†Ñ–, Ğ²ÑƒĞ».ĞœĞ°Ğ¼Ğ°Ñ—Ğ²ÑÑŒĞºĞ°.6','Ğ§ĞµÑ€Ğ½Ñ–Ğ²ĞµÑ†ÑŒĞºĞ¸Ğ¹ ĞĞ¦ĞĞ¢Ğ¢Ğ£Ğœ',1,NULL),(2,'Ğ¼. ĞšĞ°Ğ¼\'ÑĞ½ĞµÑ†ÑŒ-ĞŸĞ¾Ğ´Ñ–Ğ»ÑŒÑÑŒĞºĞ¸Ğ¹, Ğ²ÑƒĞ». Ğ“Ñ€ÑƒÑˆĞµĞ²ÑÑŒĞºĞ¾Ğ³Ğ¾ 74/524','Ğ¤Ñ–Ğ»Ñ–Ñ Ğ¥ĞĞ¦ĞĞ¢Ğ¢Ğ£Ğœ Ğ¼. ĞšĞ°Ğ¼\'ÑĞ½ĞµÑ†ÑŒ-ĞŸĞ¾Ğ´Ñ–Ğ»ÑŒÑÑŒĞºĞ¸Ğ¹',2,NULL),(3,'Ğ¼. Ğ§ĞµÑ€Ğ½Ñ–Ğ²Ñ†Ñ–','Ğ§ĞµÑ€Ğ½Ñ–Ğ²ĞµÑ†ÑŒĞºÑ– ÑÑÑ‚Ñ€ÑƒĞ±Ğ¸',3,NULL),(4,'Ğ¼. Ğ¡Ñ‚Ñ€Ğ¸Ğ¹, Ğ²ÑƒĞ». Ğ‘Ğ°Ğ½Ğ´ĞµÑ€Ğ¸, 12 , ĞºĞ².6','Ğ›ÑŒĞ²Ñ–Ğ²ÑÑŒĞºĞ¸Ğ¹ ĞĞ¦ĞĞ¢Ğ¢Ğ£Ğœ',4,NULL),(5,'Adress','My Team',5,'E565'),(13,'Ğ¿ĞŸĞ°Ğ¿Ğ²Ğ°Ğ¿','ĞĞŸĞŸ',8,'ĞŸĞ²Ğ°Ğ¿Ğ²Ğ°Ğ¿'),(14,'fafa','Super Command',15,'123412'),(16,'Ğ§ĞµÑ€Ğ½Ñ–Ğ²Ñ†Ñ–, Ğ²ÑƒĞ» ĞšĞ¾Ğ¼Ğ°Ñ€Ğ¾Ğ²Ğ° 19/21, ĞºĞ². â„–56','Com',14,'AS â„–123456');
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
INSERT INTO `users` VALUES (1,'admin',1,'8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918',1,'',NULL),(4,'roman',1,'4eaae75f1df2f52bda44f6b18a400542d51c81bd7c00b0e720be5dc2c997575d',2,'',NULL),(6,'team1',1,'03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4',2,'',NULL),(7,'team2',1,'03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4',2,'',NULL),(8,'team4',1,'03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4',2,'',NULL),(9,'test',1,'0ffe1abd1a08215353c233d6e009613e95eec4253832a761af28ff37ac5a150c',2,'',NULL),(10,'test1',0,'0ffe1abd1a08215353c233d6e009613e95eec4253832a761af28ff37ac5a150c',2,'',NULL),(13,'alex',0,'96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e',2,'',NULL),(14,'tem',0,'96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e',2,'',NULL),(15,'demo',1,'96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e',2,'',NULL),(16,'tester',1,'96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e',2,'',NULL),(18,'kolio',1,'5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5',2,'kolio5991@gmail.com','682c5d12b454444f10e3660f3e1317434e93eabc9b58747552d05a642cdb45bc');
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

-- Dump completed on 2014-08-21 15:13:00
