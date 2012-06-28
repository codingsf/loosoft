/*
Navicat MySQL Data Transfer

Source Server         : 61.190.67.238
Source Server Version : 50051
Source Host           : 61.190.67.238:3306
Source Database       : stuwork_welnew

Target Server Type    : MYSQL
Target Server Version : 50051
File Encoding         : 65001

Date: 2010-08-23 02:57:24
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `student`
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `admissionNo` varchar(30) default NULL,
  `examineeNo` varchar(30) NOT NULL,
  `batchId` int(11) NOT NULL,
  `id` bigint(20) unsigned zerofill NOT NULL auto_increment,
  `name` varchar(20) NOT NULL,
  `IDcard` varchar(20) NOT NULL,
  `sex` char(0) NOT NULL,
  `nation` varchar(20) NOT NULL,
  `telephone` varchar(20) NOT NULL,
  `address` varchar(50) NOT NULL,
  `province` varchar(20) NOT NULL,
  `testaddr` varchar(30) NOT NULL,
  `mark` int(11) NOT NULL,
  `Institutecode` varchar(50) NOT NULL,
  `departmentcode` varchar(50) NOT NULL,
  `professionalcode` varchar(50) NOT NULL,
  `classcode` varchar(10) NOT NULL,
  `gradation` varchar(20) NOT NULL,
  `length` int(11) NOT NULL,
  `order` tinyint(4) default NULL,
  `registerdate` datetime default NULL,
  `state` tinyint(3) unsigned zerofill NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------
