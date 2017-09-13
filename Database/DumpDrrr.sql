CREATE DATABASE  IF NOT EXISTS `drrr` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `drrr`;
-- MySQL dump 10.13  Distrib 5.5.57, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: drrr
-- ------------------------------------------------------
-- Server version	5.5.57-0+deb8u1

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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `id` int(10) unsigned NOT NULL,
  `level` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  CONSTRAINT `id` FOREIGN KEY (`id`) REFERENCES `utenti` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabella contenente gli admin di drrr ed il loro livello di potere.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,1),(6,1);
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commenti`
--

DROP TABLE IF EXISTS `commenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commenti` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_screen` int(10) unsigned NOT NULL,
  `id_utente` int(10) unsigned NOT NULL,
  `commento` varchar(140) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commenti`
--

LOCK TABLES `commenti` WRITE;
/*!40000 ALTER TABLE `commenti` DISABLE KEYS */;
INSERT INTO `commenti` VALUES (1,1,1,'Questo è un commento.'),(2,1,1,'Ma anche questo è un commento cazzo.'),(3,2,1,'YEEEEHAHAHAHAH.'),(4,3,1,'Provaprovaprova ma cosa proverò mai tanto non fa.'),(5,7,1,'UN POLLOOOO. \r\nma porco Ã²Ã Ã Ã².'),(6,6,1,'asdasdasd'),(7,6,1,'WE WE SO NO SPAMMER WUAGLÃ².'),(8,51,1,'Queste sadDineh');
/*!40000 ALTER TABLE `commenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `info_screen`
--

