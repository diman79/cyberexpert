-- MySQL dump 10.13  Distrib 8.0.35, for Linux (x86_64)
--
-- Host: localhost    Database: cyberexpert
-- ------------------------------------------------------
-- Server version	8.0.35-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_app_user`
--

DROP TABLE IF EXISTS `auth_app_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_app_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `username` varchar(254) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `birthday` date NOT NULL,
  `description` longtext,
  `avatar` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_app_user`
--

LOCK TABLES `auth_app_user` WRITE;
/*!40000 ALTER TABLE `auth_app_user` DISABLE KEYS */;
INSERT INTO `auth_app_user` VALUES (1,'pbkdf2_sha256$600000$FiO0IE25Ys2t0VcGykkDPF$6hsYa7NNXwENWQNBxz3wGtW311Ldvl3TESq4BcWz5Hg=','2023-11-30 15:54:26.233859',1,'','',1,1,'2023-11-30 06:20:45.317053','sharonov-db@mail.ru','sharonov-db@mail.ru','1979-02-16','','');
/*!40000 ALTER TABLE `auth_app_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_app_user_groups`
--

DROP TABLE IF EXISTS `auth_app_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_app_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_app_user_groups_user_id_group_id_5f174ff0_uniq` (`user_id`,`group_id`),
  KEY `auth_app_user_groups_group_id_b4576925_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_app_user_groups_group_id_b4576925_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_app_user_groups_user_id_2b6e45f5_fk_auth_app_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_app_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_app_user_groups`
--

LOCK TABLES `auth_app_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_app_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_app_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_app_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_app_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_app_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_app_user_user_permi_user_id_permission_id_727a8e97_uniq` (`user_id`,`permission_id`),
  KEY `auth_app_user_user_p_permission_id_cc1b2396_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_app_user_user_p_permission_id_cc1b2396_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_app_user_user_p_user_id_b7c37328_fk_auth_app_` FOREIGN KEY (`user_id`) REFERENCES `auth_app_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_app_user_user_permissions`
--

LOCK TABLES `auth_app_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_app_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_app_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add Участник',6,'add_user'),(22,'Can change Участник',6,'change_user'),(23,'Can delete Участник',6,'delete_user'),(24,'Can view Участник',6,'view_user'),(25,'Can add Token',7,'add_token'),(26,'Can change Token',7,'change_token'),(27,'Can delete Token',7,'delete_token'),(28,'Can view Token',7,'view_token'),(29,'Can add token',8,'add_tokenproxy'),(30,'Can change token',8,'change_tokenproxy'),(31,'Can delete token',8,'delete_tokenproxy'),(32,'Can view token',8,'view_tokenproxy'),(33,'Can add Утилита',9,'add_utilita'),(34,'Can change Утилита',9,'change_utilita'),(35,'Can delete Утилита',9,'delete_utilita'),(36,'Can view Утилита',9,'view_utilita'),(37,'Can add Рубрика',10,'add_rubrika'),(38,'Can change Рубрика',10,'change_rubrika'),(39,'Can delete Рубрика',10,'delete_rubrika'),(40,'Can view Рубрика',10,'view_rubrika'),(41,'Can modify rubrika',10,'modify_rubrika'),(42,'Can add Оценки',11,'add_ocenka'),(43,'Can change Оценки',11,'change_ocenka'),(44,'Can delete Оценки',11,'delete_ocenka'),(45,'Can view Оценки',11,'view_ocenka'),(46,'Can modify ocenka',11,'modify_ocenka'),(47,'Can add Статья',12,'add_statya'),(48,'Can change Статья',12,'change_statya'),(49,'Can delete Статья',12,'delete_statya'),(50,'Can view Статья',12,'view_statya'),(51,'Can modify statya',12,'modify_statya'),(52,'Can add Комментарий',13,'add_comment'),(53,'Can change Комментарий',13,'change_comment'),(54,'Can delete Комментарий',13,'delete_comment'),(55,'Can view Комментарий',13,'view_comment'),(56,'Can modify comment',13,'modify_comment');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_app_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_app_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_app_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_app_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_app_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(6,'auth_app','user'),(7,'authtoken','token'),(8,'authtoken','tokenproxy'),(4,'contenttypes','contenttype'),(13,'logica','comment'),(11,'logica','ocenka'),(10,'logica','rubrika'),(12,'logica','statya'),(9,'logica','utilita'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-11-30 05:57:27.627689'),(2,'contenttypes','0002_remove_content_type_name','2023-11-30 05:57:27.721271'),(3,'auth','0001_initial','2023-11-30 05:57:28.042878'),(4,'auth','0002_alter_permission_name_max_length','2023-11-30 05:57:28.130381'),(5,'auth','0003_alter_user_email_max_length','2023-11-30 05:57:28.142498'),(6,'auth','0004_alter_user_username_opts','2023-11-30 05:57:28.152433'),(7,'auth','0005_alter_user_last_login_null','2023-11-30 05:57:28.165065'),(8,'auth','0006_require_contenttypes_0002','2023-11-30 05:57:28.170244'),(9,'auth','0007_alter_validators_add_error_messages','2023-11-30 05:57:28.188479'),(10,'auth','0008_alter_user_username_max_length','2023-11-30 05:57:28.212999'),(11,'auth','0009_alter_user_last_name_max_length','2023-11-30 05:57:28.234748'),(12,'auth','0010_alter_group_name_max_length','2023-11-30 05:57:28.276460'),(13,'auth','0011_update_proxy_permissions','2023-11-30 05:57:28.288429'),(14,'auth','0012_alter_user_first_name_max_length','2023-11-30 05:57:28.299725'),(15,'auth_app','0001_initial','2023-11-30 05:57:28.745380'),(16,'admin','0001_initial','2023-11-30 05:57:28.932158'),(17,'admin','0002_logentry_remove_auto_add','2023-11-30 05:57:28.948205'),(18,'admin','0003_logentry_add_action_flag_choices','2023-11-30 05:57:28.963717'),(19,'authtoken','0001_initial','2023-11-30 05:57:29.063915'),(20,'authtoken','0002_auto_20160226_1747','2023-11-30 05:57:29.101084'),(21,'authtoken','0003_tokenproxy','2023-11-30 05:57:29.107083'),(22,'sessions','0001_initial','2023-11-30 05:57:29.159819'),(23,'logica','0001_initial','2023-11-30 09:26:30.085409'),(24,'logica','0002_statya_count_views_utilita_count_downloads','2023-11-30 16:06:32.746445');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logica_comment`
--

DROP TABLE IF EXISTS `logica_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logica_comment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `rod_description` longtext NOT NULL,
  `txt` longtext NOT NULL,
  `date` date NOT NULL,
  `author_comment_id` bigint NOT NULL,
  `statya_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `logica_comment_author_comment_id_d7d62cee_fk_auth_app_user_id` (`author_comment_id`),
  KEY `logica_comment_statya_id_5d59763f_fk_logica_statya_id` (`statya_id`),
  CONSTRAINT `logica_comment_author_comment_id_d7d62cee_fk_auth_app_user_id` FOREIGN KEY (`author_comment_id`) REFERENCES `auth_app_user` (`id`),
  CONSTRAINT `logica_comment_statya_id_5d59763f_fk_logica_statya_id` FOREIGN KEY (`statya_id`) REFERENCES `logica_statya` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logica_comment`
