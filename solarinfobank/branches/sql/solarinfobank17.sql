/*
MySQL Data Transfer
Source Host: localhost
Source Database: solarinfobank17_init
Target Host: localhost
Target Database: solarinfobank17_init
Date: 2012/7/1 14:49:33
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for admin_controller_action
-- ----------------------------
CREATE TABLE `admin_controller_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `controller_name` varchar(255) DEFAULT NULL,
  `action_name` varchar(255) DEFAULT NULL,
  `typeid` int(11) DEFAULT NULL COMMENT '多个action 逗号分隔',
  `descr` varchar(255) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `isautoredirect` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for admin_controller_action_role
-- ----------------------------
CREATE TABLE `admin_controller_action_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleid` int(11) DEFAULT NULL,
  `controller_action_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6144 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for admin_role
-- ----------------------------
CREATE TABLE `admin_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `descr` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for admin_user_role
-- ----------------------------
CREATE TABLE `admin_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `roleid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for adpic
-- ----------------------------
CREATE TABLE `adpic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `picName` varchar(100) DEFAULT NULL,
  `picUrl` varchar(100) DEFAULT NULL,
  `language` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ammeter_day_data_200001
-- ----------------------------
CREATE TABLE `ammeter_day_data_200001` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200002
-- ----------------------------
CREATE TABLE `ammeter_day_data_200002` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200003
-- ----------------------------
CREATE TABLE `ammeter_day_data_200003` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200004
-- ----------------------------
CREATE TABLE `ammeter_day_data_200004` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200005
-- ----------------------------
CREATE TABLE `ammeter_day_data_200005` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200006
-- ----------------------------
CREATE TABLE `ammeter_day_data_200006` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200007
-- ----------------------------
CREATE TABLE `ammeter_day_data_200007` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200008
-- ----------------------------
CREATE TABLE `ammeter_day_data_200008` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200009
-- ----------------------------
CREATE TABLE `ammeter_day_data_200009` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200010
-- ----------------------------
CREATE TABLE `ammeter_day_data_200010` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200011
-- ----------------------------
CREATE TABLE `ammeter_day_data_200011` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200012
-- ----------------------------
CREATE TABLE `ammeter_day_data_200012` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200201
-- ----------------------------
CREATE TABLE `ammeter_day_data_200201` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200202
-- ----------------------------
CREATE TABLE `ammeter_day_data_200202` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200203
-- ----------------------------
CREATE TABLE `ammeter_day_data_200203` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200204
-- ----------------------------
CREATE TABLE `ammeter_day_data_200204` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200205
-- ----------------------------
CREATE TABLE `ammeter_day_data_200205` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200206
-- ----------------------------
CREATE TABLE `ammeter_day_data_200206` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200207
-- ----------------------------
CREATE TABLE `ammeter_day_data_200207` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200208
-- ----------------------------
CREATE TABLE `ammeter_day_data_200208` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200209
-- ----------------------------
CREATE TABLE `ammeter_day_data_200209` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200210
-- ----------------------------
CREATE TABLE `ammeter_day_data_200210` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200211
-- ----------------------------
CREATE TABLE `ammeter_day_data_200211` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200212
-- ----------------------------
CREATE TABLE `ammeter_day_data_200212` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200301
-- ----------------------------
CREATE TABLE `ammeter_day_data_200301` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200302
-- ----------------------------
CREATE TABLE `ammeter_day_data_200302` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200303
-- ----------------------------
CREATE TABLE `ammeter_day_data_200303` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200304
-- ----------------------------
CREATE TABLE `ammeter_day_data_200304` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200305
-- ----------------------------
CREATE TABLE `ammeter_day_data_200305` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200306
-- ----------------------------
CREATE TABLE `ammeter_day_data_200306` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200307
-- ----------------------------
CREATE TABLE `ammeter_day_data_200307` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200308
-- ----------------------------
CREATE TABLE `ammeter_day_data_200308` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200309
-- ----------------------------
CREATE TABLE `ammeter_day_data_200309` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200310
-- ----------------------------
CREATE TABLE `ammeter_day_data_200310` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200311
-- ----------------------------
CREATE TABLE `ammeter_day_data_200311` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200312
-- ----------------------------
CREATE TABLE `ammeter_day_data_200312` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200401
-- ----------------------------
CREATE TABLE `ammeter_day_data_200401` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200402
-- ----------------------------
CREATE TABLE `ammeter_day_data_200402` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200403
-- ----------------------------
CREATE TABLE `ammeter_day_data_200403` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200404
-- ----------------------------
CREATE TABLE `ammeter_day_data_200404` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200405
-- ----------------------------
CREATE TABLE `ammeter_day_data_200405` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200406
-- ----------------------------
CREATE TABLE `ammeter_day_data_200406` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200407
-- ----------------------------
CREATE TABLE `ammeter_day_data_200407` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200408
-- ----------------------------
CREATE TABLE `ammeter_day_data_200408` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200409
-- ----------------------------
CREATE TABLE `ammeter_day_data_200409` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200410
-- ----------------------------
CREATE TABLE `ammeter_day_data_200410` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200411
-- ----------------------------
CREATE TABLE `ammeter_day_data_200411` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200412
-- ----------------------------
CREATE TABLE `ammeter_day_data_200412` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200501
-- ----------------------------
CREATE TABLE `ammeter_day_data_200501` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200502
-- ----------------------------
CREATE TABLE `ammeter_day_data_200502` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200503
-- ----------------------------
CREATE TABLE `ammeter_day_data_200503` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200504
-- ----------------------------
CREATE TABLE `ammeter_day_data_200504` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200505
-- ----------------------------
CREATE TABLE `ammeter_day_data_200505` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200506
-- ----------------------------
CREATE TABLE `ammeter_day_data_200506` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200507
-- ----------------------------
CREATE TABLE `ammeter_day_data_200507` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200508
-- ----------------------------
CREATE TABLE `ammeter_day_data_200508` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200509
-- ----------------------------
CREATE TABLE `ammeter_day_data_200509` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200510
-- ----------------------------
CREATE TABLE `ammeter_day_data_200510` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200511
-- ----------------------------
CREATE TABLE `ammeter_day_data_200511` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200512
-- ----------------------------
CREATE TABLE `ammeter_day_data_200512` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200601
-- ----------------------------
CREATE TABLE `ammeter_day_data_200601` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200602
-- ----------------------------
CREATE TABLE `ammeter_day_data_200602` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200603
-- ----------------------------
CREATE TABLE `ammeter_day_data_200603` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200604
-- ----------------------------
CREATE TABLE `ammeter_day_data_200604` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200605
-- ----------------------------
CREATE TABLE `ammeter_day_data_200605` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200606
-- ----------------------------
CREATE TABLE `ammeter_day_data_200606` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200607
-- ----------------------------
CREATE TABLE `ammeter_day_data_200607` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200608
-- ----------------------------
CREATE TABLE `ammeter_day_data_200608` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200609
-- ----------------------------
CREATE TABLE `ammeter_day_data_200609` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200610
-- ----------------------------
CREATE TABLE `ammeter_day_data_200610` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200611
-- ----------------------------
CREATE TABLE `ammeter_day_data_200611` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200612
-- ----------------------------
CREATE TABLE `ammeter_day_data_200612` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200701
-- ----------------------------
CREATE TABLE `ammeter_day_data_200701` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200702
-- ----------------------------
CREATE TABLE `ammeter_day_data_200702` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200703
-- ----------------------------
CREATE TABLE `ammeter_day_data_200703` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200704
-- ----------------------------
CREATE TABLE `ammeter_day_data_200704` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200705
-- ----------------------------
CREATE TABLE `ammeter_day_data_200705` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200706
-- ----------------------------
CREATE TABLE `ammeter_day_data_200706` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200707
-- ----------------------------
CREATE TABLE `ammeter_day_data_200707` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200708
-- ----------------------------
CREATE TABLE `ammeter_day_data_200708` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200709
-- ----------------------------
CREATE TABLE `ammeter_day_data_200709` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200710
-- ----------------------------
CREATE TABLE `ammeter_day_data_200710` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200711
-- ----------------------------
CREATE TABLE `ammeter_day_data_200711` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200712
-- ----------------------------
CREATE TABLE `ammeter_day_data_200712` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200801
-- ----------------------------
CREATE TABLE `ammeter_day_data_200801` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200802
-- ----------------------------
CREATE TABLE `ammeter_day_data_200802` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200803
-- ----------------------------
CREATE TABLE `ammeter_day_data_200803` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200804
-- ----------------------------
CREATE TABLE `ammeter_day_data_200804` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200805
-- ----------------------------
CREATE TABLE `ammeter_day_data_200805` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200806
-- ----------------------------
CREATE TABLE `ammeter_day_data_200806` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200807
-- ----------------------------
CREATE TABLE `ammeter_day_data_200807` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200808
-- ----------------------------
CREATE TABLE `ammeter_day_data_200808` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200809
-- ----------------------------
CREATE TABLE `ammeter_day_data_200809` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200810
-- ----------------------------
CREATE TABLE `ammeter_day_data_200810` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200811
-- ----------------------------
CREATE TABLE `ammeter_day_data_200811` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200812
-- ----------------------------
CREATE TABLE `ammeter_day_data_200812` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200901
-- ----------------------------
CREATE TABLE `ammeter_day_data_200901` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200902
-- ----------------------------
CREATE TABLE `ammeter_day_data_200902` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200903
-- ----------------------------
CREATE TABLE `ammeter_day_data_200903` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200904
-- ----------------------------
CREATE TABLE `ammeter_day_data_200904` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200905
-- ----------------------------
CREATE TABLE `ammeter_day_data_200905` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200906
-- ----------------------------
CREATE TABLE `ammeter_day_data_200906` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200907
-- ----------------------------
CREATE TABLE `ammeter_day_data_200907` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200908
-- ----------------------------
CREATE TABLE `ammeter_day_data_200908` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200909
-- ----------------------------
CREATE TABLE `ammeter_day_data_200909` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200910
-- ----------------------------
CREATE TABLE `ammeter_day_data_200910` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200911
-- ----------------------------
CREATE TABLE `ammeter_day_data_200911` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_200912
-- ----------------------------
CREATE TABLE `ammeter_day_data_200912` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201001
-- ----------------------------
CREATE TABLE `ammeter_day_data_201001` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201002
-- ----------------------------
CREATE TABLE `ammeter_day_data_201002` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201003
-- ----------------------------
CREATE TABLE `ammeter_day_data_201003` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201004
-- ----------------------------
CREATE TABLE `ammeter_day_data_201004` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201005
-- ----------------------------
CREATE TABLE `ammeter_day_data_201005` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201006
-- ----------------------------
CREATE TABLE `ammeter_day_data_201006` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201007
-- ----------------------------
CREATE TABLE `ammeter_day_data_201007` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201008
-- ----------------------------
CREATE TABLE `ammeter_day_data_201008` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201009
-- ----------------------------
CREATE TABLE `ammeter_day_data_201009` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201010
-- ----------------------------
CREATE TABLE `ammeter_day_data_201010` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201011
-- ----------------------------
CREATE TABLE `ammeter_day_data_201011` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201012
-- ----------------------------
CREATE TABLE `ammeter_day_data_201012` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201101
-- ----------------------------
CREATE TABLE `ammeter_day_data_201101` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201102
-- ----------------------------
CREATE TABLE `ammeter_day_data_201102` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201103
-- ----------------------------
CREATE TABLE `ammeter_day_data_201103` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201104
-- ----------------------------
CREATE TABLE `ammeter_day_data_201104` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201105
-- ----------------------------
CREATE TABLE `ammeter_day_data_201105` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201106
-- ----------------------------
CREATE TABLE `ammeter_day_data_201106` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201107
-- ----------------------------
CREATE TABLE `ammeter_day_data_201107` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201108
-- ----------------------------
CREATE TABLE `ammeter_day_data_201108` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201109
-- ----------------------------
CREATE TABLE `ammeter_day_data_201109` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201110
-- ----------------------------
CREATE TABLE `ammeter_day_data_201110` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201111
-- ----------------------------
CREATE TABLE `ammeter_day_data_201111` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201112
-- ----------------------------
CREATE TABLE `ammeter_day_data_201112` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201201
-- ----------------------------
CREATE TABLE `ammeter_day_data_201201` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201202
-- ----------------------------
CREATE TABLE `ammeter_day_data_201202` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201203
-- ----------------------------
CREATE TABLE `ammeter_day_data_201203` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201204
-- ----------------------------
CREATE TABLE `ammeter_day_data_201204` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=372 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201205
-- ----------------------------
CREATE TABLE `ammeter_day_data_201205` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201206
-- ----------------------------
CREATE TABLE `ammeter_day_data_201206` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=1086 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201207
-- ----------------------------
CREATE TABLE `ammeter_day_data_201207` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201208
-- ----------------------------
CREATE TABLE `ammeter_day_data_201208` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201209
-- ----------------------------
CREATE TABLE `ammeter_day_data_201209` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201210
-- ----------------------------
CREATE TABLE `ammeter_day_data_201210` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201211
-- ----------------------------
CREATE TABLE `ammeter_day_data_201211` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201212
-- ----------------------------
CREATE TABLE `ammeter_day_data_201212` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201301
-- ----------------------------
CREATE TABLE `ammeter_day_data_201301` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201302
-- ----------------------------
CREATE TABLE `ammeter_day_data_201302` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201303
-- ----------------------------
CREATE TABLE `ammeter_day_data_201303` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201304
-- ----------------------------
CREATE TABLE `ammeter_day_data_201304` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201305
-- ----------------------------
CREATE TABLE `ammeter_day_data_201305` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201306
-- ----------------------------
CREATE TABLE `ammeter_day_data_201306` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201307
-- ----------------------------
CREATE TABLE `ammeter_day_data_201307` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201308
-- ----------------------------
CREATE TABLE `ammeter_day_data_201308` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201309
-- ----------------------------
CREATE TABLE `ammeter_day_data_201309` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201310
-- ----------------------------
CREATE TABLE `ammeter_day_data_201310` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201311
-- ----------------------------
CREATE TABLE `ammeter_day_data_201311` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201312
-- ----------------------------
CREATE TABLE `ammeter_day_data_201312` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201401
-- ----------------------------
CREATE TABLE `ammeter_day_data_201401` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201402
-- ----------------------------
CREATE TABLE `ammeter_day_data_201402` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201403
-- ----------------------------
CREATE TABLE `ammeter_day_data_201403` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201404
-- ----------------------------
CREATE TABLE `ammeter_day_data_201404` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201405
-- ----------------------------
CREATE TABLE `ammeter_day_data_201405` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201406
-- ----------------------------
CREATE TABLE `ammeter_day_data_201406` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201407
-- ----------------------------
CREATE TABLE `ammeter_day_data_201407` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201408
-- ----------------------------
CREATE TABLE `ammeter_day_data_201408` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201409
-- ----------------------------
CREATE TABLE `ammeter_day_data_201409` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201410
-- ----------------------------
CREATE TABLE `ammeter_day_data_201410` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201411
-- ----------------------------
CREATE TABLE `ammeter_day_data_201411` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201412
-- ----------------------------
CREATE TABLE `ammeter_day_data_201412` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201501
-- ----------------------------
CREATE TABLE `ammeter_day_data_201501` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201502
-- ----------------------------
CREATE TABLE `ammeter_day_data_201502` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201503
-- ----------------------------
CREATE TABLE `ammeter_day_data_201503` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201504
-- ----------------------------
CREATE TABLE `ammeter_day_data_201504` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201505
-- ----------------------------
CREATE TABLE `ammeter_day_data_201505` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201506
-- ----------------------------
CREATE TABLE `ammeter_day_data_201506` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201507
-- ----------------------------
CREATE TABLE `ammeter_day_data_201507` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201508
-- ----------------------------
CREATE TABLE `ammeter_day_data_201508` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201509
-- ----------------------------
CREATE TABLE `ammeter_day_data_201509` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201510
-- ----------------------------
CREATE TABLE `ammeter_day_data_201510` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201511
-- ----------------------------
CREATE TABLE `ammeter_day_data_201511` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for ammeter_day_data_201512
-- ----------------------------
CREATE TABLE `ammeter_day_data_201512` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200001
-- ----------------------------
CREATE TABLE `cabinet_day_data_200001` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200002
-- ----------------------------
CREATE TABLE `cabinet_day_data_200002` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200003
-- ----------------------------
CREATE TABLE `cabinet_day_data_200003` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200004
-- ----------------------------
CREATE TABLE `cabinet_day_data_200004` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200005
-- ----------------------------
CREATE TABLE `cabinet_day_data_200005` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200006
-- ----------------------------
CREATE TABLE `cabinet_day_data_200006` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200007
-- ----------------------------
CREATE TABLE `cabinet_day_data_200007` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200008
-- ----------------------------
CREATE TABLE `cabinet_day_data_200008` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200009
-- ----------------------------
CREATE TABLE `cabinet_day_data_200009` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200010
-- ----------------------------
CREATE TABLE `cabinet_day_data_200010` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200011
-- ----------------------------
CREATE TABLE `cabinet_day_data_200011` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200012
-- ----------------------------
CREATE TABLE `cabinet_day_data_200012` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200201
-- ----------------------------
CREATE TABLE `cabinet_day_data_200201` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200202
-- ----------------------------
CREATE TABLE `cabinet_day_data_200202` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200203
-- ----------------------------
CREATE TABLE `cabinet_day_data_200203` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200204
-- ----------------------------
CREATE TABLE `cabinet_day_data_200204` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200205
-- ----------------------------
CREATE TABLE `cabinet_day_data_200205` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200206
-- ----------------------------
CREATE TABLE `cabinet_day_data_200206` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200207
-- ----------------------------
CREATE TABLE `cabinet_day_data_200207` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200208
-- ----------------------------
CREATE TABLE `cabinet_day_data_200208` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200209
-- ----------------------------
CREATE TABLE `cabinet_day_data_200209` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200210
-- ----------------------------
CREATE TABLE `cabinet_day_data_200210` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200211
-- ----------------------------
CREATE TABLE `cabinet_day_data_200211` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200212
-- ----------------------------
CREATE TABLE `cabinet_day_data_200212` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200301
-- ----------------------------
CREATE TABLE `cabinet_day_data_200301` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200302
-- ----------------------------
CREATE TABLE `cabinet_day_data_200302` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200303
-- ----------------------------
CREATE TABLE `cabinet_day_data_200303` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200304
-- ----------------------------
CREATE TABLE `cabinet_day_data_200304` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200305
-- ----------------------------
CREATE TABLE `cabinet_day_data_200305` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200306
-- ----------------------------
CREATE TABLE `cabinet_day_data_200306` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200307
-- ----------------------------
CREATE TABLE `cabinet_day_data_200307` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200308
-- ----------------------------
CREATE TABLE `cabinet_day_data_200308` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200309
-- ----------------------------
CREATE TABLE `cabinet_day_data_200309` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200310
-- ----------------------------
CREATE TABLE `cabinet_day_data_200310` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200311
-- ----------------------------
CREATE TABLE `cabinet_day_data_200311` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200312
-- ----------------------------
CREATE TABLE `cabinet_day_data_200312` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200401
-- ----------------------------
CREATE TABLE `cabinet_day_data_200401` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200402
-- ----------------------------
CREATE TABLE `cabinet_day_data_200402` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200403
-- ----------------------------
CREATE TABLE `cabinet_day_data_200403` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200404
-- ----------------------------
CREATE TABLE `cabinet_day_data_200404` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200405
-- ----------------------------
CREATE TABLE `cabinet_day_data_200405` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200406
-- ----------------------------
CREATE TABLE `cabinet_day_data_200406` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200407
-- ----------------------------
CREATE TABLE `cabinet_day_data_200407` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200408
-- ----------------------------
CREATE TABLE `cabinet_day_data_200408` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200409
-- ----------------------------
CREATE TABLE `cabinet_day_data_200409` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200410
-- ----------------------------
CREATE TABLE `cabinet_day_data_200410` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200411
-- ----------------------------
CREATE TABLE `cabinet_day_data_200411` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200412
-- ----------------------------
CREATE TABLE `cabinet_day_data_200412` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200501
-- ----------------------------
CREATE TABLE `cabinet_day_data_200501` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200502
-- ----------------------------
CREATE TABLE `cabinet_day_data_200502` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200503
-- ----------------------------
CREATE TABLE `cabinet_day_data_200503` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200504
-- ----------------------------
CREATE TABLE `cabinet_day_data_200504` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200505
-- ----------------------------
CREATE TABLE `cabinet_day_data_200505` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200506
-- ----------------------------
CREATE TABLE `cabinet_day_data_200506` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200507
-- ----------------------------
CREATE TABLE `cabinet_day_data_200507` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200508
-- ----------------------------
CREATE TABLE `cabinet_day_data_200508` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200509
-- ----------------------------
CREATE TABLE `cabinet_day_data_200509` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200510
-- ----------------------------
CREATE TABLE `cabinet_day_data_200510` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200511
-- ----------------------------
CREATE TABLE `cabinet_day_data_200511` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200512
-- ----------------------------
CREATE TABLE `cabinet_day_data_200512` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200601
-- ----------------------------
CREATE TABLE `cabinet_day_data_200601` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200602
-- ----------------------------
CREATE TABLE `cabinet_day_data_200602` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200603
-- ----------------------------
CREATE TABLE `cabinet_day_data_200603` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200604
-- ----------------------------
CREATE TABLE `cabinet_day_data_200604` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200605
-- ----------------------------
CREATE TABLE `cabinet_day_data_200605` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200606
-- ----------------------------
CREATE TABLE `cabinet_day_data_200606` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200607
-- ----------------------------
CREATE TABLE `cabinet_day_data_200607` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200608
-- ----------------------------
CREATE TABLE `cabinet_day_data_200608` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200609
-- ----------------------------
CREATE TABLE `cabinet_day_data_200609` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200610
-- ----------------------------
CREATE TABLE `cabinet_day_data_200610` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200611
-- ----------------------------
CREATE TABLE `cabinet_day_data_200611` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200612
-- ----------------------------
CREATE TABLE `cabinet_day_data_200612` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200701
-- ----------------------------
CREATE TABLE `cabinet_day_data_200701` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200702
-- ----------------------------
CREATE TABLE `cabinet_day_data_200702` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200703
-- ----------------------------
CREATE TABLE `cabinet_day_data_200703` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200704
-- ----------------------------
CREATE TABLE `cabinet_day_data_200704` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200705
-- ----------------------------
CREATE TABLE `cabinet_day_data_200705` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200706
-- ----------------------------
CREATE TABLE `cabinet_day_data_200706` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200707
-- ----------------------------
CREATE TABLE `cabinet_day_data_200707` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200708
-- ----------------------------
CREATE TABLE `cabinet_day_data_200708` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200709
-- ----------------------------
CREATE TABLE `cabinet_day_data_200709` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200710
-- ----------------------------
CREATE TABLE `cabinet_day_data_200710` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200711
-- ----------------------------
CREATE TABLE `cabinet_day_data_200711` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200712
-- ----------------------------
CREATE TABLE `cabinet_day_data_200712` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200801
-- ----------------------------
CREATE TABLE `cabinet_day_data_200801` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200802
-- ----------------------------
CREATE TABLE `cabinet_day_data_200802` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200803
-- ----------------------------
CREATE TABLE `cabinet_day_data_200803` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200804
-- ----------------------------
CREATE TABLE `cabinet_day_data_200804` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200805
-- ----------------------------
CREATE TABLE `cabinet_day_data_200805` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200806
-- ----------------------------
CREATE TABLE `cabinet_day_data_200806` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200807
-- ----------------------------
CREATE TABLE `cabinet_day_data_200807` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200808
-- ----------------------------
CREATE TABLE `cabinet_day_data_200808` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200809
-- ----------------------------
CREATE TABLE `cabinet_day_data_200809` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200810
-- ----------------------------
CREATE TABLE `cabinet_day_data_200810` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200811
-- ----------------------------
CREATE TABLE `cabinet_day_data_200811` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200812
-- ----------------------------
CREATE TABLE `cabinet_day_data_200812` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200901
-- ----------------------------
CREATE TABLE `cabinet_day_data_200901` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200902
-- ----------------------------
CREATE TABLE `cabinet_day_data_200902` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200903
-- ----------------------------
CREATE TABLE `cabinet_day_data_200903` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200904
-- ----------------------------
CREATE TABLE `cabinet_day_data_200904` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200905
-- ----------------------------
CREATE TABLE `cabinet_day_data_200905` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200906
-- ----------------------------
CREATE TABLE `cabinet_day_data_200906` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200907
-- ----------------------------
CREATE TABLE `cabinet_day_data_200907` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200908
-- ----------------------------
CREATE TABLE `cabinet_day_data_200908` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200909
-- ----------------------------
CREATE TABLE `cabinet_day_data_200909` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200910
-- ----------------------------
CREATE TABLE `cabinet_day_data_200910` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200911
-- ----------------------------
CREATE TABLE `cabinet_day_data_200911` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_200912
-- ----------------------------
CREATE TABLE `cabinet_day_data_200912` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201001
-- ----------------------------
CREATE TABLE `cabinet_day_data_201001` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201002
-- ----------------------------
CREATE TABLE `cabinet_day_data_201002` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201003
-- ----------------------------
CREATE TABLE `cabinet_day_data_201003` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201004
-- ----------------------------
CREATE TABLE `cabinet_day_data_201004` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201005
-- ----------------------------
CREATE TABLE `cabinet_day_data_201005` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201006
-- ----------------------------
CREATE TABLE `cabinet_day_data_201006` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201007
-- ----------------------------
CREATE TABLE `cabinet_day_data_201007` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201008
-- ----------------------------
CREATE TABLE `cabinet_day_data_201008` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201009
-- ----------------------------
CREATE TABLE `cabinet_day_data_201009` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201010
-- ----------------------------
CREATE TABLE `cabinet_day_data_201010` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201011
-- ----------------------------
CREATE TABLE `cabinet_day_data_201011` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201012
-- ----------------------------
CREATE TABLE `cabinet_day_data_201012` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201101
-- ----------------------------
CREATE TABLE `cabinet_day_data_201101` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201102
-- ----------------------------
CREATE TABLE `cabinet_day_data_201102` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201103
-- ----------------------------
CREATE TABLE `cabinet_day_data_201103` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201104
-- ----------------------------
CREATE TABLE `cabinet_day_data_201104` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201105
-- ----------------------------
CREATE TABLE `cabinet_day_data_201105` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201106
-- ----------------------------
CREATE TABLE `cabinet_day_data_201106` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201107
-- ----------------------------
CREATE TABLE `cabinet_day_data_201107` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201108
-- ----------------------------
CREATE TABLE `cabinet_day_data_201108` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201109
-- ----------------------------
CREATE TABLE `cabinet_day_data_201109` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=372 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201110
-- ----------------------------
CREATE TABLE `cabinet_day_data_201110` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201111
-- ----------------------------
CREATE TABLE `cabinet_day_data_201111` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201112
-- ----------------------------
CREATE TABLE `cabinet_day_data_201112` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201201
-- ----------------------------
CREATE TABLE `cabinet_day_data_201201` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=2576 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201202
-- ----------------------------
CREATE TABLE `cabinet_day_data_201202` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=2482 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201203
-- ----------------------------
CREATE TABLE `cabinet_day_data_201203` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=1379 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201204
-- ----------------------------
CREATE TABLE `cabinet_day_data_201204` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=2479 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201205
-- ----------------------------
CREATE TABLE `cabinet_day_data_201205` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=2372 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201206
-- ----------------------------
CREATE TABLE `cabinet_day_data_201206` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=2546 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201207
-- ----------------------------
CREATE TABLE `cabinet_day_data_201207` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=130 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201208
-- ----------------------------
CREATE TABLE `cabinet_day_data_201208` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201209
-- ----------------------------
CREATE TABLE `cabinet_day_data_201209` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201210
-- ----------------------------
CREATE TABLE `cabinet_day_data_201210` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201211
-- ----------------------------
CREATE TABLE `cabinet_day_data_201211` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201212
-- ----------------------------
CREATE TABLE `cabinet_day_data_201212` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201301
-- ----------------------------
CREATE TABLE `cabinet_day_data_201301` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201302
-- ----------------------------
CREATE TABLE `cabinet_day_data_201302` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201303
-- ----------------------------
CREATE TABLE `cabinet_day_data_201303` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201304
-- ----------------------------
CREATE TABLE `cabinet_day_data_201304` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201305
-- ----------------------------
CREATE TABLE `cabinet_day_data_201305` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201306
-- ----------------------------
CREATE TABLE `cabinet_day_data_201306` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201307
-- ----------------------------
CREATE TABLE `cabinet_day_data_201307` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201308
-- ----------------------------
CREATE TABLE `cabinet_day_data_201308` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201309
-- ----------------------------
CREATE TABLE `cabinet_day_data_201309` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201310
-- ----------------------------
CREATE TABLE `cabinet_day_data_201310` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201311
-- ----------------------------
CREATE TABLE `cabinet_day_data_201311` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201312
-- ----------------------------
CREATE TABLE `cabinet_day_data_201312` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201401
-- ----------------------------
CREATE TABLE `cabinet_day_data_201401` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201402
-- ----------------------------
CREATE TABLE `cabinet_day_data_201402` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201403
-- ----------------------------
CREATE TABLE `cabinet_day_data_201403` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201404
-- ----------------------------
CREATE TABLE `cabinet_day_data_201404` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201405
-- ----------------------------
CREATE TABLE `cabinet_day_data_201405` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201406
-- ----------------------------
CREATE TABLE `cabinet_day_data_201406` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201407
-- ----------------------------
CREATE TABLE `cabinet_day_data_201407` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201408
-- ----------------------------
CREATE TABLE `cabinet_day_data_201408` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201409
-- ----------------------------
CREATE TABLE `cabinet_day_data_201409` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201410
-- ----------------------------
CREATE TABLE `cabinet_day_data_201410` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201411
-- ----------------------------
CREATE TABLE `cabinet_day_data_201411` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201412
-- ----------------------------
CREATE TABLE `cabinet_day_data_201412` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201501
-- ----------------------------
CREATE TABLE `cabinet_day_data_201501` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201502
-- ----------------------------
CREATE TABLE `cabinet_day_data_201502` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201503
-- ----------------------------
CREATE TABLE `cabinet_day_data_201503` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201504
-- ----------------------------
CREATE TABLE `cabinet_day_data_201504` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201505
-- ----------------------------
CREATE TABLE `cabinet_day_data_201505` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201506
-- ----------------------------
CREATE TABLE `cabinet_day_data_201506` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201507
-- ----------------------------
CREATE TABLE `cabinet_day_data_201507` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201508
-- ----------------------------
CREATE TABLE `cabinet_day_data_201508` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201509
-- ----------------------------
CREATE TABLE `cabinet_day_data_201509` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201510
-- ----------------------------
CREATE TABLE `cabinet_day_data_201510` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201511
-- ----------------------------
CREATE TABLE `cabinet_day_data_201511` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for cabinet_day_data_201512
-- ----------------------------
CREATE TABLE `cabinet_day_data_201512` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=624 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for chart_group
-- ----------------------------
CREATE TABLE `chart_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupName` varchar(255) COLLATE utf8_bin NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=88 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200001
-- ----------------------------
CREATE TABLE `collector_day_data_200001` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200002
-- ----------------------------
CREATE TABLE `collector_day_data_200002` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200003
-- ----------------------------
CREATE TABLE `collector_day_data_200003` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200004
-- ----------------------------
CREATE TABLE `collector_day_data_200004` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200005
-- ----------------------------
CREATE TABLE `collector_day_data_200005` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200006
-- ----------------------------
CREATE TABLE `collector_day_data_200006` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200007
-- ----------------------------
CREATE TABLE `collector_day_data_200007` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200008
-- ----------------------------
CREATE TABLE `collector_day_data_200008` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200009
-- ----------------------------
CREATE TABLE `collector_day_data_200009` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200010
-- ----------------------------
CREATE TABLE `collector_day_data_200010` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200011
-- ----------------------------
CREATE TABLE `collector_day_data_200011` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200012
-- ----------------------------
CREATE TABLE `collector_day_data_200012` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200101
-- ----------------------------
CREATE TABLE `collector_day_data_200101` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200102
-- ----------------------------
CREATE TABLE `collector_day_data_200102` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200103
-- ----------------------------
CREATE TABLE `collector_day_data_200103` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200104
-- ----------------------------
CREATE TABLE `collector_day_data_200104` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200105
-- ----------------------------
CREATE TABLE `collector_day_data_200105` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200106
-- ----------------------------
CREATE TABLE `collector_day_data_200106` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200107
-- ----------------------------
CREATE TABLE `collector_day_data_200107` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200108
-- ----------------------------
CREATE TABLE `collector_day_data_200108` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200109
-- ----------------------------
CREATE TABLE `collector_day_data_200109` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200110
-- ----------------------------
CREATE TABLE `collector_day_data_200110` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200111
-- ----------------------------
CREATE TABLE `collector_day_data_200111` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200112
-- ----------------------------
CREATE TABLE `collector_day_data_200112` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200201
-- ----------------------------
CREATE TABLE `collector_day_data_200201` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200202
-- ----------------------------
CREATE TABLE `collector_day_data_200202` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200203
-- ----------------------------
CREATE TABLE `collector_day_data_200203` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200204
-- ----------------------------
CREATE TABLE `collector_day_data_200204` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200205
-- ----------------------------
CREATE TABLE `collector_day_data_200205` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200206
-- ----------------------------
CREATE TABLE `collector_day_data_200206` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200207
-- ----------------------------
CREATE TABLE `collector_day_data_200207` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200208
-- ----------------------------
CREATE TABLE `collector_day_data_200208` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200209
-- ----------------------------
CREATE TABLE `collector_day_data_200209` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200210
-- ----------------------------
CREATE TABLE `collector_day_data_200210` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200211
-- ----------------------------
CREATE TABLE `collector_day_data_200211` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200212
-- ----------------------------
CREATE TABLE `collector_day_data_200212` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200301
-- ----------------------------
CREATE TABLE `collector_day_data_200301` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200302
-- ----------------------------
CREATE TABLE `collector_day_data_200302` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200303
-- ----------------------------
CREATE TABLE `collector_day_data_200303` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200304
-- ----------------------------
CREATE TABLE `collector_day_data_200304` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200305
-- ----------------------------
CREATE TABLE `collector_day_data_200305` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200306
-- ----------------------------
CREATE TABLE `collector_day_data_200306` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200307
-- ----------------------------
CREATE TABLE `collector_day_data_200307` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200308
-- ----------------------------
CREATE TABLE `collector_day_data_200308` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200309
-- ----------------------------
CREATE TABLE `collector_day_data_200309` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200310
-- ----------------------------
CREATE TABLE `collector_day_data_200310` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200311
-- ----------------------------
CREATE TABLE `collector_day_data_200311` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200312
-- ----------------------------
CREATE TABLE `collector_day_data_200312` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200401
-- ----------------------------
CREATE TABLE `collector_day_data_200401` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200402
-- ----------------------------
CREATE TABLE `collector_day_data_200402` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200403
-- ----------------------------
CREATE TABLE `collector_day_data_200403` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200404
-- ----------------------------
CREATE TABLE `collector_day_data_200404` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200405
-- ----------------------------
CREATE TABLE `collector_day_data_200405` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200406
-- ----------------------------
CREATE TABLE `collector_day_data_200406` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200407
-- ----------------------------
CREATE TABLE `collector_day_data_200407` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200408
-- ----------------------------
CREATE TABLE `collector_day_data_200408` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200409
-- ----------------------------
CREATE TABLE `collector_day_data_200409` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200410
-- ----------------------------
CREATE TABLE `collector_day_data_200410` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200411
-- ----------------------------
CREATE TABLE `collector_day_data_200411` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200412
-- ----------------------------
CREATE TABLE `collector_day_data_200412` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200501
-- ----------------------------
CREATE TABLE `collector_day_data_200501` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200502
-- ----------------------------
CREATE TABLE `collector_day_data_200502` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200503
-- ----------------------------
CREATE TABLE `collector_day_data_200503` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200504
-- ----------------------------
CREATE TABLE `collector_day_data_200504` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200505
-- ----------------------------
CREATE TABLE `collector_day_data_200505` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200506
-- ----------------------------
CREATE TABLE `collector_day_data_200506` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200507
-- ----------------------------
CREATE TABLE `collector_day_data_200507` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200508
-- ----------------------------
CREATE TABLE `collector_day_data_200508` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200509
-- ----------------------------
CREATE TABLE `collector_day_data_200509` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200510
-- ----------------------------
CREATE TABLE `collector_day_data_200510` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200511
-- ----------------------------
CREATE TABLE `collector_day_data_200511` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200512
-- ----------------------------
CREATE TABLE `collector_day_data_200512` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200601
-- ----------------------------
CREATE TABLE `collector_day_data_200601` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200602
-- ----------------------------
CREATE TABLE `collector_day_data_200602` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200603
-- ----------------------------
CREATE TABLE `collector_day_data_200603` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200604
-- ----------------------------
CREATE TABLE `collector_day_data_200604` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200605
-- ----------------------------
CREATE TABLE `collector_day_data_200605` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200606
-- ----------------------------
CREATE TABLE `collector_day_data_200606` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200607
-- ----------------------------
CREATE TABLE `collector_day_data_200607` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200608
-- ----------------------------
CREATE TABLE `collector_day_data_200608` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200609
-- ----------------------------
CREATE TABLE `collector_day_data_200609` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200610
-- ----------------------------
CREATE TABLE `collector_day_data_200610` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200611
-- ----------------------------
CREATE TABLE `collector_day_data_200611` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200612
-- ----------------------------
CREATE TABLE `collector_day_data_200612` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200701
-- ----------------------------
CREATE TABLE `collector_day_data_200701` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200702
-- ----------------------------
CREATE TABLE `collector_day_data_200702` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200703
-- ----------------------------
CREATE TABLE `collector_day_data_200703` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200704
-- ----------------------------
CREATE TABLE `collector_day_data_200704` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200705
-- ----------------------------
CREATE TABLE `collector_day_data_200705` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200706
-- ----------------------------
CREATE TABLE `collector_day_data_200706` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200707
-- ----------------------------
CREATE TABLE `collector_day_data_200707` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200708
-- ----------------------------
CREATE TABLE `collector_day_data_200708` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200709
-- ----------------------------
CREATE TABLE `collector_day_data_200709` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200710
-- ----------------------------
CREATE TABLE `collector_day_data_200710` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200711
-- ----------------------------
CREATE TABLE `collector_day_data_200711` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200712
-- ----------------------------
CREATE TABLE `collector_day_data_200712` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200801
-- ----------------------------
CREATE TABLE `collector_day_data_200801` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200802
-- ----------------------------
CREATE TABLE `collector_day_data_200802` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200803
-- ----------------------------
CREATE TABLE `collector_day_data_200803` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200804
-- ----------------------------
CREATE TABLE `collector_day_data_200804` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200805
-- ----------------------------
CREATE TABLE `collector_day_data_200805` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200806
-- ----------------------------
CREATE TABLE `collector_day_data_200806` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200807
-- ----------------------------
CREATE TABLE `collector_day_data_200807` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200808
-- ----------------------------
CREATE TABLE `collector_day_data_200808` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200809
-- ----------------------------
CREATE TABLE `collector_day_data_200809` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200810
-- ----------------------------
CREATE TABLE `collector_day_data_200810` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200811
-- ----------------------------
CREATE TABLE `collector_day_data_200811` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200812
-- ----------------------------
CREATE TABLE `collector_day_data_200812` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200901
-- ----------------------------
CREATE TABLE `collector_day_data_200901` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200902
-- ----------------------------
CREATE TABLE `collector_day_data_200902` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200903
-- ----------------------------
CREATE TABLE `collector_day_data_200903` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200904
-- ----------------------------
CREATE TABLE `collector_day_data_200904` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200905
-- ----------------------------
CREATE TABLE `collector_day_data_200905` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200906
-- ----------------------------
CREATE TABLE `collector_day_data_200906` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200907
-- ----------------------------
CREATE TABLE `collector_day_data_200907` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200908
-- ----------------------------
CREATE TABLE `collector_day_data_200908` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200909
-- ----------------------------
CREATE TABLE `collector_day_data_200909` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200910
-- ----------------------------
CREATE TABLE `collector_day_data_200910` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200911
-- ----------------------------
CREATE TABLE `collector_day_data_200911` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_200912
-- ----------------------------
CREATE TABLE `collector_day_data_200912` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201001
-- ----------------------------
CREATE TABLE `collector_day_data_201001` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201002
-- ----------------------------
CREATE TABLE `collector_day_data_201002` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201003
-- ----------------------------
CREATE TABLE `collector_day_data_201003` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201004
-- ----------------------------
CREATE TABLE `collector_day_data_201004` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201005
-- ----------------------------
CREATE TABLE `collector_day_data_201005` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201006
-- ----------------------------
CREATE TABLE `collector_day_data_201006` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201007
-- ----------------------------
CREATE TABLE `collector_day_data_201007` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201008
-- ----------------------------
CREATE TABLE `collector_day_data_201008` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201009
-- ----------------------------
CREATE TABLE `collector_day_data_201009` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201010
-- ----------------------------
CREATE TABLE `collector_day_data_201010` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201011
-- ----------------------------
CREATE TABLE `collector_day_data_201011` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201012
-- ----------------------------
CREATE TABLE `collector_day_data_201012` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201101
-- ----------------------------
CREATE TABLE `collector_day_data_201101` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201102
-- ----------------------------
CREATE TABLE `collector_day_data_201102` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201103
-- ----------------------------
CREATE TABLE `collector_day_data_201103` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201104
-- ----------------------------
CREATE TABLE `collector_day_data_201104` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=182348 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for collector_day_data_201105
-- ----------------------------
CREATE TABLE `collector_day_data_201105` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=182557 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for collector_day_data_201106
-- ----------------------------
CREATE TABLE `collector_day_data_201106` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=182822 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for collector_day_data_201107
-- ----------------------------
CREATE TABLE `collector_day_data_201107` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=183342 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for collector_day_data_201108
-- ----------------------------
CREATE TABLE `collector_day_data_201108` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=627 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201109
-- ----------------------------
CREATE TABLE `collector_day_data_201109` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=870 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201110
-- ----------------------------
CREATE TABLE `collector_day_data_201110` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=1018 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201111
-- ----------------------------
CREATE TABLE `collector_day_data_201111` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=1115 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201112
-- ----------------------------
CREATE TABLE `collector_day_data_201112` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=1522 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201201
-- ----------------------------
CREATE TABLE `collector_day_data_201201` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=1688 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201202
-- ----------------------------
CREATE TABLE `collector_day_data_201202` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=1613 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201203
-- ----------------------------
CREATE TABLE `collector_day_data_201203` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=1577 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201204
-- ----------------------------
CREATE TABLE `collector_day_data_201204` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=1650 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201205
-- ----------------------------
CREATE TABLE `collector_day_data_201205` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=2051 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201206
-- ----------------------------
CREATE TABLE `collector_day_data_201206` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=1876 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201207
-- ----------------------------
CREATE TABLE `collector_day_data_201207` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201208
-- ----------------------------
CREATE TABLE `collector_day_data_201208` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201209
-- ----------------------------
CREATE TABLE `collector_day_data_201209` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201210
-- ----------------------------
CREATE TABLE `collector_day_data_201210` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201211
-- ----------------------------
CREATE TABLE `collector_day_data_201211` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201212
-- ----------------------------
CREATE TABLE `collector_day_data_201212` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201301
-- ----------------------------
CREATE TABLE `collector_day_data_201301` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201302
-- ----------------------------
CREATE TABLE `collector_day_data_201302` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201303
-- ----------------------------
CREATE TABLE `collector_day_data_201303` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201304
-- ----------------------------
CREATE TABLE `collector_day_data_201304` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201305
-- ----------------------------
CREATE TABLE `collector_day_data_201305` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201306
-- ----------------------------
CREATE TABLE `collector_day_data_201306` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201307
-- ----------------------------
CREATE TABLE `collector_day_data_201307` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201308
-- ----------------------------
CREATE TABLE `collector_day_data_201308` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201309
-- ----------------------------
CREATE TABLE `collector_day_data_201309` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201310
-- ----------------------------
CREATE TABLE `collector_day_data_201310` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201311
-- ----------------------------
CREATE TABLE `collector_day_data_201311` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201312
-- ----------------------------
CREATE TABLE `collector_day_data_201312` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201401
-- ----------------------------
CREATE TABLE `collector_day_data_201401` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201402
-- ----------------------------
CREATE TABLE `collector_day_data_201402` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201403
-- ----------------------------
CREATE TABLE `collector_day_data_201403` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201404
-- ----------------------------
CREATE TABLE `collector_day_data_201404` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201405
-- ----------------------------
CREATE TABLE `collector_day_data_201405` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201406
-- ----------------------------
CREATE TABLE `collector_day_data_201406` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201407
-- ----------------------------
CREATE TABLE `collector_day_data_201407` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201408
-- ----------------------------
CREATE TABLE `collector_day_data_201408` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201409
-- ----------------------------
CREATE TABLE `collector_day_data_201409` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201410
-- ----------------------------
CREATE TABLE `collector_day_data_201410` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201411
-- ----------------------------
CREATE TABLE `collector_day_data_201411` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201412
-- ----------------------------
CREATE TABLE `collector_day_data_201412` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201501
-- ----------------------------
CREATE TABLE `collector_day_data_201501` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201502
-- ----------------------------
CREATE TABLE `collector_day_data_201502` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201503
-- ----------------------------
CREATE TABLE `collector_day_data_201503` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201504
-- ----------------------------
CREATE TABLE `collector_day_data_201504` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201505
-- ----------------------------
CREATE TABLE `collector_day_data_201505` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201506
-- ----------------------------
CREATE TABLE `collector_day_data_201506` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201507
-- ----------------------------
CREATE TABLE `collector_day_data_201507` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201508
-- ----------------------------
CREATE TABLE `collector_day_data_201508` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201509
-- ----------------------------
CREATE TABLE `collector_day_data_201509` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201510
-- ----------------------------
CREATE TABLE `collector_day_data_201510` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201511
-- ----------------------------
CREATE TABLE `collector_day_data_201511` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_day_data_201512
-- ----------------------------
CREATE TABLE `collector_day_data_201512` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectorID2sendDay2monitorCode_index` (`collectorID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_info
-- ----------------------------
CREATE TABLE `collector_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) CHARACTER SET utf8 COLLATE utf8_swedish_ci NOT NULL,
  `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_swedish_ci NOT NULL,
  `isUsed` bit(1) NOT NULL,
  `import_date` datetime DEFAULT NULL,
  `descr` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `limit_date` datetime DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `mac` varchar(16) COLLATE utf8_bin DEFAULT NULL,
  `pno` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `createdate` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `encryption` varchar(32) COLLATE utf8_bin DEFAULT NULL,
  `pwd_key` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_code` (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=110429026 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_monthday_data_2000
-- ----------------------------
CREATE TABLE `collector_monthday_data_2000` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID2month_index` (`collectorID`,`month`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_monthday_data_2001
-- ----------------------------
CREATE TABLE `collector_monthday_data_2001` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID2month_index` (`collectorID`,`month`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_monthday_data_2002
-- ----------------------------
CREATE TABLE `collector_monthday_data_2002` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID2month_index` (`collectorID`,`month`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_monthday_data_2003
-- ----------------------------
CREATE TABLE `collector_monthday_data_2003` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID2month_index` (`collectorID`,`month`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_monthday_data_2004
-- ----------------------------
CREATE TABLE `collector_monthday_data_2004` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID2month_index` (`collectorID`,`month`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_monthday_data_2005
-- ----------------------------
CREATE TABLE `collector_monthday_data_2005` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID2month_index` (`collectorID`,`month`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_monthday_data_2006
-- ----------------------------
CREATE TABLE `collector_monthday_data_2006` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID2month_index` (`collectorID`,`month`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_monthday_data_2007
-- ----------------------------
CREATE TABLE `collector_monthday_data_2007` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  `monitorCode` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID2month_index` (`collectorID`,`month`)
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_monthday_data_2008
-- ----------------------------
CREATE TABLE `collector_monthday_data_2008` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  `monitorCode` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID2month_index` (`collectorID`,`month`)
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_monthday_data_2009
-- ----------------------------
CREATE TABLE `collector_monthday_data_2009` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  `monitorCode` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID2month_index` (`collectorID`,`month`)
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_monthday_data_2010
-- ----------------------------
CREATE TABLE `collector_monthday_data_2010` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  `monitorCode` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID2month_index` (`collectorID`,`month`)
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_monthday_data_2011
-- ----------------------------
CREATE TABLE `collector_monthday_data_2011` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,2) DEFAULT NULL,
  `d_2` float(11,2) DEFAULT NULL,
  `d_3` float(11,2) DEFAULT NULL,
  `d_4` float(11,2) DEFAULT NULL,
  `d_5` float(11,2) DEFAULT NULL,
  `d_6` float(11,2) DEFAULT NULL,
  `d_7` float(11,2) DEFAULT NULL,
  `d_8` float(11,2) DEFAULT NULL,
  `d_9` float(11,2) DEFAULT NULL,
  `d_10` float(11,2) DEFAULT NULL,
  `d_11` float(11,2) DEFAULT NULL,
  `d_12` float(11,2) DEFAULT NULL,
  `d_13` float(11,2) DEFAULT NULL,
  `d_14` float(11,2) DEFAULT NULL,
  `d_15` float(11,2) DEFAULT NULL,
  `d_16` float(11,2) DEFAULT NULL,
  `d_17` float(11,2) DEFAULT NULL,
  `d_18` float(11,2) DEFAULT NULL,
  `d_19` float(11,2) DEFAULT NULL,
  `d_20` float(11,2) DEFAULT NULL,
  `d_21` float(11,2) DEFAULT NULL,
  `d_22` float(11,2) DEFAULT NULL,
  `d_23` float(11,2) DEFAULT NULL,
  `d_24` float(11,2) DEFAULT NULL,
  `d_25` float(11,2) DEFAULT NULL,
  `d_26` float(11,2) DEFAULT NULL,
  `d_27` float(11,2) DEFAULT NULL,
  `d_28` float(11,2) DEFAULT NULL,
  `d_29` float(11,2) DEFAULT NULL,
  `d_30` float(11,2) DEFAULT NULL,
  `d_31` float(11,2) DEFAULT NULL,
  `monitorCode` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID2month_index` (`collectorID`,`month`)
) ENGINE=MyISAM AUTO_INCREMENT=171 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_monthday_data_2012
-- ----------------------------
CREATE TABLE `collector_monthday_data_2012` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  `monitorCode` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID2month_index` (`collectorID`,`month`)
) ENGINE=MyISAM AUTO_INCREMENT=281 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_monthday_data_2013
-- ----------------------------
CREATE TABLE `collector_monthday_data_2013` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID2month_index` (`collectorID`,`month`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_monthday_data_2014
-- ----------------------------
CREATE TABLE `collector_monthday_data_2014` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID2month_index` (`collectorID`,`month`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_monthday_data_2015
-- ----------------------------
CREATE TABLE `collector_monthday_data_2015` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID2month_index` (`collectorID`,`month`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_run_data
-- ----------------------------
CREATE TABLE `collector_run_data` (
  `collectorID` int(11) NOT NULL DEFAULT '0',
  `day_energy` float(11,2) NOT NULL,
  `total_energy` float(11,2) NOT NULL,
  `power` float(11,2) NOT NULL,
  `sun_strength` float(11,2) DEFAULT NULL,
  `wind_speed` double(18,2) DEFAULT NULL,
  `wind_direction` float(11,2) DEFAULT NULL,
  `temperature` float(11,2) DEFAULT NULL,
  `sendTime` datetime NOT NULL,
  PRIMARY KEY (`collectorID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_year_data
-- ----------------------------
CREATE TABLE `collector_year_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `year` smallint(4) NOT NULL,
  `dataValue` float(11,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID2year_index` (`collectorID`,`year`),
  KEY `collectorID_index` (`collectorID`),
  KEY `year_index` (`year`)
) ENGINE=MyISAM AUTO_INCREMENT=159 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for collector_yearmonth_data
-- ----------------------------
CREATE TABLE `collector_yearmonth_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) NOT NULL,
  `year` smallint(4) NOT NULL,
  `m_1` float(11,2) DEFAULT NULL,
  `m_2` float(11,2) DEFAULT NULL,
  `m_3` float(11,2) DEFAULT NULL,
  `m_4` float(11,2) DEFAULT NULL,
  `m_5` float(11,2) DEFAULT NULL,
  `m_6` float(11,2) DEFAULT NULL,
  `m_7` float(11,2) DEFAULT NULL,
  `m_8` float(11,2) DEFAULT NULL,
  `m_9` float(11,2) DEFAULT NULL,
  `m_10` float(11,2) DEFAULT NULL,
  `m_11` float(11,2) DEFAULT NULL,
  `m_12` float(11,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID2year_index` (`collectorID`,`year`)
) ENGINE=MyISAM AUTO_INCREMENT=162 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for commoninfo
-- ----------------------------
CREATE TABLE `commoninfo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for countrycity
-- ----------------------------
CREATE TABLE `countrycity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sort_order` int(11) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  `weather_code` varchar(20) DEFAULT NULL,
  `startdate` varchar(20) DEFAULT NULL,
  `enddate` varchar(20) DEFAULT NULL,
  `hours` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=206 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for custom_chart
-- ----------------------------
CREATE TABLE `custom_chart` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userId` int(11) NOT NULL COMMENT '用户id',
  `subType` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '图表类型(区域area; 条状: bar; 柱形: column; 曲线: line)',
  `customType` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '1，普通图表2：多设备比较图表；3多时间段比较图表',
  `groupId` int(11) unsigned zerofill DEFAULT NULL COMMENT '分组ID',
  `reportName` varchar(150) COLLATE utf8_bin DEFAULT NULL COMMENT '报表名称',
  `timeSlot` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `tcounter` int(11) DEFAULT NULL,
  `timeInterval` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `product` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  `times` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `productName` varchar(1500) COLLATE utf8_bin DEFAULT NULL,
  `plantId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=171 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for dataitem
-- ----------------------------
CREATE TABLE `dataitem` (
  `id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(500) DEFAULT NULL,
  `enabled` bit(1) DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=112 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for dbconfig
-- ----------------------------
CREATE TABLE `dbconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `year` varchar(200) COLLATE utf8_bin NOT NULL,
  `url` varchar(100) COLLATE utf8_bin NOT NULL,
  `isenabled` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for definereport
-- ----------------------------
CREATE TABLE `definereport` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `reportName` varchar(50) DEFAULT NULL,
  `reportType` int(11) DEFAULT NULL,
  `plantId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `dataitem` varchar(255) DEFAULT NULL,
  `saveTime` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=2565 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for detector_day_data_200001
-- ----------------------------
CREATE TABLE `detector_day_data_200001` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200002
-- ----------------------------
CREATE TABLE `detector_day_data_200002` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200003
-- ----------------------------
CREATE TABLE `detector_day_data_200003` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200004
-- ----------------------------
CREATE TABLE `detector_day_data_200004` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200005
-- ----------------------------
CREATE TABLE `detector_day_data_200005` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200006
-- ----------------------------
CREATE TABLE `detector_day_data_200006` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200007
-- ----------------------------
CREATE TABLE `detector_day_data_200007` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200008
-- ----------------------------
CREATE TABLE `detector_day_data_200008` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200009
-- ----------------------------
CREATE TABLE `detector_day_data_200009` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200010
-- ----------------------------
CREATE TABLE `detector_day_data_200010` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200011
-- ----------------------------
CREATE TABLE `detector_day_data_200011` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200012
-- ----------------------------
CREATE TABLE `detector_day_data_200012` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200101
-- ----------------------------
CREATE TABLE `detector_day_data_200101` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200102
-- ----------------------------
CREATE TABLE `detector_day_data_200102` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200103
-- ----------------------------
CREATE TABLE `detector_day_data_200103` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200104
-- ----------------------------
CREATE TABLE `detector_day_data_200104` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200105
-- ----------------------------
CREATE TABLE `detector_day_data_200105` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200106
-- ----------------------------
CREATE TABLE `detector_day_data_200106` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200107
-- ----------------------------
CREATE TABLE `detector_day_data_200107` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200108
-- ----------------------------
CREATE TABLE `detector_day_data_200108` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200109
-- ----------------------------
CREATE TABLE `detector_day_data_200109` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200110
-- ----------------------------
CREATE TABLE `detector_day_data_200110` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200111
-- ----------------------------
CREATE TABLE `detector_day_data_200111` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200112
-- ----------------------------
CREATE TABLE `detector_day_data_200112` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200201
-- ----------------------------
CREATE TABLE `detector_day_data_200201` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200202
-- ----------------------------
CREATE TABLE `detector_day_data_200202` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200203
-- ----------------------------
CREATE TABLE `detector_day_data_200203` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200204
-- ----------------------------
CREATE TABLE `detector_day_data_200204` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200205
-- ----------------------------
CREATE TABLE `detector_day_data_200205` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200206
-- ----------------------------
CREATE TABLE `detector_day_data_200206` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200207
-- ----------------------------
CREATE TABLE `detector_day_data_200207` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200208
-- ----------------------------
CREATE TABLE `detector_day_data_200208` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200209
-- ----------------------------
CREATE TABLE `detector_day_data_200209` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200210
-- ----------------------------
CREATE TABLE `detector_day_data_200210` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200211
-- ----------------------------
CREATE TABLE `detector_day_data_200211` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200212
-- ----------------------------
CREATE TABLE `detector_day_data_200212` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200301
-- ----------------------------
CREATE TABLE `detector_day_data_200301` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200302
-- ----------------------------
CREATE TABLE `detector_day_data_200302` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200303
-- ----------------------------
CREATE TABLE `detector_day_data_200303` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200304
-- ----------------------------
CREATE TABLE `detector_day_data_200304` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200305
-- ----------------------------
CREATE TABLE `detector_day_data_200305` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200306
-- ----------------------------
CREATE TABLE `detector_day_data_200306` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200307
-- ----------------------------
CREATE TABLE `detector_day_data_200307` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200308
-- ----------------------------
CREATE TABLE `detector_day_data_200308` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200309
-- ----------------------------
CREATE TABLE `detector_day_data_200309` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200310
-- ----------------------------
CREATE TABLE `detector_day_data_200310` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200311
-- ----------------------------
CREATE TABLE `detector_day_data_200311` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200312
-- ----------------------------
CREATE TABLE `detector_day_data_200312` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200401
-- ----------------------------
CREATE TABLE `detector_day_data_200401` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200402
-- ----------------------------
CREATE TABLE `detector_day_data_200402` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200403
-- ----------------------------
CREATE TABLE `detector_day_data_200403` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200404
-- ----------------------------
CREATE TABLE `detector_day_data_200404` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200405
-- ----------------------------
CREATE TABLE `detector_day_data_200405` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200406
-- ----------------------------
CREATE TABLE `detector_day_data_200406` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200407
-- ----------------------------
CREATE TABLE `detector_day_data_200407` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200408
-- ----------------------------
CREATE TABLE `detector_day_data_200408` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200409
-- ----------------------------
CREATE TABLE `detector_day_data_200409` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200410
-- ----------------------------
CREATE TABLE `detector_day_data_200410` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200411
-- ----------------------------
CREATE TABLE `detector_day_data_200411` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200412
-- ----------------------------
CREATE TABLE `detector_day_data_200412` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200501
-- ----------------------------
CREATE TABLE `detector_day_data_200501` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200502
-- ----------------------------
CREATE TABLE `detector_day_data_200502` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200503
-- ----------------------------
CREATE TABLE `detector_day_data_200503` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200504
-- ----------------------------
CREATE TABLE `detector_day_data_200504` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200505
-- ----------------------------
CREATE TABLE `detector_day_data_200505` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200506
-- ----------------------------
CREATE TABLE `detector_day_data_200506` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200507
-- ----------------------------
CREATE TABLE `detector_day_data_200507` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200508
-- ----------------------------
CREATE TABLE `detector_day_data_200508` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200509
-- ----------------------------
CREATE TABLE `detector_day_data_200509` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200510
-- ----------------------------
CREATE TABLE `detector_day_data_200510` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200511
-- ----------------------------
CREATE TABLE `detector_day_data_200511` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200512
-- ----------------------------
CREATE TABLE `detector_day_data_200512` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200601
-- ----------------------------
CREATE TABLE `detector_day_data_200601` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200602
-- ----------------------------
CREATE TABLE `detector_day_data_200602` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200603
-- ----------------------------
CREATE TABLE `detector_day_data_200603` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200604
-- ----------------------------
CREATE TABLE `detector_day_data_200604` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200605
-- ----------------------------
CREATE TABLE `detector_day_data_200605` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200606
-- ----------------------------
CREATE TABLE `detector_day_data_200606` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200607
-- ----------------------------
CREATE TABLE `detector_day_data_200607` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200608
-- ----------------------------
CREATE TABLE `detector_day_data_200608` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200609
-- ----------------------------
CREATE TABLE `detector_day_data_200609` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200610
-- ----------------------------
CREATE TABLE `detector_day_data_200610` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200611
-- ----------------------------
CREATE TABLE `detector_day_data_200611` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200612
-- ----------------------------
CREATE TABLE `detector_day_data_200612` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200701
-- ----------------------------
CREATE TABLE `detector_day_data_200701` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200702
-- ----------------------------
CREATE TABLE `detector_day_data_200702` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200703
-- ----------------------------
CREATE TABLE `detector_day_data_200703` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200704
-- ----------------------------
CREATE TABLE `detector_day_data_200704` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200705
-- ----------------------------
CREATE TABLE `detector_day_data_200705` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200706
-- ----------------------------
CREATE TABLE `detector_day_data_200706` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200707
-- ----------------------------
CREATE TABLE `detector_day_data_200707` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200708
-- ----------------------------
CREATE TABLE `detector_day_data_200708` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200709
-- ----------------------------
CREATE TABLE `detector_day_data_200709` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200710
-- ----------------------------
CREATE TABLE `detector_day_data_200710` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200711
-- ----------------------------
CREATE TABLE `detector_day_data_200711` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200712
-- ----------------------------
CREATE TABLE `detector_day_data_200712` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200801
-- ----------------------------
CREATE TABLE `detector_day_data_200801` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200802
-- ----------------------------
CREATE TABLE `detector_day_data_200802` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200803
-- ----------------------------
CREATE TABLE `detector_day_data_200803` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200804
-- ----------------------------
CREATE TABLE `detector_day_data_200804` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200805
-- ----------------------------
CREATE TABLE `detector_day_data_200805` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200806
-- ----------------------------
CREATE TABLE `detector_day_data_200806` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200807
-- ----------------------------
CREATE TABLE `detector_day_data_200807` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200808
-- ----------------------------
CREATE TABLE `detector_day_data_200808` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200809
-- ----------------------------
CREATE TABLE `detector_day_data_200809` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200810
-- ----------------------------
CREATE TABLE `detector_day_data_200810` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200811
-- ----------------------------
CREATE TABLE `detector_day_data_200811` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200812
-- ----------------------------
CREATE TABLE `detector_day_data_200812` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200901
-- ----------------------------
CREATE TABLE `detector_day_data_200901` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200902
-- ----------------------------
CREATE TABLE `detector_day_data_200902` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200903
-- ----------------------------
CREATE TABLE `detector_day_data_200903` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200904
-- ----------------------------
CREATE TABLE `detector_day_data_200904` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200905
-- ----------------------------
CREATE TABLE `detector_day_data_200905` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200906
-- ----------------------------
CREATE TABLE `detector_day_data_200906` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200907
-- ----------------------------
CREATE TABLE `detector_day_data_200907` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200908
-- ----------------------------
CREATE TABLE `detector_day_data_200908` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200909
-- ----------------------------
CREATE TABLE `detector_day_data_200909` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200910
-- ----------------------------
CREATE TABLE `detector_day_data_200910` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200911
-- ----------------------------
CREATE TABLE `detector_day_data_200911` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_200912
-- ----------------------------
CREATE TABLE `detector_day_data_200912` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201001
-- ----------------------------
CREATE TABLE `detector_day_data_201001` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201002
-- ----------------------------
CREATE TABLE `detector_day_data_201002` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201003
-- ----------------------------
CREATE TABLE `detector_day_data_201003` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201004
-- ----------------------------
CREATE TABLE `detector_day_data_201004` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201005
-- ----------------------------
CREATE TABLE `detector_day_data_201005` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201006
-- ----------------------------
CREATE TABLE `detector_day_data_201006` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201007
-- ----------------------------
CREATE TABLE `detector_day_data_201007` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201008
-- ----------------------------
CREATE TABLE `detector_day_data_201008` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201009
-- ----------------------------
CREATE TABLE `detector_day_data_201009` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201010
-- ----------------------------
CREATE TABLE `detector_day_data_201010` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201011
-- ----------------------------
CREATE TABLE `detector_day_data_201011` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201012
-- ----------------------------
CREATE TABLE `detector_day_data_201012` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201101
-- ----------------------------
CREATE TABLE `detector_day_data_201101` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201102
-- ----------------------------
CREATE TABLE `detector_day_data_201102` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201103
-- ----------------------------
CREATE TABLE `detector_day_data_201103` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201104
-- ----------------------------
CREATE TABLE `detector_day_data_201104` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=182328 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for detector_day_data_201105
-- ----------------------------
CREATE TABLE `detector_day_data_201105` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=182578 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for detector_day_data_201106
-- ----------------------------
CREATE TABLE `detector_day_data_201106` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=182820 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for detector_day_data_201107
-- ----------------------------
CREATE TABLE `detector_day_data_201107` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=183480 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for detector_day_data_201108
-- ----------------------------
CREATE TABLE `detector_day_data_201108` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=801 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201109
-- ----------------------------
CREATE TABLE `detector_day_data_201109` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=1065 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201110
-- ----------------------------
CREATE TABLE `detector_day_data_201110` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=841 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201111
-- ----------------------------
CREATE TABLE `detector_day_data_201111` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=833 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201112
-- ----------------------------
CREATE TABLE `detector_day_data_201112` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=1025 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201201
-- ----------------------------
CREATE TABLE `detector_day_data_201201` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=1177 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201202
-- ----------------------------
CREATE TABLE `detector_day_data_201202` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=1017 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201203
-- ----------------------------
CREATE TABLE `detector_day_data_201203` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=869 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201204
-- ----------------------------
CREATE TABLE `detector_day_data_201204` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=981 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201205
-- ----------------------------
CREATE TABLE `detector_day_data_201205` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=1201 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201206
-- ----------------------------
CREATE TABLE `detector_day_data_201206` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=989 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201207
-- ----------------------------
CREATE TABLE `detector_day_data_201207` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201208
-- ----------------------------
CREATE TABLE `detector_day_data_201208` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201209
-- ----------------------------
CREATE TABLE `detector_day_data_201209` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201210
-- ----------------------------
CREATE TABLE `detector_day_data_201210` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201211
-- ----------------------------
CREATE TABLE `detector_day_data_201211` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201212
-- ----------------------------
CREATE TABLE `detector_day_data_201212` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201301
-- ----------------------------
CREATE TABLE `detector_day_data_201301` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201302
-- ----------------------------
CREATE TABLE `detector_day_data_201302` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201303
-- ----------------------------
CREATE TABLE `detector_day_data_201303` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201304
-- ----------------------------
CREATE TABLE `detector_day_data_201304` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201305
-- ----------------------------
CREATE TABLE `detector_day_data_201305` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201306
-- ----------------------------
CREATE TABLE `detector_day_data_201306` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201307
-- ----------------------------
CREATE TABLE `detector_day_data_201307` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201308
-- ----------------------------
CREATE TABLE `detector_day_data_201308` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201309
-- ----------------------------
CREATE TABLE `detector_day_data_201309` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201310
-- ----------------------------
CREATE TABLE `detector_day_data_201310` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201311
-- ----------------------------
CREATE TABLE `detector_day_data_201311` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201312
-- ----------------------------
CREATE TABLE `detector_day_data_201312` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201401
-- ----------------------------
CREATE TABLE `detector_day_data_201401` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201402
-- ----------------------------
CREATE TABLE `detector_day_data_201402` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201403
-- ----------------------------
CREATE TABLE `detector_day_data_201403` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201404
-- ----------------------------
CREATE TABLE `detector_day_data_201404` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201405
-- ----------------------------
CREATE TABLE `detector_day_data_201405` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201406
-- ----------------------------
CREATE TABLE `detector_day_data_201406` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201407
-- ----------------------------
CREATE TABLE `detector_day_data_201407` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201408
-- ----------------------------
CREATE TABLE `detector_day_data_201408` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201409
-- ----------------------------
CREATE TABLE `detector_day_data_201409` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201410
-- ----------------------------
CREATE TABLE `detector_day_data_201410` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201411
-- ----------------------------
CREATE TABLE `detector_day_data_201411` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201412
-- ----------------------------
CREATE TABLE `detector_day_data_201412` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201501
-- ----------------------------
CREATE TABLE `detector_day_data_201501` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201502
-- ----------------------------
CREATE TABLE `detector_day_data_201502` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201503
-- ----------------------------
CREATE TABLE `detector_day_data_201503` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201504
-- ----------------------------
CREATE TABLE `detector_day_data_201504` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201505
-- ----------------------------
CREATE TABLE `detector_day_data_201505` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201506
-- ----------------------------
CREATE TABLE `detector_day_data_201506` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201507
-- ----------------------------
CREATE TABLE `detector_day_data_201507` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201508
-- ----------------------------
CREATE TABLE `detector_day_data_201508` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201509
-- ----------------------------
CREATE TABLE `detector_day_data_201509` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201510
-- ----------------------------
CREATE TABLE `detector_day_data_201510` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201511
-- ----------------------------
CREATE TABLE `detector_day_data_201511` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for detector_day_data_201512
-- ----------------------------
CREATE TABLE `detector_day_data_201512` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for device
-- ----------------------------
CREATE TABLE `device` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `deviceTypeCode` smallint(6) NOT NULL,
  `deviceAddress` varchar(20) COLLATE utf8_swedish_ci NOT NULL,
  `deviceModelCode` smallint(6) NOT NULL,
  `collectorID` int(11) NOT NULL,
  `Status` varchar(10) COLLATE utf8_swedish_ci NOT NULL DEFAULT '0',
  `currentPower` varchar(255) COLLATE utf8_swedish_ci DEFAULT NULL,
  `isHidden` bit(1) NOT NULL DEFAULT b'0',
  `name` varchar(100) COLLATE utf8_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID_index` (`collectorID`),
  KEY `collectorIDhidden_index` (`collectorID`,`isHidden`)
) ENGINE=MyISAM AUTO_INCREMENT=2133 DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

-- ----------------------------
-- Table structure for device_model
-- ----------------------------
CREATE TABLE `device_model` (
  `code` smallint(6) NOT NULL,
  `name` varchar(20) COLLATE utf8_bin NOT NULL,
  `modelTypeCode` smallint(6) NOT NULL,
  `designPower` float(11,2) DEFAULT NULL,
  PRIMARY KEY (`code`),
  UNIQUE KEY `index_code` (`code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for device_monthday_data_2000
-- ----------------------------
CREATE TABLE `device_monthday_data_2000` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deviceID2month_index` (`deviceID`,`month`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for device_monthday_data_2001
-- ----------------------------
CREATE TABLE `device_monthday_data_2001` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deviceID2month_index` (`deviceID`,`month`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for device_monthday_data_2002
-- ----------------------------
CREATE TABLE `device_monthday_data_2002` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deviceID2month_index` (`deviceID`,`month`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for device_monthday_data_2003
-- ----------------------------
CREATE TABLE `device_monthday_data_2003` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deviceID2month_index` (`deviceID`,`month`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for device_monthday_data_2004
-- ----------------------------
CREATE TABLE `device_monthday_data_2004` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deviceID2month_index` (`deviceID`,`month`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for device_monthday_data_2005
-- ----------------------------
CREATE TABLE `device_monthday_data_2005` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deviceID2month_index` (`deviceID`,`month`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for device_monthday_data_2006
-- ----------------------------
CREATE TABLE `device_monthday_data_2006` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deviceID2month_index` (`deviceID`,`month`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for device_monthday_data_2007
-- ----------------------------
CREATE TABLE `device_monthday_data_2007` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deviceID2month_index` (`deviceID`,`month`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for device_monthday_data_2008
-- ----------------------------
CREATE TABLE `device_monthday_data_2008` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deviceID2month_index` (`deviceID`,`month`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for device_monthday_data_2009
-- ----------------------------
CREATE TABLE `device_monthday_data_2009` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deviceID2month_index` (`deviceID`,`month`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for device_monthday_data_2010
-- ----------------------------
CREATE TABLE `device_monthday_data_2010` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deviceID2month_index` (`deviceID`,`month`)
) ENGINE=MyISAM AUTO_INCREMENT=505 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for device_monthday_data_2011
-- ----------------------------
CREATE TABLE `device_monthday_data_2011` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deviceID2month_index` (`deviceID`,`month`)
) ENGINE=MyISAM AUTO_INCREMENT=2001 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for device_monthday_data_2012
-- ----------------------------
CREATE TABLE `device_monthday_data_2012` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deviceID2month_index` (`deviceID`,`month`)
) ENGINE=MyISAM AUTO_INCREMENT=2903 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for device_monthday_data_2013
-- ----------------------------
CREATE TABLE `device_monthday_data_2013` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deviceID2month_index` (`deviceID`,`month`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for device_monthday_data_2014
-- ----------------------------
CREATE TABLE `device_monthday_data_2014` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deviceID2month_index` (`deviceID`,`month`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for device_monthday_data_2015
-- ----------------------------
CREATE TABLE `device_monthday_data_2015` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `month` tinyint(2) NOT NULL,
  `d_1` float(11,6) DEFAULT NULL,
  `d_2` float(11,6) DEFAULT NULL,
  `d_3` float(11,6) DEFAULT NULL,
  `d_4` float(11,6) DEFAULT NULL,
  `d_5` float(11,6) DEFAULT NULL,
  `d_6` float(11,6) DEFAULT NULL,
  `d_7` float(11,6) DEFAULT NULL,
  `d_8` float(11,6) DEFAULT NULL,
  `d_9` float(11,6) DEFAULT NULL,
  `d_10` float(11,6) DEFAULT NULL,
  `d_11` float(11,6) DEFAULT NULL,
  `d_12` float(11,6) DEFAULT NULL,
  `d_13` float(11,6) DEFAULT NULL,
  `d_14` float(11,6) DEFAULT NULL,
  `d_15` float(11,6) DEFAULT NULL,
  `d_16` float(11,6) DEFAULT NULL,
  `d_17` float(11,6) DEFAULT NULL,
  `d_18` float(11,6) DEFAULT NULL,
  `d_19` float(11,6) DEFAULT NULL,
  `d_20` float(11,6) DEFAULT NULL,
  `d_21` float(11,6) DEFAULT NULL,
  `d_22` float(11,6) DEFAULT NULL,
  `d_23` float(11,6) DEFAULT NULL,
  `d_24` float(11,6) DEFAULT NULL,
  `d_25` float(11,6) DEFAULT NULL,
  `d_26` float(11,6) DEFAULT NULL,
  `d_27` float(11,6) DEFAULT NULL,
  `d_28` float(11,6) DEFAULT NULL,
  `d_29` float(11,6) DEFAULT NULL,
  `d_30` float(11,6) DEFAULT NULL,
  `d_31` float(11,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deviceID2month_index` (`deviceID`,`month`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for device_run_data
-- ----------------------------
CREATE TABLE `device_run_data` (
  `deviceID` int(11) NOT NULL DEFAULT '0',
  `rundatastr` varchar(1000) DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  `totalEnergy` float(11,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`deviceID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for device_year_data
-- ----------------------------
CREATE TABLE `device_year_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `year` smallint(4) NOT NULL,
  `dataValue` float(11,6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7723 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for device_yearmonth_data
-- ----------------------------
CREATE TABLE `device_yearmonth_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `year` smallint(4) NOT NULL,
  `m_1` float(11,6) DEFAULT NULL,
  `m_2` float(11,6) DEFAULT NULL,
  `m_3` float(11,6) DEFAULT NULL,
  `m_4` float(11,6) DEFAULT NULL,
  `m_5` float(11,6) DEFAULT NULL,
  `m_6` float(11,6) DEFAULT NULL,
  `m_7` float(11,6) DEFAULT NULL,
  `m_8` float(11,6) DEFAULT NULL,
  `m_9` float(11,6) DEFAULT NULL,
  `m_10` float(11,6) DEFAULT NULL,
  `m_11` float(11,6) DEFAULT NULL,
  `m_12` float(11,6) DEFAULT NULL,
  `monitorCode` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1993 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for devicedatacount_2000
-- ----------------------------
CREATE TABLE `devicedatacount_2000` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `dmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for devicedatacount_2001
-- ----------------------------
CREATE TABLE `devicedatacount_2001` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `dmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for devicedatacount_2002
-- ----------------------------
CREATE TABLE `devicedatacount_2002` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `dmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for devicedatacount_2003
-- ----------------------------
CREATE TABLE `devicedatacount_2003` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `dmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for devicedatacount_2004
-- ----------------------------
CREATE TABLE `devicedatacount_2004` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `dmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for devicedatacount_2005
-- ----------------------------
CREATE TABLE `devicedatacount_2005` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `dmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for devicedatacount_2006
-- ----------------------------
CREATE TABLE `devicedatacount_2006` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `dmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for devicedatacount_2007
-- ----------------------------
CREATE TABLE `devicedatacount_2007` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `dmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for devicedatacount_2008
-- ----------------------------
CREATE TABLE `devicedatacount_2008` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `dmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for devicedatacount_2009
-- ----------------------------
CREATE TABLE `devicedatacount_2009` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `dmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for devicedatacount_2010
-- ----------------------------
CREATE TABLE `devicedatacount_2010` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `dmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for devicedatacount_2011
-- ----------------------------
CREATE TABLE `devicedatacount_2011` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `dmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM AUTO_INCREMENT=23068 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for devicedatacount_2012
-- ----------------------------
CREATE TABLE `devicedatacount_2012` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `dmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM AUTO_INCREMENT=41903 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for devicedatacount_2013
-- ----------------------------
CREATE TABLE `devicedatacount_2013` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `dmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for devicedatacount_2014
-- ----------------------------
CREATE TABLE `devicedatacount_2014` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `dmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for devicedatacount_2015
-- ----------------------------
CREATE TABLE `devicedatacount_2015` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `dmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for email_queue
-- ----------------------------
CREATE TABLE `email_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `content` mediumtext CHARACTER SET utf8,
  `receiver` varchar(200) DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `state` char(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=29548 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for fault_2000
-- ----------------------------
CREATE TABLE `fault_2000` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) DEFAULT NULL,
  `address` varchar(200) CHARACTER SET latin1 DEFAULT NULL,
  `sendTime` datetime NOT NULL,
  `isConfirmed` bit(1) DEFAULT NULL,
  `errorCode` int(6) DEFAULT NULL,
  `errorTypeCode` tinyint(2) DEFAULT NULL,
  `deviceID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID_index` (`collectorID`),
  KEY `deviceID_index` (`deviceID`),
  KEY `sendTime_index` (`sendTime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for fault_2001
-- ----------------------------
CREATE TABLE `fault_2001` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) DEFAULT NULL,
  `address` varchar(200) CHARACTER SET latin1 DEFAULT NULL,
  `sendTime` datetime NOT NULL,
  `isConfirmed` bit(1) DEFAULT NULL,
  `errorCode` int(6) DEFAULT NULL,
  `errorTypeCode` tinyint(2) DEFAULT NULL,
  `deviceID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID_index` (`collectorID`),
  KEY `deviceID_index` (`deviceID`),
  KEY `sendTime_index` (`sendTime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for fault_2002
-- ----------------------------
CREATE TABLE `fault_2002` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) DEFAULT NULL,
  `address` varchar(200) CHARACTER SET latin1 DEFAULT NULL,
  `sendTime` datetime NOT NULL,
  `isConfirmed` bit(1) DEFAULT NULL,
  `errorCode` int(6) DEFAULT NULL,
  `errorTypeCode` tinyint(2) DEFAULT NULL,
  `deviceID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID_index` (`collectorID`),
  KEY `deviceID_index` (`deviceID`),
  KEY `sendTime_index` (`sendTime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for fault_2003
-- ----------------------------
CREATE TABLE `fault_2003` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) DEFAULT NULL,
  `address` varchar(200) CHARACTER SET latin1 DEFAULT NULL,
  `sendTime` datetime NOT NULL,
  `isConfirmed` bit(1) DEFAULT NULL,
  `errorCode` int(6) DEFAULT NULL,
  `errorTypeCode` tinyint(2) DEFAULT NULL,
  `deviceID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID_index` (`collectorID`),
  KEY `deviceID_index` (`deviceID`),
  KEY `sendTime_index` (`sendTime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for fault_2004
-- ----------------------------
CREATE TABLE `fault_2004` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) DEFAULT NULL,
  `address` varchar(200) CHARACTER SET latin1 DEFAULT NULL,
  `sendTime` datetime NOT NULL,
  `isConfirmed` bit(1) DEFAULT NULL,
  `errorCode` int(6) DEFAULT NULL,
  `errorTypeCode` tinyint(2) DEFAULT NULL,
  `deviceID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID_index` (`collectorID`),
  KEY `deviceID_index` (`deviceID`),
  KEY `sendTime_index` (`sendTime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for fault_2005
-- ----------------------------
CREATE TABLE `fault_2005` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) DEFAULT NULL,
  `address` varchar(200) CHARACTER SET latin1 DEFAULT NULL,
  `sendTime` datetime NOT NULL,
  `isConfirmed` bit(1) DEFAULT NULL,
  `errorCode` int(6) DEFAULT NULL,
  `errorTypeCode` tinyint(2) DEFAULT NULL,
  `deviceID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID_index` (`collectorID`),
  KEY `deviceID_index` (`deviceID`),
  KEY `sendTime_index` (`sendTime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for fault_2006
-- ----------------------------
CREATE TABLE `fault_2006` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) DEFAULT NULL,
  `address` varchar(200) CHARACTER SET latin1 DEFAULT NULL,
  `sendTime` datetime NOT NULL,
  `isConfirmed` bit(1) DEFAULT NULL,
  `errorCode` int(6) DEFAULT NULL,
  `errorTypeCode` tinyint(2) DEFAULT NULL,
  `deviceID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID_index` (`collectorID`),
  KEY `deviceID_index` (`deviceID`),
  KEY `sendTime_index` (`sendTime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for fault_2007
-- ----------------------------
CREATE TABLE `fault_2007` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) DEFAULT NULL,
  `address` varchar(200) CHARACTER SET latin1 DEFAULT NULL,
  `sendTime` datetime NOT NULL,
  `isConfirmed` bit(1) DEFAULT NULL,
  `errorCode` int(6) DEFAULT NULL,
  `errorTypeCode` tinyint(2) DEFAULT NULL,
  `deviceID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID_index` (`collectorID`),
  KEY `deviceID_index` (`deviceID`),
  KEY `sendTime_index` (`sendTime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for fault_2008
-- ----------------------------
CREATE TABLE `fault_2008` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) DEFAULT NULL,
  `address` varchar(200) CHARACTER SET latin1 DEFAULT NULL,
  `sendTime` datetime NOT NULL,
  `isConfirmed` bit(1) DEFAULT NULL,
  `errorCode` int(6) DEFAULT NULL,
  `errorTypeCode` tinyint(2) DEFAULT NULL,
  `deviceID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID_index` (`collectorID`),
  KEY `deviceID_index` (`deviceID`),
  KEY `sendTime_index` (`sendTime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for fault_2009
-- ----------------------------
CREATE TABLE `fault_2009` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) DEFAULT NULL,
  `address` varchar(200) CHARACTER SET latin1 DEFAULT NULL,
  `sendTime` datetime NOT NULL,
  `isConfirmed` bit(1) DEFAULT NULL,
  `errorCode` int(6) DEFAULT NULL,
  `errorTypeCode` tinyint(2) DEFAULT NULL,
  `deviceID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID_index` (`collectorID`),
  KEY `deviceID_index` (`deviceID`),
  KEY `sendTime_index` (`sendTime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for fault_2010
-- ----------------------------
CREATE TABLE `fault_2010` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) DEFAULT NULL,
  `address` varchar(200) CHARACTER SET latin1 DEFAULT NULL,
  `sendTime` datetime NOT NULL,
  `isConfirmed` bit(1) DEFAULT NULL,
  `errorCode` int(6) DEFAULT NULL,
  `errorTypeCode` tinyint(2) DEFAULT NULL,
  `deviceID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID_index` (`collectorID`),
  KEY `deviceID_index` (`deviceID`),
  KEY `sendTime_index` (`sendTime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for fault_2011
-- ----------------------------
CREATE TABLE `fault_2011` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) DEFAULT NULL,
  `address` varchar(200) CHARACTER SET latin1 DEFAULT NULL,
  `sendTime` datetime NOT NULL,
  `isConfirmed` bit(1) DEFAULT NULL,
  `errorCode` int(6) DEFAULT NULL,
  `errorTypeCode` tinyint(2) DEFAULT NULL,
  `deviceID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `asd` (`address`,`sendTime`,`deviceID`,`errorCode`),
  KEY `collectorID_index` (`collectorID`),
  KEY `deviceID_index` (`deviceID`),
  KEY `sendTime_index` (`sendTime`)
) ENGINE=MyISAM AUTO_INCREMENT=410588 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for fault_2012
-- ----------------------------
CREATE TABLE `fault_2012` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) DEFAULT NULL,
  `address` varchar(200) CHARACTER SET latin1 DEFAULT NULL,
  `sendTime` datetime NOT NULL,
  `isConfirmed` bit(1) DEFAULT NULL,
  `errorCode` int(6) DEFAULT NULL,
  `errorTypeCode` tinyint(2) DEFAULT NULL,
  `deviceID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID_index` (`collectorID`),
  KEY `deviceID_index` (`deviceID`),
  KEY `sendTime_index` (`sendTime`)
) ENGINE=MyISAM AUTO_INCREMENT=378014 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for fault_2013
-- ----------------------------
CREATE TABLE `fault_2013` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) DEFAULT NULL,
  `address` varchar(200) CHARACTER SET latin1 DEFAULT NULL,
  `sendTime` datetime NOT NULL,
  `isConfirmed` bit(1) DEFAULT NULL,
  `errorCode` int(6) DEFAULT NULL,
  `errorTypeCode` tinyint(2) DEFAULT NULL,
  `deviceID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID_index` (`collectorID`),
  KEY `deviceID_index` (`deviceID`),
  KEY `sendTime_index` (`sendTime`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for fault_2014
-- ----------------------------
CREATE TABLE `fault_2014` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) DEFAULT NULL,
  `address` varchar(200) CHARACTER SET latin1 DEFAULT NULL,
  `sendTime` datetime NOT NULL,
  `isConfirmed` bit(1) DEFAULT NULL,
  `errorCode` int(6) DEFAULT NULL,
  `errorTypeCode` tinyint(2) DEFAULT NULL,
  `deviceID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID_index` (`collectorID`),
  KEY `deviceID_index` (`deviceID`),
  KEY `sendTime_index` (`sendTime`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for fault_2015
-- ----------------------------
CREATE TABLE `fault_2015` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collectorID` int(11) DEFAULT NULL,
  `address` varchar(200) CHARACTER SET latin1 DEFAULT NULL,
  `sendTime` datetime NOT NULL,
  `isConfirmed` bit(1) DEFAULT NULL,
  `errorCode` int(6) DEFAULT NULL,
  `errorTypeCode` tinyint(2) DEFAULT NULL,
  `deviceID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `collectorID_index` (`collectorID`),
  KEY `deviceID_index` (`deviceID`),
  KEY `sendTime_index` (`sendTime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200001
-- ----------------------------
CREATE TABLE `hlx_day_data_200001` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200002
-- ----------------------------
CREATE TABLE `hlx_day_data_200002` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200003
-- ----------------------------
CREATE TABLE `hlx_day_data_200003` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200004
-- ----------------------------
CREATE TABLE `hlx_day_data_200004` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200005
-- ----------------------------
CREATE TABLE `hlx_day_data_200005` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200006
-- ----------------------------
CREATE TABLE `hlx_day_data_200006` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200007
-- ----------------------------
CREATE TABLE `hlx_day_data_200007` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200008
-- ----------------------------
CREATE TABLE `hlx_day_data_200008` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200009
-- ----------------------------
CREATE TABLE `hlx_day_data_200009` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200010
-- ----------------------------
CREATE TABLE `hlx_day_data_200010` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200011
-- ----------------------------
CREATE TABLE `hlx_day_data_200011` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200012
-- ----------------------------
CREATE TABLE `hlx_day_data_200012` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200101
-- ----------------------------
CREATE TABLE `hlx_day_data_200101` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200102
-- ----------------------------
CREATE TABLE `hlx_day_data_200102` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200103
-- ----------------------------
CREATE TABLE `hlx_day_data_200103` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200104
-- ----------------------------
CREATE TABLE `hlx_day_data_200104` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200105
-- ----------------------------
CREATE TABLE `hlx_day_data_200105` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200106
-- ----------------------------
CREATE TABLE `hlx_day_data_200106` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200107
-- ----------------------------
CREATE TABLE `hlx_day_data_200107` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200108
-- ----------------------------
CREATE TABLE `hlx_day_data_200108` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200109
-- ----------------------------
CREATE TABLE `hlx_day_data_200109` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200110
-- ----------------------------
CREATE TABLE `hlx_day_data_200110` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200111
-- ----------------------------
CREATE TABLE `hlx_day_data_200111` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200112
-- ----------------------------
CREATE TABLE `hlx_day_data_200112` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200201
-- ----------------------------
CREATE TABLE `hlx_day_data_200201` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200202
-- ----------------------------
CREATE TABLE `hlx_day_data_200202` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200203
-- ----------------------------
CREATE TABLE `hlx_day_data_200203` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200204
-- ----------------------------
CREATE TABLE `hlx_day_data_200204` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200205
-- ----------------------------
CREATE TABLE `hlx_day_data_200205` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200206
-- ----------------------------
CREATE TABLE `hlx_day_data_200206` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200207
-- ----------------------------
CREATE TABLE `hlx_day_data_200207` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200208
-- ----------------------------
CREATE TABLE `hlx_day_data_200208` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200209
-- ----------------------------
CREATE TABLE `hlx_day_data_200209` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200210
-- ----------------------------
CREATE TABLE `hlx_day_data_200210` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200211
-- ----------------------------
CREATE TABLE `hlx_day_data_200211` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200212
-- ----------------------------
CREATE TABLE `hlx_day_data_200212` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200301
-- ----------------------------
CREATE TABLE `hlx_day_data_200301` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200302
-- ----------------------------
CREATE TABLE `hlx_day_data_200302` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200303
-- ----------------------------
CREATE TABLE `hlx_day_data_200303` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200304
-- ----------------------------
CREATE TABLE `hlx_day_data_200304` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200305
-- ----------------------------
CREATE TABLE `hlx_day_data_200305` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200306
-- ----------------------------
CREATE TABLE `hlx_day_data_200306` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200307
-- ----------------------------
CREATE TABLE `hlx_day_data_200307` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200308
-- ----------------------------
CREATE TABLE `hlx_day_data_200308` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200309
-- ----------------------------
CREATE TABLE `hlx_day_data_200309` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200310
-- ----------------------------
CREATE TABLE `hlx_day_data_200310` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200311
-- ----------------------------
CREATE TABLE `hlx_day_data_200311` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200312
-- ----------------------------
CREATE TABLE `hlx_day_data_200312` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200401
-- ----------------------------
CREATE TABLE `hlx_day_data_200401` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200402
-- ----------------------------
CREATE TABLE `hlx_day_data_200402` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200403
-- ----------------------------
CREATE TABLE `hlx_day_data_200403` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200404
-- ----------------------------
CREATE TABLE `hlx_day_data_200404` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200405
-- ----------------------------
CREATE TABLE `hlx_day_data_200405` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200406
-- ----------------------------
CREATE TABLE `hlx_day_data_200406` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200407
-- ----------------------------
CREATE TABLE `hlx_day_data_200407` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200408
-- ----------------------------
CREATE TABLE `hlx_day_data_200408` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200409
-- ----------------------------
CREATE TABLE `hlx_day_data_200409` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200410
-- ----------------------------
CREATE TABLE `hlx_day_data_200410` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200411
-- ----------------------------
CREATE TABLE `hlx_day_data_200411` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200412
-- ----------------------------
CREATE TABLE `hlx_day_data_200412` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200501
-- ----------------------------
CREATE TABLE `hlx_day_data_200501` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200502
-- ----------------------------
CREATE TABLE `hlx_day_data_200502` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200503
-- ----------------------------
CREATE TABLE `hlx_day_data_200503` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200504
-- ----------------------------
CREATE TABLE `hlx_day_data_200504` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200505
-- ----------------------------
CREATE TABLE `hlx_day_data_200505` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200506
-- ----------------------------
CREATE TABLE `hlx_day_data_200506` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200507
-- ----------------------------
CREATE TABLE `hlx_day_data_200507` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200508
-- ----------------------------
CREATE TABLE `hlx_day_data_200508` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200509
-- ----------------------------
CREATE TABLE `hlx_day_data_200509` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200510
-- ----------------------------
CREATE TABLE `hlx_day_data_200510` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200511
-- ----------------------------
CREATE TABLE `hlx_day_data_200511` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200512
-- ----------------------------
CREATE TABLE `hlx_day_data_200512` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200601
-- ----------------------------
CREATE TABLE `hlx_day_data_200601` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200602
-- ----------------------------
CREATE TABLE `hlx_day_data_200602` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200603
-- ----------------------------
CREATE TABLE `hlx_day_data_200603` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200604
-- ----------------------------
CREATE TABLE `hlx_day_data_200604` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200605
-- ----------------------------
CREATE TABLE `hlx_day_data_200605` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200606
-- ----------------------------
CREATE TABLE `hlx_day_data_200606` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200607
-- ----------------------------
CREATE TABLE `hlx_day_data_200607` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200608
-- ----------------------------
CREATE TABLE `hlx_day_data_200608` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200609
-- ----------------------------
CREATE TABLE `hlx_day_data_200609` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200610
-- ----------------------------
CREATE TABLE `hlx_day_data_200610` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200611
-- ----------------------------
CREATE TABLE `hlx_day_data_200611` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200612
-- ----------------------------
CREATE TABLE `hlx_day_data_200612` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200701
-- ----------------------------
CREATE TABLE `hlx_day_data_200701` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200702
-- ----------------------------
CREATE TABLE `hlx_day_data_200702` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200703
-- ----------------------------
CREATE TABLE `hlx_day_data_200703` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200704
-- ----------------------------
CREATE TABLE `hlx_day_data_200704` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200705
-- ----------------------------
CREATE TABLE `hlx_day_data_200705` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200706
-- ----------------------------
CREATE TABLE `hlx_day_data_200706` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200707
-- ----------------------------
CREATE TABLE `hlx_day_data_200707` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200708
-- ----------------------------
CREATE TABLE `hlx_day_data_200708` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200709
-- ----------------------------
CREATE TABLE `hlx_day_data_200709` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200710
-- ----------------------------
CREATE TABLE `hlx_day_data_200710` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200711
-- ----------------------------
CREATE TABLE `hlx_day_data_200711` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200712
-- ----------------------------
CREATE TABLE `hlx_day_data_200712` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200801
-- ----------------------------
CREATE TABLE `hlx_day_data_200801` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200802
-- ----------------------------
CREATE TABLE `hlx_day_data_200802` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200803
-- ----------------------------
CREATE TABLE `hlx_day_data_200803` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200804
-- ----------------------------
CREATE TABLE `hlx_day_data_200804` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200805
-- ----------------------------
CREATE TABLE `hlx_day_data_200805` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200806
-- ----------------------------
CREATE TABLE `hlx_day_data_200806` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200807
-- ----------------------------
CREATE TABLE `hlx_day_data_200807` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200808
-- ----------------------------
CREATE TABLE `hlx_day_data_200808` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200809
-- ----------------------------
CREATE TABLE `hlx_day_data_200809` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200810
-- ----------------------------
CREATE TABLE `hlx_day_data_200810` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200811
-- ----------------------------
CREATE TABLE `hlx_day_data_200811` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200812
-- ----------------------------
CREATE TABLE `hlx_day_data_200812` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200901
-- ----------------------------
CREATE TABLE `hlx_day_data_200901` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200902
-- ----------------------------
CREATE TABLE `hlx_day_data_200902` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200903
-- ----------------------------
CREATE TABLE `hlx_day_data_200903` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200904
-- ----------------------------
CREATE TABLE `hlx_day_data_200904` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200905
-- ----------------------------
CREATE TABLE `hlx_day_data_200905` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200906
-- ----------------------------
CREATE TABLE `hlx_day_data_200906` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200907
-- ----------------------------
CREATE TABLE `hlx_day_data_200907` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200908
-- ----------------------------
CREATE TABLE `hlx_day_data_200908` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200909
-- ----------------------------
CREATE TABLE `hlx_day_data_200909` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200910
-- ----------------------------
CREATE TABLE `hlx_day_data_200910` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200911
-- ----------------------------
CREATE TABLE `hlx_day_data_200911` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_200912
-- ----------------------------
CREATE TABLE `hlx_day_data_200912` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201001
-- ----------------------------
CREATE TABLE `hlx_day_data_201001` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201002
-- ----------------------------
CREATE TABLE `hlx_day_data_201002` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201003
-- ----------------------------
CREATE TABLE `hlx_day_data_201003` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201004
-- ----------------------------
CREATE TABLE `hlx_day_data_201004` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201005
-- ----------------------------
CREATE TABLE `hlx_day_data_201005` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201006
-- ----------------------------
CREATE TABLE `hlx_day_data_201006` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201007
-- ----------------------------
CREATE TABLE `hlx_day_data_201007` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201008
-- ----------------------------
CREATE TABLE `hlx_day_data_201008` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201009
-- ----------------------------
CREATE TABLE `hlx_day_data_201009` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201010
-- ----------------------------
CREATE TABLE `hlx_day_data_201010` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201011
-- ----------------------------
CREATE TABLE `hlx_day_data_201011` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201012
-- ----------------------------
CREATE TABLE `hlx_day_data_201012` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201101
-- ----------------------------
CREATE TABLE `hlx_day_data_201101` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201102
-- ----------------------------
CREATE TABLE `hlx_day_data_201102` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201103
-- ----------------------------
CREATE TABLE `hlx_day_data_201103` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201104
-- ----------------------------
CREATE TABLE `hlx_day_data_201104` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201105
-- ----------------------------
CREATE TABLE `hlx_day_data_201105` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201106
-- ----------------------------
CREATE TABLE `hlx_day_data_201106` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=183106 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for hlx_day_data_201107
-- ----------------------------
CREATE TABLE `hlx_day_data_201107` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=183133 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for hlx_day_data_201108
-- ----------------------------
CREATE TABLE `hlx_day_data_201108` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=300 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201109
-- ----------------------------
CREATE TABLE `hlx_day_data_201109` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=1073 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201110
-- ----------------------------
CREATE TABLE `hlx_day_data_201110` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=1499 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201111
-- ----------------------------
CREATE TABLE `hlx_day_data_201111` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=1454 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201112
-- ----------------------------
CREATE TABLE `hlx_day_data_201112` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=3979 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201201
-- ----------------------------
CREATE TABLE `hlx_day_data_201201` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=3940 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201202
-- ----------------------------
CREATE TABLE `hlx_day_data_201202` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=12738 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201203
-- ----------------------------
CREATE TABLE `hlx_day_data_201203` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=7354 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201204
-- ----------------------------
CREATE TABLE `hlx_day_data_201204` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=6998 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201205
-- ----------------------------
CREATE TABLE `hlx_day_data_201205` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=10751 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201206
-- ----------------------------
CREATE TABLE `hlx_day_data_201206` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=20085 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201207
-- ----------------------------
CREATE TABLE `hlx_day_data_201207` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=493 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201208
-- ----------------------------
CREATE TABLE `hlx_day_data_201208` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201209
-- ----------------------------
CREATE TABLE `hlx_day_data_201209` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201210
-- ----------------------------
CREATE TABLE `hlx_day_data_201210` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201211
-- ----------------------------
CREATE TABLE `hlx_day_data_201211` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201212
-- ----------------------------
CREATE TABLE `hlx_day_data_201212` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201301
-- ----------------------------
CREATE TABLE `hlx_day_data_201301` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201302
-- ----------------------------
CREATE TABLE `hlx_day_data_201302` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201303
-- ----------------------------
CREATE TABLE `hlx_day_data_201303` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201304
-- ----------------------------
CREATE TABLE `hlx_day_data_201304` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=105 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201305
-- ----------------------------
CREATE TABLE `hlx_day_data_201305` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201306
-- ----------------------------
CREATE TABLE `hlx_day_data_201306` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201307
-- ----------------------------
CREATE TABLE `hlx_day_data_201307` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201308
-- ----------------------------
CREATE TABLE `hlx_day_data_201308` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201309
-- ----------------------------
CREATE TABLE `hlx_day_data_201309` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201310
-- ----------------------------
CREATE TABLE `hlx_day_data_201310` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201311
-- ----------------------------
CREATE TABLE `hlx_day_data_201311` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201312
-- ----------------------------
CREATE TABLE `hlx_day_data_201312` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201401
-- ----------------------------
CREATE TABLE `hlx_day_data_201401` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201402
-- ----------------------------
CREATE TABLE `hlx_day_data_201402` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201403
-- ----------------------------
CREATE TABLE `hlx_day_data_201403` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201404
-- ----------------------------
CREATE TABLE `hlx_day_data_201404` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201405
-- ----------------------------
CREATE TABLE `hlx_day_data_201405` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201406
-- ----------------------------
CREATE TABLE `hlx_day_data_201406` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201407
-- ----------------------------
CREATE TABLE `hlx_day_data_201407` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201408
-- ----------------------------
CREATE TABLE `hlx_day_data_201408` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201409
-- ----------------------------
CREATE TABLE `hlx_day_data_201409` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201410
-- ----------------------------
CREATE TABLE `hlx_day_data_201410` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201411
-- ----------------------------
CREATE TABLE `hlx_day_data_201411` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201412
-- ----------------------------
CREATE TABLE `hlx_day_data_201412` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201501
-- ----------------------------
CREATE TABLE `hlx_day_data_201501` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201502
-- ----------------------------
CREATE TABLE `hlx_day_data_201502` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201503
-- ----------------------------
CREATE TABLE `hlx_day_data_201503` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201504
-- ----------------------------
CREATE TABLE `hlx_day_data_201504` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201505
-- ----------------------------
CREATE TABLE `hlx_day_data_201505` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201506
-- ----------------------------
CREATE TABLE `hlx_day_data_201506` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201507
-- ----------------------------
CREATE TABLE `hlx_day_data_201507` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201508
-- ----------------------------
CREATE TABLE `hlx_day_data_201508` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201509
-- ----------------------------
CREATE TABLE `hlx_day_data_201509` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201510
-- ----------------------------
CREATE TABLE `hlx_day_data_201510` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201511
-- ----------------------------
CREATE TABLE `hlx_day_data_201511` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for hlx_day_data_201512
-- ----------------------------
CREATE TABLE `hlx_day_data_201512` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200001
-- ----------------------------
CREATE TABLE `inverter_day_data_200001` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200002
-- ----------------------------
CREATE TABLE `inverter_day_data_200002` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200003
-- ----------------------------
CREATE TABLE `inverter_day_data_200003` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200004
-- ----------------------------
CREATE TABLE `inverter_day_data_200004` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200005
-- ----------------------------
CREATE TABLE `inverter_day_data_200005` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200006
-- ----------------------------
CREATE TABLE `inverter_day_data_200006` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200007
-- ----------------------------
CREATE TABLE `inverter_day_data_200007` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200008
-- ----------------------------
CREATE TABLE `inverter_day_data_200008` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200009
-- ----------------------------
CREATE TABLE `inverter_day_data_200009` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200010
-- ----------------------------
CREATE TABLE `inverter_day_data_200010` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200011
-- ----------------------------
CREATE TABLE `inverter_day_data_200011` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200012
-- ----------------------------
CREATE TABLE `inverter_day_data_200012` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200101
-- ----------------------------
CREATE TABLE `inverter_day_data_200101` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200102
-- ----------------------------
CREATE TABLE `inverter_day_data_200102` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200103
-- ----------------------------
CREATE TABLE `inverter_day_data_200103` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200104
-- ----------------------------
CREATE TABLE `inverter_day_data_200104` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200105
-- ----------------------------
CREATE TABLE `inverter_day_data_200105` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200106
-- ----------------------------
CREATE TABLE `inverter_day_data_200106` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200107
-- ----------------------------
CREATE TABLE `inverter_day_data_200107` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200108
-- ----------------------------
CREATE TABLE `inverter_day_data_200108` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200109
-- ----------------------------
CREATE TABLE `inverter_day_data_200109` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200110
-- ----------------------------
CREATE TABLE `inverter_day_data_200110` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200111
-- ----------------------------
CREATE TABLE `inverter_day_data_200111` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200112
-- ----------------------------
CREATE TABLE `inverter_day_data_200112` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200201
-- ----------------------------
CREATE TABLE `inverter_day_data_200201` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200202
-- ----------------------------
CREATE TABLE `inverter_day_data_200202` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200203
-- ----------------------------
CREATE TABLE `inverter_day_data_200203` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200204
-- ----------------------------
CREATE TABLE `inverter_day_data_200204` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200205
-- ----------------------------
CREATE TABLE `inverter_day_data_200205` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200206
-- ----------------------------
CREATE TABLE `inverter_day_data_200206` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200207
-- ----------------------------
CREATE TABLE `inverter_day_data_200207` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200208
-- ----------------------------
CREATE TABLE `inverter_day_data_200208` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200209
-- ----------------------------
CREATE TABLE `inverter_day_data_200209` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200210
-- ----------------------------
CREATE TABLE `inverter_day_data_200210` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200211
-- ----------------------------
CREATE TABLE `inverter_day_data_200211` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200212
-- ----------------------------
CREATE TABLE `inverter_day_data_200212` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200301
-- ----------------------------
CREATE TABLE `inverter_day_data_200301` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200302
-- ----------------------------
CREATE TABLE `inverter_day_data_200302` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200303
-- ----------------------------
CREATE TABLE `inverter_day_data_200303` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200304
-- ----------------------------
CREATE TABLE `inverter_day_data_200304` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200305
-- ----------------------------
CREATE TABLE `inverter_day_data_200305` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200306
-- ----------------------------
CREATE TABLE `inverter_day_data_200306` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200307
-- ----------------------------
CREATE TABLE `inverter_day_data_200307` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200308
-- ----------------------------
CREATE TABLE `inverter_day_data_200308` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200309
-- ----------------------------
CREATE TABLE `inverter_day_data_200309` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200310
-- ----------------------------
CREATE TABLE `inverter_day_data_200310` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200311
-- ----------------------------
CREATE TABLE `inverter_day_data_200311` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200312
-- ----------------------------
CREATE TABLE `inverter_day_data_200312` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200401
-- ----------------------------
CREATE TABLE `inverter_day_data_200401` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200402
-- ----------------------------
CREATE TABLE `inverter_day_data_200402` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200403
-- ----------------------------
CREATE TABLE `inverter_day_data_200403` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200404
-- ----------------------------
CREATE TABLE `inverter_day_data_200404` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200405
-- ----------------------------
CREATE TABLE `inverter_day_data_200405` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200406
-- ----------------------------
CREATE TABLE `inverter_day_data_200406` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200407
-- ----------------------------
CREATE TABLE `inverter_day_data_200407` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200408
-- ----------------------------
CREATE TABLE `inverter_day_data_200408` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200409
-- ----------------------------
CREATE TABLE `inverter_day_data_200409` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200410
-- ----------------------------
CREATE TABLE `inverter_day_data_200410` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200411
-- ----------------------------
CREATE TABLE `inverter_day_data_200411` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200412
-- ----------------------------
CREATE TABLE `inverter_day_data_200412` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200501
-- ----------------------------
CREATE TABLE `inverter_day_data_200501` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200502
-- ----------------------------
CREATE TABLE `inverter_day_data_200502` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200503
-- ----------------------------
CREATE TABLE `inverter_day_data_200503` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200504
-- ----------------------------
CREATE TABLE `inverter_day_data_200504` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200505
-- ----------------------------
CREATE TABLE `inverter_day_data_200505` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200506
-- ----------------------------
CREATE TABLE `inverter_day_data_200506` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200507
-- ----------------------------
CREATE TABLE `inverter_day_data_200507` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200508
-- ----------------------------
CREATE TABLE `inverter_day_data_200508` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200509
-- ----------------------------
CREATE TABLE `inverter_day_data_200509` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200510
-- ----------------------------
CREATE TABLE `inverter_day_data_200510` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200511
-- ----------------------------
CREATE TABLE `inverter_day_data_200511` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200512
-- ----------------------------
CREATE TABLE `inverter_day_data_200512` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200601
-- ----------------------------
CREATE TABLE `inverter_day_data_200601` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200602
-- ----------------------------
CREATE TABLE `inverter_day_data_200602` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200603
-- ----------------------------
CREATE TABLE `inverter_day_data_200603` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200604
-- ----------------------------
CREATE TABLE `inverter_day_data_200604` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200605
-- ----------------------------
CREATE TABLE `inverter_day_data_200605` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200606
-- ----------------------------
CREATE TABLE `inverter_day_data_200606` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200607
-- ----------------------------
CREATE TABLE `inverter_day_data_200607` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200608
-- ----------------------------
CREATE TABLE `inverter_day_data_200608` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200609
-- ----------------------------
CREATE TABLE `inverter_day_data_200609` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200610
-- ----------------------------
CREATE TABLE `inverter_day_data_200610` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200611
-- ----------------------------
CREATE TABLE `inverter_day_data_200611` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200612
-- ----------------------------
CREATE TABLE `inverter_day_data_200612` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200701
-- ----------------------------
CREATE TABLE `inverter_day_data_200701` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200702
-- ----------------------------
CREATE TABLE `inverter_day_data_200702` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200703
-- ----------------------------
CREATE TABLE `inverter_day_data_200703` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200704
-- ----------------------------
CREATE TABLE `inverter_day_data_200704` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200705
-- ----------------------------
CREATE TABLE `inverter_day_data_200705` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200706
-- ----------------------------
CREATE TABLE `inverter_day_data_200706` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200707
-- ----------------------------
CREATE TABLE `inverter_day_data_200707` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200708
-- ----------------------------
CREATE TABLE `inverter_day_data_200708` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200709
-- ----------------------------
CREATE TABLE `inverter_day_data_200709` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200710
-- ----------------------------
CREATE TABLE `inverter_day_data_200710` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200711
-- ----------------------------
CREATE TABLE `inverter_day_data_200711` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200712
-- ----------------------------
CREATE TABLE `inverter_day_data_200712` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200801
-- ----------------------------
CREATE TABLE `inverter_day_data_200801` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200802
-- ----------------------------
CREATE TABLE `inverter_day_data_200802` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200803
-- ----------------------------
CREATE TABLE `inverter_day_data_200803` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200804
-- ----------------------------
CREATE TABLE `inverter_day_data_200804` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200805
-- ----------------------------
CREATE TABLE `inverter_day_data_200805` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200806
-- ----------------------------
CREATE TABLE `inverter_day_data_200806` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200807
-- ----------------------------
CREATE TABLE `inverter_day_data_200807` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200808
-- ----------------------------
CREATE TABLE `inverter_day_data_200808` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200809
-- ----------------------------
CREATE TABLE `inverter_day_data_200809` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200810
-- ----------------------------
CREATE TABLE `inverter_day_data_200810` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200811
-- ----------------------------
CREATE TABLE `inverter_day_data_200811` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200812
-- ----------------------------
CREATE TABLE `inverter_day_data_200812` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200901
-- ----------------------------
CREATE TABLE `inverter_day_data_200901` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200902
-- ----------------------------
CREATE TABLE `inverter_day_data_200902` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200903
-- ----------------------------
CREATE TABLE `inverter_day_data_200903` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200904
-- ----------------------------
CREATE TABLE `inverter_day_data_200904` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200905
-- ----------------------------
CREATE TABLE `inverter_day_data_200905` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200906
-- ----------------------------
CREATE TABLE `inverter_day_data_200906` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200907
-- ----------------------------
CREATE TABLE `inverter_day_data_200907` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200908
-- ----------------------------
CREATE TABLE `inverter_day_data_200908` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200909
-- ----------------------------
CREATE TABLE `inverter_day_data_200909` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200910
-- ----------------------------
CREATE TABLE `inverter_day_data_200910` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200911
-- ----------------------------
CREATE TABLE `inverter_day_data_200911` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_200912
-- ----------------------------
CREATE TABLE `inverter_day_data_200912` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201001
-- ----------------------------
CREATE TABLE `inverter_day_data_201001` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201002
-- ----------------------------
CREATE TABLE `inverter_day_data_201002` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201003
-- ----------------------------
CREATE TABLE `inverter_day_data_201003` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201004
-- ----------------------------
CREATE TABLE `inverter_day_data_201004` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201005
-- ----------------------------
CREATE TABLE `inverter_day_data_201005` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201006
-- ----------------------------
CREATE TABLE `inverter_day_data_201006` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201007
-- ----------------------------
CREATE TABLE `inverter_day_data_201007` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201008
-- ----------------------------
CREATE TABLE `inverter_day_data_201008` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201009
-- ----------------------------
CREATE TABLE `inverter_day_data_201009` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201010
-- ----------------------------
CREATE TABLE `inverter_day_data_201010` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201011
-- ----------------------------
CREATE TABLE `inverter_day_data_201011` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201012
-- ----------------------------
CREATE TABLE `inverter_day_data_201012` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201101
-- ----------------------------
CREATE TABLE `inverter_day_data_201101` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=401 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201102
-- ----------------------------
CREATE TABLE `inverter_day_data_201102` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201103
-- ----------------------------
CREATE TABLE `inverter_day_data_201103` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201104
-- ----------------------------
CREATE TABLE `inverter_day_data_201104` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=186116 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for inverter_day_data_201105
-- ----------------------------
CREATE TABLE `inverter_day_data_201105` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=193074 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for inverter_day_data_201106
-- ----------------------------
CREATE TABLE `inverter_day_data_201106` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=201834 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for inverter_day_data_201107
-- ----------------------------
CREATE TABLE `inverter_day_data_201107` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=218498 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for inverter_day_data_201108
-- ----------------------------
CREATE TABLE `inverter_day_data_201108` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=15889 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201109
-- ----------------------------
CREATE TABLE `inverter_day_data_201109` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=49402 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201110
-- ----------------------------
CREATE TABLE `inverter_day_data_201110` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=89284 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201111
-- ----------------------------
CREATE TABLE `inverter_day_data_201111` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=102481 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201112
-- ----------------------------
CREATE TABLE `inverter_day_data_201112` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=136836 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201201
-- ----------------------------
CREATE TABLE `inverter_day_data_201201` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=141953 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201202
-- ----------------------------
CREATE TABLE `inverter_day_data_201202` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=139561 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201203
-- ----------------------------
CREATE TABLE `inverter_day_data_201203` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=136790 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201204
-- ----------------------------
CREATE TABLE `inverter_day_data_201204` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=147927 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201205
-- ----------------------------
CREATE TABLE `inverter_day_data_201205` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=170333 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201206
-- ----------------------------
CREATE TABLE `inverter_day_data_201206` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=172542 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201207
-- ----------------------------
CREATE TABLE `inverter_day_data_201207` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=5593 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201208
-- ----------------------------
CREATE TABLE `inverter_day_data_201208` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201209
-- ----------------------------
CREATE TABLE `inverter_day_data_201209` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201210
-- ----------------------------
CREATE TABLE `inverter_day_data_201210` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201211
-- ----------------------------
CREATE TABLE `inverter_day_data_201211` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201212
-- ----------------------------
CREATE TABLE `inverter_day_data_201212` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201301
-- ----------------------------
CREATE TABLE `inverter_day_data_201301` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201302
-- ----------------------------
CREATE TABLE `inverter_day_data_201302` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201303
-- ----------------------------
CREATE TABLE `inverter_day_data_201303` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201304
-- ----------------------------
CREATE TABLE `inverter_day_data_201304` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=93 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201305
-- ----------------------------
CREATE TABLE `inverter_day_data_201305` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201306
-- ----------------------------
CREATE TABLE `inverter_day_data_201306` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201307
-- ----------------------------
CREATE TABLE `inverter_day_data_201307` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201308
-- ----------------------------
CREATE TABLE `inverter_day_data_201308` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201309
-- ----------------------------
CREATE TABLE `inverter_day_data_201309` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201310
-- ----------------------------
CREATE TABLE `inverter_day_data_201310` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201311
-- ----------------------------
CREATE TABLE `inverter_day_data_201311` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201312
-- ----------------------------
CREATE TABLE `inverter_day_data_201312` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201401
-- ----------------------------
CREATE TABLE `inverter_day_data_201401` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201402
-- ----------------------------
CREATE TABLE `inverter_day_data_201402` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201403
-- ----------------------------
CREATE TABLE `inverter_day_data_201403` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201404
-- ----------------------------
CREATE TABLE `inverter_day_data_201404` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201405
-- ----------------------------
CREATE TABLE `inverter_day_data_201405` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201406
-- ----------------------------
CREATE TABLE `inverter_day_data_201406` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201407
-- ----------------------------
CREATE TABLE `inverter_day_data_201407` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM AUTO_INCREMENT=276 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201408
-- ----------------------------
CREATE TABLE `inverter_day_data_201408` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201409
-- ----------------------------
CREATE TABLE `inverter_day_data_201409` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201410
-- ----------------------------
CREATE TABLE `inverter_day_data_201410` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201411
-- ----------------------------
CREATE TABLE `inverter_day_data_201411` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201412
-- ----------------------------
CREATE TABLE `inverter_day_data_201412` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201501
-- ----------------------------
CREATE TABLE `inverter_day_data_201501` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201502
-- ----------------------------
CREATE TABLE `inverter_day_data_201502` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201503
-- ----------------------------
CREATE TABLE `inverter_day_data_201503` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201504
-- ----------------------------
CREATE TABLE `inverter_day_data_201504` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201505
-- ----------------------------
CREATE TABLE `inverter_day_data_201505` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201506
-- ----------------------------
CREATE TABLE `inverter_day_data_201506` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201507
-- ----------------------------
CREATE TABLE `inverter_day_data_201507` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201508
-- ----------------------------
CREATE TABLE `inverter_day_data_201508` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201509
-- ----------------------------
CREATE TABLE `inverter_day_data_201509` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201510
-- ----------------------------
CREATE TABLE `inverter_day_data_201510` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201511
-- ----------------------------
CREATE TABLE `inverter_day_data_201511` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for inverter_day_data_201512
-- ----------------------------
CREATE TABLE `inverter_day_data_201512` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `deviceID` int(11) NOT NULL,
  `sendDay` tinyint(2) NOT NULL,
  `monitorCode` smallint(2) NOT NULL,
  `dataContent` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviceID2sendDay2monitorCode_index` (`deviceID`,`sendDay`,`monitorCode`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for item_config
-- ----------------------------
CREATE TABLE `item_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8_swedish_ci DEFAULT NULL,
  `value` float DEFAULT NULL,
  `type` smallint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name_index` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

-- ----------------------------
-- Table structure for language
-- ----------------------------
CREATE TABLE `language` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `codename` varchar(20) CHARACTER SET utf8 COLLATE utf8_swedish_ci NOT NULL,
  `package_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  `isenabled` bit(1) NOT NULL DEFAULT b'1',
  `currencies` varchar(10) DEFAULT NULL,
  `displayName` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `isEdited` bit(1) DEFAULT b'1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for loginrecord
-- ----------------------------
CREATE TABLE `loginrecord` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `ip` varchar(20) DEFAULT NULL,
  `loginTime` datetime NOT NULL,
  `localZone` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5588 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for mail_config
-- ----------------------------
CREATE TABLE `mail_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serverName` varchar(255) NOT NULL,
  `emailName` varchar(255) DEFAULT NULL,
  `emailPwd` varchar(255) DEFAULT NULL,
  `port` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for manager
-- ----------------------------
CREATE TABLE `manager` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) CHARACTER SET utf8 NOT NULL,
  `department` varchar(50) CHARACTER SET utf8 COLLATE utf8_swedish_ci DEFAULT NULL,
  `fullname` varchar(20) CHARACTER SET utf8 COLLATE utf8_swedish_ci NOT NULL,
  `islocked` bit(1) NOT NULL,
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_swedish_ci NOT NULL,
  `Type` int(1) NOT NULL DEFAULT '1',
  `m_type` int(11) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=73 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for manager_monitor_code
-- ----------------------------
CREATE TABLE `manager_monitor_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `type` int(255) DEFAULT NULL,
  `isdisplay` bit(1) DEFAULT NULL,
  `sort_order` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for monitor_config
-- ----------------------------
CREATE TABLE `monitor_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` int(11) DEFAULT NULL,
  `items` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for monitor_item
-- ----------------------------
CREATE TABLE `monitor_item` (
  `code` varchar(100) COLLATE utf8_bin NOT NULL,
  `protocolType` smallint(6) NOT NULL,
  `isCount` bit(1) NOT NULL DEFAULT b'0',
  `isDisplay` bit(1) NOT NULL DEFAULT b'1',
  `noteName` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unit` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `step` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=102 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for plant_info
-- ----------------------------
CREATE TABLE `plant_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin NOT NULL,
  `postcode` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `location` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `country` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `city` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `timezone` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `street` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `installdate` datetime DEFAULT NULL,
  `operater` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `phone` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `direction` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `angle` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `manufacturer` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `module_type` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `pic` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `longitude` float(20,2) DEFAULT NULL,
  `userID` bigint(20) NOT NULL,
  `latitude` float(20,2) DEFAULT NULL,
  `design_power` float(20,2) DEFAULT NULL,
  `description` text COLLATE utf8_bin,
  `example_plant` bit(1) DEFAULT b'0',
  `VideoMonitorEnable` bit(1) DEFAULT b'0',
  `revenueRate` double NOT NULL DEFAULT '0',
  `isNewPlant` bit(1) DEFAULT b'0',
  `startDate` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `endDate` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `hours` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `dst_enable` bit(1) DEFAULT NULL,
  `area` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `longitudeString` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `latitudeString` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `waring_lastsendtime` datetime DEFAULT NULL,
  `import_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userID_index` (`userID`)
) ENGINE=MyISAM AUTO_INCREMENT=515 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for plant_unit
-- ----------------------------
CREATE TABLE `plant_unit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plantID` int(11) NOT NULL,
  `collectorID` int(11) NOT NULL,
  `displayname` varchar(100) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `plantID2collectorID_index` (`plantID`,`collectorID`),
  KEY `collectorID_index` (`collectorID`)
) ENGINE=MyISAM AUTO_INCREMENT=518 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for plant_user
-- ----------------------------
CREATE TABLE `plant_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plantID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  PRIMARY KEY (`id`,`plantID`,`userID`),
  KEY `plantID2userID_index` (`plantID`),
  KEY `userID_index` (`userID`)
) ENGINE=MyISAM AUTO_INCREMENT=445 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for plantdatacount_2000
-- ----------------------------
CREATE TABLE `plantdatacount_2000` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `pmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for plantdatacount_2001
-- ----------------------------
CREATE TABLE `plantdatacount_2001` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `pmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for plantdatacount_2002
-- ----------------------------
CREATE TABLE `plantdatacount_2002` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `pmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for plantdatacount_2003
-- ----------------------------
CREATE TABLE `plantdatacount_2003` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `pmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for plantdatacount_2004
-- ----------------------------
CREATE TABLE `plantdatacount_2004` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `pmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for plantdatacount_2005
-- ----------------------------
CREATE TABLE `plantdatacount_2005` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `pmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for plantdatacount_2006
-- ----------------------------
CREATE TABLE `plantdatacount_2006` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `pmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for plantdatacount_2007
-- ----------------------------
CREATE TABLE `plantdatacount_2007` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `pmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for plantdatacount_2008
-- ----------------------------
CREATE TABLE `plantdatacount_2008` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `pmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for plantdatacount_2009
-- ----------------------------
CREATE TABLE `plantdatacount_2009` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `pmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for plantdatacount_2010
-- ----------------------------
CREATE TABLE `plantdatacount_2010` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `pmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for plantdatacount_2011
-- ----------------------------
CREATE TABLE `plantdatacount_2011` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `pmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM AUTO_INCREMENT=1328 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for plantdatacount_2012
-- ----------------------------
CREATE TABLE `plantdatacount_2012` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `pmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM AUTO_INCREMENT=1796 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for plantdatacount_2013
-- ----------------------------
CREATE TABLE `plantdatacount_2013` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `pmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM AUTO_INCREMENT=237 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for plantdatacount_2014
-- ----------------------------
CREATE TABLE `plantdatacount_2014` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `pmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM AUTO_INCREMENT=237 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for plantdatacount_2015
-- ----------------------------
CREATE TABLE `plantdatacount_2015` (
  `deviceID` int(11) NOT NULL,
  `monitorCode` int(4) NOT NULL,
  `month` int(4) NOT NULL,
  `day` int(2) NOT NULL,
  `maxValue` float(11,2) DEFAULT NULL,
  `maxTime` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `pmmd_index` (`deviceID`,`monitorCode`,`month`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for product_picture
-- ----------------------------
CREATE TABLE `product_picture` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `picname` varchar(100) COLLATE utf8_bin NOT NULL,
  `picurl` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for report_config
-- ----------------------------
CREATE TABLE `report_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sendFormat` varchar(50) DEFAULT NULL,
  `sendMode` int(50) DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `tinterval` varchar(20) DEFAULT NULL,
  `plantId` int(11) DEFAULT NULL,
  `reportId` int(11) DEFAULT NULL,
  `fixedTime` varchar(255) DEFAULT NULL,
  `lastSendTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3731 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for role
-- ----------------------------
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `Descr` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for role_function
-- ----------------------------
CREATE TABLE `role_function` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleId` int(11) NOT NULL,
  `function_code` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `roleId_index` (`roleId`)
) ENGINE=MyISAM AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
CREATE TABLE `user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `roleId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userID_index` (`userId`)
) ENGINE=MyISAM AUTO_INCREMENT=189 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for userinfo
-- ----------------------------
CREATE TABLE `userinfo` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) COLLATE utf8_swedish_ci NOT NULL,
  `password` varchar(100) COLLATE utf8_swedish_ci NOT NULL,
  `organize` varchar(100) COLLATE utf8_swedish_ci DEFAULT NULL,
  `sex` char(1) COLLATE utf8_swedish_ci NOT NULL,
  `fullname` varchar(100) COLLATE utf8_swedish_ci DEFAULT NULL,
  `address` varchar(100) COLLATE utf8_swedish_ci DEFAULT '',
  `email` varchar(100) COLLATE utf8_swedish_ci DEFAULT NULL,
  `city` varchar(100) COLLATE utf8_swedish_ci DEFAULT NULL,
  `country` varchar(100) COLLATE utf8_swedish_ci DEFAULT NULL,
  `tel` varchar(100) COLLATE utf8_swedish_ci DEFAULT NULL,
  `currencies` varchar(10) COLLATE utf8_swedish_ci DEFAULT NULL,
  `revenueRate` float(100,0) DEFAULT NULL,
  `languageId` bigint(11) DEFAULT NULL,
  `TemperatureType` varchar(4) COLLATE utf8_swedish_ci DEFAULT NULL,
  `mobilePhone` varchar(20) COLLATE utf8_swedish_ci DEFAULT NULL,
  `faxPhone` varchar(20) COLLATE utf8_swedish_ci DEFAULT NULL,
  `postalcode` varchar(20) COLLATE utf8_swedish_ci DEFAULT NULL,
  `parentUserId` int(11) DEFAULT NULL,
  `FirstName` varchar(100) COLLATE utf8_swedish_ci DEFAULT NULL,
  `LastName` varchar(100) COLLATE utf8_swedish_ci DEFAULT NULL,
  `lastApplyCollectorDate` date DEFAULT NULL,
  `menudisplaycount` smallint(6) DEFAULT '4',
  `overviewdisplaycount` smallint(6) DEFAULT '10',
  `todayApplyCollectorCount` smallint(6) DEFAULT '20',
  PRIMARY KEY (`id`,`username`),
  UNIQUE KEY `username_uindex` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=416 DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

-- ----------------------------
-- Table structure for video_monitor
-- ----------------------------
CREATE TABLE `video_monitor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plantId` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `url` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=169 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `admin_controller_action` VALUES ('1', 'admin', 'users', '1', '查看用户列表', null, '');
INSERT INTO `admin_controller_action` VALUES ('2', 'admin', 'users_output', '1', '导出用户列表', null, '');
INSERT INTO `admin_controller_action` VALUES ('3', 'admin', 'userdel', '1', '删除用户', null, '');
INSERT INTO `admin_controller_action` VALUES ('4', 'admin', 'allplants', '2', '查看电站列表', null, '');
INSERT INTO `admin_controller_action` VALUES ('5', 'admin', 'collectors', '3', '查看采集器列表', '1', '');
INSERT INTO `admin_controller_action` VALUES ('6', 'admin', 'devices', '4', '查看设备列表', null, '');
INSERT INTO `admin_controller_action` VALUES ('7', 'admin', 'DepartmentList', '5', '查看宣传图片列表', '1', '');
INSERT INTO `admin_controller_action` VALUES ('8', 'itemconfig', 'edit', '11', '二氧化碳', null, '');
INSERT INTO `admin_controller_action` VALUES ('9', 'admin', 'language', '7', '查看语言列表', '1', '');
INSERT INTO `admin_controller_action` VALUES ('10', 'devicemodel', 'list', '8', '查看设备类型列表', '1', '');
INSERT INTO `admin_controller_action` VALUES ('11', 'admin', 'mailconfig', '9', '邮箱配置', null, '');
INSERT INTO `admin_controller_action` VALUES ('12', 'admin', 'dataitems', '11', '报表配置', null, '');
INSERT INTO `admin_controller_action` VALUES ('13', 'admin', 'countries', '10', '查看国家列表', '1', '');
INSERT INTO `admin_controller_action` VALUES ('14', 'admin', 'monitorconfig', '11', '测点配置', null, '');
INSERT INTO `admin_controller_action` VALUES ('15', 'admin', 'currencies', '13', '查看货币列表', '1', '');
INSERT INTO `admin_controller_action` VALUES ('16', 'admin', 'config_mge_items', '11', '电站逆变器配置', null, '');
INSERT INTO `admin_controller_action` VALUES ('17', 'itemconfig', 'reg_collector', '11', '申请数据源配置', null, '');
INSERT INTO `admin_controller_action` VALUES ('18', 'admin', 'role', '12', '添加角色', '2', '');
INSERT INTO `admin_controller_action` VALUES ('19', 'admin', 'roles', '12', '查看角色列表', '1', '');
INSERT INTO `admin_controller_action` VALUES ('20', 'admin', 'allplants_excel', '2', '导出电站列表', null, '');
INSERT INTO `admin_controller_action` VALUES ('21', 'admin', 'recommend', '2', '设置/取消事例电站', null, '');
INSERT INTO `admin_controller_action` VALUES ('22', 'admin', 'newplant', '2', '设置/取消首页显示', null, '');
INSERT INTO `admin_controller_action` VALUES ('23', 'admin', 'delplant', '2', '删除电站', null, '');
INSERT INTO `admin_controller_action` VALUES ('24', 'admin', 'anonymous', '2', '匿名访问', null, '');
INSERT INTO `admin_controller_action` VALUES ('25', 'admin', 'collector_output', '3', '导出采集器列表', '7', '');
INSERT INTO `admin_controller_action` VALUES ('26', 'admin', 'collector_add', '3', '添加采集器', '2', '');
INSERT INTO `admin_controller_action` VALUES ('27', 'admin', 'collector_excel', '3', '导入采集器', '5', '');
INSERT INTO `admin_controller_action` VALUES ('28', 'admin', 'collector_delete', '3', '删除采集器', '4', '');
INSERT INTO `admin_controller_action` VALUES ('29', 'admin', 'managers', '6', '查看管理员列表', '1', '');
INSERT INTO `admin_controller_action` VALUES ('30', 'admin', 'DelDepartmentPic', '5', '删除宣传图片', '4', '');
INSERT INTO `admin_controller_action` VALUES ('31', 'admin', 'manager_edit', '6', '编辑管理员', '3', '');
INSERT INTO `admin_controller_action` VALUES ('32', 'admin', 'manager_delete', '6', '删除管理员', '4', '');
INSERT INTO `admin_controller_action` VALUES ('33', 'admin', 'language_upload', '7', '添加语言', '2', '');
INSERT INTO `admin_controller_action` VALUES ('34', 'admin', 'language_delete', '7', '删除语言', '4', '');
INSERT INTO `admin_controller_action` VALUES ('35', 'devicemodel', 'add', '8', '添加设备类型', '2', '');
INSERT INTO `admin_controller_action` VALUES ('36', 'devicemodel', 'delete', '8', '删除设备类型', '4', '');
INSERT INTO `admin_controller_action` VALUES ('37', 'admin', 'removemail', '9', '删除邮箱', null, '');
INSERT INTO `admin_controller_action` VALUES ('38', 'admin', 'country_edit', '10', '编辑国家', '2', '');
INSERT INTO `admin_controller_action` VALUES ('39', 'admin', 'cities', '10', '查看城市列表', '4', '');
INSERT INTO `admin_controller_action` VALUES ('40', 'admin', 'city_edit', '10', '编辑城市', '5', '');
INSERT INTO `admin_controller_action` VALUES ('41', 'admin', 'country_del', '10', '删除国家', '3', '');
INSERT INTO `admin_controller_action` VALUES ('42', 'admin', 'city_del', '10', '删除城市', '11', '');
INSERT INTO `admin_controller_action` VALUES ('43', 'admin', 'UploadAdpic', '5', '添加宣传图片', '2', '');
INSERT INTO `admin_controller_action` VALUES ('44', 'admin', 'EditAdpic', '5', '编辑宣传图片', '3', '');
INSERT INTO `admin_controller_action` VALUES ('45', 'admin', 'language_edit', '7', '编辑语言', '3', '');
INSERT INTO `admin_controller_action` VALUES ('46', 'admin', 'Manager_Add', '6', '添加管理员', '2', '');
INSERT INTO `admin_controller_action` VALUES ('47', 'devicemodel', 'edit', '8', '编辑设备类型', '3', '');
INSERT INTO `admin_controller_action` VALUES ('48', 'admin', 'Role_Edit', '12', '编辑角色', '3', '');
INSERT INTO `admin_controller_action` VALUES ('49', 'admin', 'delrole', '12', '删除角色', '4', '');
INSERT INTO `admin_controller_action` VALUES ('50', 'admin', 'Country_Add', '10', '添加国家', '1', '');
INSERT INTO `admin_controller_action` VALUES ('51', 'admin', 'city_add', '10', '添加城市', '4', '');
INSERT INTO `admin_controller_action` VALUES ('52', 'admin', 'collector_edit', '3', '编辑采集器', '3', '');
INSERT INTO `admin_controller_action` VALUES ('53', 'admin', 'device_down', '4', '导出设备列表', null, '');
INSERT INTO `admin_controller_action` VALUES ('54', 'admin', 'currency_add', '13', '添加货币', '2', '');
INSERT INTO `admin_controller_action` VALUES ('55', 'admin', 'currency_edit', '13', '编辑货币', '3', '');
INSERT INTO `admin_controller_action` VALUES ('56', 'admin', 'currency_del', '13', '删除货币', '4', '');
INSERT INTO `admin_controller_action` VALUES ('57', 'admin', 'userrecords', '1', '用户日志', null, null);
INSERT INTO `admin_controller_action` VALUES ('58', 'itemconfig', 'tree', '11', '等效树木', null, null);
INSERT INTO `admin_controller_action_role` VALUES ('6143', '67', '17');
INSERT INTO `admin_controller_action_role` VALUES ('6142', '67', '16');
INSERT INTO `admin_controller_action_role` VALUES ('6141', '67', '14');
INSERT INTO `admin_controller_action_role` VALUES ('6140', '67', '12');
INSERT INTO `admin_controller_action_role` VALUES ('6139', '67', '8');
INSERT INTO `admin_controller_action_role` VALUES ('6138', '67', '56');
INSERT INTO `admin_controller_action_role` VALUES ('6137', '67', '55');
INSERT INTO `admin_controller_action_role` VALUES ('6136', '67', '54');
INSERT INTO `admin_controller_action_role` VALUES ('6135', '67', '15');
INSERT INTO `admin_controller_action_role` VALUES ('6134', '67', '49');
INSERT INTO `admin_controller_action_role` VALUES ('6133', '67', '48');
INSERT INTO `admin_controller_action_role` VALUES ('6132', '67', '18');
INSERT INTO `admin_controller_action_role` VALUES ('6131', '67', '19');
INSERT INTO `admin_controller_action_role` VALUES ('6130', '67', '42');
INSERT INTO `admin_controller_action_role` VALUES ('6129', '67', '40');
INSERT INTO `admin_controller_action_role` VALUES ('6128', '67', '51');
INSERT INTO `admin_controller_action_role` VALUES ('6127', '67', '39');
INSERT INTO `admin_controller_action_role` VALUES ('6126', '67', '41');
INSERT INTO `admin_controller_action_role` VALUES ('6125', '67', '38');
INSERT INTO `admin_controller_action_role` VALUES ('6124', '67', '50');
INSERT INTO `admin_controller_action_role` VALUES ('6123', '67', '13');
INSERT INTO `admin_controller_action_role` VALUES ('6122', '67', '37');
INSERT INTO `admin_controller_action_role` VALUES ('6121', '67', '11');
INSERT INTO `admin_controller_action_role` VALUES ('6120', '67', '36');
INSERT INTO `admin_controller_action_role` VALUES ('6119', '67', '47');
INSERT INTO `admin_controller_action_role` VALUES ('6118', '67', '35');
INSERT INTO `admin_controller_action_role` VALUES ('6117', '67', '10');
INSERT INTO `admin_controller_action_role` VALUES ('6116', '67', '34');
INSERT INTO `admin_controller_action_role` VALUES ('6115', '67', '45');
INSERT INTO `admin_controller_action_role` VALUES ('6114', '67', '33');
INSERT INTO `admin_controller_action_role` VALUES ('6113', '67', '9');
INSERT INTO `admin_controller_action_role` VALUES ('6112', '67', '32');
INSERT INTO `admin_controller_action_role` VALUES ('6111', '67', '31');
INSERT INTO `admin_controller_action_role` VALUES ('6110', '67', '46');
INSERT INTO `admin_controller_action_role` VALUES ('6109', '67', '29');
INSERT INTO `admin_controller_action_role` VALUES ('6108', '67', '30');
INSERT INTO `admin_controller_action_role` VALUES ('6107', '67', '44');
INSERT INTO `admin_controller_action_role` VALUES ('6106', '67', '43');
INSERT INTO `admin_controller_action_role` VALUES ('6105', '67', '7');
INSERT INTO `admin_controller_action_role` VALUES ('6104', '67', '53');
INSERT INTO `admin_controller_action_role` VALUES ('6103', '67', '6');
INSERT INTO `admin_controller_action_role` VALUES ('6102', '67', '28');
INSERT INTO `admin_controller_action_role` VALUES ('6101', '67', '52');
INSERT INTO `admin_controller_action_role` VALUES ('6100', '67', '24');
INSERT INTO `admin_controller_action_role` VALUES ('6099', '67', '23');
INSERT INTO `admin_controller_action_role` VALUES ('6098', '67', '22');
INSERT INTO `admin_controller_action_role` VALUES ('6097', '67', '21');
INSERT INTO `admin_controller_action_role` VALUES ('6096', '67', '20');
INSERT INTO `admin_controller_action_role` VALUES ('6095', '67', '4');
INSERT INTO `admin_controller_action_role` VALUES ('6094', '67', '57');
INSERT INTO `admin_controller_action_role` VALUES ('6093', '67', '3');
INSERT INTO `admin_controller_action_role` VALUES ('6092', '67', '2');
INSERT INTO `admin_controller_action_role` VALUES ('6091', '67', '1');
INSERT INTO `admin_role` VALUES ('67', '角色1', null);
INSERT INTO `admin_user_role` VALUES ('41', '94', '67');
INSERT INTO `admin_user_role` VALUES ('42', '71', '67');
INSERT INTO `admin_user_role` VALUES ('43', '72', '67');
INSERT INTO `adpic` VALUES ('36', '201106010527178666img01.jpg', 'http://www.sungrowpower.com/index.php', 'zh-CN');
INSERT INTO `adpic` VALUES ('35', '201105310209143998img01.jpg', 'http://www.sungrowpower.com/en/index.php', 'en-US');
INSERT INTO `adpic` VALUES ('38', '201205250932009496img01.jpg', 'http://www.sungrowpower.com/de/index.php', 'de-DE');
INSERT INTO `adpic` VALUES ('39', '201205250932272212img01.jpg', 'http://www.sungrowpower.com/it/index.php ', 'it-ch');
INSERT INTO `commoninfo` VALUES ('2', '1', '￥', 'CNY');
INSERT INTO `commoninfo` VALUES ('3', '1', '＄', 'USD');
INSERT INTO `commoninfo` VALUES ('4', '1', '£', 'GBP');
INSERT INTO `commoninfo` VALUES ('6', '1', '€ ', 'EUR');
INSERT INTO `commoninfo` VALUES ('7', '1', 'р.', 'RUB');
INSERT INTO `commoninfo` VALUES ('8', '1', '₩', 'WON');
INSERT INTO `countrycity` VALUES ('1', null, '中国', '0', '东亚', null, null, null);
INSERT INTO `countrycity` VALUES ('3', null, '日本', '0', '东亚', null, null, null);
INSERT INTO `countrycity` VALUES ('4', null, '合肥', '1', '2127866', null, null, null);
INSERT INTO `countrycity` VALUES ('5', null, '济南', '1', '2168327', null, null, null);
INSERT INTO `countrycity` VALUES ('6', null, '石家庄', '1', '2171287', null, null, null);
INSERT INTO `countrycity` VALUES ('7', null, '上海', '1', '2151849', null, null, null);
INSERT INTO `countrycity` VALUES ('8', null, '成都', '1', '2158433', null, null, null);
INSERT INTO `countrycity` VALUES ('9', null, '東京', '3', '1118370', null, null, null);
INSERT INTO `countrycity` VALUES ('10', null, 'America', '0', '北美洲', null, null, null);
INSERT INTO `countrycity` VALUES ('70', null, 'Nebraska', '10', '2457480', null, null, null);
INSERT INTO `countrycity` VALUES ('12', null, 'Deutschland ', '0', '南欧', null, null, null);
INSERT INTO `countrycity` VALUES ('13', null, 'Köln', '12', '667931', null, null, null);
INSERT INTO `countrycity` VALUES ('14', null, 'Italian ', '0', '东欧', null, null, null);
INSERT INTO `countrycity` VALUES ('15', null, 'Turin', '14', null, null, null, null);
INSERT INTO `countrycity` VALUES ('16', null, 'Palermo', '14', null, null, null, null);
INSERT INTO `countrycity` VALUES ('17', null, 'Pakistan', '0', '南亚', null, null, null);
INSERT INTO `countrycity` VALUES ('18', null, 'Karachi', '17', null, null, null, null);
INSERT INTO `countrycity` VALUES ('19', null, 'NIGERIA', '0', '非洲', null, null, null);
INSERT INTO `countrycity` VALUES ('20', null, 'lagos', '19', null, null, null, null);
INSERT INTO `countrycity` VALUES ('21', null, 'München', '12', '676757', null, null, null);
INSERT INTO `countrycity` VALUES ('22', null, 'England', '0', '西欧', null, null, null);
INSERT INTO `countrycity` VALUES ('23', null, 'France', '0', '西欧', null, null, null);
INSERT INTO `countrycity` VALUES ('24', null, 'Россия', '0', '东欧', null, null, null);
INSERT INTO `countrycity` VALUES ('25', null, 'Suomi', '0', '北欧', null, null, null);
INSERT INTO `countrycity` VALUES ('27', null, '北京', '1', '2151330', null, null, null);
INSERT INTO `countrycity` VALUES ('28', null, '天津', '1', '2159908', null, null, null);
INSERT INTO `countrycity` VALUES ('29', null, '广州', '1', '2161838', null, null, null);
INSERT INTO `countrycity` VALUES ('30', null, '深圳', '1', '2161853', null, null, null);
INSERT INTO `countrycity` VALUES ('31', null, '香港', '1', '2165352', null, null, null);
INSERT INTO `countrycity` VALUES ('32', null, '重庆', '1', '2158434', null, null, null);
INSERT INTO `countrycity` VALUES ('33', null, '宁波', '1', '2132579', null, null, null);
INSERT INTO `countrycity` VALUES ('34', null, '苏州', '1', '2137082', null, null, null);
INSERT INTO `countrycity` VALUES ('35', null, '福州', '1', '2139963', null, null, null);
INSERT INTO `countrycity` VALUES ('36', null, '厦门', '1', '12685770', null, null, null);
INSERT INTO `countrycity` VALUES ('37', null, '南昌', '1', '2133704', null, null, null);
INSERT INTO `countrycity` VALUES ('38', null, '台北', '1', '2306179', null, null, null);
INSERT INTO `countrycity` VALUES ('39', null, '高雄', '1', '2306180', null, null, null);
INSERT INTO `countrycity` VALUES ('40', null, '澳门', '1', null, null, null, null);
INSERT INTO `countrycity` VALUES ('41', null, '长沙', '1', '2142699', null, null, null);
INSERT INTO `countrycity` VALUES ('42', null, '沈阳', '1', '2148332', null, null, null);
INSERT INTO `countrycity` VALUES ('43', null, '大连', '1', '2147986', null, null, null);
INSERT INTO `countrycity` VALUES ('46', null, '南京', '1', '2137081', null, null, null);
INSERT INTO `countrycity` VALUES ('45', null, '青岛', '1', '2168606', null, null, null);
INSERT INTO `countrycity` VALUES ('47', null, '杭州', '1', '2132574', null, null, null);
INSERT INTO `countrycity` VALUES ('48', null, '武汉', '1', '2163866', null, null, null);
INSERT INTO `countrycity` VALUES ('49', null, '成都', '1', '2158433', null, null, null);
INSERT INTO `countrycity` VALUES ('50', null, '长春', '1', '2137321', null, null, null);
INSERT INTO `countrycity` VALUES ('51', null, '西安', '1', '2157249', null, null, null);
INSERT INTO `countrycity` VALUES ('52', null, '汕头', '1', '2162312', null, null, null);
INSERT INTO `countrycity` VALUES ('53', null, '珠海', '1', '2161856', null, null, null);
INSERT INTO `countrycity` VALUES ('54', null, '海口', '1', '2160123', null, null, null);
INSERT INTO `countrycity` VALUES ('55', null, '南宁', '1', '2166473', null, null, null);
INSERT INTO `countrycity` VALUES ('56', null, '太原', '1', '2154547', null, null, null);
INSERT INTO `countrycity` VALUES ('57', null, '郑州', '1', '2172736', null, null, null);
INSERT INTO `countrycity` VALUES ('58', null, '贵阳', '1', '2146703', null, null, null);
INSERT INTO `countrycity` VALUES ('59', null, '昆明', '1', '2160693', null, null, null);
INSERT INTO `countrycity` VALUES ('60', null, '拉萨', '1', '2144789', null, null, null);
INSERT INTO `countrycity` VALUES ('61', null, '兰州', '1', '2145605', null, null, null);
INSERT INTO `countrycity` VALUES ('62', null, '西宁', '1', '2138941', null, null, null);
INSERT INTO `countrycity` VALUES ('63', null, '银川', '1', '2150551', null, null, null);
INSERT INTO `countrycity` VALUES ('64', null, '乌鲁木齐', '1', '2143692', null, null, null);
INSERT INTO `countrycity` VALUES ('65', null, '呼和浩特', '1', '2149760', null, null, null);
INSERT INTO `countrycity` VALUES ('66', null, '哈尔滨', '1', '2141166', null, null, null);
INSERT INTO `countrycity` VALUES ('67', null, '石家庄', '1', '2171287', null, null, null);
INSERT INTO `countrycity` VALUES ('68', null, '唐山', '1', '2171288', null, null, null);
INSERT INTO `countrycity` VALUES ('69', null, 'Alabama', '10', '2352520', null, null, null);
INSERT INTO `countrycity` VALUES ('71', null, 'Alaska', '10', '2352609', null, null, null);
INSERT INTO `countrycity` VALUES ('72', null, 'Nevada', '10', '2457929', null, null, null);
INSERT INTO `countrycity` VALUES ('73', null, 'Arizona', '10', '112385', null, null, null);
INSERT INTO `countrycity` VALUES ('74', null, 'New Hampshire', '10', '2458352', null, null, null);
INSERT INTO `countrycity` VALUES ('75', null, 'Arkansas', '10', '2355840', null, null, null);
INSERT INTO `countrycity` VALUES ('76', null, 'New Jersy', '10', '23392787', null, null, null);
INSERT INTO `countrycity` VALUES ('77', null, 'California', '10', '2373278', null, null, null);
INSERT INTO `countrycity` VALUES ('78', null, 'New Mexico', '10', '133481', null, null, null);
INSERT INTO `countrycity` VALUES ('79', null, 'Colorado', '10', '429937', null, null, null);
INSERT INTO `countrycity` VALUES ('80', null, 'New York', '10', '2459115', null, null, null);
INSERT INTO `countrycity` VALUES ('81', null, 'Connecticut', '10', null, null, null, null);
INSERT INTO `countrycity` VALUES ('82', null, 'North Carolina', '10', '2375281', null, null, null);
INSERT INTO `countrycity` VALUES ('83', null, 'Delaware', '10', '2390774', null, null, null);
INSERT INTO `countrycity` VALUES ('84', null, 'North Dakota', '10', '2388832', null, null, null);
INSERT INTO `countrycity` VALUES ('85', null, 'District of Columbia', '10', '2383552', null, null, null);
INSERT INTO `countrycity` VALUES ('86', null, 'Ohio', '10', '2464399', null, null, null);
INSERT INTO `countrycity` VALUES ('87', null, 'Florida', '10', '2404567', null, null, null);
INSERT INTO `countrycity` VALUES ('88', null, 'Oklahoma', '10', '2464530', null, null, null);
INSERT INTO `countrycity` VALUES ('89', null, 'Georgia', '10', '2409718', null, null, null);
INSERT INTO `countrycity` VALUES ('90', null, 'Oregon', '10', '2466127', null, null, null);
INSERT INTO `countrycity` VALUES ('91', null, 'Hawaii', '10', null, null, null, null);
INSERT INTO `countrycity` VALUES ('92', null, 'Pennsylvania', '10', null, null, null, null);
INSERT INTO `countrycity` VALUES ('93', null, 'Idaho', '10', '2426432', null, null, null);
INSERT INTO `countrycity` VALUES ('94', null, 'Puerto Rico', '10', '2477171', null, null, null);
INSERT INTO `countrycity` VALUES ('95', null, 'Illinois', '10', '2426607', null, null, null);
INSERT INTO `countrycity` VALUES ('96', null, 'Rhode Island', '10', null, null, null, null);
INSERT INTO `countrycity` VALUES ('97', null, 'Indiana', '10', '2427026', null, null, null);
INSERT INTO `countrycity` VALUES ('98', null, 'South Carolina', '10', '2375281', null, null, null);
INSERT INTO `countrycity` VALUES ('99', null, 'Iowa', '10', '2427419', null, null, null);
INSERT INTO `countrycity` VALUES ('100', null, 'South Dakota', '10', '238883', null, null, null);
INSERT INTO `countrycity` VALUES ('101', null, 'Kansas', '10', '2430624', null, null, null);
INSERT INTO `countrycity` VALUES ('102', null, 'Tennessee', '10', '2504768', null, null, null);
INSERT INTO `countrycity` VALUES ('103', null, 'Kentucky', '10', '2431733', null, null, null);
INSERT INTO `countrycity` VALUES ('104', null, 'Texas', '10', '2505016', null, null, null);
INSERT INTO `countrycity` VALUES ('105', null, 'Louisiana', '10', '2442315', null, null, null);
INSERT INTO `countrycity` VALUES ('106', null, 'Utah', '10', '2510492', null, null, null);
INSERT INTO `countrycity` VALUES ('107', null, 'Maine', '10', '2444325', null, null, null);
INSERT INTO `countrycity` VALUES ('108', null, 'Vermont', '10', '2511768', null, null, null);
INSERT INTO `countrycity` VALUES ('109', null, 'Maryland', '10', '2446527', null, null, null);
INSERT INTO `countrycity` VALUES ('110', null, 'Virginia', '10', '2512622', null, null, null);
INSERT INTO `countrycity` VALUES ('111', null, 'Massachusetts', '10', null, null, null, null);
INSERT INTO `countrycity` VALUES ('112', null, 'Virgin Islands', '10', '55971473', null, null, null);
INSERT INTO `countrycity` VALUES ('113', null, 'Michigan', '10', '2450139', null, null, null);
INSERT INTO `countrycity` VALUES ('114', null, 'Washington', '10', '2514815', null, null, null);
INSERT INTO `countrycity` VALUES ('115', null, 'Minnesota', '10', '2452134', null, null, null);
INSERT INTO `countrycity` VALUES ('116', null, 'West Virginia', '10', '2517899', null, null, null);
INSERT INTO `countrycity` VALUES ('117', null, 'Mississippi', '10', '55992387', null, null, null);
INSERT INTO `countrycity` VALUES ('118', null, 'Wisconsin', '10', null, null, null, null);
INSERT INTO `countrycity` VALUES ('119', null, 'Missouri', '10', null, null, null, null);
INSERT INTO `countrycity` VALUES ('120', null, 'Wyoming', '10', '2524381', null, null, null);
INSERT INTO `countrycity` VALUES ('121', null, 'Montana', '10', '2453135', null, null, null);
INSERT INTO `countrycity` VALUES ('122', null, '神奈川', '3', '28415594', null, null, null);
INSERT INTO `countrycity` VALUES ('123', null, '大阪', '3', '15015370', null, null, null);
INSERT INTO `countrycity` VALUES ('124', null, '横浜', '3', '1118550', null, null, null);
INSERT INTO `countrycity` VALUES ('125', null, '名古屋', '3', '1117817', null, null, null);
INSERT INTO `countrycity` VALUES ('126', null, '札幌', '3', '1118108', null, null, null);
INSERT INTO `countrycity` VALUES ('127', null, '神戸', '3', '1117545', null, null, null);
INSERT INTO `countrycity` VALUES ('128', null, '京都', '3', '15015372', null, null, null);
INSERT INTO `countrycity` VALUES ('129', null, '福岡', '3', '1117099', null, null, null);
INSERT INTO `countrycity` VALUES ('130', null, 'カワサキ', '3', '1117099', null, null, null);
INSERT INTO `countrycity` VALUES ('131', null, '埼玉県', '3', null, null, null, null);
INSERT INTO `countrycity` VALUES ('132', null, '広島', '3', '1117227', null, null, null);
INSERT INTO `countrycity` VALUES ('133', null, '仙台', '3', '1118129', null, null, null);
INSERT INTO `countrycity` VALUES ('134', null, '北九州', '3', '1110809', null, null, null);
INSERT INTO `countrycity` VALUES ('135', null, '千葉県', '3', null, null, null, null);
INSERT INTO `countrycity` VALUES ('136', null, 'Frankfurt', '12', '650272', null, null, null);
INSERT INTO `countrycity` VALUES ('137', null, 'Berlin', '12', '638242', null, null, null);
INSERT INTO `countrycity` VALUES ('138', null, 'Stuttgart', '12', '698064', null, null, null);
INSERT INTO `countrycity` VALUES ('139', null, 'Hannover', '12', '657169', null, null, null);
INSERT INTO `countrycity` VALUES ('140', null, 'Leipzig', '12', '671072', null, null, null);
INSERT INTO `countrycity` VALUES ('141', null, 'Dresden', '12', '645686', null, null, null);
INSERT INTO `countrycity` VALUES ('142', null, 'Weimar', '12', '704770', null, null, null);
INSERT INTO `countrycity` VALUES ('143', null, 'London', '22', '44418', null, null, null);
INSERT INTO `countrycity` VALUES ('144', null, 'Birmingham', '22', '12723', null, null, null);
INSERT INTO `countrycity` VALUES ('145', null, 'Glasgow', '22', '21125', null, null, null);
INSERT INTO `countrycity` VALUES ('146', null, 'Manchester', '22', '28218', null, null, null);
INSERT INTO `countrycity` VALUES ('147', null, 'Liverpool', '22', '26734', null, null, null);
INSERT INTO `countrycity` VALUES ('148', null, 'Cardiff', '22', '15127', null, null, null);
INSERT INTO `countrycity` VALUES ('149', null, 'Newcastle', '22', '30079', null, null, null);
INSERT INTO `countrycity` VALUES ('150', null, 'Leicester', '22', '26062', null, null, null);
INSERT INTO `countrycity` VALUES ('151', null, 'Exeter', '22', '19792', null, null, null);
INSERT INTO `countrycity` VALUES ('152', null, 'Belfast', '22', '19792', null, null, null);
INSERT INTO `countrycity` VALUES ('153', null, 'Portsmouth', '22', '32452', null, null, null);
INSERT INTO `countrycity` VALUES ('154', null, 'Leeds', '22', '26042', null, null, null);
INSERT INTO `countrycity` VALUES ('155', null, 'Paris', '23', '615702', null, null, null);
INSERT INTO `countrycity` VALUES ('156', null, 'Dunkerque', '23', '589284', null, null, null);
INSERT INTO `countrycity` VALUES ('157', null, 'Lille', '23', '608105', null, null, null);
INSERT INTO `countrycity` VALUES ('158', null, 'Cherbourg', '23', '585596', null, null, null);
INSERT INTO `countrycity` VALUES ('159', null, 'Rouen', '23', '620108', null, null, null);
INSERT INTO `countrycity` VALUES ('160', null, 'Nancy', '23', '613836', null, null, null);
INSERT INTO `countrycity` VALUES ('161', null, 'Brest', '23', '581787', null, null, null);
INSERT INTO `countrycity` VALUES ('162', null, 'Strasbourg', '23', '627791', null, null, null);
INSERT INTO `countrycity` VALUES ('163', null, 'Orleans', '23', '615134', null, null, null);
INSERT INTO `countrycity` VALUES ('164', null, 'Nantes', '23', '613858', null, null, null);
INSERT INTO `countrycity` VALUES ('165', null, 'Dijon', '23', '588765', null, null, null);
INSERT INTO `countrycity` VALUES ('166', null, 'Limoges', '23', '608140', null, null, null);
INSERT INTO `countrycity` VALUES ('167', null, 'Lyon', '23', '609125', null, null, null);
INSERT INTO `countrycity` VALUES ('168', null, 'Grenoble', '23', '593720', null, null, null);
INSERT INTO `countrycity` VALUES ('169', null, 'Bordeaux', '23', '580778', null, null, null);
INSERT INTO `countrycity` VALUES ('170', null, 'Valence', '23', '629840', null, null, null);
INSERT INTO `countrycity` VALUES ('171', null, 'Toulouse', '23', '628886', null, null, null);
INSERT INTO `countrycity` VALUES ('172', null, 'Nice', '23', '614274', null, null, null);
INSERT INTO `countrycity` VALUES ('173', null, 'Perpignan', '23', '616113', null, null, null);
INSERT INTO `countrycity` VALUES ('174', null, 'Marseille', '23', '610264', null, null, null);
INSERT INTO `countrycity` VALUES ('175', null, 'Toulon', '23', '628878', null, null, null);
INSERT INTO `countrycity` VALUES ('176', null, 'Москва', '24', null, null, null, null);
INSERT INTO `countrycity` VALUES ('177', null, 'Санкт-Петербург', '24', null, null, null, null);
INSERT INTO `countrycity` VALUES ('178', null, 'Владивосток', '24', null, null, null, null);
INSERT INTO `countrycity` VALUES ('179', null, 'Мурманск', '24', null, null, null, null);
INSERT INTO `countrycity` VALUES ('180', null, 'Екатеринбург', '24', null, null, null, null);
INSERT INTO `countrycity` VALUES ('181', null, 'Челябинск', '24', null, null, null, null);
INSERT INTO `countrycity` VALUES ('183', null, 'Магнитогорск', '24', null, null, null, null);
INSERT INTO `countrycity` VALUES ('184', null, 'Новосибирск', '24', null, null, null, null);
INSERT INTO `countrycity` VALUES ('185', null, 'Ленинградская', '24', null, null, null, null);
INSERT INTO `countrycity` VALUES ('186', null, 'Rotterdam', '25', '733075', null, null, null);
INSERT INTO `countrycity` VALUES ('187', null, 'Amsterdam', '25', '727232', null, null, null);
INSERT INTO `countrycity` VALUES ('188', null, 'Den Haag', '25', '726874', null, null, null);
INSERT INTO `countrycity` VALUES ('189', null, 'Zo hoog', '25', null, null, null, null);
INSERT INTO `countrycity` VALUES ('191', null, 'Leiden', '25', '731208', null, null, null);
INSERT INTO `countrycity` VALUES ('192', null, 'Arezzo', '14', '710284', null, null, null);
INSERT INTO `countrycity` VALUES ('193', null, 'Bari', '14', '710722', null, null, null);
INSERT INTO `countrycity` VALUES ('194', null, 'Brescia', '14', '711410', null, null, null);
INSERT INTO `countrycity` VALUES ('195', null, 'Catania', '14', '713571', null, null, null);
INSERT INTO `countrycity` VALUES ('196', null, 'Florence', '14', '715496', null, null, null);
INSERT INTO `countrycity` VALUES ('197', null, 'Genova', '14', '716085', null, null, null);
INSERT INTO `countrycity` VALUES ('198', null, 'Milan', '14', '718345', null, null, null);
INSERT INTO `countrycity` VALUES ('199', null, 'Naples', '14', '719258', null, null, null);
INSERT INTO `countrycity` VALUES ('200', null, 'Palermo', '14', '719846', null, null, null);
INSERT INTO `countrycity` VALUES ('201', null, 'Pisa', '14', '720627', null, null, null);
INSERT INTO `countrycity` VALUES ('202', null, 'Rome', '14', '721943', null, null, null);
INSERT INTO `countrycity` VALUES ('203', null, 'Siena', '14', '724196', null, null, null);
INSERT INTO `countrycity` VALUES ('204', null, 'Turin', '14', '725003', null, null, null);
INSERT INTO `countrycity` VALUES ('205', null, 'Venice', '14', '725746', null, null, null);
INSERT INTO `dataitem` VALUES ('4', '4107,4106,4108,4109,4113,4110,4111,4112,', '');
INSERT INTO `dataitem` VALUES ('3', '3100,3101,3102,3103,3107,3104,3105,3106,', '');
INSERT INTO `dataitem` VALUES ('2', '2094,2095,2096,2097,2101,2098,2099,2100,', '');
INSERT INTO `dataitem` VALUES ('5', '5112,5114,5119,5117,5118,', '');
INSERT INTO `dataitem` VALUES ('11', '2,1,3,4,5,6,', '');
INSERT INTO `dataitem` VALUES ('12', '2094,2095,2096,2097,2098,2099,2101,', '');
INSERT INTO `dataitem` VALUES ('13', '3100,3101,3102,3103,3104,3105,', '');
INSERT INTO `dataitem` VALUES ('14', '4107,4106,4108,4109,4110,4111,', '');
INSERT INTO `dataitem` VALUES ('15', '5112,5114,5117,', '');
INSERT INTO `dataitem` VALUES ('1', '1,2,3,4,12,5,6,7,106,107,108,103,104,115,125,126,128,109,110,111,112,114,113,116,117,118,119,120,121,122,123,124,136,135,138,137,129,139,140,', '');
INSERT INTO `device_model` VALUES ('31', 'SG1K5TL', '1', '1.50');
INSERT INTO `device_model` VALUES ('32', 'SG2K5TL', '1', '2.50');
INSERT INTO `device_model` VALUES ('11', 'SG3K-B', '1', '3.00');
INSERT INTO `device_model` VALUES ('12', 'SG5K-B', '1', '5.00');
INSERT INTO `device_model` VALUES ('13', 'SG5K-C', '1', '5.00');
INSERT INTO `device_model` VALUES ('33', 'SG3KTL', '1', '3.00');
INSERT INTO `device_model` VALUES ('34', 'SG4KTL', '1', '4.00');
INSERT INTO `device_model` VALUES ('35', 'SG5KTL', '1', '5.00');
INSERT INTO `device_model` VALUES ('36', 'SG6KTL', '1', '6.00');
INSERT INTO `device_model` VALUES ('37', 'SG8KTL', '1', '8.00');
INSERT INTO `device_model` VALUES ('38', 'SG10KTL', '1', '10.00');
INSERT INTO `device_model` VALUES ('39', 'SG30KTL', '1', '30.00');
INSERT INTO `device_model` VALUES ('40', 'SG15KTL', '1', '15.00');
INSERT INTO `device_model` VALUES ('141', 'SG10K3', '1', '10.00');
INSERT INTO `device_model` VALUES ('143', 'SG30K3', '1', '30.00');
INSERT INTO `device_model` VALUES ('144', 'SG50K3', '1', '50.00');
INSERT INTO `device_model` VALUES ('145', 'SG100K3', '1', '100.00');
INSERT INTO `device_model` VALUES ('146', 'SG250K3', '1', '250.00');
INSERT INTO `device_model` VALUES ('147', 'SG250KTL', '1', '250.00');
INSERT INTO `device_model` VALUES ('148', 'SG500K3', '1', '500.00');
INSERT INTO `device_model` VALUES ('149', 'SG500KTL', '1', '500.00');
INSERT INTO `device_model` VALUES ('150', 'SG1000KTL', '1', '1000.00');
INSERT INTO `device_model` VALUES ('151', 'SG250KLV', '1', '250.00');
INSERT INTO `device_model` VALUES ('51', 'WG1K5TL', '1', '1.50');
INSERT INTO `device_model` VALUES ('52', 'WG2K5TL', '1', '2.50');
INSERT INTO `device_model` VALUES ('53', 'WG3K', '1', '3.00');
INSERT INTO `device_model` VALUES ('54', 'WG5K', '1', '5.00');
INSERT INTO `device_model` VALUES ('55', 'WG10K', '1', '10.00');
INSERT INTO `device_model` VALUES ('58', 'WG10K-B', '1', '10.00');
INSERT INTO `device_model` VALUES ('161', 'WG10K3', '1', '10.00');
INSERT INTO `device_model` VALUES ('56', 'WG20K', '1', '20.00');
INSERT INTO `device_model` VALUES ('162', 'WG20K3', '1', '20.00');
INSERT INTO `device_model` VALUES ('57', 'WG30K', '1', '30.00');
INSERT INTO `device_model` VALUES ('163', 'WG30K3', '1', '50.00');
INSERT INTO `device_model` VALUES ('164', 'WG50K3', '1', '50.00');
INSERT INTO `device_model` VALUES ('201', 'SC22020', '1', '20.00');
INSERT INTO `device_model` VALUES ('202', 'SC4860', '1', null);
INSERT INTO `device_model` VALUES ('205', 'SC48200-3', '1', null);
INSERT INTO `device_model` VALUES ('71', 'WEL2K', '1', '2.00');
INSERT INTO `device_model` VALUES ('72', 'WEL4K', '1', '4.00');
INSERT INTO `device_model` VALUES ('73', 'WEL6K', '1', '6.00');
INSERT INTO `device_model` VALUES ('74', 'WEL10K', '1', '10.00');
INSERT INTO `device_model` VALUES ('75', 'WEL20K', '1', '20.00');
INSERT INTO `device_model` VALUES ('76', 'WEL30K', '1', '30.00');
INSERT INTO `device_model` VALUES ('97', 'SDCPG', '1', null);
INSERT INTO `device_model` VALUES ('81', 'GCI1500(OEM)', '1', null);
INSERT INTO `device_model` VALUES ('82', 'GCI5000(OEM)', '1', null);
INSERT INTO `device_model` VALUES ('208', 'PVS-6M', '3', null);
INSERT INTO `device_model` VALUES ('209', 'PVS-16M', '3', null);
INSERT INTO `device_model` VALUES ('210', 'PVS-16M8', '3', null);
INSERT INTO `device_model` VALUES ('211', 'PVS-12M', '3', null);
INSERT INTO `device_model` VALUES ('212', 'PVS-8M', '3', null);
INSERT INTO `device_model` VALUES ('224', 'SS100K', '1', '100.00');
INSERT INTO `device_model` VALUES ('225', 'SS100KLV', '1', '100.00');
INSERT INTO `device_model` VALUES ('157', 'SG125KTL', '1', '125.00');
INSERT INTO `device_model` VALUES ('14', 'SG6K-B', '1', '6.00');
INSERT INTO `device_model` VALUES ('15', 'SG6K-C', '1', '6.00');
INSERT INTO `device_model` VALUES ('41', 'SG12KTL', '1', '12.00');
INSERT INTO `device_model` VALUES ('152', 'SG630KTL', '1', '630.00');
INSERT INTO `device_model` VALUES ('153', 'SG100KC', '1', '100.00');
INSERT INTO `device_model` VALUES ('154', 'SG100KU', '1', '100.00');
INSERT INTO `device_model` VALUES ('155', 'SG250KC', '1', '250.00');
INSERT INTO `device_model` VALUES ('156', 'SG250KU', '1', '250.00');
INSERT INTO `device_model` VALUES ('158', 'SG100KLV', '1', '100.00');
INSERT INTO `device_model` VALUES ('159', 'SG500LV', '1', '500.00');
INSERT INTO `device_model` VALUES ('142', 'SG20K3', '1', '20.00');
INSERT INTO `device_model` VALUES ('42', 'SG20KTL', '1', '20.00');
INSERT INTO `device_model` VALUES ('4', 'SG5K-B', '1', '5.00');
INSERT INTO `device_model` VALUES ('176', 'SG630MX', '1', '630.00');
INSERT INTO `device_model` VALUES ('160', 'SG500MX', '1', '500.00');
INSERT INTO `device_model` VALUES ('177', 'SG100J', '1', '100.00');
INSERT INTO `device_model` VALUES ('179', 'SG2KTL', '1', '2.00');
INSERT INTO `device_model` VALUES ('180', 'SG3KTL-M', '1', '3.00');
INSERT INTO `device_model` VALUES ('181', 'SG4KTL-M', '1', '5.00');
INSERT INTO `device_model` VALUES ('178', 'SG5KTL-M', '1', '5.00');
INSERT INTO `item_config` VALUES ('47', '二氧化碳减排', '0.6', '1');
INSERT INTO `item_config` VALUES ('48', '每天生成采集器数量', '50', '1');
INSERT INTO `item_config` VALUES ('49', '生成采集器过期天数', '15', '1');
INSERT INTO `item_config` VALUES ('50', '等效树木', '40', '1');
INSERT INTO `language` VALUES ('1', 'English', 'en-US', null, '', 'USD', '英语', '');
INSERT INTO `language` VALUES ('2', '中文', 'zh-CN', null, '', 'RMB', '汉语', '');
INSERT INTO `language` VALUES ('3', '日文', 'ja-JP', null, '', 'Yen', '日语', '');
INSERT INTO `language` VALUES ('4', '한국어', 'ko-KR', null, '', 'Won', '韩语', '');
INSERT INTO `language` VALUES ('5', 'Française', 'fr-FR', null, '', 'Franc', '法语', '');
INSERT INTO `language` VALUES ('6', 'Deutsch', 'de-DE', null, '', 'DEM', '德语', '');
INSERT INTO `language` VALUES ('7', 'Россию', 'ru-RU', null, '', 'Rouble', '俄语', '');
INSERT INTO `language` VALUES ('30', 'Suomi', 'fi-FI', null, '', 'FIM', '芬兰', '');
INSERT INTO `language` VALUES ('31', 'Italian', 'it-ch', null, '', 'Lit.', '意大利', '');
INSERT INTO `mail_config` VALUES ('7', 'mail.solarinfobank.com', 'service@solarinfobank.com', '111111', '25');
INSERT INTO `manager` VALUES ('65', 'admin', '5ckKVrvKiB09mXc3yCs7JA==', '软件接口部', 'admin', '', 'zhouh@sungrowpower.com', '0', null, null);
INSERT INTO `manager` VALUES ('71', 'manuser', 'yGvItMGM0RQQmcTZ4tK63A==', '生产部', '采集器管理员', '', 'zhouh@sungrow.com.cn', '1', null, null);
INSERT INTO `manager` VALUES ('72', 'test111', '111', null, '111', '', 'dsf@sdaf.erw', '1', '0', '2012-04-10 10:02:20');
INSERT INTO `manager_monitor_code` VALUES ('1', '日发电量', '0', '', '10');
INSERT INTO `manager_monitor_code` VALUES ('2', '总发电量', '0', '', '9');
INSERT INTO `manager_monitor_code` VALUES ('3', '日功率', '0', '', null);
INSERT INTO `manager_monitor_code` VALUES ('5', '安装功率', '0', '', '6');
INSERT INTO `manager_monitor_code` VALUES ('6', '今日CO2减排', '0', '', '8');
INSERT INTO `manager_monitor_code` VALUES ('7', '累计CO2减排', '0', '', '7');
INSERT INTO `manager_monitor_code` VALUES ('8', '今日收益', '0', '', null);
INSERT INTO `manager_monitor_code` VALUES ('9', '温度', '0', '', null);
INSERT INTO `manager_monitor_code` VALUES ('10', '日照强度', '0', '', null);
INSERT INTO `manager_monitor_code` VALUES ('13', '总发电量', '1', '', '1');
INSERT INTO `manager_monitor_code` VALUES ('14', '机内空气温度', '1', '', null);
INSERT INTO `manager_monitor_code` VALUES ('15', '机内变压器温度', '1', '', null);
INSERT INTO `manager_monitor_code` VALUES ('16', '机内散热器温度', '1', '', null);
INSERT INTO `manager_monitor_code` VALUES ('17', '直流电压1', '1', '', null);
INSERT INTO `manager_monitor_code` VALUES ('18', '直流电流1', '1', '', null);
INSERT INTO `manager_monitor_code` VALUES ('19', '直流电压2', '1', '', null);
INSERT INTO `manager_monitor_code` VALUES ('20', '直流电流2', '1', '', null);
INSERT INTO `manager_monitor_code` VALUES ('21', '直流电压3', '1', '', null);
INSERT INTO `manager_monitor_code` VALUES ('22', '直流电流3', '1', '', null);
INSERT INTO `manager_monitor_code` VALUES ('23', '总直流功率', '1', '', null);
INSERT INTO `manager_monitor_code` VALUES ('24', 'A相电压', '1', '', null);
INSERT INTO `manager_monitor_code` VALUES ('25', ' B相电压', '1', '', null);
INSERT INTO `manager_monitor_code` VALUES ('26', 'C相电压', '1', '', null);
INSERT INTO `manager_monitor_code` VALUES ('27', 'A相电流', '1', '', null);
INSERT INTO `manager_monitor_code` VALUES ('28', 'B相电流', '1', '', null);
INSERT INTO `manager_monitor_code` VALUES ('29', 'C相电流', '1', '', null);
INSERT INTO `manager_monitor_code` VALUES ('30', 'A相有功功率', '1', '', null);
INSERT INTO `manager_monitor_code` VALUES ('31', ' B相有功功率', '1', '', null);
INSERT INTO `manager_monitor_code` VALUES ('32', ' C相有功功率', '1', '', null);
INSERT INTO `manager_monitor_code` VALUES ('33', '总有功功率', '1', '', null);
INSERT INTO `manager_monitor_code` VALUES ('34', '总无功功率', '1', '', null);
INSERT INTO `manager_monitor_code` VALUES ('35', '总功率因数', '1', '', null);
INSERT INTO `manager_monitor_code` VALUES ('36', '电网频率', '1', '', null);
INSERT INTO `manager_monitor_code` VALUES ('37', '逆变器效率', '1', '', null);
INSERT INTO `manager_monitor_code` VALUES ('38', '安装功率', '1', '', null);
INSERT INTO `manager_monitor_code` VALUES ('39', '当前功率 ', '1', '', null);
INSERT INTO `manager_monitor_code` VALUES ('40', '今日发电量', '1', '', '10');
INSERT INTO `manager_monitor_code` VALUES ('41', '本月发电量', '1', '', '9');
INSERT INTO `manager_monitor_code` VALUES ('42', '本月每KWP发电量 ', '1', '', null);
INSERT INTO `manager_monitor_code` VALUES ('43', '累计发电量 ', '1', '', '8');
INSERT INTO `manager_monitor_code` VALUES ('44', '总每KWP发电量', '0', '', '4');
INSERT INTO `manager_monitor_code` VALUES ('45', '日每KWP发电量', '0', '', '5');
INSERT INTO `manager_monitor_code` VALUES ('46', '累计发电量', '0', '', null);
INSERT INTO `monitor_config` VALUES ('26', '1', '104,106,107,108,109,110,111,112,113,');
INSERT INTO `monitor_config` VALUES ('25', '0', '17,11,15,13,21,19,');
INSERT INTO `monitor_config` VALUES ('27', '5', '505,507,504,506,503,508,509,510,512,');
INSERT INTO `monitor_config` VALUES ('28', '3', '324,325,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,');
INSERT INTO `monitor_config` VALUES ('29', '7', '324,325,301,302,303,304,305,306,307,308,309,310,');
INSERT INTO `monitor_config` VALUES ('30', '9', '901,902,903,904,905,906,907,908,909,910,911,912,');
INSERT INTO `monitor_item` VALUES ('202', '2', '', '', '', '8', null, null);
INSERT INTO `monitor_item` VALUES ('203', '2', '', '', '', '9', 'kWh', null);
INSERT INTO `monitor_item` VALUES ('204', '2', '', '', '', '10', 'kWh', null);
INSERT INTO `monitor_item` VALUES ('206', '2', '', '', '', '11', 'h', null);
INSERT INTO `monitor_item` VALUES ('208', '2', '', '', '', '12', '℃', null);
INSERT INTO `monitor_item` VALUES ('209', '2', '', '', '', '13', '℃', null);
INSERT INTO `monitor_item` VALUES ('210', '2', '', '', '', '14', '℃', null);
INSERT INTO `monitor_item` VALUES ('211', '2', '', '', '', '15', 'V', null);
INSERT INTO `monitor_item` VALUES ('212', '2', '', '', '', '16', 'A', null);
INSERT INTO `monitor_item` VALUES ('213', '2', '', '', '', '17', 'V', null);
INSERT INTO `monitor_item` VALUES ('214', '2', '', '', '', '18', 'A', null);
INSERT INTO `monitor_item` VALUES ('215', '2', '', '', '', '19', 'V', null);
INSERT INTO `monitor_item` VALUES ('216', '2', '', '', '', '20', 'A', null);
INSERT INTO `monitor_item` VALUES ('217', '2', '', '', '', '21', 'W', null);
INSERT INTO `monitor_item` VALUES ('219', '2', '', '', '', '22', 'V', null);
INSERT INTO `monitor_item` VALUES ('220', '2', '', '', '', '23', 'V', null);
INSERT INTO `monitor_item` VALUES ('221', '2', '', '', '', '24', 'V', null);
INSERT INTO `monitor_item` VALUES ('222', '2', '', '', '', '25', 'A', null);
INSERT INTO `monitor_item` VALUES ('223', '2', '', '', '', '26', 'A', null);
INSERT INTO `monitor_item` VALUES ('224', '2', '', '', '', '27', 'A', null);
INSERT INTO `monitor_item` VALUES ('225', '2', '', '', '', '28', 'W', null);
INSERT INTO `monitor_item` VALUES ('227', '2', '', '', '', '29', 'W', null);
INSERT INTO `monitor_item` VALUES ('229', '2', '', '', '', '30', 'W', null);
INSERT INTO `monitor_item` VALUES ('231', '2', '', '', '', '31', 'W', null);
INSERT INTO `monitor_item` VALUES ('233', '2', '', '', '', '32', 'W', null);
INSERT INTO `monitor_item` VALUES ('235', '2', '', '', '', '33', null, null);
INSERT INTO `monitor_item` VALUES ('236', '2', '', '', '', '34', 'Hz', null);
INSERT INTO `monitor_item` VALUES ('237', '2', '', '', '', '35', '%', null);
INSERT INTO `monitor_item` VALUES ('238', '2', '', '', '', '36', null, null);
INSERT INTO `monitor_item` VALUES ('239', '2', '', '', '', '37', null, null);
INSERT INTO `monitor_item` VALUES ('245', '2', '', '', '', '38', null, null);
INSERT INTO `monitor_item` VALUES ('246', '2', '', '', '', '39', null, null);
INSERT INTO `monitor_item` VALUES ('247', '2', '', '', '', '40', null, null);
INSERT INTO `monitor_item` VALUES ('101', '1', '', '', '', '41', 'V', null);
INSERT INTO `monitor_item` VALUES ('102', '1', '', '', '', '42', 'A', null);
INSERT INTO `monitor_item` VALUES ('104', '1', '', '', '', '43', 'V', null);
INSERT INTO `monitor_item` VALUES ('106', '1', '', '', '', '44', 'A', null);
INSERT INTO `monitor_item` VALUES ('108', '1', '', '', '', '45', '℃', null);
INSERT INTO `monitor_item` VALUES ('110', '1', '', '', '', '46', 'kWh', null);
INSERT INTO `monitor_item` VALUES ('112', '1', '', '', '', '47', 'kWh', null);
INSERT INTO `monitor_item` VALUES ('116', '1', '', '', '', '48', null, null);
INSERT INTO `monitor_item` VALUES ('120', '1', '', '', '', '49', 'Hz', null);
INSERT INTO `monitor_item` VALUES ('1701', '11', '', '', '', '50', 'A', null);
INSERT INTO `monitor_item` VALUES ('1702', '11', '', '', '', '51', 'A', null);
INSERT INTO `monitor_item` VALUES ('1703', '11', '', '', '', '52', 'A', null);
INSERT INTO `monitor_item` VALUES ('1704', '11', '', '', '', '53', 'A', null);
INSERT INTO `monitor_item` VALUES ('1705', '11', '', '', '', '54', 'A', null);
INSERT INTO `monitor_item` VALUES ('1706', '11', '', '', '', '55', 'A', null);
INSERT INTO `monitor_item` VALUES ('1707', '11', '', '', '', '56', 'A', null);
INSERT INTO `monitor_item` VALUES ('1708', '11', '', '', '', '57', 'A', null);
INSERT INTO `monitor_item` VALUES ('1709', '11', '', '', '', '58', 'A', null);
INSERT INTO `monitor_item` VALUES ('1710', '11', '', '', '', '59', 'A', null);
INSERT INTO `monitor_item` VALUES ('1711', '11', '', '', '', '60', 'A', null);
INSERT INTO `monitor_item` VALUES ('1712', '11', '', '', '', '61', 'A', null);
INSERT INTO `monitor_item` VALUES ('1713', '11', '', '', '', '62', 'A', null);
INSERT INTO `monitor_item` VALUES ('1714', '11', '', '', '', '63', 'A', null);
INSERT INTO `monitor_item` VALUES ('1715', '11', '', '', '', '64', 'A', null);
INSERT INTO `monitor_item` VALUES ('1716', '11', '', '', '', '65', 'A', null);
INSERT INTO `monitor_item` VALUES ('1718', '11', '', '', '', '66', 'V', null);
INSERT INTO `monitor_item` VALUES ('1719', '11', '', '', '', '67', null, null);
INSERT INTO `monitor_item` VALUES ('1720', '11', '', '', '', '68', null, null);
INSERT INTO `monitor_item` VALUES ('1721', '11', '', '', '', '69', null, null);
INSERT INTO `monitor_item` VALUES ('1722', '11', '', '', '', '70', null, null);
INSERT INTO `monitor_item` VALUES ('3301', '21', '', '', '', '71', null, null);
INSERT INTO `monitor_item` VALUES ('3302', '21', '', '', '', '72', null, null);
INSERT INTO `monitor_item` VALUES ('3313', '21', '', '', '', '73', 'W/m2', null);
INSERT INTO `monitor_item` VALUES ('3320', '21', '', '', '', '74', '℃', null);
INSERT INTO `monitor_item` VALUES ('3324', '21', '', '', '', '75', '℃', null);
INSERT INTO `monitor_item` VALUES ('3325', '21', '', '', '', '76', '℃', null);
INSERT INTO `monitor_item` VALUES ('3327', '21', '', '', '', '77', '℃', null);
INSERT INTO `monitor_item` VALUES ('3341', '21', '', '', '', '78', 'm/s', null);
INSERT INTO `monitor_item` VALUES ('3345', '21', '', '', '', '79', 'm/s', null);
INSERT INTO `monitor_item` VALUES ('3347', '21', '', '', '', '80', 'W/m2', null);
INSERT INTO `monitor_item` VALUES ('3353', '21', '', '', '', '81', null, null);
INSERT INTO `monitor_item` VALUES ('1801', '12', '', '', '', '82', null, null);
INSERT INTO `monitor_item` VALUES ('1802', '12', '', '', '', '83', '℃', null);
INSERT INTO `monitor_item` VALUES ('1803', '12', '', '', '', '84', 'V', null);
INSERT INTO `monitor_item` VALUES ('1804', '12', '', '', '', '85', null, null);
INSERT INTO `monitor_item` VALUES ('1809', '12', '', '', '', '86', 'A', null);
INSERT INTO `monitor_item` VALUES ('1810', '12', '', '', '', '87', 'A', null);
INSERT INTO `monitor_item` VALUES ('1811', '12', '', '', '', '88', 'A', null);
INSERT INTO `monitor_item` VALUES ('1812', '12', '', '', '', '89', 'A', null);
INSERT INTO `monitor_item` VALUES ('1813', '12', '', '', '', '90', 'A', null);
INSERT INTO `monitor_item` VALUES ('1814', '12', '', '', '', '91', 'A', null);
INSERT INTO `monitor_item` VALUES ('1815', '12', '', '', '', '92', 'A', null);
INSERT INTO `monitor_item` VALUES ('1816', '12', '', '', '', '93', 'A', null);
INSERT INTO `monitor_item` VALUES ('1817', '12', '', '', '', '94', 'A', null);
INSERT INTO `monitor_item` VALUES ('1818', '12', '', '', '', '95', 'A', null);
INSERT INTO `monitor_item` VALUES ('1819', '12', '', '', '', '96', 'A', null);
INSERT INTO `monitor_item` VALUES ('1820', '12', '', '', '', '97', 'A', null);
INSERT INTO `monitor_item` VALUES ('1821', '12', '', '', '', '98', 'A', null);
INSERT INTO `monitor_item` VALUES ('1822', '12', '', '', '', '99', 'A', null);
INSERT INTO `monitor_item` VALUES ('1823', '12', '', '', '', '100', 'A', null);
INSERT INTO `monitor_item` VALUES ('1824', '12', '', '', '', '101', 'A', null);
INSERT INTO `userinfo` VALUES ('215', 'demo', 'k2u67/dEAno=', '阳光电源股份有限公司', '0', 'exampleuser', '合肥天湖路2号', 'Support@sungrowpower.com', '合肥', '中国', '400-880-5578', '¥', '1', '2', 'C', null, '0551-5327870', null, null, null, null, '2012-04-21', '4', '10', '2');
