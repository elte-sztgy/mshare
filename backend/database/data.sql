-- MySQL dump 10.13  Distrib 8.0.15, for Linux (x86_64)
--
-- Host: localhost    Database: mshare
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `email_tokens`
--

DROP TABLE IF EXISTS `email_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `email_tokens` (
  `user_id` bigint(20) unsigned NOT NULL,
  `token` char(40) NOT NULL,
  `expiration_date` datetime DEFAULT NULL,
  `token_type` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`token`),
  UNIQUE KEY `email_token_UNIQUE` (`token`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`),
  KEY `email_enum_idx` (`token_type`),
  CONSTRAINT `email_enum` FOREIGN KEY (`token_type`) REFERENCES `email_types` (`id`),
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_tokens`
--

LOCK TABLES `email_tokens` WRITE;
/*!40000 ALTER TABLE `email_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_types`
--

DROP TABLE IF EXISTS `email_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `email_types` (
  `id` tinyint(3) unsigned NOT NULL,
  `type_name` char(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_types`
--

LOCK TABLES `email_types` WRITE;
/*!40000 ALTER TABLE `email_types` DISABLE KEYS */;
INSERT INTO `email_types` VALUES (1,'forgotten_psw'),(2,'validate_email');
/*!40000 ALTER TABLE `email_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `groups` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `creator_user_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_group_creator_idx` (`creator_user_id`),
  CONSTRAINT `fk_group_creator` FOREIGN KEY (`creator_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1,'Drinking group - everyone',1),(2,'Elvis & Elivia',13);
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `groups_AFTER_INSERT` AFTER INSERT ON `groups` FOR EACH ROW BEGIN
	INSERT INTO mshare.users_groups_map (user_id, group_id) VALUES (new.creator_user_id, new.id);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `test` (
  `idtest` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idtest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES (1,'SANYIII'),(2,'BÉÉÉÉLA'),(3,'ASDASD'),(4,'BÉÉÉÉLA'),(5,'BÉÉÉÉLLAAA'),(6,'GAZSI2');
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(320) NOT NULL,
  `password` char(64) NOT NULL,
  `display_name` varchar(32) NOT NULL,
  `creation_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'test1@test.hu','37A8EEC1CE19687D132FE29051DCA629D164E2C4958BA141D5F4133A33F0688F','Mr. Test 1','2019-03-21 00:50:56'),(2,'tommy@test.hu','37A8EEC1CE19687D132FE29051DCA629D164E2C4958BA141D5F4133A33F0688F','Tommy','2019-03-21 08:54:27'),(3,'hilario@test.hu','37A8EEC1CE19687D132FE29051DCA629D164E2C4958BA141D5F4133A33F0688F','Hilario','2019-03-21 08:54:27'),(4,'raul@test.hu','37A8EEC1CE19687D132FE29051DCA629D164E2C4958BA141D5F4133A33F0688F','Raul','2019-03-21 08:54:27'),(5,'avril@test.hu','37A8EEC1CE19687D132FE29051DCA629D164E2C4958BA141D5F4133A33F0688F','Avril','2019-03-21 08:54:27'),(6,'gracie@test.hu','37A8EEC1CE19687D132FE29051DCA629D164E2C4958BA141D5F4133A33F0688F','Gracie','2019-03-21 08:54:27'),(7,'iluminada@test.hu','37A8EEC1CE19687D132FE29051DCA629D164E2C4958BA141D5F4133A33F0688F','Iluminada','2019-03-21 08:54:27'),(8,'delpha@test.hu','37A8EEC1CE19687D132FE29051DCA629D164E2C4958BA141D5F4133A33F0688F','Delpha','2019-03-21 08:54:27'),(9,'karae@test.hu','37A8EEC1CE19687D132FE29051DCA629D164E2C4958BA141D5F4133A33F0688F','Larae','2019-03-21 08:54:27'),(10,'elvia@test.hu','37A8EEC1CE19687D132FE29051DCA629D164E2C4958BA141D5F4133A33F0688F','Elvia','2019-03-21 08:54:27'),(11,'keisha2@test.hu','37A8EEC1CE19687D132FE29051DCA629D164E2C4958BA141D5F4133A33F0688F','Keisha2','2019-03-21 08:54:27'),(12,'brice@test.hu','37A8EEC1CE19687D132FE29051DCA629D164E2C4958BA141D5F4133A33F0688F','Brice','2019-03-21 08:54:27'),(13,'elvis@test.hu','37A8EEC1CE19687D132FE29051DCA629D164E2C4958BA141D5F4133A33F0688F','Elvis','2019-03-21 08:54:27'),(14,'lucinda@test.hu','37A8EEC1CE19687D132FE29051DCA629D164E2C4958BA141D5F4133A33F0688F','Lucinda','2019-03-21 08:54:27'),(15,'donny@test.hu','37A8EEC1CE19687D132FE29051DCA629D164E2C4958BA141D5F4133A33F0688F','Donny','2019-03-21 08:54:27'),(16,'louis@test.hu','37A8EEC1CE19687D132FE29051DCA629D164E2C4958BA141D5F4133A33F0688F','Louis','2019-03-21 08:54:27'),(17,'rebecca@test.hu','37A8EEC1CE19687D132FE29051DCA629D164E2C4958BA141D5F4133A33F0688F','Rebecca','2019-03-21 08:54:27'),(18,'tamra@test.hu','37A8EEC1CE19687D132FE29051DCA629D164E2C4958BA141D5F4133A33F0688F','Tamra','2019-03-21 08:54:27'),(19,'yan@test.hu','37A8EEC1CE19687D132FE29051DCA629D164E2C4958BA141D5F4133A33F0688F','Yan','2019-03-21 08:54:27'),(20,'benito@test.hu','37A8EEC1CE19687D132FE29051DCA629D164E2C4958BA141D5F4133A33F0688F','Benito','2019-03-21 08:54:27'),(21,'jenifer@test.hu','37A8EEC1CE19687D132FE29051DCA629D164E2C4958BA141D5F4133A33F0688F','Jenifer','2019-03-21 08:54:27');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_groups_map`
--

DROP TABLE IF EXISTS `users_groups_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `users_groups_map` (
  `user_id` bigint(20) unsigned NOT NULL,
  `group_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`group_id`,`user_id`),
  KEY `groupIndex_users_groups_map` (`group_id`) /*!80000 INVISIBLE */,
  KEY `userIndex_users_groups_map` (`user_id`) /*!80000 INVISIBLE */,
  CONSTRAINT `fk_group_users_mapping` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_groups_mapping` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_groups_map`
--

LOCK TABLES `users_groups_map` WRITE;
/*!40000 ALTER TABLE `users_groups_map` DISABLE KEYS */;
INSERT INTO `users_groups_map` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1),(13,1),(14,1),(15,1),(16,1),(17,1),(18,1),(19,1),(20,1),(21,1),(10,2),(13,2);
/*!40000 ALTER TABLE `users_groups_map` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-03-22 11:38:50