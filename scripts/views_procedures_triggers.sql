-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: ekindergarten
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `number` char(16) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `amount` int NOT NULL,
  `date` date NOT NULL,
  `isPaid` tinyint NOT NULL,
  `KINDERGARTEN_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`number`),
  KEY `fk_ACCOUNT_KINDERGARTEN1_idx` (`KINDERGARTEN_name`),
  CONSTRAINT `fk_ACCOUNT_KINDERGARTEN1` FOREIGN KEY (`KINDERGARTEN_name`) REFERENCES `kindergarten` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activity`
--

DROP TABLE IF EXISTS `activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity`
--

LOCK TABLES `activity` WRITE;
/*!40000 ALTER TABLE `activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activity_has_group`
--

DROP TABLE IF EXISTS `activity_has_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity_has_group` (
  `ACTIVITY_id` int NOT NULL,
  `GROUP_id` int NOT NULL,
  `date` date NOT NULL,
  `period` int NOT NULL,
  PRIMARY KEY (`ACTIVITY_id`,`GROUP_id`,`date`),
  KEY `fk_ACTIVITY_has_GROUP_GROUP1_idx` (`GROUP_id`),
  KEY `fk_ACTIVITY_has_GROUP_ACTIVITY1_idx` (`ACTIVITY_id`),
  CONSTRAINT `fk_ACTIVITY_has_GROUP_ACTIVITY1` FOREIGN KEY (`ACTIVITY_id`) REFERENCES `activity` (`id`),
  CONSTRAINT `fk_ACTIVITY_has_GROUP_GROUP1` FOREIGN KEY (`GROUP_id`) REFERENCES `group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_has_group`
--

LOCK TABLES `activity_has_group` WRITE;
/*!40000 ALTER TABLE `activity_has_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_has_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `id` int NOT NULL AUTO_INCREMENT,
  `street` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `city` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `number` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'street1','city1',1);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `salary` int NOT NULL,
  `username` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `PERSON_id` int NOT NULL,
  PRIMARY KEY (`PERSON_id`),
  CONSTRAINT `fk_ADMIN_PERSON1` FOREIGN KEY (`PERSON_id`) REFERENCES `person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `arrival_departure_time`
--

DROP TABLE IF EXISTS `arrival_departure_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `arrival_departure_time` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dateTime` datetime NOT NULL,
  `CHILD_PERSON_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ARRIVAL_DEPARTURE_TIME_CHILD1_idx` (`CHILD_PERSON_id`),
  CONSTRAINT `fk_ARRIVAL_DEPARTURE_TIME_CHILD1` FOREIGN KEY (`CHILD_PERSON_id`) REFERENCES `child` (`PERSON_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arrival_departure_time`
--

LOCK TABLES `arrival_departure_time` WRITE;
/*!40000 ALTER TABLE `arrival_departure_time` DISABLE KEYS */;
/*!40000 ALTER TABLE `arrival_departure_time` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `child`
--

DROP TABLE IF EXISTS `child`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `child` (
  `height` int NOT NULL,
  `weight` int NOT NULL,
  `PERSON_id` int NOT NULL,
  PRIMARY KEY (`PERSON_id`),
  KEY `fk_DIJETE_PERSON1_idx` (`PERSON_id`),
  CONSTRAINT `fk_DIJETE_PERSON1` FOREIGN KEY (`PERSON_id`) REFERENCES `person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `child`
--

LOCK TABLES `child` WRITE;
/*!40000 ALTER TABLE `child` DISABLE KEYS */;
INSERT INTO `child` VALUES (130,20,1);
/*!40000 ALTER TABLE `child` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `child_has_group`
--

DROP TABLE IF EXISTS `child_has_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `child_has_group` (
  `CHILD_PERSON_id` int NOT NULL,
  `GROUP_id` int NOT NULL,
  `period` int NOT NULL,
  `electionDate` date NOT NULL,
  PRIMARY KEY (`CHILD_PERSON_id`,`electionDate`),
  KEY `fk_CHILD_has_GROUP_GROUP1_idx` (`GROUP_id`),
  KEY `fk_CHILD_has_GROUP_CHILD1_idx` (`CHILD_PERSON_id`),
  CONSTRAINT `fk_CHILD_has_GROUP_CHILD1` FOREIGN KEY (`CHILD_PERSON_id`) REFERENCES `child` (`PERSON_id`),
  CONSTRAINT `fk_CHILD_has_GROUP_GROUP1` FOREIGN KEY (`GROUP_id`) REFERENCES `group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `child_has_group`
--

LOCK TABLES `child_has_group` WRITE;
/*!40000 ALTER TABLE `child_has_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `child_has_group` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `adding_child_to_group` AFTER INSERT ON `child_has_group` FOR EACH ROW update ekindergarten.group
set numberOfMembers = numberOfMembers + 1
where id = new.GROUP_id */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `deleting_child_from_group` AFTER DELETE ON `child_has_group` FOR EACH ROW update ekindergarten.group
set numberOfMembers = numberOfMembers - 1
where id = old.GROUP_id */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `educator`
--

