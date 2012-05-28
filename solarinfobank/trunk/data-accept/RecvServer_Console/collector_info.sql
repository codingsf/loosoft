/*
MySQL Data Transfer
Source Host: localhost
Source Database: temp
Target Host: localhost
Target Database: temp
Date: 2011/7/21 12:52:58
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for collector_info
-- ----------------------------
CREATE TABLE `collector_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) CHARACTER SET utf8 COLLATE utf8_swedish_ci NOT NULL,
  `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_swedish_ci NOT NULL,
  `isUsed` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_code` (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=174 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

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
  KEY `collectorID_index` (`collectorID`)
) ENGINE=MyISAM AUTO_INCREMENT=797 DEFAULT CHARSET=utf8 COLLATE=utf8_swedish_ci;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `collector_info` VALUES ('165', '121212111111117', '123456', '');
INSERT INTO `collector_info` VALUES ('153', '121212111111115', '123456', '');
INSERT INTO `collector_info` VALUES ('169', '911111111111116', '123456', '');
INSERT INTO `collector_info` VALUES ('152', '121212111111114', '123456', '');
INSERT INTO `collector_info` VALUES ('168', '911111111111111', '123456', '');
INSERT INTO `collector_info` VALUES ('149', '121212111111111', '123456', '');
INSERT INTO `collector_info` VALUES ('167', '121212111111118', '123456', '');
INSERT INTO `collector_info` VALUES ('158', '1212100@0111112', '123456', '');
INSERT INTO `collector_info` VALUES ('160', '121212111111119', '123456', '');
INSERT INTO `collector_info` VALUES ('166', '121212111111116', '123456', '');
INSERT INTO `collector_info` VALUES ('162', '211111111111111', '123456', '');
INSERT INTO `collector_info` VALUES ('129', '121212111111112', '123456', '');
INSERT INTO `collector_info` VALUES ('164', '221111111111111', '123456', '');
INSERT INTO `collector_info` VALUES ('170', '911111111111112', '123456', '');
INSERT INTO `collector_info` VALUES ('171', '911111111111113', '123456', '');
INSERT INTO `collector_info` VALUES ('172', '911111111111114', '123456', '');
INSERT INTO `collector_info` VALUES ('173', '911111111111115', '123456', '');
INSERT INTO `device` VALUES ('703', '1', '1', '31', '149', '0', '1.5', '', null);
INSERT INTO `device` VALUES ('704', '1', '2', '31', '149', '0', '1.5', '', null);
INSERT INTO `device` VALUES ('705', '1', '3', '31', '149', '0', '1.5', '', null);
INSERT INTO `device` VALUES ('706', '1', '4', '31', '149', '0', null, '', null);
INSERT INTO `device` VALUES ('707', '1', '5', '31', '149', '0', '1.5', '', null);
INSERT INTO `device` VALUES ('708', '1', '6', '31', '149', '0', '1.5', '', null);
INSERT INTO `device` VALUES ('709', '1', '7', '31', '149', '0', '1.5', '', null);
INSERT INTO `device` VALUES ('710', '1', '8', '31', '149', '0', '1.5', '', null);
INSERT INTO `device` VALUES ('711', '1', '9', '31', '149', '0', '1.5', '', null);
INSERT INTO `device` VALUES ('712', '1', '10', '31', '149', '0', '1.5', '', null);
INSERT INTO `device` VALUES ('713', '1', '3', '40', '129', '0', '15', '', 'SG15KTL#3ddsdsds');
INSERT INTO `device` VALUES ('714', '1', '4', '40', '129', '0', '14', '', null);
INSERT INTO `device` VALUES ('715', '1', '5', '40', '129', '0', '15', '', null);
INSERT INTO `device` VALUES ('716', '1', '6', '40', '129', '0', null, '', null);
INSERT INTO `device` VALUES ('717', '1', '7', '33', '129', '0', '30', '', 'SG3KTL#7dsdsdsdd');
INSERT INTO `device` VALUES ('718', '1', '11', '33', '129', '0', '3', '', null);
INSERT INTO `device` VALUES ('719', '1', '12', '33', '129', '0', '3', '', null);
INSERT INTO `device` VALUES ('720', '1', '13', '33', '129', '0', '3', '', null);
INSERT INTO `device` VALUES ('721', '1', '14', '40', '129', '0', null, '', null);
INSERT INTO `device` VALUES ('722', '1', '15', '40', '129', '0', '15', '', null);
INSERT INTO `device` VALUES ('723', '1', '16', '40', '129', '0', '15', '', null);
INSERT INTO `device` VALUES ('724', '1', '17', '40', '129', '0', '15', '', null);
INSERT INTO `device` VALUES ('725', '5', '237', '0', '149', '0', null, '', null);
INSERT INTO `device` VALUES ('726', '1', '2', '31', '151', '0', null, '', null);
INSERT INTO `device` VALUES ('727', '1', '3', '31', '151', '0', null, '', null);
INSERT INTO `device` VALUES ('728', '5', '237', '0', '151', '0', null, '', null);
INSERT INTO `device` VALUES ('729', '1', '1', '31', '151', '0', null, '', null);
INSERT INTO `device` VALUES ('730', '1', '2', '31', '157', '0', null, '', null);
INSERT INTO `device` VALUES ('731', '1', '3', '31', '157', '0', null, '', null);
INSERT INTO `device` VALUES ('732', '1', '1', '31', '157', '0', null, '', null);
INSERT INTO `device` VALUES ('733', '1', '3', '40', '158', '0', null, '', null);
INSERT INTO `device` VALUES ('734', '1', '4', '40', '158', '0', null, '', null);
INSERT INTO `device` VALUES ('735', '1', '5', '40', '158', '0', null, '', null);
INSERT INTO `device` VALUES ('736', '1', '6', '40', '158', '0', null, '', null);
INSERT INTO `device` VALUES ('737', '1', '14', '40', '158', '0', null, '', null);
INSERT INTO `device` VALUES ('738', '1', '15', '40', '158', '0', null, '', null);
INSERT INTO `device` VALUES ('739', '1', '16', '40', '158', '0', null, '', null);
INSERT INTO `device` VALUES ('740', '1', '17', '40', '158', '0', null, '', null);
INSERT INTO `device` VALUES ('741', '1', '1', '157', '153', '0', null, '', null);
INSERT INTO `device` VALUES ('742', '1', '2', '33', '153', '0', null, '', null);
INSERT INTO `device` VALUES ('743', '1', '3', '35', '153', '0', null, '', null);
INSERT INTO `device` VALUES ('744', '3', '10', '209', '153', '0', null, '', null);
INSERT INTO `device` VALUES ('745', '1', '1', '157', '160', '0', null, '', null);
INSERT INTO `device` VALUES ('746', '1', '2', '33', '160', '0', null, '', null);
INSERT INTO `device` VALUES ('747', '1', '3', '35', '160', '0', null, '', null);
INSERT INTO `device` VALUES ('748', '3', '10', '209', '160', '0', null, '', null);
INSERT INTO `device` VALUES ('749', '5', '255', '0', '162', '0', null, '', 'SunInfo EM#255');
INSERT INTO `device` VALUES ('750', '5', '255', '0', '163', '0', null, '', null);
INSERT INTO `device` VALUES ('751', '1', '2', '10496', '162', '7', null, '', null);
INSERT INTO `device` VALUES ('752', '1', '1', '7936', '162', '7', null, '', null);
INSERT INTO `device` VALUES ('753', '1', '4', '32767', '151', '0', null, '', null);
INSERT INTO `device` VALUES ('754', '1', '5', '32767', '151', '0', null, '', null);
INSERT INTO `device` VALUES ('755', '1', '6', '32767', '151', '0', null, '', null);
INSERT INTO `device` VALUES ('756', '1', '7', '32767', '151', '0', null, '', null);
INSERT INTO `device` VALUES ('757', '1', '8', '32767', '151', '0', null, '', null);
INSERT INTO `device` VALUES ('758', '1', '9', '32767', '151', '0', null, '', null);
INSERT INTO `device` VALUES ('759', '1', '10', '32767', '151', '0', null, '', null);
INSERT INTO `device` VALUES ('760', '1', '11', '32767', '151', '0', null, '', null);
INSERT INTO `device` VALUES ('761', '1', '12', '32767', '151', '0', null, '', null);
INSERT INTO `device` VALUES ('762', '1', '13', '32767', '151', '0', null, '', null);
INSERT INTO `device` VALUES ('763', '1', '14', '32767', '151', '0', null, '', null);
INSERT INTO `device` VALUES ('764', '1', '15', '32767', '151', '0', null, '', null);
INSERT INTO `device` VALUES ('765', '1', '16', '32767', '151', '0', null, '', null);
INSERT INTO `device` VALUES ('766', '1', '17', '32767', '151', '0', null, '', null);
INSERT INTO `device` VALUES ('767', '5', '255', '0', '166', '0', null, '', null);
INSERT INTO `device` VALUES ('768', '1', '1', '145', '166', '0', null, '', null);
INSERT INTO `device` VALUES ('769', '1', '2', '145', '166', '0', null, '', null);
INSERT INTO `device` VALUES ('770', '1', '3', '145', '166', '0', null, '', null);
INSERT INTO `device` VALUES ('771', '1', '4', '145', '166', '0', null, '', null);
INSERT INTO `device` VALUES ('772', '1', '5', '145', '166', '0', null, '', null);
INSERT INTO `device` VALUES ('773', '1', '6', '145', '166', '0', null, '', null);
INSERT INTO `device` VALUES ('774', '1', '7', '145', '166', '0', null, '', null);
INSERT INTO `device` VALUES ('775', '1', '8', '145', '166', '0', null, '', null);
INSERT INTO `device` VALUES ('776', '1', '9', '145', '166', '0', null, '', null);
INSERT INTO `device` VALUES ('777', '1', '10', '0', '166', '0', null, '', null);
INSERT INTO `device` VALUES ('778', '1', '11', '4', '166', '0', null, '', null);
INSERT INTO `device` VALUES ('779', '1', '12', '4', '166', '0', null, '', null);
INSERT INTO `device` VALUES ('780', '1', '13', '4', '166', '0', null, '', null);
INSERT INTO `device` VALUES ('781', '1', '14', '4', '166', '0', null, '', null);
INSERT INTO `device` VALUES ('782', '5', '255', '0', '165', '0', null, '', null);
INSERT INTO `device` VALUES ('783', '1', '1', '145', '165', '0', null, '', null);
INSERT INTO `device` VALUES ('784', '1', '2', '145', '165', '0', null, '', null);
INSERT INTO `device` VALUES ('785', '1', '3', '145', '165', '0', null, '', null);
INSERT INTO `device` VALUES ('786', '1', '4', '145', '165', '0', null, '', null);
INSERT INTO `device` VALUES ('787', '1', '5', '145', '165', '0', null, '', null);
INSERT INTO `device` VALUES ('788', '1', '6', '145', '165', '0', null, '', null);
INSERT INTO `device` VALUES ('789', '1', '7', '145', '165', '0', null, '', null);
INSERT INTO `device` VALUES ('790', '1', '8', '145', '165', '0', null, '', null);
INSERT INTO `device` VALUES ('791', '1', '9', '145', '165', '0', null, '', null);
INSERT INTO `device` VALUES ('792', '1', '10', '0', '165', '0', null, '', null);
INSERT INTO `device` VALUES ('793', '1', '11', '4', '165', '0', null, '', null);
INSERT INTO `device` VALUES ('794', '1', '12', '4', '165', '0', null, '', null);
INSERT INTO `device` VALUES ('795', '1', '13', '4', '165', '0', null, '', null);
INSERT INTO `device` VALUES ('796', '1', '14', '4', '165', '0', null, '', null);
