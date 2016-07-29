-- MySQL dump 10.14  Distrib 5.5.47-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: g7platform
-- ------------------------------------------------------
-- Server version	5.5.47-MariaDB

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
  `name` varchar(80) NOT NULL,
  `date_of_birth` date NOT NULL,
  `creator_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `Account_g7group_3700153c` (`creator_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Account_g7group`
--

LOCK TABLES `Account_g7group` WRITE;
/*!40000 ALTER TABLE `Account_g7group` DISABLE KEYS */;
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
  UNIQUE KEY `Account_g7group_permissions_g7group_id_8e6baf2d_uniq` (`g7group_id`,`permission_id`),
  KEY `Account_g7group_per_permission_id_3d040a3d_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `Account_g7group_permis_g7group_id_2d4d16e1_fk_Account_g7group_id` FOREIGN KEY (`g7group_id`) REFERENCES `Account_g7group` (`id`),
  CONSTRAINT `Account_g7group_per_permission_id_3d040a3d_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Account_g7user`
--

LOCK TABLES `Account_g7user` WRITE;
/*!40000 ALTER TABLE `Account_g7user` DISABLE KEYS */;
INSERT INTO `Account_g7user` VALUES (1,'pbkdf2_sha256$24000$4pTGidvogU6t$hCsoyePgxaem0FFqEm+3KiOgUsoSvtO5PBjinIl/kPw=','2016-07-29 02:34:15','2016-07-28',1,1,'','root@gao7.com','root','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 06:50:14','','','','','暂无岗位','','',0,''),(2,'pbkdf2_sha256$24000$Fb7yt8FIxGhI$jiGiKInUIqNvknq1Je9mF81uZfklCaDguo4OcnjqRhE=',NULL,'2016-07-28',1,1,'4ac894e01bd93c8088d933df5a91d1d1','2851728841@qq.com','378','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 08:23:24','b474b3abb9ea327e8dc963e3371f0fb7','','8df381ab121d31838f4672f661fd4e05','余洋','iOS工程师','15659731452','',1,''),(3,'pbkdf2_sha256$24000$5vun0UGqs9Ou$+Q8aEzaJiZNyQ9TFBwy8JhTjI6Gssd9DyHz0Rc2QFUk=','2016-07-28 08:46:51','2016-07-29',1,1,'356c0f4af43d3c8682a0d7b4fac88c30','2851728855@qq.com','595','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 08:42:22','e6fe793ff9413494a389fb003b1de688','','d6b6187853c9332db91705fe37612dbe','陈冷耀','测试工程师','','',0,''),(4,'pbkdf2_sha256$24000$mRX3VzphuU01$e/wiyBmmRLsdidzx/kYlWSB8DouMlZaysVqstnSsK+4=',NULL,'2016-07-28',1,0,'2622e18cea3a3ed5a3c5d804d48ac356','2851728796@qq.com','109','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 08:44:58','3ed1189a6b9832cfaa01d5aca02a34fd','','ddc9b927e94b32b1b00efef17dbf5589','朱如钢','副总裁兼应用事业部总监','','',0,''),(5,'pbkdf2_sha256$24000$1GqFvNSENafY$Oov6n1fBwh2ZBxGhdMMHNg3R3ex/ou6jsa8uIaImd08=',NULL,'2016-07-28',1,0,'9e0a571ca7ed3e14a3a8fb18e12c47fe','2851728865@qq.com','1160','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 08:45:18','710fd80f3e4b3f9497098a7d00b0452b','','a4c87eddae483b1ebe7759236fee7bfb','陈昕','设计总监','','',0,''),(6,'pbkdf2_sha256$24000$VKLXJZPia3Gy$sa8w3e3eLWI1v0EyH6qxlrB2F2JpDKy298N3xh2b68E=',NULL,'2016-07-28',1,0,'ecf5f602374b3923b336c53e68e95de7','2851728808@qq.com','507','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 08:46:21','91f68d822edf3b50a2e6a23a3ceba79f','','8f2c63fb93dd3e61899f6fa4a43dc4ad','黄磊','Android工程师','','',0,''),(7,'pbkdf2_sha256$24000$0SWzxnBpOJ0E$0aYl/mVZbuRQVxiWkofXybUcfYGLSts2zft0Zn2BnBc=',NULL,'2016-07-28',1,0,'10bedb3049de35db8bb22e9c86add04a','2851728801@qq.com','703','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 08:46:30','97750521a351321db21e161f15aebc9d','','a8e4ce9ceefd32b59b0c5459fc1068cd','温怡春','测试工程师','','',0,''),(8,'pbkdf2_sha256$24000$dR9cUycfdI5U$kwqyquiyYjIhxihzs5RwKlLKlQYxGLNj8b6QZDH7HGk=',NULL,'2016-07-28',1,0,'a7af471aa8e431c1b9f12c38b1090f3d','2851728806@qq.com','139','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 08:46:57','ed77621c08313ad9a3d8d40c8c88e931','','6a6df03be98c32699b3d6a5123a3f99a','潘超群','Android工程师','','',0,''),(9,'pbkdf2_sha256$24000$Sg6wq48wbXIV$ox4qIKDAJGhoDiVfHaHVfZBJJJi4K2ghpUjat2szp/Y=',NULL,'2016-07-28',1,0,'835122bd8d1132149f2ff83f9f6bb1ab','2851728854@qq.com','365','female','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 08:48:22','596d6a7fd1fe313887d36324e511f937','','40170c99b975361a99e958f6259fdfb6','左榕艳','测试工程师','','',0,''),(10,'pbkdf2_sha256$24000$FKFa2Mc7Dt8d$w5X3o8cloyZJz9bNUADs4yztu6zxUA7pZWZKWpN9Lh4=',NULL,'2016-07-28',1,1,'e48b03a85c16379ebd4c255e4a42afc5','2851728998@qq.com','5','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 08:48:38','a67e6f6ede503283af0b84946f5476e3','','8abcca4fa9243dbf88411227bff88737','董宇','CEO','13959190114','',0,''),(11,'pbkdf2_sha256$24000$hCH5HWmIQeCY$trI20GEwqCG9cUhLEkoR/EOi/38bVcctkyc/+WqgRnQ=',NULL,'2016-07-28',1,0,'d3dde06775273852b0bd5d9aa4b53f57','2851728858@qq.com','147','female','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 08:50:18','1b17ed1ec1013081bb67fb974c2cb047','','012c33b5a53034fbbf072796c46ff3bb','曹文蔷','设计师','','',0,''),(12,'pbkdf2_sha256$24000$9svx7ack2iCW$iY0feTdh4zl10j0dkjpFQ/cF5lDV3QW0+oVY8lVSwDg=',NULL,'2016-07-28',1,0,'b72f23c6866931f29b8f524962dd28f1','2851728818@qq.com','103','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 08:54:22','b691952ec2b7308aa3354d23d5b58fc9','','66b259e23c563b12bdf18960b33dd7ec','朱明振','.net工程师','','',0,''),(13,'pbkdf2_sha256$24000$6NglCvinXqYu$gAKc2HcWvKp+WWnfWoLQtsQcjOvsfs/nNAa92OCbA+Q=',NULL,'2016-07-28',1,0,'876248095e473af5af62026609f3b5f8','2851728816@qq.com','306','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 08:55:21','a7f370dee60d38c5a3c68c32cb65e013','','5701515a1c5e325c9384311969c315fe','郑荣锥','.net工程师','','',0,''),(14,'pbkdf2_sha256$24000$lkLfdLXI5nmr$SwOSU4O6v1Tq2ocu0kEqsiGUrMXGPMSvgN5/1fZl/C4=',NULL,'2016-07-28',1,0,'e5fe7b4ea27531418a9496cd332b0f18','2851728863@qq.com','156','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 08:55:24','55d116f9039e3342a36586ced5285219','','c7716e3badea37b2a76806fdf43c51b7','陈申','编辑','','',0,''),(15,'pbkdf2_sha256$24000$LdnVyQyoEJUt$SigiYzAzXhwVBF5Om8XVl9/cwXqmCyUeI/NuTfD2mF8=',NULL,'2016-07-28',1,0,'d05d2a9c5fa43460bbcac514dc442f1b','2851728836@qq.com','116','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 08:56:14','d18066bd90cb3d2693fe1fe3507f34b8','','cbaef0ded9463fe9b9ccd181567031c1','陈文','策划','','',0,''),(16,'pbkdf2_sha256$24000$D0K5dRlfMsCj$7mLILXtn0wgiw+FwmGMDtltQSBWpf6MEcLk3vS7mpEs=',NULL,'2016-07-28',1,0,'c9e988b78a2b3197ac38487c483261c2','2851728753@qq.com','731','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 08:57:57','1f97931478503108b42f77db72531601','','9be347cb4fd034b88e4690824a27b316','陈志恒','策划','','',0,''),(17,'pbkdf2_sha256$24000$3sEa9FoRreEd$2xvb3tcHYk3V41V52P1zVISgi1kxXrNJ3Lzz9pO+NDY=',NULL,'2016-07-28',1,0,'a737f742ff743f6183a2e8804758ff73','`2851728857@qq.com','131','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 08:58:51','d8d85f2f3c8f3e1da61df3b4f74a2ebd','','6e5f1c7e8434306aa1cbf60bcb59d65a','郭岚岚','设计部主管','','',0,''),(18,'pbkdf2_sha256$24000$7XUTIFZbdGjL$nltV0zlM78TeomUMk0bVo1Blw08bv3rZnYXDsHa7Dmo=',NULL,'2016-07-28',1,0,'90049867601439829b9ecbcddc965bee','2851728869@qq.com','129','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 08:59:40','86d8b6e5d58d37cd8ec9e4ec63dc2045','','23a9192a0abc370f8e1ca18202a88d68','韩瑞峰','编辑','','',0,''),(19,'pbkdf2_sha256$24000$QVkZXZRm1iBT$xVTfgbEpJrnoxmsL71C93GHt1stD769dIQZGSZfhVYg=',NULL,'2016-07-28',1,0,'bf4b3170a9853533821e8619f20de153','2851728764@qq.com','487','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:01:34','32a9865e88483f6ab5b707619de67009','','cdd23e680559313f871eac54627fb3d4','黄德炜','市场推广','','',0,''),(20,'pbkdf2_sha256$24000$LrOI0B7lRuBe$Fgcgzxx7060a9lRENAQ3JwZKl8acpQovSBGv+Az+egY=',NULL,'2016-07-28',1,0,'9bc9e74640aa31818920899f3bfd3ee4','2851729173@qq.com','292','female','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:03:20','1fa68d62346e32e999f6337c552ca9d8','','5daaeaee11a23c11b9e4a409b94ade36','黄兰','ios开发工程师','','',0,''),(21,'pbkdf2_sha256$24000$MZrJlSfvoZ2c$FJ1Ma1igpzzzoCoP46bsmeaGsBP69smgRmKhrhXU18s=',NULL,'2016-07-28',1,0,'0ec6a0e4d6cd34bfbfd31e16be181c3e','2851728848@qq.com','319','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:05:37','4610d785bea234ac8c5bcbb2f31a4f42','','4520faefc38f3b9b967e12283ff95516','黄文彬','.net工程师','','',0,''),(22,'pbkdf2_sha256$24000$cHuD9YmjRVAf$aaiGOuAjHld1vAnjLwKiY96R/mE4hJow5ig1fOzlXuo=',NULL,'2016-07-28',1,0,'8923d6e05eef3990ae2e0263ebc13cd6','2851728862@qq.com','114','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:06:20','9e7d202f0b363032896c7ec29d26ccba','','3d23d8b4acf13fb58d730c15f5ce59ff','黄晓春','编辑','','',0,''),(23,'pbkdf2_sha256$24000$8ugFobSutzOB$9mw30PRIeaoicirTgYzlvLW1Rfa1YhbsEdY2YNEgFi4=',NULL,'2016-07-28',1,0,'8e0ac8789e043f3ba22d329728561fed','2851728762@qq.com','136','female','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:08:36','c808a18ba3fe37268a4d5d035c800e4f','','8927c710932b35ba93021986de720350','江云燕','市场推广部经理','','',0,''),(24,'pbkdf2_sha256$24000$eh2zDnrah8Xh$iNaEpkXDG/3sVEuqDVLkmuhrqMGSg4BrB/lNgEZa5u8=',NULL,'2016-07-28',1,0,'fc57ef24336731af80a17e5045d1088b','2851728765@qq.com','499','female','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:09:22','86a35fcf16c2306fa1c16ee13cdb7de1','','9cafabdea5f631cca6a3916b8738f1bd','赖美娟','市场推广','','',0,''),(25,'pbkdf2_sha256$24000$gWl9LmMI9D3Q$UPwrtLYkVyGmnLuG8O3s38Ldsb/9exZjcXTSHv7CuT0=',NULL,'2016-07-28',1,0,'a54aa7460b233b8eb8a15c5b593c8942','2851728845@qq.com','491','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:09:54','9582655147083cc2bf293e57b457f8c8','','78456b2a389d3ea68825123dc4db21fe','林悯明','应用事业部副经理','','',0,''),(26,'pbkdf2_sha256$24000$1fTjkYzreqao$bdIAzw6bQetwqtWukcx0+1MSqbrKhcEfocInZiDM2ZE=',NULL,'2016-07-28',1,0,'5b0da0d527493a5aa8cbf104d7c3bc6f','2851728939@qq.com','1000','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:11:01','893e930d55cf38c193cc84bd736890c5','','73cda68c75953d029a6f36c05bb7f921','林强','.net工程师','','',0,''),(27,'pbkdf2_sha256$24000$dltld8gF8u2V$Fb7E5jGbmyASFMWoxyAs89VS6RwlASUTZ532JXjS9+g=',NULL,'2016-07-28',1,0,'fc0e43145ea735bfb72208f38db7059b','2851728837@qq.com','474','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:11:35','a09bbb063ad531f7a0412c0226200496','','12fbcd86d7d63c46a80fa868bf915fb9','林云枫','策划','','',0,''),(28,'pbkdf2_sha256$24000$00m5gDP1d7CP$+R8nZNfw7u9xigDAxwfBswzwS04LLZOA6vXfYa0CVeA=',NULL,'2016-07-28',1,0,'d98073bd6b4b3df0b03861ad30f2028a','2851728844@qq.com','693','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:12:27','b34ca7b5453a392aa6666799d0339482','','51b28db644cf3c5e9ebac8fd025a9e71','刘雷','ios开发工程师','','',0,''),(29,'pbkdf2_sha256$24000$1IFovX11SER8$0xIyp06KSuMZZMlSRZa1+t4WBn0v8FeTScwgs2v7i74=',NULL,'2016-07-28',1,0,'0e5f2d668a7c362d9f3caa0eeb2c0258','2851728867@qq.com','424','female','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:13:13','a8bbdfcb030e34dc835751a600f01606','','14a6dd2cfa93398c9070e26767babdab','刘培','编辑','','',0,''),(30,'pbkdf2_sha256$24000$LLBjEIC1ONBC$kG5lJW8zk3PV3K7q0jST9WgfInfWhrGx4LyByHhp6v0=',NULL,'2016-07-28',1,0,'a94daaf7f8ef3fba8e3662c8572f2324','2851728842@qq.com','416','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:13:47','255049a627dc304fa5f55eda9cad351c','','4ed7bf3afacf31b29ad2c4951387336d','卢志贤','ios开发工程师','','',0,''),(31,'pbkdf2_sha256$24000$dqTYZxx8yTIl$WEXmyNPlIrv8ltTMgq8RsuYAcc6enin/xAe6ht+tcvE=',NULL,'2016-07-28',1,0,'0407a2c89d5c32fe9c37c00d170ad6f3','2851728843@qq.com','692','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:14:17','edc5880a438e319192a223c2321680f6','','4062b9f3de6e392c871fc7f94768c1b6','吕廷元','ios开发工程师','','',0,''),(32,'pbkdf2_sha256$24000$hotFqiqqN6s3$K2wb8LTVouFvLZ9JKZKxtu/RSm7p6WH8auLtulvEWWE=',NULL,'2016-07-28',1,0,'70b682808e5f3e8b8f6bb0d62134a8ab','2851729146@qq.com','861','female','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:14:55','95b57cc7bdcc341b86b03ccf879b8e69','','418ab32a8e0d3ea58c5de40234b87907','麦秀香','市场推广','','',0,''),(33,'pbkdf2_sha256$24000$WFe0vmutlre2$rWP1d9LzklLSMPk0nHmCe3Pj6gb4PBjDbLbPrTiL7ZY=',NULL,'2016-07-28',1,0,'2645849c4b6f3d49bbea1c6a0ba8b627','2851728846@qq.com','265','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:15:38','28a9ba2b419731e886b5700f75741915','','ee4e46ba671c384a9d7b9bdeb937358d','彭亮亮','.net工程师','','',0,''),(34,'pbkdf2_sha256$24000$LvbxR3755Qek$0iCan7sy/zjEQKHd5h8FZIxJtZ9DS+K7rXwwYDHz198=',NULL,'2016-07-28',1,0,'80d7e4be3a5b37b4880f268c28bdcaa2','2851728860@qq.com','117','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:16:08','099db62d69f130e19f452e7537bcd55f','','d1c1082ddb19366ab702e48e3b93c71c','施威','设计一组组长','','',0,''),(35,'pbkdf2_sha256$24000$6ix3z8GNu48t$q1UPtNbmZl1CuIwE8wlh0y4mxCSxuJKnj6Nb1JvFt3M=',NULL,'2016-07-28',1,0,'72e11c89339831bda0c0f74e03c48ef1','2851728921@qq.com','951','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:16:52','ccdaf8b1f5dc31f59665e3d12a67922d','','f497ddbdae2c39298a4c3a70c0335650','苏镇妹','美术设计师','','',0,''),(36,'pbkdf2_sha256$24000$kYXeSOFdUr3L$TxBZMYayMiFKxDrw1kuvJcQjshbKyhEihS1YzskkvhA=',NULL,'2016-07-28',1,0,'ef701a164e973606a4ef0ae35ba50442','2851728839@qq.com','142','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:17:37','a707081ef56e3f998966bebd9261565e','','446571418d0e369e96537ea90daa6512','涂勇彬','iOS一组组长','','',0,''),(37,'pbkdf2_sha256$24000$uaCay0IRLgTx$+MGhi8vhTTfW8Kd4JQZFKjx+dO7SukQIGRgZKEstWbo=',NULL,'2016-07-29',1,1,'9a4bef00813b3ccdab371f75349aafa1','2851728838@qq.com','108','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:18:41','34a273bf9bd231aa9e6f2589649fda7a','','dd2fb8bba8233adb9d33e182c7d6529f','王明福','应用事业部经理','','',0,''),(38,'pbkdf2_sha256$24000$pUZcRewWExqD$OznnRVOblSMF9Adg+bn/gv7zxAq9f3+U8pGiD8ShWbk=',NULL,'2016-07-28',1,0,'444717b71e8132c2a1e01e6255f8fd4c','2851728748@qq.com','981','female','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:19:18','48c36c929bc0305abc75356110e31f9f','','3aa80f3927213c0e89f1ee1f38e4fdfd','翁丽蓉','美术设计师','','',0,''),(39,'pbkdf2_sha256$24000$T4JPmCok4yPe$HjmT+PWyEPhpTiHdei3p+u0b80lfGfOVOJOCAhO9SpA=',NULL,'2016-07-28',1,0,'0d7b3324e88f3bffa713b74d99ce2105','2851728757@qq.com','285','female','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:20:29','d1fa161ea3363be7abba3e88e3c217e0','','3a8e938af97931b4a0269fbe98119964','吴婷','媒介副经理','','',0,''),(40,'pbkdf2_sha256$24000$1HPQysQHfzBr$xyBGBzQFP0pdY9URAGKwfPWVOEJoxHxU3/HV+4cwRoQ=',NULL,'2016-07-28',1,0,'f899f9cf9bd13beebd999538e3801661','2851728859@qq.com','199','female','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:20:59','5e9ba6573c683b3fb7fd53170fe92142','','b85a2e5bac073c9ea746c62e3a2c0e58','吴玉坤','美术设计师','','',0,''),(41,'pbkdf2_sha256$24000$VBgB0MggFhLd$mPXQxXZqYdJBw/pzOvUH+0JeTJfs0uMiLTv+Flq3P+I=',NULL,'2016-07-28',1,0,'2bc3ec49e74139ff955c3d08bfa15457','2851728851@qq.com','130','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:21:39','986b596c8a183501b6cfe287a3ea09b2','','3be6619d4429306ba960d237336f4477','肖远忠','前端工程师','','',0,''),(42,'pbkdf2_sha256$24000$Hz6osgOGp9qM$ud97Vlg2RCy5BLdu96SAKfXQ4UzxVf/NyP5epoShyH0=',NULL,'2016-07-28',1,0,'27b1126bd5a13f058ce263d2a78a3041','2851728872@qq.com','669','female','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:22:18','94359fbf4c41347c90b2d6b6803408a4','','c8760f86ea333217be2cdf60cb976f75','谢雨蓉','编辑','','',0,''),(43,'pbkdf2_sha256$24000$AeofCaCaN4mc$VK11FVIafTvxVrs/l+4t3mpk65JBLhiMeTr7Qw5G0+E=',NULL,'2016-07-28',1,0,'824015ca09743c769c9d15fc537c9449','2851728868@qq.com','439','female','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:22:53','79cc8add54ff30cd8c6ec607ec759aef','','2e8abd5766893b1dba1a2a740624a6b8','姚丽方','编辑','','',0,''),(44,'pbkdf2_sha256$24000$EVYA2dwDh7wk$+jvdwhjuleKOXVA6G4nv8xTAyXJw1mWBIlk69bIvjnI=',NULL,'2016-07-28',1,0,'fce1240fca153c7e8e5258e22476e431','2851728866@qq.com','124','female','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:23:35','6559633c6b293146a58d1fd60461849a','','5a5054d9975d3352a0ab12eac8984823','张萍','编辑','','',0,''),(45,'pbkdf2_sha256$24000$LvZV1WF07rv3$umjSAba/4j5y2RKrKLR6c6bG9bEAKxOsxEW4F7Ok0AQ=',NULL,'2016-07-28',1,0,'2184ebaacfbf35fcb97c804808d6abbc','2851728861@qq.com','110','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:24:01','9d11b2b934ae3934a93ebc7ca10ffd29','','18e28b7df3043477999f0f7057dda6e9','张如挺','编辑部副经理','','',0,''),(46,'pbkdf2_sha256$24000$PCg0ryoWOpus$ZgM9Fv1CfogcGh6c1vc0W7yREW1/YehXWYYpUJgH5us=',NULL,'2016-07-28',1,0,'18c71cb93bd43052b03ebb5b2570bca6','2851728793@qq.com','793','man','/media/user/thumbnails/default_thumb.png',0,'2016-07-28 09:24:43','4a2221fd6090319db06b5d539e3a7fe7','','c89d0de1e4fe3a27b832f65be7453372','张世鹏','.net工程师','','',0,'');
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
  UNIQUE KEY `Account_g7user_groups_g7user_id_0f65fe1a_uniq` (`g7user_id`,`g7group_id`),
  KEY `Account_g7user_groups_g7group_id_cb46f748_fk_Account_g7group_id` (`g7group_id`),
  CONSTRAINT `Account_g7user_groups_g7group_id_cb46f748_fk_Account_g7group_id` FOREIGN KEY (`g7group_id`) REFERENCES `Account_g7group` (`id`),
  CONSTRAINT `Account_g7user_groups_g7user_id_7fd7ec84_fk_Account_g7user_id` FOREIGN KEY (`g7user_id`) REFERENCES `Account_g7user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Account_g7user_groups`
