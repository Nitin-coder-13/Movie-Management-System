CREATE DATABASE  IF NOT EXISTS `movie_system` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `movie_system`;
-- MySQL dump 10.13  Distrib 8.0.43, for macos15 (arm64)
--
-- Host: localhost    Database: movie_system
-- ------------------------------------------------------
-- Server version	8.4.6

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
-- Table structure for table `Actors`
--

DROP TABLE IF EXISTS `Actors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Actors` (
  `ActorID` int NOT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `Gender` char(1) DEFAULT NULL,
  `DoB` date DEFAULT NULL,
  PRIMARY KEY (`ActorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Actors`
--

LOCK TABLES `Actors` WRITE;
/*!40000 ALTER TABLE `Actors` DISABLE KEYS */;
INSERT INTO `Actors` VALUES (101,'Leonardo','DiCaprio','M','1974-11-11'),(102,'Cillian','Murphy','M','1976-05-25'),(103,'Margot','Robbie','F','1990-07-02'),(104,'Ryan','Gosling','M','1980-11-12'),(105,'Kate','Winslet','F','1975-10-05'),(106,'Tom','Hanks','M','1956-07-09');
/*!40000 ALTER TABLE `Actors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Directors`
--

DROP TABLE IF EXISTS `Directors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Directors` (
  `DirectorID` int NOT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `Nationality` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`DirectorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Directors`
--

LOCK TABLES `Directors` WRITE;
/*!40000 ALTER TABLE `Directors` DISABLE KEYS */;
INSERT INTO `Directors` VALUES (1,'Christopher','Nolan','British'),(2,'Steven','Spielberg','American'),(3,'Greta','Gerwig','American'),(4,'James','Cameron','Canadian');
/*!40000 ALTER TABLE `Directors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Movie_Cast`
--

DROP TABLE IF EXISTS `Movie_Cast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Movie_Cast` (
  `MovieID` int NOT NULL,
  `ActorID` int NOT NULL,
  `RoleName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`MovieID`,`ActorID`),
  KEY `ActorID` (`ActorID`),
  CONSTRAINT `movie_cast_ibfk_1` FOREIGN KEY (`MovieID`) REFERENCES `Movies` (`MovieID`),
  CONSTRAINT `movie_cast_ibfk_2` FOREIGN KEY (`ActorID`) REFERENCES `Actors` (`ActorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Movie_Cast`
--

LOCK TABLES `Movie_Cast` WRITE;
/*!40000 ALTER TABLE `Movie_Cast` DISABLE KEYS */;
INSERT INTO `Movie_Cast` VALUES (501,101,'Cobb'),(501,102,'Robert Fischer'),(502,102,'J. Robert Oppenheimer'),(503,103,'Barbie'),(503,104,'Ken'),(504,101,'Jack Dawson'),(504,105,'Rose DeWitt Bukater'),(505,106,'Captain Miller');
/*!40000 ALTER TABLE `Movie_Cast` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Movies`
--

DROP TABLE IF EXISTS `Movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Movies` (
  `MovieID` int NOT NULL,
  `Title` varchar(100) NOT NULL,
  `ReleaseYear` int DEFAULT NULL,
  `Genre` varchar(50) DEFAULT NULL,
  `DirectorID` int DEFAULT NULL,
  PRIMARY KEY (`MovieID`),
  KEY `DirectorID` (`DirectorID`),
  CONSTRAINT `movies_ibfk_1` FOREIGN KEY (`DirectorID`) REFERENCES `Directors` (`DirectorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Movies`
--

LOCK TABLES `Movies` WRITE;
/*!40000 ALTER TABLE `Movies` DISABLE KEYS */;
INSERT INTO `Movies` VALUES (501,'Inception',2010,'Sci-Fi',1),(502,'Oppenheimer',2023,'Biopic',1),(503,'Barbie',2023,'Comedy',3),(504,'Titanic',1997,'Romance',4),(505,'Saving Private Ryan',1998,'War',2);
/*!40000 ALTER TABLE `Movies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reviews`
--

DROP TABLE IF EXISTS `Reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reviews` (
  `ReviewID` int NOT NULL,
  `MovieID` int DEFAULT NULL,
  `ReviewerName` varchar(50) DEFAULT NULL,
  `Rating` decimal(3,1) DEFAULT NULL,
  `Comment` text,
  PRIMARY KEY (`ReviewID`),
  KEY `MovieID` (`MovieID`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`MovieID`) REFERENCES `Movies` (`MovieID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reviews`
--

LOCK TABLES `Reviews` WRITE;
/*!40000 ALTER TABLE `Reviews` DISABLE KEYS */;
INSERT INTO `Reviews` VALUES (1,501,'MovieBuff99',9.5,'Absolute masterpiece, confusing but great.'),(2,501,'JohnDoe',8.0,'Good visuals, story was okay.'),(3,503,'PinkLover',9.0,'Loved the set design!'),(4,502,'HistoryNerd',10.0,'Hauntingly beautiful.'),(5,504,'CryingFan',8.5,'I cry every time properly.');
/*!40000 ALTER TABLE `Reviews` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-05 19:22:41
