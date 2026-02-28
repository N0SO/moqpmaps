-- MySQL dump 10.13  Distrib 8.4.8, for Linux (x86_64)
--
-- Host: localhost    Database: moqp_2026
-- ------------------------------------------------------
-- Server version	8.4.8-0ubuntu0.25.10.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `plan_counties`
--

DROP TABLE IF EXISTS `plan_counties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plan_counties` (
  `id` int NOT NULL AUTO_INCREMENT,
  `plan_id` int DEFAULT NULL,
  `stateFips` char(2) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `countyFips` char(3) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type` enum('County','City') COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plan_id` (`plan_id`),
  CONSTRAINT `plan_counties_ibfk_1` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan_counties`
--

LOCK TABLES `plan_counties` WRITE;
/*!40000 ALTER TABLE `plan_counties` DISABLE KEYS */;
INSERT INTO `plan_counties` VALUES (26,18,'29','203','Shannon','County'),(27,18,'29','065','Dent','County'),(28,18,'29','055','Crawford','County'),(29,18,'29','179','Reynolds','County'),(55,34,'29','069','Dunklin','County'),(56,34,'29','155','Pemiscot','County'),(57,34,'29','143','New Madrid','County'),(80,41,'29','189','St. Louis','County'),(85,44,'29','510','St. Louis','City'),(107,51,'29','097','Jasper','County'),(108,51,'29','109','Lawrence','County'),(109,51,'29','043','Christian','County'),(110,51,'29','213','Taney','County'),(111,51,'29','183','St. Charles','County'),(112,51,'29','189','St. Louis','County'),(113,51,'29','143','New Madrid','County'),(114,51,'29','155','Pemiscot','County'),(115,51,'29','069','Dunklin','County');
/*!40000 ALTER TABLE `plan_counties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plans`
--

DROP TABLE IF EXISTS `plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plans` (
  `id` int NOT NULL AUTO_INCREMENT,
  `callsign` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `event` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `saved_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plans`
--

LOCK TABLES `plans` WRITE;
/*!40000 ALTER TABLE `plans` DISABLE KEYS */;
INSERT INTO `plans` VALUES (18,'N0CAL','MO_QSO_PARTY','2026-02-26 05:15:05'),(34,'TE0ST','MO_QSO_PARTY','2026-02-26 21:29:34'),(41,'W0MA','MO_QSO_PARTY','2026-02-27 04:47:37'),(44,'AA0A','MO_QSO_PARTY','2026-02-27 16:40:23'),(51,'N0SO','MO_QSO_PARTY','2026-02-28 16:48:31');
/*!40000 ALTER TABLE `plans` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-28 20:20:58