--

LOCK TABLES `logica_comment` WRITE;
/*!40000 ALTER TABLE `logica_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `logica_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logica_ocenka`
--

DROP TABLE IF EXISTS `logica_ocenka`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logica_ocenka` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `bal` int NOT NULL,
  `author_ocenka_id` bigint NOT NULL,
  `komu_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `logica_ocenka_author_ocenka_id_341c014a_fk_auth_app_user_id` (`author_ocenka_id`),
  KEY `logica_ocenka_komu_id_1239208e_fk_auth_app_user_id` (`komu_id`),
  CONSTRAINT `logica_ocenka_author_ocenka_id_341c014a_fk_auth_app_user_id` FOREIGN KEY (`author_ocenka_id`) REFERENCES `auth_app_user` (`id`),
  CONSTRAINT `logica_ocenka_komu_id_1239208e_fk_auth_app_user_id` FOREIGN KEY (`komu_id`) REFERENCES `auth_app_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logica_ocenka`
--

LOCK TABLES `logica_ocenka` WRITE;
/*!40000 ALTER TABLE `logica_ocenka` DISABLE KEYS */;
/*!40000 ALTER TABLE `logica_ocenka` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logica_rubrika`
--

DROP TABLE IF EXISTS `logica_rubrika`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logica_rubrika` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `naim` varchar(255) NOT NULL,
  `author_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `naim` (`naim`),
  KEY `logica_rubrika_author_id_7f9742cd_fk_auth_app_user_id` (`author_id`),
  CONSTRAINT `logica_rubrika_author_id_7f9742cd_fk_auth_app_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_app_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logica_rubrika`
--

LOCK TABLES `logica_rubrika` WRITE;
/*!40000 ALTER TABLE `logica_rubrika` DISABLE KEYS */;
/*!40000 ALTER TABLE `logica_rubrika` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logica_statya`
--

DROP TABLE IF EXISTS `logica_statya`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logica_statya` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `date` date NOT NULL,
  `content` longtext,
  `kartinka` varchar(100) NOT NULL,
  `author_id` bigint NOT NULL,
  `count_views` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `logica_statya_author_id_cf786c63_fk_auth_app_user_id` (`author_id`),
  CONSTRAINT `logica_statya_author_id_cf786c63_fk_auth_app_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_app_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logica_statya`
--

LOCK TABLES `logica_statya` WRITE;
/*!40000 ALTER TABLE `logica_statya` DISABLE KEYS */;
/*!40000 ALTER TABLE `logica_statya` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logica_utilita`
--

DROP TABLE IF EXISTS `logica_utilita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logica_utilita` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `naim` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `file` varchar(100) NOT NULL,
  `author_id` bigint NOT NULL,
  `count_downloads` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `naim` (`naim`),
  KEY `logica_utilita_author_id_7fed4c20_fk_auth_app_user_id` (`author_id`),
  CONSTRAINT `logica_utilita_author_id_7fed4c20_fk_auth_app_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_app_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logica_utilita`
--

LOCK TABLES `logica_utilita` WRITE;
/*!40000 ALTER TABLE `logica_utilita` DISABLE KEYS */;
/*!40000 ALTER TABLE `logica_utilita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statya_rubrika`
--

DROP TABLE IF EXISTS `statya_rubrika`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `statya_rubrika` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `statya_id` bigint NOT NULL,
  `rubrika_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `statya_rubrika_statya_id_rubrika_id_8b697047_uniq` (`statya_id`,`rubrika_id`),
  KEY `statya_rubrika_rubrika_id_dac2ea2f_fk_logica_rubrika_id` (`rubrika_id`),
  CONSTRAINT `statya_rubrika_rubrika_id_dac2ea2f_fk_logica_rubrika_id` FOREIGN KEY (`rubrika_id`) REFERENCES `logica_rubrika` (`id`),
  CONSTRAINT `statya_rubrika_statya_id_bf024d26_fk_logica_statya_id` FOREIGN KEY (`statya_id`) REFERENCES `logica_statya` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statya_rubrika`
--

LOCK TABLES `statya_rubrika` WRITE;
/*!40000 ALTER TABLE `statya_rubrika` DISABLE KEYS */;
/*!40000 ALTER TABLE `statya_rubrika` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-30 20:07:23