--

LOCK TABLES `Account_g7user_groups` WRITE;
/*!40000 ALTER TABLE `Account_g7user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `Account_g7user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Account_g7user_permissions`
--

DROP TABLE IF EXISTS `Account_g7user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Account_g7user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `g7user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Account_g7user_permissions_g7user_id_00bab13b_uniq` (`g7user_id`,`permission_id`),
  KEY `Account_g7user_perm_permission_id_28bc2397_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `Account_g7user_permissio_g7user_id_5285a830_fk_Account_g7user_id` FOREIGN KEY (`g7user_id`) REFERENCES `Account_g7user` (`id`),
  CONSTRAINT `Account_g7user_perm_permission_id_28bc2397_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Account_g7user_permissions`
--

LOCK TABLES `Account_g7user_permissions` WRITE;
/*!40000 ALTER TABLE `Account_g7user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `Account_g7user_permissions` ENABLE KEYS */;
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
  `identifier` varchar(100) NOT NULL,
  `file` varchar(100) DEFAULT NULL,
  `dsymFile` varchar(100) DEFAULT NULL,
  `version` varchar(150) NOT NULL,
  `icon` varchar(100) NOT NULL,
  `create_at` datetime NOT NULL,
  `modified_at` datetime NOT NULL,
  `bundleID` varchar(200) DEFAULT NULL,
  `description` longtext,
  `build_version` varchar(200) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identifier` (`identifier`),
  KEY `Application_g7application_user_id_75eb2d3d_fk_Account_g7user_id` (`user_id`),
  CONSTRAINT `Application_g7application_user_id_75eb2d3d_fk_Account_g7user_id` FOREIGN KEY (`user_id`) REFERENCES `Account_g7user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Application_g7application`
--

LOCK TABLES `Application_g7application` WRITE;
/*!40000 ALTER TABLE `Application_g7application` DISABLE KEYS */;
INSERT INTO `Application_g7application` VALUES (1,849,1,1,3,'MarsX','271d23630d5f47899356dbfbbf2cfe4b','application/package/MarsX_V1.0_Build16072816261469_20160728162946.ipa','application/package/MarsX_V1.0_Build16072816261469_20160728162946-dSYM.zip','1.0','application/icon/20160728162946.png','2016-07-28 08:29:46','2016-07-28 08:29:46','com.marsplat.marsx','','16072816261469',2),(2,849,1,1,3,'MarsX','7c25e6509ee04e2782568698a992afcc','application/package/MarsX_V1.0_Build16072816403870_20160728164402.ipa','application/package/MarsX_V1.0_Build16072816403870_20160728164402-dSYM.zip','1.0','application/icon/20160728164402.png','2016-07-28 08:44:02','2016-07-28 08:44:02','com.marsplat.marsx','','16072816403870',2),(3,849,1,1,3,'MarsX','2dbce0214b9d428ea6c12987d054aceb','application/package/MarsX_V1.0_Build16072817154571_20160728171909.ipa','application/package/MarsX_V1.0_Build16072817154571_20160728171909-dSYM.zip','1.0','application/icon/20160728171909.png','2016-07-28 09:19:09','2016-07-28 09:19:09','com.marsplat.marsx','','16072817154571',2),(4,39,0,5,29,'壁纸HD','bc697af9fa0d4581927742aa4477c5e4','application/package/壁纸HD_V2.2.5_Build160729092624122_20160729094053.ipa','application/package/壁纸HD_V2.2.5_Build160729092624122_20160729094053-dSYM.zip','2.2.5','application/icon/20160729094053.png','2016-07-29 01:40:53','2016-07-29 01:40:54','com.tandy.wallpaper.pid39ch5','','160729092624122',36),(5,849,1,1,3,'MarsX','17840fcbffdb4b94a179ae9f9f19ead0','application/package/MarsX_V1.0_Build16072910230072_20160729102542.ipa','application/package/MarsX_V1.0_Build16072910230072_20160729102542-dSYM.zip','1.0','application/icon/20160729102542.png','2016-07-29 02:25:42','2016-07-29 02:25:42','com.gao7.marsx','','16072910230072',2),(6,849,1,1,3,'MarsX','08ef771c3aea4a6aafd1ce1f29c33e97','application/package/MarsX_V1.0_Build16072910470373_20160729104930.ipa','application/package/MarsX_V1.0_Build16072910470373_20160729104930-dSYM.zip','1.0','application/icon/20160729104930.png','2016-07-29 02:49:30','2016-07-29 02:49:30','com.marsplat.marsx','','16072910470373',2);
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
  UNIQUE KEY `Application_g7application_fr_from_g7application_id_09d536f1_uniq` (`from_g7application_id`,`to_g7application_id`),
  KEY `App_to_g7application_id_3c839676_fk_Application_g7application_id` (`to_g7application_id`),
  CONSTRAINT `App_to_g7application_id_3c839676_fk_Application_g7application_id` FOREIGN KEY (`to_g7application_id`) REFERENCES `Application_g7application` (`id`),
  CONSTRAINT `A_from_g7application_id_8a26ac21_fk_Application_g7application_id` FOREIGN KEY (`from_g7application_id`) REFERENCES `Application_g7application` (`id`)
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
-- Table structure for table `Application_g7product`
--

DROP TABLE IF EXISTS `Application_g7product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Application_g7product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `platform` int(11) NOT NULL,
  `product_type` int(11) NOT NULL,
  `product_status` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `latest_version` varchar(200) DEFAULT NULL,
  `latest_inner_version` int(11) DEFAULT NULL,
  `latest_build_version` varchar(200) DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `description` longtext,
  `icon` varchar(100) NOT NULL,
  `identifier` varchar(100) NOT NULL,
  `bundleID` varchar(200) NOT NULL,
  `create_at` datetime NOT NULL,
  `modified_at` datetime NOT NULL,
  `owner_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identifier` (`identifier`),
  UNIQUE KEY `bundleID` (`bundleID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Application_g7product`
--

LOCK TABLES `Application_g7product` WRITE;
/*!40000 ALTER TABLE `Application_g7product` DISABLE KEYS */;
INSERT INTO `Application_g7product` VALUES (1,0,0,0,849,'1.0',3,'16072910470373','MarsX','','product/icon/Icon-83.52x.png','e879ac698cc634e2bbc35d7d82fc93e8','com.marsplat.marsx','2016-07-28 08:29:46','2016-07-29 02:49:30',2),(2,0,0,0,39,'2.2.5',29,'160729092624122','壁纸HD','','product/icon/20160729094053.png','b607f3dfb8f03480be67a4183ac5716e','com.tandy.wallpaper.pid39ch5','2016-07-29 01:40:53','2016-07-29 01:44:54',36);
/*!40000 ALTER TABLE `Application_g7product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Application_g7product_applications`
--

DROP TABLE IF EXISTS `Application_g7product_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Application_g7product_applications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `g7product_id` int(11) NOT NULL,
  `g7application_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Application_g7product_applications_g7product_id_6ba9293b_uniq` (`g7product_id`,`g7application_id`),
  KEY `Applic_g7application_id_d715679a_fk_Application_g7application_id` (`g7application_id`),
  CONSTRAINT `Application_g7_g7product_id_703f1005_fk_Application_g7product_id` FOREIGN KEY (`g7product_id`) REFERENCES `Application_g7product` (`id`),
  CONSTRAINT `Applic_g7application_id_d715679a_fk_Application_g7application_id` FOREIGN KEY (`g7application_id`) REFERENCES `Application_g7application` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Application_g7product_applications`
--

LOCK TABLES `Application_g7product_applications` WRITE;
/*!40000 ALTER TABLE `Application_g7product_applications` DISABLE KEYS */;
INSERT INTO `Application_g7product_applications` VALUES (1,1,1),(2,1,2),(3,1,3),(5,1,5),(6,1,6),(4,2,4);
/*!40000 ALTER TABLE `Application_g7product_applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Application_g7product_members`
--

DROP TABLE IF EXISTS `Application_g7product_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Application_g7product_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `g7product_id` int(11) NOT NULL,
  `g7user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Application_g7product_members_g7product_id_3cbc0fa1_uniq` (`g7product_id`,`g7user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Application_g7product_members`
--

LOCK TABLES `Application_g7product_members` WRITE;
/*!40000 ALTER TABLE `Application_g7product_members` DISABLE KEYS */;
INSERT INTO `Application_g7product_members` VALUES (1,1,2),(2,2,36);
/*!40000 ALTER TABLE `Application_g7product_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Feedback_g7feedbackmodel`
--

DROP TABLE IF EXISTS `Feedback_g7feedbackmodel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Feedback_g7feedbackmodel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(200) DEFAULT NULL,
  `contact` varchar(200) DEFAULT NULL,
  `context` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Feedback_g7feedbackmodel`
--

LOCK TABLES `Feedback_g7feedbackmodel` WRITE;
/*!40000 ALTER TABLE `Feedback_g7feedbackmodel` DISABLE KEYS */;
/*!40000 ALTER TABLE `Feedback_g7feedbackmodel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Push_g7pushnotificatintoken`
--

DROP TABLE IF EXISTS `Push_g7pushnotificatintoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Push_g7pushnotificatintoken` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Push_g7pushnotificatintoken`
--

LOCK TABLES `Push_g7pushnotificatintoken` WRITE;
/*!40000 ALTER TABLE `Push_g7pushnotificatintoken` DISABLE KEYS */;
INSERT INTO `Push_g7pushnotificatintoken` VALUES (9,'0c9e40c9bd07654c8fc84c777d657f78994ac8df55a80fb82c93552929e9c1a4'),(3,'1cb619562480f9eaf9c33626dcb8a89177d1a83c945ea1e7f218be7cc7201be8'),(8,'2c55f20677590b328aef19267ed0bdbb115c4452c76e926b4cecad6826ffca26'),(6,'a08683f8064b0fbdebd172d235835a2c75ccb9d067614317a8fd6067a8d01af8'),(7,'a197f78798cc48b5223150c38a90a5f0722b02e7426edfddebc1006b83dc7441'),(2,'af8bc816c006a07ceeadfffcce436a7e315a82d90f2e2bc45f0150dac0c06f86'),(1,'d25931069523995e939cdb990002f03871c2871c8076ced8899d1fc8144b5bec'),(4,'d7d33c46994a9c8411c9d5d7e708a6118a56e86e5cf1f8b2b06e0eabfa79f4c6'),(5,'de8b8fd243ad3a59b35ba174dd697aec8cccb4be5fefd9d93422eb7de1b8419a');
/*!40000 ALTER TABLE `Push_g7pushnotificatintoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Push_g7pushprofile`
--

DROP TABLE IF EXISTS `Push_g7pushprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Push_g7pushprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `p12file` varchar(100) NOT NULL,
  `p12password` varchar(100) DEFAULT NULL,
  `private_pem_file` varchar(100) DEFAULT NULL,
  `public_pem_file` varchar(100) DEFAULT NULL,
  `using` tinyint(1) NOT NULL,
  `use_sandbox` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Push_g7pushprofile`
--

LOCK TABLES `Push_g7pushprofile` WRITE;
/*!40000 ALTER TABLE `Push_g7pushprofile` DISABLE KEYS */;
INSERT INTO `Push_g7pushprofile` VALUES (1,'648f2b056f263071ba90a90a8479ac3c','MarsX','push/profile/push_dis.p12','123654','push/profile/private/317b66f203f43083a7e434c2d71d2b0e','push/profile/public/501e2d5c74fe3151bb0cfb0fc7d42058',1,0);
/*!40000 ALTER TABLE `Push_g7pushprofile` ENABLE KEYS */;
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
  UNIQUE KEY `auth_group_permissions_group_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
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
  UNIQUE KEY `auth_permission_content_type_id_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permissi_content_type_id_2f476e4b_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add 群组',6,'add_g7group'),(17,'Can change 群组',6,'change_g7group'),(18,'Can delete 群组',6,'delete_g7group'),(19,'Can add 用户',7,'add_g7user'),(20,'Can change 用户',7,'change_g7user'),(21,'Can delete 用户',7,'delete_g7user'),(22,'Can add 反馈',8,'add_g7feedbackmodel'),(23,'Can change 反馈',8,'change_g7feedbackmodel'),(24,'Can delete 反馈',8,'delete_g7feedbackmodel'),(25,'Can add 产品',9,'add_g7product'),(26,'Can change 产品',9,'change_g7product'),(27,'Can delete 产品',9,'delete_g7product'),(28,'Can add 应用',10,'add_g7application'),(29,'Can change 应用',10,'change_g7application'),(30,'Can delete 应用',10,'delete_g7application'),(31,'Can add 推送',11,'add_g7pushprofile'),(32,'Can change 推送',11,'change_g7pushprofile'),(33,'Can delete 推送',11,'delete_g7pushprofile'),(34,'Can add 推送标识码',12,'add_g7pushnotificatintoken'),(35,'Can change 推送标识码',12,'change_g7pushnotificatintoken'),(36,'Can delete 推送标识码',12,'delete_g7pushnotificatintoken');
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
  KEY `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_Account_g7user_id` (`user_id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_Account_g7user_id` FOREIGN KEY (`user_id`) REFERENCES `Account_g7user` (`id`),
  CONSTRAINT `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2016-07-28 07:48:04','1','1.MarsX',1,'Added.',11,1),(2,'2016-07-28 08:23:24','2','2.yuyang',1,'Added.',7,1),(3,'2016-07-28 08:23:49','2','2.余洋',2,'已修改 realname 和 email_vip 。',7,1),(4,'2016-07-28 08:25:12','2','2.余洋',2,'已修改 job 。',7,1),(5,'2016-07-28 08:25:22','2','2.余洋',2,'已修改 username 。',7,1),(6,'2016-07-28 08:41:57','1','1.MarsX',2,'已修改 owner 。',9,1),(7,'2016-07-28 08:42:22','3','3.595',1,'Added.',7,1),(8,'2016-07-28 08:43:32','3','3.陈冷耀',2,'已修改 realname 和 is_admin 。',7,1),(9,'2016-07-28 08:43:45','3','3.陈冷耀',2,'已修改 job 。',7,1),(10,'2016-07-28 08:44:58','4','4.109',1,'Added.',7,3),(11,'2016-07-28 08:45:18','5','5.1160',1,'Added.',7,1),(12,'2016-07-28 08:45:46','4','4.朱如钢',2,'已修改 job 和 realname 。',7,3),(13,'2016-07-28 08:45:57','5','5.陈昕',2,'已修改 job 和 realname 。',7,1),(14,'2016-07-28 08:46:21','6','6.507',1,'Added.',7,1),(15,'2016-07-28 08:46:30','7','7.703',1,'Added.',7,3),(16,'2016-07-28 08:46:40','6','6.黄磊',2,'已修改 job 和 realname 。',7,1),(17,'2016-07-28 08:46:57','8','8.139',1,'Added.',7,1),(18,'2016-07-28 08:47:19','8','8.潘超群',2,'已修改 job 和 realname 。',7,1),(19,'2016-07-28 08:47:47','7','7.温怡春',2,'已修改 job 和 realname 。',7,3),(20,'2016-07-28 08:48:00','8','8.潘超群',2,'已修改 email 。',7,1),(21,'2016-07-28 08:48:22','9','9.365',1,'Added.',7,3),(22,'2016-07-28 08:48:37','9','9.365',2,'已修改 job 和 sex 。',7,3),(23,'2016-07-28 08:48:38','10','10.5',1,'Added.',7,1),(24,'2016-07-28 08:49:00','9','9.左榕艳',2,'已修改 realname 。',7,3),(25,'2016-07-28 08:49:07','10','10.董宇',2,'已修改 job，realname，mobile 和 is_admin 。',7,1),(26,'2016-07-28 08:50:18','11','11.14',1,'Added.',7,3),(27,'2016-07-28 08:50:28','11','11.147',2,'已修改 username 。',7,3),(28,'2016-07-28 08:50:49','2','2.余洋',2,'已修改 email 。',7,1),(29,'2016-07-28 08:50:53','11','11.曹文蔷',2,'已修改 job，sex 和 realname 。',7,3),(30,'2016-07-28 08:50:58','2','2.余洋',2,'已修改 is_admin 。',7,1),(31,'2016-07-28 08:51:20','3','3.陈冷耀',2,'已修改 email 。',7,1),(32,'2016-07-28 08:52:58','5','5.陈昕',2,'已修改 email 。',7,1),(33,'2016-07-28 08:53:18','6','6.黄磊',2,'已修改 email 。',7,1),(34,'2016-07-28 08:53:27','8','8.潘超群',2,'已修改 email 。',7,1),(35,'2016-07-28 08:54:22','12','12.103',1,'Added.',7,1),(36,'2016-07-28 08:54:55','12','12.朱明振',2,'已修改 job 和 realname 。',7,1),(37,'2016-07-28 08:55:21','13','13.306',1,'Added.',7,1),(38,'2016-07-28 08:55:24','14','14.156',1,'Added.',7,3),(39,'2016-07-28 08:55:40','13','13.郑荣锥',2,'已修改 job 和 realname 。',7,1),(40,'2016-07-28 08:55:44','14','14.陈申',2,'已修改 job 和 realname 。',7,3),(41,'2016-07-28 08:56:14','15','15.陈文',1,'Added.',7,3),(42,'2016-07-28 08:57:13','15','15.116',2,'已修改 username 。',7,3),(43,'2016-07-28 08:57:31','15','15.陈文',2,'已修改 job 和 realname 。',7,3),(44,'2016-07-28 08:57:57','16','16.731',1,'Added.',7,3),(45,'2016-07-28 08:58:15','16','16.陈志恒',2,'已修改 job 和 realname 。',7,3),(46,'2016-07-28 08:58:16','1','1.MarsX',2,'已修改 icon 。',9,1),(47,'2016-07-28 08:58:19','16','16.陈志恒',2,'没有字段被修改。',7,3),(48,'2016-07-28 08:58:51','17','17.131',1,'Added.',7,3),(49,'2016-07-28 08:59:16','17','17.郭岚岚',2,'已修改 job 和 realname 。',7,3),(50,'2016-07-28 08:59:40','18','18.129',1,'Added.',7,3),(51,'2016-07-28 09:00:35','18','18.韩瑞峰',2,'已修改 job 和 realname 。',7,3),(52,'2016-07-28 09:01:34','19','19.487',1,'Added.',7,3),(53,'2016-07-28 09:02:52','19','19.黄德炜',2,'已修改 job 和 realname 。',7,3),(54,'2016-07-28 09:03:20','20','20.292',1,'Added.',7,3),(55,'2016-07-28 09:04:42','20','20.292',2,'已修改 job 和 sex 。',7,3),(56,'2016-07-28 09:05:05','20','20.黄兰',2,'已修改 realname 。',7,3),(57,'2016-07-28 09:05:37','21','21.319',1,'Added.',7,3),(58,'2016-07-28 09:05:59','21','21.黄文彬',2,'已修改 job 和 realname 。',7,3),(59,'2016-07-28 09:06:20','22','22.114',1,'Added.',7,3),(60,'2016-07-28 09:08:14','22','22.黄晓春',2,'已修改 job 和 realname 。',7,3),(61,'2016-07-28 09:08:36','23','23.136',1,'Added.',7,3),(62,'2016-07-28 09:08:56','23','23.江云燕',2,'已修改 job，sex 和 realname 。',7,3),(63,'2016-07-28 09:09:22','24','24.499',1,'Added.',7,3),(64,'2016-07-28 09:09:37','24','24.499',2,'已修改 job 和 sex 。',7,3),(65,'2016-07-28 09:09:54','25','25.491',1,'Added.',7,3),(66,'2016-07-28 09:10:43','25','25.林悯明',2,'已修改 job 和 realname 。',7,3),(67,'2016-07-28 09:11:01','26','26.1000',1,'Added.',7,3),(68,'2016-07-28 09:11:16','26','26.林强',2,'已修改 job 和 realname 。',7,3),(69,'2016-07-28 09:11:35','27','27.474',1,'Added.',7,3),(70,'2016-07-28 09:12:05','27','27.林云枫',2,'已修改 job 和 realname 。',7,3),(71,'2016-07-28 09:12:27','28','28.693',1,'Added.',7,3),(72,'2016-07-28 09:12:50','28','28.刘雷',2,'已修改 job 和 realname 。',7,3),(73,'2016-07-28 09:13:13','29','29.424',1,'Added.',7,3),(74,'2016-07-28 09:13:30','29','29.刘培',2,'已修改 job，sex 和 realname 。',7,3),(75,'2016-07-28 09:13:47','30','30.416',1,'Added.',7,3),(76,'2016-07-28 09:14:02','30','30.卢志贤',2,'已修改 job 和 realname 。',7,3),(77,'2016-07-28 09:14:17','31','31.692',1,'Added.',7,3),(78,'2016-07-28 09:14:32','31','31.吕廷元',2,'已修改 job 和 realname 。',7,3),(79,'2016-07-28 09:14:55','32','32.861',1,'Added.',7,3),(80,'2016-07-28 09:15:17','32','32.麦秀香',2,'已修改 job，sex 和 realname 。',7,3),(81,'2016-07-28 09:15:38','33','33.265',1,'Added.',7,3),(82,'2016-07-28 09:15:52','33','33.彭亮亮',2,'已修改 job 和 realname 。',7,3),(83,'2016-07-28 09:16:08','34','34.117',1,'Added.',7,3),(84,'2016-07-28 09:16:29','34','34.施威',2,'已修改 job 和 realname 。',7,3),(85,'2016-07-28 09:16:52','35','35.951',1,'Added.',7,3),(86,'2016-07-28 09:17:10','35','35.苏镇妹',2,'已修改 job 和 realname 。',7,3),(87,'2016-07-28 09:17:37','36','36.142',1,'Added.',7,3),(88,'2016-07-28 09:18:19','36','36.涂勇彬',2,'已修改 job 和 realname 。',7,3),(89,'2016-07-28 09:18:41','37','37.108',1,'Added.',7,3),(90,'2016-07-28 09:18:59','37','37.王明福',2,'已修改 job 和 realname 。',7,3),(91,'2016-07-28 09:19:18','38','38.981',1,'Added.',7,3),(92,'2016-07-28 09:19:39','38','38.翁丽蓉',2,'已修改 job，sex 和 realname 。',7,3),(93,'2016-07-28 09:20:29','39','39.285',1,'Added.',7,3),(94,'2016-07-28 09:20:43','39','39.吴婷',2,'已修改 job，sex 和 realname 。',7,3),(95,'2016-07-28 09:20:59','40','40.199',1,'Added.',7,3),(96,'2016-07-28 09:21:21','40','40.吴玉坤',2,'已修改 job，sex 和 realname 。',7,3),(97,'2016-07-28 09:21:39','41','41.130',1,'Added.',7,3),(98,'2016-07-28 09:21:58','41','41.肖远忠',2,'已修改 job 和 realname 。',7,3),(99,'2016-07-28 09:22:18','42','42.669',1,'Added.',7,3),(100,'2016-07-28 09:22:33','42','42.谢雨蓉',2,'已修改 job，sex 和 realname 。',7,3),(101,'2016-07-28 09:22:53','43','43.439',1,'Added.',7,3),(102,'2016-07-28 09:23:07','43','43.姚丽方',2,'已修改 job，sex 和 realname 。',7,3),(103,'2016-07-28 09:23:35','44','44.124',1,'Added.',7,3),(104,'2016-07-28 09:23:45','44','44.张萍',2,'已修改 job，sex 和 realname 。',7,3),(105,'2016-07-28 09:24:01','45','45.110',1,'Added.',7,3),(106,'2016-07-28 09:24:23','45','45.张如挺',2,'已修改 job 和 realname 。',7,3),(107,'2016-07-28 09:24:43','46','46.793',1,'Added.',7,3),(108,'2016-07-28 09:24:59','46','46.张世鹏',2,'已修改 job 和 realname 。',7,3),(109,'2016-07-28 09:26:17','24','24.莱美娟',2,'已修改 realname 。',7,3),(110,'2016-07-28 09:26:54','2','2.余洋',2,'已修改 mobile 。',7,1),(111,'2016-07-28 09:33:45','24','24.赖美娟',2,'已修改 realname 。',7,1),(112,'2016-07-29 01:17:11','37','37.王明福',2,'已修改 is_admin 。',7,1),(113,'2016-07-29 01:44:54','2','2.壁纸HD',2,'已修改 owner 。',9,1);
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
  UNIQUE KEY `django_content_type_app_label_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (6,'Account','g7group'),(7,'Account','g7user'),(1,'admin','logentry'),(10,'Application','g7application'),(9,'Application','g7product'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(8,'Feedback','g7feedbackmodel'),(12,'Push','g7pushnotificatintoken'),(11,'Push','g7pushprofile'),(5,'sessions','session');
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2016-07-28 06:50:00'),(2,'contenttypes','0002_remove_content_type_name','2016-07-28 06:50:00'),(3,'auth','0001_initial','2016-07-28 06:50:00'),(4,'auth','0002_alter_permission_name_max_length','2016-07-28 06:50:00'),(5,'auth','0003_alter_user_email_max_length','2016-07-28 06:50:00'),(6,'auth','0004_alter_user_username_opts','2016-07-28 06:50:00'),(7,'auth','0005_alter_user_last_login_null','2016-07-28 06:50:00'),(8,'auth','0006_require_contenttypes_0002','2016-07-28 06:50:00'),(9,'auth','0007_alter_validators_add_error_messages','2016-07-28 06:50:00'),(10,'Account','0001_initial','2016-07-28 06:50:00'),(11,'Account','0002_auto_20160728_1449','2016-07-28 06:50:00'),(12,'Application','0001_initial','2016-07-28 06:50:00'),(13,'Feedback','0001_initial','2016-07-28 06:50:00'),(14,'Push','0001_initial','2016-07-28 06:50:00'),(15,'admin','0001_initial','2016-07-28 06:50:00'),(16,'admin','0002_logentry_remove_auto_add','2016-07-28 06:50:00'),(17,'sessions','0001_initial','2016-07-28 06:50:00');
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
INSERT INTO `django_session` VALUES ('e3ghhouz50p4w27r1wnz0zn2s2lxqai6','NmFlYWIzNmRkYTY2M2ZjOTVmNzM4N2JhZGY5ZjJjNzIwZGE2MDNhODp7Il9hdXRoX3VzZXJfaGFzaCI6ImM0MzE1MDcwMjc4YTI2ODQ5Zjc2M2EwNDk2OTlkMWExNzIwZGU1YTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-08-12 02:34:15'),('fgh55ircy0krmk15rsltl5jtltie4s16','NWJmZTc5MDE5YTRkYjQ1ZTQ1MWQ4ZmU4MDYzNTIyNjllY2NhMzYzMzp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MTc0MDY1ZDRlNzg0NjI5Yzk2NzM5ZGZjNjM3MmQ1MzM2MWJiYWYwIn0=','2016-08-11 08:46:51'),('hoz5lojsdpf939fsuaiz7vneqjyd2bww','YWM2MDY2MDA1MGQwN2VkNzVkNDMxNTIyZGNiN2Q4MzFjODc1YTcxNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzZjAzNzU4ODNiNWJiMTcwOTQ0MGE5ZmU2MmRjNTQ2ZWU4Nzg1YjAyIn0=','2016-08-12 01:16:57'),('t6z2f866mvb68jvgsdl5o515wfuz8ax8','NWJmZTc5MDE5YTRkYjQ1ZTQ1MWQ4ZmU4MDYzNTIyNjllY2NhMzYzMzp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MTc0MDY1ZDRlNzg0NjI5Yzk2NzM5ZGZjNjM3MmQ1MzM2MWJiYWYwIn0=','2016-08-11 08:43:45');
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

-- Dump completed on 2016-07-28 23:03:25
