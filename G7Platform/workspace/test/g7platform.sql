-- MySQL dump 10.13  Distrib 5.6.24, for osx10.10 (x86_64)
--
-- Host: localhost    Database: g7platform
-- ------------------------------------------------------
-- Server version	5.6.24

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
-- Table structure for table `Account_g7group`
--

DROP TABLE IF EXISTS `Account_g7group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Account_g7group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `creator_id` int(11) NOT NULL,
  `name` varchar(80) NOT NULL,
  `date_of_birth` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Account_g7group`
--

LOCK TABLES `Account_g7group` WRITE;
/*!40000 ALTER TABLE `Account_g7group` DISABLE KEYS */;
INSERT INTO `Account_g7group` VALUES (1,9,'最美产品组','2015-09-01'),(2,19,'助手产品组','2015-09-01'),(3,23,'搞趣产品组','2015-09-01'),(4,27,'微信产品组','2015-09-01'),(5,4,'iOS研发部','2015-09-01'),(6,5,'.net研发部','2015-09-01'),(7,2,'策划组','2015-09-01'),(8,3,'测试组','2015-09-01'),(9,7,'设计部','2015-09-01'),(10,9,'Android研发部','2015-09-01'),(11,18,'jenkins测试组','2015-09-01');
/*!40000 ALTER TABLE `Account_g7group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Account_g7group_permissions`
--

DROP TABLE IF EXISTS `Account_g7group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Account_g7group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `g7group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `g7group_id` (`g7group_id`,`permission_id`),
  CONSTRAINT `Account_g7grou_g7group_id_65dea6a5a8cbe889_fk_Account_g7group_id` FOREIGN KEY (`g7group_id`) REFERENCES `Account_g7group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Account_g7group_permissions`
--

LOCK TABLES `Account_g7group_permissions` WRITE;
/*!40000 ALTER TABLE `Account_g7group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `Account_g7group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Account_g7user`
--

DROP TABLE IF EXISTS `Account_g7user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Account_g7user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `date_of_birth` date NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `userid` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `sex` varchar(15) NOT NULL,
  `thumb` varchar(100) NOT NULL,
  `age` int(11) NOT NULL,
  `expires_time` datetime DEFAULT NULL,
  `usignature` varchar(100) NOT NULL,
  `nickname` varchar(255) NOT NULL,
  `clientid` varchar(100) NOT NULL,
  `realname` varchar(255) DEFAULT NULL,
  `job` varchar(100) NOT NULL,
  `mobile` varchar(50) DEFAULT NULL,
  `description` longtext,
  `email_vip` tinyint(1) NOT NULL,
  `mail_pwd` varchar(200) DEFAULT NULL,
  `pgyer_ukey` varchar(200) DEFAULT NULL,
  `pgyer_apiKey` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Account_g7user`
--

LOCK TABLES `Account_g7user` WRITE;
/*!40000 ALTER TABLE `Account_g7user` DISABLE KEYS */;
INSERT INTO `Account_g7user` VALUES (1,'pbkdf2_sha256$20000$OnitKDlIllo8$kO6eUJsoF+iJZDTbQM12vkd6DNLL94iPvoEv/hTpugk=','2015-09-01 03:47:09','2015-09-01',1,1,'7829b10a2ccc4cbd888d52fdf90bfde8','yumous@vip.163.com','root','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 03:47:03','b5e517f4dadc4d25b2acfe1c05a57491','623a5bc60a974ad4bba1a19fd291f035','3f1b9414c4fb4a6f8e0857d571059a9e','','无业游民','','',1,'JIM@19871017','10bfec8a0ad76ec4513d0a1a911c0070','7aa43e0355b94a671f5ae11cecea6972'),(2,'pbkdf2_sha256$20000$wx79TKltPxe0$M5PuhobKa8/4Dt8qPhly8MoPysN5uY0g4pg8wUM3C7U=',NULL,'2015-09-01',1,0,'2405badde863488d8d23eadc5fca0eaa','pluwen@gmail.com','cw','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 06:47:53','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','陈文','产品经理','','',1,'','',''),(3,'pbkdf2_sha256$20000$xogcVAIvksM0$f5clIXcgBovDlir1voPCyx8ldrKyvS9qUQjUNNcO9bE=',NULL,'2015-09-01',1,1,'2405badde863488d8d23eadc5fca0eaa','lengyao@foxmail.com','cly','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 06:48:23','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','陈冷耀','测试工程师','','',1,'','',''),(4,'pbkdf2_sha256$20000$dedMl4840saA$ccfGQTjR1N+Wa722fEUBrl+Ce6dFxmnp6Q4JAttjLAk=',NULL,'2015-09-01',1,1,'2405badde863488d8d23eadc5fca0eaa','2851728838@qq.com','wmf','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 06:49:22','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','王明福','iOS工程师','','',1,'','',''),(5,'pbkdf2_sha256$20000$KQYMhrIaRDYK$X3yHTBhdGgjsg5fT2f2O+oPaqDCAY1h2WVrqOBGSFF0=',NULL,'2015-09-01',1,1,'2405badde863488d8d23eadc5fca0eaa','2851728845@qq.com','lmm','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 06:49:44','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','林悯明','.net工程师','','',1,'','',''),(6,'pbkdf2_sha256$20000$KEP4PNGn10az$NqnkdVsYjVscoEbUreYALLOp1GOS6WguCMIQISLl+EQ=',NULL,'2015-09-01',1,1,'2405badde863488d8d23eadc5fca0eaa','245838185@qq.com','zry','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 06:51:14','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','左榕艳','测试工程师','','',1,'','',''),(7,'pbkdf2_sha256$20000$RZGgu3AI7IE0$IdQueU0Ys6aJzgsiWjNcFWirK++++ysS+xIcdGhlPbc=',NULL,'2015-09-01',1,1,'2405badde863488d8d23eadc5fca0eaa','2851728857@qq.com','gll','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 06:51:36','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','郭岚岚','设计师','','',1,'','',''),(8,'pbkdf2_sha256$20000$P4MeStuvjV8I$QVgGL+y//y5qQPtD5kT4uFX38fyew18vUCzxnF9QFaY=',NULL,'2015-09-01',1,1,'2405badde863488d8d23eadc5fca0eaa','2851728796@qq.com','zrg','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 06:52:02','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','朱如钢','总监','','',1,'','',''),(9,'pbkdf2_sha256$20000$JLRm2zxSFkWz$/vb910ZFfX4YrCn2wijMmG5Epjaw8Ox1qPJQBg3OH3E=',NULL,'2015-09-01',1,0,'2405badde863488d8d23eadc5fca0eaa','663971596@qq.com','lyf','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 06:52:43','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','林云枫','产品经理','','',0,'','',''),(10,'pbkdf2_sha256$20000$iPUrrrZHsJJi$vJGMidJWgoJ2Zlr134G5QE9FqYX1P+RKEc1aig3cTTY=',NULL,'2015-09-01',1,0,'2405badde863488d8d23eadc5fca0eaa','2851728848@qq.com','hwb','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 06:53:03','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','黄文彬','.net工程师','','',0,'','',''),(11,'pbkdf2_sha256$20000$ol0gON9nDtY7$EUCyoOCOo+QResJvBIxt0r0hj8vxHOrbxPSDxj107aQ=',NULL,'2015-09-01',1,0,'2405badde863488d8d23eadc5fca0eaa','2851728846@qq.com','pll','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 06:53:20','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','彭亮亮','.net工程师','','',0,'','',''),(12,'pbkdf2_sha256$20000$G7tS50Wz8F1X$ojhYDuzYrOX4Y7mC/verLGS0/ydbsWLzlwgRNl+vCm8=',NULL,'2015-09-01',1,0,'2405badde863488d8d23eadc5fca0eaa','2851728839@qq.com','tyb','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 06:53:37','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','涂勇彬','iOS工程师','','',0,'','',''),(13,'pbkdf2_sha256$20000$oFWGCprgpe6U$/zTBGHsqCPYjnArMp6UFvmgzE3I4LTx8NS++RVIw7GM=',NULL,'2015-09-01',1,0,'2405badde863488d8d23eadc5fca0eaa','2851729173@qq.com','hl','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 06:53:57','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','黄兰','iOS工程师','','',0,'','',''),(14,'pbkdf2_sha256$20000$72QnOfjriuHu$8rSmvaDmRX2akh3x9WKVf+j73rASiPB4Ts26NrS03RI=',NULL,'2015-09-01',1,0,'2405badde863488d8d23eadc5fca0eaa','2851728844@qq.com','ll','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 06:54:21','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','刘雷','iOS工程师','','',0,'','',''),(15,'pbkdf2_sha256$20000$VMntdUL0V3ko$pupuOTUG2NNsY+ikn01+JB83bUviz/W+rjszqXvIefY=',NULL,'2015-09-01',1,0,'2405badde863488d8d23eadc5fca0eaa','2851728860@qq.com','sw','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 06:55:01','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','施威','设计师','','',0,'','',''),(16,'pbkdf2_sha256$20000$VA1QVnMHla87$OuzLm6AcmRZZa4tUWNbqvVW6klWfP7Ubot1bhs7kn+A=',NULL,'2015-09-01',1,0,'2405badde863488d8d23eadc5fca0eaa','2851728842@qq.com','lzx','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 06:55:16','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','卢志贤','iOS工程师','','',0,'','',''),(17,'pbkdf2_sha256$20000$jdmxynnjjAv5$93I1PpoOGRV25Mu7cpDe7R5NJJBzSk814xzPiFuBzAY=',NULL,'2015-09-01',1,0,'2405badde863488d8d23eadc5fca0eaa','2851728843@qq.com','lty','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 06:55:44','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','吕廷元','iOS工程师','','',0,'','',''),(18,'pbkdf2_sha256$20000$3p1g2DiMhwJz$fB7nWOQSnprudjKnF4rVO5rbcvLdbdhzLV6juTAMi10=',NULL,'2015-09-01',1,0,'2405badde863488d8d23eadc5fca0eaa','2851728841@qq.com','yy','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 06:56:09','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','余洋','iOS工程师','','',0,'','',''),(19,'pbkdf2_sha256$20000$drxHeI7h1iuw$NiFOx01iMDQyTi39OkYW1qJEQTuC+WyExBC/F0nF4Ck=',NULL,'2015-09-01',1,0,'2405badde863488d8d23eadc5fca0eaa','2851728787@qq.com','cll','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 06:56:22','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','陈璐铃','产品经理','','',0,'','',''),(20,'pbkdf2_sha256$20000$48qGdYnOiCeF$p7S7PGybNezJCbuDrV/HOVNYJThkK7Qi8u9ABAYb/AI=',NULL,'2015-09-01',1,0,'2405badde863488d8d23eadc5fca0eaa','2851728800@qq.com','zwj','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 06:56:58','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','曾伟君','测试工程师','','',0,'','',''),(21,'pbkdf2_sha256$20000$bThl4Lar5grc$P1SmMkfRyKCduxkgNDo1zpRlsl8H068aeSf+wVF8Ssw=',NULL,'2015-09-01',1,0,'2405badde863488d8d23eadc5fca0eaa','234836887@qq.com','lc','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 06:59:08','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','林超','iOS工程师','','',0,'','',''),(22,'pbkdf2_sha256$20000$P5CqDDzhRY8k$jOriWb+49pSCXkzDuskoAH1Pn4PisrcwtpLcwnDF0aM=',NULL,'2015-09-01',1,0,'2405badde863488d8d23eadc5fca0eaa','shikaimin@qq.com','skm','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 06:59:24','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','施凯敏','iOS工程师','','',0,'','',''),(23,'pbkdf2_sha256$20000$yF6rWC6RDxIU$PjRbrccz2LBCJS/kTfdWlk5gZZBDXYwoL7dApwEKpe8=',NULL,'2015-09-01',1,0,'2405badde863488d8d23eadc5fca0eaa','2851728802@qq.com','ck','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 06:59:42','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','陈侃','产品经理','','',0,'','',''),(24,'pbkdf2_sha256$20000$bFfNhXgg5Aud$TeuTfHkeOsicDvGkCBvS1Kw0Qe18QhxmZLG19W1TtIQ=',NULL,'2015-09-01',1,1,'2405badde863488d8d23eadc5fca0eaa','2851728998@qq.com','dy','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 06:59:56','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','董宇','CEO','','',0,'','',''),(25,'pbkdf2_sha256$20000$KpBpt9BU7pel$aREqBar/YDhq90y994wtHznlvVi5Eov4m1x/78nW4gc=',NULL,'2015-09-01',1,0,'2405badde863488d8d23eadc5fca0eaa','2851728876@qq.com','hzy','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 07:00:54','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','黄智莺','产品经理','','',0,'','',''),(26,'pbkdf2_sha256$20000$ilyY1ftEkhit$UiU0knV31jYXefH0RJc5Ikgmru4dzZSnFM+rU81Y1Sc=',NULL,'2015-09-01',1,0,'2405badde863488d8d23eadc5fca0eaa','2851728804@qq.com','cyh','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 07:01:21','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','陈燕华','产品经理','','',0,'','',''),(27,'pbkdf2_sha256$20000$4eQvmCMYztyA$cgREuDvP02UnV7doTGDLUnCv8W3oyo485mOd1YNgjAg=',NULL,'2015-09-01',1,0,'2405badde863488d8d23eadc5fca0eaa','2851728797@qq.com','zyq','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 07:01:40','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','郑宇全','产品经理','','',0,'','',''),(28,'pbkdf2_sha256$20000$ukjKjIyuK3XT$QTyYpLoNkXmCLY+879zcFDCpOHDH7lzoeaQyt1m8XtI=',NULL,'2015-09-01',1,0,'2405badde863488d8d23eadc5fca0eaa','2851728817@qq.com','zbf','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 07:02:07','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','张冰烽','.net工程师','','',0,'','',''),(29,'pbkdf2_sha256$20000$0xkUPDvSwycJ$5YfLZwIqy/O3mPcO/ZmG12I64ZmIJWcoAEU2X7CQKyA=',NULL,'2015-09-01',1,0,'2405badde863488d8d23eadc5fca0eaa','2851728972@qq.com','chc','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 07:02:33','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','陈聪慧','测试工程师','','',0,'','',''),(30,'pbkdf2_sha256$20000$cW8AzCjFuB1E$C1A1iXV8E1uRxV22Z76mhnHpboVwMZVu9Ml+MhzZzeQ=',NULL,'2015-09-01',1,0,'2405badde863488d8d23eadc5fca0eaa','2851728974@qq.com','lqy','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 07:02:53','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','林倩依','设计师','','',0,'','',''),(31,'pbkdf2_sha256$20000$um7Oa3hnijxh$/QzZ+9HXAS8laJ4zpcRs44YA9CvHU47FPd1SkSvPg/k=',NULL,'2015-09-01',1,0,'2405badde863488d8d23eadc5fca0eaa','2851728809@qq.com','hzd','man','/media/user/thumbnails/default_thumb.png',0,'2015-09-01 07:03:07','241786204d1b434f987c99df97dada26','f2738eae3c014badb05d4a16b0386997','0e48f7a66e10451981774e565e5e6015','黄振达','iOS工程师','','',0,'','','');
/*!40000 ALTER TABLE `Account_g7user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Account_g7user_groups`
--

DROP TABLE IF EXISTS `Account_g7user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Account_g7user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `g7user_id` int(11) NOT NULL,
  `g7group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `g7user_id` (`g7user_id`,`g7group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Account_g7user_groups`
--

LOCK TABLES `Account_g7user_groups` WRITE;
/*!40000 ALTER TABLE `Account_g7user_groups` DISABLE KEYS */;
INSERT INTO `Account_g7user_groups` VALUES (3,2,2),(15,2,3),(55,2,8),(4,3,2),(16,3,3),(58,3,9),(63,3,11),(5,4,2),(17,4,3),(27,4,4),(34,4,5),(41,4,6),(6,5,2),(18,5,3),(51,5,7),(7,6,2),(19,6,3),(59,6,9),(8,7,2),(60,7,10),(9,8,2),(20,8,3),(21,9,3),(56,9,8),(22,10,3),(52,10,7),(10,11,2),(53,11,7),(23,12,3),(42,12,6),(24,13,3),(43,13,6),(25,14,3),(44,14,6),(26,15,3),(61,15,10),(11,16,2),(45,16,6),(64,16,11),(12,17,2),(46,17,6),(13,18,2),(47,18,6),(62,18,11),(14,19,2),(57,19,8),(28,20,4),(29,21,4),(48,21,6),(30,22,4),(49,22,6),(31,23,4),(32,24,4),(33,25,4),(35,26,5),(36,27,5),(37,28,5),(54,28,7),(38,29,5),(39,30,5),(40,31,5),(50,31,6);
/*!40000 ALTER TABLE `Account_g7user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Application_g7application`
--

DROP TABLE IF EXISTS `Application_g7application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Application_g7application` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `product_type` int(11) DEFAULT NULL,
  `channel` int(11) NOT NULL,
  `inner_version` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `appid` varchar(100) NOT NULL,
  `file` varchar(100) DEFAULT NULL,
  `version` varchar(150) NOT NULL,
  `icon` varchar(100) NOT NULL,
  `create_at` datetime NOT NULL,
  `modified_at` datetime NOT NULL,
  `bundleID` varchar(200) DEFAULT NULL,
  `description` longtext,
  `build_version` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `appid` (`appid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Application_g7application`
--

LOCK TABLES `Application_g7application` WRITE;
/*!40000 ALTER TABLE `Application_g7application` DISABLE KEYS */;
INSERT INTO `Application_g7application` VALUES (1,52,1,1,1,'清理大师测试','29a7b8179d6046039793e3549e6ee25c','application/package/清理大师测试_V1.0_Build15090117074321_20150901180125.ipa','1.0','application/icon/20150901180125.png','2015-09-01 10:01:25','2015-09-01 10:01:25','com.gao7.cleanMaster.pid52ch1','','15090117074321');
/*!40000 ALTER TABLE `Application_g7application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Application_g7application_frameworks`
--

DROP TABLE IF EXISTS `Application_g7application_frameworks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Application_g7application_frameworks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_g7application_id` int(11) NOT NULL,
  `to_g7application_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `from_g7application_id` (`from_g7application_id`,`to_g7application_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Application_g7application_frameworks`
--

LOCK TABLES `Application_g7application_frameworks` WRITE;
/*!40000 ALTER TABLE `Application_g7application_frameworks` DISABLE KEYS */;
/*!40000 ALTER TABLE `Application_g7application_frameworks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Application_g7project`
--

DROP TABLE IF EXISTS `Application_g7project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Application_g7project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `platform` int(11) NOT NULL,
  `project_type` int(11) NOT NULL,
  `project_status` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `latest_version` varchar(200) DEFAULT NULL,
  `latest_inner_version` int(11) DEFAULT NULL,
  `latest_build_version` varchar(200) DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `descriptin` longtext,
  `icon` varchar(100) NOT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `identifier` varchar(100) NOT NULL,
  `bundleID` varchar(200) NOT NULL,
  `create_at` datetime NOT NULL,
  `modified_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identifier` (`identifier`),
  UNIQUE KEY `bundleID` (`bundleID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Application_g7project`
--

LOCK TABLES `Application_g7project` WRITE;
/*!40000 ALTER TABLE `Application_g7project` DISABLE KEYS */;
INSERT INTO `Application_g7project` VALUES (1,0,0,0,52,'1.0',1,'15090117074321','清理大师测试','','project/icon/20150901180125.png',NULL,'a633925bd9534ff1a32f6f2a33621ae2','com.gao7.cleanMaster.pid52ch1','2015-09-01 10:01:25','2015-09-01 10:01:25');
/*!40000 ALTER TABLE `Application_g7project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Application_g7project_applications`
--

DROP TABLE IF EXISTS `Application_g7project_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Application_g7project_applications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `g7project_id` int(11) NOT NULL,
  `g7application_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `g7project_id` (`g7project_id`,`g7application_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Application_g7project_applications`
--

LOCK TABLES `Application_g7project_applications` WRITE;
/*!40000 ALTER TABLE `Application_g7project_applications` DISABLE KEYS */;
INSERT INTO `Application_g7project_applications` VALUES (1,1,1);
/*!40000 ALTER TABLE `Application_g7project_applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Application_g7project_members`
--

DROP TABLE IF EXISTS `Application_g7project_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Application_g7project_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `g7project_id` int(11) NOT NULL,
  `g7user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `g7project_id` (`g7project_id`,`g7user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Application_g7project_members`
--

LOCK TABLES `Application_g7project_members` WRITE;
/*!40000 ALTER TABLE `Application_g7project_members` DISABLE KEYS */;
/*!40000 ALTER TABLE `Application_g7project_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group__permission_id_7d75d9158a1ca0f3_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_group__permission_id_7d75d9158a1ca0f3_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_adb6874e5f2980b_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  CONSTRAINT `auth__content_type_id_4c731da21d6b56c4_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add 群组',6,'add_g7group'),(17,'Can change 群组',6,'change_g7group'),(18,'Can delete 群组',6,'delete_g7group'),(19,'Can add 用户',7,'add_g7user'),(20,'Can change 用户',7,'change_g7user'),(21,'Can delete 用户',7,'delete_g7user'),(22,'Can add 产品',8,'add_g7project'),(23,'Can change 产品',8,'change_g7project'),(24,'Can delete 产品',8,'delete_g7project'),(25,'Can add 应用',9,'add_g7application'),(26,'Can change 应用',9,'change_g7application'),(27,'Can delete 应用',9,'delete_g7application');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `djang_content_type_id_2b4dba52777301a9_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_7e7ae2ed62e198b8_fk_Account_g7user_id` (`user_id`),
  CONSTRAINT `djang_content_type_id_2b4dba52777301a9_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_7e7ae2ed62e198b8_fk_Account_g7user_id` FOREIGN KEY (`user_id`) REFERENCES `Account_g7user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2015-09-01 03:47:39','1','1.root',2,'已修改 email_vip 。',7,1),(2,'2015-09-01 06:39:16','1','1.root',2,'已修改 email，mail_pwd，pgyer_ukey 和 pgyer_apiKey 。',7,1),(3,'2015-09-01 06:39:26','1','1.yumous',2,'已修改 username 。',7,1),(4,'2015-09-01 06:41:11','1','1.清理大师',1,'',8,1),(5,'2015-09-01 06:41:25','1','1.清理大师',3,'',8,1),(6,'2015-09-01 06:46:38','1','1.iOS研发部',1,'',6,1),(7,'2015-09-01 06:47:53','2','2.cw',1,'',7,1),(8,'2015-09-01 06:48:23','3','3.cly',1,'',7,1),(9,'2015-09-01 06:48:34','3','3.cly',2,'已修改 job 。',7,1),(10,'2015-09-01 06:48:49','2','2.cw',2,'已修改 job 。',7,1),(11,'2015-09-01 06:48:57','3','3.cly',2,'已修改 job 。',7,1),(12,'2015-09-01 06:49:05','1','1.root',2,'已修改 username 。',7,1),(13,'2015-09-01 06:49:22','4','4.wmf',1,'',7,1),(14,'2015-09-01 06:49:30','4','4.wmf',2,'已修改 job 。',7,1),(15,'2015-09-01 06:49:44','5','5.lmm',1,'',7,1),(16,'2015-09-01 06:49:52','5','5.lmm',2,'已修改 job 。',7,1),(17,'2015-09-01 06:50:45','5','5.lmm',2,'已修改 job 。',7,1),(18,'2015-09-01 06:50:52','3','3.cly',2,'已修改 job 。',7,1),(19,'2015-09-01 06:50:58','4','4.wmf',2,'已修改 job 。',7,1),(20,'2015-09-01 06:51:14','6','6.zry',1,'',7,1),(21,'2015-09-01 06:51:22','6','6.zry',2,'已修改 job 。',7,1),(22,'2015-09-01 06:51:36','7','7.gll',1,'',7,1),(23,'2015-09-01 06:51:43','7','7.gll',2,'已修改 job 。',7,1),(24,'2015-09-01 06:52:02','8','8.zrg',1,'',7,1),(25,'2015-09-01 06:52:07','8','8.zrg',2,'已修改 job 。',7,1),(26,'2015-09-01 06:52:43','9','9.lyf',1,'',7,1),(27,'2015-09-01 06:52:55','9','9.lyf',2,'已修改 job 。',7,1),(28,'2015-09-01 06:53:03','10','10.hwb',1,'',7,1),(29,'2015-09-01 06:53:10','10','10.hwb',2,'已修改 job 。',7,1),(30,'2015-09-01 06:53:20','11','11.pll',1,'',7,1),(31,'2015-09-01 06:53:27','11','11.pll',2,'已修改 job 。',7,1),(32,'2015-09-01 06:53:37','12','12.tyb',1,'',7,1),(33,'2015-09-01 06:53:46','12','12.tyb',2,'已修改 job 。',7,1),(34,'2015-09-01 06:53:57','13','13.hl',1,'',7,1),(35,'2015-09-01 06:54:08','13','13.hl',2,'已修改 job 。',7,1),(36,'2015-09-01 06:54:21','14','14.ll',1,'',7,1),(37,'2015-09-01 06:54:50','14','14.ll',2,'已修改 job 。',7,1),(38,'2015-09-01 06:55:01','15','15.sw',1,'',7,1),(39,'2015-09-01 06:55:05','15','15.sw',2,'已修改 job 。',7,1),(40,'2015-09-01 06:55:16','16','16.lzx',1,'',7,1),(41,'2015-09-01 06:55:25','16','16.lzx',2,'已修改 job 。',7,1),(42,'2015-09-01 06:55:44','17','17.lty',1,'',7,1),(43,'2015-09-01 06:55:50','17','17.lty',2,'已修改 job 。',7,1),(44,'2015-09-01 06:56:09','18','18.yy',1,'',7,1),(45,'2015-09-01 06:56:14','18','18.yy',2,'已修改 job 。',7,1),(46,'2015-09-01 06:56:22','19','19.cll',1,'',7,1),(47,'2015-09-01 06:56:28','19','19.cll',2,'已修改 job 。',7,1),(48,'2015-09-01 06:56:58','20','20.zwj',1,'',7,1),(49,'2015-09-01 06:58:49','20','20.zwj',2,'没有字段被修改。',7,1),(50,'2015-09-01 06:59:08','21','21.lc',1,'',7,1),(51,'2015-09-01 06:59:14','21','21.lc',2,'已修改 job 。',7,1),(52,'2015-09-01 06:59:24','22','22.skm',1,'',7,1),(53,'2015-09-01 06:59:27','22','22.skm',2,'已修改 job 。',7,1),(54,'2015-09-01 06:59:42','23','23.ck',1,'',7,1),(55,'2015-09-01 06:59:46','23','23.ck',2,'没有字段被修改。',7,1),(56,'2015-09-01 06:59:56','24','24.dy',1,'',7,1),(57,'2015-09-01 07:00:33','24','24.dy',2,'已修改 job 。',7,1),(58,'2015-09-01 07:00:54','25','25.hzy',1,'',7,1),(59,'2015-09-01 07:01:01','25','25.hzy',2,'没有字段被修改。',7,1),(60,'2015-09-01 07:01:21','26','26.cyh',1,'',7,1),(61,'2015-09-01 07:01:32','26','26.cyh',2,'没有字段被修改。',7,1),(62,'2015-09-01 07:01:40','27','27.zyq',1,'',7,1),(63,'2015-09-01 07:01:53','27','27.zyq',2,'已修改 job 。',7,1),(64,'2015-09-01 07:02:07','28','28.zbf',1,'',7,1),(65,'2015-09-01 07:02:19','28','28.zbf',2,'没有字段被修改。',7,1),(66,'2015-09-01 07:02:33','29','29.chc',1,'',7,1),(67,'2015-09-01 07:02:40','29','29.chc',2,'没有字段被修改。',7,1),(68,'2015-09-01 07:02:53','30','30.lqy',1,'',7,1),(69,'2015-09-01 07:02:55','30','30.lqy',2,'没有字段被修改。',7,1),(70,'2015-09-01 07:03:07','31','31.hzd',1,'',7,1),(71,'2015-09-01 07:03:18','31','31.hzd',2,'没有字段被修改。',7,1),(72,'2015-09-01 07:04:06','1','1.iOS研发部',2,'已修改 creator 。',6,1),(73,'2015-09-01 07:04:19','2','2.陈文',2,'已修改 realname 。',7,1),(74,'2015-09-01 07:04:39','3','3.陈冷耀',2,'已修改 realname 。',7,1),(75,'2015-09-01 07:04:46','4','4.王明福',2,'已修改 realname 。',7,1),(76,'2015-09-01 07:04:57','5','5.林悯明',2,'已修改 realname 。',7,1),(77,'2015-09-01 07:05:16','6','6.左榕艳',2,'已修改 realname 。',7,1),(78,'2015-09-01 07:05:30','7','7.郭岚岚',2,'已修改 realname 。',7,1),(79,'2015-09-01 07:05:41','8','8.朱如钢',2,'已修改 realname 。',7,1),(80,'2015-09-01 07:05:57','9','9.林云枫',2,'已修改 realname 。',7,1),(81,'2015-09-01 07:06:08','10','10.黄文彬',2,'已修改 realname 。',7,1),(82,'2015-09-01 07:06:24','11','11.彭亮亮',2,'已修改 realname 。',7,1),(83,'2015-09-01 07:06:32','12','12.涂勇彬',2,'已修改 realname 。',7,1),(84,'2015-09-01 07:06:40','13','13.黄兰',2,'已修改 realname 。',7,1),(85,'2015-09-01 07:06:50','14','14.刘雷',2,'已修改 realname 。',7,1),(86,'2015-09-01 07:06:57','15','15.施威',2,'已修改 realname 。',7,1),(87,'2015-09-01 07:07:06','16','16.卢志贤',2,'已修改 realname 。',7,1),(88,'2015-09-01 07:07:15','17','17.吕廷元',2,'已修改 realname 。',7,1),(89,'2015-09-01 07:07:44','18','18.余洋',2,'已修改 realname 。',7,1),(90,'2015-09-01 07:07:55','19','19.陈璐铃',2,'已修改 realname 。',7,1),(91,'2015-09-01 07:08:12','20','20.曾伟君',2,'已修改 realname 。',7,1),(92,'2015-09-01 07:08:26','20','20.曾伟君',2,'已修改 job 。',7,1),(93,'2015-09-01 07:08:44','21','21.林超',2,'已修改 realname 。',7,1),(94,'2015-09-01 07:09:14','22','22.施凯敏',2,'已修改 realname 。',7,1),(95,'2015-09-01 07:09:57','23','23.陈侃',2,'已修改 job 和 realname 。',7,1),(96,'2015-09-01 07:10:08','24','24.董宇',2,'已修改 realname 。',7,1),(97,'2015-09-01 07:10:26','25','25.黄智莺',2,'已修改 job 和 realname 。',7,1),(98,'2015-09-01 07:10:58','26','26.陈燕华',2,'已修改 job 和 realname 。',7,1),(99,'2015-09-01 07:11:15','27','27.郑宇全',2,'已修改 realname 。',7,1),(100,'2015-09-01 07:11:33','28','28.张冰烽',2,'已修改 job 和 realname 。',7,1),(101,'2015-09-01 07:11:52','29','29.陈聪慧',2,'已修改 job 和 realname 。',7,1),(102,'2015-09-01 07:12:15','30','30.林倩依',2,'已修改 job 和 realname 。',7,1),(103,'2015-09-01 07:12:31','31','31.黄振达',2,'已修改 job 和 realname 。',7,1),(104,'2015-09-01 07:12:53','24','24.董宇',2,'已修改 is_admin 。',7,1),(105,'2015-09-01 07:13:05','3','3.陈冷耀',2,'已修改 is_admin 和 email_vip 。',7,1),(106,'2015-09-01 07:13:15','2','2.陈文',2,'已修改 email_vip 。',7,1),(107,'2015-09-01 07:13:26','4','4.王明福',2,'已修改 is_admin 和 email_vip 。',7,1),(108,'2015-09-01 07:13:34','2','2.陈文',2,'没有字段被修改。',7,1),(109,'2015-09-01 07:14:32','2','2.陈文',2,'已修改 is_admin 。',7,1),(110,'2015-09-01 07:14:38','2','2.陈文',2,'已修改 is_admin 。',7,1),(111,'2015-09-01 07:15:42','5','5.林悯明',2,'已修改 is_admin 和 email_vip 。',7,1),(112,'2015-09-01 07:17:47','8','8.朱如钢',2,'已修改 is_admin 和 email_vip 。',7,1),(113,'2015-09-01 07:17:55','7','7.郭岚岚',2,'已修改 is_admin 和 email_vip 。',7,1),(114,'2015-09-01 07:18:05','6','6.左榕艳',2,'已修改 is_admin 和 email_vip 。',7,1),(115,'2015-09-01 07:19:35','1','1.iOS研发部',3,'',6,1),(116,'2015-09-01 07:22:14','2','2.助手产品组',1,'',6,1),(117,'2015-09-01 07:23:22','3','3.最美产品组',1,'',6,1),(118,'2015-09-01 07:24:26','4','4.搞趣产品组',1,'',6,1),(119,'2015-09-01 07:25:18','5','5.微信产品组',1,'',6,1),(120,'2015-09-01 07:26:31','6','6.iOS研发部',1,'',6,1),(121,'2015-09-01 07:28:24','7','7..net研发部',1,'',6,1),(122,'2015-09-01 07:29:21','8','8.策划组',1,'',6,1),(123,'2015-09-01 07:32:26','9','9.测试组',1,'',6,1),(124,'2015-09-01 07:33:06','10','10.设计部',1,'',6,1),(125,'2015-09-01 09:04:21','11','11.jenkins测试组',1,'',6,1),(126,'2015-09-01 09:04:52','11','11.jenkins测试组',2,'没有字段被修改。',6,1),(127,'2015-09-01 09:05:05','11','11.jenkins组',2,'已修改 name 。',6,1),(128,'2015-09-01 09:05:10','11','11.jenkins测试组',2,'已修改 name 。',6,1),(129,'2015-09-01 09:07:02','11','11.jenkins测试组',2,'没有字段被修改。',6,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_1785cbc1f8ea80d6_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (6,'Account','g7group'),(7,'Account','g7user'),(1,'admin','logentry'),(9,'Application','g7application'),(8,'Application','g7project'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2015-08-31 10:02:24'),(2,'admin','0001_initial','2015-08-31 10:02:24'),(3,'contenttypes','0002_remove_content_type_name','2015-08-31 10:02:25'),(4,'auth','0001_initial','2015-08-31 10:02:27'),(5,'auth','0002_alter_permission_name_max_length','2015-08-31 10:02:27'),(6,'auth','0003_alter_user_email_max_length','2015-08-31 10:02:27'),(7,'auth','0004_alter_user_username_opts','2015-08-31 10:02:27'),(8,'auth','0005_alter_user_last_login_null','2015-08-31 10:02:27'),(9,'auth','0006_require_contenttypes_0002','2015-08-31 10:02:27'),(10,'sessions','0001_initial','2015-08-31 10:02:27');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('668qzrr32fhdvfo7juvh4usvi59dewnr','YTE2NDRhNzJjZDAzZGU1YWU1MjE0MTM2ZDM3ZTcyMzJiZDNhZDllNTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNDkyNDI2MDlkNjM0YjY4ZjdhOGU4NWJiZGY3MTEzNzBjMjRlZjg1MiIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2015-09-15 03:47:09');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-09-01 18:07:08
