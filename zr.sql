/*
Navicat MySQL Data Transfer

Source Server         : 本机
Source Server Version : 50562
Source Host           : 127.0.0.1:3306
Source Database       : zr

Target Server Type    : MYSQL
Target Server Version : 50562
File Encoding         : 65001

Date: 2022-07-03 15:53:36
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for car_car
-- ----------------------------
DROP TABLE IF EXISTS `car_car`;
CREATE TABLE `car_car` (
  `id` bigint(40) NOT NULL AUTO_INCREMENT COMMENT '车辆编码 自增主键',
  `name` varchar(40) NOT NULL COMMENT '车辆名称',
  `brand` varchar(20) DEFAULT NULL COMMENT '品牌',
  `model` varchar(20) DEFAULT NULL COMMENT '型号',
  `box` decimal(6,0) DEFAULT NULL COMMENT '厢数',
  `volume` decimal(9,2) DEFAULT NULL COMMENT '排量',
  `door` decimal(2,0) DEFAULT NULL COMMENT '门数',
  `seat` decimal(2,0) DEFAULT NULL COMMENT '座位数',
  `gears` decimal(2,0) DEFAULT NULL COMMENT '档位数',
  `auto` varchar(4) DEFAULT NULL COMMENT '自动 手动 一体',
  `price` decimal(6,0) DEFAULT NULL COMMENT '价格 元/天',
  `agreement_id` int(11) DEFAULT NULL,
  `status` varchar(4) DEFAULT NULL COMMENT '状态：正常 下架',
  `create_id` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `modify_id` varchar(20) DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  `img_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of car_car
-- ----------------------------
INSERT INTO `car_car` VALUES ('1', '奥迪A4L', '奥迪', 'A4L', '3', '2.00', '4', '5', '8', '自动', '450', null, '正常', 'admin', '2020-08-31 11:44:07', 'admin', '2021-10-10 15:15:29', 'f28d11dd-3c73-4be3-9c30-cc4b0d8eb715.jpg');
INSERT INTO `car_car` VALUES ('2', '奥迪A6L', '奥迪', 'A6L', '3', '2.00', '5', '5', '7', '一体', '600', null, '正常', 'admin', '2021-10-06 15:33:20', 'admin', '2021-10-10 15:12:04', 'fc17c7a4-c31f-4207-a01c-fbf710c7324b.jpg');
INSERT INTO `car_car` VALUES ('3', '奥迪Q5L', '奥迪', 'Q5L', '2', '2.00', '5', '5', '8', '一体', '500', null, '正常', 'admin', '2021-10-07 21:11:21', 'admin', '2021-10-10 15:12:21', 'a51adbf0-37fa-4a16-8f1f-c5c5be0e3fa3.jpg');
INSERT INTO `car_car` VALUES ('4', '奥迪e-tron', '奥迪', 'e-tron', '3', '2.00', '5', '5', '7', '一体', '600', null, '正常', 'admin', '2021-10-08 09:14:58', 'admin', '2021-10-10 10:17:36', '7699fb66-84e8-483d-8c02-7b8b0a63056d.jpg');
INSERT INTO `car_car` VALUES ('5', '奥迪Q3L', '奥迪', 'Q3L', '3', '1.80', '5', '5', '8', '自动', '300', null, '正常', 'admin', '2021-10-08 21:03:39', 'admin', '2021-10-10 10:18:04', '371154f5-271b-4ebd-95c3-00acf3842774.jpg');
INSERT INTO `car_car` VALUES ('6', '奥迪Q7', '奥迪', 'Q7', '3', '2.00', '4', '5', '8', '一体', '800', null, '正常', 'admin', '2021-10-09 17:29:36', 'admin', '2021-10-10 15:12:53', '8cdaa8cb-879e-4d92-b83c-b8711205bacd.jpg');
INSERT INTO `car_car` VALUES ('7', '奥迪Q8L', '奥迪', 'Q8L', '2', '3.00', '5', '5', '8', '一体', '1000', null, '正常', 'admin', '2021-10-10 10:18:51', 'admin', '2021-10-10 15:13:20', '0b29ec71-10b4-4f90-8708-f64b96910274.jpg');
INSERT INTO `car_car` VALUES ('8', '奥迪Q2L', '奥迪', 'Q2L', '2', '1.50', '5', '5', '7', '自动', '200', null, '下架', 'admin', '2021-10-10 10:55:05', 'admin', '2021-10-10 19:22:41', '30f3d668-a18b-4a20-9ca6-780c72693f95.jpg');
INSERT INTO `car_car` VALUES ('10', '奥迪R8', '奥迪', 'R8', '3', '3.00', '2', '2', '7', '一体', '1500', null, '正常', 'admin', '2021-10-10 19:19:30', null, null, null);

-- ----------------------------
-- Table structure for car_work
-- ----------------------------
DROP TABLE IF EXISTS `car_work`;
CREATE TABLE `car_work` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '派遣单编号 ：自增主键',
  `order_id` bigint(20) DEFAULT NULL COMMENT '订单id',
  `car_no` varchar(20) DEFAULT NULL COMMENT '车牌号码',
  `out_time` datetime DEFAULT NULL COMMENT '出车时间',
  `in_time` datetime DEFAULT NULL COMMENT '回车时间',
  `out_user_id` varchar(20) DEFAULT NULL COMMENT '出车操作人',
  `in_user_id` varchar(20) DEFAULT NULL COMMENT '回车操作人',
  `out_fit_time` datetime DEFAULT NULL COMMENT '车辆整备日期',
  `out_fit_user_id` varchar(20) DEFAULT NULL COMMENT '车辆整备人',
  `status` varchar(10) DEFAULT NULL COMMENT '状态：已准备/已整备/已出车/已回车',
  `total` decimal(10,2) DEFAULT NULL COMMENT '退款(付数)/补款(正数) 金额',
  `mark` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`) USING BTREE,
  KEY `out_user_id` (`out_user_id`) USING BTREE,
  KEY `in_user_id` (`in_user_id`) USING BTREE,
  KEY `out_fit_user_id` (`out_fit_user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of car_work
-- ----------------------------
INSERT INTO `car_work` VALUES ('1', '1', '吉b12345', '2021-10-09 19:41:28', '2021-10-10 15:21:20', 'admin', 'admin', '2021-10-10 15:21:25', 'admin', '已整备', '450.00', '补一天差价');
INSERT INTO `car_work` VALUES ('2', '2', '吉a-288kl', '2020-09-21 16:10:23', '2020-09-21 16:11:03', 'admin', 'admin', '2020-09-21 16:11:38', 'admin', '已整备', '0.00', null);
INSERT INTO `car_work` VALUES ('3', '3', '吉a-kj2000', '2020-09-24 17:18:38', '2020-09-24 17:19:02', 'admin', 'admin', '2020-09-24 17:26:34', 'admin', '已整备', '0.00', null);
INSERT INTO `car_work` VALUES ('4', '4', '吉A2021', '2021-10-10 15:22:58', '2021-10-10 15:24:04', 'admin', 'admin', '2021-10-10 15:25:06', 'admin', '已整备', null, null);
INSERT INTO `car_work` VALUES ('5', '5', '吉a-66f8', '2020-09-23 19:46:59', '2020-09-23 19:48:09', 'admin', 'admin', '2020-09-24 17:16:31', 'admin', '已整备', '-2000.00', null);
INSERT INTO `car_work` VALUES ('6', '6', '吉a1234', '2020-12-08 14:26:08', '2020-12-08 14:27:18', 'admin', 'admin', '2020-12-08 14:27:29', 'admin', '已整备', '0.00', null);
INSERT INTO `car_work` VALUES ('7', '7', '京a.x88a8', '2020-12-09 09:20:56', '2020-12-09 09:21:53', 'admin', 'admin', '2020-12-09 09:23:15', 'admin', '已整备', '9000.00', null);
INSERT INTO `car_work` VALUES ('8', '8', '京A88a8', '2020-12-09 09:20:56', '2021-10-08 16:21:58', 'admin', 'admin', '2021-10-08 16:32:20', 'admin', '已整备', '150.00', '剐蹭赔偿');
INSERT INTO `car_work` VALUES ('9', '9', '吉B A2345', '2021-10-10 20:56:21', '2021-10-10 20:57:15', 'admin', 'admin', '2021-10-10 20:57:26', 'admin', '已整备', '230.50', '补差价');
INSERT INTO `car_work` VALUES ('10', '10', '皖A0001', '2021-10-10 15:23:32', null, 'admin', null, null, null, '已出车', null, null);
INSERT INTO `car_work` VALUES ('11', '11', null, null, null, null, null, null, null, '已准备', null, null);
INSERT INTO `car_work` VALUES ('12', '12', null, null, null, null, null, null, null, '已准备', null, null);
INSERT INTO `car_work` VALUES ('13', '13', null, null, null, null, null, null, null, '已准备', null, null);
INSERT INTO `car_work` VALUES ('14', '14', null, null, null, null, null, null, null, '已准备', null, null);
INSERT INTO `car_work` VALUES ('15', '15', null, null, null, null, null, null, null, '已准备', null, null);
INSERT INTO `car_work` VALUES ('16', '16', null, null, null, null, null, null, null, '已准备', null, null);

-- ----------------------------
-- Table structure for lease_agreement
-- ----------------------------
DROP TABLE IF EXISTS `lease_agreement`;
CREATE TABLE `lease_agreement` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '合同编码：自动递增',
  `name` varchar(40) DEFAULT NULL COMMENT '合同名称',
  `text` text COMMENT '合同文本',
  `status` varchar(4) DEFAULT NULL COMMENT '合同状态：有效 作废',
  `create_id` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `modify_id` varchar(20) DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='InnoDB free: 29696 kB';

-- ----------------------------
-- Records of lease_agreement
-- ----------------------------
INSERT INTO `lease_agreement` VALUES ('1', '奥迪租车通用合同', '服务规则\n>待租车况：\n1.车辆定期保养检修及安全检查，无重大事故及安全隐患；\n2.车身外观、内饰、性能:\n(1）车身整洁，内饰干净、无破损；\n（2）轮胎完好，无鼓包，胎面无明显偏磨;\n（3）备胎、灭火器、故障警示牌、随车工具等齐全完好；\n（4）行驶本、保单复印件、交强险标、年检标志等齐全并有效放置、粘贴；\n（5）车辆性能（灯光、仪表、空调、玻璃、水、电瓶等）正常；\n（6）房车内各项随车设备均性能完好、无故障。\n>租车资格：\n1.两证一卡\n（1）本人有效身份证件。\n        a.境内客户：二代身份证\n        b.港澳客户：港澳居民来往内地通行证（回乡证）（租车期间有效）\n        c.台湾客户：大陆通行证（台胞证）（租车期间有效）\n        d.外籍客户：护照，签证/居住证（租车期间有效）\n（2）本人国内有效驾驶证，满足c1及3年以上驾龄，且机动车驾驶证有效期至少超过本次租期的一个月以上。在一个记分周期内，交通违法记分不得超过6分以上（含6分）及其他尚未处理违法犯罪记录。\n（3）有效信用卡。\n2.须租车人携带“两证一卡”亲自到取车门店办理租车手续。\n3.提供租车人有效联系方式。\n（1）行驶本、保单复印件、交强险标、年检标志等齐全并有效放置、粘贴；\n4.数量限制：每次限租一辆房车，即在您归还所租房车之前，不能再租用我司其它房车，也不能为其他人担保租车。\n5.房车内各项随车设备均性能完好、无故障。', '有效', 'admin', '2020-09-11 08:29:12', 'admin', '2021-10-10 16:13:33');
INSERT INTO `lease_agreement` VALUES ('3', '奥迪三厢车租赁合同', '服务规则\n>待租车况：\n1.车辆定期保养检修及安全检查，无重大事故及安全隐患；\n2.车身外观、内饰、性能:\n(1）车身整洁，内饰干净、无破损；\n（2）轮胎完好，无鼓包，胎面无明显偏磨;\n（3）备胎、灭火器、故障警示牌、随车工具等齐全完好；\n（4）行驶本、保单复印件、交强险标、年检标志等齐全并有效放置、粘贴；\n（5）车辆性能（灯光、仪表、空调、玻璃、水、电瓶等）正常；\n（6）房车内各项随车设备均性能完好、无故障。\n>租车资格：\n1.两证一卡\n（1）本人有效身份证件。\n        a.境内客户：二代身份证\n        b.港澳客户：港澳居民来往内地通行证（回乡证）（租车期间有效）\n        c.台湾客户：大陆通行证（台胞证）（租车期间有效）\n        d.外籍客户：护照，签证/居住证（租车期间有效）\n（2）本人国内有效驾驶证，满足c1及3年以上驾龄，且机动车驾驶证有效期至少超过本次租期的一个月以上。在一个记分周期内，交通违法记分不得超过6分以上（含6分）及其他尚未处理违法犯罪记录。\n（3）有效信用卡。\n2.须租车人携带“两证一卡”亲自到取车门店办理租车手续。\n3.提供租车人有效联系方式。\n（1）行驶本、保单复印件、交强险标、年检标志等齐全并有效放置、粘贴；\n4.数量限制：每次限租一辆房车，即在您归还所租房车之前，不能再租用我司其它房车，也不能为其他人担保租车。\n5.房车内各项随车设备均性能完好、无故障。', '有效', 'admin', '2020-09-11 08:29:12', 'admin', '2021-10-10 16:12:35');

-- ----------------------------
-- Table structure for lease_customer
-- ----------------------------
DROP TABLE IF EXISTS `lease_customer`;
CREATE TABLE `lease_customer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `customer_id` varchar(50) NOT NULL DEFAULT '' COMMENT '客户账号：手机号码',
  `password` varchar(32) DEFAULT NULL COMMENT '客户密码',
  `code` varchar(6) DEFAULT NULL COMMENT '手机验证码',
  `name` varchar(10) DEFAULT NULL COMMENT '客户名称',
  `idcard` varchar(18) DEFAULT NULL COMMENT '身份证号码',
  `contact` varchar(20) DEFAULT NULL COMMENT '紧急联系人名称',
  `ctel` varchar(20) DEFAULT NULL COMMENT '紧急联系人电话',
  `status` varchar(4) DEFAULT NULL COMMENT '账号状态：正常 冻结',
  `create_id` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `modify_id` varchar(20) DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_id` (`customer_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='InnoDB free: 29696 kB';

-- ----------------------------
-- Records of lease_customer
-- ----------------------------
INSERT INTO `lease_customer` VALUES ('1', '13478395393', '81dc9bdb52d04dc20036dbd8313ed055', '1594', '江南风', '102947199910138093', '江强国1', '17709893065', '正常', 'jxt', '2021-10-09 21:45:10', 'admin', '2021-10-10 21:04:07');
INSERT INTO `lease_customer` VALUES ('2', '18880497195', '81dc9bdb52d04dc20036dbd8313ed055', '1364', '王和均', '230103198902051204', '王德化', '13669790303', '正常', 'wcf', '2021-10-09 21:46:06', null, null);
INSERT INTO `lease_customer` VALUES ('3', '13216437378', '81dc9bdb52d04dc20036dbd8313ed055', '1263', '郭克莱', '320103199012138371', '郭东兴', '13216431932', '正常', 'admin', '2021-10-09 21:47:51', null, null);
INSERT INTO `lease_customer` VALUES ('4', '13910957285', '81dc9bdb52d04dc20036dbd8313ed055', '3453', '周天保', '420109197808022328', '周德华', '18810920811', '正常', 'admin', '2021-10-09 21:48:58', null, null);
INSERT INTO `lease_customer` VALUES ('6', '18888888888', '81dc9bdb52d04dc20036dbd8313ed055', '1234', '吴晓峰', '220501199009102345', '吴晓波', null, '正常', 'admin', '2021-10-10 15:33:05', null, null);
INSERT INTO `lease_customer` VALUES ('8', '18890903456', '81dc9bdb52d04dc20036dbd8313ed055', '1346', '张凤', '234356457576567444', '张宝', '13456546789', '正常', 'admin', '2021-10-10 20:25:18', null, null);

-- ----------------------------
-- Table structure for lease_order
-- ----------------------------
DROP TABLE IF EXISTS `lease_order`;
CREATE TABLE `lease_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单ID:自动递增',
  `customer_id` varchar(20) DEFAULT NULL COMMENT '客户id',
  `car_id` bigint(20) DEFAULT NULL COMMENT '车辆id',
  `from_shop_id` bigint(20) DEFAULT NULL COMMENT '取车门店id',
  `from_time` datetime DEFAULT NULL COMMENT '取车时间',
  `to_shop_id` bigint(20) DEFAULT NULL COMMENT '还车门店id',
  `to_time` datetime DEFAULT NULL COMMENT '还车时间',
  `agreement_id` varchar(50) DEFAULT NULL COMMENT '合同id',
  `nomp` varchar(2) DEFAULT NULL COMMENT '不计免赔险 是/否',
  `psur` varchar(2) DEFAULT NULL COMMENT '车上人员责任险 是/否',
  `total` decimal(10,2) DEFAULT NULL COMMENT '合计支付金额',
  `status` varchar(10) DEFAULT NULL COMMENT '未支付/已支付/已取车/已还车',
  `type` varchar(10) DEFAULT NULL COMMENT '支付方式：支付宝/微信',
  `card_id` varchar(40) DEFAULT NULL COMMENT '支付账号',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `order_time` datetime DEFAULT NULL COMMENT '下单时间',
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`) USING BTREE,
  KEY `car_id` (`car_id`) USING BTREE,
  KEY `from_shop_id` (`from_shop_id`) USING BTREE,
  KEY `to_shop_id` (`to_shop_id`) USING BTREE,
  KEY `agreement_id` (`agreement_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='InnoDB free: 29696 kB';

-- ----------------------------
-- Records of lease_order
-- ----------------------------
INSERT INTO `lease_order` VALUES ('1', '13478395393', '1', '1', '2020-09-17 06:05:00', '1', '2020-09-24 10:50:00', '1', '是', '是', '3200.00', '已还车', '微信', 'test', '2020-09-16 15:38:09', '2020-09-16 15:38:09');
INSERT INTO `lease_order` VALUES ('2', '18880497195', '1', '2', '2020-09-09 10:00:00', '2', '2020-09-18 17:00:00', '1', '是', '是', '3500.00', '已还车', '微信', 'test', '2020-09-21 08:37:08', '2020-09-21 08:37:08');
INSERT INTO `lease_order` VALUES ('3', '13216437378', '2', '1', '2020-09-23 10:00:00', '1', '2020-09-30 14:00:00', '1', '是', '是', '2100.00', '已还车', '微信', 'test', '2020-09-22 20:34:33', '2020-09-22 20:34:33');
INSERT INTO `lease_order` VALUES ('4', '13910957285', '1', '2', '2020-10-23 10:00:00', '2', '2020-10-30 18:00:00', '1', '是', '否', '2650.00', '已还车', '微信', 'test', '2020-09-23 10:49:12', '2020-09-23 10:49:12');
INSERT INTO `lease_order` VALUES ('5', '13910957285', '1', '3', '2020-09-24 10:00:00', '2', '2020-10-08 14:00:00', '1', '是', '是', '5000.00', '已还车', '微信', 'test', '2020-09-23 19:38:03', '2020-09-23 19:38:03');
INSERT INTO `lease_order` VALUES ('6', '18888888888', '2', '1', '2020-11-23 10:30:00', '1', '2020-11-27 10:50:00', '1', '是', '是', '1500.00', '已还车', '微信', 'test', '2020-11-23 15:32:16', '2020-11-23 15:32:16');
INSERT INTO `lease_order` VALUES ('7', '18844501940', '2', '1', '2020-11-23 10:30:00', '1', '2020-11-27 10:50:00', '1', '是', '是', '1500.00', '已还车', '微信', 'test', '2020-11-23 15:32:35', '2020-11-23 15:32:35');
INSERT INTO `lease_order` VALUES ('8', '13478395393', '1', '1', '2021-10-06 13:40:18', '1', '2021-10-08 13:40:29', '1', '是', '是', '100.00', '已还车', '微信', 'test', '2021-10-13 13:41:26', '2021-09-28 17:33:39');
INSERT INTO `lease_order` VALUES ('9', '18880497195', '1', '1', '2021-10-06 13:40:23', '1', '2021-10-08 13:40:34', '1', '是', '是', '1100.00', '已还车', '微信', 'test', '2021-10-20 13:41:29', '2021-09-28 18:24:06');
INSERT INTO `lease_order` VALUES ('10', '13216437378', '3', '4', '2021-10-09 20:19:49', '2', '2021-10-14 00:10:00', '1', '是', '否', '2750.00', '已取车', '微信', 'test', '2021-10-09 20:21:53', '2021-10-09 20:21:53');
INSERT INTO `lease_order` VALUES ('11', '13216437378', '1', '4', '2021-10-09 20:19:49', '2', '2021-10-14 00:10:00', '1', '否', '否', '1750.00', '已支付', '微信', 'test', '2021-10-10 08:35:05', '2021-10-10 08:35:05');
INSERT INTO `lease_order` VALUES ('12', '13478395393', '1', '1', '2021-10-21 00:00:00', '1', '2021-10-21 00:00:00', '1', '是', '是', '0.00', '已支付', '微信', 'test', '2021-10-10 16:46:17', '2021-10-10 16:46:17');
INSERT INTO `lease_order` VALUES ('13', '18888888888', '3', '2', '2021-10-10 16:53:21', '2', '2021-10-12 00:00:00', '1', '是', '是', '1200.00', '已支付', '微信', 'test', '2021-10-10 16:54:18', '2021-10-10 16:54:18');
INSERT INTO `lease_order` VALUES ('14', '18844501940', '4', '4', '2021-10-11 00:00:00', '2', '2021-10-14 11:10:00', '1', '是', '是', '2800.00', '已支付', '微信', 'test', '2021-10-10 17:00:28', '2021-10-10 17:00:28');
INSERT INTO `lease_order` VALUES ('15', '18890903456', '1', '1', '2021-10-10 19:08:31', '1', '2021-10-12 00:00:00', '1', '是', '是', '1100.00', '已支付', '微信', 'test', '2021-10-10 19:08:52', '2021-10-10 19:08:52');
INSERT INTO `lease_order` VALUES ('16', '18880497195', '2', '1', '2021-10-10 21:10:35', '1', '2021-10-17 00:00:00', '1', '是', '否', '4450.00', '已支付', '微信', 'test', '2021-10-10 21:11:43', '2021-10-10 21:11:43');

-- ----------------------------
-- Table structure for shop_city
-- ----------------------------
DROP TABLE IF EXISTS `shop_city`;
CREATE TABLE `shop_city` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '城市编码：自动递增',
  `province_id` bigint(11) DEFAULT NULL COMMENT '省份id',
  `name` varchar(20) DEFAULT NULL COMMENT '城市名称',
  `create_id` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `modify_id` varchar(20) DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop_city
-- ----------------------------
INSERT INTO `shop_city` VALUES ('1', '1', '北京市', 'admin', '2020-07-24 23:15:35', null, null);
INSERT INTO `shop_city` VALUES ('2', '14', '长春市', 'admin', '2020-07-24 23:12:35', null, null);
INSERT INTO `shop_city` VALUES ('3', '2', '合肥市', null, '2021-10-08 18:59:46', 'admin', '2021-10-09 19:34:19');
INSERT INTO `shop_city` VALUES ('4', '17', '沈阳市', 'admin', '2021-10-09 19:33:20', null, null);
INSERT INTO `shop_city` VALUES ('6', '3', '厦门市', 'admin', '2021-10-10 14:39:02', 'admin', '2021-10-10 14:39:19');

-- ----------------------------
-- Table structure for shop_province
-- ----------------------------
DROP TABLE IF EXISTS `shop_province`;
CREATE TABLE `shop_province` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '省份编码：自动递增',
  `name` varchar(20) DEFAULT NULL COMMENT '省份名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop_province
-- ----------------------------
INSERT INTO `shop_province` VALUES ('1', '北京');
INSERT INTO `shop_province` VALUES ('2', '安徽');
INSERT INTO `shop_province` VALUES ('3', '福建');
INSERT INTO `shop_province` VALUES ('4', '甘肃');
INSERT INTO `shop_province` VALUES ('5', '广东');
INSERT INTO `shop_province` VALUES ('6', '广西');
INSERT INTO `shop_province` VALUES ('7', '贵州');
INSERT INTO `shop_province` VALUES ('8', '海南');
INSERT INTO `shop_province` VALUES ('9', '河北');
INSERT INTO `shop_province` VALUES ('10', '河南');
INSERT INTO `shop_province` VALUES ('11', '黑龙江');
INSERT INTO `shop_province` VALUES ('12', '湖北');
INSERT INTO `shop_province` VALUES ('13', '湖南');
INSERT INTO `shop_province` VALUES ('14', '吉林');
INSERT INTO `shop_province` VALUES ('15', '江苏');
INSERT INTO `shop_province` VALUES ('16', '江西');
INSERT INTO `shop_province` VALUES ('17', '辽宁');
INSERT INTO `shop_province` VALUES ('18', '内蒙古');
INSERT INTO `shop_province` VALUES ('19', '宁夏');
INSERT INTO `shop_province` VALUES ('20', '青海');
INSERT INTO `shop_province` VALUES ('21', '山东');
INSERT INTO `shop_province` VALUES ('22', '山西');
INSERT INTO `shop_province` VALUES ('23', '陕西');
INSERT INTO `shop_province` VALUES ('24', '上海');
INSERT INTO `shop_province` VALUES ('25', '四川');
INSERT INTO `shop_province` VALUES ('26', '天津');
INSERT INTO `shop_province` VALUES ('27', '西藏');
INSERT INTO `shop_province` VALUES ('28', '新疆');
INSERT INTO `shop_province` VALUES ('29', '云南');
INSERT INTO `shop_province` VALUES ('30', '浙江');
INSERT INTO `shop_province` VALUES ('31', '重庆');
INSERT INTO `shop_province` VALUES ('32', '香港');
INSERT INTO `shop_province` VALUES ('33', '澳门');
INSERT INTO `shop_province` VALUES ('34', '台湾');

-- ----------------------------
-- Table structure for shop_shop
-- ----------------------------
DROP TABLE IF EXISTS `shop_shop`;
CREATE TABLE `shop_shop` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT COMMENT '门店编码：自动递增',
  `name` varchar(40) DEFAULT NULL COMMENT '门店名称',
  `city_id` bigint(20) DEFAULT NULL COMMENT '所在城市id',
  `address` varchar(100) DEFAULT NULL COMMENT '门店地址',
  `tel` varchar(20) DEFAULT NULL COMMENT '门店电话',
  `admin` varchar(20) DEFAULT NULL COMMENT '门店负责人',
  `status` varchar(4) DEFAULT NULL COMMENT '门店状态：在营/关闭',
  `create_id` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `modify_id` varchar(20) DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `city_id` (`city_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop_shop
-- ----------------------------
INSERT INTO `shop_shop` VALUES ('1', '东直门店', '1', '东直门666号', '010-7758991', '李富贵', '在营', 'admin', '2020-07-26 00:00:00', null, null);
INSERT INTO `shop_shop` VALUES ('2', '迅驰广场店', '2', '长春市迅驰广场888号', '0431-8857991', '杨春旭', '在营', 'admin', '2020-07-26 14:15:09', null, null);
INSERT INTO `shop_shop` VALUES ('3', '临江门店', '1', '北京大街111号', '0432-1100258', '张磊', '在营', 'admin', '2020-07-26 12:10:00', 'admin', '2021-10-10 14:48:08');
INSERT INTO `shop_shop` VALUES ('4', '合肥第一店', '3', '延乔路1号', '1998882345', '陈延年', '在营', 'admin', '2021-10-09 19:36:30', null, null);

-- ----------------------------
-- Table structure for sys_auth
-- ----------------------------
DROP TABLE IF EXISTS `sys_auth`;
CREATE TABLE `sys_auth` (
  `id` bigint(6) NOT NULL AUTO_INCREMENT COMMENT '权限id:自增',
  `name` varchar(20) DEFAULT NULL COMMENT '权限名称',
  `url` varchar(100) DEFAULT NULL COMMENT '权限地址',
  `seq` decimal(2,0) DEFAULT NULL COMMENT '排序',
  `mark` varchar(40) DEFAULT NULL COMMENT '权限说明',
  `pid` bigint(6) DEFAULT NULL COMMENT '上级权限id',
  `create_id` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `modify_id` varchar(20) DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`) USING BTREE,
  CONSTRAINT `sys_auth_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `sys_auth` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_auth
-- ----------------------------
INSERT INTO `sys_auth` VALUES ('1', '系统设置', null, '1', '菜单', null, 'admin', '2020-07-08 09:59:41', null, null);
INSERT INTO `sys_auth` VALUES ('2', '用户设置', 'SysUser', '1', '菜单/权限', '1', 'admin', '2020-07-09 01:59:41', null, null);
INSERT INTO `sys_auth` VALUES ('3', '角色设置', 'SysRole', '2', '菜单/权限', '1', 'admin', '2020-07-08 09:59:41', null, null);
INSERT INTO `sys_auth` VALUES ('4', '权限设置', 'SysAuth', '3', '菜单/权限', '1', 'admin', '2020-07-08 09:59:41', null, null);
INSERT INTO `sys_auth` VALUES ('5', '车辆管理', null, '3', '菜单', null, 'admin', '2020-07-08 09:59:41', null, null);
INSERT INTO `sys_auth` VALUES ('7', '车辆管理', 'CarCar', '1', '菜单/权限', '5', 'admin', '2020-07-08 17:59:41', null, null);
INSERT INTO `sys_auth` VALUES ('9', '车辆派遣', 'CarWork', '2', '菜单/权限', '5', 'admin', '2020-07-08 17:59:41', null, null);
INSERT INTO `sys_auth` VALUES ('14', '租赁管理', null, '4', '菜单', null, 'admin', '2020-07-08 09:59:41', null, null);
INSERT INTO `sys_auth` VALUES ('15', '客户管理', 'LeaseCustomer', '2', '菜单/权限', '14', 'admin', '2020-07-08 17:59:41', null, null);
INSERT INTO `sys_auth` VALUES ('16', '合同管理', 'LeaseAgreement', '3', '菜单/权限', '14', 'admin', '2020-07-08 17:59:41', null, null);
INSERT INTO `sys_auth` VALUES ('17', '订单管理', 'LeaseOrder', '1', '菜单/权限', '14', 'admin', '2020-07-08 17:59:41', null, null);
INSERT INTO `sys_auth` VALUES ('18', '门店管理', null, '2', '菜单', null, 'admin', '2020-07-08 09:59:41', null, null);
INSERT INTO `sys_auth` VALUES ('19', '城市管理', 'ShopCity', '1', '菜单/权限', '18', 'admin', '2020-07-08 17:59:41', null, null);
INSERT INTO `sys_auth` VALUES ('20', '门店管理', 'ShopShop', '2', '菜单/权限', '18', 'admin', '2020-07-08 17:59:41', null, null);
INSERT INTO `sys_auth` VALUES ('21', '报表管理', null, '5', '菜单', null, 'admin', '2020-07-08 09:59:41', null, null);
INSERT INTO `sys_auth` VALUES ('22', '车型统计', 'ReportCar', '1', '菜单/权限', '21', 'admin', '2020-07-08 17:59:41', null, null);
INSERT INTO `sys_auth` VALUES ('23', '财务统计', 'ReportMoney', '2', '菜单/权限', '21', 'admin', '2020-07-08 17:59:41', null, null);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色编码:自增',
  `name` varchar(40) DEFAULT NULL COMMENT '角色名称',
  `mark` varchar(40) DEFAULT NULL COMMENT '角色描述',
  `create_id` varchar(20) DEFAULT NULL COMMENT '创建人id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_id` varchar(20) DEFAULT NULL COMMENT '修改人id',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '超级账号', '管理员', 'admin', '2020-07-14 22:04:42', 'admin', '2022-05-18 11:02:31');
INSERT INTO `sys_role` VALUES ('2', '普通员工', '普通', 'admin', '2020-07-14 22:04:42', 'admin', '2022-05-18 11:02:58');
INSERT INTO `sys_role` VALUES ('5', '项目经理', '经理', 'admin', '2022-05-19 03:02:14', 'admin', '2022-05-19 16:42:59');

-- ----------------------------
-- Table structure for sys_roleauth
-- ----------------------------
DROP TABLE IF EXISTS `sys_roleauth`;
CREATE TABLE `sys_roleauth` (
  `role_id` bigint(6) NOT NULL COMMENT '角色id',
  `auth_id` bigint(6) NOT NULL COMMENT '权限id',
  KEY `role_id` (`role_id`) USING BTREE,
  KEY `auth_id` (`auth_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_roleauth
-- ----------------------------
INSERT INTO `sys_roleauth` VALUES ('1', '1');
INSERT INTO `sys_roleauth` VALUES ('1', '2');
INSERT INTO `sys_roleauth` VALUES ('1', '3');
INSERT INTO `sys_roleauth` VALUES ('1', '4');
INSERT INTO `sys_roleauth` VALUES ('1', '5');
INSERT INTO `sys_roleauth` VALUES ('1', '7');
INSERT INTO `sys_roleauth` VALUES ('1', '9');
INSERT INTO `sys_roleauth` VALUES ('1', '14');
INSERT INTO `sys_roleauth` VALUES ('1', '15');
INSERT INTO `sys_roleauth` VALUES ('1', '16');
INSERT INTO `sys_roleauth` VALUES ('1', '17');
INSERT INTO `sys_roleauth` VALUES ('1', '18');
INSERT INTO `sys_roleauth` VALUES ('1', '19');
INSERT INTO `sys_roleauth` VALUES ('1', '20');
INSERT INTO `sys_roleauth` VALUES ('1', '21');
INSERT INTO `sys_roleauth` VALUES ('1', '22');
INSERT INTO `sys_roleauth` VALUES ('1', '23');
INSERT INTO `sys_roleauth` VALUES ('2', '18');
INSERT INTO `sys_roleauth` VALUES ('2', '19');
INSERT INTO `sys_roleauth` VALUES ('2', '20');
INSERT INTO `sys_roleauth` VALUES ('2', '5');
INSERT INTO `sys_roleauth` VALUES ('2', '7');
INSERT INTO `sys_roleauth` VALUES ('2', '9');
INSERT INTO `sys_roleauth` VALUES ('2', '14');
INSERT INTO `sys_roleauth` VALUES ('2', '17');
INSERT INTO `sys_roleauth` VALUES ('2', '15');
INSERT INTO `sys_roleauth` VALUES ('2', '16');
INSERT INTO `sys_roleauth` VALUES ('2', '21');
INSERT INTO `sys_roleauth` VALUES ('2', '22');
INSERT INTO `sys_roleauth` VALUES ('2', '23');
INSERT INTO `sys_roleauth` VALUES ('3', '18');
INSERT INTO `sys_roleauth` VALUES ('3', '19');
INSERT INTO `sys_roleauth` VALUES ('3', '20');
INSERT INTO `sys_roleauth` VALUES ('3', '5');
INSERT INTO `sys_roleauth` VALUES ('3', '7');
INSERT INTO `sys_roleauth` VALUES ('3', '9');
INSERT INTO `sys_roleauth` VALUES ('3', '14');
INSERT INTO `sys_roleauth` VALUES ('3', '17');
INSERT INTO `sys_roleauth` VALUES ('3', '15');
INSERT INTO `sys_roleauth` VALUES ('3', '16');
INSERT INTO `sys_roleauth` VALUES ('3', '21');
INSERT INTO `sys_roleauth` VALUES ('3', '22');
INSERT INTO `sys_roleauth` VALUES ('3', '23');
INSERT INTO `sys_roleauth` VALUES ('4', '5');
INSERT INTO `sys_roleauth` VALUES ('4', '7');
INSERT INTO `sys_roleauth` VALUES ('4', '9');
INSERT INTO `sys_roleauth` VALUES ('4', '14');
INSERT INTO `sys_roleauth` VALUES ('4', '17');
INSERT INTO `sys_roleauth` VALUES ('4', '15');
INSERT INTO `sys_roleauth` VALUES ('4', '16');
INSERT INTO `sys_roleauth` VALUES ('5', '2');
INSERT INTO `sys_roleauth` VALUES ('5', '18');
INSERT INTO `sys_roleauth` VALUES ('5', '19');
INSERT INTO `sys_roleauth` VALUES ('5', '20');
INSERT INTO `sys_roleauth` VALUES ('5', '21');
INSERT INTO `sys_roleauth` VALUES ('5', '22');
INSERT INTO `sys_roleauth` VALUES ('5', '23');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` varchar(20) NOT NULL COMMENT '用户ID',
  `user_name` varchar(40) DEFAULT NULL COMMENT '用户姓名',
  `password` char(32) DEFAULT NULL COMMENT '用户密码',
  `status` char(1) DEFAULT NULL COMMENT '状态',
  `create_id` varchar(20) DEFAULT NULL COMMENT '创建人id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_id` varchar(20) DEFAULT NULL COMMENT '修改人id',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  `img_url` varchar(200) DEFAULT NULL COMMENT '用户头像',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('admin', '管理员', 'ISMvKXpXpadDiUoOSoAfww==', '1', 'admin', '2021-07-08 10:04:00', 'admin', '2021-10-09 21:47:00', null);
INSERT INTO `sys_user` VALUES ('dlw', '董立为', 'gdyb21LQTcIANtvYMT7QVQ==', '1', 'admin', '2021-07-13 09:58:25', 'admin', '2022-05-18 11:03:18', null);
INSERT INTO `sys_user` VALUES ('gls', '高雷时', 'gdyb21LQTcIANtvYMT7QVQ==', '1', 'admin', '2021-07-13 09:58:25', 'admin', '2021-10-09 21:47:00', null);
INSERT INTO `sys_user` VALUES ('jxt', '姜欣汤', 'gdyb21LQTcIANtvYMT7QVQ==', '1', 'admin', '2021-07-13 09:58:25', 'admin', '2021-11-09 17:02:04', null);
INSERT INTO `sys_user` VALUES ('mhk', '牟海库', 'gdyb21LQTcIANtvYMT7QVQ==', '1', 'admin', '2021-07-13 09:58:25', 'admin', '2021-10-09 21:47:00', null);
INSERT INTO `sys_user` VALUES ('qxs', '秦先生', 'gdyb21LQTcIANtvYMT7QVQ==', '1', 'admin', '2021-07-13 09:58:25', 'admin', '2021-07-13 09:58:25', null);
INSERT INTO `sys_user` VALUES ('wcf', '温长非', 'gdyb21LQTcIANtvYMT7QVQ==', '1', 'admin', '2021-07-13 09:58:25', 'admin', '2021-11-13 11:09:38', null);
INSERT INTO `sys_user` VALUES ('ww', '王五', 'gdyb21LQTcIANtvYMT7QVQ==', '0', 'admin', '2021-11-09 15:20:16', null, null, null);
INSERT INTO `sys_user` VALUES ('xjx', '许珏新', 'gdyb21LQTcIANtvYMT7QVQ==', '0', 'admin', '2021-10-10 14:26:04', 'admin', '2022-05-17 09:38:18', 'img\\user\\893ba163-666c-49a4-af02-b15fbd59e7ca.jpg');
INSERT INTO `sys_user` VALUES ('zq', '赵七', 'gdyb21LQTcIANtvYMT7QVQ==', '1', 'admin', '2021-11-09 15:20:32', 'admin', '2021-11-09 17:22:07', null);
INSERT INTO `sys_user` VALUES ('zs', '张三', 'gdyb21LQTcIANtvYMT7QVQ==', '1', 'admin', '2021-11-09 14:49:47', null, null, null);

-- ----------------------------
-- Table structure for sys_userrole
-- ----------------------------
DROP TABLE IF EXISTS `sys_userrole`;
CREATE TABLE `sys_userrole` (
  `user_id` varchar(20) NOT NULL COMMENT '用户id',
  `role_id` bigint(6) NOT NULL COMMENT '角色id',
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `role_id` (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_userrole
-- ----------------------------
INSERT INTO `sys_userrole` VALUES ('admin', '1');
INSERT INTO `sys_userrole` VALUES ('gls', '2');
INSERT INTO `sys_userrole` VALUES ('mhk', '2');
INSERT INTO `sys_userrole` VALUES ('jxt', '2');
INSERT INTO `sys_userrole` VALUES ('dlw', '2');
