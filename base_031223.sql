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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_app_user`
--

LOCK TABLES `auth_app_user` WRITE;
/*!40000 ALTER TABLE `auth_app_user` DISABLE KEYS */;
INSERT INTO `auth_app_user` VALUES (1,'pbkdf2_sha256$600000$FiO0IE25Ys2t0VcGykkDPF$6hsYa7NNXwENWQNBxz3wGtW311Ldvl3TESq4BcWz5Hg=','2023-12-03 15:47:04.339096',1,'Дмитрий','Шаронов',1,1,'2023-11-30 06:20:45.000000','sharonov-db@mail.ru','sharonov-db@mail.ru','1979-02-16','',''),(2,'pbkdf2_sha256$600000$7ifZOecSrRlW3rVEPB1IWa$mx/kqmvtFCWLw5mDpG0uOASFeGT/2WNlSK9saz4yxOE=','2023-12-02 15:09:54.023575',0,'uchenik','uchenik',0,1,'2023-12-02 15:02:08.000000','uchenik@uchenik.ru','uchenik@uchenik.ru','2023-02-12','wqw',''),(3,'pbkdf2_sha256$600000$lpMDB0bxGJ3bvOuBs9devi$5W4DWI9Y4Tsi7Y7VzL+vuPNdVSNu0BKFuAhxLMXa0dc=','2023-12-02 16:14:47.206464',0,'uchenik2','uchenik2',0,1,'2023-12-02 15:20:10.938909',NULL,'uchenik2@uchenik2.ru','2023-02-12','wwewe','');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_app_user_groups`
--

