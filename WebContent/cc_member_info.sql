/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : mylib

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-03-04 21:26:12
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cc_member_info
-- ----------------------------
DROP TABLE IF EXISTS `cc_member_info`;
CREATE TABLE `cc_member_info` (
  `i_id` int(20) NOT NULL AUTO_INCREMENT,
  `i_uid` int(11) NOT NULL,
  `s_name` varchar(40) NOT NULL COMMENT '真实姓名',
  `i_sex` tinyint(4) NOT NULL DEFAULT '1',
  `s_occupation` varchar(255) NOT NULL DEFAULT '' COMMENT '1医务人员2教师3研发人员4学生5其它（显示文本框自己填）',
  `s_mobile` varchar(50) NOT NULL DEFAULT '',
  `s_address` varchar(100) NOT NULL DEFAULT '' COMMENT '省',
  `s_capacity` varchar(40) DEFAULT NULL,
  `s_education` varchar(20) DEFAULT '2' COMMENT '1专科2本科3硕士4博士5其它 ',
  `s_create_time` varchar(23) NOT NULL,
  `i_deleted` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`i_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=gbk;
