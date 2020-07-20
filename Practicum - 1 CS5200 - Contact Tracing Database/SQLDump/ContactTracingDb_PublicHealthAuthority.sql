-- MySQL dump 10.13  Distrib 8.0.21, for macos10.15 (x86_64)
--
-- Host: 127.0.0.1    Database: ContactTracingDb
-- ------------------------------------------------------
-- Server version	8.0.21

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
-- Table structure for table `PublicHealthAuthority`
--

DROP TABLE IF EXISTS `PublicHealthAuthority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PublicHealthAuthority` (
  `AuthorityID` int NOT NULL AUTO_INCREMENT,
  `AuthAddressID` int NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Jurisdiction` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`AuthorityID`),
  KEY `AuthAddressID` (`AuthAddressID`),
  CONSTRAINT `publichealthauthority_ibfk_1` FOREIGN KEY (`AuthAddressID`) REFERENCES `Place` (`placeid`)
) ENGINE=InnoDB AUTO_INCREMENT=13111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PublicHealthAuthority`
--

LOCK TABLES `PublicHealthAuthority` WRITE;
/*!40000 ALTER TABLE `PublicHealthAuthority` DISABLE KEYS */;
INSERT INTO `PublicHealthAuthority` VALUES (13100,1,'Mollis Lectus Pede Institute','EAST BOSTON'),(13101,2,'Eleifend Ltd','BOSTON'),(13102,3,'Cursus Integer Company','SOUTH BOSTON'),(13103,4,'Quis Diam Pellentesque Consulting','BOSTON'),(13104,5,'Non Foundation','SOUTH BOSTON'),(13105,6,'Et Magna Praesent PC','EAST BOSTON'),(13106,7,'Tristique Incorporated','EAST BOSTON'),(13107,8,'Nunc Sed Corp.','EAST BOSTON'),(13108,9,'Ipsum Phasellus Associates','BOSTON'),(13109,10,'Ut Nec PC','DARMOUTH'),(13110,11,'Eleifend Associates','BOSTON');
/*!40000 ALTER TABLE `PublicHealthAuthority` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-19 11:02:34
