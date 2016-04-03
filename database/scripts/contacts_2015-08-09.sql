# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.6.23)
# Database: contacts
# Generation Time: 2015-08-09 21:49:01 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table address
# ------------------------------------------------------------

DROP TABLE IF EXISTS `address`;

CREATE TABLE `address` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifier',
  `label` varchar(100) NOT NULL COMMENT 'Label',
  `line1` varchar(255) NOT NULL DEFAULT '' COMMENT 'Line 1',
  `line2` varchar(255) DEFAULT NULL COMMENT 'Line 2',
  `country_alpha2_code` char(2) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'Country ISO',
  `state` varchar(255) DEFAULT NULL COMMENT 'State/Province',
  `city` varchar(255) DEFAULT NULL COMMENT 'Town/City',
  `postal_code` varchar(15) DEFAULT NULL COMMENT 'Postal Code',
  PRIMARY KEY (`id`),
  KEY `idx_label` (`label`),
  KEY `country_alpha2_code_fk` (`country_alpha2_code`),
  CONSTRAINT `country_alpha2_code_fk` FOREIGN KEY (`country_alpha2_code`) REFERENCES `country` (`country_alpha2_code`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table connection
# ------------------------------------------------------------

DROP TABLE IF EXISTS `connection`;

CREATE TABLE `connection` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifier',
  `nickname` varchar(255) DEFAULT NULL COMMENT 'Nickname',
  `member_id_main` int(11) unsigned NOT NULL COMMENT 'Member',
  `status` enum('PENDING_REQUEST','PENDING_ACCEPT','CONNECTED','SPAMMED') NOT NULL DEFAULT 'PENDING_REQUEST' COMMENT 'Status between members',
  `member_id_connection` int(11) unsigned NOT NULL COMMENT 'Member connection',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unq_member_id_main_connection` (`member_id_main`,`member_id_connection`),
  KEY `idx_member_id_main` (`member_id_main`),
  KEY `idx_member_id_connection` (`member_id_connection`),
  KEY `idx_status` (`status`),
  KEY `idx_nickname` (`nickname`),
  CONSTRAINT `member_id_connection_fk` FOREIGN KEY (`member_id_connection`) REFERENCES `member` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table country
# ------------------------------------------------------------

DROP TABLE IF EXISTS `country`;

CREATE TABLE `country` (
  `lang` varchar(5) COLLATE utf8_bin DEFAULT NULL,
  `lang_name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `country_alpha2_code` char(2) COLLATE utf8_bin DEFAULT NULL,
  `country_alpha3_code` char(3) COLLATE utf8_bin DEFAULT NULL,
  `country_numeric_code` char(3) COLLATE utf8_bin DEFAULT NULL,
  `country_name` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  KEY `idx_lang` (`lang`),
  KEY `idx_country_alpha2_code` (`country_alpha2_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;



# Dump of table member
# ------------------------------------------------------------

DROP TABLE IF EXISTS `member`;

CREATE TABLE `member` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifier',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Full name',
  `username` varchar(100) NOT NULL COMMENT 'Username',
  `password` varchar(40) NOT NULL DEFAULT '' COMMENT 'Password',
  `birth` date DEFAULT NULL COMMENT 'Date of birth',
  `sign_up_token` varchar(40) NOT NULL DEFAULT '' COMMENT 'Sign up token',
  `active` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Flag to say if is an active member, user needs to verify before been activated',
  `creation` datetime NOT NULL COMMENT 'Creation date',
  `sign_up` datetime DEFAULT NULL COMMENT 'Sign up date',
  PRIMARY KEY (`id`),
  KEY `unq_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table member_address
# ------------------------------------------------------------

DROP TABLE IF EXISTS `member_address`;

CREATE TABLE `member_address` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifier',
  `member_id` int(11) unsigned NOT NULL COMMENT 'Member Identifier',
  `address_id` int(11) unsigned NOT NULL COMMENT 'Address Identifier',
  PRIMARY KEY (`id`),
  KEY `idx_member_id` (`member_id`),
  KEY `idx_address_id` (`address_id`),
  CONSTRAINT `member_address_address_id_fk` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `member_address_member_id_fk` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table member_phone
# ------------------------------------------------------------

DROP TABLE IF EXISTS `member_phone`;

CREATE TABLE `member_phone` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifier',
  `member_id` int(11) unsigned NOT NULL COMMENT 'Member Identifier',
  `phone_id` int(11) unsigned NOT NULL COMMENT 'Phone Identifier',
  PRIMARY KEY (`id`),
  KEY `idx_member_id` (`member_id`),
  KEY `idx_phone_id` (`phone_id`),
  CONSTRAINT `member_phone_member_id_fk` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `member_phone_phone_id_fk` FOREIGN KEY (`phone_id`) REFERENCES `phone` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table phone
# ------------------------------------------------------------

DROP TABLE IF EXISTS `phone`;

CREATE TABLE `phone` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifier',
  `label` varchar(100) NOT NULL COMMENT 'Label',
  `number` varchar(50) NOT NULL DEFAULT '' COMMENT 'Number',
  PRIMARY KEY (`id`),
  KEY `idx_label` (`label`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