DROP TABLE IF EXISTS `educator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `educator` (
  `salary` int NOT NULL,
  `username` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `PERSON_id` int NOT NULL,
  PRIMARY KEY (`PERSON_id`),
  KEY `fk_VASPITAC_PERSON1_idx` (`PERSON_id`),
  CONSTRAINT `fk_VASPITAC_PERSON1` FOREIGN KEY (`PERSON_id`) REFERENCES `person` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `educator`
--

LOCK TABLES `educator` WRITE;
/*!40000 ALTER TABLE `educator` DISABLE KEYS */;
/*!40000 ALTER TABLE `educator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `educator_has_group`
--

DROP TABLE IF EXISTS `educator_has_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `educator_has_group` (
  `EDUCATOR_PERSON_id` int NOT NULL,
  `GROUP_id` int NOT NULL,
  `electionDate` date NOT NULL,
  `period` int NOT NULL,
  PRIMARY KEY (`EDUCATOR_PERSON_id`,`GROUP_id`,`electionDate`),
  KEY `fk_EDUCATOR_has_GROUP_GROUP1_idx` (`GROUP_id`),
  KEY `fk_EDUCATOR_has_GROUP_EDUCATOR1_idx` (`EDUCATOR_PERSON_id`),
  CONSTRAINT `fk_EDUCATOR_has_GROUP_EDUCATOR1` FOREIGN KEY (`EDUCATOR_PERSON_id`) REFERENCES `educator` (`PERSON_id`),
  CONSTRAINT `fk_EDUCATOR_has_GROUP_GROUP1` FOREIGN KEY (`GROUP_id`) REFERENCES `group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `educator_has_group`
--

LOCK TABLES `educator_has_group` WRITE;
/*!40000 ALTER TABLE `educator_has_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `educator_has_group` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `adding_educator_to_group` AFTER INSERT ON `educator_has_group` FOR EACH ROW update ekindergarten.group
set numberOfMembers = numberOfMembers + 1
where id = new.GROUP_id */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `deleting_educator_from_group` AFTER DELETE ON `educator_has_group` FOR EACH ROW update ekindergarten.group
set numberOfMembers = numberOfMembers - 1
where id = old.GROUP_id */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `find_educator_name`
--

