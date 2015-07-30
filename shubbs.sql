-- MySQL dump 10.13  Distrib 5.6.25, for Win64 (x86_64)
--
-- Host: localhost    Database: shubbs
-- ------------------------------------------------------
-- Server version	5.6.25-log

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
-- Table structure for table `bigboard`
--

DROP TABLE IF EXISTS `bigboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bigboard` (
  `BiBoid` int(11) NOT NULL DEFAULT '0',
  `BiBo_title` varchar(50) DEFAULT NULL,
  `brief` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`BiBoid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bigboard`
--

LOCK TABLES `bigboard` WRITE;
/*!40000 ALTER TABLE `bigboard` DISABLE KEYS */;
INSERT INTO `bigboard` VALUES (0,'官方资讯','此版块由校园官方管理，发布校园新闻、官方动态等资讯。'),(1,'讨论区','讨论版旨在同学们自由交流，由学生自主管理。已注册学生可以在各个子版块中发帖、回帖，对校园新闻或兴趣爱好等进行讨论。'),(2,'跳蚤市场','跳蚤市场提供学生自己的交易平台和实习招聘资讯。');
/*!40000 ALTER TABLE `bigboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `postid` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(50) DEFAULT NULL,
  `SmBoidid` int(11) DEFAULT NULL,
  `admin` varchar(16) DEFAULT NULL,
  `createtime` datetime DEFAULT CURRENT_TIMESTAMP,
  `content` text,
  `goodcount` int(11) DEFAULT '0',
  `reply` int(11) DEFAULT NULL,
  `essence` int(11) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`postid`),
  KEY `SmBoidid` (`SmBoidid`),
  KEY `admin` (`admin`),
  CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`SmBoidid`) REFERENCES `smallboard` (`SmBoidid`),
  CONSTRAINT `posts_ibfk_2` FOREIGN KEY (`admin`) REFERENCES `userinfo` (`admin`)
) ENGINE=InnoDB AUTO_INCREMENT=220 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reply`
--

DROP TABLE IF EXISTS `reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reply` (
  `reply_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `admin` varchar(16) DEFAULT NULL,
  `postid` int(11) DEFAULT NULL,
  `reply_content` text,
  `reply_createtime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`reply_id`),
  KEY `admin` (`admin`),
  KEY `reply_ibfk_2` (`postid`),
  CONSTRAINT `reply_ibfk_1` FOREIGN KEY (`admin`) REFERENCES `userinfo` (`admin`),
  CONSTRAINT `reply_ibfk_2` FOREIGN KEY (`postid`) REFERENCES `posts` (`postid`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reply`
--

LOCK TABLES `reply` WRITE;
/*!40000 ALTER TABLE `reply` DISABLE KEYS */;
/*!40000 ALTER TABLE `reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `smallboard`
--

DROP TABLE IF EXISTS `smallboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smallboard` (
  `SmBoidid` int(11) NOT NULL DEFAULT '0',
  `SmBo_title` varchar(32) DEFAULT NULL,
  `BiBoid` int(11) DEFAULT NULL,
  PRIMARY KEY (`SmBoidid`),
  KEY `BiBoid` (`BiBoid`),
  CONSTRAINT `smallboard_ibfk_1` FOREIGN KEY (`BiBoid`) REFERENCES `bigboard` (`BiBoid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smallboard`
--

LOCK TABLES `smallboard` WRITE;
/*!40000 ALTER TABLE `smallboard` DISABLE KEYS */;
INSERT INTO `smallboard` VALUES (0,'校园资讯',0),(1,'社区学院',0),(2,'新生区',0),(3,'学生会招聘',0),(4,'校园专题',0),(5,'校园周边',1),(6,'吃喝玩乐',1),(7,'时政讨论',1),(8,'文学艺术',1),(9,'游戏数码',1),(10,'影视专区',1),(11,'体坛风采',1),(12,'二手专区',2),(13,'兼职招聘',2);
/*!40000 ALTER TABLE `smallboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userinfo`
--

DROP TABLE IF EXISTS `userinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userinfo` (
  `admin` varchar(16) NOT NULL,
  `Pwd` varchar(32) NOT NULL,
  `email` varchar(99) NOT NULL,
  `sex` char(4) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `headpicurl` varchar(99) DEFAULT NULL,
  `userlevel` int(11) NOT NULL,
  `registerdate` datetime NOT NULL,
  `roleid` int(11) DEFAULT NULL,
  PRIMARY KEY (`admin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userinfo`
--

LOCK TABLES `userinfo` WRITE;
/*!40000 ALTER TABLE `userinfo` DISABLE KEYS */;
INSERT INTO `userinfo` VALUES ('abc123','123','abc@163.com',NULL,NULL,NULL,NULL,1,'2015-07-28 16:27:21',1),('abcghy','1234','abcghy@21cn.com','男','1994-10-24','18818217393',NULL,1,'2015-07-11 16:29:34',1),('little','123','little@163.com',NULL,NULL,NULL,NULL,1,'2015-07-29 17:29:51',0),('nanduidui','123','nanduidui@163.com',NULL,NULL,NULL,NULL,1,'2015-07-29 10:15:14',1);
/*!40000 ALTER TABLE `userinfo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-07-30 10:27:02
