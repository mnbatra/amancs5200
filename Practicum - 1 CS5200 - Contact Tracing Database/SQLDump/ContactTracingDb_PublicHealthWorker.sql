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
-- Table structure for table `PublicHealthWorker`
--

DROP TABLE IF EXISTS `PublicHealthWorker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PublicHealthWorker` (
  `WorkerID` int NOT NULL,
  `Title` varchar(255) NOT NULL,
  `OfficeID` varchar(255) NOT NULL,
  `PublicAuthID` int NOT NULL,
  PRIMARY KEY (`WorkerID`),
  KEY `PublicAuthID` (`PublicAuthID`),
  CONSTRAINT `publichealthworker_ibfk_1` FOREIGN KEY (`PublicAuthID`) REFERENCES `PublicHealthAuthority` (`AuthorityID`),
  CONSTRAINT `publichealthworker_ibfk_2` FOREIGN KEY (`WorkerID`) REFERENCES `Person` (`PersonID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PublicHealthWorker`
--

LOCK TABLES `PublicHealthWorker` WRITE;
/*!40000 ALTER TABLE `PublicHealthWorker` DISABLE KEYS */;
INSERT INTO `PublicHealthWorker` VALUES (1501,'Eu Foundation','110',13104),(1502,'Elit Limited','932',13103),(1503,'Faucibus Leo Associates','708',13105),(1504,'Lectus Cum LLC','851',13108),(1505,'Proin Non Massa LLC','608',13105),(1506,'Diam Pellentesque Habitant LLC','766',13108),(1507,'Adipiscing Lacus PC','565',13108),(1508,'Commodo At Libero Inc.','419',13107),(1509,'Nec Orci PC','305',13108),(1510,'Vestibulum Ante Ipsum Ltd','33',13104),(1511,'Ultrices Iaculis Associates','864',13105),(1512,'Nunc Company','591',13101),(1513,'Risus At Consulting','730',13105),(1514,'Non Foundation','989',13103),(1515,'Ante Industries','613',13103),(1516,'Purus Gravida Sagittis Consulting','821',13104),(1517,'Aenean Eget Inc.','752',13104),(1518,'Quam Associates','12',13102),(1519,'Nunc Inc.','273',13104),(1520,'Arcu LLP','445',13103),(1521,'Nisl Maecenas Ltd','390',13107),(1522,'Tempus Scelerisque Associates','952',13100),(1523,'Cum Sociis Natoque LLC','530',13105),(1524,'Aliquam Institute','348',13100),(1525,'Phasellus Company','337',13103),(1526,'Justo Industries','586',13106),(1527,'Odio Sagittis Semper Incorporated','820',13100),(1528,'Donec Egestas Duis Corp.','770',13102),(1529,'Augue Sed Molestie Associates','954',13108),(1530,'Varius Nam Company','991',13103),(1531,'Convallis Dolor Company','389',13110),(1532,'Dui Cras Associates','993',13110),(1533,'Nunc Company','897',13108),(1534,'Egestas Lacinia LLC','853',13105),(1535,'Lorem Vitae Consulting','733',13107),(1536,'Ante Bibendum Ullamcorper Industries','687',13102),(1537,'Ipsum Dolor Company','17',13108),(1538,'Ac Eleifend PC','560',13110),(1539,'Ac Associates','354',13108),(1540,'Sociis Associates','504',13103),(1541,'Ac Inc.','357',13102),(1542,'Quisque Tincidunt Pede Industries','529',13110),(1543,'In Cursus Et Associates','464',13110),(1544,'Donec Est Nunc Incorporated','944',13107),(1545,'Gravida Company','673',13106),(1546,'Risus Donec Nibh Incorporated','401',13101),(1547,'Facilisi Sed Company','373',13105),(1548,'Nulla Aliquet Institute','504',13107),(1549,'Hendrerit Company','951',13101),(1550,'Eu Placerat Eget Limited','822',13101),(1551,'Penatibus Et Magnis Ltd','279',13104),(1552,'Diam Sed Incorporated','784',13100),(1553,'Quam Corporation','418',13109),(1554,'Quam Inc.','207',13102),(1555,'Phasellus Dolor LLC','139',13105),(1556,'Luctus Et Ultrices PC','172',13107),(1557,'Ullamcorper Magna Sed Associates','163',13106),(1558,'In LLP','630',13100),(1559,'Rhoncus Institute','69',13104),(1560,'Semper Pretium Associates','886',13103),(1561,'Sed Eget Company','771',13105),(1562,'Vitae Limited','278',13108),(1563,'Augue Sed Molestie Inc.','221',13104),(1564,'Lobortis Risus In Corporation','266',13106),(1565,'Amet Consectetuer Adipiscing Institute','103',13104),(1566,'Penatibus Et Magnis Incorporated','70',13109),(1567,'Iaculis LLC','474',13110),(1568,'Nonummy Ipsum Non LLP','80',13101),(1569,'Orci Lobortis Foundation','779',13108),(1570,'Donec Industries','759',13110),(1571,'Scelerisque Scelerisque Dui Limited','185',13109),(1572,'Erat Nonummy Corporation','868',13109),(1573,'Pellentesque Habitant Morbi Corporation','524',13109),(1574,'Natoque Foundation','940',13104),(1575,'Ornare Egestas Ligula Company','763',13109),(1576,'Euismod Inc.','453',13102),(1577,'Pellentesque A LLP','124',13103),(1578,'Neque Inc.','696',13102),(1579,'Semper Corporation','602',13101),(1580,'Pede Inc.','949',13109),(1581,'Auctor Non Consulting','150',13103),(1582,'Erat Neque Non Incorporated','253',13101),(1583,'Pellentesque Inc.','589',13110),(1584,'Lorem Luctus Inc.','964',13107),(1585,'Amet Company','846',13106),(1586,'A Enim LLP','869',13109),(1587,'Turpis Consulting','536',13102),(1588,'Nec Institute','202',13104),(1589,'Mi Duis Risus Industries','142',13110),(1590,'Metus Aliquam Erat LLP','184',13106),(1591,'Fringilla Inc.','34',13109),(1592,'Nunc In At LLC','769',13107),(1593,'Non Magna Company','109',13110),(1594,'Elementum Purus Accumsan Corporation','139',13106),(1595,'Nunc Sollicitudin Incorporated','532',13107),(1596,'Proin Vel Arcu Limited','26',13109),(1597,'Consequat Dolor Vitae LLC','751',13110),(1598,'At Augue Industries','537',13105),(1599,'Neque Nullam Nisl Institute','165',13103),(1600,'Mauris Blandit LLP','471',13109);
/*!40000 ALTER TABLE `PublicHealthWorker` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-19 11:02:33
