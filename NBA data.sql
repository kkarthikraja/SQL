/*
Navicat Premium Data Transfer
height_grades
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for height_grades
-- ----------------------------
DROP TABLE IF EXISTS `height_grades`;
CREATE TABLE `height_grades`  (
  `height_level` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '身高等级',
  `height_lowest` float(3, 2) NOT NULL COMMENT '该等级范围中的最低身高',
  `height_highest` float(3, 2) NOT NULL COMMENT '该等级范围中的最高身高'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of height_grades
-- ----------------------------
INSERT INTO `height_grades` VALUES ('A', 2.00, 2.50);
INSERT INTO `height_grades` VALUES ('B', 1.90, 1.99);
INSERT INTO `height_grades` VALUES ('C', 1.80, 1.89);
INSERT INTO `height_grades` VALUES ('D', 1.60, 1.79);

SET FOREIGN_KEY_CHECKS = 1;

/*
player
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for player
-- ----------------------------
DROP TABLE IF EXISTS `player`;
CREATE TABLE `player`  (
  `player_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '球员ID',
  `team_id` int(11) NOT NULL COMMENT '球队ID',
  `player_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '球员姓名',
  `height` float(3, 2) NULL DEFAULT NULL COMMENT '球员身高',
  PRIMARY KEY (`player_id`) USING BTREE,
  UNIQUE INDEX `player_name`(`player_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of player
-- ----------------------------
INSERT INTO `player` VALUES (10001, 1001, '韦恩-艾灵顿', 1.93);
INSERT INTO `player` VALUES (10002, 1001, '雷吉-杰克逊', 1.91);
INSERT INTO `player` VALUES (10003, 1001, '安德烈-德拉蒙德', 2.11);
INSERT INTO `player` VALUES (10004, 1001, '索恩-马克', 2.16);
INSERT INTO `player` VALUES (10005, 1001, '布鲁斯-布朗', 1.96);
INSERT INTO `player` VALUES (10006, 1001, '兰斯顿-加洛韦', 1.88);
INSERT INTO `player` VALUES (10007, 1001, '格伦-罗宾逊三世', 1.98);
INSERT INTO `player` VALUES (10008, 1001, '伊斯梅尔-史密斯', 1.83);
INSERT INTO `player` VALUES (10009, 1001, '扎扎-帕楚里亚', 2.11);
INSERT INTO `player` VALUES (10010, 1001, '乔恩-洛伊尔', 2.08);
INSERT INTO `player` VALUES (10011, 1001, '布雷克-格里芬', 2.08);
INSERT INTO `player` VALUES (10012, 1001, '雷吉-巴洛克', 2.01);
INSERT INTO `player` VALUES (10013, 1001, '卢克-肯纳德', 1.96);
INSERT INTO `player` VALUES (10014, 1001, '斯坦利-约翰逊', 2.01);
INSERT INTO `player` VALUES (10015, 1001, '亨利-埃伦森', 2.11);
INSERT INTO `player` VALUES (10016, 1001, '凯里-托马斯', 1.91);
INSERT INTO `player` VALUES (10017, 1001, '何塞-卡尔德隆', 1.91);
INSERT INTO `player` VALUES (10018, 1001, '斯维亚托斯拉夫-米凯卢克', 2.03);
INSERT INTO `player` VALUES (10019, 1001, '扎克-洛夫顿', 1.93);
INSERT INTO `player` VALUES (10020, 1001, '卡林-卢卡斯', 1.85);
INSERT INTO `player` VALUES (10021, 1002, '维克多-奥拉迪波', 1.93);
INSERT INTO `player` VALUES (10022, 1002, '博扬-博格达诺维奇', 2.03);
INSERT INTO `player` VALUES (10023, 1002, '多曼塔斯-萨博尼斯', 2.11);
INSERT INTO `player` VALUES (10024, 1002, '迈尔斯-特纳', 2.11);
INSERT INTO `player` VALUES (10025, 1002, '赛迪斯-杨', 2.03);
INSERT INTO `player` VALUES (10026, 1002, '达伦-科里森', 1.83);
INSERT INTO `player` VALUES (10027, 1002, '韦斯利-马修斯', 1.96);
INSERT INTO `player` VALUES (10028, 1002, '泰瑞克-埃文斯', 1.98);
INSERT INTO `player` VALUES (10029, 1002, '道格-迈克德莫特', 2.03);
INSERT INTO `player` VALUES (10030, 1002, '科里-约瑟夫', 1.91);
INSERT INTO `player` VALUES (10031, 1002, '阿龙-霍勒迪', 1.85);
INSERT INTO `player` VALUES (10032, 1002, 'TJ-利夫', 2.08);
INSERT INTO `player` VALUES (10033, 1002, '凯尔-奥奎因', 2.08);
INSERT INTO `player` VALUES (10034, 1002, '埃德蒙-萨姆纳', 1.96);
INSERT INTO `player` VALUES (10035, 1002, '达文-里德', 1.98);
INSERT INTO `player` VALUES (10036, 1002, '阿利兹-约翰逊', 2.06);
INSERT INTO `player` VALUES (10037, 1002, '伊凯·阿尼博古', 2.08);

SET FOREIGN_KEY_CHECKS = 1;

/*
player_score
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for player_score
-- ----------------------------
DROP TABLE IF EXISTS `player_score`;
CREATE TABLE `player_score`  (
  `game_id` int(11) NOT NULL COMMENT '比赛ID',
  `player_id` int(11) NOT NULL COMMENT '球员ID',
  `is_first` tinyint(1) NOT NULL COMMENT '是否首发',
  `playing_time` int(11) NOT NULL COMMENT '该球员本次比赛出场时间',
  `rebound` int(11) NOT NULL COMMENT '篮板球',
  `rebound_o` int(11) NOT NULL COMMENT '前场篮板',
  `rebound_d` int(11) NOT NULL COMMENT '后场篮板',
  `assist` int(11) NOT NULL COMMENT '助攻',
  `score` int(11) NOT NULL COMMENT '比分',
  `steal` int(11) NOT NULL COMMENT '抢断',
  `blockshot` int(11) NOT NULL COMMENT '盖帽',
  `fault` int(11) NOT NULL COMMENT '失误',
  `foul` int(11) NOT NULL COMMENT '犯规',
  `shoot_attempts` int(11) NOT NULL COMMENT '总出手',
  `shoot_hits` int(11) NOT NULL COMMENT '命中',
  `shoot_3_attempts` int(11) NOT NULL COMMENT '3分出手',
  `shoot_3_hits` int(11) NOT NULL COMMENT '3分命中',
  `shoot_p_attempts` int(11) NOT NULL COMMENT '罚球出手',
  `shoot_p_hits` int(11) NOT NULL COMMENT '罚球命中'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of player_score
-- ----------------------------
INSERT INTO `player_score` VALUES (10001, 10001, 1, 38, 4, 1, 3, 2, 26, 0, 1, 0, 3, 19, 10, 13, 4, 4, 2);
INSERT INTO `player_score` VALUES (10001, 10002, 1, 30, 6, 4, 2, 4, 22, 0, 0, 6, 3, 19, 8, 5, 1, 5, 5);
INSERT INTO `player_score` VALUES (10001, 10003, 1, 37, 17, 7, 10, 5, 18, 4, 0, 3, 4, 18, 8, 1, 0, 5, 2);
INSERT INTO `player_score` VALUES (10001, 10004, 1, 42, 6, 1, 5, 2, 14, 0, 4, 1, 2, 10, 4, 7, 4, 2, 2);
INSERT INTO `player_score` VALUES (10001, 10005, 1, 19, 2, 0, 2, 2, 0, 2, 0, 1, 1, 1, 0, 1, 0, 0, 0);
INSERT INTO `player_score` VALUES (10001, 10006, 0, 23, 2, 2, 0, 1, 9, 1, 0, 0, 2, 10, 3, 3, 2, 1, 1);
INSERT INTO `player_score` VALUES (10001, 10007, 0, 13, 1, 1, 0, 1, 7, 0, 0, 0, 2, 4, 2, 2, 1, 2, 2);
INSERT INTO `player_score` VALUES (10001, 10008, 0, 20, 2, 0, 2, 3, 6, 0, 0, 3, 3, 5, 3, 0, 0, 0, 0);
INSERT INTO `player_score` VALUES (10001, 10009, 0, 11, 1, 0, 1, 1, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 0);
INSERT INTO `player_score` VALUES (10001, 10010, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO `player_score` VALUES (10002, 10022, 1, 37, 7, 1, 6, 6, 19, 3, 0, 1, 3, 16, 7, 3, 1, 4, 4);
INSERT INTO `player_score` VALUES (10002, 10025, 1, 34, 9, 1, 8, 5, 19, 0, 0, 5, 1, 12, 8, 0, 0, 4, 3);
INSERT INTO `player_score` VALUES (10002, 10024, 1, 34, 6, 0, 6, 0, 17, 3, 5, 0, 2, 7, 5, 3, 2, 6, 5);
INSERT INTO `player_score` VALUES (10002, 10028, 1, 27, 3, 0, 3, 3, 13, 1, 1, 3, 1, 10, 4, 6, 4, 2, 1);
INSERT INTO `player_score` VALUES (10002, 10030, 1, 31, 1, 0, 1, 3, 4, 2, 0, 1, 2, 9, 2, 3, 0, 0, 0);
INSERT INTO `player_score` VALUES (10002, 10023, 0, 23, 12, 4, 8, 3, 18, 0, 0, 3, 6, 10, 8, 0, 0, 2, 2);
INSERT INTO `player_score` VALUES (10002, 10029, 0, 24, 2, 1, 1, 2, 11, 0, 0, 1, 2, 8, 5, 3, 1, 0, 0);
INSERT INTO `player_score` VALUES (10002, 10031, 0, 25, 1, 0, 1, 5, 10, 0, 1, 2, 3, 4, 3, 3, 2, 4, 2);
INSERT INTO `player_score` VALUES (10002, 10032, 0, 4, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 0, 0);

SET FOREIGN_KEY_CHECKS = 1;

/*
 team
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for team
-- ----------------------------
DROP TABLE IF EXISTS `team`;
CREATE TABLE `team`  (
  `team_id` int(11) NOT NULL COMMENT '球队ID',
  `team_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '球队名称',
  PRIMARY KEY (`team_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of team
-- ----------------------------
INSERT INTO `team` VALUES (1001, '底特律活塞');
INSERT INTO `team` VALUES (1002, '印第安纳步行者');
INSERT INTO `team` VALUES (1003, '亚特兰大老鹰');

SET FOREIGN_KEY_CHECKS = 1;

/*
 team_score
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for team_score
-- ----------------------------
DROP TABLE IF EXISTS `team_score`;
CREATE TABLE `team_score`  (
  `game_id` int(11) NOT NULL COMMENT '比赛ID',
  `h_team_id` int(11) NOT NULL COMMENT '主队ID',
  `v_team_id` int(11) NOT NULL COMMENT '客队ID',
  `h_team_score` int(11) NOT NULL COMMENT '主队得分',
  `v_team_score` int(11) NOT NULL COMMENT '客队得分',
  `game_date` date NULL DEFAULT NULL COMMENT '比赛时间',
  PRIMARY KEY (`game_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of team_score
-- ----------------------------
INSERT INTO `team_score` VALUES (10001, 1001, 1002, 102, 111, '2019-04-01');
INSERT INTO `team_score` VALUES (10002, 1002, 1003, 135, 134, '2019-04-10');

SET FOREIGN_KEY_CHECKS = 1;