DROP TABLE IF EXISTS `find_educator_name`;
/*!50001 DROP VIEW IF EXISTS `find_educator_name`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `find_educator_name` AS SELECT 
 1 AS `firstName`,
 1 AS `lastName`,
 1 AS `username`,
 1 AS `password`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `group`
--

DROP TABLE IF EXISTS `group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `numberOfMembers` int NOT NULL,
  `isActive` tinyint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `NazivGrupe_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group`
--

LOCK TABLES `group` WRITE;
/*!40000 ALTER TABLE `group` DISABLE KEYS */;
INSERT INTO `group` VALUES (1,'Prva grupa',0,0);
/*!40000 ALTER TABLE `group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hygiene_test`
--

DROP TABLE IF EXISTS `hygiene_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hygiene_test` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `period` tinyint NOT NULL,
  `EDUCATOR_PERSON_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_HYGIENE_TEST_EDUCATOR1_idx` (`EDUCATOR_PERSON_id`),
  CONSTRAINT `fk_HYGIENE_TEST_EDUCATOR1` FOREIGN KEY (`EDUCATOR_PERSON_id`) REFERENCES `educator` (`PERSON_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hygiene_test`
--

LOCK TABLES `hygiene_test` WRITE;
/*!40000 ALTER TABLE `hygiene_test` DISABLE KEYS */;
/*!40000 ALTER TABLE `hygiene_test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kindergarten`
--

DROP TABLE IF EXISTS `kindergarten`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kindergarten` (
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `phoneNumber` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `ADDRESS_id` int NOT NULL,
  PRIMARY KEY (`name`),
  KEY `fk_KINDERGARTEN_ADDRESS1_idx` (`ADDRESS_id`),
  CONSTRAINT `fk_KINDERGARTEN_ADDRESS1` FOREIGN KEY (`ADDRESS_id`) REFERENCES `address` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kindergarten`
--

LOCK TABLES `kindergarten` WRITE;
/*!40000 ALTER TABLE `kindergarten` DISABLE KEYS */;
/*!40000 ALTER TABLE `kindergarten` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medical_clearance`
--

DROP TABLE IF EXISTS `medical_clearance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medical_clearance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `period` tinyint NOT NULL,
  `EDUCATOR_PERSON_id` int DEFAULT NULL,
  `CHILD_PERSON_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_MEDICAL_CLEARANCE_EDUCATOR1_idx` (`EDUCATOR_PERSON_id`),
  KEY `fk_MEDICAL_CLEARANCE_CHILD1_idx` (`CHILD_PERSON_id`),
  CONSTRAINT `fk_MEDICAL_CLEARANCE_CHILD1` FOREIGN KEY (`CHILD_PERSON_id`) REFERENCES `child` (`PERSON_id`),
  CONSTRAINT `fk_MEDICAL_CLEARANCE_EDUCATOR1` FOREIGN KEY (`EDUCATOR_PERSON_id`) REFERENCES `educator` (`PERSON_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medical_clearance`
--

LOCK TABLES `medical_clearance` WRITE;
/*!40000 ALTER TABLE `medical_clearance` DISABLE KEYS */;
/*!40000 ALTER TABLE `medical_clearance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `membership_fee`
--

DROP TABLE IF EXISTS `membership_fee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `membership_fee` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `amoun` int NOT NULL,
  `isPaid` tinyint DEFAULT NULL,
  `date` date NOT NULL,
  `dateOfPaymant` date DEFAULT NULL,
  `CHILD_PERSON_id` int NOT NULL,
  PRIMARY KEY (`id`,`CHILD_PERSON_id`),
  KEY `fk_MEMBERSHIP_FEE_CHILD1_idx` (`CHILD_PERSON_id`),
  CONSTRAINT `fk_MEMBERSHIP_FEE_CHILD1` FOREIGN KEY (`CHILD_PERSON_id`) REFERENCES `child` (`PERSON_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membership_fee`
--

LOCK TABLES `membership_fee` WRITE;
/*!40000 ALTER TABLE `membership_fee` DISABLE KEYS */;
INSERT INTO `membership_fee` VALUES (1,'Service 1',200,0,'2023-08-07',NULL,1);
/*!40000 ALTER TABLE `membership_fee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `note`
--

DROP TABLE IF EXISTS `note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `note` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `CHILD_PERSON_id` int NOT NULL,
  PRIMARY KEY (`id`,`CHILD_PERSON_id`),
  KEY `fk_NOTE_CHILD1_idx` (`CHILD_PERSON_id`),
  CONSTRAINT `fk_NOTE_CHILD1` FOREIGN KEY (`CHILD_PERSON_id`) REFERENCES `child` (`PERSON_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `note`
--

LOCK TABLES `note` WRITE;
/*!40000 ALTER TABLE `note` DISABLE KEYS */;
/*!40000 ALTER TABLE `note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person` (
  `id` int NOT NULL AUTO_INCREMENT,
  `imbd` char(13) COLLATE utf8_unicode_ci NOT NULL,
  `firstName` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `lastName` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `dateOfBirth` date NOT NULL,
  `ADDRESS_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `JMB_UNIQUE` (`imbd`),
  KEY `fk_PERSON_ADDRESS1_idx` (`ADDRESS_id`),
  CONSTRAINT `fk_PERSON_ADDRESS1` FOREIGN KEY (`ADDRESS_id`) REFERENCES `address` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (1,'1234567890123','Jovan','Jovanovic','2019-02-10',1);
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `show_children`
--

DROP TABLE IF EXISTS `show_children`;
/*!50001 DROP VIEW IF EXISTS `show_children`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `show_children` AS SELECT 
 1 AS `imbd`,
 1 AS `Ime`,
 1 AS `Prezime`,
 1 AS `dateOfBirth`,
 1 AS `street`,
 1 AS `city`,
 1 AS `number`,
 1 AS `height`,
 1 AS `weight`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `show_educators`
--

DROP TABLE IF EXISTS `show_educators`;
/*!50001 DROP VIEW IF EXISTS `show_educators`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `show_educators` AS SELECT 
 1 AS `imbd`,
 1 AS `firstName`,
 1 AS `lastName`,
 1 AS `dateOfBirth`,
 1 AS `street`,
 1 AS `city`,
 1 AS `number`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'ekindergarten'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_in_group` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_in_group`(
	in 	imbd varchar(13),
		groupName varchar(30),
        personType bool,
	out stat bool
)
BEGIN
	declare _idPerson, _idGroup INT;
    
    set stat = false;
    
	SELECT id into _idPerson
    FROM person p
    WHERE p.imbd = imbd;
    
    SELECT id into _idGroup
    from ekindergarten.group g
    where g.name = groupName;
    
    if personType = 1 then
		insert into educator_has_group values (_idPerson, _idGroup, DATE(NOW()), 12);
	else
		insert into child_has_group values (_idPerson, _idGroup, DATE(NOW()), 12);
	end if;
    
    set stat = true;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_child` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_child`(
	in 	firstName varchar(30),
		lastName varchar(30),
		imbd varchar(13),
		streetNumber INT,
		streetName varchar(30),
		city varchar(20),
		height INT,
		weight INT,
		dateOfBirth DATE,
	out isCreated bool
)
BEGIN
	declare _idAddress, _idPerson INT;
    set isCreated = false;
    
    insert into address(street, city, number) values (streetName, city, streetNumber);
    SELECT LAST_INSERT_ID() into _idAddress;
    
    insert into person(imbd, firstName, lastName, dateOfBirth, ADDRESS_id) values (imbd, firstName, lastName, dateOfBirth, _idAddress);
    SELECT LAST_INSERT_ID() into _idPerson;
    
    insert into child values (_idPerson, height, weight);
    set isCreated = true;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_membership_fee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_membership_fee`(
	in imbd varchar(13),
		typeOfService varchar(30),
        amount INT,
        forMonth DATE
)
begin
	declare _idPerson INT;
    
	select id into _idPerson
	from person p
	where p.imbd = imbd;
    
    insert into membership_fee(type, amoun, isPaid, date, CHILD_PERSON_id, dateOfPaymant) values (typeOfService, amount, 0, forMonth, _idPerson, null);
    
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_from_group` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_from_group`(
	in 	imbd varchar(13),
		groupName varchar(30),
	out isDeleted bool
)
BEGIN
	declare _idPerson, _idGroup, pom INT;
    
    set isDeleted = false;
    
    select id into _idPerson
    from person p
    where p.imbd = imbd;
    
    select id into _idGroup
    from ekindergarten.group g
    where g.name = groupName;
    
    select count(*) into pom
    from educator e
    where e.PERSON_id = _idPerson;
    
    if pom = 1 then
		delete from educator_has_group where EDUCATOR_PERSON_id = _idPerson AND GROUP_id = _idGroup;
	else
		delete from child_has_group where CHILD_PERSON_id = _idPerson AND GROUP_id = _idGroup;
	end if;
    set isDeleted = true;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_children_from_group` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_children_from_group`(
	in groupName varchar(30)
)
BEGIN
	SELECT imbd, firstName, lastName, dateOfBirth, street, city, number, height, weight
    FROM person p, child c, ekindergarten.group g, child_has_group cg, address adr
    WHERE p.id = c.PERSON_id
		AND g.id = cg.CHILD_PERSON_id
        AND adr.id = p.ADDRESS_id
        AND c.PERSON_id = cg.CHILD_PERSON_id
        AND g.name = groupName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_educators_from_group` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_educators_from_group`(
	in groupName varchar(30)
)
BEGIN
	SELECT imbd, firstName, lastName, dateOfBirth, street, city, number
    FROM person p, educator e, ekindergarten.group g, educator_has_group eg, address adr
    WHERE p.id = e.PERSON_id
		AND g.id = eg.GROUP_id
        AND adr.id = p.ADDRESS_id
        AND e.PERSON_id = eg.EDUCATOR_PERSON_id
        AND g.name = groupName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `log_arrival` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `log_arrival`(
	in imbd varchar(13),
    out isPaid bool,
	out isLogged bool
)
BEGIN
	declare _idPerson, _idMembership, pom INT;
    
    SET isPaid = false, isLogged = false; 
    
    select id into _idPerson
    from person p
    where p.imbd = imbd;
    
    insert into arrival_departure_time(CHILD_PERSON_id, dateTime) values (_idPerson, NOW());
	set isLogged = true;
    
    select count(*) into pom
    from membership_fee m
	where m.CHILD_PERSON_id = _idPerson AND isPaid = 0;
    
    if pom = 0 then
		set isPaid = true;
	end if;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `log_departure` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `log_departure`(
	in imbd varchar(13),
	out isLogged bool
)
BEGIN

	declare _idPerson INT;
	set isLogged = false;
    
    select id into _idPerson
    from person p
    where p.imbd = imbd;
    
    insert into arrival_departure_time(CHILD_PERSON_id, dateTime) values (_idPerson, NOW());
    set isLogged = true;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pay_membership_fee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pay_membership_fee`(
	in id INT
)
begin
	
    update membership_fee m
    set m.isPaid = 1, m.dateOfPayment = NOW()
    where m.id = id;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_all_evidence` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_all_evidence`(
	in imbd varchar(13)
)
begin
	declare _idPerson INT;
    
    select id into _idPerson
    from person p
    where p.imbd = imbd;
    
    select EvidentiranoVrijeme
    from arrival_departure_time adt
    where adt.CHILD_PERSON_id = _idPerson;
    
    SET time_zone ='+01:00';
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_membership_fees` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_membership_fees`(
	in imbd varchar(13)
)
BEGIN
	declare _idPerson INT;
    
    select id into _idPerson
    from person p
    where p.imbd = imbd;
    
    select id, m.type, amoun, isPaid, m.date
    from membership_fee m
    where CHILD_PERSON_id = _idPerson;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `find_educator_name`
--

/*!50001 DROP VIEW IF EXISTS `find_educator_name`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `find_educator_name` AS select `p`.`firstName` AS `firstName`,`p`.`lastName` AS `lastName`,`e`.`username` AS `username`,`e`.`password` AS `password` from (`educator` `e` join `person` `p` on((`p`.`id` = `e`.`PERSON_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `show_children`
--

/*!50001 DROP VIEW IF EXISTS `show_children`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `show_children` AS select `p`.`imbd` AS `imbd`,`p`.`firstName` AS `Ime`,`p`.`lastName` AS `Prezime`,`p`.`dateOfBirth` AS `dateOfBirth`,`a`.`street` AS `street`,`a`.`city` AS `city`,`a`.`number` AS `number`,`c`.`height` AS `height`,`c`.`weight` AS `weight` from ((`child` `c` join `person` `p` on((`p`.`id` = `c`.`PERSON_id`))) join `address` `a` on((`a`.`id` = `p`.`ADDRESS_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `show_educators`
--

/*!50001 DROP VIEW IF EXISTS `show_educators`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `show_educators` AS select `p`.`imbd` AS `imbd`,`p`.`firstName` AS `firstName`,`p`.`lastName` AS `lastName`,`p`.`dateOfBirth` AS `dateOfBirth`,`a`.`street` AS `street`,`a`.`city` AS `city`,`a`.`number` AS `number` from ((`educator` `e` join `person` `p` on((`p`.`id` = `e`.`PERSON_id`))) join `address` `a` on((`a`.`id` = `p`.`ADDRESS_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-31 17:59:37
