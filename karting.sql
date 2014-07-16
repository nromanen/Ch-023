-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1
-- Время создания: Июн 13 2014 г., 17:24
-- Версия сервера: 5.5.25
-- Версия PHP: 5.3.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `karting`
--

-- --------------------------------------------------------

--
-- Структура таблицы `admin_settings`
--

CREATE TABLE IF NOT EXISTS `admin_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `feedback_email` varchar(255) NOT NULL,
  `parental_permission_years` int(11) NOT NULL,
  `points_by_places` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `admin_settings`
--

INSERT INTO `admin_settings` (`id`, `feedback_email`, `parental_permission_years`, `points_by_places`) VALUES
(1, 'softserve.karting@gmail.com', 18, '20,15,12,10,8,6,3,3,1');

-- --------------------------------------------------------

--
-- Структура таблицы `authorities`
--

CREATE TABLE IF NOT EXISTS `authorities` (
  `username` varchar(255) NOT NULL,
  `authority` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `authorities`
--

INSERT INTO `authorities` (`username`, `authority`) VALUES
('admin', 'ROLE_ADMIN'),
('roman', 'ROLE_TEAM_LEADER'),
('team1', 'ROLE_TEAM_LEADER'),
('team2', 'ROLE_TEAM_LEADER'),
('team4', 'ROLE_TEAM_LEADER'),
('test', 'ROLE_TEAM_LEADER'),
('test1', 'ROLE_TEAM_LEADER');

-- --------------------------------------------------------

--
-- Структура таблицы `car_classes`
--

CREATE TABLE IF NOT EXISTS `car_classes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lower_years_limit` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `upper_years_limit` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_2` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Дамп данных таблицы `car_classes`
--

INSERT INTO `car_classes` (`id`, `lower_years_limit`, `name`, `upper_years_limit`) VALUES
(1, 12, 'Популярний-Юнаки', 17),
(2, 15, 'Кадет', 99),
(3, 15, 'Популярний', 99),
(4, 6, 'Піонер Н-міні', 9),
(6, 6, 'Піонер Б', 13),
(7, 9, 'Піонер Н', 13),
(8, 5, 'dgfhdsgh', 8),
(9, 16, 'ICA', 98);

-- --------------------------------------------------------

--
-- Структура таблицы `car_class_competition`
--

CREATE TABLE IF NOT EXISTS `car_class_competition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `circle_count` int(11) NOT NULL,
  `first_race_time` time NOT NULL,
  `percentage_offset` int(11) NOT NULL,
  `second_race_time` time NOT NULL,
  `car_class_id` int(11) NOT NULL,
  `competition_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKC7F8C1CDED6F4EAD` (`competition_id`),
  KEY `FKC7F8C1CD1F1B02DE` (`car_class_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Дамп данных таблицы `car_class_competition`
--

