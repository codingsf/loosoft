/*
Navicat MySQL Data Transfer
Source Host     : 192.168.0.133:3306
Source Database : stuwork_archives
Target Host     : 192.168.0.133:3306
Target Database : stuwork_archives
Date: 2010-12-27 16:27:55
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for changelog
-- ----------------------------
DROP TABLE IF EXISTS `changelog`;
CREATE TABLE `changelog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `stuId` varchar(20) DEFAULT NULL,
  `changeDate` datetime DEFAULT NULL,
  `operater` varchar(20) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  `content` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of changelog
-- ----------------------------

-- ----------------------------
-- Table structure for dictionary
-- ----------------------------
DROP TABLE IF EXISTS `dictionary`;
CREATE TABLE `dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(20) DEFAULT NULL,
  `value` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=104 DEFAULT CHARSET=utf8 COMMENT='系统设置表';

-- ----------------------------
-- Records of dictionary
-- ----------------------------
INSERT INTO `dictionary` VALUES ('103', 'rkcl', '高考报名表');
INSERT INTO `dictionary` VALUES ('102', 'ddly', '学籍表');
INSERT INTO `dictionary` VALUES ('101', 'rkcl', '学籍表');
INSERT INTO `dictionary` VALUES ('99', 'ddly', '调档理由1');
INSERT INTO `dictionary` VALUES ('100', 'ddly', '调档理由2');

-- ----------------------------
-- Table structure for lendlog
-- ----------------------------
DROP TABLE IF EXISTS `lendlog`;
CREATE TABLE `lendlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stuId` varchar(32) DEFAULT NULL,
  `operater` varchar(20) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  `organization` varchar(20) DEFAULT NULL,
  `lendDate` date DEFAULT NULL,
  `returnDate` date DEFAULT NULL,
  `fileName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lendlog
-- ----------------------------
INSERT INTO `lendlog` VALUES ('16', '5555', 'ddd', 'dd', 'dcdff', '2010-12-26', '2010-12-25', null);
INSERT INTO `lendlog` VALUES ('15', '456789', 'ffff', 'fff', 'cccc', '2010-12-26', '2010-12-25', null);
INSERT INTO `lendlog` VALUES ('17', '456789', 'ccc ', 'dfff', 'ccc', '2010-12-26', '2010-12-25', null);
INSERT INTO `lendlog` VALUES ('18', '456789', 'wode', 'wode', 'wode', '2010-12-26', '2010-12-25', null);
INSERT INTO `lendlog` VALUES ('20', '456789', 'haode', 'haode', 'haode', '2010-12-26', '2010-12-25', null);
INSERT INTO `lendlog` VALUES ('21', '456789', 'fff3', 'fff', 'fff', '2010-12-29', '2010-12-25', null);
INSERT INTO `lendlog` VALUES ('22', '3333', 'fff', 'fff', 'ddd', '2010-12-26', '2010-12-25', null);
INSERT INTO `lendlog` VALUES ('23', '52', '吴善如', '公司迁移', '合肥智搜', '2010-12-26', '2010-12-17', null);
INSERT INTO `lendlog` VALUES ('30', '4444', 'vv', '发发发', '反反复复', '2010-12-27', '2010-12-09', 'lendlog1293417904000285.java');

-- ----------------------------
-- Table structure for outlog
-- ----------------------------
DROP TABLE IF EXISTS `outlog`;
CREATE TABLE `outlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stuId` varchar(20) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `organization` varchar(50) DEFAULT NULL,
  `outDate` datetime DEFAULT NULL,
  `operater` varchar(20) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL,
  `fileName` varchar(50) DEFAULT NULL,
  `isbn` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `location` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of outlog
-- ----------------------------

-- ----------------------------
-- Table structure for returnlog
-- ----------------------------
DROP TABLE IF EXISTS `returnlog`;
CREATE TABLE `returnlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stuId` varchar(32) DEFAULT NULL,
  `operater` varchar(20) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  `lendNum` varchar(20) DEFAULT NULL,
  `returnDate` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of returnlog
-- ----------------------------
INSERT INTO `returnlog` VALUES ('5', '456789', 'xxxx', 'xxx', null, '2010-12-26');
INSERT INTO `returnlog` VALUES ('6', '456789', 'ccccc', 'cccc', null, '2010-12-26');
INSERT INTO `returnlog` VALUES ('7', '456789', 'nn', 'nn', null, '2010-12-26');
INSERT INTO `returnlog` VALUES ('8', '456789', 'mmm', 'mmm', null, '2010-12-26');
INSERT INTO `returnlog` VALUES ('9', '456789', 'fff3', 'fff3', null, '2010-12-26');
INSERT INTO `returnlog` VALUES ('10', '456789', 'tade', 'tade', null, '2010-12-26');
INSERT INTO `returnlog` VALUES ('11', '456789', 'haode', 'haode', null, '2010-12-26');
INSERT INTO `returnlog` VALUES ('12', '456789', 'aa', 'aa', null, '2010-12-26');
INSERT INTO `returnlog` VALUES ('13', '456789', 'ggg', 'gg', null, '2010-12-26');
INSERT INTO `returnlog` VALUES ('15', '52', '小产', '归档了。', '23', '2010-12-27');
INSERT INTO `returnlog` VALUES ('16', '5555', '发发发', '发发发', '16', '2010-12-27');
INSERT INTO `returnlog` VALUES ('17', '4444', 'fff', 'dfdff', '30', '2010-12-27');
INSERT INTO `returnlog` VALUES ('18', '4444', '发发发', 'vv', '30', '2010-12-27');
INSERT INTO `returnlog` VALUES ('19', '456789', '方法', 'cv', '21', '2010-12-27');

-- ----------------------------
-- Table structure for store
-- ----------------------------
DROP TABLE IF EXISTS `store`;
CREATE TABLE `store` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `area` varchar(50) DEFAULT NULL,
  `rank` varchar(10) DEFAULT NULL,
  `storow` int(11) DEFAULT NULL,
  `stocolumn` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of store
-- ----------------------------
INSERT INTO `store` VALUES ('16', 'A', '3', '2', '1');
INSERT INTO `store` VALUES ('17', 'A', '4', '8', '8');

-- ----------------------------
-- Table structure for stuarchives
-- ----------------------------
DROP TABLE IF EXISTS `stuarchives`;
CREATE TABLE `stuarchives` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stuId` varchar(32) DEFAULT NULL,
  `archivesInfo` varchar(50) DEFAULT NULL,
  `storageTime` datetime DEFAULT NULL,
  `storeInfo` varchar(50) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `operater` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of stuarchives
-- ----------------------------
INSERT INTO `stuarchives` VALUES ('74', '20109004005tz01', '学籍表，体检表，高考报名表，入党材料，评优材料', null, 'A-1-2-3', '在库', null);
INSERT INTO `stuarchives` VALUES ('75', '20109004005tz02', '学籍表，体检表，高考报名表', null, 'A-2-2-3', '在库', null);
INSERT INTO `stuarchives` VALUES ('76', '20109004005tz03', '学籍表，体检表，高考报名表', null, 'A-1-2-3', '在库', null);
INSERT INTO `stuarchives` VALUES ('77', '20109004005tz04', '学籍表，体检表，高考报名表', null, 'A-1-2-3', '在库', null);
INSERT INTO `stuarchives` VALUES ('78', '20109004005tz05', '学籍表，体检表，高考报名表', null, 'A-1-2-3', '在库', null);
INSERT INTO `stuarchives` VALUES ('79', '20109004005tz06', '学籍表，体检表，高考报名表', null, 'A-1-2-3', '在库', null);
INSERT INTO `stuarchives` VALUES ('80', '20109004005tz07', '学籍表，体检表，高考报名表，入党材料，评优材料', null, 'A-1-2-3', '在库', null);
INSERT INTO `stuarchives` VALUES ('81', '20109004005tz08', '学籍表，体检表，高考报名表，入党材料，评优材料', null, 'A-1-2-3', '在库', null);
INSERT INTO `stuarchives` VALUES ('82', '20109004005tz09', '学籍表，体检表，高考报名表，入党材料，评优材料', null, 'A-1-2-3', '在库', null);
INSERT INTO `stuarchives` VALUES ('83', '20109004005tz10', '学籍表，体检表，高考报名表，入党材料，评优材料', null, 'A-1-2-3', '在库', null);
INSERT INTO `stuarchives` VALUES ('84', '20109004005tz11', '学籍表，体检表，高考报名表，入党材料，评优材料', null, 'A-1-2-3', '在库', null);
INSERT INTO `stuarchives` VALUES ('85', '20109004005tz12', '学籍表，体检表，高考报名表，入党材料，评优材料', null, 'A-1-2-3', '在库', null);
INSERT INTO `stuarchives` VALUES ('86', '20109004005tz13', '学籍表，体检表，高考报名表，入党材料，评优材料', null, 'A-1-2-3', '在库', null);
INSERT INTO `stuarchives` VALUES ('87', '20109004005tz14', '学籍表，体检表，高考报名表，入党材料，评优材料', null, 'A-1-2-3', '在库', null);
INSERT INTO `stuarchives` VALUES ('88', '20109004005tz15', '学籍表，体检表，高考报名表，入党材料，评优材料', null, 'A-1-2-3', '在库', null);
INSERT INTO `stuarchives` VALUES ('89', '20109004005tz16', '学籍表，体检表，高考报名表，入党材料，评优材料', null, 'A-1-2-3', '在库', null);
INSERT INTO `stuarchives` VALUES ('90', '20109004005tz17', '学籍表，体检表，高考报名表，入党材料，评优材料', null, 'A-1-2-3', '在库', null);
INSERT INTO `stuarchives` VALUES ('91', '20109004005tz18', '学籍表，体检表，高考报名表，入党材料，评优材料', null, 'A-1-2-3', '在库', null);
INSERT INTO `stuarchives` VALUES ('92', '20109004005tz19', '学籍表，体检表，高考报名表，入党材料，评优材料', null, 'A-1-2-3', '在库', null);
INSERT INTO `stuarchives` VALUES ('93', '20109004005tz20', '学籍表，体检表，高考报名表，入党材料，评优材料', null, 'A-1-2-3', '在库', null);
INSERT INTO `stuarchives` VALUES ('94', '20109004005tz21', '学籍表，体检表，高考报名表，入党材料，评优材料', null, 'A-1-2-3', '在库', null);
INSERT INTO `stuarchives` VALUES ('95', '20109004005tz22', '学籍表，体检表，高考报名表，入党材料，评优材料', null, 'A-1-2-3', '在库', null);
INSERT INTO `stuarchives` VALUES ('96', '20109004005tz23', '学籍表，体检表，高考报名表，入党材料，评优材料', null, 'A-1-2-3', '在库', null);
INSERT INTO `stuarchives` VALUES ('97', '20109004005tz24', '学籍表，体检表，高考报名表，入党材料，评优材料', null, 'A-1-2-3', '在库', null);
INSERT INTO `stuarchives` VALUES ('98', '20109004005tz25', '学籍表，体检表，高考报名表，入党材料，评优材料', null, 'A-1-2-3', '在库', null);
INSERT INTO `stuarchives` VALUES ('99', '20109004005tz26', '学籍表，体检表，高考报名表，入党材料，评优材料', null, 'A-1-2-3', '在库', null);

-- ----------------------------
-- Table structure for welbatch
-- ----------------------------
DROP TABLE IF EXISTS `welbatch`;
CREATE TABLE `welbatch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `year` varchar(20) DEFAULT NULL,
  `season` varchar(50) DEFAULT NULL,
  `startdate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `current` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of welbatch
-- ----------------------------
INSERT INTO `welbatch` VALUES ('1', '2010', '秋季', '2010-11-01 00:00:00', '2010-11-08 00:00:00', '1');
