CREATE DATABASE  IF NOT EXISTS `specit` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `specit`;
-- MySQL dump 10.13  Distrib 5.5.29, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: specit
-- ------------------------------------------------------
-- Server version	5.5.29-0ubuntu0.12.10.1

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
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `id_comment` bigint(20) NOT NULL AUTO_INCREMENT,
  `creat_by` varchar(255) DEFAULT NULL,
  `dt_creat` datetime DEFAULT NULL,
  `dt_modif` datetime DEFAULT NULL,
  `modif_by` varchar(255) DEFAULT NULL,
  `texte` longtext,
  `VERSION` bigint(20) DEFAULT NULL,
  `id_test_step` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_comment`),
  KEY `FK_comment_id_test_step` (`id_test_step`),
  CONSTRAINT `FK_comment_id_test_step` FOREIGN KEY (`id_test_step`) REFERENCES `test_step` (`id_test_step`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,'smarechal','2012-10-29 17:25:05','2012-11-13 19:06:11',NULL,'http://checkthis.com/vthz',6,1),(2,'smarechal','2012-10-29 17:25:31','2012-11-13 19:06:11',NULL,'<b>sdq</b><br/>dsq',5,1),(3,'gbougeard','2012-10-29 17:27:03','2012-11-13 19:06:11',NULL,'test',4,1),(4,'gbougeard','2012-10-29 15:37:14','2012-11-13 19:06:11',NULL,'test',3,1),(5,'pcreunion','2012-11-05 14:24:39','2012-11-05 14:24:39',NULL,'ca marche pas',1,18),(6,'pcreunion','2012-11-05 14:25:51','2012-11-05 14:25:51',NULL,'plus dinfos',1,18),(7,'jganovelli','2012-11-13 19:06:11','2012-11-13 19:06:11',NULL,'ca mlarcher pas',1,1),(8,'failed','2012-12-13 21:23:12',NULL,NULL,':(',NULL,25),(9,'failed','2012-12-13 21:23:57',NULL,NULL,':(',NULL,25),(10,'test','2012-12-16 18:17:03',NULL,NULL,'',NULL,17),(11,'Test','2013-02-04 19:22:51',NULL,NULL,'yéyéyé',NULL,17);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `info`
--

DROP TABLE IF EXISTS `info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info` (
  `id_info` bigint(20) NOT NULL AUTO_INCREMENT,
  `creat_by` varchar(255) DEFAULT NULL,
  `description` longtext,
  `dt_creat` datetime DEFAULT NULL,
  `dt_modif` datetime DEFAULT NULL,
  `info_type` varchar(255) DEFAULT NULL,
  `modif_by` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `VERSION` bigint(20) DEFAULT NULL,
  `id_campaign` bigint(20) DEFAULT NULL,
  `id_story` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_info`),
  KEY `FK_info_id_campaign` (`id_campaign`),
  KEY `FK_info_id_story` (`id_story`),
  CONSTRAINT `FK_info_id_campaign` FOREIGN KEY (`id_campaign`) REFERENCES `campaign` (`id_campaign`),
  CONSTRAINT `FK_info_id_story` FOREIGN KEY (`id_story`) REFERENCES `story` (`id_story`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `info`
--

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;
INSERT INTO `info` VALUES (1,'gbougeard','<b>gbougeard</b> a créé la campagne suivante : <br/><h2>premiere campagne (test)</h2><p>premiere campagne (test)<br/></p><br/>Elle est affectée à <b>smarechal</b>.<br/>Pour acceder directement à la campagne <a href=\'https://specifyit.dev.it.int:8181/specify-it//campaign/v/1\'>Cliquez là</a>','2012-10-29 17:09:45','2012-10-29 17:09:45','NEW_CAMPAIGN',NULL,'Une nouvelle campagne pour tester Story de test a été créée',1,1,1),(2,'smarechal','<h2>premier scenario (test)</h2><h3>premier step (test)</h3><b>smarechal</b> a ajouté le commentaire suivant : <br/><p>http://checkthis.com/vthz</p><br/>Pour accéder directement à la campagne <a href=\'https://specifyit.dev.it.int:8181/specify-it//campaign/v/1\'>Cliquez là</a>','2012-10-29 17:25:05','2012-10-29 17:25:05','NEW_COMMENT',NULL,'premiere campagne (test) - Un nouveau commentaire a été ajouté',1,1,1),(3,'smarechal','<h2>premier scenario (test)</h2><h3>premier step (test)</h3><b>smarechal</b> a ajouté le commentaire suivant : <br/><p>sdqdsq</p><br/>Pour accéder directement à la campagne <a href=\'https://specifyit.dev.it.int:8181/specify-it//campaign/v/1\'>Cliquez là</a>','2012-10-29 17:25:31','2012-10-29 17:25:31','NEW_COMMENT',NULL,'premiere campagne (test) - Un nouveau commentaire a été ajouté',1,1,1),(4,'gbougeard','<h2>premier scenario (test)</h2><h3>premier step (test)</h3><b>gbougeard</b> a ajouté le commentaire suivant : <br/><p>test</p><br/>Pour accéder directement à la campagne <a href=\'https://specifyit.dev.it.int:8181/specify-it//campaign/v/1\'>Cliquez là</a>','2012-10-29 17:27:03','2012-10-29 17:27:03','NEW_COMMENT',NULL,'premiere campagne (test) - Un nouveau commentaire a été ajouté',1,1,1),(5,'gbougeard','<h2>premier scenario (test)</h2><h3>premier step (test)</h3><b>gbougeard</b> a ajouté le commentaire suivant : <br/><p>test</p><br/>Pour accéder directement à la campagne <a href=\'https://10.2.1.211:8181/specify-it//campaign/v/1\'>Cliquez là</a>','2012-10-29 15:37:14','2012-10-29 15:37:14','NEW_COMMENT',NULL,'premiere campagne (test) - Un nouveau commentaire a été ajouté',1,1,1),(6,'gbougeard','<b>null</b> a créé la campagne suivante : <br/><h2>test de version - Story de test - IE6 - FR</h2><p>null</p><br/>Elle est affectée à <b>akeiflin</b>.<br/>Pour acceder directement à la campagne <a href=\'https://specifyit.dev.it.int:8181/specify-it//campaign/v/2\'>Cliquez là</a>','2012-10-31 17:39:27','2012-10-31 17:39:27','NEW_CAMPAIGN',NULL,'Une nouvelle campagne pour tester Story de test a été créée',1,2,1),(7,'gbougeard','<b>null</b> a créé la campagne suivante : <br/><h2>test de version - Story de test - IE6 - DE</h2><p>null</p><br/>Elle est affectée à <b>akeiflin</b>.<br/>Pour acceder directement à la campagne <a href=\'https://specifyit.dev.it.int:8181/specify-it//campaign/v/3\'>Cliquez là</a>','2012-10-31 17:39:27','2012-10-31 17:39:27','NEW_CAMPAIGN',NULL,'Une nouvelle campagne pour tester Story de test a été créée',1,3,1),(8,'gbougeard','<b>null</b> a créé la campagne suivante : <br/><h2>test de version - Story de test - FIREFOX - FR</h2><p>null</p><br/>Elle est affectée à <b>akeiflin</b>.<br/>Pour acceder directement à la campagne <a href=\'https://specifyit.dev.it.int:8181/specify-it//campaign/v/4\'>Cliquez là</a>','2012-10-31 17:39:27','2012-10-31 17:39:27','NEW_CAMPAIGN',NULL,'Une nouvelle campagne pour tester Story de test a été créée',1,4,1),(9,'gbougeard','<b>null</b> a créé la campagne suivante : <br/><h2>test de version - Story de test - SAFARI - DE</h2><p>null</p><br/>Elle est affectée à <b>akeiflin</b>.<br/>Pour acceder directement à la campagne <a href=\'https://specifyit.dev.it.int:8181/specify-it//campaign/v/5\'>Cliquez là</a>','2012-10-31 17:39:27','2012-10-31 17:39:27','NEW_CAMPAIGN',NULL,'Une nouvelle campagne pour tester Story de test a été créée',1,5,1),(10,'gbougeard','<b>null</b> a créé la campagne suivante : <br/><h2>test de version - Story de test - CHROME - DE</h2><p>null</p><br/>Elle est affectée à <b>akeiflin</b>.<br/>Pour acceder directement à la campagne <a href=\'https://specifyit.dev.it.int:8181/specify-it//campaign/v/6\'>Cliquez là</a>','2012-10-31 17:39:27','2012-10-31 17:39:27','NEW_CAMPAIGN',NULL,'Une nouvelle campagne pour tester Story de test a été créée',1,6,1),(11,'gbougeard','<b>null</b> a créé la campagne suivante : <br/><h2>test de version - Story de test - FIREFOX - DE</h2><p>null</p><br/>Elle est affectée à <b>akeiflin</b>.<br/>Pour acceder directement à la campagne <a href=\'https://specifyit.dev.it.int:8181/specify-it//campaign/v/7\'>Cliquez là</a>','2012-10-31 17:39:27','2012-10-31 17:39:27','NEW_CAMPAIGN',NULL,'Une nouvelle campagne pour tester Story de test a été créée',1,7,1),(12,'gbougeard','<b>null</b> a créé la campagne suivante : <br/><h2>test de version - Story de test - SAFARI - FR</h2><p>null</p><br/>Elle est affectée à <b>akeiflin</b>.<br/>Pour acceder directement à la campagne <a href=\'https://specifyit.dev.it.int:8181/specify-it//campaign/v/8\'>Cliquez là</a>','2012-10-31 17:39:27','2012-10-31 17:39:27','NEW_CAMPAIGN',NULL,'Une nouvelle campagne pour tester Story de test a été créée',1,8,1),(13,'gbougeard','<b>null</b> a créé la campagne suivante : <br/><h2>test de version - Story de test - CHROME - FR</h2><p>null</p><br/>Elle est affectée à <b>akeiflin</b>.<br/>Pour acceder directement à la campagne <a href=\'https://specifyit.dev.it.int:8181/specify-it//campaign/v/9\'>Cliquez là</a>','2012-10-31 17:39:27','2012-10-31 17:39:27','NEW_CAMPAIGN',NULL,'Une nouvelle campagne pour tester Story de test a été créée',1,9,1),(14,'gbougeard','<b>gbougeard</b> a créé la campagne suivante : <br/><h2>Test SBT version XX</h2><p>passe de routine sur SBT<br/></p><br/>Elle est affectée à <b>akeiflin</b>.<br/>Pour acceder directement à la campagne <a href=\'https://specifyit.dev.it.int:8181/specify-it//campaign/v/10\'>Cliquez là</a>','2012-11-05 11:30:44','2012-11-05 11:30:44','NEW_CAMPAIGN',NULL,'Une nouvelle campagne pour tester SBT - Reservation a été créée',1,10,2),(15,'pcreunion','<b>pcreunion</b> a créé la campagne suivante : <br/><h2>Nouvelle campagne</h2><p>test de validation interne</p><br/>Elle est affectée à <b>akeiflin</b>.<br/>Pour acceder directement à la campagne <a href=\'https://specifyit.dev.it.int:8181/specify-it//campaign/v/11\'>Cliquez là</a>','2012-11-05 14:22:34','2012-11-05 14:22:34','NEW_CAMPAIGN',NULL,'Une nouvelle campagne pour tester SBT - Reservation a été créée',1,11,2),(16,'pcreunion','<h2>SBT - Reservation simple (2 adultes, no options)</h2><b>pcreunion</b> a échoué à passer le step  : SBT - Aller sur l\'écran Nouvelle Reservation<br/><p>ca marche pas</p><br/>Pour accéder directement à la campagne <a href=\'https://specifyit.dev.it.int:8181/specify-it//campaign/v/11\'>Cliquez là</a>','2012-11-05 14:24:40','2012-11-05 14:24:40','STEP_FAILED',NULL,'Nouvelle campagne - Un test a échoué',1,11,2),(17,'pcreunion','<h2>SBT - Reservation simple (2 adultes, no options)</h2><h3>SBT - Aller sur l\'écran Nouvelle Reservation</h3><b>pcreunion</b> a ajouté le commentaire suivant : <br/><p>plus dinfos</p><br/>Pour accéder directement à la campagne <a href=\'https://specifyit.dev.it.int:8181/specify-it//campaign/v/11\'>Cliquez là</a>','2012-11-05 14:25:51','2012-11-05 14:25:51','NEW_COMMENT',NULL,'Nouvelle campagne - Un nouveau commentaire a été ajouté',1,11,2),(18,'pcreunion','<b>null</b> a créé la campagne suivante : <br/><h2>s70 bw - SBT - Reservation - SAFARI - FR</h2><p>null</p><br/>Elle est affectée à <b>smarechal</b>.<br/>Pour acceder directement à la campagne <a href=\'https://specifyit.dev.it.int:8181/specify-it//campaign/v/12\'>Cliquez là</a>','2012-11-05 14:35:19','2012-11-05 14:35:19','NEW_CAMPAIGN',NULL,'Une nouvelle campagne pour tester SBT - Reservation a été créée',1,12,2),(19,'pcreunion','<b>null</b> a créé la campagne suivante : <br/><h2>s70 bw - SBT - Reservation - IE6 - FR</h2><p>null</p><br/>Elle est affectée à <b>smarechal</b>.<br/>Pour acceder directement à la campagne <a href=\'https://specifyit.dev.it.int:8181/specify-it//campaign/v/13\'>Cliquez là</a>','2012-11-05 14:35:19','2012-11-05 14:35:19','NEW_CAMPAIGN',NULL,'Une nouvelle campagne pour tester SBT - Reservation a été créée',1,13,2),(20,'pcreunion','<b>null</b> a créé la campagne suivante : <br/><h2>s70 bw - SBT - Reservation - IE7 - FR</h2><p>null</p><br/>Elle est affectée à <b>smarechal</b>.<br/>Pour acceder directement à la campagne <a href=\'https://specifyit.dev.it.int:8181/specify-it//campaign/v/14\'>Cliquez là</a>','2012-11-05 14:35:19','2012-11-05 14:35:19','NEW_CAMPAIGN',NULL,'Une nouvelle campagne pour tester SBT - Reservation a été créée',1,14,2),(21,'jganovelli','<h2>premier scenario (test)</h2><b>jganovelli</b> a échoué à passer le step  : premier step (test)<br/><p>test</p><br/>Pour accéder directement à la campagne <a href=\'https://specifyit.dev.it.int:8181/specify-it//campaign/v/1\'>Cliquez là</a>','2012-11-13 19:06:11','2012-11-13 19:06:11','STEP_FAILED',NULL,'premiere campagne (test) - Un test a échoué',1,1,1);
/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scenario_step`
--

DROP TABLE IF EXISTS `scenario_step`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scenario_step` (
  `num_order` int(11) NOT NULL,
  `id_scenario` bigint(20) NOT NULL,
  `id_step` bigint(20) NOT NULL,
  PRIMARY KEY (`num_order`,`id_scenario`,`id_step`),
  KEY `FK_scenario_step_id_step` (`id_step`),
  KEY `FK_scenario_step_id_scenario` (`id_scenario`),
  CONSTRAINT `FK_scenario_step_id_scenario` FOREIGN KEY (`id_scenario`) REFERENCES `scenario` (`id_scenario`),
  CONSTRAINT `FK_scenario_step_id_step` FOREIGN KEY (`id_step`) REFERENCES `step` (`id_step`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scenario_step`
--

LOCK TABLES `scenario_step` WRITE;
/*!40000 ALTER TABLE `scenario_step` DISABLE KEYS */;
INSERT INTO `scenario_step` VALUES (1,1,1),(1,2,2),(1,3,2),(1,4,2),(2,2,3),(2,3,3),(2,4,3),(3,2,4),(3,3,4),(3,4,4);
/*!40000 ALTER TABLE `scenario_step` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id_user` bigint(20) NOT NULL AUTO_INCREMENT,
  `creat_by` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `dt_creat` datetime DEFAULT NULL,
  `dt_modif` datetime DEFAULT NULL,
  `modif_by` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `VERSION` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'system',NULL,'2012-10-23 13:53:35','2012-10-23 13:53:35',NULL,'gbougeard',1),(2,'system',NULL,'2012-10-26 17:27:25','2012-10-26 17:27:25',NULL,'smarechal',1),(3,'system',NULL,'2012-10-31 17:37:47','2012-10-31 17:37:47',NULL,'akeiflin',1),(4,'system',NULL,'2012-11-02 16:10:28','2012-11-02 16:10:28',NULL,'ppomes',1),(5,'system',NULL,'2012-11-02 16:17:20','2012-11-02 16:17:20',NULL,'evila',1),(6,'system',NULL,'2012-11-05 10:12:34','2012-11-05 10:12:34',NULL,'nicolas',1),(7,'system',NULL,'2012-11-05 11:43:53','2012-11-05 11:43:53',NULL,'pcreunion',1),(8,'system',NULL,'2012-11-07 10:49:32','2012-11-07 10:49:32',NULL,'cmerida',1),(9,'system',NULL,'2012-11-07 10:55:06','2012-11-07 10:55:06',NULL,'cfage',1),(10,'system',NULL,'2012-11-07 10:56:51','2012-11-07 10:56:51',NULL,'mobadia',1),(11,'system',NULL,'2012-11-13 19:00:23','2012-11-13 19:00:23',NULL,'jganovelli',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaign`
--

DROP TABLE IF EXISTS `campaign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `campaign` (
  `id_campaign` bigint(20) NOT NULL AUTO_INCREMENT,
  `author` varchar(255) DEFAULT NULL,
  `browser` varchar(255) DEFAULT NULL,
  `creat_by` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `dt_creat` datetime DEFAULT NULL,
  `dt_modif` datetime DEFAULT NULL,
  `language` varchar(255) DEFAULT NULL,
  `modif_by` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `platform` varchar(255) DEFAULT NULL,
  `VERSION` bigint(20) DEFAULT NULL,
  `id_release` bigint(20) DEFAULT NULL,
  `id_story` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_campaign`),
  UNIQUE KEY `UNQ_campaign_0` (`name`),
  KEY `FK_campaign_id_release` (`id_release`),
  KEY `FK_campaign_id_story` (`id_story`),
  CONSTRAINT `FK_campaign_id_release` FOREIGN KEY (`id_release`) REFERENCES `releases` (`id_release`),
  CONSTRAINT `FK_campaign_id_story` FOREIGN KEY (`id_story`) REFERENCES `story` (`id_story`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign`
--

LOCK TABLES `campaign` WRITE;
/*!40000 ALTER TABLE `campaign` DISABLE KEYS */;
INSERT INTO `campaign` VALUES (1,'smarechal','FIREFOX','gbougeard','premiere campagne (test)<br/>','2012-10-29 17:09:45','2012-11-13 19:06:11','FR','jganovelli','premiere campagne (test)','PRODRIT',4,NULL,1),(2,'akeiflin','IE6',NULL,NULL,'2012-10-31 17:39:27','2012-10-31 17:39:27','FR',NULL,'test de version - Story de test - IE6 - FR','PRODRIT',1,1,1),(3,'smarechal','IE6',NULL,'','2012-10-31 17:39:27','2012-10-31 17:40:31','DE','akeiflin','test de version - Story de test - IE6 - DE','PRODRIT',2,1,1),(4,'akeiflin','FIREFOX',NULL,NULL,'2012-10-31 17:39:27','2012-11-13 19:02:03','FR','jganovelli','test de version - Story de test - FIREFOX - FR','PRODRIT',2,1,1),(5,'akeiflin','SAFARI',NULL,NULL,'2012-10-31 17:39:27','2012-10-31 17:39:27','DE',NULL,'test de version - Story de test - SAFARI - DE','PRODRIT',1,1,1),(6,'smarechal','CHROME',NULL,'','2012-10-31 17:39:27','2012-10-31 17:41:51','DE','gbougeard','test de version - Story de test - CHROME - DE','PRODRIT',2,1,1),(7,'akeiflin','FIREFOX',NULL,NULL,'2012-10-31 17:39:27','2012-10-31 17:39:27','DE',NULL,'test de version - Story de test - FIREFOX - DE','PRODRIT',1,1,1),(8,'akeiflin','SAFARI',NULL,NULL,'2012-10-31 17:39:27','2012-10-31 17:39:27','FR',NULL,'test de version - Story de test - SAFARI - FR','PRODRIT',1,1,1),(9,'akeiflin','CHROME',NULL,NULL,'2012-10-31 17:39:27','2012-10-31 17:39:27','FR',NULL,'test de version - Story de test - CHROME - FR','PRODRIT',1,1,1),(10,'akeiflin','FIREFOX','gbougeard','passe de routine sur SBT<br/>','2012-11-05 11:30:44','2012-11-05 11:30:44','FR',NULL,'Test SBT version XX','PRODRIT',1,NULL,2),(11,'akeiflin','FIREFOX','pcreunion','test de validation interne','2012-11-05 14:22:33','2012-11-05 14:23:25','FR','pcreunion','Nouvelle campagne','PRODRIT',2,NULL,2),(12,'smarechal','SAFARI',NULL,NULL,'2012-11-05 14:35:19','2012-11-05 14:35:19','FR',NULL,'s70 bw - SBT - Reservation - SAFARI - FR','PRODRIT',1,2,2),(13,'smarechal','IE6',NULL,NULL,'2012-11-05 14:35:19','2012-11-05 14:35:19','FR',NULL,'s70 bw - SBT - Reservation - IE6 - FR','PRODRIT',1,2,2),(14,'smarechal','IE7',NULL,NULL,'2012-11-05 14:35:19','2012-11-05 14:35:19','FR',NULL,'s70 bw - SBT - Reservation - IE7 - FR','PRODRIT',1,2,2),(15,NULL,'IE',NULL,NULL,NULL,NULL,'FR',NULL,'testoio - SBT - Reservation - IE - FR',NULL,NULL,NULL,2),(16,NULL,'IE',NULL,NULL,NULL,NULL,'EN',NULL,'testoio - SBT - Reservation - IE - EN',NULL,NULL,NULL,2),(17,NULL,'Chrome',NULL,NULL,NULL,NULL,'FR',NULL,'testoio - SBT - Reservation - Chrome - FR',NULL,NULL,NULL,2),(18,NULL,'Chrome',NULL,NULL,NULL,NULL,'EN',NULL,'testoio - SBT - Reservation - Chrome - EN',NULL,NULL,NULL,2),(19,NULL,'IE',NULL,NULL,NULL,NULL,'FR',NULL,'testoio - Story de test - IE - FR',NULL,NULL,NULL,1),(20,NULL,'IE',NULL,NULL,NULL,NULL,'EN',NULL,'testoio - Story de test - IE - EN',NULL,NULL,NULL,1),(21,NULL,'Chrome',NULL,NULL,NULL,NULL,'FR',NULL,'testoio - Story de test - Chrome - FR',NULL,NULL,NULL,1),(22,NULL,'Chrome',NULL,NULL,NULL,NULL,'EN',NULL,'testoio - Story de test - Chrome - EN',NULL,NULL,NULL,1),(23,NULL,'IE',NULL,NULL,NULL,NULL,'FR',NULL,'test2 - SBT - Reservation - IE - FR',NULL,NULL,NULL,2),(24,NULL,'Chrome',NULL,NULL,NULL,NULL,'FR',NULL,'test2 - SBT - Reservation - Chrome - FR',NULL,NULL,NULL,2);
/*!40000 ALTER TABLE `campaign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `step`
--

DROP TABLE IF EXISTS `step`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `step` (
  `id_step` bigint(20) NOT NULL AUTO_INCREMENT,
  `automated` tinyint(1) DEFAULT '0',
  `creat_by` varchar(255) DEFAULT NULL,
  `description` longtext,
  `dev_comment` longtext,
  `dt_creat` datetime DEFAULT NULL,
  `dt_modif` datetime DEFAULT NULL,
  `modif_by` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `step_type` varchar(255) DEFAULT NULL,
  `VERSION` bigint(20) DEFAULT NULL,
  `id_subcategory` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_step`),
  UNIQUE KEY `UNQ_step_0` (`name`),
  KEY `FK_step_id_subcategory` (`id_subcategory`),
  CONSTRAINT `FK_step_id_subcategory` FOREIGN KEY (`id_subcategory`) REFERENCES `subcategory` (`id_subcategory`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `step`
--

LOCK TABLES `step` WRITE;
/*!40000 ALTER TABLE `step` DISABLE KEYS */;
INSERT INTO `step` VALUES (1,0,'gbougeard','premier step<br/>','','2012-10-29 17:08:53','2012-10-29 17:08:53',NULL,'premier step (test)',NULL,1,1),(2,0,'gbougeard','Alelr sur la page de SBT : <br/><ul><li>pour prodrit : http://prodrit/jreservit/logonfo.do?langcode=FR&id=12</li></ul><p><br/></p><p><strong>=></strong> <strong>tous les éléments doivent bien être affichés</strong><br/></p>','','2012-11-05 11:21:11','2012-11-05 11:27:12','gbougeard','Aller sur SBT',NULL,3,2),(3,0,'gbougeard','Se logguer correctement à SBT.<br/>utiliser le compte suivant :<br/><ul><li>toto / pwd</li></ul><p><strong>=> Aucun message d\'erreur ne doit s\'afficher </strong><br/></p>','','2012-11-05 11:22:40','2012-11-05 11:26:46','gbougeard','SBT - Login success',NULL,2,2),(4,0,'gbougeard','Cliquer sur le menu \"Nouvelle Reservation\"<br/><br/><strong>=&gt; La carto flash doit se charger</strong><br/>','','2012-11-05 11:28:14','2012-11-05 11:28:14',NULL,'SBT - Aller sur l\'écran Nouvelle Reservation',NULL,1,5);
/*!40000 ALTER TABLE `step` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `story_tag`
--

DROP TABLE IF EXISTS `story_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `story_tag` (
  `id_story` bigint(20) NOT NULL,
  `id_tag` bigint(20) NOT NULL,
  PRIMARY KEY (`id_story`,`id_tag`),
  KEY `FK_story_tag_id_tag` (`id_tag`),
  CONSTRAINT `FK_story_tag_id_story` FOREIGN KEY (`id_story`) REFERENCES `story` (`id_story`),
  CONSTRAINT `FK_story_tag_id_tag` FOREIGN KEY (`id_tag`) REFERENCES `tag` (`id_tag`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `story_tag`
--

LOCK TABLES `story_tag` WRITE;
/*!40000 ALTER TABLE `story_tag` DISABLE KEYS */;
INSERT INTO `story_tag` VALUES (2,1),(2,3);
/*!40000 ALTER TABLE `story_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_group`
--

DROP TABLE IF EXISTS `user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_group` (
  `id_user` bigint(20) NOT NULL,
  `groupname` varchar(64) NOT NULL,
  UNIQUE KEY `UNQ_user_group_0` (`id_user`,`groupname`),
  CONSTRAINT `FK_user_group_id_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group`
--

LOCK TABLES `user_group` WRITE;
/*!40000 ALTER TABLE `user_group` DISABLE KEYS */;
INSERT INTO `user_group` VALUES (1,'ADMIN'),(1,'DEFAULT'),(2,'DEFAULT'),(3,'DEFAULT'),(4,'DEFAULT'),(5,'DEFAULT'),(6,'DEFAULT'),(7,'DEFAULT'),(8,'DEFAULT'),(9,'DEFAULT'),(10,'DEFAULT'),(11,'DEFAULT');
/*!40000 ALTER TABLE `user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `story_release`
--

DROP TABLE IF EXISTS `story_release`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `story_release` (
  `id_release` bigint(20) NOT NULL,
  `id_story` bigint(20) NOT NULL,
  PRIMARY KEY (`id_release`,`id_story`),
  KEY `FK_story_release_id_story` (`id_story`),
  CONSTRAINT `FK_story_release_id_release` FOREIGN KEY (`id_release`) REFERENCES `releases` (`id_release`),
  CONSTRAINT `FK_story_release_id_story` FOREIGN KEY (`id_story`) REFERENCES `story` (`id_story`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `story_release`
--

LOCK TABLES `story_release` WRITE;
/*!40000 ALTER TABLE `story_release` DISABLE KEYS */;
INSERT INTO `story_release` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `story_release` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subcategory`
--

DROP TABLE IF EXISTS `subcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subcategory` (
  `id_subcategory` bigint(20) NOT NULL AUTO_INCREMENT,
  `creat_by` varchar(255) DEFAULT NULL,
  `dt_creat` datetime DEFAULT NULL,
  `dt_modif` datetime DEFAULT NULL,
  `modif_by` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `VERSION` bigint(20) DEFAULT NULL,
  `id_category` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_subcategory`),
  UNIQUE KEY `UNQ_subcategory_0` (`name`),
  KEY `FK_subcategory_id_category` (`id_category`),
  CONSTRAINT `FK_subcategory_id_category` FOREIGN KEY (`id_category`) REFERENCES `category` (`id_category`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subcategory`
--

LOCK TABLES `subcategory` WRITE;
/*!40000 ALTER TABLE `subcategory` DISABLE KEYS */;
INSERT INTO `subcategory` VALUES (1,'gbougeard','2012-10-29 17:08:27','2012-10-29 17:08:27',NULL,'subcat1',1,1),(2,'gbougeard','2012-11-05 11:25:40','2012-11-05 11:25:40',NULL,'sbt-login-success',1,2),(3,'gbougeard','2012-11-05 11:25:50','2012-11-05 11:25:50',NULL,'sbt-login-failed',1,2),(4,'gbougeard','2012-11-05 11:26:13','2012-11-05 11:26:13',NULL,'sbt-reservation-suivi',1,3),(5,'gbougeard','2012-11-05 11:26:31','2012-11-05 11:26:31',NULL,'sbt-reservation-commun',1,3);
/*!40000 ALTER TABLE `subcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `id_category` bigint(20) NOT NULL AUTO_INCREMENT,
  `creat_by` varchar(255) DEFAULT NULL,
  `dt_creat` datetime DEFAULT NULL,
  `dt_modif` datetime DEFAULT NULL,
  `modif_by` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `VERSION` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_category`),
  UNIQUE KEY `UNQ_category_0` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'gbougeard','2012-10-29 17:08:14','2012-10-29 17:08:14',NULL,'cat1',1),(2,'gbougeard','2012-11-05 11:24:48','2012-11-05 11:24:55','gbougeard','sbt-login',2),(3,'gbougeard','2012-11-05 11:25:05','2012-11-05 11:25:05',NULL,'sbt-reservation',1);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `story`
--

DROP TABLE IF EXISTS `story`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `story` (
  `id_story` bigint(20) NOT NULL AUTO_INCREMENT,
  `creat_by` varchar(255) DEFAULT NULL,
  `dt_creat` datetime DEFAULT NULL,
  `dt_modif` datetime DEFAULT NULL,
  `in_charge` varchar(255) DEFAULT NULL,
  `jira_id` varchar(255) DEFAULT NULL,
  `modif_by` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `narrative` longtext,
  `VERSION` bigint(20) DEFAULT NULL,
  `id_role` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_story`),
  UNIQUE KEY `UNQ_story_0` (`name`),
  KEY `FK_story_id_role` (`id_role`),
  CONSTRAINT `FK_story_id_role` FOREIGN KEY (`id_role`) REFERENCES `role` (`id_role`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `story`
--

LOCK TABLES `story` WRITE;
/*!40000 ALTER TABLE `story` DISABLE KEYS */;
INSERT INTO `story` VALUES (1,'gbougeard','2012-10-29 17:07:55','2012-10-29 17:07:55','smarechal','',NULL,'Story de test','story de test initial<br/>',1,2),(2,'gbougeard','2012-11-05 11:18:31','2012-11-05 11:18:31','akeiflin','',NULL,'SBT - Reservation','Tests du module Reservation de SBT<br/>',1,3);
/*!40000 ALTER TABLE `story` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `releases`
--

DROP TABLE IF EXISTS `releases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `releases` (
  `id_release` bigint(20) NOT NULL AUTO_INCREMENT,
  `creat_by` varchar(255) DEFAULT NULL,
  `description` longtext,
  `dt_creat` datetime DEFAULT NULL,
  `dt_modif` datetime DEFAULT NULL,
  `modif_by` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `VERSION` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_release`),
  UNIQUE KEY `UNQ_releases_0` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `releases`
--

LOCK TABLES `releases` WRITE;
/*!40000 ALTER TABLE `releases` DISABLE KEYS */;
INSERT INTO `releases` VALUES (1,'gbougeard','version XXX<br/>','2012-10-31 17:39:27','2012-10-31 17:39:27',NULL,'test de version',1),(2,'pcreunion','livraison BW','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'s70 bw',1),(3,NULL,NULL,NULL,NULL,NULL,'test',NULL),(4,NULL,NULL,NULL,NULL,NULL,'tata',NULL),(5,NULL,NULL,NULL,NULL,NULL,'testoio',NULL),(6,NULL,NULL,NULL,NULL,NULL,'test2',NULL);
/*!40000 ALTER TABLE `releases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scenario`
--

DROP TABLE IF EXISTS `scenario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scenario` (
  `id_scenario` bigint(20) NOT NULL AUTO_INCREMENT,
  `creat_by` varchar(255) DEFAULT NULL,
  `description` longtext,
  `dt_creat` datetime DEFAULT NULL,
  `dt_modif` datetime DEFAULT NULL,
  `modif_by` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `VERSION` bigint(20) DEFAULT NULL,
  `id_story` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_scenario`),
  UNIQUE KEY `UNQ_scenario_0` (`name`),
  KEY `FK_scenario_id_story` (`id_story`),
  CONSTRAINT `FK_scenario_id_story` FOREIGN KEY (`id_story`) REFERENCES `story` (`id_story`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scenario`
--

LOCK TABLES `scenario` WRITE;
/*!40000 ALTER TABLE `scenario` DISABLE KEYS */;
INSERT INTO `scenario` VALUES (1,'gbougeard',NULL,'2012-10-29 17:09:14','2012-10-29 17:09:14',NULL,'premier scenario (test)',1,1),(2,'gbougeard',NULL,'2012-11-05 11:19:07','2012-11-05 11:28:39','gbougeard','SBT - Reservation simple (2 adultes, no options)',2,2),(3,'gbougeard','null-CLONED','2012-11-05 11:31:54','2012-11-05 11:31:54',NULL,'SBT - Reservation simple avec enfants (2 adultes, 1 enfant > 3 ans no options)',1,2),(4,'pcreunion','null-CLONED','2012-11-05 14:19:57','2012-11-05 14:19:57',NULL,'SBT - Reservation simple (2 adultes, no options)-CLONED',1,2);
/*!40000 ALTER TABLE `scenario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screenshot`
--

DROP TABLE IF EXISTS `screenshot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `screenshot` (
  `id_screenshot` bigint(20) NOT NULL AUTO_INCREMENT,
  `creat_by` varchar(255) DEFAULT NULL,
  `dt_creat` datetime DEFAULT NULL,
  `dt_modif` datetime DEFAULT NULL,
  `modif_by` varchar(255) DEFAULT NULL,
  `VERSION` bigint(20) DEFAULT NULL,
  `id_comment` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_screenshot`),
  KEY `FK_screenshot_id_comment` (`id_comment`),
  CONSTRAINT `FK_screenshot_id_comment` FOREIGN KEY (`id_comment`) REFERENCES `comment` (`id_comment`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screenshot`
--

LOCK TABLES `screenshot` WRITE;
/*!40000 ALTER TABLE `screenshot` DISABLE KEYS */;
INSERT INTO `screenshot` VALUES (1,'gbougeard','2012-10-29 17:10:15','2012-10-29 17:10:15',NULL,1,NULL),(2,'gbougeard','2012-10-29 17:14:12','2012-10-29 17:14:12',NULL,1,NULL),(3,'smarechal','2012-10-29 17:25:00','2012-10-29 17:25:00',NULL,1,1),(4,'smarechal','2012-10-29 17:25:13','2012-10-29 17:25:13',NULL,1,2),(5,'smarechal','2012-10-29 17:25:29','2012-10-29 17:25:29',NULL,1,2),(6,'gbougeard','2012-10-29 17:27:01','2012-10-29 17:27:01',NULL,1,3),(7,'gbougeard','2012-10-29 15:37:11','2012-10-29 15:37:11',NULL,1,4);
/*!40000 ALTER TABLE `screenshot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_step`
--

DROP TABLE IF EXISTS `test_step`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_step` (
  `id_test_step` bigint(20) NOT NULL AUTO_INCREMENT,
  `creat_by` varchar(255) DEFAULT NULL,
  `dt_creat` datetime DEFAULT NULL,
  `dt_modif` datetime DEFAULT NULL,
  `modif_by` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `VERSION` bigint(20) DEFAULT NULL,
  `id_campaign` bigint(20) DEFAULT NULL,
  `id_step` bigint(20) DEFAULT NULL,
  `num_order` int(11) DEFAULT NULL,
  `id_scenario` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_test_step`),
  KEY `FK_test_step_id_campaign` (`id_campaign`),
  KEY `FK_test_step_num_order` (`num_order`,`id_scenario`,`id_step`),
  CONSTRAINT `FK_test_step_id_campaign` FOREIGN KEY (`id_campaign`) REFERENCES `campaign` (`id_campaign`),
  CONSTRAINT `FK_test_step_num_order` FOREIGN KEY (`num_order`, `id_scenario`, `id_step`) REFERENCES `scenario_step` (`num_order`, `id_scenario`, `id_step`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_step`
--

LOCK TABLES `test_step` WRITE;
/*!40000 ALTER TABLE `test_step` DISABLE KEYS */;
INSERT INTO `test_step` VALUES (1,'smarechal','2012-10-29 17:09:45','2012-11-13 19:06:11','jganovelli','KO',6,1,1,1,1),(2,'akeiflin','2012-10-31 17:39:27','2012-11-13 19:02:03','jganovelli','OK',2,4,1,1,1),(3,'akeiflin','2012-10-31 17:39:27','2012-10-31 17:39:27',NULL,'PENDING',1,3,1,1,1),(4,'akeiflin','2012-10-31 17:39:27','2012-10-31 17:39:27',NULL,'PENDING',1,5,1,1,1),(5,'akeiflin','2012-10-31 17:39:27','2012-10-31 17:39:27',NULL,'PENDING',1,8,1,1,1),(6,'akeiflin','2012-10-31 17:39:27','2012-10-31 17:39:27',NULL,'PENDING',1,9,1,1,1),(7,'akeiflin','2012-10-31 17:39:27','2012-10-31 17:39:27',NULL,'PENDING',1,2,1,1,1),(8,'akeiflin','2012-10-31 17:39:27','2012-10-31 17:39:27',NULL,'PENDING',1,7,1,1,1),(9,'akeiflin','2012-10-31 17:39:27','2012-10-31 17:39:27',NULL,'PENDING',1,6,1,1,1),(10,'akeiflin','2012-11-05 11:30:44','2012-11-05 11:30:44',NULL,'PENDING',1,10,2,1,2),(11,'akeiflin','2012-11-05 11:30:44','2012-11-05 11:30:44',NULL,'PENDING',1,10,3,2,2),(12,'akeiflin','2012-11-05 11:30:44','2012-11-05 11:30:44',NULL,'PENDING',1,10,4,3,2),(13,'akeiflin','2012-11-05 14:22:34','2012-11-05 14:23:40','pcreunion','OK',2,11,3,2,2),(14,'akeiflin','2012-11-05 14:22:34','2012-11-05 14:22:34',NULL,'PENDING',1,11,4,3,4),(15,'akeiflin','2012-11-05 14:22:34','2012-11-05 14:22:34',NULL,'PENDING',1,11,3,2,3),(16,'akeiflin','2012-11-05 14:22:34','2012-11-05 14:22:34',NULL,'PENDING',1,11,4,3,3),(17,'akeiflin','2012-11-05 14:22:34','2012-11-05 14:22:34',NULL,'PENDING',1,11,2,1,3),(18,'akeiflin','2012-11-05 14:22:34','2012-11-05 14:25:51','pcreunion','KO',3,11,4,3,2),(19,'akeiflin','2012-11-05 14:22:34','2012-11-05 14:22:34',NULL,'PENDING',1,11,2,1,4),(20,'akeiflin','2012-11-05 14:22:34','2012-11-05 14:23:25','pcreunion','OK',2,11,2,1,2),(21,'akeiflin','2012-11-05 14:22:34','2012-11-05 14:22:34',NULL,'PENDING',1,11,3,2,4),(22,'smarechal','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'PENDING',1,12,3,2,3),(23,'smarechal','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'PENDING',1,14,2,1,4),(24,'smarechal','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'OK',1,12,2,1,2),(25,'smarechal','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'PENDING',1,12,3,2,2),(26,'smarechal','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'PENDING',1,13,3,2,2),(27,'smarechal','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'PENDING',1,13,3,2,3),(28,'smarechal','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'PENDING',1,13,3,2,4),(29,'smarechal','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'PENDING',1,12,2,1,4),(30,'smarechal','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'PENDING',1,13,2,1,2),(31,'smarechal','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'PENDING',1,14,2,1,2),(32,'smarechal','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'PENDING',1,12,4,3,4),(33,'smarechal','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'PENDING',1,14,4,3,4),(34,'smarechal','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'PENDING',1,12,2,1,3),(35,'smarechal','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'PENDING',1,12,3,2,4),(36,'smarechal','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'PENDING',1,14,3,2,3),(37,'smarechal','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'PENDING',1,13,2,1,4),(38,'smarechal','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'PENDING',1,13,4,3,4),(39,'smarechal','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'PENDING',1,13,4,3,3),(40,'smarechal','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'PENDING',1,14,3,2,2),(41,'smarechal','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'PENDING',1,12,4,3,3),(42,'smarechal','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'PENDING',1,13,4,3,2),(43,'smarechal','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'PENDING',1,14,3,2,4),(44,'smarechal','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'PENDING',1,14,4,3,3),(45,'smarechal','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'PENDING',1,14,2,1,3),(46,'smarechal','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'PENDING',1,14,4,3,2),(47,'smarechal','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'PENDING',1,13,2,1,3),(48,'smarechal','2012-11-05 14:35:19','2012-11-05 14:35:19',NULL,'PENDING',1,12,4,3,2);
/*!40000 ALTER TABLE `test_step` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag` (
  `id_tag` bigint(20) NOT NULL AUTO_INCREMENT,
  `creat_by` varchar(255) DEFAULT NULL,
  `dt_creat` datetime DEFAULT NULL,
  `dt_modif` datetime DEFAULT NULL,
  `modif_by` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `VERSION` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_tag`),
  UNIQUE KEY `UNQ_tag_0` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES (1,'gbougeard','2012-10-23 14:04:55','2012-10-23 14:04:55',NULL,'front',1),(2,'gbougeard','2012-10-23 14:04:59','2012-10-23 14:04:59',NULL,'back',1),(3,'gbougeard','2012-10-23 14:05:04','2012-10-23 14:05:04',NULL,'sbt',1);
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id_role` bigint(20) NOT NULL AUTO_INCREMENT,
  `creat_by` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `dt_creat` datetime DEFAULT NULL,
  `dt_modif` datetime DEFAULT NULL,
  `modif_by` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `VERSION` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_role`),
  UNIQUE KEY `UNQ_role_0` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'gbougeard',NULL,'2012-10-23 14:04:37','2012-10-23 14:04:37',NULL,'pms',1),(2,'gbougeard',NULL,'2012-10-23 14:04:43','2012-10-23 14:04:43',NULL,'hotelier',1),(3,'gbougeard',NULL,'2012-10-23 14:04:48','2012-10-23 14:04:48',NULL,'pax',1);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `play_evolutions`
--

DROP TABLE IF EXISTS `play_evolutions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `play_evolutions` (
  `id` int(11) NOT NULL,
  `hash` varchar(255) NOT NULL,
  `applied_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `apply_script` text,
  `revert_script` text,
  `state` varchar(255) DEFAULT NULL,
  `last_problem` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `play_evolutions`
--

LOCK TABLES `play_evolutions` WRITE;
/*!40000 ALTER TABLE `play_evolutions` DISABLE KEYS */;
INSERT INTO `play_evolutions` VALUES (1,'bc4791aff2c3cb432bdba78b361403eacab61c69','2013-01-22 20:50:17','create table `releases` (`id_release` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,`name` VARCHAR(254) NOT NULL,`description` VARCHAR(254) NOT NULL);\n\ncreate table `story` (`id_story` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,`name` VARCHAR(254) NOT NULL,`narrative` VARCHAR(254) NOT NULL);\n\ncreate table `tag` (`id_tag` BIGINT NOT NULL PRIMARY KEY,`lib_tag` VARCHAR(254) NOT NULL);\n\ncreate table `story_release` (`id_story` BIGINT NOT NULL PRIMARY KEY,`id_release` BIGINT NOT NULL PRIMARY KEY);\nalter table `story_release` add constraint `STORY_FK` foreign key(`id_story`) references `story`(`id_story`) on update NO ACTION on delete NO ACTION;\nalter table `story_release` add constraint `RELEASE_FK` foreign key(`id_release`) references `releases`(`id_release`) on update NO ACTION on delete NO ACTION;\n\ncreate table `test_step` (`id_test_step` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,`num_order` INTEGER NOT NULL,`status` VARCHAR(254) NOT NULL,`id_step` BIGINT NOT NULL,`id_scenario` BIGINT NOT NULL,`id_campaign` BIGINT NOT NULL);\nalter table `test_step` add constraint `CAMPAIGN_FK` foreign key(`id_campaign`) references `campaign`(`id_campaign`) on update NO ACTION on delete NO ACTION;\nalter table `test_step` add constraint `SCENARIO_FK` foreign key(`id_scenario`) references `scenario`(`id_scenario`) on update NO ACTION on delete NO ACTION;\nalter table `test_step` add constraint `STEP_FK` foreign key(`id_step`) references `step`(`id_step`) on update NO ACTION on delete NO ACTION;\n\ncreate table `step` (`id_step` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,`name` VARCHAR(254) NOT NULL,`description` VARCHAR(254) NOT NULL);\n\ncreate table `campaign` (`id_campaign` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,`name` VARCHAR(254) NOT NULL,`description` VARCHAR(254) NOT NULL,`browser` VARCHAR(254) NOT NULL,`language` VARCHAR(254) NOT NULL,`id_story` BIGINT NOT NULL,`id_release` BIGINT NOT NULL);\nalter table `campaign` add constraint `STORY_FK` foreign key(`id_story`) references `story`(`id_story`) on update NO ACTION on delete NO ACTION;\nalter table `campaign` add constraint `RELEASE_FK` foreign key(`id_release`) references `releases`(`id_release`) on update NO ACTION on delete NO ACTION;\n\ncreate table `scenario_step` (`id_scenario` BIGINT NOT NULL PRIMARY KEY,`id_step` BIGINT NOT NULL PRIMARY KEY,`num_order` INTEGER NOT NULL);\nalter table `scenario_step` add constraint `SCENARIO_FK` foreign key(`id_scenario`) references `scenario`(`id_scenario`) on update NO ACTION on delete NO ACTION;\nalter table `scenario_step` add constraint `STEP_FK` foreign key(`id_step`) references `step`(`id_step`) on update NO ACTION on delete NO ACTION;\n\ncreate table `scenario` (`id_scenario` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,`name` VARCHAR(254) NOT NULL,`description` VARCHAR(254) NOT NULL,`id_story` BIGINT NOT NULL);\nalter table `scenario` add constraint `STORY_FK` foreign key(`id_story`) references `story`(`id_story`) on update NO ACTION on delete NO ACTION;\n\ncreate table `comment` (`id_comment` BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,`creat_by` VARCHAR(254) NOT NULL,`texte` VARCHAR(254) NOT NULL,`id_test_step` BIGINT NOT NULL,`dt_creat` TIMESTAMP NOT NULL);\nalter table `comment` add constraint `TEST_STEP_FK` foreign key(`id_test_step`) references `test_step`(`id_test_step`) on update NO ACTION on delete NO ACTION;','drop table `tag`;\n\nALTER TABLE scenario DROP FOREIGN KEY STORY_FK;\ndrop table `scenario`;\n\nALTER TABLE scenario_step DROP FOREIGN KEY SCENARIO_FK;\nALTER TABLE scenario_step DROP FOREIGN KEY STEP_FK;\ndrop table `scenario_step`;\n\nALTER TABLE story_release DROP FOREIGN KEY STORY_FK;\nALTER TABLE story_release DROP FOREIGN KEY RELEASE_FK;\ndrop table `story_release`;\n\ndrop table `releases`;\n\nALTER TABLE test_step DROP FOREIGN KEY CAMPAIGN_FK;\nALTER TABLE test_step DROP FOREIGN KEY SCENARIO_FK;\nALTER TABLE test_step DROP FOREIGN KEY STEP_FK;\ndrop table `test_step`;\n\nALTER TABLE comment DROP FOREIGN KEY TEST_STEP_FK;\ndrop table `comment`;\n\ndrop table `step`;\n\ndrop table `story`;\n\nALTER TABLE campaign DROP FOREIGN KEY STORY_FK;\nALTER TABLE campaign DROP FOREIGN KEY RELEASE_FK;\ndrop table `campaign`;','applied','Table \'releases\' already exists [ERROR:1050, SQLSTATE:42S01]');
/*!40000 ALTER TABLE `play_evolutions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-02-07 18:33:28
