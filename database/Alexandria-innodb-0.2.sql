-- MySQL dump 10.13  Distrib 5.1.58, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: Library
-- ------------------------------------------------------
-- Server version	5.1.58-1ubuntu1

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
-- Table structure for table `tblBook`
--

DROP TABLE IF EXISTS `tblBook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblBook` (
  `BookID` int(11) NOT NULL AUTO_INCREMENT,
  `BookAuthorID` int(11) NOT NULL,
  `BookTitle` varchar(1024) DEFAULT NULL,
  `BookISBN` varchar(15) DEFAULT NULL,
  `BookFormat` tinyint(4) DEFAULT '1',
  `BookPubDate` year(4) DEFAULT NULL,
  `BookPurchaseDate` datetime DEFAULT NULL,
  PRIMARY KEY (`BookID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblBook`
--

LOCK TABLES `tblBook` WRITE;
/*!40000 ALTER TABLE `tblBook` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblBook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblBookAuthor`
--

DROP TABLE IF EXISTS `tblBookAuthor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblBookAuthor` (
  `BookAuthorID` int(11) NOT NULL AUTO_INCREMENT,
  `BookAuthorName` varchar(767) DEFAULT NULL,
  PRIMARY KEY (`BookAuthorID`),
  UNIQUE KEY `idx_author_name` (`BookAuthorName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblBookAuthor`
--

LOCK TABLES `tblBookAuthor` WRITE;
/*!40000 ALTER TABLE `tblBookAuthor` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblBookAuthor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblBookFormat`
--

DROP TABLE IF EXISTS `tblBookFormat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblBookFormat` (
  `BookFormatID` tinyint(4) NOT NULL AUTO_INCREMENT,
  `BookFormatType` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`BookFormatID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblBookFormat`
--

LOCK TABLES `tblBookFormat` WRITE;
/*!40000 ALTER TABLE `tblBookFormat` DISABLE KEYS */;
INSERT INTO `tblBookFormat` VALUES (1,'Paperback'),(2,'Hardback'),(3,'eBook'),(4,'Graphic Novel'),(5,'Magazine'),(6,'Leatherbound'),(7,'Unknown');
/*!40000 ALTER TABLE `tblBookFormat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblGame`
--

DROP TABLE IF EXISTS `tblGame`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblGame` (
  `GameID` int(11) NOT NULL AUTO_INCREMENT,
  `GameTitle` varchar(1024) DEFAULT NULL,
  `GameReleaseDate` date DEFAULT NULL,
  `GamePurchaseDate` date DEFAULT NULL,
  `GamePlatform` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`GameID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblGame`
--

LOCK TABLES `tblGame` WRITE;
/*!40000 ALTER TABLE `tblGame` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblGame` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblGamePlatform`
--

DROP TABLE IF EXISTS `tblGamePlatform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblGamePlatform` (
  `GamePlatformID` tinyint(4) NOT NULL AUTO_INCREMENT,
  `GamePlatformType` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`GamePlatformID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblGamePlatform`
--

LOCK TABLES `tblGamePlatform` WRITE;
/*!40000 ALTER TABLE `tblGamePlatform` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblGamePlatform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblHeader`
--

DROP TABLE IF EXISTS `tblHeader`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblHeader` (
  `HeaderID` int(11) NOT NULL AUTO_INCREMENT,
  `HeaderMediaType` tinyint(4) NOT NULL DEFAULT '1',
  `HeaderDateAdded` datetime DEFAULT NULL,
  PRIMARY KEY (`HeaderID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblHeader`
--

LOCK TABLES `tblHeader` WRITE;
/*!40000 ALTER TABLE `tblHeader` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblHeader` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblMediaType`
--

DROP TABLE IF EXISTS `tblMediaType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblMediaType` (
  `MediaTypeID` tinyint(4) NOT NULL AUTO_INCREMENT,
  `MediaType` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`MediaTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblMediaType`
--

LOCK TABLES `tblMediaType` WRITE;
/*!40000 ALTER TABLE `tblMediaType` DISABLE KEYS */;
INSERT INTO `tblMediaType` VALUES (1,'Book'),(2,'Video'),(3,'Music'),(4,'Game');
/*!40000 ALTER TABLE `tblMediaType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblMusic`
--

DROP TABLE IF EXISTS `tblMusic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblMusic` (
  `MusicID` int(11) NOT NULL AUTO_INCREMENT,
  `MusicArtistID` int(11) NOT NULL,
  `MusicAlbumTitle` varchar(1024) DEFAULT NULL,
  `MusicReleaseDate` date DEFAULT NULL,
  `MusicFormat` tinyint(4) DEFAULT NULL,
  `MusicPurchaseDate` date DEFAULT NULL,
  PRIMARY KEY (`MusicID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblMusic`
--

LOCK TABLES `tblMusic` WRITE;
/*!40000 ALTER TABLE `tblMusic` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblMusic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblMusicFormat`
--

DROP TABLE IF EXISTS `tblMusicFormat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblMusicFormat` (
  `MusicFormatID` tinyint(4) NOT NULL AUTO_INCREMENT,
  `MusicFormatType` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`MusicFormatID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblMusicFormat`
--

LOCK TABLES `tblMusicFormat` WRITE;
/*!40000 ALTER TABLE `tblMusicFormat` DISABLE KEYS */;
INSERT INTO `tblMusicFormat` VALUES (1,'CD Album'),(2,'CD Single'),(3,'Electronic'),(4,'Vinyl');
/*!40000 ALTER TABLE `tblMusicFormat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblVideo`
--

DROP TABLE IF EXISTS `tblVideo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblVideo` (
  `VideoID` int(11) NOT NULL AUTO_INCREMENT,
  `VideoTitle` varchar(1024) DEFAULT NULL,
  `VideoReleaseDate` date DEFAULT NULL,
  `VideoPurchaseDate` date DEFAULT NULL,
  `VideoFormat` tinyint(4) DEFAULT NULL,
  `VideoType` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`VideoID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblVideo`
--

LOCK TABLES `tblVideo` WRITE;
/*!40000 ALTER TABLE `tblVideo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblVideo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblVideoFormat`
--

DROP TABLE IF EXISTS `tblVideoFormat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblVideoFormat` (
  `VideoFormatID` tinyint(4) NOT NULL AUTO_INCREMENT,
  `VideoFormatType` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`VideoFormatID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblVideoFormat`
--

LOCK TABLES `tblVideoFormat` WRITE;
/*!40000 ALTER TABLE `tblVideoFormat` DISABLE KEYS */;
INSERT INTO `tblVideoFormat` VALUES (1,'DVD'),(2,'Blu-ray'),(3,'VHS'),(4,'Electronic');
/*!40000 ALTER TABLE `tblVideoFormat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblVideoType`
--

DROP TABLE IF EXISTS `tblVideoType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblVideoType` (
  `VideoTypeID` tinyint(4) NOT NULL AUTO_INCREMENT,
  `VideoType` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`VideoTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblVideoType`
--

LOCK TABLES `tblVideoType` WRITE;
/*!40000 ALTER TABLE `tblVideoType` DISABLE KEYS */;
INSERT INTO `tblVideoType` VALUES (1,'Film'),(2,'TV');
/*!40000 ALTER TABLE `tblVideoType` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-10-20 14:21:36