INSERT INTO `car_class_competition` (`id`, `circle_count`, `first_race_time`, `percentage_offset`, `second_race_time`, `car_class_id`, `competition_id`) VALUES
(1, 6, '16:05:00', 75, '12:40:00', 7, 1),
(2, 6, '15:20:00', 75, '12:00:00', 6, 1),
(3, 10, '15:00:00', 75, '11:40:00', 3, 1),
(5, 7, '11:30:00', 75, '14:00:00', 3, 2),
(6, 7, '12:30:00', 75, '15:30:00', 7, 2),
(8, 4, '15:30:00', 75, '16:20:00', 1, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `car_class_competition_results`
--

CREATE TABLE IF NOT EXISTS `car_class_competition_results` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `absolute_place` int(11) DEFAULT NULL,
  `absolute_points` int(11) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `race2_points` int(11) DEFAULT NULL,
  `racer_competition_carclass_number_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK706F8784CA0A6B84` (`racer_competition_carclass_number_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- Дамп данных таблицы `car_class_competition_results`
--

INSERT INTO `car_class_competition_results` (`id`, `absolute_place`, `absolute_points`, `comment`, `race2_points`, `racer_competition_carclass_number_id`) VALUES
(7, 1, 20, 'без штрафу', 20, 13),
(8, 3, 17, '2 за маневрування', 0, 15),
(9, 2, 20, 'без штрафу', 0, 11),
(10, 4, 15, 'без штрафу', 15, 10),
(11, 2, 27, 'без штрафу', 12, 12),
(12, 4, 10, '10 за красивые глаза', 0, 17),
(13, 1, 30, '-5 за таран карту №1', 15, 14),
(14, 3, 20, 'без штрафу', 20, 19),
(15, 1, 0, 'без штрафу', 0, 4);

-- --------------------------------------------------------

--
-- Структура таблицы `competitions`
--

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Дамп данных таблицы `competitions`
--

INSERT INTO `competitions` (`id`, `date_end`, `date_start`, `director_category_judicial_license`, `director_name`, `enabled`, `first_race_date`, `name`, `place`, `second_race_date`, `secretary_category_judicial_license`, `secretary_name`) VALUES
(1, '2014-06-30', '2014-06-28', 'НК', 'МИРОНОВ В.І.', 0, '2014-06-28', 'ВСЕУКРАЇНСЬКІ ЗМАГАННЯ З КАРТИНГУ СЕРЕД УЧНІВСЬКОЇ МОЛОДІ 2014 року (фінальний етап)', 'м.Кам''янець-Подільський', '2014-06-30', 'НК', 'РИБАЛКА Л.А.'),
(2, '2014-05-29', '2014-05-28', 'НК', 'МИРОНОВ В.І.', 1, '2014-05-28', 'Чемпіонат Чернівецької області (весна 2014 року)', 'м. Чернівці', '2014-05-28', 'НК', 'РИБАЛКА Л.А.'),
(3, '2015-07-17', '2015-07-16', 'dsgfsd', 'Gdsfgdf', 0, '2014-06-06', 'Test', 'Test', '2014-06-07', 'dfgdsf', 'Gdgdf');

-- --------------------------------------------------------

--
-- Структура таблицы `documents`
--

CREATE TABLE IF NOT EXISTS `documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `approved` tinyint(1) NOT NULL,
  `checked` tinyint(1) NOT NULL,
  `finish_date` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `type` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Дамп данных таблицы `documents`
--

INSERT INTO `documents` (`id`, `approved`, `checked`, `finish_date`, `name`, `reason`, `start_date`, `type`) VALUES
(1, 0, 0, NULL, 'УНАК 25.15.12', '', NULL, 1),
(2, 1, 1, '2014-06-30 00:00:00', 'dfsgsdf', '', NULL, 2),
(3, 1, 1, NULL, 'sdfghsdfh', '', NULL, 1),
(4, 1, 1, '2014-07-25 00:00:00', NULL, '', NULL, 3),
(5, 1, 1, NULL, 'dghdfghdfgh', '', NULL, 1),
(6, 1, 1, '2014-07-31 00:00:00', NULL, '', NULL, 3);

-- --------------------------------------------------------

--
-- Структура таблицы `files`
--

CREATE TABLE IF NOT EXISTS `files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pass` varchar(255) NOT NULL,
  `document_id` int(11) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK5CEBA7717352767` (`document_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Дамп данных таблицы `files`
--

INSERT INTO `files` (`id`, `pass`, `document_id`, `path`) VALUES
(2, 'Racer''s license14012772230961.txt', 1, NULL),
(3, 'Racer''s insurance14013016216262.jpg', 2, NULL),
(4, 'Racer''s license14013017278162.jpg', 3, NULL),
(5, 'Racer''s medical certificate14013017643982.jpg', 4, NULL),
(6, 'Racer''s license14013018061382.jpg', 5, NULL),
(7, 'Racer''s medical certificate14013018221132.jpg', 6, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `leaders`
--

CREATE TABLE IF NOT EXISTS `leaders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) NOT NULL,
  `birthday` datetime NOT NULL,
  `document` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `license` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `registration_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3005C8AB2FAB5A3` (`user`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Дамп данных таблицы `leaders`
--

INSERT INTO `leaders` (`id`, `address`, `birthday`, `document`, `first_name`, `last_name`, `license`, `user`, `registration_date`) VALUES
(1, 'м.Чернівці, вул.Мамаївська.6', '1980-06-23 00:00:00', 'СЕ123345', 'Сергий', 'Пономар', NULL, 'team1', '2014-06-02 13:30:00'),
(2, 'м. Кам''янець-Подільський, вул. Грушевського 74/524', '1974-06-27 00:00:00', 'НВ', 'Руслан', 'Кагітін', NULL, 'team2', '2014-06-02 13:30:00'),
(3, 'м. Чернівці, вул. Каспрука 13/9', '1980-07-09 00:00:00', 'кр122312', 'Петров', 'Розуменко', NULL, 'team4', '2014-06-02 13:30:00'),
(4, 'м. Стрий, вул. Бандери 12б кв. 6', '1978-05-03 00:00:00', '1-СГ№216123', 'Роман', 'Шандаревський', NULL, 'roman', '2014-06-02 13:30:00'),
(5, 'Vfdvdfq', '2014-06-03 00:00:00', 'Vdfvdfvq', 'Vfsdvfq', 'Vsfvdfq', 'Vfdvdfq', 'test', '2014-06-03 13:30:00'),
(8, 'fgwer y3et erthyetr ', '2014-06-04 00:00:00', '34GT3RG34', 'Test', 'Test', '3GF4F34F34', 'test1', '2014-06-04 13:15:23');

-- --------------------------------------------------------

--
-- Структура таблицы `racers`
--

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
  KEY `FKC80DE8D25CF956A7` (`team_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=22 ;

--
-- Дамп данных таблицы `racers`
--

INSERT INTO `racers` (`id`, `address`, `birthday`, `document`, `first_name`, `last_name`, `enabled`, `registration_date`, `sports_category`, `team_id`) VALUES
(1, 'м.Чернівці, вул.Комарова 31Г,22', '1994-07-16 00:00:00', 'КР №772048', 'Максим', 'Лелик', 1, '2014-05-15 10:24:29', 4, 1),
(2, 'м.Чернівці, вул.Головна, 285, кв.28', '1986-06-26 00:00:00', 'КР №772048', 'Віталій', 'Вахата', 1, '2014-05-15 10:27:53', 4, 1),
(3, 'м.Чернівці, вул.Сторожинецька, 60', '2001-09-26 00:00:00', 'І-МИ № 078300', 'Андрій', 'Балашев', 1, '2014-05-15 10:31:16', 1, 1),
(4, 'м. Кам''янець-Подільський, вул. кн.Корыатовычыв 68/54', '2006-02-10 00:00:00', '1-БВ №023157', 'Даниїл', 'Кукурузов', 1, '2014-05-15 10:36:33', 0, 2),
(5, 'м. Кам''янець-Подільський, вул. Гагаріна 69/35', '2000-05-12 00:00:00', 'І-БВ 085846', 'Максим', 'Квапиш', 1, '2014-05-15 10:43:35', 4, 2),
(6, 'м. Чернівці, вул. Переяслівська 6/11 ', '2009-11-19 00:00:00', 'КР233423', 'Василь', 'Ющенко', 1, '2014-05-15 11:56:04', 0, 2),
(7, 'вул. Небесної сотні 14а', '1981-03-05 00:00:00', 'КР3431234', 'Олексій ', 'Зарубайко', 1, '2014-05-15 11:58:22', 5, 2),
(8, 'м. Чернівці, вул. Шевченко, 25', '2008-11-12 00:00:00', 'ра12342', 'Сергій', 'Надольський', 1, '2014-05-28 10:55:14', 1, 3),
(9, 'м. Чернівці, вул. Ентузіастів, 5', '2007-07-11 00:00:00', 'ке342344545', 'Павло', 'Мурзенко', 1, '2014-05-28 10:57:24', 2, 3),
(10, 'м. Стрий, вул.1 Листопада 16А, кв. 3', '1993-08-19 00:00:00', 'КС 729066', 'Олег', 'Карман', 1, '2014-05-28 18:19:02', 1, 4),
(11, 'м. Стрий, вул. Б. Хмельницького, 21, 3', '1998-07-08 00:00:00', '1-СГ №158340', 'Марко', 'Лисак', 1, '2014-05-28 18:20:26', 0, 4),
(13, 'Vsdf', '2014-06-02 00:00:00', 'Vdf', 'Vfvdfv', 'Vdfsvdfv', 1, '2014-06-03 13:59:02', 2, 5),
(15, 'пПвапва', '1990-01-23 00:00:00', 'Пвапва', 'Піап', 'Пвапвап', 1, '2014-06-04 13:26:17', 0, 13),
(16, 'Gdsfgfs', '1992-03-12 00:00:00', 'Gdfgfds', 'Fsdggg', 'Gsfgfdsgds', 1, '2014-06-04 14:04:40', 1, 13),
(21, 'м. Чернівці', '1995-07-12 00:00:00', '97NYY7MNH', 'Петро', 'Іванов', 1, '2014-06-13 17:17:53', 1, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `racer_car_class_numbers`
--

CREATE TABLE IF NOT EXISTS `racer_car_class_numbers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` int(11) NOT NULL,
  `car_class_id` int(11) NOT NULL,
  `racer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `racer_id` (`racer_id`,`car_class_id`),
  KEY `FK9F10E05AA1B9B1AD` (`racer_id`),
  KEY `FK9F10E05A1F1B02DE` (`car_class_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=31 ;

--
-- Дамп данных таблицы `racer_car_class_numbers`
--

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
(30, 5, 3, 21);

-- --------------------------------------------------------

--
-- Структура таблицы `racer_competition_car_class_numbers`
--

CREATE TABLE IF NOT EXISTS `racer_competition_car_class_numbers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number_in_competition` int(11) NOT NULL,
  `car_class_competition_id` int(11) NOT NULL,
  `racer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `racer_id` (`racer_id`,`car_class_competition_id`),
  KEY `FKFE2396DA7644F83B` (`car_class_competition_id`),
  KEY `FKFE2396DAA1B9B1AD` (`racer_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=32 ;

--
-- Дамп данных таблицы `racer_competition_car_class_numbers`
--

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

-- --------------------------------------------------------

--
-- Структура таблицы `racer_document`
--

CREATE TABLE IF NOT EXISTS `racer_document` (
  `racer_id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  PRIMARY KEY (`racer_id`,`document_id`),
  KEY `FKADCD1BD917352767` (`document_id`),
  KEY `FKADCD1BD9A1B9B1AD` (`racer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `racer_document`
--

INSERT INTO `racer_document` (`racer_id`, `document_id`) VALUES
(1, 1),
(4, 2),
(5, 2),
(6, 2),
(7, 2),
(6, 3),
(6, 4),
(7, 5),
(7, 6);

-- --------------------------------------------------------

--
-- Структура таблицы `races`
--

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
  KEY `FK6740FC21F1B02DE` (`car_class_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Дамп данных таблицы `races`
--

INSERT INTO `races` (`id`, `number_of_laps`, `number_of_members`, `race_number`, `result_sequance`, `car_class_id`, `car_class_competition_id`) VALUES
(4, 7, 4, 1, '12 4 8 9 8 4 8 9 12 12 4 8 9 8 9 8 9 12 4 4 4 ', 7, 6),
(5, 7, 4, 2, '12 9 8 4 12 9 8 8 12 9 4 8 12 9 12 8 12 9 12 9', 7, 6),
(6, 10, 4, 1, '1 7 2 9 2 9 1 7 2 1 9 7 2 9 1 2 9 1 7 2 9 2 9 1 1 1 1 2 7', 3, 5),
(7, 10, 4, 2, '2 9 1 7 1 2 7 1 2 7 1 2 7 7 2 1 7 2 1 7 2 7 2 1 7 2 1 1 7 1', 3, 5),
(8, 6, 1, 1, '1 1 1', 6, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `race_results`
--

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
  KEY `FK9D24CC88EC711227` (`race_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=28 ;

--
-- Дамп данных таблицы `race_results`
--

INSERT INTO `race_results` (`id`, `car_number`, `full_laps`, `place`, `points`, `race_id`, `racer_id`) VALUES
(11, 8, 6, 1, 20, 4, 9),
(12, 4, 6, 2, 15, 4, 7),
(13, 9, 5, 3, 0, 4, 8),
(14, 12, 4, 4, 0, 4, 3),
(15, 12, 7, 1, 20, 5, 3),
(16, 9, 6, 2, 15, 5, 8),
(17, 8, 5, 3, 0, 5, 9),
(18, 4, 2, 4, 0, 5, 7),
(19, 1, 9, 1, 20, 6, 1),
(20, 2, 8, 2, 15, 6, 2),
(21, 9, 7, 3, 0, 6, 6),
(22, 7, 5, 4, 0, 6, 7),
(23, 7, 10, 1, 20, 7, 7),
(24, 1, 10, 2, 15, 7, 1),
(25, 2, 9, 3, 12, 7, 2),
(26, 9, 1, 4, 0, 7, 6),
(27, 1, 3, 1, 0, 8, 3);

-- --------------------------------------------------------

--
-- Структура таблицы `teams`
--

CREATE TABLE IF NOT EXISTS `teams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `leader_id` int(11) NOT NULL,
  `license` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK69209B64530F7E7` (`leader_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Дамп данных таблицы `teams`
--

INSERT INTO `teams` (`id`, `address`, `name`, `leader_id`, `license`) VALUES
(1, 'м.Чернівці, вул.Мамаївська.6', 'Чернівецький ОЦНТТУМ', 1, NULL),
(2, 'м. Кам''янець-Подільський, вул. Грушевського 74/524', 'Філія ХОЦНТТУМ м. Кам''янець-Подільський', 2, NULL),
(3, 'м. Чернівці', 'Чернівецькі яструби', 3, NULL),
(4, 'м. Стрий, вул. Бандери, 12 , кв.6', 'Львівський ОЦНТТУМ', 4, NULL),
(5, 'Adress', 'My Team', 5, 'E565'),
(13, 'пПапвап', 'АПП', 8, 'Пвапвап');

-- --------------------------------------------------------

--
-- Структура таблицы `team_in_competition`
--

CREATE TABLE IF NOT EXISTS `team_in_competition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `competition_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `team_id` (`team_id`,`competition_id`),
  KEY `FK6C8DF3C7ED6F4EAD` (`competition_id`),
  KEY `FK6C8DF3C75CF956A7` (`team_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Дамп данных таблицы `team_in_competition`
--

INSERT INTO `team_in_competition` (`id`, `competition_id`, `team_id`) VALUES
(2, 2, 1),
(10, 1, 2),
(3, 2, 2),
(1, 2, 3),
(7, 2, 4),
(8, 1, 5);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `username` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`username`, `enabled`, `password`) VALUES
('admin', 1, '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918'),
('roman', 1, '4eaae75f1df2f52bda44f6b18a400542d51c81bd7c00b0e720be5dc2c997575d'),
('team1', 1, '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4'),
('team2', 1, '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4'),
('team4', 1, '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4'),
('test', 1, '0ffe1abd1a08215353c233d6e009613e95eec4253832a761af28ff37ac5a150c'),
('test1', 0, '0ffe1abd1a08215353c233d6e009613e95eec4253832a761af28ff37ac5a150c');

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `car_class_competition`
--
ALTER TABLE `car_class_competition`
  ADD CONSTRAINT `FKC7F8C1CD1F1B02DE` FOREIGN KEY (`car_class_id`) REFERENCES `car_classes` (`id`),
  ADD CONSTRAINT `FKC7F8C1CDED6F4EAD` FOREIGN KEY (`competition_id`) REFERENCES `competitions` (`id`);

--
-- Ограничения внешнего ключа таблицы `car_class_competition_results`
--
ALTER TABLE `car_class_competition_results`
  ADD CONSTRAINT `FK706F8784CA0A6B84` FOREIGN KEY (`racer_competition_carclass_number_id`) REFERENCES `racer_competition_car_class_numbers` (`id`);

--
-- Ограничения внешнего ключа таблицы `files`
--
ALTER TABLE `files`
  ADD CONSTRAINT `FK5CEBA7717352767` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`);

--
-- Ограничения внешнего ключа таблицы `leaders`
--
ALTER TABLE `leaders`
  ADD CONSTRAINT `FK3005C8AB2FAB5A3` FOREIGN KEY (`user`) REFERENCES `users` (`username`);

--
-- Ограничения внешнего ключа таблицы `racers`
--
ALTER TABLE `racers`
  ADD CONSTRAINT `FKC80DE8D25CF956A7` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`);

--
-- Ограничения внешнего ключа таблицы `racer_car_class_numbers`
--
ALTER TABLE `racer_car_class_numbers`
  ADD CONSTRAINT `FK9F10E05A1F1B02DE` FOREIGN KEY (`car_class_id`) REFERENCES `car_classes` (`id`),
  ADD CONSTRAINT `FK9F10E05AA1B9B1AD` FOREIGN KEY (`racer_id`) REFERENCES `racers` (`id`);

--
-- Ограничения внешнего ключа таблицы `racer_competition_car_class_numbers`
--
ALTER TABLE `racer_competition_car_class_numbers`
  ADD CONSTRAINT `FKFE2396DA7644F83B` FOREIGN KEY (`car_class_competition_id`) REFERENCES `car_class_competition` (`id`),
  ADD CONSTRAINT `FKFE2396DAA1B9B1AD` FOREIGN KEY (`racer_id`) REFERENCES `racers` (`id`);

--
-- Ограничения внешнего ключа таблицы `racer_document`
--
ALTER TABLE `racer_document`
  ADD CONSTRAINT `FKADCD1BD917352767` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`),
  ADD CONSTRAINT `FKADCD1BD9A1B9B1AD` FOREIGN KEY (`racer_id`) REFERENCES `racers` (`id`);

--
-- Ограничения внешнего ключа таблицы `races`
--
ALTER TABLE `races`
  ADD CONSTRAINT `FK6740FC21F1B02DE` FOREIGN KEY (`car_class_id`) REFERENCES `car_classes` (`id`),
  ADD CONSTRAINT `FK6740FC27644F83B` FOREIGN KEY (`car_class_competition_id`) REFERENCES `car_class_competition` (`id`);

--
-- Ограничения внешнего ключа таблицы `race_results`
--
ALTER TABLE `race_results`
  ADD CONSTRAINT `FK9D24CC88A1B9B1AD` FOREIGN KEY (`racer_id`) REFERENCES `racers` (`id`),
  ADD CONSTRAINT `FK9D24CC88EC711227` FOREIGN KEY (`race_id`) REFERENCES `races` (`id`);

--
-- Ограничения внешнего ключа таблицы `teams`
--
ALTER TABLE `teams`
  ADD CONSTRAINT `FK69209B64530F7E7` FOREIGN KEY (`leader_id`) REFERENCES `leaders` (`id`);

--
-- Ограничения внешнего ключа таблицы `team_in_competition`
--
ALTER TABLE `team_in_competition`
  ADD CONSTRAINT `FK6C8DF3C75CF956A7` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`),
  ADD CONSTRAINT `FK6C8DF3C7ED6F4EAD` FOREIGN KEY (`competition_id`) REFERENCES `competitions` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
