-- MySQL dump 10.13  Distrib 5.1.58, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: paynedigital_test
-- ------------------------------------------------------
-- Server version	5.1.58-1ubuntu1-log

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
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int(10) unsigned NOT NULL,
  `ip` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  `approved` tinyint(4) NOT NULL,
  `approved_at` datetime NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `notifications` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`),
  KEY `approved` (`approved`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,3,'192.168.2.18','Test User 1','test@example.com','This is a test comment, Quisque vestibulum mauris ut odio sodales convallis. In molestie orci ut felis eleifend vel pretium diam feugiat. Aenean magna turpis, tempor et volutpat eget, scelerisque vel magna. Pellentesque in dolor nisi, sed viverra felis.',1,'2011-09-16 12:56:45','2011-09-16 12:56:45','2011-09-16 12:56:45',''),(2,3,'127.0.0.2','Test Person 2','test@example.com','This is a test message Donec tincidunt, mauris at dictum vestibulum, urna nulla pharetra turpis, a vulputate risus sapien id tortor. In augue felis, blandit non vestibulum vel, dignissim id nibh. Nunc gravida, purus eu vehicula hendrerit, libero massa dapibus velit, a egestas odio mi at tortor.',1,'2011-09-15 09:33:47','2011-09-15 09:33:47','2011-09-15 09:33:47',''),(3,3,'192.168.2.18','Another Tester','test5@example.com','This is another comment which has not been approved',0,'0000-00-00 00:00:00','2011-10-10 12:02:46','2011-10-10 12:02:46','{\"email_on_approval\":\"on\",\"email_on_new\":\"on\"}'),(4,1,'127.0.0.2','Mr Test','test3@example.com','This is a comment - it has not been approved.',0,'0000-00-00 00:00:00','2011-10-10 12:02:46','2011-10-10 12:02:46','{\"email_on_new\":\"on\"}'),(5,6,'67.166.8.3','A User','a.user@example.com','This comment has not been approved.',0,'2011-10-11 11:22:44','2011-10-10 12:18:02','2011-10-10 12:18:02','');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
INSERT INTO `contacts` VALUES (1,'Test Person','test@example.com','This is a test message','2011-09-16 11:17:36','2011-09-16 11:17:36'),(2,'Test Person','test@example.com','This is a test message','2011-09-16 12:56:47','2011-09-16 12:56:47'),(3,'Test Person','test@example.com','This is a test message','2011-09-16 13:47:55','2011-09-16 13:47:55'),(4,'Test Person','test@example.com','This is a test message','2011-09-16 13:54:04','2011-09-16 13:54:04'),(5,'Test Person','test@example.com','This is a test message','2011-09-16 14:17:02','2011-09-16 14:17:02'),(6,'Test Person','test@example.com','This is a test message','2011-09-16 14:17:19','2011-09-16 14:17:19');
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  `published` datetime NOT NULL,
  `status` enum('DRAFT','PUBLISHED','DELETED') COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `tags` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `head_block` text COLLATE utf8_unicode_ci NOT NULL,
  `script_block` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `url` (`url`),
  KEY `user_id` (`user_id`),
  KEY `published` (`published`),
  KEY `status` (`status`),
  KEY `tags` (`tags`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,1,'This Is A Test Post','this-is-a-test-post','<p>This is simply a test post.</p>\r\n<p>It doesn\'t do <strong>much</strong> <em>at</em> <small>all</small>.','2011-09-14 17:34:41','PUBLISHED','2011-09-14 17:34:41','2011-09-14 17:34:41','|web|apache|music|test|','<link rel=\"stylesheet\" type=\"text/css\" href=\"/foo/bar.css\" />','<script type=\"text/javascript\" src=\"/foo/bar.js\"></script>'),(2,1,'This post hasn\'t been published','not-published-yet','<p>This post hasn\'t been published yet.</p>','2010-01-01 12:00:00','DRAFT','2011-09-14 17:34:41','2011-09-14 17:34:41','|apache|test|','',''),(3,2,'Another Test Post','another-test-post','<p>This test post doesn\'t do much either - it\'s only here to test that posts appear in the correct order.</p>','2011-09-14 18:13:47','PUBLISHED','2011-09-14 18:13:47','2011-09-14 18:13:47','|test|php|apache|','',''),(4,1,'This Post Has Been Deleted','this-post-has-been-deleted','<p>Oh well. Nevermind.</p>','2011-09-15 14:43:11','DELETED','2011-09-15 14:43:11','2011-09-15 14:43:11','|test|','',''),(5,1,'This post will be published in the future','this-post-will-be-published-in-future','<p>This is a test post to check that posts marked with a status of \'published\' don\'t appear until their published date.</p>','2021-01-01 00:00:00','PUBLISHED','2011-09-17 11:40:16','2011-09-17 11:40:16','|test|published|','',''),(6,2,'Testing Tags','testing-tags','<p>This post just tests tags with spaces.</p>','2011-09-11 12:32:08','PUBLISHED','2011-09-11 12:32:08','2011-09-11 12:32:08','|test|Server Administration|node.js|','',''),(7,2,'Just A Test','just-a-test','<p>This is just a test post. It has no tags.</p>','2011-07-01 00:00:00','PUBLISHED','2011-07-01 00:00:00','2011-07-01 00:00:00','','','');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `previews`
--

DROP TABLE IF EXISTS `previews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `previews` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `post_id` int(10) unsigned NOT NULL,
  `quantity` int(11) NOT NULL,
  `identifier` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`),
  KEY `user_id` (`user_id`),
  KEY `post_id` (`post_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `previews`
--

LOCK TABLES `previews` WRITE;
/*!40000 ALTER TABLE `previews` DISABLE KEYS */;
INSERT INTO `previews` VALUES (3,'2011-09-30 12:00:00','2011-09-30 12:13:00',1,2,0,'BxF45sZf'),(2,'2011-09-30 13:28:31','2011-09-30 13:28:31',1,2,1,'AbDx041F');
/*!40000 ALTER TABLE `previews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shortlinks`
--

DROP TABLE IF EXISTS `shortlinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shortlinks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `redirect_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `url` (`url`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shortlinks`
--

LOCK TABLES `shortlinks` WRITE;
/*!40000 ALTER TABLE `shortlinks` DISABLE KEYS */;
INSERT INTO `shortlinks` VALUES (1,'/bootbox','/2011/11/bootbox-js-alert-confirm-dialogs-for-twitter-bootstrap','2011-12-03 18:01:43','2011-12-03 18:01:43'),(2,'/trello','https://trello.com/board/paynedigital-com/4eba7ed4538fd4a54b302e23','2011-12-03 18:01:43','2011-12-03 18:01:43'),(3,'/nodeflakes','/2011/12/nodeflakes','2011-12-03 18:02:03','2011-12-03 18:02:03');
/*!40000 ALTER TABLE `shortlinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `forename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `surname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `twitter_username` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `email` (`email`),
  KEY `password` (`password`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'test@example.com','5b97e1499159553e87e7bb1566ee8ed2aa228dc8','Test','User','testuser','2011-09-14 19:12:38','2011-09-14 19:12:38'),(2,'another.test@example.com','5b97e1499159553e87e7bb1566ee8ed2aa228dc8','Another','Tester','anotherUser','2011-09-14 19:12:38','2011-09-14 19:12:38');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-12-04 11:29:35
