/*
Navicat MySQL Data Transfer
Source Host     : 192.168.0.133:3306
Source Database : stuwork_stuinfo
Target Host     : 192.168.0.133:3306
Target Database : stuwork_stuinfo
Date: 2010-12-13 10:10:54
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `id` bigint(32) NOT NULL,
  `studentNo` char(32) NOT NULL,
  `name` varchar(10) NOT NULL,
  `sex` varchar(50) NOT NULL,
  `examineeNo` varchar(50) NOT NULL,
  `pinyin` varchar(50) DEFAULT NULL,
  `former` varchar(20) DEFAULT NULL,
  `IDcard` varchar(30) DEFAULT NULL,
  `account` varchar(50) NOT NULL,
  `collegeCode` char(32) DEFAULT NULL,
  `collegeName` varchar(50) DEFAULT NULL,
  `classCode` char(32) NOT NULL,
  `className` varchar(50) DEFAULT NULL,
  `majorCode` varchar(20) NOT NULL,
  `majorName` varchar(20) DEFAULT NULL,
  `roombed` varchar(20) DEFAULT NULL,
  `nation` varchar(20) DEFAULT NULL,
  `birthPlace` varchar(20) DEFAULT NULL,
  `politicsFace` varchar(20) DEFAULT NULL,
  `length` varchar(20) DEFAULT NULL,
  `cultureWay` date DEFAULT NULL,
  `education` varchar(15) DEFAULT NULL,
  `degree` varchar(15) DEFAULT NULL,
  `inDate` date DEFAULT NULL,
  `finishDate` date DEFAULT NULL,
  `hierophant` varchar(15) DEFAULT NULL,
  `phone` varchar(32) DEFAULT NULL,
  `cardNum` varchar(32) DEFAULT NULL,
  `edudirection` varchar(20) DEFAULT NULL,
  `testaddr` varchar(50) DEFAULT NULL,
  `fatherName` varchar(50) DEFAULT NULL,
  `motherName` varchar(200) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `familyCode` varchar(20) DEFAULT NULL,
  `homePhone` varchar(50) DEFAULT NULL,
  `blood` varchar(20) DEFAULT NULL,
  `healthInfo` varchar(50) DEFAULT NULL,
  `marryInfo` varchar(50) DEFAULT NULL,
  `psyInfo` varchar(10) DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  `religion` varchar(20) DEFAULT NULL,
  `bankName` date DEFAULT NULL,
  `bankAccount` varchar(20) DEFAULT NULL,
  `onlineWeb` varchar(20) DEFAULT NULL,
  `email` varchar(20) DEFAULT NULL,
  `specialty` varchar(10) DEFAULT NULL,
  `remarks` varchar(20) DEFAULT NULL,
  `isAutonomy` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------