LOCK TABLES `auth_app_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_app_user_groups` DISABLE KEYS */;
INSERT INTO `auth_app_user_groups` VALUES (1,1,1),(2,1,2),(3,1,3),(4,2,3),(5,3,3);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (2,'Автор'),(1,'Администратор'),(3,'Посетитель');
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
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,1,12),(13,1,13),(14,1,14),(15,1,15),(16,1,16),(17,1,17),(18,1,18),(19,1,19),(20,1,20),(21,1,21),(22,1,22),(23,1,23),(24,1,24),(25,1,25),(26,1,26),(27,1,27),(28,1,28),(29,1,29),(30,1,30),(31,1,31),(32,1,32),(33,1,33),(34,1,34),(35,1,35),(36,1,36),(37,1,37),(38,1,38),(39,1,39),(40,1,40),(41,1,41),(42,1,42),(43,1,43),(44,1,44),(45,1,45),(46,1,46),(47,1,47),(48,1,48),(49,1,49),(50,1,50),(51,1,51),(52,1,52),(53,1,53),(54,1,54),(55,1,55),(56,1,56),(57,2,33),(58,2,36),(59,2,40),(60,2,45),(61,2,47),(62,2,48),(63,2,49),(64,2,50),(65,2,51),(66,2,52),(67,2,55),(68,3,36),(69,3,40),(70,3,42),(71,3,45),(72,3,50),(73,3,52),(74,3,55);
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
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add Участник',6,'add_user'),(22,'Can change Участник',6,'change_user'),(23,'Can delete Участник',6,'delete_user'),(24,'Can view Участник',6,'view_user'),(25,'Can add Token',7,'add_token'),(26,'Can change Token',7,'change_token'),(27,'Can delete Token',7,'delete_token'),(28,'Can view Token',7,'view_token'),(29,'Can add token',8,'add_tokenproxy'),(30,'Can change token',8,'change_tokenproxy'),(31,'Can delete token',8,'delete_tokenproxy'),(32,'Can view token',8,'view_tokenproxy'),(33,'Can add Утилита',9,'add_utilita'),(34,'Can change Утилита',9,'change_utilita'),(35,'Can delete Утилита',9,'delete_utilita'),(36,'Can view Утилита',9,'view_utilita'),(37,'Can add Рубрика',10,'add_rubrika'),(38,'Can change Рубрика',10,'change_rubrika'),(39,'Can delete Рубрика',10,'delete_rubrika'),(40,'Can view Рубрика',10,'view_rubrika'),(41,'Can modify rubrika',10,'modify_rubrika'),(42,'Can add Оценки',11,'add_ocenka'),(43,'Can change Оценки',11,'change_ocenka'),(44,'Can delete Оценки',11,'delete_ocenka'),(45,'Can view Оценки',11,'view_ocenka'),(46,'Can modify ocenka',11,'modify_ocenka'),(47,'Can add Статья',12,'add_statya'),(48,'Can change Статья',12,'change_statya'),(49,'Can delete Статья',12,'delete_statya'),(50,'Can view Статья',12,'view_statya'),(51,'Can modify statya',12,'modify_statya'),(52,'Can add Комментарий',13,'add_comment'),(53,'Can change Комментарий',13,'change_comment'),(54,'Can delete Комментарий',13,'delete_comment'),(55,'Can view Комментарий',13,'view_comment'),(56,'Can modify comment',13,'modify_comment'),(57,'Can add Ответ на комментарий',14,'add_answer_to_comment'),(58,'Can change Ответ на комментарий',14,'change_answer_to_comment'),(59,'Can delete Ответ на комментарий',14,'delete_answer_to_comment'),(60,'Can view Ответ на комментарий',14,'view_answer_to_comment'),(61,'Can add Утилита',15,'add_utilita'),(62,'Can change Утилита',15,'change_utilita'),(63,'Can delete Утилита',15,'delete_utilita'),(64,'Can view Утилита',15,'view_utilita');
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2023-12-01 05:58:51.683937','1','Администратор',1,'[{\"added\": {}}]',3,1),(2,'2023-12-01 06:02:00.705656','2','Автор',1,'[{\"added\": {}}]',3,1),(3,'2023-12-01 06:03:30.275997','3','Посетитель',1,'[{\"added\": {}}]',3,1),(4,'2023-12-01 06:03:51.907788','1','Участник  : sharonov-db@mail.ru',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',6,1),(5,'2023-12-01 08:32:49.067354','1','Участник Дмитрий Шаронов: sharonov-db@mail.ru',2,'[{\"changed\": {\"fields\": [\"First name\", \"Last name\"]}}]',6,1),(6,'2023-12-01 10:18:25.176489','1','Рубрика: Сетевые технологии',1,'[{\"added\": {}}]',10,1),(7,'2023-12-02 06:46:19.102059','2','Рубрика: Интернет',1,'[{\"added\": {}}]',10,1),(8,'2023-12-02 08:00:04.595754','7','Статья: уукук. Рубрика: [\'Интернет\']. Дата публикации: 2023-12-02. Автор: Участник Дмитрий Шаронов: sharonov-db@mail.ru Описание: укук',2,'[{\"changed\": {\"fields\": [\"\\u0410\\u0432\\u0442\\u043e\\u0440 \\u0441\\u0442\\u0430\\u0442\\u044c\\u0438\", \"\\u0420\\u0443\\u0431\\u0440\\u0438\\u043a\\u0430\", \"\\u0414\\u0430\\u0442\\u0430 \\u043f\\u0443\\u0431\\u043b\\u0438\\u043a\\u0430\\u0446\\u0438\\u0438\"]}}]',12,1),(9,'2023-12-02 08:00:25.761789','8','Статья: rtrtrtr. Рубрика: [\'Интернет\']. Дата публикации: 2023-12-02. Автор: Участник Дмитрий Шаронов: sharonov-db@mail.ru Описание: rtrt',2,'[{\"changed\": {\"fields\": [\"\\u0410\\u0432\\u0442\\u043e\\u0440 \\u0441\\u0442\\u0430\\u0442\\u044c\\u0438\", \"\\u0420\\u0443\\u0431\\u0440\\u0438\\u043a\\u0430\", \"\\u0414\\u0430\\u0442\\u0430 \\u043f\\u0443\\u0431\\u043b\\u0438\\u043a\\u0430\\u0446\\u0438\\u0438\"]}}]',12,1),(10,'2023-12-02 08:00:41.593355','6','Статья: sdsd. Рубрика: [\'Сетевые технологии\']. Дата публикации: 2023-12-02. Автор: Участник Дмитрий Шаронов: sharonov-db@mail.ru Описание: sdsd',2,'[{\"changed\": {\"fields\": [\"\\u0410\\u0432\\u0442\\u043e\\u0440 \\u0441\\u0442\\u0430\\u0442\\u044c\\u0438\", \"\\u0420\\u0443\\u0431\\u0440\\u0438\\u043a\\u0430\", \"\\u0414\\u0430\\u0442\\u0430 \\u043f\\u0443\\u0431\\u043b\\u0438\\u043a\\u0430\\u0446\\u0438\\u0438\"]}}]',12,1),(11,'2023-12-02 14:40:43.825221','1','Участник Дмитрий Шаронов: sharonov-db@mail.ru',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',6,1),(12,'2023-12-02 15:03:20.177135','9','Статья: 2sdde. Рубрика: [\'Интернет\']. Дата публикации: 2023-12-02. Автор: Участник Дмитрий Шаронов: sharonov-db@mail.ru Описание: sdd',2,'[{\"changed\": {\"fields\": [\"\\u0410\\u0432\\u0442\\u043e\\u0440 \\u0441\\u0442\\u0430\\u0442\\u044c\\u0438\", \"Rubrika\", \"\\u0414\\u0430\\u0442\\u0430 \\u043f\\u0443\\u0431\\u043b\\u0438\\u043a\\u0430\\u0446\\u0438\\u0438\"]}}]',12,1),(13,'2023-12-02 15:05:26.961302','10','Статья: ssD. Рубрика: [\'Интернет\']. Дата публикации: 2023-12-02. Автор: Участник Дмитрий Шаронов: sharonov-db@mail.ru Описание: SDASDASD',2,'[{\"changed\": {\"fields\": [\"\\u0410\\u0432\\u0442\\u043e\\u0440 \\u0441\\u0442\\u0430\\u0442\\u044c\\u0438\", \"Rubrika\", \"\\u0414\\u0430\\u0442\\u0430 \\u043f\\u0443\\u0431\\u043b\\u0438\\u043a\\u0430\\u0446\\u0438\\u0438\"]}}]',12,1),(14,'2023-12-02 15:06:37.654057','2','Участник uchenik uchenik: uchenik@uchenik.ru',2,'[{\"changed\": {\"fields\": [\"Groups\", \"Username\"]}}]',6,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(6,'auth_app','user'),(7,'authtoken','token'),(8,'authtoken','tokenproxy'),(4,'contenttypes','contenttype'),(14,'logica','answer_to_comment'),(13,'logica','comment'),(11,'logica','ocenka'),(10,'logica','rubrika'),(12,'logica','statya'),(9,'logica','utilita'),(5,'sessions','session'),(15,'utilites','utilita');
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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-11-30 05:57:27.627689'),(2,'contenttypes','0002_remove_content_type_name','2023-11-30 05:57:27.721271'),(3,'auth','0001_initial','2023-11-30 05:57:28.042878'),(4,'auth','0002_alter_permission_name_max_length','2023-11-30 05:57:28.130381'),(5,'auth','0003_alter_user_email_max_length','2023-11-30 05:57:28.142498'),(6,'auth','0004_alter_user_username_opts','2023-11-30 05:57:28.152433'),(7,'auth','0005_alter_user_last_login_null','2023-11-30 05:57:28.165065'),(8,'auth','0006_require_contenttypes_0002','2023-11-30 05:57:28.170244'),(9,'auth','0007_alter_validators_add_error_messages','2023-11-30 05:57:28.188479'),(10,'auth','0008_alter_user_username_max_length','2023-11-30 05:57:28.212999'),(11,'auth','0009_alter_user_last_name_max_length','2023-11-30 05:57:28.234748'),(12,'auth','0010_alter_group_name_max_length','2023-11-30 05:57:28.276460'),(13,'auth','0011_update_proxy_permissions','2023-11-30 05:57:28.288429'),(14,'auth','0012_alter_user_first_name_max_length','2023-11-30 05:57:28.299725'),(15,'auth_app','0001_initial','2023-11-30 05:57:28.745380'),(16,'admin','0001_initial','2023-11-30 05:57:28.932158'),(17,'admin','0002_logentry_remove_auto_add','2023-11-30 05:57:28.948205'),(18,'admin','0003_logentry_add_action_flag_choices','2023-11-30 05:57:28.963717'),(19,'authtoken','0001_initial','2023-11-30 05:57:29.063915'),(20,'authtoken','0002_auto_20160226_1747','2023-11-30 05:57:29.101084'),(21,'authtoken','0003_tokenproxy','2023-11-30 05:57:29.107083'),(22,'sessions','0001_initial','2023-11-30 05:57:29.159819'),(23,'logica','0001_initial','2023-11-30 09:26:30.085409'),(24,'logica','0002_statya_count_views_utilita_count_downloads','2023-11-30 16:06:32.746445'),(25,'logica','0003_alter_statya_content_alter_statya_description','2023-12-01 05:05:45.847537'),(26,'logica','0004_remove_statya_author_statya_author','2023-12-02 05:35:52.170941'),(27,'logica','0005_alter_statya_date','2023-12-02 05:52:52.212785'),(28,'logica','0006_rename_date_statya_data_publication','2023-12-02 05:56:20.795546'),(29,'logica','0007_remove_statya_author_statya_author','2023-12-02 06:12:19.786150'),(30,'logica','0008_alter_statya_rubrika','2023-12-02 10:02:10.745652'),(31,'logica','0009_alter_statya_rubrika_answer_to_comment','2023-12-02 10:59:52.868859'),(32,'logica','0010_remove_comment_rod_description','2023-12-02 11:03:38.348864'),(33,'logica','0011_rename_txt_comment_content','2023-12-02 11:05:55.804041'),(34,'logica','0012_answer_to_comment_author_otveta_and_more','2023-12-02 11:15:27.106681'),(35,'logica','0013_alter_comment_date','2023-12-02 12:55:38.330476'),(36,'logica','0014_alter_statya_count_views','2023-12-02 16:44:06.111137'),(37,'logica','0015_statya_reiting','2023-12-03 05:10:45.306012'),(38,'logica','0016_ocenka_statya','2023-12-03 07:04:52.973746'),(39,'utilites','0001_initial','2023-12-03 13:25:02.395962'),(40,'utilites','0002_utilita_file','2023-12-03 13:33:37.167448');
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
INSERT INTO `django_session` VALUES ('3ryo2fmzt416wx638ei2jhr6y4nuet69','.eJxVjEEOwiAQRe8ya0OAQp126d4zEGCmFjVgSptojHe3Tbrp9r33_xdc5VpTyY7frzR9oJcncH6ZR7dUnlwi6EHBgQUfH5w3QXefb0XEkucpBbElYrdVXAvx87K3h4PR13Fdo-0a1EZLZmqpGZSMxlryHFszeI0KB9mhCkZJPpPFuIJgrGblW0to4PcH-ks-tA:1r8ylf:nQuQ57fFOv89WQ1MiOTPwh7s6TYtHHZj5tiFOXGi37Y','2023-12-01 09:10:59.235884');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logica_answer_to_comment`
--

DROP TABLE IF EXISTS `logica_answer_to_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logica_answer_to_comment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `sent_date` datetime(6) NOT NULL,
  `comment_id` bigint NOT NULL,
  `komu_answer_id` bigint NOT NULL,
  `author_otveta_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `logica_answer_to_com_comment_id_5d476cf2_fk_logica_co` (`comment_id`),
  KEY `logica_answer_to_com_komu_answer_id_4450d712_fk_auth_app_` (`komu_answer_id`),
  KEY `logica_answer_to_com_author_otveta_id_61eaeb78_fk_auth_app_` (`author_otveta_id`),
  CONSTRAINT `logica_answer_to_com_author_otveta_id_61eaeb78_fk_auth_app_` FOREIGN KEY (`author_otveta_id`) REFERENCES `auth_app_user` (`id`),
  CONSTRAINT `logica_answer_to_com_comment_id_5d476cf2_fk_logica_co` FOREIGN KEY (`comment_id`) REFERENCES `logica_comment` (`id`),
  CONSTRAINT `logica_answer_to_com_komu_answer_id_4450d712_fk_auth_app_` FOREIGN KEY (`komu_answer_id`) REFERENCES `auth_app_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logica_answer_to_comment`
--

LOCK TABLES `logica_answer_to_comment` WRITE;
/*!40000 ALTER TABLE `logica_answer_to_comment` DISABLE KEYS */;
INSERT INTO `logica_answer_to_comment` VALUES (1,'ewewwe','2023-12-02 14:21:19.591201',1,1,1),(2,'wewewe','2023-12-02 14:23:57.857444',2,1,1),(3,'wwwqw','2023-12-02 14:55:29.842581',4,1,1),(4,'wwqw','2023-12-02 15:04:37.415439',6,1,1),(5,'ererer','2023-12-02 15:09:44.386101',7,2,1),(6,'dweew','2023-12-02 16:15:36.773643',12,3,1),(7,'qwqwqww','2023-12-02 16:15:57.829179',12,3,1),(8,'wwee','2023-12-02 16:20:11.310656',14,1,1),(9,'qwqw','2023-12-02 16:20:22.280602',14,1,1),(10,'qwqqw','2023-12-02 16:20:42.759072',14,1,1);
/*!40000 ALTER TABLE `logica_answer_to_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logica_comment`
--

DROP TABLE IF EXISTS `logica_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logica_comment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `date` date NOT NULL,
  `author_comment_id` bigint NOT NULL,
  `statya_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `logica_comment_author_comment_id_d7d62cee_fk_auth_app_user_id` (`author_comment_id`),
  KEY `logica_comment_statya_id_5d59763f_fk_logica_statya_id` (`statya_id`),
  CONSTRAINT `logica_comment_author_comment_id_d7d62cee_fk_auth_app_user_id` FOREIGN KEY (`author_comment_id`) REFERENCES `auth_app_user` (`id`),
  CONSTRAINT `logica_comment_statya_id_5d59763f_fk_logica_statya_id` FOREIGN KEY (`statya_id`) REFERENCES `logica_statya` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logica_comment`
--

LOCK TABLES `logica_comment` WRITE;
/*!40000 ALTER TABLE `logica_comment` DISABLE KEYS */;
INSERT INTO `logica_comment` VALUES (1,'wewewe','2023-12-02',1,8),(2,'wwewwe','2023-12-02',1,23),(3,'asas','2023-12-02',1,24),(4,'adsd','2023-12-02',1,6),(5,'ddfdfdf','2023-12-02',1,25),(6,'wwewew','2023-12-02',1,9),(7,'wewewe','2023-12-02',2,10),(8,'ывыв','2023-12-02',3,6),(9,'цвццвйцв','2023-12-02',3,6),(10,'выыв','2023-12-02',3,6),(11,'цццуцу','2023-12-02',3,9),(12,'цццу','2023-12-02',3,9),(13,'wewewe','2023-12-02',1,8),(14,'erwere','2023-12-02',1,23);
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
  `statya_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `logica_ocenka_author_ocenka_id_341c014a_fk_auth_app_user_id` (`author_ocenka_id`),
  KEY `logica_ocenka_komu_id_1239208e_fk_auth_app_user_id` (`komu_id`),
  KEY `logica_ocenka_statya_id_2f69049b_fk_logica_statya_id` (`statya_id`),
  CONSTRAINT `logica_ocenka_author_ocenka_id_341c014a_fk_auth_app_user_id` FOREIGN KEY (`author_ocenka_id`) REFERENCES `auth_app_user` (`id`),
  CONSTRAINT `logica_ocenka_komu_id_1239208e_fk_auth_app_user_id` FOREIGN KEY (`komu_id`) REFERENCES `auth_app_user` (`id`),
  CONSTRAINT `logica_ocenka_statya_id_2f69049b_fk_logica_statya_id` FOREIGN KEY (`statya_id`) REFERENCES `logica_statya` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logica_ocenka`
--

LOCK TABLES `logica_ocenka` WRITE;
/*!40000 ALTER TABLE `logica_ocenka` DISABLE KEYS */;
INSERT INTO `logica_ocenka` VALUES (4,5,1,1,23),(5,3,1,1,8),(6,3,1,1,24);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logica_rubrika`
--

LOCK TABLES `logica_rubrika` WRITE;
/*!40000 ALTER TABLE `logica_rubrika` DISABLE KEYS */;
INSERT INTO `logica_rubrika` VALUES (1,'Сетевые технологии',1),(2,'Интернет',1);
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
  `data_publication` date DEFAULT NULL,
  `content` longtext,
  `kartinka` varchar(100) NOT NULL,
  `count_views` int unsigned NOT NULL,
  `author_id` bigint DEFAULT NULL,
  `reiting` double NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `logica_statya_author_id_cf786c63_fk_auth_app_user_id` (`author_id`),
  CONSTRAINT `logica_statya_author_id_cf786c63_fk_auth_app_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_app_user` (`id`),
  CONSTRAINT `logica_statya_count_views_1c32550f_check` CHECK ((`count_views` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logica_statya`
--

LOCK TABLES `logica_statya` WRITE;
/*!40000 ALTER TABLE `logica_statya` DISABLE KEYS */;
INSERT INTO `logica_statya` VALUES (6,'sdsd','sdsd','2023-12-02','sdsd','',0,1,3.67),(8,'rtrtrtr1','rtrt1','2023-12-02','trtrtr','',18,1,3.67),(9,'2sdde','sdd','2023-12-02','dsdd','',15,1,3.67),(10,'ssD','SDASDASD','2023-12-02','ASDASDDSA','',15,1,3.67),(11,'kkkkkkk','kkkkkkkk','2023-12-02','kkkkkkkkkkkkk','',0,1,3.67),(12,'аааа','аааа','2023-12-02','аааа','',0,1,3.67),(13,'ddd','ddd','2023-12-02','ddd','',0,1,3.67),(15,'sdsd33333','sds','2023-12-02','sdsd','',0,1,3.67),(16,'wwewwe','wewweew','2023-12-02','wewewew','',0,1,3.67),(17,'qwqwq23','qwqwqw','2023-12-02','qwqwqwq','',0,1,3.67),(18,'ццуцууцуцу33','ывывыв','2023-12-02','ывывы','',0,1,3.67),(19,'dsdd44','qqwwq','2023-12-02','qwqwqw','',0,1,3.67),(22,'wwwwwww','wqw','2023-12-02','qwqw','',0,1,3.67),(23,'wwew','wewe','2023-12-02','wewe','',15,1,3.67),(24,'uuuuuuuuuuuuuuuuuuuu67','dwdweew','2023-12-02','wewe','',18,1,3.67),(25,'ghghghgh','ghghghh','2023-12-02','ghghgh','',16,1,3.67);
/*!40000 ALTER TABLE `logica_statya` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logica_statya_rubrika`
--

DROP TABLE IF EXISTS `logica_statya_rubrika`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logica_statya_rubrika` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `statya_id` bigint NOT NULL,
  `rubrika_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `statya_rubrika_statya_id_rubrika_id_8b697047_uniq` (`statya_id`,`rubrika_id`),
  KEY `statya_rubrika_rubrika_id_dac2ea2f_fk_logica_rubrika_id` (`rubrika_id`),
  CONSTRAINT `statya_rubrika_rubrika_id_dac2ea2f_fk_logica_rubrika_id` FOREIGN KEY (`rubrika_id`) REFERENCES `logica_rubrika` (`id`),
  CONSTRAINT `statya_rubrika_statya_id_bf024d26_fk_logica_statya_id` FOREIGN KEY (`statya_id`) REFERENCES `logica_statya` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logica_statya_rubrika`
--

LOCK TABLES `logica_statya_rubrika` WRITE;
/*!40000 ALTER TABLE `logica_statya_rubrika` DISABLE KEYS */;
INSERT INTO `logica_statya_rubrika` VALUES (3,6,1),(2,8,2),(7,9,2),(8,10,2),(4,23,2),(5,24,2),(6,25,2);
/*!40000 ALTER TABLE `logica_statya_rubrika` ENABLE KEYS */;
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
-- Table structure for table `utilites_utilita`
--

DROP TABLE IF EXISTS `utilites_utilita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utilites_utilita` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `data_publication` date DEFAULT NULL,
  `count_downloads` int unsigned NOT NULL,
  `moderated` tinyint(1) NOT NULL,
  `author_id` bigint DEFAULT NULL,
  `file` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `utilites_utilita_author_id_2273586b_fk_auth_app_user_id` (`author_id`),
  CONSTRAINT `utilites_utilita_author_id_2273586b_fk_auth_app_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_app_user` (`id`),
  CONSTRAINT `utilites_utilita_chk_1` CHECK ((`count_downloads` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilites_utilita`
--

LOCK TABLES `utilites_utilita` WRITE;
/*!40000 ALTER TABLE `utilites_utilita` DISABLE KEYS */;
INSERT INTO `utilites_utilita` VALUES (1,'wewe','wewe','2023-12-03',0,0,1,'Снимок_экрана_от_2023-11-28_20-31-33.png');
/*!40000 ALTER TABLE `utilites_utilita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utilites_utilita_rubrika`
--

DROP TABLE IF EXISTS `utilites_utilita_rubrika`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utilites_utilita_rubrika` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `utilita_id` bigint NOT NULL,
  `rubrika_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `utilites_utilita_rubrika_utilita_id_rubrika_id_d8cffe75_uniq` (`utilita_id`,`rubrika_id`),
  KEY `utilites_utilita_rub_rubrika_id_3cb2d46d_fk_logica_ru` (`rubrika_id`),
  CONSTRAINT `utilites_utilita_rub_rubrika_id_3cb2d46d_fk_logica_ru` FOREIGN KEY (`rubrika_id`) REFERENCES `logica_rubrika` (`id`),
  CONSTRAINT `utilites_utilita_rub_utilita_id_970a417d_fk_utilites_` FOREIGN KEY (`utilita_id`) REFERENCES `utilites_utilita` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilites_utilita_rubrika`
--

LOCK TABLES `utilites_utilita_rubrika` WRITE;
/*!40000 ALTER TABLE `utilites_utilita_rubrika` DISABLE KEYS */;
INSERT INTO `utilites_utilita_rubrika` VALUES (1,1,2);
/*!40000 ALTER TABLE `utilites_utilita_rubrika` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-03 19:55:57
