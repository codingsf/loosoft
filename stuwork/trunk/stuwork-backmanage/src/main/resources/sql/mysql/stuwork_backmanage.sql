/*
Navicat MySQL Data Transfer
Source Host     : 192.168.0.133:3306
Source Database : stuwork_backmanage
Target Host     : 192.168.0.133:3306
Target Database : stuwork_backmanage
Date: 2010-12-17 17:40:27
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for acct_authority
-- ----------------------------
DROP TABLE IF EXISTS `acct_authority`;
CREATE TABLE `acct_authority` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of acct_authority
-- ----------------------------
INSERT INTO `acct_authority` VALUES ('21', '军训_军训团成员新增');
INSERT INTO `acct_authority` VALUES ('20', '军训_军训团成员浏览');
INSERT INTO `acct_authority` VALUES ('34', '军训_军训学员导入');
INSERT INTO `acct_authority` VALUES ('33', '军训_军训学员浏览');
INSERT INTO `acct_authority` VALUES ('27', '军训_分班发放登记');
INSERT INTO `acct_authority` VALUES ('19', '军训_分连及学员总览');
INSERT INTO `acct_authority` VALUES ('17', '军训_到场录入');
INSERT INTO `acct_authority` VALUES ('16', '军训_到场统计');
INSERT INTO `acct_authority` VALUES ('6', '军训_奖项设置');
INSERT INTO `acct_authority` VALUES ('13', '军训_学员出勤浏览');
INSERT INTO `acct_authority` VALUES ('11', '军训_学员意见浏览');
INSERT INTO `acct_authority` VALUES ('30', '军训_学员成绩浏览');
INSERT INTO `acct_authority` VALUES ('35', '军训_学员班级导入');
INSERT INTO `acct_authority` VALUES ('7', '军训_学员获奖情况浏览');
INSERT INTO `acct_authority` VALUES ('15', '军训_异常出勤录入');
INSERT INTO `acct_authority` VALUES ('14', '军训_异常出勤浏览');
INSERT INTO `acct_authority` VALUES ('12', '军训_意见录入');
INSERT INTO `acct_authority` VALUES ('9', '军训_批次浏览');
INSERT INTO `acct_authority` VALUES ('28', '军训_教官浏览');
INSERT INTO `acct_authority` VALUES ('10', '军训_新增批次');
INSERT INTO `acct_authority` VALUES ('29', '军训_新增教官');
INSERT INTO `acct_authority` VALUES ('8', '军训_新增获奖');
INSERT INTO `acct_authority` VALUES ('25', '军训_物资发放浏览');
INSERT INTO `acct_authority` VALUES ('26', '军训_现场发放登记');
INSERT INTO `acct_authority` VALUES ('32', '军训_理论课成绩录入');
INSERT INTO `acct_authority` VALUES ('23', '军训_考核项目浏览');
INSERT INTO `acct_authority` VALUES ('24', '军训_考核项目设置');
INSERT INTO `acct_authority` VALUES ('18', '军训_营管理');
INSERT INTO `acct_authority` VALUES ('31', '军训_训练课成绩录入');
INSERT INTO `acct_authority` VALUES ('22', '军训_课程百分比设置');
INSERT INTO `acct_authority` VALUES ('1', '军训系统');
INSERT INTO `acct_authority` VALUES ('4', '后台_学校基础数据设置');
INSERT INTO `acct_authority` VALUES ('5', '后台_用户管理');
INSERT INTO `acct_authority` VALUES ('3', '后台管理');
INSERT INTO `acct_authority` VALUES ('36', '学生综合信息管理系统');
INSERT INTO `acct_authority` VALUES ('37', '档案系统');
INSERT INTO `acct_authority` VALUES ('2', '迎新系统');

-- ----------------------------
-- Table structure for acct_role
-- ----------------------------
DROP TABLE IF EXISTS `acct_role`;
CREATE TABLE `acct_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of acct_role
-- ----------------------------
INSERT INTO `acct_role` VALUES ('5', '军训团成员');
INSERT INTO `acct_role` VALUES ('2', '学生处工作人员');
INSERT INTO `acct_role` VALUES ('1', '超级管理员');
INSERT INTO `acct_role` VALUES ('4', '辅导员');
INSERT INTO `acct_role` VALUES ('3', '院系工作人员');

-- ----------------------------
-- Table structure for acct_role_authority
-- ----------------------------
DROP TABLE IF EXISTS `acct_role_authority`;
CREATE TABLE `acct_role_authority` (
  `role_id` bigint(20) NOT NULL,
  `authority_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of acct_role_authority
-- ----------------------------
INSERT INTO `acct_role_authority` VALUES ('2', '1');
INSERT INTO `acct_role_authority` VALUES ('2', '3');
INSERT INTO `acct_role_authority` VALUES ('2', '2');
INSERT INTO `acct_role_authority` VALUES ('1', '1');
INSERT INTO `acct_role_authority` VALUES ('1', '2');
INSERT INTO `acct_role_authority` VALUES ('1', '3');
INSERT INTO `acct_role_authority` VALUES ('1', '4');
INSERT INTO `acct_role_authority` VALUES ('1', '5');
INSERT INTO `acct_role_authority` VALUES ('1', '21');
INSERT INTO `acct_role_authority` VALUES ('1', '20');
INSERT INTO `acct_role_authority` VALUES ('1', '34');
INSERT INTO `acct_role_authority` VALUES ('1', '33');
INSERT INTO `acct_role_authority` VALUES ('1', '27');
INSERT INTO `acct_role_authority` VALUES ('1', '19');
INSERT INTO `acct_role_authority` VALUES ('1', '17');
INSERT INTO `acct_role_authority` VALUES ('1', '16');
INSERT INTO `acct_role_authority` VALUES ('1', '6');
INSERT INTO `acct_role_authority` VALUES ('1', '13');
INSERT INTO `acct_role_authority` VALUES ('1', '11');
INSERT INTO `acct_role_authority` VALUES ('1', '30');
INSERT INTO `acct_role_authority` VALUES ('1', '35');
INSERT INTO `acct_role_authority` VALUES ('1', '7');
INSERT INTO `acct_role_authority` VALUES ('1', '15');
INSERT INTO `acct_role_authority` VALUES ('1', '14');
INSERT INTO `acct_role_authority` VALUES ('1', '12');
INSERT INTO `acct_role_authority` VALUES ('1', '9');
INSERT INTO `acct_role_authority` VALUES ('1', '28');
INSERT INTO `acct_role_authority` VALUES ('1', '10');
INSERT INTO `acct_role_authority` VALUES ('1', '29');
INSERT INTO `acct_role_authority` VALUES ('1', '8');
INSERT INTO `acct_role_authority` VALUES ('1', '25');
INSERT INTO `acct_role_authority` VALUES ('1', '26');
INSERT INTO `acct_role_authority` VALUES ('1', '32');
INSERT INTO `acct_role_authority` VALUES ('1', '23');
INSERT INTO `acct_role_authority` VALUES ('1', '24');
INSERT INTO `acct_role_authority` VALUES ('1', '18');
INSERT INTO `acct_role_authority` VALUES ('1', '31');
INSERT INTO `acct_role_authority` VALUES ('1', '22');
INSERT INTO `acct_role_authority` VALUES ('3', '1');
INSERT INTO `acct_role_authority` VALUES ('3', '2');
INSERT INTO `acct_role_authority` VALUES ('3', '20');
INSERT INTO `acct_role_authority` VALUES ('3', '33');
INSERT INTO `acct_role_authority` VALUES ('3', '19');
INSERT INTO `acct_role_authority` VALUES ('3', '13');
INSERT INTO `acct_role_authority` VALUES ('3', '11');
INSERT INTO `acct_role_authority` VALUES ('3', '30');
INSERT INTO `acct_role_authority` VALUES ('3', '7');
INSERT INTO `acct_role_authority` VALUES ('3', '14');
INSERT INTO `acct_role_authority` VALUES ('3', '12');
INSERT INTO `acct_role_authority` VALUES ('3', '9');
INSERT INTO `acct_role_authority` VALUES ('3', '25');
INSERT INTO `acct_role_authority` VALUES ('3', '23');
INSERT INTO `acct_role_authority` VALUES ('5', '21');
INSERT INTO `acct_role_authority` VALUES ('5', '20');
INSERT INTO `acct_role_authority` VALUES ('5', '33');
INSERT INTO `acct_role_authority` VALUES ('5', '19');
INSERT INTO `acct_role_authority` VALUES ('5', '17');
INSERT INTO `acct_role_authority` VALUES ('5', '16');
INSERT INTO `acct_role_authority` VALUES ('5', '13');
INSERT INTO `acct_role_authority` VALUES ('5', '11');
INSERT INTO `acct_role_authority` VALUES ('5', '30');
INSERT INTO `acct_role_authority` VALUES ('5', '7');
INSERT INTO `acct_role_authority` VALUES ('5', '15');
INSERT INTO `acct_role_authority` VALUES ('5', '14');
INSERT INTO `acct_role_authority` VALUES ('5', '9');
INSERT INTO `acct_role_authority` VALUES ('5', '28');
INSERT INTO `acct_role_authority` VALUES ('5', '29');
INSERT INTO `acct_role_authority` VALUES ('5', '25');
INSERT INTO `acct_role_authority` VALUES ('5', '31');
INSERT INTO `acct_role_authority` VALUES ('5', '1');
INSERT INTO `acct_role_authority` VALUES ('1', '36');
INSERT INTO `acct_role_authority` VALUES ('1', '37');

-- ----------------------------
-- Table structure for acct_user
-- ----------------------------
DROP TABLE IF EXISTS `acct_user`;
CREATE TABLE `acct_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `loginName` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `departmentID` int(11) DEFAULT NULL,
  `instituteID` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login_name` (`loginName`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of acct_user
-- ----------------------------
INSERT INTO `acct_user` VALUES ('1', 'admin@admin.com', 'admin', '超户', 'admin', '2010-09-02 09:43:16', null, null);
INSERT INTO `acct_user` VALUES ('6', 'admin@admin.com', 'genggh', '耿广汉', '111111', '2010-09-02 09:43:19', null, '17');
INSERT INTO `acct_user` VALUES ('7', 'admin@admin.com', 'kaijm', '开金苗', '111111', '2010-09-02 09:43:24', null, '23');
INSERT INTO `acct_user` VALUES ('8', 'admin@admin.com', 'zhangf', '张帆', '111111', '2010-09-02 09:43:31', null, '18');
INSERT INTO `acct_user` VALUES ('9', 'admin@admin.com', 'huwj', '胡文靖', '111111', '2010-09-02 09:43:34', null, '15');
INSERT INTO `acct_user` VALUES ('10', 'admin@admin.com', 'caoh', '曹浩', '111111', '2010-09-02 09:43:38', null, '21');
INSERT INTO `acct_user` VALUES ('11', 'admin@admin.com', 'zhanghl', '张海亮', '111111', '2010-09-02 09:43:42', null, '22');
INSERT INTO `acct_user` VALUES ('12', 'admin@admin.com', 'shensz', '沈树周', '111111', '2010-09-02 09:43:45', null, '25');
INSERT INTO `acct_user` VALUES ('13', 'admin@admin.com', 'xuef', '薛枫', '111111', '2010-09-02 09:43:48', null, '19');
INSERT INTO `acct_user` VALUES ('14', 'admin@admin.com', 'zhengyl', '郑玉莲', '111111', '2010-09-02 09:43:54', null, '20');
INSERT INTO `acct_user` VALUES ('15', 'admin@admin.com', 'lisn', '李沙娜', '111111', '2010-09-02 09:43:57', null, '24');
INSERT INTO `acct_user` VALUES ('16', '', 'shaozb', '邵峥波', '111111', '2010-09-06 11:14:01', null, null);

-- ----------------------------
-- Table structure for acct_user_role
-- ----------------------------
DROP TABLE IF EXISTS `acct_user_role`;
CREATE TABLE `acct_user_role` (
  `userID` bigint(20) NOT NULL,
  `roleID` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of acct_user_role
-- ----------------------------
INSERT INTO `acct_user_role` VALUES ('1', '1');
INSERT INTO `acct_user_role` VALUES ('6', '3');
INSERT INTO `acct_user_role` VALUES ('7', '3');
INSERT INTO `acct_user_role` VALUES ('8', '3');
INSERT INTO `acct_user_role` VALUES ('9', '3');
INSERT INTO `acct_user_role` VALUES ('10', '3');
INSERT INTO `acct_user_role` VALUES ('11', '3');
INSERT INTO `acct_user_role` VALUES ('12', '3');
INSERT INTO `acct_user_role` VALUES ('13', '3');
INSERT INTO `acct_user_role` VALUES ('14', '3');
INSERT INTO `acct_user_role` VALUES ('15', '3');
INSERT INTO `acct_user_role` VALUES ('16', '2');
INSERT INTO `acct_user_role` VALUES ('16', '5');

-- ----------------------------
-- Table structure for bm_class
-- ----------------------------
DROP TABLE IF EXISTS `bm_class`;
CREATE TABLE `bm_class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(30) NOT NULL,
  `name` varchar(20) NOT NULL,
  `year` varchar(6) NOT NULL,
  `season` varchar(4) NOT NULL,
  `leader` varchar(10) DEFAULT NULL,
  `leader_telnum` varchar(30) DEFAULT NULL,
  `room` varchar(30) DEFAULT NULL,
  `specialtyID` int(15) NOT NULL,
  `type` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`,`code`),
  UNIQUE KEY `code` (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=369 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bm_class
-- ----------------------------
INSERT INTO `bm_class` VALUES ('0', '20109004005tz01', '工商管理类103', '2010', '秋季', null, null, null, '31', 'tz');
INSERT INTO `bm_class` VALUES ('261', '20109004005tz02', '工商管理类104', '2010', '秋季', null, null, null, '31', 'tz');
INSERT INTO `bm_class` VALUES ('262', '20109004005tz03', '工商管理类105', '2010', '秋季', null, null, null, '31', 'tz');
INSERT INTO `bm_class` VALUES ('263', '20109004009tz01', '财务会计教育2010级预科1班', '2010', '秋季', null, null, null, '35', 'tz');
INSERT INTO `bm_class` VALUES ('0', '20109004009tz02', '会计101', '2010', '秋季', null, null, null, '35', 'tz');
INSERT INTO `bm_class` VALUES ('265', '20109004002tz01', '国贸101', '2010', '秋季', null, null, null, '28', 'tz');
INSERT INTO `bm_class` VALUES ('266', '20109004002tz02', '国贸102', '2010', '秋季', null, null, null, '28', 'tz');
INSERT INTO `bm_class` VALUES ('267', '20109004002tz03', '国贸103', '2010', '秋季', null, null, null, '28', 'tz');
INSERT INTO `bm_class` VALUES ('268', '20109004005tz04', '工商管理类101', '2010', '秋季', null, null, null, '31', 'tz');
INSERT INTO `bm_class` VALUES ('269', '20109004005tz05', '工商管理类102', '2010', '秋季', null, null, null, '31', 'tz');
INSERT INTO `bm_class` VALUES ('270', '20109004001tz01', '经济学101', '2010', '秋季', null, null, null, '27', 'tz');
INSERT INTO `bm_class` VALUES ('271', '20109004001tz02', '经济学102', '2010', '秋季', null, null, null, '27', 'tz');
INSERT INTO `bm_class` VALUES ('272', '20109008003tz01', '烹饪与营养101', '2010', '秋季', null, null, null, '55', 'tz');
INSERT INTO `bm_class` VALUES ('273', '20109008003tz02', '烹饪与营养102', '2010', '秋季', null, null, null, '55', 'tz');
INSERT INTO `bm_class` VALUES ('274', '20109008002tz01', '食品质量与安全101', '2010', '秋季', null, null, null, '54', 'tz');
INSERT INTO `bm_class` VALUES ('275', '20109008002tz02', '食品质量与安全102', '2010', '秋季', null, null, null, '54', 'tz');
INSERT INTO `bm_class` VALUES ('276', '20109008001tz01', '食品101', '2010', '秋季', null, null, null, '53', 'tz');
INSERT INTO `bm_class` VALUES ('277', '20109008001tz02', '食品102', '2010', '秋季', null, null, null, '53', 'tz');
INSERT INTO `bm_class` VALUES ('278', '20109008005tz01', '药物制剂101', '2010', '秋季', null, null, null, '57', 'tz');
INSERT INTO `bm_class` VALUES ('279', '20109008005tz02', '药物制剂102', '2010', '秋季', null, null, null, '57', 'tz');
INSERT INTO `bm_class` VALUES ('280', '20109008004tz01', '中药101', '2010', '秋季', null, null, null, '56', 'tz');
INSERT INTO `bm_class` VALUES ('281', '20109008004tz02', '中药102', '2010', '秋季', null, null, null, '56', 'tz');
INSERT INTO `bm_class` VALUES ('282', '20109005005tz01', '车辆工程101', '2010', '秋季', null, null, null, '40', 'tz');
INSERT INTO `bm_class` VALUES ('283', '20109005005tz02', '车辆工程102', '2010', '秋季', null, null, null, '40', 'tz');
INSERT INTO `bm_class` VALUES ('284', '20109005005tz03', '车辆工程103', '2010', '秋季', null, null, null, '40', 'tz');
INSERT INTO `bm_class` VALUES ('285', '20109005005tz04', '车辆工程104', '2010', '秋季', null, null, null, '40', 'tz');
INSERT INTO `bm_class` VALUES ('286', '20109005006tz01', '电气101', '2010', '秋季', null, null, null, '41', 'tz');
INSERT INTO `bm_class` VALUES ('287', '20109005006tz02', '电气102', '2010', '秋季', null, null, null, '41', 'tz');
INSERT INTO `bm_class` VALUES ('288', '20109005006tz03', '电气103', '2010', '秋季', null, null, null, '41', 'tz');
INSERT INTO `bm_class` VALUES ('289', '20109005006tz04', '电气104', '2010', '秋季', null, null, null, '41', 'tz');
INSERT INTO `bm_class` VALUES ('290', '20109005004tz01', '电信101', '2010', '秋季', null, null, null, '39', 'tz');
INSERT INTO `bm_class` VALUES ('291', '20109005004tz02', '电信102', '2010', '秋季', null, null, null, '39', 'tz');
INSERT INTO `bm_class` VALUES ('292', '20109005004tz03', '电信103', '2010', '秋季', null, null, null, '39', 'tz');
INSERT INTO `bm_class` VALUES ('293', '20109005001tz01', '机电101', '2010', '秋季', null, null, null, '36', 'tz');
INSERT INTO `bm_class` VALUES ('294', '20109005001tz02', '机电102', '2010', '秋季', null, null, null, '36', 'tz');
INSERT INTO `bm_class` VALUES ('295', '20109005003tz01', '机械电子101', '2010', '秋季', null, null, null, '38', 'tz');
INSERT INTO `bm_class` VALUES ('296', '20109005003tz02', '机械电子102', '2010', '秋季', null, null, null, '38', 'tz');
INSERT INTO `bm_class` VALUES ('297', '20109005003tz03', '机械电子103', '2010', '秋季', null, null, null, '38', 'tz');
INSERT INTO `bm_class` VALUES ('298', '20109005002tz01', '自动化101', '2010', '秋季', null, null, null, '37', 'tz');
INSERT INTO `bm_class` VALUES ('299', '20109005002tz02', '自动化102', '2010', '秋季', null, null, null, '37', 'tz');
INSERT INTO `bm_class` VALUES ('300', '20109005002tz03', '自动化103', '2010', '秋季', null, null, null, '37', 'tz');
INSERT INTO `bm_class` VALUES ('301', '20109007001tz01', '英语101', '2010', '秋季', null, null, null, '51', 'tz');
INSERT INTO `bm_class` VALUES ('302', '20109007001tz02', '英语102', '2010', '秋季', null, null, null, '51', 'tz');
INSERT INTO `bm_class` VALUES ('303', '20109007001tz03', '英语103', '2010', '秋季', null, null, null, '51', 'tz');
INSERT INTO `bm_class` VALUES ('304', '20109007001tz04', '英语104', '2010', '秋季', null, null, null, '51', 'tz');
INSERT INTO `bm_class` VALUES ('305', '20109010001tz01', '城规101', '2010', '秋季', null, null, null, '61', 'tz');
INSERT INTO `bm_class` VALUES ('306', '20109010001tz02', '城规102', '2010', '秋季', null, null, null, '61', 'tz');
INSERT INTO `bm_class` VALUES ('307', '20109010002tz01', '园林101', '2010', '秋季', null, null, null, '62', 'tz');
INSERT INTO `bm_class` VALUES ('308', '20109010002tz02', '园林102', '2010', '秋季', null, null, null, '62', 'tz');
INSERT INTO `bm_class` VALUES ('309', '20109010006tz01', '电信101', '2010', '秋季', null, null, null, '66', 'tz');
INSERT INTO `bm_class` VALUES ('310', '20109010006tz02', '地信102', '2010', '秋季', null, null, null, '66', 'tz');
INSERT INTO `bm_class` VALUES ('311', '20109010005tz01', '环境科学101', '2010', '秋季', null, null, null, '65', 'tz');
INSERT INTO `bm_class` VALUES ('312', '20109010005tz02', '环境科学102', '2010', '秋季', null, null, null, '65', 'tz');
INSERT INTO `bm_class` VALUES ('313', '20109010003tz01', '环境工程101', '2010', '秋季', null, null, null, '63', 'tz');
INSERT INTO `bm_class` VALUES ('314', '20109010003tz02', '环境工程102', '2010', '秋季', null, null, null, '63', 'tz');
INSERT INTO `bm_class` VALUES ('315', '20109010004tz01', '资源101', '2010', '秋季', null, null, null, '64', 'tz');
INSERT INTO `bm_class` VALUES ('316', '20109010004tz02', '资源102', '2010', '秋季', null, null, null, '64', 'tz');
INSERT INTO `bm_class` VALUES ('317', '20109003001tz01', '生物科学大类101', '2010', '秋季', null, null, null, '21', 'tz');
INSERT INTO `bm_class` VALUES ('318', '20109003001tz02', '生物科学大类102', '2010', '秋季', null, null, null, '21', 'tz');
INSERT INTO `bm_class` VALUES ('319', '20109003001tz03', '生物科学大类103', '2010', '秋季', null, null, null, '21', 'tz');
INSERT INTO `bm_class` VALUES ('320', '20109003005tz01', '园艺101', '2010', '秋季', null, null, null, '25', 'tz');
INSERT INTO `bm_class` VALUES ('321', '20109003005tz02', '园艺102', '2010', '秋季', null, null, null, '25', 'tz');
INSERT INTO `bm_class` VALUES ('322', '20109003004tz01', '设施农业101', '2010', '秋季', null, null, null, '24', 'tz');
INSERT INTO `bm_class` VALUES ('323', '20109003004tz02', '设施农业102', '2010', '秋季', null, null, null, '24', 'tz');
INSERT INTO `bm_class` VALUES ('324', '20109003003tz01', '生物工程101', '2010', '秋季', null, null, null, '23', 'tz');
INSERT INTO `bm_class` VALUES ('325', '20109003003tz02', '生物工程102', '2010', '秋季', null, null, null, '23', 'tz');
INSERT INTO `bm_class` VALUES ('326', '20109009002tz01', '法学101', '2010', '秋季', null, null, null, '59', 'tz');
INSERT INTO `bm_class` VALUES ('327', '20109009002tz02', '法学102', '2010', '秋季', null, null, null, '59', 'tz');
INSERT INTO `bm_class` VALUES ('328', '20109009001tz01', '管理101', '2010', '秋季', null, null, null, '58', 'tz');
INSERT INTO `bm_class` VALUES ('329', '20109009001tz02', '管理102', '2010', '秋季', null, null, null, '58', 'tz');
INSERT INTO `bm_class` VALUES ('330', '20109009003tz01', '汉语言文学2010级预科4班', '2010', '秋季', null, null, null, '60', 'tz');
INSERT INTO `bm_class` VALUES ('331', '20109009003tz02', '中文101', '2010', '秋季', null, null, null, '60', 'tz');
INSERT INTO `bm_class` VALUES ('332', '20109001003tz01', '动物生物技术101', '2010', '秋季', null, null, null, '67', 'tz');
INSERT INTO `bm_class` VALUES ('333', '20109001003tz02', '动物生物技术102', '2010', '秋季', null, null, null, '67', 'tz');
INSERT INTO `bm_class` VALUES ('334', '20109001002tz01', '动物医学101', '2010', '秋季', null, null, null, '16', 'tz');
INSERT INTO `bm_class` VALUES ('335', '20109001002tz02', '动物医学102', '2010', '秋季', null, null, null, '16', 'tz');
INSERT INTO `bm_class` VALUES ('336', '20109001002tz03', '动物医学103', '2010', '秋季', null, null, null, '16', 'tz');
INSERT INTO `bm_class` VALUES ('337', '20109001001tz01', '动物科学101', '2010', '秋季', null, null, null, '15', 'tz');
INSERT INTO `bm_class` VALUES ('338', '20109001001tz02', '动物科学102', '2010', '秋季', null, null, null, '15', 'tz');
INSERT INTO `bm_class` VALUES ('339', '20109001001tz03', '动物科学103', '2010', '秋季', null, null, null, '15', 'tz');
INSERT INTO `bm_class` VALUES ('340', '20109001001tz04', '动物科学2010级预科2班', '2010', '秋季', null, null, null, '15', 'tz');
INSERT INTO `bm_class` VALUES ('341', '20109001002tz04', '动物医学2010级预科3班', '2010', '秋季', null, null, null, '16', 'tz');
INSERT INTO `bm_class` VALUES ('342', '20109006006tz01', '材料工程101', '2010', '秋季', null, null, null, '50', 'tz');
INSERT INTO `bm_class` VALUES ('343', '20109006006tz02', '材料工程102', '2010', '秋季', null, null, null, '50', 'tz');
INSERT INTO `bm_class` VALUES ('344', '20109006002tz01', '电子科学101', '2010', '秋季', null, null, null, '46', 'tz');
INSERT INTO `bm_class` VALUES ('345', '20109006002tz02', '电子科学102', '2010', '秋季', null, null, null, '46', 'tz');
INSERT INTO `bm_class` VALUES ('346', '20109006002tz03', '电子科学103', '2010', '秋季', null, null, null, '46', 'tz');
INSERT INTO `bm_class` VALUES ('347', '20109006001tz01', '计算机101', '2010', '秋季', null, null, null, '45', 'tz');
INSERT INTO `bm_class` VALUES ('348', '20109006001tz02', '计算机102', '2010', '秋季', null, null, null, '45', 'tz');
INSERT INTO `bm_class` VALUES ('349', '20109006004tz01', '网络工程101', '2010', '秋季', null, null, null, '48', 'tz');
INSERT INTO `bm_class` VALUES ('350', '20109006004tz02', '网络工程102', '2010', '秋季', null, null, null, '48', 'tz');
INSERT INTO `bm_class` VALUES ('351', '20109006004tz03', '网络工程103', '2010', '秋季', null, null, null, '48', 'tz');
INSERT INTO `bm_class` VALUES ('352', '20109006005tz01', '信息101', '2010', '秋季', null, null, null, '49', 'tz');
INSERT INTO `bm_class` VALUES ('353', '20109006005tz02', '信息102', '2010', '秋季', null, null, null, '49', 'tz');
INSERT INTO `bm_class` VALUES ('354', '20109006003tz01', '应用化学101', '2010', '秋季', null, null, null, '47', 'tz');
INSERT INTO `bm_class` VALUES ('355', '20109006003tz02', '应用化学102', '2010', '秋季', null, null, null, '47', 'tz');
INSERT INTO `bm_class` VALUES ('356', '20109002003tz01', '植物保护101', '2010', '秋季', null, null, null, '19', 'tz');
INSERT INTO `bm_class` VALUES ('357', '20109002003tz02', '植物保护102', '2010', '秋季', null, null, null, '19', 'tz');
INSERT INTO `bm_class` VALUES ('358', '20109002002tz01', '种子101', '2010', '秋季', null, null, null, '18', 'tz');
INSERT INTO `bm_class` VALUES ('359', '20109002002tz02', '种子102', '2010', '秋季', null, null, null, '18', 'tz');
INSERT INTO `bm_class` VALUES ('360', '20109002001tz01', '农学101', '2010', '秋季', null, null, null, '17', 'tz');
INSERT INTO `bm_class` VALUES ('361', '20109002001tz02', '农学102', '2010', '秋季', null, null, null, '17', 'tz');
INSERT INTO `bm_class` VALUES ('362', '20109005001tz03', '机电技术教育预科', '2010', '秋季', null, null, null, '36', 'tz');
INSERT INTO `bm_class` VALUES ('0', '20109002004tz01', '农艺教育预科', '2010', '秋季', null, null, null, '20', 'tz');
INSERT INTO `bm_class` VALUES ('364', '201002010001tz01', '20108城市规划1班', '2010', '秋季', null, null, null, '61', 'tz');
INSERT INTO `bm_class` VALUES ('365', '201002010001tz02', '电子商务5班', '2010', '秋季', null, null, null, '61', 'tz');
INSERT INTO `bm_class` VALUES ('366', '201002006004tz01', '2010网络工程1班', '2010', '秋季', null, null, null, '48', 'tz');
INSERT INTO `bm_class` VALUES ('367', '201002006004tz02', '2010网络工程2班', '2010', '秋季', null, null, null, '48', 'tz');
INSERT INTO `bm_class` VALUES ('368', '201002006004dx01', '2010网络工程1班', '2010', '秋季', null, null, null, '48', 'dx');

-- ----------------------------
-- Table structure for bm_department
-- ----------------------------
DROP TABLE IF EXISTS `bm_department`;
CREATE TABLE `bm_department` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键\r\n',
  `code` varchar(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `leader` varchar(20) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `institute` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ndexi_code` (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bm_department
-- ----------------------------
INSERT INTO `bm_department` VALUES ('13', '001001', '动物医学系', '宁康健', '动物科学实验楼', '1');
INSERT INTO `bm_department` VALUES ('14', '001002', '动物科学系', '蔡治华', '动物科学实验楼', '1');
INSERT INTO `bm_department` VALUES ('15', '004001', '财务会计系', '刘文秀', '西区办公楼', '1');
INSERT INTO `bm_department` VALUES ('16', '004002', '工商管理系', '汤洁', '西区办公楼 ', '1');
INSERT INTO `bm_department` VALUES ('17', '005001', '机电工程系', '王芳', '东区办公楼', '1');
INSERT INTO `bm_department` VALUES ('18', '005002', '机械车辆工程系', '毕丽丽', '东区办公楼 ', '1');
INSERT INTO `bm_department` VALUES ('19', '008001', '食品系', '于凌云', '东区办公楼 ', '1');
INSERT INTO `bm_department` VALUES ('20', '008002', '药学系', '张群', '东区办公楼 ', '1');
INSERT INTO `bm_department` VALUES ('21', '009001', '法学系', '赵文清', '东区办公楼 ', '1');
INSERT INTO `bm_department` VALUES ('22', '009002', '文学系', '周莉', '东区办公楼 ', '1');
INSERT INTO `bm_department` VALUES ('23', '010001', '资环系', '胡新春', '东区办公楼 ', '1');
INSERT INTO `bm_department` VALUES ('24', '010002', '城规系', '刘运亮', '东区办公楼 ', '1');

-- ----------------------------
-- Table structure for bm_fdyuser_class
-- ----------------------------
DROP TABLE IF EXISTS `bm_fdyuser_class`;
CREATE TABLE `bm_fdyuser_class` (
  `fdyUserID` int(11) NOT NULL,
  `classID` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bm_fdyuser_class
-- ----------------------------

-- ----------------------------
-- Table structure for bm_institute
-- ----------------------------
DROP TABLE IF EXISTS `bm_institute`;
CREATE TABLE `bm_institute` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键\r\n',
  `code` varchar(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `leader` varchar(20) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ndexi_code` (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bm_institute
-- ----------------------------
INSERT INTO `bm_institute` VALUES ('15', '001', '动物科学学院', '王立克', '动物科学学院办公楼');
INSERT INTO `bm_institute` VALUES ('17', '002', '植物科学学院', '张子学', '植物科学学院办公大楼');
INSERT INTO `bm_institute` VALUES ('18', '003', '生命科学学院', '金光明', '生命科学学院办公大楼');
INSERT INTO `bm_institute` VALUES ('19', '004', '经济管理学院', '鲍步云', '经济管理学院办公大楼');
INSERT INTO `bm_institute` VALUES ('20', '005', '工学院', '院长', '工学院办公大楼');
INSERT INTO `bm_institute` VALUES ('21', '006', '理学院', '许万祥', '理学院办公大楼');
INSERT INTO `bm_institute` VALUES ('22', '007', '外国语学院', '刘东楼', '外国语学院办公大楼');
INSERT INTO `bm_institute` VALUES ('23', '008', '食品药品学院', '李先保', '食品药品学院办公大楼');
INSERT INTO `bm_institute` VALUES ('24', '009', '文法学院', '吴贵春', '文法学院办公大楼');
INSERT INTO `bm_institute` VALUES ('25', '010', '城建与环境学院', '汪建飞', '城建与环境学院办公大楼');

-- ----------------------------
-- Table structure for bm_schoolarea
-- ----------------------------
DROP TABLE IF EXISTS `bm_schoolarea`;
CREATE TABLE `bm_schoolarea` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键\r\n',
  `code` varchar(10) NOT NULL,
  `name` varchar(30) NOT NULL,
  `address` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ndexi_code` (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bm_schoolarea
-- ----------------------------
INSERT INTO `bm_schoolarea` VALUES ('8', '002', '蚌埠坦克学院教学点', '安徽省蚌埠市陶山路');
INSERT INTO `bm_schoolarea` VALUES ('5', '001', '本校区', '安徽省滁州市凤阳县东华路9号');

-- ----------------------------
-- Table structure for bm_specialty
-- ----------------------------
DROP TABLE IF EXISTS `bm_specialty`;
CREATE TABLE `bm_specialty` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键\r\n',
  `code` varchar(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `departmentID` int(20) DEFAULT NULL,
  `instituteID` int(11) DEFAULT NULL,
  `current` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ndexi_code` (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bm_specialty
-- ----------------------------
INSERT INTO `bm_specialty` VALUES ('15', '001001', '动物科学', '14', '15', '\0');
INSERT INTO `bm_specialty` VALUES ('16', '001002', '动物医学', '13', '15', '\0');
INSERT INTO `bm_specialty` VALUES ('17', '002001', '农学', '13', '17', '\0');
INSERT INTO `bm_specialty` VALUES ('18', '002002', '种子科学与工程', '23', '17', '\0');
INSERT INTO `bm_specialty` VALUES ('19', '002003', '植物保护', '14', '17', '\0');
INSERT INTO `bm_specialty` VALUES ('20', '002004', '农艺教育', null, '17', '\0');
INSERT INTO `bm_specialty` VALUES ('21', '003001', '生物科学大类', null, '18', '\0');
INSERT INTO `bm_specialty` VALUES ('22', '003002', '生物科学专业', null, '18', '\0');
INSERT INTO `bm_specialty` VALUES ('23', '003003', '生物工程', null, '18', '\0');
INSERT INTO `bm_specialty` VALUES ('24', '003004', '设施农业科学与工程', null, '18', '\0');
INSERT INTO `bm_specialty` VALUES ('25', '003005', '园艺', null, '18', '\0');
INSERT INTO `bm_specialty` VALUES ('27', '004001', '经济学', '16', '19', '\0');
INSERT INTO `bm_specialty` VALUES ('28', '004002', '国际经济与贸易', '16', '19', '\0');
INSERT INTO `bm_specialty` VALUES ('29', '004003', '农村区域发展专业', '16', '19', '\0');
INSERT INTO `bm_specialty` VALUES ('30', '004004', '物流管理专业', '16', '19', '\0');
INSERT INTO `bm_specialty` VALUES ('31', '004005', '工商管理类', '16', '19', '\0');
INSERT INTO `bm_specialty` VALUES ('32', '004006', '市场营销专业', '16', '19', '\0');
INSERT INTO `bm_specialty` VALUES ('33', '004007', '市场营销教育专业', '16', '19', '\0');
INSERT INTO `bm_specialty` VALUES ('34', '004008', '财务管理专业', '15', '19', '\0');
INSERT INTO `bm_specialty` VALUES ('35', '004009', '财务会计教育', '15', '19', '\0');
INSERT INTO `bm_specialty` VALUES ('36', '005001', '机电技术教育', '17', '20', '\0');
INSERT INTO `bm_specialty` VALUES ('37', '005002', '机械设计制造及其自动化', '18', '20', '\0');
INSERT INTO `bm_specialty` VALUES ('38', '005003', '机械电子工程', '17', '20', '\0');
INSERT INTO `bm_specialty` VALUES ('39', '005004', '电子信息工程', '17', '20', '\0');
INSERT INTO `bm_specialty` VALUES ('40', '005005', '车辆工程', '18', '20', '\0');
INSERT INTO `bm_specialty` VALUES ('41', '005006', '电气工程及其自动化', '17', '20', '\0');
INSERT INTO `bm_specialty` VALUES ('42', '005007', '机电一体化', '17', '20', '\0');
INSERT INTO `bm_specialty` VALUES ('43', '005008', '数控技术与应用', '17', '20', '\0');
INSERT INTO `bm_specialty` VALUES ('44', '005009', '汽车检测与维修', '18', '20', '\0');
INSERT INTO `bm_specialty` VALUES ('45', '006001', '计算机科学与技术', null, '21', '\0');
INSERT INTO `bm_specialty` VALUES ('46', '006002', '电子科学与技术', null, '21', '\0');
INSERT INTO `bm_specialty` VALUES ('47', '006003', '应用化学', null, '21', '\0');
INSERT INTO `bm_specialty` VALUES ('48', '006004', '网络工程', null, '21', '\0');
INSERT INTO `bm_specialty` VALUES ('49', '006005', '信息与计算科学', null, '21', '\0');
INSERT INTO `bm_specialty` VALUES ('50', '006006', '无机非金属材料工程', null, '21', '\0');
INSERT INTO `bm_specialty` VALUES ('51', '007001', '英语', null, '22', '\0');
INSERT INTO `bm_specialty` VALUES ('52', '007002', '英语教育', null, '22', '\0');
INSERT INTO `bm_specialty` VALUES ('53', '008001', '食品科学与工程', '19', '23', '\0');
INSERT INTO `bm_specialty` VALUES ('54', '008002', '食品质量与安全', '19', '23', '\0');
INSERT INTO `bm_specialty` VALUES ('55', '008003', '烹饪与营养教育', '19', '23', '\0');
INSERT INTO `bm_specialty` VALUES ('56', '008004', '中药学', '20', '23', '\0');
INSERT INTO `bm_specialty` VALUES ('57', '008005', '药物制剂', '20', '23', '\0');
INSERT INTO `bm_specialty` VALUES ('58', '009001', '公共事业管理', null, '24', '\0');
INSERT INTO `bm_specialty` VALUES ('59', '009002', '法学', '21', '24', '\0');
INSERT INTO `bm_specialty` VALUES ('60', '009003', '汉语言文学', '22', '24', '\0');
INSERT INTO `bm_specialty` VALUES ('61', '010001', '城市规划', '24', '25', '\0');
INSERT INTO `bm_specialty` VALUES ('62', '010002', '园林', '24', '25', '\0');
INSERT INTO `bm_specialty` VALUES ('63', '010003', '环境工程', '23', '25', '\0');
INSERT INTO `bm_specialty` VALUES ('64', '010004', '农业资源与环境', '23', '25', '\0');
INSERT INTO `bm_specialty` VALUES ('65', '010005', '环境科学', '23', '25', '\0');
INSERT INTO `bm_specialty` VALUES ('66', '010006', '地理信息系统', null, '25', '\0');
INSERT INTO `bm_specialty` VALUES ('67', '001003', '动物生物技术', null, '15', '\0');