DROP TABLE IF EXISTS `info_screen`;
/*!50001 DROP VIEW IF EXISTS `info_screen`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `info_screen` (
  `numero` tinyint NOT NULL,
  `src` tinyint NOT NULL,
  `nome` tinyint NOT NULL,
  `pic` tinyint NOT NULL,
  `descrizione` tinyint NOT NULL,
  `data` tinyint NOT NULL,
  `titolo` tinyint NOT NULL,
  `n_like` tinyint NOT NULL,
  `n_dislike` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `info_user`
--

DROP TABLE IF EXISTS `info_user`;
/*!50001 DROP VIEW IF EXISTS `info_user`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `info_user` (
  `nome` tinyint NOT NULL,
  `pic` tinyint NOT NULL,
  `punti` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `like_screen`
--

DROP TABLE IF EXISTS `like_screen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `like_screen` (
  `id_user` int(10) unsigned NOT NULL,
  `id_screen` int(10) unsigned NOT NULL,
  `voto` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_user`,`id_screen`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `like_screen`
--

LOCK TABLES `like_screen` WRITE;
/*!40000 ALTER TABLE `like_screen` DISABLE KEYS */;
INSERT INTO `like_screen` VALUES (1,0,1),(1,1,1),(1,2,1),(1,3,1),(1,5,1),(1,13,1),(1,26,1),(1,27,1),(1,40,1),(1,51,1),(1,64,1),(1,65,1),(1,128,0),(1,141,1),(1,142,1),(8,0,0),(8,51,1),(8,64,0),(8,115,1),(11,1,1),(37,1,0),(37,2,1),(37,3,1),(37,4,1);
/*!40000 ALTER TABLE `like_screen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `s_dislike`
--

DROP TABLE IF EXISTS `s_dislike`;
/*!50001 DROP VIEW IF EXISTS `s_dislike`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `s_dislike` (
  `id_screen` tinyint NOT NULL,
  `n_dislike` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `s_like`
--

DROP TABLE IF EXISTS `s_like`;
/*!50001 DROP VIEW IF EXISTS `s_like`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `s_like` (
  `id_screen` tinyint NOT NULL,
  `n_like` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `screen`
--

DROP TABLE IF EXISTS `screen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `screen` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET latin1 NOT NULL,
  `id_utente` int(10) unsigned NOT NULL,
  `commento` varchar(140) CHARACTER SET latin1 DEFAULT NULL,
  `data` datetime NOT NULL DEFAULT '2016-11-26 12:00:00',
  `titolo` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8 COMMENT='tabella degli screen.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screen`
--

LOCK TABLES `screen` WRITE;
/*!40000 ALTER TABLE `screen` DISABLE KEYS */;
INSERT INTO `screen` VALUES (1,'YumeMangiaFrancesi.PNG',1,NULL,'2016-11-26 12:00:00',''),(2,'Droga.PNG',1,'','2016-11-26 12:00:00',''),(3,'231.PNG',1,NULL,'2016-11-26 12:00:00',''),(4,'324.PNG',1,NULL,'2016-11-26 12:00:00',''),(5,'4yyura.PNG',1,NULL,'2016-11-26 12:00:00',''),(6,'aa1asdCattura.PNG',1,NULL,'2016-11-26 12:00:00',''),(7,'ag34ttsgd3ura.PNG',1,NULL,'2016-11-26 12:00:00',''),(8,'AmbiguitU.PNG',1,NULL,'2016-11-26 12:00:00',''),(9,'autoscreen.PNG',1,NULL,'2016-11-26 12:00:00',''),(10,'BadBadShiz.PNG',1,NULL,'2016-11-26 12:00:00',''),(11,'BadCoco.PNG',1,NULL,'2016-11-26 12:00:00',''),(12,'BadShiz999.PNG',1,NULL,'2016-11-26 12:00:00',''),(13,'BadTop.PNG',1,NULL,'2016-11-26 12:00:00',''),(14,'Ballo.PNG',1,NULL,'2016-11-26 12:00:00',''),(15,'BibbiaRP.PNG',1,NULL,'2016-11-26 12:00:00',''),(16,'BlutGGPene.PNG',1,NULL,'2016-11-26 12:00:00',''),(17,'Blut_Nipoti.PNG',1,NULL,'2016-11-26 12:00:00',''),(18,'bossIgnoraWoodstock.PNG',1,NULL,'2016-11-26 12:00:00',''),(19,'Cadfgdfgttura.PNG',1,NULL,'2016-11-26 12:00:00',''),(20,'Casdfttura.PNG',1,NULL,'2016-11-26 12:00:00',''),(21,'Catadftura.PNG',1,NULL,'2016-11-26 12:00:00',''),(22,'Catdfgjdfgjtura.PNG',1,NULL,'2016-11-26 12:00:00',''),(23,'Catt345345ura.PNG',1,NULL,'2016-11-26 12:00:00',''),(24,'Cattasdasdtopura.PNG',1,NULL,'2016-11-26 12:00:00',''),(25,'Cattfghura.PNG',1,NULL,'2016-11-26 12:00:00',''),(26,'Cattop2tura.PNG',1,NULL,'2016-11-26 12:00:00',''),(27,'Cattsdfsdfura.PNG',1,NULL,'2016-11-26 12:00:00',''),(28,'Catttopura.PNG',1,NULL,'2016-11-26 12:00:00',''),(29,'Cattu45ra.PNG',1,NULL,'2016-11-26 12:00:00',''),(30,'Cattucgjhra.PNG',1,NULL,'2016-11-26 12:00:00',''),(31,'Cattur65ujya.PNG',1,NULL,'2016-11-26 12:00:00',''),(32,'Cattura34G.PNG',1,NULL,'2016-11-26 12:00:00',''),(33,'Cattura34GT.PNG',1,NULL,'2016-11-26 12:00:00',''),(34,'Cattura34T.PNG',1,NULL,'2016-11-26 12:00:00',''),(35,'Cattura3.PNG',1,NULL,'2016-11-26 12:00:00',''),(36,'Cattura555G.PNG',1,NULL,'2016-11-26 12:00:00',''),(37,'Cattura55.PNG',1,NULL,'2016-11-26 12:00:00',''),(38,'Cattura56.PNG',1,NULL,'2016-11-26 12:00:00',''),(39,'CatturaA.PNG',1,NULL,'2016-11-26 12:00:00',''),(40,'CatturaK.PNG',1,NULL,'2016-11-26 12:00:00',''),(41,'CatturaSDF.PNG',1,NULL,'2016-11-26 12:00:00',''),(42,'CatturaSF4W4.PNG',1,NULL,'2016-11-26 12:00:00',''),(43,'CatturDFR.PNG',1,NULL,'2016-11-26 12:00:00',''),(44,'yyy.PNG',1,NULL,'2016-11-26 12:00:00',''),(45,'chat_sballona.PNG',1,NULL,'2016-11-26 12:00:00',''),(46,'Cinderalla.PNG',1,NULL,'2016-11-26 12:00:00',''),(47,'classic.PNG',1,NULL,'2016-11-26 12:00:00',''),(48,'ComboX2.PNG',1,NULL,'2016-11-26 12:00:00',''),(49,'Cwgerra.PNG',1,NULL,'2016-11-26 12:00:00',''),(50,'dichiarazioni.PNG',1,NULL,'2016-11-26 12:00:00',''),(51,'DinahMuore.PNG',1,NULL,'2016-11-26 12:00:00',''),(52,'Dookie-Galera.PNG',1,NULL,'2016-11-26 12:00:00',''),(53,'Droga0.PNG',1,NULL,'2016-11-26 12:00:00',''),(54,'1234567ttura.PNG',1,'Una potty molto curiosa scopre delle polveri magiche.','2016-11-26 12:00:00',''),(55,'dsfdsfg.PNG',1,NULL,'2016-11-26 12:00:00',''),(56,'dwweg.PNG',1,NULL,'2016-11-26 12:00:00',''),(57,'epic1.PNG',1,NULL,'2016-11-26 12:00:00',''),(58,'Epico007.PNG',1,NULL,'2016-11-26 12:00:00',''),(59,'epico.PNG',1,NULL,'2016-11-26 12:00:00',''),(60,'ErrorFriz.PNG',1,NULL,'2016-11-26 12:00:00',''),(61,'evocazione.PNG',1,NULL,'2016-11-26 12:00:00',''),(62,'Festaioli.PNG',1,NULL,'2016-11-26 12:00:00',''),(63,'gem2.PNG',1,NULL,'2016-11-26 12:00:00',''),(64,'gemelles.PNG',1,NULL,'2016-11-26 12:00:00',''),(65,'gfhjtop.PNG',1,NULL,'2016-11-26 12:00:00',''),(66,'HitFFMuss.PNG',1,NULL,'2016-11-26 12:00:00',''),(67,'HUB.PNG',1,NULL,'2016-11-26 12:00:00',''),(68,'idexolino2.PNG',1,NULL,'2016-11-26 12:00:00',''),(69,'idexolino.PNG',1,NULL,'2016-11-26 12:00:00',''),(70,'ImpoAlone.PNG',1,NULL,'2016-11-26 12:00:00',''),(71,'ImpoPietra.PNG',1,NULL,'2016-11-26 12:00:00',''),(72,'Inopportuno.PNG',1,NULL,'2016-11-26 12:00:00',''),(73,'Irish.PNG',1,NULL,'2016-11-26 12:00:00',''),(74,'KrisTTporno.PNG',1,NULL,'2016-11-26 12:00:00',''),(75,'lavapiatti.PNG',1,NULL,'2016-11-26 12:00:00',''),(76,'legend.PNG',1,NULL,'2016-11-26 12:00:00',''),(77,'MegaMomo.PNG',1,NULL,'2016-11-26 12:00:00',''),(78,'MeTTSai.PNG',1,NULL,'2016-11-26 12:00:00',''),(79,'MidiCoca.PNG',1,NULL,'2016-11-26 12:00:00',''),(80,'MidiCom.PNG',1,NULL,'2016-11-26 12:00:00',''),(81,'MilaneseDoc.PNG',1,NULL,'2016-11-26 12:00:00',''),(82,'mission.PNG',1,NULL,'2016-11-26 12:00:00',''),(83,'Mistero.PNG',1,NULL,'2016-11-26 12:00:00',''),(84,'Misure.PNG',1,NULL,'2016-11-26 12:00:00',''),(85,'MokaTruzza.PNG',1,NULL,'2016-11-26 12:00:00',''),(86,'NASODURO.PNG',1,NULL,'2016-11-26 12:00:00',''),(87,'NaziShiz.PNG',1,NULL,'2016-11-26 12:00:00',''),(88,'NewOldTime.PNG',1,NULL,'2016-11-26 12:00:00',''),(89,'oak.PNG',1,NULL,'2016-11-26 12:00:00',''),(90,'Odio.PNG',1,NULL,'2016-11-26 12:00:00',''),(91,'Orpheus_Colpisce_Ancora.PNG',1,NULL,'2016-11-26 12:00:00',''),(92,'PEdofiliaLV2.PNG',1,NULL,'2016-11-26 12:00:00',''),(93,'Polacche.PNG',1,NULL,'2016-11-26 12:00:00',''),(94,'PolandShiz.PNG',1,NULL,'2016-11-26 12:00:00',''),(95,'PolloDinah.PNG',1,NULL,'2016-11-26 12:00:00',''),(96,'poorKris5.PNG',1,NULL,'2016-11-26 12:00:00',''),(97,'PresaFacile2.PNG',1,NULL,'2016-11-26 12:00:00',''),(98,'PresaFacile.PNG',1,NULL,'2016-11-26 12:00:00',''),(99,'Problemi_DiLino.PNG',1,NULL,'2016-11-26 12:00:00',''),(100,'YumeAcidella.PNG',1,NULL,'2016-11-26 12:00:00',''),(101,'Ridicolous.PNG',1,NULL,'2016-11-26 12:00:00',''),(102,'Riflessioni_serali.PNG',1,NULL,'2016-11-26 12:00:00',''),(103,'SaiAssassino.PNG',1,NULL,'2016-11-26 12:00:00',''),(104,'SaiNonSa.PNG',1,NULL,'2016-11-26 12:00:00',''),(105,'Sais_Love.PNG',1,NULL,'2016-11-26 12:00:00',''),(106,'scem1.PNG',1,NULL,'2016-11-26 12:00:00',''),(107,'scem2.PNG',1,NULL,'2016-11-26 12:00:00',''),(108,'scem3.PNG',1,NULL,'2016-11-26 12:00:00',''),(109,'scem4.PNG',1,NULL,'2016-11-26 12:00:00',''),(110,'scem5.PNG',1,NULL,'2016-11-26 12:00:00',''),(111,'scem6.PNG',1,NULL,'2016-11-26 12:00:00',''),(112,'scem7.PNG',1,NULL,'2016-11-26 12:00:00',''),(113,'scemaaa.PNG',1,NULL,'2016-11-26 12:00:00',''),(114,'SefMania2015.PNG',1,NULL,'2016-11-26 12:00:00',''),(115,'sef.PNG',1,NULL,'2016-11-26 12:00:00',''),(116,'SexySai.PNG',1,NULL,'2016-11-26 12:00:00',''),(117,'Shiz_at.PNG',1,NULL,'2016-11-26 12:00:00',''),(118,'shiz_grassa.PNG',1,NULL,'2016-11-26 12:00:00',''),(119,'Shiz_Scimmia.PNG',1,NULL,'2016-11-26 12:00:00',''),(120,'ShizuDook.PNG',1,NULL,'2016-11-26 12:00:00',''),(121,'ShizuTOP2.PNG',1,NULL,'2016-11-26 12:00:00',''),(122,'ShizuTOP.PNG',1,NULL,'2016-11-26 12:00:00',''),(123,'shizutrans.PNG',1,NULL,'2016-11-26 12:00:00',''),(124,'SignoraTop.PNG',1,NULL,'2016-11-26 12:00:00',''),(125,'Soc.PNG',1,NULL,'2016-11-26 12:00:00',''),(126,'ssdgf.PNG',1,NULL,'2016-11-26 12:00:00',''),(127,'ssghf.PNG',1,NULL,'2016-11-26 12:00:00',''),(128,'TheEnd.PNG',1,NULL,'2016-11-26 12:00:00',''),(129,'Tiziananonmivuolebene.PNG',1,NULL,'2016-11-26 12:00:00',''),(130,'tONIA.PNG',1,NULL,'2016-11-26 12:00:00',''),(131,'TopSatana2.PNG',1,NULL,'2016-11-26 12:00:00',''),(132,'TopSatana.PNG',1,NULL,'2016-11-26 12:00:00',''),(133,'tradimento.PNG',1,NULL,'2016-11-26 12:00:00',''),(134,'TuttiOdianoDama2.PNG',1,NULL,'2016-11-26 12:00:00',''),(135,'TuttiOdianoDama.PNG',1,NULL,'2016-11-26 12:00:00',''),(136,'WabiAmbigua1.PNG',1,NULL,'2016-11-26 12:00:00',''),(137,'WabiAmbigua.PNG',1,NULL,'2016-11-26 12:00:00',''),(138,'WabiFrancese.PNG',1,NULL,'2016-11-26 12:00:00',''),(139,'WabiSNoobba.PNG',1,NULL,'2016-11-26 12:00:00',''),(140,'140.png',1,'Giove e le sue motivazioni molto valide.','2016-11-27 22:18:00',''),(141,'141.png',1,'Orpheus abbandona la preda.','2016-11-27 22:19:00',''),(142,'142.png',1,'Le tristi convinzioni di Sai.','2016-11-29 18:51:00','');
/*!40000 ALTER TABLE `screen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screen_vote`
--

DROP TABLE IF EXISTS `screen_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `screen_vote` (
  `id_utente` int(10) unsigned NOT NULL,
  `id_screen` int(10) unsigned NOT NULL,
  `voto` bit(1) NOT NULL,
  PRIMARY KEY (`id_utente`,`id_screen`),
  KEY `id_screen_idx` (`id_screen`),
  CONSTRAINT `id_screen` FOREIGN KEY (`id_screen`) REFERENCES `screen` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `id_utente` FOREIGN KEY (`id_utente`) REFERENCES `utenti` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='tabella contenente i voti degli utenti riguardo gli screen.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screen_vote`
--

LOCK TABLES `screen_vote` WRITE;
/*!40000 ALTER TABLE `screen_vote` DISABLE KEYS */;
/*!40000 ALTER TABLE `screen_vote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `u_minus`
--

DROP TABLE IF EXISTS `u_minus`;
/*!50001 DROP VIEW IF EXISTS `u_minus`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `u_minus` (
  `id` tinyint NOT NULL,
  `minus` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `u_plus`
--

DROP TABLE IF EXISTS `u_plus`;
/*!50001 DROP VIEW IF EXISTS `u_plus`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `u_plus` (
  `id` tinyint NOT NULL,
  `plus` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `utenti`
--

DROP TABLE IF EXISTS `utenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `utenti` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(16) NOT NULL,
  `pic` varchar(32) NOT NULL,
  `password` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome_UNIQUE` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1 COMMENT='Tabella per gli user di drrr.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utenti`
--

LOCK TABLES `utenti` WRITE;
/*!40000 ALTER TABLE `utenti` DISABLE KEYS */;
INSERT INTO `utenti` VALUES (1,'Mr.Impo','pic/setton.png','49f0c636d3143749215665a7ac4ce204'),(4,'Noble','pic/saika.png','90c9e51b0ece89b20ffab3b63ee77b71'),(5,'Dess','pic/setton.png','2bbf2c077a4b977c83139fbc78ead796'),(6,'Anzu','pic/simon.png','1051843c0f32a66104d8a5268a5ac8a3'),(7,'Raiga','pic/bakyura.png','5898722e026109acad0103e11741e448'),(8,'nabbo','pic/sizuo.png','ce4c7cb7317dc622d353af6d81fa10ea'),(9,'gigio','pic/simon.png','ciliegio'),(10,'cindy','pic/chinese.png','rolla'),(11,'1','pic/lady.png','2'),(12,'21','pic/lady.png','2'),(13,'3','pic/lady.png','2'),(14,'4','pic/lady.png','2'),(15,'cacca','pic/lady.png','2'),(16,'yey','pic/gg.png','asd'),(17,'cristolone','pic/bakyura.png','asd'),(18,'JEFF','pic/zawa.png','asd'),(19,'JEFF1','pic/zawa.png','asd'),(20,'JEFF12','pic/zawa.png','asd'),(21,'sdqw','pic/chinese.png','asd'),(22,'Dggei','pic/lady.png','lasfewg'),(23,'myfuckingtest','pic/chinese.png','kebriòewrf'),(24,'funziona','pic/koukin.png','loso'),(25,'funziona\\','pic/koukin.png','3loso'),(27,'pigro','pic/shinra.png','lazy'),(29,'tranzo','pic/bakyura.png','trinzo'),(31,'yeeee','pic/simon.png','sankana'),(33,'pinkys','pic/lolita.png','asdfawsfewgf'),(34,'cavalla','pic/izaya.png','asdwg'),(35,'test','pic/shinra.png','test'),(36,'gianni','pic/chinese.png','gianni'),(37,'1234','pic/chineseF.png','7110eda4d09e062aa5e4a390b0a572ac0d2c0220');
/*!40000 ALTER TABLE `utenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `info_screen`
--

/*!50001 DROP TABLE IF EXISTS `info_screen`*/;
/*!50001 DROP VIEW IF EXISTS `info_screen`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `info_screen` AS select `S`.`id` AS `numero`,`S`.`name` AS `src`,`U`.`nome` AS `nome`,`U`.`pic` AS `pic`,`S`.`commento` AS `descrizione`,`S`.`data` AS `data`,`S`.`titolo` AS `titolo`,`s_like`.`n_like` AS `n_like`,`s_dislike`.`n_dislike` AS `n_dislike` from (`utenti` `U` join ((`screen` `S` left join `s_like` on((`S`.`id` = `s_like`.`id_screen`))) left join `s_dislike` on((`S`.`id` = `s_dislike`.`id_screen`)))) where (`S`.`id_utente` = `U`.`id`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `info_user`
--

/*!50001 DROP TABLE IF EXISTS `info_user`*/;
/*!50001 DROP VIEW IF EXISTS `info_user`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `info_user` AS select `utenti`.`nome` AS `nome`,`utenti`.`pic` AS `pic`,(`u_plus`.`plus` - `u_minus`.`minus`) AS `punti` from ((`utenti` left join `u_plus` on((`utenti`.`id` = `u_plus`.`id`))) left join `u_minus` on((`utenti`.`id` = `u_minus`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `s_dislike`
--

/*!50001 DROP TABLE IF EXISTS `s_dislike`*/;
/*!50001 DROP VIEW IF EXISTS `s_dislike`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `s_dislike` AS select `like_screen`.`id_screen` AS `id_screen`,count(0) AS `n_dislike` from `like_screen` where (`like_screen`.`voto` = 0) group by `like_screen`.`id_screen` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `s_like`
--

/*!50001 DROP TABLE IF EXISTS `s_like`*/;
/*!50001 DROP VIEW IF EXISTS `s_like`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `s_like` AS select `like_screen`.`id_screen` AS `id_screen`,count(0) AS `n_like` from `like_screen` where (`like_screen`.`voto` = 1) group by `like_screen`.`id_screen` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `u_minus`
--

/*!50001 DROP TABLE IF EXISTS `u_minus`*/;
/*!50001 DROP VIEW IF EXISTS `u_minus`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `u_minus` AS select `screen`.`id_utente` AS `id`,sum(`s_dislike`.`n_dislike`) AS `minus` from (`s_dislike` join `screen`) where (`s_dislike`.`id_screen` = `screen`.`id`) group by `screen`.`id_utente` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `u_plus`
--

/*!50001 DROP TABLE IF EXISTS `u_plus`*/;
/*!50001 DROP VIEW IF EXISTS `u_plus`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `u_plus` AS select `screen`.`id_utente` AS `id`,sum(`s_like`.`n_like`) AS `plus` from (`s_like` join `screen`) where (`s_like`.`id_screen` = `screen`.`id`) group by `screen`.`id_utente` */;
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

-- Dump completed on 2017-09-14  0:27:36
