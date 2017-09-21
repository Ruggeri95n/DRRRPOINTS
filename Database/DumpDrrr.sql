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
  `commento` varchar(202) CHARACTER SET latin1 DEFAULT NULL,
  `data` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `titolo` varchar(22) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8 COMMENT='tabella degli screen.';
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=latin1 COMMENT='Tabella per gli user di drrr.';
/*!40101 SET character_set_client = @saved_cs_client */;

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
/*!50001 VIEW `info_screen` AS select `S`.`id` AS `numero`,`S`.`name` AS `src`,`U`.`nome` AS `nome`,`U`.`pic` AS `pic`,`S`.`commento` AS `descrizione`,`S`.`data` AS `data`,`S`.`titolo` AS `titolo`,ifnull(`s_like`.`n_like`,0) AS `n_like`,ifnull(`s_dislike`.`n_dislike`,0) AS `n_dislike` from (`utenti` `U` join ((`screen` `S` left join `s_like` on((`S`.`id` = `s_like`.`id_screen`))) left join `s_dislike` on((`S`.`id` = `s_dislike`.`id_screen`)))) where (`S`.`id_utente` = `U`.`id`) */;
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
/*!50001 VIEW `info_user` AS select `utenti`.`nome` AS `nome`,`utenti`.`pic` AS `pic`,(ifnull(`u_plus`.`plus`,0) - ifnull(`u_minus`.`minus`,0)) AS `punti` from ((`utenti` left join `u_plus` on((`utenti`.`id` = `u_plus`.`id`))) left join `u_minus` on((`utenti`.`id` = `u_minus`.`id`))) */;
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

-- Dump completed on 2017-09-21 21:42:14
