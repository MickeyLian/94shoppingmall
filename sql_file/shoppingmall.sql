/*
Navicat MySQL Data Transfer

Source Server         : java
Source Server Version : 50532
Source Host           : 127.0.0.1:3306
Source Database       : shoppingmall

Target Server Type    : MYSQL
Target Server Version : 50532
File Encoding         : 65001

Date: 2018-12-14 13:30:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `cid` varchar(32) NOT NULL,
  `cname` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', '手机数码');
INSERT INTO `category` VALUES ('2', '电脑办公');
INSERT INTO `category` VALUES ('3', '家具家居');
INSERT INTO `category` VALUES ('5', '图书音像');
INSERT INTO `category` VALUES ('56ADF6AFB0AC477488C9B8ECAFB9F014', '家用电器');
INSERT INTO `category` VALUES ('6', '随便逛逛');
INSERT INTO `category` VALUES ('B274B9BF800C40099C7430020755E893', '美味零食');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `commentor` varchar(255) DEFAULT NULL COMMENT '评论者',
  `date` timestamp NULL DEFAULT NULL COMMENT '评论日期',
  `commentHeader` varchar(255) DEFAULT NULL COMMENT '评论者头像',
  `content` varchar(255) DEFAULT NULL COMMENT '评论内容',
  `pid` varchar(255) DEFAULT NULL COMMENT '商品id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('13', 'admin', '2018-12-13 10:40:06', 'userPhoto/208367.jpg', '好实用的手机', '1');
INSERT INTO `comment` VALUES ('14', 'Mickey', '2018-12-13 10:41:07', 'userPhoto/213123.jpg', '放屁！垃圾的要死！没用到几个月就坏了', '1');
INSERT INTO `comment` VALUES ('15', 'Baby宝贝', '2018-12-13 10:43:58', 'userPhoto/201193.jpg', '看到你们这样评论，我都不敢买了', '1');

-- ----------------------------
-- Table structure for orderitem
-- ----------------------------
DROP TABLE IF EXISTS `orderitem`;
CREATE TABLE `orderitem` (
  `itemid` varchar(32) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `total` double DEFAULT NULL,
  `pid` varchar(32) DEFAULT NULL,
  `oid` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`itemid`),
  KEY `order_item_fk_0001` (`pid`),
  KEY `order_item_fk_0002` (`oid`),
  CONSTRAINT `order_item_fk_0001` FOREIGN KEY (`pid`) REFERENCES `product` (`pid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_item_fk_0002` FOREIGN KEY (`oid`) REFERENCES `orders` (`oid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orderitem
-- ----------------------------
INSERT INTO `orderitem` VALUES ('1D3BE1A258FD44CDA1B87E21C861756C', '1', '2599', '10', 'E7D258B86B2F48F29B980F0C3B41F08C');
INSERT INTO `orderitem` VALUES ('32A3B45E3AAE45D5BEBCD53BE7D0161F', '1', '1299', '1', 'AE8550B3354540E0BA16342632072F11');
INSERT INTO `orderitem` VALUES ('33F6A317A2E34388A9F883AAEB471C8F', '1', '6', '98E7F117CBA4408294DC516946F67653', 'ED574FCE46794A09A727E0A3695AB84B');
INSERT INTO `orderitem` VALUES ('3BB88F6CEB6946F29BE93B5564D00097', '2', '5198', '10', 'ED574FCE46794A09A727E0A3695AB84B');
INSERT INTO `orderitem` VALUES ('5615D5DB0A7A42F08F0B42A901FE20E6', '1', '6688', '32', 'C5498CB2268F434D9ABF841147E6DF0A');
INSERT INTO `orderitem` VALUES ('5824D4BA26784D4D98CE88B49BC9BE50', '1', '2599', '10', '83D3751CFE1D434FBE4AE84A521ED3F9');
INSERT INTO `orderitem` VALUES ('6AD2B61863344B078DA6B6278E9471F7', '1', '1299', '1', '6EB69698B10248B1B90E2AF9D2CCAD2B');
INSERT INTO `orderitem` VALUES ('795F63B1F95848C5AA8A4715238CB6BD', '4', '18', '0CF61FDB8965411F87E028796D0DF064', 'DCF1EACCC40145BF956265ADB4A29C73');
INSERT INTO `orderitem` VALUES ('7D2E177B4251452391672406D2D8063E', '1', '312', '2EFBAC6CE6E34BEE9DA35FD169442487', 'DCF1EACCC40145BF956265ADB4A29C73');
INSERT INTO `orderitem` VALUES ('870CDC36FD0047A28B69054AA53297E0', '1', '2599', '10', 'C5498CB2268F434D9ABF841147E6DF0A');
INSERT INTO `orderitem` VALUES ('A1A3B705ADF349C2A4DDF0A623F87878', '1', '4199', '33', '1959994A423E4075A2BF38B7D0B18D0D');
INSERT INTO `orderitem` VALUES ('BA80DC9C557C4405BF7C404E594B4084', '1', '4.5', '0CF61FDB8965411F87E028796D0DF064', 'C13F1C7102544D82BC630684FD091310');
INSERT INTO `orderitem` VALUES ('BE6375E82C2644E3948F0E1C23561595', '1', '1699', '23', 'C13F1C7102544D82BC630684FD091310');
INSERT INTO `orderitem` VALUES ('CEA04BEC6EB74E699FB4330DB6998E66', '1', '2299', '31', 'AD2000300498407096A35A53CFFD5B5D');
INSERT INTO `orderitem` VALUES ('D220C55D9743474DB295CF3801530B06', '1', '2499', '13', 'C13F1C7102544D82BC630684FD091310');
INSERT INTO `orderitem` VALUES ('D98491D360BF48D4BE5F6D9F95F4766C', '1', '4199', '33', 'A75EB1FDEC914210A7D8F8997F4C456D');
INSERT INTO `orderitem` VALUES ('DB1BF74DFC624C0182725609CB0AC33B', '1', '1299', '1', 'E12AD7C2F2BF4B00B28EE2B4940B64A7');
INSERT INTO `orderitem` VALUES ('F563E2694A0747DF9C2D8F50E1A9C4EB', '1', '2299', '31', 'ACE41D2A5F2048DC952B0817B2AED1BA');
INSERT INTO `orderitem` VALUES ('FF6A175CDDE944C1A66AE33981B90FB3', '1', '2299', '31', 'CA421A5F7E4A4521B8612CCEA6EB571B');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `oid` varchar(32) NOT NULL,
  `ordertime` datetime DEFAULT NULL,
  `total` double DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `address` varchar(30) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `uid` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`oid`),
  KEY `order_fk_0001` (`uid`),
  CONSTRAINT `order_fk_0001` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('1959994A423E4075A2BF38B7D0B18D0D', '2018-08-22 14:30:25', '4199', '1', '', '', '', '05DD93A7A02C43A48F4C8945CAD3E96F');
INSERT INTO `orders` VALUES ('2CB12E810EFE4A579BE2A1BCD40E8717', '2018-12-13 19:01:41', '0', '1', null, null, null, '05DD93A7A02C43A48F4C8945CAD3E96F');
INSERT INTO `orders` VALUES ('6EB69698B10248B1B90E2AF9D2CCAD2B', '2018-08-21 10:27:17', '1299', '1', '深圳', 'mickey', '15797654898', '05DD93A7A02C43A48F4C8945CAD3E96F');
INSERT INTO `orders` VALUES ('83D3751CFE1D434FBE4AE84A521ED3F9', '2018-08-21 21:07:02', '2599', '3', null, null, null, '05DD93A7A02C43A48F4C8945CAD3E96F');
INSERT INTO `orders` VALUES ('890F85746C614D0B8BFCEDF00F47D3A1', '2018-12-13 19:01:47', '0', '1', null, null, null, '05DD93A7A02C43A48F4C8945CAD3E96F');
INSERT INTO `orders` VALUES ('A75EB1FDEC914210A7D8F8997F4C456D', '2018-08-22 14:25:17', '4199', '1', null, null, null, '05DD93A7A02C43A48F4C8945CAD3E96F');
INSERT INTO `orders` VALUES ('ACE41D2A5F2048DC952B0817B2AED1BA', '2018-08-22 16:02:48', '2299', '4', null, 'mickey', '157654686', '05DD93A7A02C43A48F4C8945CAD3E96F');
INSERT INTO `orders` VALUES ('AD2000300498407096A35A53CFFD5B5D', '2018-08-21 22:31:41', '2299', '3', null, null, null, '05DD93A7A02C43A48F4C8945CAD3E96F');
INSERT INTO `orders` VALUES ('AE8550B3354540E0BA16342632072F11', '2018-08-21 10:27:01', '1299', '1', null, null, null, '05DD93A7A02C43A48F4C8945CAD3E96F');
INSERT INTO `orders` VALUES ('BB64ADE5C35F457287CC890A8E51CDAC', '2018-12-13 19:02:48', '0', '1', null, null, null, '05DD93A7A02C43A48F4C8945CAD3E96F');
INSERT INTO `orders` VALUES ('C13F1C7102544D82BC630684FD091310', '2018-12-13 18:59:46', '4202.5', '1', '', '', '', '05DD93A7A02C43A48F4C8945CAD3E96F');
INSERT INTO `orders` VALUES ('C5498CB2268F434D9ABF841147E6DF0A', '2018-08-26 19:20:35', '9287', '1', null, null, null, '05DD93A7A02C43A48F4C8945CAD3E96F');
INSERT INTO `orders` VALUES ('CA421A5F7E4A4521B8612CCEA6EB571B', '2018-09-03 10:16:35', '2299', '1', null, null, null, '05DD93A7A02C43A48F4C8945CAD3E96F');
INSERT INTO `orders` VALUES ('DCF1EACCC40145BF956265ADB4A29C73', '2018-10-16 22:20:29', '330', '1', null, null, null, 'DD8FCA52E00993F4DA48B5A03A7643EB');
INSERT INTO `orders` VALUES ('E12AD7C2F2BF4B00B28EE2B4940B64A7', '2018-08-21 12:02:18', '1299', '3', null, null, null, '05DD93A7A02C43A48F4C8945CAD3E96F');
INSERT INTO `orders` VALUES ('E7D258B86B2F48F29B980F0C3B41F08C', '2018-08-21 14:28:45', '6887', '4', null, 'mickey', '163646548', '05DD93A7A02C43A48F4C8945CAD3E96F');
INSERT INTO `orders` VALUES ('ED574FCE46794A09A727E0A3695AB84B', '2018-09-07 09:08:39', '5204', '1', '深圳', 'admin', '15797654898', '05DD93A7A02C43A48F4C8945CAD3E96F');
INSERT INTO `orders` VALUES ('F1064EDBD74F44C789BEE620BE590F16', '2018-12-13 19:03:06', '0', '1', null, null, null, '05DD93A7A02C43A48F4C8945CAD3E96F');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `pid` varchar(32) NOT NULL,
  `pname` varchar(50) DEFAULT NULL,
  `marketPrice` double DEFAULT NULL,
  `shopPrice` double DEFAULT NULL,
  `pimage` varchar(200) DEFAULT NULL,
  `pdate` date DEFAULT NULL,
  `isHot` int(11) DEFAULT NULL,
  `pdesc` varchar(255) DEFAULT NULL,
  `pflag` int(11) DEFAULT '0',
  `cid` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`pid`),
  KEY `product_fk_0001` (`cid`),
  CONSTRAINT `product_fk_0001` FOREIGN KEY (`cid`) REFERENCES `category` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('0CF61FDB8965411F87E028796D0DF064', '卫龙', '5', '4.5', 'products/3/weolong.jpg', '2018-10-17', '1', '很辣', '0', 'B274B9BF800C40099C7430020755E893');
INSERT INTO `product` VALUES ('1', '小米note m4', '1399', '1299', 'products/1/c_0001.jpg', '2015-11-02', '1', '小米 4c 标准版 全网通 白色 移动联通电信4G手机 双卡双待', '0', '1');
INSERT INTO `product` VALUES ('10', '华为 Ascend Mate7', '2699', '2599', 'products/1/c_0010.jpg', '2015-11-02', '1', '华为 Ascend Mate7 月光银 移动4G手机 双卡双待双通6英寸高清大屏，纤薄机身，智能超八核，按压式指纹识别！!选择下方“移动老用户4G飞享合约”，无需换号，还有话费每月返还！', '0', '1');
INSERT INTO `product` VALUES ('12', '努比亚（nubia）My 布拉格', '1899', '1799', ' ', '2015-11-02', '0', '努比亚（nubia）My 布拉格 银白 移动联通4G手机 双卡双待【嗨11，下单立减100】金属机身，快速充电！布拉格相机全新体验！', '1', '1');
INSERT INTO `product` VALUES ('13', '华为 麦芒4', '2599', '2499', 'products/1/c_0012.jpg', '2015-11-02', '1', '华为 麦芒4 晨曦金 全网通版4G手机 双卡双待金属机身 2.5D弧面屏 指纹解锁 光学防抖', '0', '1');
INSERT INTO `product` VALUES ('16', '华为 HUAWEI Mate S ', '4200', '4087', 'products/1/c_0016.jpg', '2015-11-03', '0', '华为 HUAWEI Mate S 臻享版 手机 极昼金 移动联通双4G(高配)满星评价即返30元话费啦；买就送电源+清水套+创意手机支架；优雅弧屏，mate7升级版', '0', '1');
INSERT INTO `product` VALUES ('19', 'HTC Desire 826d  臻珠白', '1599', '1469', 'products/1/c_0020.jpg', '2015-11-02', '1', '后置1300万+UltraPixel超像素前置摄像头+【双】前置扬声器+5.5英寸【1080p】大屏！', '0', '1');
INSERT INTO `product` VALUES ('2', '中兴 AXON', '2899', '2699', 'products/1/c_0002.jpg', '2015-11-05', '1', '中兴 AXON 天机 mini 压力屏版 B2015 华尔金 移动联通电信4G 双卡双待', '0', '1');
INSERT INTO `product` VALUES ('20', '小米 红米2A 增强版 白色', '649', '549', 'products/1/c_0019.jpg', '2015-11-02', '0', '新增至2GB 内存+16GB容量！4G双卡双待，联芯 4 核 1.5GHz 处理器！', '0', '1');
INSERT INTO `product` VALUES ('21', ' 魅蓝note2 16GB 白色', '1099', '999', 'products/1/c_0021.jpg', '2015-11-02', '0', '现货速抢，抢完即止！5.5英寸1080P分辨率屏幕，64位八核1.3GHz处理器，1300万像素摄像头，双色温双闪光灯！', '0', '1');
INSERT INTO `product` VALUES ('22', '三星 Galaxy S5 闪耀白', '2099', '1999', 'products/1/c_0022.jpg', '2015-11-02', '1', '5.1英寸全高清炫丽屏，2.5GHz四核处理器，1600万像素', '0', '1');
INSERT INTO `product` VALUES ('23', 'sonim XP7700 4G手机', '1799', '1699', 'products/1/c_0023.jpg', '2015-11-09', '1', '三防智能手机 移动/联通双4G 安全 黑黄色 双4G美国军工IP69 30天长待机 3米防水防摔 北斗', '0', '1');
INSERT INTO `product` VALUES ('24', '努比亚（nubia）Z9 金色', '3988', '3888', 'products/1/c_0024.jpg', '2015-11-02', '1', '移动联通电信4G手机 双卡双待真正的无边框！金色尊贵版！4GB+64GB大内存！', '0', '1');
INSERT INTO `product` VALUES ('25', 'Apple iPhone 6 Plus 16GB ', '5188', '4988', 'products/1/c_0025.jpg', '2015-11-02', '0', 'Apple iPhone 6 Plus (A1524) 16GB 金色 移动联通电信4G手机 硬货 硬实力', '0', '1');
INSERT INTO `product` VALUES ('26', 'Apple iPhone 6s (A1700)', '6388', '6088', 'products/1/c_0026.jpg', '2015-11-02', '0', 'Apple iPhone 6 Plus (A1524) 16GB 金色 移动联通电信4G手机 硬货 硬实力', '0', '1');
INSERT INTO `product` VALUES ('27', '三星 Galaxy Note5', '5588', '5388', 'products/1/c_0027.jpg', '2015-11-02', '0', '旗舰机型！5.7英寸大屏，4+32G内存！不一样的SPen更优化的浮窗指令！赠无线充电板！', '0', '1');
INSERT INTO `product` VALUES ('28', '三星 Galaxy S6 Edge+', '5999', '5888', 'products/1/c_0028.jpg', '2015-11-02', '0', '赠移动电源+自拍杆+三星OTG金属U盘+无线充电器+透明保护壳', '0', '1');
INSERT INTO `product` VALUES ('29', 'LG G4（H818） 国际版', '3018', '2978', 'products/1/c_0029.jpg', '2015-11-02', '0', '李敏镐代言，F1.8大光圈1600万后置摄像头，5.5英寸2K屏，3G+32G内存，LG年度旗舰机！', '0', '1');
INSERT INTO `product` VALUES ('2EFBAC6CE6E34BEE9DA35FD169442487', '草稿', '231', '312', 'products/1/c_0029.jpg', '2018-08-24', '0', '旗舰机', '0', '6');
INSERT INTO `product` VALUES ('3', '华为荣耀6', '1599', '1499', 'products/1/c_0003.jpg', '2015-11-02', '0', '荣耀 6 (H60-L01) 3GB内存标准版 黑色 移动4G手机', '0', '1');
INSERT INTO `product` VALUES ('30', '微软(Microsoft) Lumia 640', '1099', '999', 'products/1/c_0030.jpg', '2015-11-02', '0', '微软首款双网双卡双4G手机，5.0英寸高清大屏，双网双卡双4G！', '0', '1');
INSERT INTO `product` VALUES ('31', '宏碁（acer）ATC705-N50', '2399', '2299', 'products/1/c_0031.jpg', '2015-11-02', '0', '爆款直降，满千减百，品质宏碁，特惠来袭，何必苦等11.11，早买早便宜！', '0', '2');
INSERT INTO `product` VALUES ('32', 'Apple MacBook Air ', '6788', '6688', 'products/1/c_0032.jpg', '2015-11-02', '0', '宽屏笔记本电脑 128GB 闪存', '0', '2');
INSERT INTO `product` VALUES ('33', '联想（ThinkPad）', '4399', '4199', 'products/1/c_0033.jpg', '2015-11-02', '0', '联想（ThinkPad） 轻薄系列E450C(20EH0001CD)14英寸笔记本电脑(i5-4210U 4G 500G 2G独显 Win8.1)', '0', '2');
INSERT INTO `product` VALUES ('34', '联想 小新V3000经典版', '4599', '4499', 'products/1/c_0034.jpg', '2015-11-02', '0', '14英寸超薄笔记本电脑（i7-5500U 4G 500G+8G SSHD 2G独显 全高清屏）黑色满1000減100，狂减！火力全开，横扫3天！', '0', '2');
INSERT INTO `product` VALUES ('35', '华硕 经典系列R557LI', '3799', '3699', 'products/1/c_0035.jpg', '2015-11-02', '0', '15.6英寸笔记本电脑（i5-5200U 4G 7200转500G 2G独显 D刻 蓝牙 Win8.1 黑色）', '0', '2');
INSERT INTO `product` VALUES ('36', '华硕（ASUS）X450J', '4599', '4399', 'products/1/c_0036.jpg', '2015-11-02', '0', '14英寸笔记本电脑 （i5-4200H 4G 1TB GT940M 2G独显 蓝牙4.0 D刻 Win8.1 黑色）', '0', '2');
INSERT INTO `product` VALUES ('37', '戴尔（DELL）灵越 ', '3399', '3299', 'products/1/c_0037.jpg', '2015-11-03', '0', ' Ins14C-4528B 14英寸笔记本（i5-5200U 4G 500G GT820M 2G独显 Win8）黑', '0', '2');
INSERT INTO `product` VALUES ('38', '惠普(HP)WASD 暗影精灵', '5699', '5499', 'products/1/c_0038.jpg', '2015-11-02', '0', '15.6英寸游戏笔记本电脑(i5-6300HQ 4G 1TB+128G SSD GTX950M 4G独显 Win10)', '0', '2');
INSERT INTO `product` VALUES ('39', 'Apple 配备 Retina ', '11299', '10288', 'products/1/c_0039.jpg', '2015-11-02', '0', 'Pro MF840CH/A 13.3英寸宽屏笔记本电脑 256GB 闪存', '0', '2');
INSERT INTO `product` VALUES ('4', '联想 P1', '2199', '1999', 'products/1/c_0004.jpg', '2015-11-02', '0', '联想 P1 16G 伯爵金 移动联通4G手机充电5分钟，通话3小时！科技源于超越！品质源于沉淀！5000mAh大电池！高端商务佳配！', '0', '1');
INSERT INTO `product` VALUES ('40', '机械革命（MECHREVO）', '6799', '6599', 'products/1/c_0040.jpg', '2015-11-02', '0', '15.6英寸游戏本(I7-4710MQ 8G 64GSSD+1T GTX960M 2G独显 IPS屏 WIN7)黑色', '0', '2');
INSERT INTO `product` VALUES ('41', '神舟（HASEE） ', '5699', '5499', 'products/1/c_0041.jpg', '2015-11-02', '0', '15.6英寸游戏本(i7-4710MQ 8G 1TB GTX960M 2G独显 1080P)黑色', '0', '2');
INSERT INTO `product` VALUES ('42', '微星（MSI）', '6199', '5999', 'products/1/c_0042.jpg', '2015-11-02', '0', '15.6英寸游戏笔记本电脑（i5-4210H 8G 1T GTX960MG DDR5 2G 背光键盘）黑色', '0', '2');
INSERT INTO `product` VALUES ('43', '雷神（ThundeRobot）', '5699', '5499', 'products/1/c_0043.jpg', '2015-11-02', '0', '15.6英寸游戏本 ( i7-4710MQ 4G 500G GTX950M 2G独显 包无亮点全高清屏) 金', '0', '2');
INSERT INTO `product` VALUES ('44', '惠普（HP）轻薄系列 HP', '3199', '3099', 'products/1/c_0044.jpg', '2015-11-02', '0', '15-r239TX 15.6英寸笔记本电脑（i5-5200U 4G 500G GT820M 2G独显 win8.1）金属灰', '0', '2');
INSERT INTO `product` VALUES ('45', '未来人类（Terrans Force）', '10999', '9899', 'products/1/c_0045.jpg', '2015-11-02', '0', '15.6英寸游戏本（i7-5700HQ 16G 120G固态+1TB GTX970M 3G GDDR5独显）黑', '0', '2');
INSERT INTO `product` VALUES ('46', '戴尔 Vostro  台式电脑', '3299', '3199', 'products/1/c_0046.jpg', '2015-11-02', '0', '（i3-4170 4G 500G DVD 三年上门服务 Win7）黑', '0', '2');
INSERT INTO `product` VALUES ('47', '联想H3050 台式电脑', '5099', '4899', 'products/1/c_0047.jpg', '2015-11-11', '0', '（i5-4460 4G 500G GT720 1G独显 DVD 千兆网卡 Win10）23英寸', '0', '2');
INSERT INTO `product` VALUES ('48', 'Apple iPad mini 2 ', '2088', '1888', 'products/1/c_0048.jpg', '2015-11-02', '0', '（配备 Retina 显示屏 7.9英寸 16G WLAN 机型 银色）', '0', '2');
INSERT INTO `product` VALUES ('49', '小米（MI）7.9英寸平板', '1399', '1299', 'products/1/c_0049.jpg', '2015-11-02', '0', 'WIFI 64GB（NVIDIA Tegra K1 2.2GHz 2G 64G 2048*1536视网膜屏 800W）白色', '0', '2');
INSERT INTO `product` VALUES ('5', '摩托罗拉 moto x（x+1）', '1799', '1699', 'products/1/c_0005.jpg', '2015-11-01', '0', '摩托罗拉 moto x（x+1）(XT1085) 32GB 天然竹 全网通4G手机11月11天！MOTO X震撼特惠来袭！1699元！带你玩转黑科技！天然材质，原生流畅系统！', '0', '1');
INSERT INTO `product` VALUES ('50', 'Apple iPad Air 2 ', '2399', '2299', 'products/1/c_0050.jpg', '2015-11-12', '0', '（9.7英寸 16G WLAN 机型 银色）', '0', '2');
INSERT INTO `product` VALUES ('5044C9D5808F449C88B1FAA186CD7A29', '辣条3', '5', '6', 'products/3/latiao1.jpg', '2018-08-27', '1', '辣条3', '0', 'B274B9BF800C40099C7430020755E893');
INSERT INTO `product` VALUES ('6', '魅族 MX5 16GB 银黑色', '1899', '1799', 'products/1/c_0006.jpg', '2015-11-02', '0', '魅族 MX5 16GB 银黑色 移动联通双4G手机 双卡双待送原厂钢化膜+保护壳+耳机！5.5英寸大屏幕，3G运行内存，2070万+500万像素摄像头！长期省才是真的省！', '0', '1');
INSERT INTO `product` VALUES ('7', '三星 Galaxy On7', '1499', '1398', 'products/1/c_0007.jpg', '2015-11-14', '0', '三星 Galaxy On7（G6000）昂小七 金色 全网通4G手机 双卡双待新品火爆抢购中！京东尊享千元良机！5.5英寸高清大屏！1300+500W像素！评价赢30元话费券！', '0', '1');
INSERT INTO `product` VALUES ('8', 'NUU NU5', '1288', '1190', 'products/1/c_0008.jpg', '2015-11-02', '0', 'NUU NU5 16GB 移动联通双4G智能手机 双卡双待 晒单有礼 晨光金香港品牌 2.5D弧度前后钢化玻璃 随机附赠手机套+钢化贴膜 晒单送移动电源+蓝牙耳机', '0', '1');
INSERT INTO `product` VALUES ('9', '乐视乐1pro（X800）', '2399', '2299', 'products/1/c_0009.jpg', '2015-11-02', '0', '乐视（Letv）乐1pro（X800）64GB 金色 移动联通4G手机 双卡双待乐视生态UI+5.5英寸2K屏+高通8核处理器+4GB运行内存+64GB存储+1300万摄像头！', '0', '1');
INSERT INTO `product` VALUES ('98E7F117CBA4408294DC516946F67653', '薯片2', '7', '6', 'products/3/shupian2.jpg', '2018-08-27', '1', '薯片2', '0', 'B274B9BF800C40099C7430020755E893');
INSERT INTO `product` VALUES ('9A6A01CBB10A441FAC24D386EE954408', '辣条5', '5', '6', 'products/3/latiao1.jpg', '2018-09-07', '1', 'asadsa', '0', 'B274B9BF800C40099C7430020755E893');
INSERT INTO `product` VALUES ('BCAAE6B89D1840658BFDF7B307252325', '薯片1', '5', '4', 'products/3/shupian1.jpg', '2018-08-27', '1', '薯片1', '0', 'B274B9BF800C40099C7430020755E893');
INSERT INTO `product` VALUES ('CAB49FEE89FE4DE3B8F6D6BC47E8EC82', '辣条2', '5', '6', 'products/3/latiao2.jpg', '2018-08-27', '1', '辣条2', '1', 'B274B9BF800C40099C7430020755E893');
INSERT INTO `product` VALUES ('F27294C03ACA4EF7A583431068FEF237', '薯片', '5', '4', 'products/3/shupian1.jpg', '2018-08-27', '1', '薯片', '0', 'B274B9BF800C40099C7430020755E893');
INSERT INTO `product` VALUES ('F59C73F86E74489992519DF6FD44977A', '薯片2', '5', '6', 'products/3/shupian1.jpg', '2018-08-27', '1', '薯片2', '0', 'B274B9BF800C40099C7430020755E893');

-- ----------------------------
-- Table structure for reply
-- ----------------------------
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `replyer` varchar(255) DEFAULT NULL COMMENT '回复人',
  `date` timestamp NULL DEFAULT NULL COMMENT '回复日期',
  `replyHeader` varchar(255) DEFAULT NULL COMMENT '回复者头像',
  `content` varchar(255) DEFAULT NULL COMMENT '回复内容',
  `reply_for` varchar(255) DEFAULT NULL COMMENT '被回复的人',
  `comment_id` int(11) DEFAULT NULL COMMENT '回复评论的id',
  `reply_id` int(11) DEFAULT NULL COMMENT '回复回复的id',
  `pid` varchar(255) DEFAULT NULL COMMENT '商品id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of reply
-- ----------------------------
INSERT INTO `reply` VALUES ('9', 'admin', '2018-12-13 10:41:33', 'userPhoto/208367.jpg', '没有吧，我都用一年了', 'wang', '14', null, '1');
INSERT INTO `reply` VALUES ('10', 'Mickey', '2018-12-13 10:44:42', 'userPhoto/213123.jpg', '真的很垃圾，千万别买', 'zeng', '15', null, '1');
INSERT INTO `reply` VALUES ('11', 'Baby宝贝', '2018-12-13 10:47:50', 'userPhoto/201193.jpg', '好吧，果断不买', 'zeng', '15', '10', '1');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `uid` varchar(32) NOT NULL,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL COMMENT '用户头像',
  `state` int(11) DEFAULT '0',
  `code` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('05DD93A7A02C43A48F4C8945CAD3E96F', 'admin', '123456', 'aaa', 'aaa@shoppingmall.com', '15797654898', '2000-08-08', '男', 'userPhoto/208367.jpg', '1', null);
INSERT INTO `user` VALUES ('31C05D1B7C624BD08AA04DF66308E401', 'ljn', '123456', 'lian', 'lian@shoppingmall.com', '12345678972', '1995-11-30', '男', 'userPhoto/217851.jpg', '1', null);
INSERT INTO `user` VALUES ('3549FCCA024C450AB6562B6DD8A355AD', '那个傻子', '123456', '傻子就是你', 'lian@shoppingmall.com', '15795254138', '1996-05-31', '男', 'userPhoto/微笑的狗.jpg', '1', null);
INSERT INTO `user` VALUES ('68BB03648E234B27BE8964DC58814C0C', 'Mickey', '123456', 'aaa', 'aaa@shoppingmall.com', '12345678971', '2000-08-16', '男', 'userPhoto/213123.jpg', '1', '');
INSERT INTO `user` VALUES ('A643D97C7F844264AC679353304729BB', 'Baby宝贝', '123456', 'bbb', 'bbb@shoppingmall.com', '15797655697', '1996-08-20', '女', 'userPhoto/201193.jpg', '1', '');
INSERT INTO `user` VALUES ('DD8FCA52E00993F4DA48B5A03A7643EB', 'Demons', '123456', '小lian', 'lian@shoppingmall.com', '15795289647', '1996-05-31', '男', 'userPhoto/u=2579527192,4127148430&fm=27&gp=0.jpg', '1', null);
