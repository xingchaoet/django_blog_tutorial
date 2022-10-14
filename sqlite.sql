/*
 Navicat Premium Data Transfer

 Source Server         : rumor-sqlite
 Source Server Type    : SQLite
 Source Server Version : 3030001
 Source Schema         : main

 Target Server Type    : SQLite
 Target Server Version : 3030001
 File Encoding         : 65001

 Date: 11/10/2022 17:51:02
*/

PRAGMA foreign_keys = false;

-- ----------------------------
-- Table structure for account_emailaddress
-- ----------------------------
DROP TABLE IF EXISTS "account_emailaddress";
CREATE TABLE "account_emailaddress" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "verified" bool NOT NULL,
  "primary" bool NOT NULL,
  "user_id" integer NOT NULL,
  "email" varchar(254) NOT NULL,
  FOREIGN KEY ("user_id") REFERENCES "auth_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  UNIQUE ("email" ASC)
);

-- ----------------------------
-- Records of account_emailaddress
-- ----------------------------

-- ----------------------------
-- Table structure for account_emailconfirmation
-- ----------------------------
DROP TABLE IF EXISTS "account_emailconfirmation";
CREATE TABLE "account_emailconfirmation" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "created" datetime NOT NULL,
  "sent" datetime,
  "key" varchar(64) NOT NULL,
  "email_address_id" integer NOT NULL,
  FOREIGN KEY ("email_address_id") REFERENCES "account_emailaddress" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  UNIQUE ("key" ASC)
);

-- ----------------------------
-- Records of account_emailconfirmation
-- ----------------------------

-- ----------------------------
-- Table structure for article_articlecolumn
-- ----------------------------
DROP TABLE IF EXISTS "article_articlecolumn";
CREATE TABLE "article_articlecolumn" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "title" varchar(100) NOT NULL,
  "created" datetime NOT NULL
);

-- ----------------------------
-- Records of article_articlecolumn
-- ----------------------------
INSERT INTO "article_articlecolumn" VALUES (1, 'Django', '2019-01-29 10:47:02');
INSERT INTO "article_articlecolumn" VALUES (2, 'Java', '2019-01-29 10:47:43');
INSERT INTO "article_articlecolumn" VALUES (3, 'HTML', '2019-01-29 10:47:53');

-- ----------------------------
-- Table structure for article_articlepost
-- ----------------------------
DROP TABLE IF EXISTS "article_articlepost";
CREATE TABLE "article_articlepost" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "title" varchar(100) NOT NULL,
  "body" text NOT NULL,
  "created" datetime NOT NULL,
  "updated" datetime NOT NULL,
  "author_id" integer NOT NULL,
  "total_views" integer unsigned NOT NULL,
  "column_id" integer,
  "avatar" varchar(100) NOT NULL,
  "likes" integer unsigned NOT NULL,
  FOREIGN KEY ("author_id") REFERENCES "auth_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  FOREIGN KEY ("column_id") REFERENCES "article_articlecolumn" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Records of article_articlepost
-- ----------------------------
INSERT INTO "article_articlepost" VALUES (19, '作文', '下教师资格证综合素质作文主题预测一，我的直觉一向准，懂得都懂', '2022-09-26 03:30:11', '2022-09-26 03:30:11', 14, 48, 1, 'article/20190624/威尼斯.jpg', 0);
INSERT INTO "article_articlepost" VALUES (20, '奶茶', '今天的奶茶是双份糖，为什么呢？因为今天是半糖开播两周年啦！', '2022-09-26 03:30:11', '2022-09-26 03:30:11', 14, 407, 1, '', 0);
INSERT INTO "article_articlepost" VALUES (21, '爱媛珍珠', '爱媛县的珍珠产量在日本名列前茅，从母贝生产到珍珠养殖，都经过了严格的把控，因此才有了又大又亮的爱媛珍珠[好喜欢]爱媛的珍珠你值得拥有！', '2022-09-26 03:30:11', '2022-09-26 03:30:11', 14, 34, 1, '', 1);
INSERT INTO "article_articlepost" VALUES (22, '情绪', '人与人的情感交流在需要与理解之间发生，患者期望医生能理解他们。

从医二十余年，接诊过来自五湖四海的患者朋友。

从他们身上我看过太多太多艰难的寻医历程，所以每一个诊疗过程都是一个难得故事。

患者有故事要讲，有情绪要宣泄，有心理负担要解脱，这个过程也是治疗', '2022-09-26 03:30:11', '2022-09-26 03:30:11', 14, 15, NULL, '', 0);
INSERT INTO "article_articlepost" VALUES (23, '心理', '考证超话#心理学#如何快速拿到心理咨询师证书，心理大师免费分享学习心得 学习入口 并赠送多套学习资料[冲刺] [冲刺] 领取入口<<< ​​​', '2022-09-26 03:30:11', '2022-09-26 03:30:11', 14, 33, NULL, '', 0);
INSERT INTO "article_articlepost" VALUES (24, '礼物', '“我不过节”
不过节可以没有仪式可以没有礼物，但是该打钱就打钱。不然呢？', '2022-09-26 03:30:11', '2022-09-26 03:30:11', 14, 38, 3, '', 0);
INSERT INTO "article_articlepost" VALUES (25, '考试', '易师考23年教综笔试课程课堂实录：循序渐进教学原则', '2022-09-26 03:30:11', '2022-09-26 03:30:11', 14, 88, 2, '', 0);
INSERT INTO "article_articlepost" VALUES (30, '旅游', '承认物种多样性//@布丁薇HQ:心情如最右//@重生之我是龚俊老婆:图片评论 查看图片', '2022-09-26 03:30:11', '2022-09-26 03:30:11', 14, 62, 2, 'article/20190226/pic1.jpg', 1);
INSERT INTO "article_articlepost" VALUES (31, '香港', '香港（简称港，雅称香江；英语：Hong Kong，缩写作 HK、HKSAR）是中华人民共和国两个特别行政区之一，位于南海北岸、珠江口东侧，北接广东省深圳市，西面与邻近的澳门特别行政区相距63公里，其余两面与南海邻接。
香港全境由香港岛、九龙和新界组成，其中香港岛北最为发达；地理环境上则由九龙半岛等大陆土地、以及263个岛屿构成[5]，人口约741万人。
香港是世界上相当重要的国际金融、工商服务业及航运中心，连续24年蝉联全球最自由经济体，并凭治安优良、社会廉洁、税制简单和法律制度健全闻名于世，有“东方之珠”的美誉。在2018年GaWC公布的世界全球都市列表中，香港仅次于伦敦、纽约位列第三。“亚洲国际都会”则为官方定位的香港品牌。香港同时为全球首屈一指的安全、经济发达、生活富足、具竞争力、适宜居住以及人均寿命最长的大都会。', '2022-09-26 03:30:11', '2022-09-26 03:30:11', 14, 164, 1, 'article/20190226/12.jpg', 1);
INSERT INTO "article_articlepost" VALUES (32, '
初夏Studio
', '人是不可能停下来的，只有沿着自己的路继续走下去  ​​​', '2022-09-26 03:30:11', '2022-09-26 03:30:11', 14, 598, 3, 'article/20190226/4.jpg', 6);

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS "auth_group";
CREATE TABLE "auth_group" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "name" varchar(80) NOT NULL,
  UNIQUE ("name" ASC)
);

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS "auth_group_permissions";
CREATE TABLE "auth_group_permissions" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "group_id" integer NOT NULL,
  "permission_id" integer NOT NULL,
  FOREIGN KEY ("group_id") REFERENCES "auth_group" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  FOREIGN KEY ("permission_id") REFERENCES "auth_permission" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS "auth_permission";
CREATE TABLE "auth_permission" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "content_type_id" integer NOT NULL,
  "codename" varchar(100) NOT NULL,
  "name" varchar(255) NOT NULL,
  FOREIGN KEY ("content_type_id") REFERENCES "django_content_type" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO "auth_permission" VALUES (1, 1, 'add_logentry', 'Can add log entry');
INSERT INTO "auth_permission" VALUES (2, 1, 'change_logentry', 'Can change log entry');
INSERT INTO "auth_permission" VALUES (3, 1, 'delete_logentry', 'Can delete log entry');
INSERT INTO "auth_permission" VALUES (4, 1, 'view_logentry', 'Can view log entry');
INSERT INTO "auth_permission" VALUES (5, 2, 'add_permission', 'Can add permission');
INSERT INTO "auth_permission" VALUES (6, 2, 'change_permission', 'Can change permission');
INSERT INTO "auth_permission" VALUES (7, 2, 'delete_permission', 'Can delete permission');
INSERT INTO "auth_permission" VALUES (8, 2, 'view_permission', 'Can view permission');
INSERT INTO "auth_permission" VALUES (9, 3, 'add_group', 'Can add group');
INSERT INTO "auth_permission" VALUES (10, 3, 'change_group', 'Can change group');
INSERT INTO "auth_permission" VALUES (11, 3, 'delete_group', 'Can delete group');
INSERT INTO "auth_permission" VALUES (12, 3, 'view_group', 'Can view group');
INSERT INTO "auth_permission" VALUES (13, 4, 'add_user', 'Can add user');
INSERT INTO "auth_permission" VALUES (14, 4, 'change_user', 'Can change user');
INSERT INTO "auth_permission" VALUES (15, 4, 'delete_user', 'Can delete user');
INSERT INTO "auth_permission" VALUES (16, 4, 'view_user', 'Can view user');
INSERT INTO "auth_permission" VALUES (17, 5, 'add_contenttype', 'Can add content type');
INSERT INTO "auth_permission" VALUES (18, 5, 'change_contenttype', 'Can change content type');
INSERT INTO "auth_permission" VALUES (19, 5, 'delete_contenttype', 'Can delete content type');
INSERT INTO "auth_permission" VALUES (20, 5, 'view_contenttype', 'Can view content type');
INSERT INTO "auth_permission" VALUES (21, 6, 'add_session', 'Can add session');
INSERT INTO "auth_permission" VALUES (22, 6, 'change_session', 'Can change session');
INSERT INTO "auth_permission" VALUES (23, 6, 'delete_session', 'Can delete session');
INSERT INTO "auth_permission" VALUES (24, 6, 'view_session', 'Can view session');
INSERT INTO "auth_permission" VALUES (25, 7, 'add_article', 'Can add article');
INSERT INTO "auth_permission" VALUES (26, 7, 'change_article', 'Can change article');
INSERT INTO "auth_permission" VALUES (27, 7, 'delete_article', 'Can delete article');
INSERT INTO "auth_permission" VALUES (28, 7, 'view_article', 'Can view article');
INSERT INTO "auth_permission" VALUES (29, 7, 'add_articlepost', 'Can add article post');
INSERT INTO "auth_permission" VALUES (30, 7, 'change_articlepost', 'Can change article post');
INSERT INTO "auth_permission" VALUES (31, 7, 'delete_articlepost', 'Can delete article post');
INSERT INTO "auth_permission" VALUES (32, 7, 'view_articlepost', 'Can view article post');
INSERT INTO "auth_permission" VALUES (33, 8, 'add_profile', 'Can add profile');
INSERT INTO "auth_permission" VALUES (34, 8, 'change_profile', 'Can change profile');
INSERT INTO "auth_permission" VALUES (35, 8, 'delete_profile', 'Can delete profile');
INSERT INTO "auth_permission" VALUES (36, 8, 'view_profile', 'Can view profile');
INSERT INTO "auth_permission" VALUES (37, 9, 'add_comment', 'Can add comment');
INSERT INTO "auth_permission" VALUES (38, 9, 'change_comment', 'Can change comment');
INSERT INTO "auth_permission" VALUES (39, 9, 'delete_comment', 'Can delete comment');
INSERT INTO "auth_permission" VALUES (40, 9, 'view_comment', 'Can view comment');
INSERT INTO "auth_permission" VALUES (41, 10, 'add_articlecolumn', 'Can add article column');
INSERT INTO "auth_permission" VALUES (42, 10, 'change_articlecolumn', 'Can change article column');
INSERT INTO "auth_permission" VALUES (43, 10, 'delete_articlecolumn', 'Can delete article column');
INSERT INTO "auth_permission" VALUES (44, 10, 'view_articlecolumn', 'Can view article column');
INSERT INTO "auth_permission" VALUES (45, 11, 'add_tag', 'Can add Tag');
INSERT INTO "auth_permission" VALUES (46, 11, 'change_tag', 'Can change Tag');
INSERT INTO "auth_permission" VALUES (47, 11, 'delete_tag', 'Can delete Tag');
INSERT INTO "auth_permission" VALUES (48, 11, 'view_tag', 'Can view Tag');
INSERT INTO "auth_permission" VALUES (49, 12, 'add_taggeditem', 'Can add Tagged Item');
INSERT INTO "auth_permission" VALUES (50, 12, 'change_taggeditem', 'Can change Tagged Item');
INSERT INTO "auth_permission" VALUES (51, 12, 'delete_taggeditem', 'Can delete Tagged Item');
INSERT INTO "auth_permission" VALUES (52, 12, 'view_taggeditem', 'Can view Tagged Item');
INSERT INTO "auth_permission" VALUES (53, 13, 'add_notification', 'Can add notification');
INSERT INTO "auth_permission" VALUES (54, 13, 'change_notification', 'Can change notification');
INSERT INTO "auth_permission" VALUES (55, 13, 'delete_notification', 'Can delete notification');
INSERT INTO "auth_permission" VALUES (56, 13, 'view_notification', 'Can view notification');
INSERT INTO "auth_permission" VALUES (57, 14, 'add_site', 'Can add site');
INSERT INTO "auth_permission" VALUES (58, 14, 'change_site', 'Can change site');
INSERT INTO "auth_permission" VALUES (59, 14, 'delete_site', 'Can delete site');
INSERT INTO "auth_permission" VALUES (60, 14, 'view_site', 'Can view site');
INSERT INTO "auth_permission" VALUES (61, 15, 'add_emailaddress', 'Can add email address');
INSERT INTO "auth_permission" VALUES (62, 15, 'change_emailaddress', 'Can change email address');
INSERT INTO "auth_permission" VALUES (63, 15, 'delete_emailaddress', 'Can delete email address');
INSERT INTO "auth_permission" VALUES (64, 15, 'view_emailaddress', 'Can view email address');
INSERT INTO "auth_permission" VALUES (65, 16, 'add_emailconfirmation', 'Can add email confirmation');
INSERT INTO "auth_permission" VALUES (66, 16, 'change_emailconfirmation', 'Can change email confirmation');
INSERT INTO "auth_permission" VALUES (67, 16, 'delete_emailconfirmation', 'Can delete email confirmation');
INSERT INTO "auth_permission" VALUES (68, 16, 'view_emailconfirmation', 'Can view email confirmation');
INSERT INTO "auth_permission" VALUES (69, 17, 'add_socialaccount', 'Can add social account');
INSERT INTO "auth_permission" VALUES (70, 17, 'change_socialaccount', 'Can change social account');
INSERT INTO "auth_permission" VALUES (71, 17, 'delete_socialaccount', 'Can delete social account');
INSERT INTO "auth_permission" VALUES (72, 17, 'view_socialaccount', 'Can view social account');
INSERT INTO "auth_permission" VALUES (73, 18, 'add_socialapp', 'Can add social application');
INSERT INTO "auth_permission" VALUES (74, 18, 'change_socialapp', 'Can change social application');
INSERT INTO "auth_permission" VALUES (75, 18, 'delete_socialapp', 'Can delete social application');
INSERT INTO "auth_permission" VALUES (76, 18, 'view_socialapp', 'Can view social application');
INSERT INTO "auth_permission" VALUES (77, 19, 'add_socialtoken', 'Can add social application token');
INSERT INTO "auth_permission" VALUES (78, 19, 'change_socialtoken', 'Can change social application token');
INSERT INTO "auth_permission" VALUES (79, 19, 'delete_socialtoken', 'Can delete social application token');
INSERT INTO "auth_permission" VALUES (80, 19, 'view_socialtoken', 'Can view social application token');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS "auth_user";
CREATE TABLE "auth_user" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "password" varchar(128) NOT NULL,
  "last_login" datetime,
  "is_superuser" bool NOT NULL,
  "username" varchar(150) NOT NULL,
  "first_name" varchar(30) NOT NULL,
  "email" varchar(254) NOT NULL,
  "is_staff" bool NOT NULL,
  "is_active" bool NOT NULL,
  "date_joined" datetime NOT NULL,
  "last_name" varchar(150) NOT NULL,
  UNIQUE ("username" ASC)
);

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO "auth_user" VALUES (14, 'pbkdf2_sha256$120000$JqKJjHuOi5XN$kPIbYFTQmb8yg9aFwsj6iShZ9eMwEOoMeH4gVdYuW9k=', '2020-07-22 01:46:32.997737', 1, 'dusai', '', 'dusaiphoto@foxmail.com', 1, 1, '2022-09-27 06:46:15', '');
INSERT INTO "auth_user" VALUES (15, 'pbkdf2_sha256$120000$e4LwUuStYhir$5/YLNe+9YE735HI/eJeSaq63suuGeh1HfZ5KC730wDg=', '2019-06-04 12:52:01.850143', 0, 'diaowei', '', '', 0, 1, '2022-09-27 13:04:47.428357', '');

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS "auth_user_groups";
CREATE TABLE "auth_user_groups" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "user_id" integer NOT NULL,
  "group_id" integer NOT NULL,
  FOREIGN KEY ("user_id") REFERENCES "auth_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  FOREIGN KEY ("group_id") REFERENCES "auth_group" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS "auth_user_user_permissions";
CREATE TABLE "auth_user_user_permissions" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "user_id" integer NOT NULL,
  "permission_id" integer NOT NULL,
  FOREIGN KEY ("user_id") REFERENCES "auth_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  FOREIGN KEY ("permission_id") REFERENCES "auth_permission" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for comment_comment
-- ----------------------------
DROP TABLE IF EXISTS "comment_comment";
CREATE TABLE "comment_comment" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "body" text NOT NULL,
  "created" datetime NOT NULL,
  "article_id" integer NOT NULL,
  "user_id" integer NOT NULL,
  "reply_to_id" integer,
  "level" integer unsigned NOT NULL,
  "lft" integer unsigned NOT NULL,
  "rght" integer unsigned NOT NULL,
  "tree_id" integer unsigned NOT NULL,
  "parent_id" integer,
  FOREIGN KEY ("article_id") REFERENCES "article_articlepost" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  FOREIGN KEY ("user_id") REFERENCES "auth_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  FOREIGN KEY ("reply_to_id") REFERENCES "auth_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  FOREIGN KEY ("parent_id") REFERENCES "comment_comment" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Records of comment_comment
-- ----------------------------
INSERT INTO "comment_comment" VALUES (29, '<p>我是<strong>一级评论</strong>，是所有评论的<strong><span style="color:#e74c3c">树根</span></strong><img alt="laugh" height="23" src="http://127.0.0.1:8000/static/ckeditor/ckeditor/plugins/smiley/images/teeth_smile.png" title="laugh" width="23" /></p>', '202-05-04 11:29:23.009770', 20, 15, NULL, 0, 1, 8, 1, NULL);
INSERT INTO "comment_comment" VALUES (30, '<p>我是<strong>二级评论</strong></p>

<p>我评论给了<span style="color:#2980b9"><strong>diaowei</strong></span>同志<img alt="cheeky" height="23" src="http://127.0.0.1:8000/static/ckeditor/ckeditor/plugins/smiley/images/tongue_smile.png" title="cheeky" width="23" /></p>', '202-05-04 11:29:23.009770', 20, 14, 15, 1, 2, 3, 1, 29);
INSERT INTO "comment_comment" VALUES (31, '<p>我是<strong>三级评论</strong></p>

<p>评论给了<strong>二级评论</strong>中的<strong><span style="color:#8e44ad">dusai</span></strong>同志</p>

<p>但是我会被<span style="color:#16a085"><strong>强制转换</strong></span>为<strong>二级评论</strong><img alt="surprise" height="23" src="http://127.0.0.1:8000/static/ckeditor/ckeditor/plugins/smiley/images/omg_smile.png" title="surprise" width="23" /></p>', '202-05-04 11:29:23.009770', 20, 15, 14, 1, 4, 5, 1, 29);
INSERT INTO "comment_comment" VALUES (32, '<p><strong><span style="color:#c0392b">文章</span>写得很棒！</strong><img alt="laugh" height="23" src="http://127.0.0.1:8000/static/ckeditor/ckeditor/plugins/smiley/images/teeth_smile.png" title="laugh" width="23" /></p>', '202-05-04 11:29:23.009770', 32, 14, NULL, 0, 1, 32, 2, NULL);
INSERT INTO "comment_comment" VALUES (33, '<p><strong>赞同！</strong><img alt="yes" height="23" src="http://127.0.0.1:8000/static/ckeditor/ckeditor/plugins/smiley/images/thumbs_up.png" title="yes" width="23" /></p>', '202-05-04 11:29:23.009770', 32, 15, 14, 1, 2, 3, 2, 32);
INSERT INTO "comment_comment" VALUES (34, '<p>赞同+2<img alt="heart" height="23" src="http://127.0.0.1:8000/static/ckeditor/ckeditor/plugins/smiley/images/heart.png" title="heart" width="23" /></p>', '202-05-04 11:29:23.009770', 32, 15, 14, 1, 4, 5, 2, 32);
INSERT INTO "comment_comment" VALUES (35, '<p>通知功能也写好了<img alt="angel" height="23" src="http://127.0.0.1:8000/static/ckeditor/ckeditor/plugins/smiley/images/angel_smile.png" title="angel" width="23" /></p>', '202-05-04 11:29:23.009770', 20, 15, 14, 1, 6, 7, 1, 29);
INSERT INTO "comment_comment" VALUES (42, '<p>测试通知功能</p>', '202-05-04 11:29:23.009770', 32, 15, 14, 1, 18, 19, 2, 32);
INSERT INTO "comment_comment" VALUES (46, '<p><strong>所有留言</strong>都会给<strong>管理员</strong>发送通知</p>', '202-05-04 11:29:23.009770', 31, 14, NULL, 0, 1, 16, 3, NULL);
INSERT INTO "comment_comment" VALUES (47, '<p>本条也会给管理员发送通知</p>', '202-05-04 11:29:23.009770', 31, 15, NULL, 0, 1, 8, 4, NULL);
INSERT INTO "comment_comment" VALUES (48, '<p>二级评论不会给管理员重复发送通知</p>', '202-05-04 11:29:23.009770', 31, 15, 14, 1, 2, 3, 3, 46);
INSERT INTO "comment_comment" VALUES (49, '<p>评论给普通用户的通知<img alt="yes" height="23" src="http://127.0.0.1:8000/static/ckeditor/ckeditor/plugins/smiley/images/thumbs_up.png" title="yes" width="23" /></p>', '202-05-04 11:29:23.009770', 31, 14, 15, 1, 4, 5, 3, 46);
INSERT INTO "comment_comment" VALUES (50, '<p>一级评论也有通知</p>', '202-05-04 11:29:23.009770', 31, 14, 15, 1, 2, 3, 4, 47);
INSERT INTO "comment_comment" VALUES (90, '<p>测试评论锚点</p>', '202-05-04 11:29:23.009770', 32, 15, NULL, 0, 1, 4, 5, NULL);
INSERT INTO "comment_comment" VALUES (91, '<p><img alt="heart" height="23" src="http://127.0.0.1:8000/static/ckeditor/ckeditor/plugins/smiley/images/heart.png" title="heart" width="23" /></p>', '202-05-04 11:29:23.009770', 31, 15, NULL, 0, 1, 2, 6, NULL);
INSERT INTO "comment_comment" VALUES (92, '<p><img alt="yes" height="23" src="http://127.0.0.1:8000/static/ckeditor/ckeditor/plugins/smiley/images/thumbs_up.png" title="yes" width="23" /></p>', '202-05-04 11:29:23.009770', 32, 15, NULL, 0, 1, 2, 7, NULL);
INSERT INTO "comment_comment" VALUES (93, '<p><img alt="mail" height="23" src="http://127.0.0.1:8000/static/ckeditor/ckeditor/plugins/smiley/images/envelope.png" title="mail" width="23" /></p>', '202-05-04 11:29:23.009770', 30, 15, NULL, 0, 1, 6, 8, NULL);
INSERT INTO "comment_comment" VALUES (94, '<p>再次评论<img alt="devil" height="23" src="http://127.0.0.1:8000/static/ckeditor/ckeditor/plugins/smiley/images/devil_smile.png" title="devil" width="23" /></p>', '202-05-04 11:29:23.009770', 31, 15, NULL, 0, 1, 2, 9, NULL);
INSERT INTO "comment_comment" VALUES (95, '<p>嘿嘿~</p>', '202-05-04 11:29:23.009770', 30, 14, NULL, 0, 1, 2, 10, NULL);
INSERT INTO "comment_comment" VALUES (96, '<p><img alt="kiss" height="23" src="http://127.0.0.1:8000/static/ckeditor/ckeditor/plugins/smiley/images/kiss.png" title="kiss" width="23" /></p>', '202-05-04 11:29:23.009770', 30, 14, 15, 1, 2, 3, 8, 93);
INSERT INTO "comment_comment" VALUES (97, '<p><img alt="heart" height="23" src="http://127.0.0.1:8000/static/ckeditor/ckeditor/plugins/smiley/images/heart.png" title="heart" width="23" /></p>', '202-05-04 11:29:23.009770', 32, 15, NULL, 0, 1, 2, 11, NULL);
INSERT INTO "comment_comment" VALUES (98, '<p><img alt="angry" height="23" src="http://127.0.0.1:8000/static/ckeditor/ckeditor/plugins/smiley/images/angry_smile.png" title="angry" width="23" /></p>', '202-05-04 11:29:23.009770', 32, 15, 15, 1, 28, 29, 2, 32);
INSERT INTO "comment_comment" VALUES (99, '<p><img alt="angry" height="23" src="http://127.0.0.1:8000/static/ckeditor/ckeditor/plugins/smiley/images/angry_smile.png" title="angry" width="23" /></p>', '202-05-04 11:29:23.009770', 32, 15, 15, 1, 30, 31, 2, 32);
INSERT INTO "comment_comment" VALUES (100, '<p>赞同</p>', '202-05-04 11:29:23.009770', 30, 15, 14, 1, 4, 5, 8, 93);
INSERT INTO "comment_comment" VALUES (101, '<p>1</p>', '202-05-04 11:29:23.009770', 21, 15, NULL, 0, 1, 8, 12, NULL);
INSERT INTO "comment_comment" VALUES (102, '<p>2</p>', '202-05-04 11:29:23.009770', 21, 15, 15, 1, 2, 3, 12, 101);
INSERT INTO "comment_comment" VALUES (103, '<p>3</p>', '202-05-04 11:29:23.009770', 21, 14, 15, 1, 4, 5, 12, 101);
INSERT INTO "comment_comment" VALUES (104, '<p>4</p>', '202-05-04 11:29:23.009770', 21, 14, 14, 1, 6, 7, 12, 101);
INSERT INTO "comment_comment" VALUES (105, '<p>高级灰在水粉画中特指一个色系或一组色。 色彩经过调合纯度通常偏低给人的感觉和谐，而不是单独一个色。 因为色彩的运用关键在于搭配，没有一个色是独立存在。 高级灰柔和，平静，稳重，和谐，统一，不强烈，不刺眼，没有冲突，色彩内含的元素是复杂的而非单纯的。</p>', '202-05-04 11:29:23.009770', 32, 14, NULL, 0, 1, 2, 13, NULL);
INSERT INTO "comment_comment" VALUES (106, '<p>123</p>', '202-05-04 11:29:23.009770', 32, 14, 15, 1, 2, 3, 5, 90);

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS "django_admin_log";
CREATE TABLE "django_admin_log" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "action_time" datetime NOT NULL,
  "object_id" text,
  "object_repr" varchar(200) NOT NULL,
  "change_message" text NOT NULL,
  "content_type_id" integer,
  "user_id" integer NOT NULL,
  "action_flag" smallint unsigned NOT NULL,
  FOREIGN KEY ("content_type_id") REFERENCES "django_content_type" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  FOREIGN KEY ("user_id") REFERENCES "auth_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO "django_admin_log" VALUES (18, '202-05-04 11:29:23.009770', 14, 'dusai', '[{"changed": {"name": "profile", "object": "user dusai", "fields": ["bio"]}}]', 4, 14, 2);
INSERT INTO "django_admin_log" VALUES (19, '202-05-04 11:29:23.009770', 14, 'dusai', '[{"changed": {"name": "profile", "object": "user dusai", "fields": ["bio"]}}]', 4, 14, 2);
INSERT INTO "django_admin_log" VALUES (20, '202-05-04 11:29:23.009770', 14, 'dusai', '[{"changed": {"name": "profile", "object": "user dusai", "fields": ["bio"]}}]', 4, 14, 2);
INSERT INTO "django_admin_log" VALUES (21, '202-05-04 11:29:23.009770', 20, '测试md文章', '[{"changed": {"fields": ["title", "body"]}}]', 7, 14, 2);
INSERT INTO "django_admin_log" VALUES (22, '202-05-04 11:29:23.009770', 15, 'diaowei', '[{"added": {}}]', 4, 14, 1);
INSERT INTO "django_admin_log" VALUES (23, '202-05-04 11:29:23.009770', 1, 'Django', '[{"added": {}}]', 10, 14, 1);
INSERT INTO "django_admin_log" VALUES (24, '202-05-04 11:29:23.009770', 2, 'Java', '[{"added": {}}]', 10, 14, 1);
INSERT INTO "django_admin_log" VALUES (25, '202-05-04 11:29:23.009770', 3, 'HTML', '[{"added": {}}]', 10, 14, 1);
INSERT INTO "django_admin_log" VALUES (26, '202-05-04 11:29:23.009770', 26, '测试类视图创建文章', '[]', 7, 14, 2);
INSERT INTO "django_admin_log" VALUES (27, '202-05-04 11:29:23.009770', 26, '测试类视图创建文章', '[{"changed": {"fields": ["column"]}}]', 7, 14, 2);
INSERT INTO "django_admin_log" VALUES (28, '202-05-04 11:29:23.009770', 25, '测试搜索功能', '[{"changed": {"fields": ["column"]}}]', 7, 14, 2);
INSERT INTO "django_admin_log" VALUES (29, '202-05-04 11:29:23.009770', 24, 'Java 编程语言', '[{"changed": {"fields": ["column"]}}]', 7, 14, 2);
INSERT INTO "django_admin_log" VALUES (30, '202-05-04 11:29:23.009770', 26, '测试类视图创建文章', '[{"changed": {"fields": ["tags"]}}]', 7, 14, 2);
INSERT INTO "django_admin_log" VALUES (31, '202-05-04 11:29:23.009770', 20, '书写md文章', '[{"changed": {"fields": ["title", "body", "tags"]}}]', 7, 14, 2);
INSERT INTO "django_admin_log" VALUES (32, '202-05-04 11:29:23.009770', 20, '书写md文章', '[{"changed": {"fields": ["body", "tags"]}}]', 7, 14, 2);
INSERT INTO "django_admin_log" VALUES (33, '202-05-04 11:29:23.009770', 20, '书写md文章', '[{"changed": {"fields": ["body", "tags"]}}]', 7, 14, 2);
INSERT INTO "django_admin_log" VALUES (34, '202-05-04 11:29:23.009770', 14, 'dusai', '[]', 4, 14, 2);
INSERT INTO "django_admin_log" VALUES (35, '202-05-04 11:29:23.009770', 14, 'dusai', '[{"changed": {"name": "profile", "object": "user dusai", "fields": ["avatar"]}}]', 4, 14, 2);
INSERT INTO "django_admin_log" VALUES (36, '202-05-04 11:29:23.009770', 14, 'dusai', '[]', 4, 14, 2);
INSERT INTO "django_admin_log" VALUES (37, '202-05-04 11:29:23.009770', 14, 'dusai', '[]', 4, 14, 2);
INSERT INTO "django_admin_log" VALUES (38, '202-05-04 11:29:23.009770', 33, 1, '[{"added": {}}]', 7, 14, 1);
INSERT INTO "django_admin_log" VALUES (39, '202-05-04 11:29:23.009770', 33, 1, '', 7, 14, 3);
INSERT INTO "django_admin_log" VALUES (40, '202-05-04 11:29:23.009770', 1, '<h2><strong>我一定要学好Dj', '[{"changed": {"fields": ["body"]}}]', 9, 14, 2);
INSERT INTO "django_admin_log" VALUES (41, '202-05-04 11:29:23.009770', 1, '<h2><strong>我一定要学好Dj', '[]', 9, 14, 2);
INSERT INTO "django_admin_log" VALUES (42, '202-05-04 11:29:23.009770', 1, '<div><strong>我一定要学好D', '[{"changed": {"fields": ["body"]}}]', 9, 14, 2);
INSERT INTO "django_admin_log" VALUES (43, '202-05-04 11:29:23.009770', 1, '<p><strong>我一定要学好Dja', '[{"changed": {"fields": ["body"]}}]', 9, 14, 2);
INSERT INTO "django_admin_log" VALUES (44, '202-05-04 11:29:23.009770', 1, '<p><strong>我一定要学好Dja', '[{"changed": {"fields": ["body"]}}]', 9, 14, 2);
INSERT INTO "django_admin_log" VALUES (45, '202-05-04 11:29:23.009770', 16, 'testname', '', 4, 14, 3);
INSERT INTO "django_admin_log" VALUES (46, '202-05-04 11:29:23.009770', 17, 'testname', '[{"added": {}}]', 4, 14, 1);
INSERT INTO "django_admin_log" VALUES (47, '202-05-04 11:29:23.009770', 18, 'testname2', '[{"added": {}}]', 4, 14, 1);
INSERT INTO "django_admin_log" VALUES (48, '202-05-04 11:29:23.009770', 18, 'testname2', '[{"changed": {"name": "profile", "object": "user testname2", "fields": ["phone"]}}]', 4, 14, 2);
INSERT INTO "django_admin_log" VALUES (49, '202-05-04 11:29:23.009770', 18, 'testname2', '[{"changed": {"name": "profile", "object": "user testname2", "fields": ["bio"]}}]', 4, 14, 2);
INSERT INTO "django_admin_log" VALUES (50, '202-05-04 11:29:23.009770', 19, 'testname3', '[{"added": {}}, {"added": {"name": "profile", "object": "user testname3"}}]', 4, 14, 1);
INSERT INTO "django_admin_log" VALUES (51, '202-05-04 11:29:23.009770', 20, 'testname4', '[{"added": {}}, {"added": {"name": "profile", "object": "user testname4"}}]', 4, 14, 1);
INSERT INTO "django_admin_log" VALUES (52, '202-05-04 11:29:23.009770', 36, '<p>哈哈</p>', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (53, '202-05-04 11:29:23.009770', 37, '<p>谢谢</p>', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (54, '202-05-04 11:29:23.009770', 38, '<p>继续测试<img alt="lau', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (55, '202-05-04 11:29:23.009770', 39, '<p>一切正常<img alt="ind', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (56, '202-05-04 11:29:23.009770', 40, '<p>1</p>', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (57, '202-05-04 11:29:23.009770', 41, '<p>2</p>', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (58, '202-05-04 11:29:23.009770', 43, '<p>第二次测试<img alt="la', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (59, '202-05-04 11:29:23.009770', 17, 'testname', '', 4, 14, 3);
INSERT INTO "django_admin_log" VALUES (60, '202-05-04 11:29:23.009770', 18, 'testname2', '', 4, 14, 3);
INSERT INTO "django_admin_log" VALUES (61, '202-05-04 11:29:23.009770', 19, 'testname3', '', 4, 14, 3);
INSERT INTO "django_admin_log" VALUES (62, '202-05-04 11:29:23.009770', 20, 'testname4', '', 4, 14, 3);
INSERT INTO "django_admin_log" VALUES (63, '202-05-04 11:29:23.009770', 14, 'dusai', '[{"changed": {"fields": ["password"]}}]', 4, 14, 2);
INSERT INTO "django_admin_log" VALUES (64, '202-05-04 11:29:23.009770', 15, 'diaowei', '[{"changed": {"fields": ["password"]}}]', 4, 14, 2);
INSERT INTO "django_admin_log" VALUES (65, '202-05-04 11:29:23.009770', 14, 'dusai', '[{"changed": {"fields": ["password"]}}]', 4, 14, 2);
INSERT INTO "django_admin_log" VALUES (66, '202-05-04 11:29:23.009770', 58, '<p>test again<img al', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (67, '202-05-04 11:29:23.009770', 64, '<p><img alt="heart" ', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (68, '202-05-04 11:29:23.009770', 65, '<p><img alt="angel" ', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (69, '202-05-04 11:29:23.009770', 66, '<p><img alt="crying"', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (70, '202-05-04 11:29:23.009770', 68, '<p><img alt="frown" ', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (71, '202-05-04 11:29:23.009770', 69, '<p><img alt="enlight', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (72, '202-05-04 11:29:23.009770', 70, '<p><img alt="surpris', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (73, '202-05-04 11:29:23.009770', 71, '<p><img alt="surpris', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (74, '202-05-04 11:29:23.009770', 72, '<p><img alt="angry" ', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (75, '202-05-04 11:29:23.009770', 73, '<p><img alt="angel" ', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (76, '202-05-04 11:29:23.009770', 74, '<p>灯泡后面~</p>', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (77, '202-05-04 11:29:23.009770', 75, '<p>托尔斯泰</p>', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (78, '202-05-04 11:29:23.009770', 76, '<p>111</p>', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (79, '202-05-04 11:29:23.009770', 77, '<p>222</p>', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (80, '202-05-04 11:29:23.009770', 78, '<p>222</p>', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (81, '202-05-04 11:29:23.009770', 79, '<p>333</p>', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (82, '202-05-04 11:29:23.009770', 80, '<p>333</p>', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (83, '202-05-04 11:29:23.009770', 81, '<p>444</p>', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (84, '202-05-04 11:29:23.009770', 82, '<p>多对多</p>', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (85, '202-05-04 11:29:23.009770', 83, '<p>啊啊啊</p>', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (86, '202-05-04 11:29:23.009770', 84, '<p>111</p>', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (87, '202-05-04 11:29:23.009770', 85, '<p>暗暗</p>', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (88, '202-05-04 11:29:23.009770', 67, '<p><img alt="laugh" ', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (89, '202-05-04 11:29:23.009770', 57, '<p><img alt="yes" he', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (90, '202-05-04 11:29:23.009770', 62, '<p>测试评论后跳转锚点</p>', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (91, '202-05-04 11:29:23.009770', 63, '<p>test again</p>', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (92, '202-05-04 11:29:23.009770', 52, '<p><img alt="cool" h', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (93, '202-05-04 11:29:23.009770', 53, '<p>回复给自己<img alt="su', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (94, '202-05-04 11:29:23.009770', 44, '<p>继续测试</p>', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (95, '202-05-04 11:29:23.009770', 45, '<p>最后一次</p>', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (96, '202-05-04 11:29:23.009770', 61, '<p><img alt="yes" he', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (97, '202-05-04 11:29:23.009770', 56, '<p><img alt="mail" h', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (98, '202-05-04 11:29:23.009770', 59, '<p>测试锚点功能</p>', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (99, '202-05-04 11:29:23.009770', 60, '<p>测试锚点功能2</p>', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (100, '202-05-04 11:29:23.009770', 88, '<p>的孙菲菲</p>', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (101, '202-05-04 11:29:23.009770', 89, '<p><img alt="cheeky"', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (102, '202-05-04 11:29:23.009770', 86, '<p>123</p>', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (103, '202-05-04 11:29:23.009770', 87, '<p>哎哎哎</p>', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (104, '202-05-04 11:29:23.009770', 51, '<p><img alt="heart" ', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (105, '202-05-04 11:29:23.009770', 54, '<p>回复给博主哟</p>', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (106, '202-05-04 11:29:23.009770', 55, '<p>嘿嘿~</p>', '', 9, 14, 3);
INSERT INTO "django_admin_log" VALUES (107, '202-05-04 11:29:23.009770', 14, 'dusai', '[{"changed": {"name": "profile", "object": "user dusai", "fields": ["phone"]}}]', 4, 14, 2);
INSERT INTO "django_admin_log" VALUES (108, '202-05-04 11:29:23.009770', 21, 'test', '[{"added": {}}]', 4, 14, 1);
INSERT INTO "django_admin_log" VALUES (109, '202-05-04 11:29:23.009770', 21, 'test', '', 4, 14, 3);
INSERT INTO "django_admin_log" VALUES (110, '202-05-04 11:29:23.009770', 22, 'test', '[{"added": {}}, {"added": {"name": "profile", "object": "user test"}}]', 4, 14, 1);
INSERT INTO "django_admin_log" VALUES (111, '202-05-04 11:29:23.009770', 22, 'test', '[{"changed": {"name": "profile", "object": "user test", "fields": ["phone"]}}]', 4, 14, 2);
INSERT INTO "django_admin_log" VALUES (112, '202-05-04 11:29:23.009770', 23, 'test2', '[{"added": {}}, {"added": {"name": "profile", "object": "user test2"}}]', 4, 14, 1);
INSERT INTO "django_admin_log" VALUES (113, '202-05-04 11:29:23.009770', 23, 'test2', '[{"changed": {"name": "profile", "object": "user test2", "fields": ["phone"]}}]', 4, 14, 2);
INSERT INTO "django_admin_log" VALUES (114, '202-05-04 11:29:23.009770', 22, 'test', '[]', 4, 14, 2);
INSERT INTO "django_admin_log" VALUES (115, '202-05-04 11:29:23.009770', 22, 'test', '[]', 4, 14, 2);
INSERT INTO "django_admin_log" VALUES (116, '202-05-04 11:29:23.009770', 14, 'dusai', '[]', 4, 14, 2);
INSERT INTO "django_admin_log" VALUES (117, '202-05-04 11:29:23.009770', 24, 'test3', '[{"added": {}}, {"added": {"name": "profile", "object": "user test3"}}]', 4, 14, 1);
INSERT INTO "django_admin_log" VALUES (118, '202-05-04 11:29:23.009770', 24, 'test3', '[]', 4, 14, 2);
INSERT INTO "django_admin_log" VALUES (119, '202-05-04 11:29:23.009770', 14, 'dusai', '[]', 4, 14, 2);
INSERT INTO "django_admin_log" VALUES (120, '202-05-04 11:29:23.009770', 14, 'dusai', '[]', 4, 14, 2);
INSERT INTO "django_admin_log" VALUES (121, '202-05-04 11:29:23.009770', 14, 'dusai', '[{"changed": {"name": "profile", "object": "user dusai", "fields": ["phone"]}}]', 4, 14, 2);
INSERT INTO "django_admin_log" VALUES (122, '202-05-04 11:29:23.009770', 14, 'dusai', '[{"changed": {"name": "profile", "object": "user dusai", "fields": ["phone"]}}]', 4, 14, 2);
INSERT INTO "django_admin_log" VALUES (123, '202-05-04 11:29:23.009770', 14, 'dusai', '[]', 4, 14, 2);
INSERT INTO "django_admin_log" VALUES (124, '202-05-04 11:29:23.009770', 25, 'test7', '[{"added": {}}, {"added": {"name": "profile", "object": "user test7"}}]', 4, 14, 1);
INSERT INTO "django_admin_log" VALUES (125, '202-05-04 11:29:23.009770', 14, 'dusai', '[{"changed": {"name": "profile", "object": "user dusai", "fields": ["phone"]}}]', 4, 14, 2);
INSERT INTO "django_admin_log" VALUES (126, '202-05-04 11:29:23.009770', 14, 'dusai', '[{"changed": {"name": "profile", "object": "user dusai", "fields": ["phone"]}}]', 4, 14, 2);
INSERT INTO "django_admin_log" VALUES (127, '202-05-04 11:29:23.009770', 28, 'test10', '[{"added": {}}, {"added": {"name": "profile", "object": "user test10"}}]', 4, 14, 1);
INSERT INTO "django_admin_log" VALUES (128, '202-05-04 11:29:23.009770', 22, 'test', '', 4, 14, 3);
INSERT INTO "django_admin_log" VALUES (129, '202-05-04 11:29:23.009770', 28, 'test10', '', 4, 14, 3);
INSERT INTO "django_admin_log" VALUES (130, '202-05-04 11:29:23.009770', 23, 'test2', '', 4, 14, 3);
INSERT INTO "django_admin_log" VALUES (131, '202-05-04 11:29:23.009770', 24, 'test3', '', 4, 14, 3);
INSERT INTO "django_admin_log" VALUES (132, '202-05-04 11:29:23.009770', 25, 'test7', '', 4, 14, 3);
INSERT INTO "django_admin_log" VALUES (133, '202-05-04 11:29:23.009770', 26, 'test8', '', 4, 14, 3);
INSERT INTO "django_admin_log" VALUES (134, '202-05-04 11:29:23.009770', 27, 'test9', '', 4, 14, 3);
INSERT INTO "django_admin_log" VALUES (135, '202-05-04 11:29:23.009770', 31, 'test', '[{"added": {}}]', 4, 14, 1);
INSERT INTO "django_admin_log" VALUES (136, '202-05-04 11:29:23.009770', 32, 'test1', '[{"added": {}}, {"added": {"name": "profile", "object": "user test1"}}]', 4, 14, 1);
INSERT INTO "django_admin_log" VALUES (137, '202-05-04 11:29:23.009770', 1, 'http://127.0.0.1:8000', '[{"changed": {"fields": ["domain", "name"]}}]', 14, 14, 2);
INSERT INTO "django_admin_log" VALUES (138, '202-05-04 11:29:23.009770', 1, 'GitHub', '[{"added": {}}]', 18, 14, 1);
INSERT INTO "django_admin_log" VALUES (139, '202-05-04 11:29:23.009770', 1, 'GitHub', '[{"changed": {"fields": ["sites"]}}]', 18, 14, 2);
INSERT INTO "django_admin_log" VALUES (140, '202-05-04 11:29:23.009770', 40, 'dusaiphoto', '', 4, 14, 3);
INSERT INTO "django_admin_log" VALUES (141, '202-05-04 11:29:23.009770', 39, 'test100', '', 4, 14, 3);
INSERT INTO "django_admin_log" VALUES (142, '202-05-04 11:29:23.009770', 35, 'test30', '', 4, 14, 3);
INSERT INTO "django_admin_log" VALUES (143, '202-05-04 11:29:23.009770', 36, 'test35', '', 4, 14, 3);
INSERT INTO "django_admin_log" VALUES (144, '202-05-04 11:29:23.009770', 37, 'test40', '', 4, 14, 3);
INSERT INTO "django_admin_log" VALUES (145, '202-05-04 11:29:23.009770', 38, 'test45', '', 4, 14, 3);
INSERT INTO "django_admin_log" VALUES (146, '202-05-04 11:29:23.009770', 1, 'GitHub', '[{"changed": {"fields": ["client_id", "secret"]}}]', 18, 14, 2);

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS "django_content_type";
CREATE TABLE "django_content_type" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "app_label" varchar(100) NOT NULL,
  "model" varchar(100) NOT NULL
);

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO "django_content_type" VALUES (1, 'admin', 'logentry');
INSERT INTO "django_content_type" VALUES (2, 'auth', 'permission');
INSERT INTO "django_content_type" VALUES (3, 'auth', 'group');
INSERT INTO "django_content_type" VALUES (4, 'auth', 'user');
INSERT INTO "django_content_type" VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO "django_content_type" VALUES (6, 'sessions', 'session');
INSERT INTO "django_content_type" VALUES (7, 'article', 'articlepost');
INSERT INTO "django_content_type" VALUES (8, 'userprofile', 'profile');
INSERT INTO "django_content_type" VALUES (9, 'comment', 'comment');
INSERT INTO "django_content_type" VALUES (10, 'article', 'articlecolumn');
INSERT INTO "django_content_type" VALUES (11, 'taggit', 'tag');
INSERT INTO "django_content_type" VALUES (12, 'taggit', 'taggeditem');
INSERT INTO "django_content_type" VALUES (13, 'notifications', 'notification');
INSERT INTO "django_content_type" VALUES (14, 'sites', 'site');
INSERT INTO "django_content_type" VALUES (15, 'account', 'emailaddress');
INSERT INTO "django_content_type" VALUES (16, 'account', 'emailconfirmation');
INSERT INTO "django_content_type" VALUES (17, 'socialaccount', 'socialaccount');
INSERT INTO "django_content_type" VALUES (18, 'socialaccount', 'socialapp');
INSERT INTO "django_content_type" VALUES (19, 'socialaccount', 'socialtoken');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS "django_migrations";
CREATE TABLE "django_migrations" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "app" varchar(255) NOT NULL,
  "name" varchar(255) NOT NULL,
  "applied" datetime NOT NULL
);

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO "django_migrations" VALUES (1, 'contenttypes', '0001_initial', '2018-08-24 16:15:59.823541');
INSERT INTO "django_migrations" VALUES (2, 'auth', '0001_initial', '2018-08-24 16:16:00.017266');
INSERT INTO "django_migrations" VALUES (3, 'admin', '0001_initial', '2018-08-24 16:16:00.210379');
INSERT INTO "django_migrations" VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2018-08-24 16:16:00.402857');
INSERT INTO "django_migrations" VALUES (5, 'admin', '0003_logentry_add_action_flag_choices', '2018-08-24 16:16:00.594019');
INSERT INTO "django_migrations" VALUES (6, 'article', '0001_initial', '2018-08-24 16:16:00.773390');
INSERT INTO "django_migrations" VALUES (7, 'contenttypes', '0002_remove_content_type_name', '2018-08-24 16:16:00.977909');
INSERT INTO "django_migrations" VALUES (8, 'auth', '0002_alter_permission_name_max_length', '2018-08-24 16:16:01.159607');
INSERT INTO "django_migrations" VALUES (9, 'auth', '0003_alter_user_email_max_length', '2018-08-24 16:16:01.351088');
INSERT INTO "django_migrations" VALUES (10, 'auth', '0004_alter_user_username_opts', '2018-08-24 16:16:01.564144');
INSERT INTO "django_migrations" VALUES (11, 'auth', '0005_alter_user_last_login_null', '2018-08-24 16:16:01.745629');
INSERT INTO "django_migrations" VALUES (12, 'auth', '0006_require_contenttypes_0002', '2018-08-24 16:16:01.831089');
INSERT INTO "django_migrations" VALUES (13, 'auth', '0007_alter_validators_add_error_messages', '2018-08-24 16:16:02.038549');
INSERT INTO "django_migrations" VALUES (14, 'auth', '0008_alter_user_username_max_length', '2018-08-24 16:16:02.240057');
INSERT INTO "django_migrations" VALUES (15, 'auth', '0009_alter_user_last_name_max_length', '2018-08-24 16:16:02.421124');
INSERT INTO "django_migrations" VALUES (16, 'sessions', '0001_initial', '2018-08-24 16:16:02.591212');
INSERT INTO "django_migrations" VALUES (17, 'article', '0002_auto_20180830_1759', '2018-08-30 09:59:46.963015');
INSERT INTO "django_migrations" VALUES (18, 'userprofile', '0001_initial', '2018-12-04 06:28:12.814777');
INSERT INTO "django_migrations" VALUES (19, 'article', '0003_articlepost_total_views', '2018-12-27 12:41:44.992625');
INSERT INTO "django_migrations" VALUES (20, 'userprofile', '0002_auto_20181227_2041', '2018-12-27 12:41:45.195723');
INSERT INTO "django_migrations" VALUES (21, 'comment', '0001_initial', '2018-12-31 14:25:08.363062');
INSERT INTO "django_migrations" VALUES (22, 'article', '0004_auto_20190129_1839', '2019-01-29 10:39:51.717688');
INSERT INTO "django_migrations" VALUES (23, 'taggit', '0001_initial', '2019-02-02 08:09:40.857658');
INSERT INTO "django_migrations" VALUES (24, 'taggit', '0002_auto_20150616_2121', '2019-02-02 08:09:41.127381');
INSERT INTO "django_migrations" VALUES (25, 'article', '0005_articlepost_tags', '2019-02-02 08:09:41.328110');
INSERT INTO "django_migrations" VALUES (26, 'article', '0006_articlepost_avatar', '2019-02-25 12:08:06.953402');
INSERT INTO "django_migrations" VALUES (27, 'article', '0007_auto_20190226_1939', '2019-02-26 11:39:40.821114');
INSERT INTO "django_migrations" VALUES (28, 'article', '0008_auto_20190226_1942', '2019-02-26 11:42:07.914077');
INSERT INTO "django_migrations" VALUES (29, 'comment', '0002_auto_20190318_2051', '2019-03-18 12:51:39.927476');
INSERT INTO "django_migrations" VALUES (30, 'comment', '0003_auto_20190502_2043', '2019-05-02 12:44:49.343963');
INSERT INTO "django_migrations" VALUES (31, 'comment', '0004_auto_20190502_2050', '2019-05-02 12:50:39.475867');
INSERT INTO "django_migrations" VALUES (32, 'comment', '0005_auto_20190503_1657', '2019-05-03 08:57:53.811305');
INSERT INTO "django_migrations" VALUES (33, 'notifications', '0001_initial', '2019-05-15 11:45:05.180828');
INSERT INTO "django_migrations" VALUES (34, 'notifications', '0002_auto_20150224_1134', '2019-05-15 11:45:05.403467');
INSERT INTO "django_migrations" VALUES (35, 'notifications', '0003_notification_data', '2019-05-15 11:45:05.596452');
INSERT INTO "django_migrations" VALUES (36, 'notifications', '0004_auto_20150826_1508', '2019-05-15 11:45:05.836814');
INSERT INTO "django_migrations" VALUES (37, 'notifications', '0005_auto_20160504_1520', '2019-05-15 11:45:06.037691');
INSERT INTO "django_migrations" VALUES (38, 'notifications', '0006_indexes', '2019-05-15 11:45:06.263936');
INSERT INTO "django_migrations" VALUES (39, 'account', '0001_initial', '2019-06-20 11:24:09.768106');
INSERT INTO "django_migrations" VALUES (40, 'account', '0002_email_max_length', '2019-06-20 11:24:10.174250');
INSERT INTO "django_migrations" VALUES (41, 'sites', '0001_initial', '2019-06-20 11:24:10.470691');
INSERT INTO "django_migrations" VALUES (42, 'sites', '0002_alter_domain_unique', '2019-06-20 11:24:10.908040');
INSERT INTO "django_migrations" VALUES (43, 'socialaccount', '0001_initial', '2019-06-20 11:24:11.329962');
INSERT INTO "django_migrations" VALUES (44, 'socialaccount', '0002_token_max_lengths', '2019-06-20 11:24:11.792323');
INSERT INTO "django_migrations" VALUES (45, 'socialaccount', '0003_extra_data_default_dict', '2019-06-20 11:24:12.229727');
INSERT INTO "django_migrations" VALUES (46, 'article', '0009_articlepost_likes', '2019-09-04 14:51:16.221706');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS "django_session";
CREATE TABLE "django_session" (
  "session_key" varchar(40) NOT NULL,
  "session_data" text NOT NULL,
  "expire_date" datetime NOT NULL,
  PRIMARY KEY ("session_key")
);

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO "django_session" VALUES ('mhu31qsr7u8nbfkc9wttqlvznxx5qpvs', 'YTRhODkxNTVlOTNkOWQwN2UyMDIwZmQzZDdhNGM2MDNlMDNkYzFkODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3NzU3NzBhZjBjNjBjMGUyM2M5ZjFhZjc3ZjM4Y2MzY2Q2MjIxYzg3In0=', '2018-09-20 10:53:28.732918');
INSERT INTO "django_session" VALUES ('s8a1garqj0f7r5kx5jamge7kjzbfs1qx', 'YTRhODkxNTVlOTNkOWQwN2UyMDIwZmQzZDdhNGM2MDNlMDNkYzFkODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3NzU3NzBhZjBjNjBjMGUyM2M5ZjFhZjc3ZjM4Y2MzY2Q2MjIxYzg3In0=', '2018-10-01 12:01:08.638346');
INSERT INTO "django_session" VALUES ('bnc405cal1wr7hjr2pl7txeyhbtojwkx', 'ZDdiMmQzM2QwNGNhZDFmN2M5ZjJmYmY2NDliY2U3ZTc3Mjg0YzcwZjp7Il9hdXRoX3VzZXJfaWQiOiIxMyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMzVkMWFiYjE5MTgzZTJiN2MwYjM0NDNkNjZmYzZiZjlhZTg4OTQ3ZSJ9', '2018-11-18 09:59:14.793309');
INSERT INTO "django_session" VALUES ('h2az7ueg8c9ha4f9a3wdbonje2znmstr', 'YWY3M2FmMjM5ZDE2MTA4MGMxNzQ1NjQ5MjliMWI4NmMzYTE5ZTFiNTp7fQ==', '2018-12-18 06:36:22.371244');
INSERT INTO "django_session" VALUES ('4fz9xc79kc4leyzxaxpqrfxb4itdlk09', 'YWY3M2FmMjM5ZDE2MTA4MGMxNzQ1NjQ5MjliMWI4NmMzYTE5ZTFiNTp7fQ==', '2018-12-18 06:36:36.939301');
INSERT INTO "django_session" VALUES ('uotsc70tan04x280xzhiho7lvypccrqh', 'MWEyZTdiZTJmN2NhZWU2NjkyMjVhYWU5MzdlZDI2ZGQwMzFjNWExOTp7Il9hdXRoX3VzZXJfaWQiOiIxNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZTVlMWEyYWE0MmYyMjVkNjYyZGY2Yjk4N2EzZWVmMzAwY2FhMjc5YyJ9', '2018-12-18 13:48:57.782448');
INSERT INTO "django_session" VALUES ('yi0cacfogvs81oqeg1arv2dsusjlh99l', 'MWEyZTdiZTJmN2NhZWU2NjkyMjVhYWU5MzdlZDI2ZGQwMzFjNWExOTp7Il9hdXRoX3VzZXJfaWQiOiIxNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZTVlMWEyYWE0MmYyMjVkNjYyZGY2Yjk4N2EzZWVmMzAwY2FhMjc5YyJ9', '2019-01-02 12:34:02.690764');
INSERT INTO "django_session" VALUES ('nhndt5vptyz2ho2cn18mzkkmyxux08k1', 'MWEyZTdiZTJmN2NhZWU2NjkyMjVhYWU5MzdlZDI2ZGQwMzFjNWExOTp7Il9hdXRoX3VzZXJfaWQiOiIxNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZTVlMWEyYWE0MmYyMjVkNjYyZGY2Yjk4N2EzZWVmMzAwY2FhMjc5YyJ9', '2019-01-15 03:19:16.397384');
INSERT INTO "django_session" VALUES ('k73hi96ts08inyhfa35nw7xnfddp98mv', 'MWEyZTdiZTJmN2NhZWU2NjkyMjVhYWU5MzdlZDI2ZGQwMzFjNWExOTp7Il9hdXRoX3VzZXJfaWQiOiIxNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZTVlMWEyYWE0MmYyMjVkNjYyZGY2Yjk4N2EzZWVmMzAwY2FhMjc5YyJ9', '2019-02-12 10:43:22.162285');
INSERT INTO "django_session" VALUES ('usa4w3yrcufy0bytej64pt6m07wgxgye', 'MWEyZTdiZTJmN2NhZWU2NjkyMjVhYWU5MzdlZDI2ZGQwMzFjNWExOTp7Il9hdXRoX3VzZXJfaWQiOiIxNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZTVlMWEyYWE0MmYyMjVkNjYyZGY2Yjk4N2EzZWVmMzAwY2FhMjc5YyJ9', '2019-02-26 14:09:19.154661');
INSERT INTO "django_session" VALUES ('28vqeajj3y0zy3q0mezydp3u9e1njc7i', 'MWEyZTdiZTJmN2NhZWU2NjkyMjVhYWU5MzdlZDI2ZGQwMzFjNWExOTp7Il9hdXRoX3VzZXJfaWQiOiIxNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZTVlMWEyYWE0MmYyMjVkNjYyZGY2Yjk4N2EzZWVmMzAwY2FhMjc5YyJ9', '2019-03-11 12:05:34.668467');
INSERT INTO "django_session" VALUES ('225ywalfzw79uyt7d4ogpnit2yjahhei', 'MWEyZTdiZTJmN2NhZWU2NjkyMjVhYWU5MzdlZDI2ZGQwMzFjNWExOTp7Il9hdXRoX3VzZXJfaWQiOiIxNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZTVlMWEyYWE0MmYyMjVkNjYyZGY2Yjk4N2EzZWVmMzAwY2FhMjc5YyJ9', '2019-04-01 12:52:37.044501');
INSERT INTO "django_session" VALUES ('7rn6jg4ez8ozt0gphki6e53a8zzxwl4u', 'MWEyZTdiZTJmN2NhZWU2NjkyMjVhYWU5MzdlZDI2ZGQwMzFjNWExOTp7Il9hdXRoX3VzZXJfaWQiOiIxNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZTVlMWEyYWE0MmYyMjVkNjYyZGY2Yjk4N2EzZWVmMzAwY2FhMjc5YyJ9', '2019-05-05 12:20:33.943905');
INSERT INTO "django_session" VALUES ('sd3dm23el77w8uyo6pt0794b759cw3jt', 'OTkzOTEzZWUyNmYwYWFmOTFlNmQxN2RiMzA5YTMwZjgxNzBlN2U4Nzp7Il9hdXRoX3VzZXJfaWQiOiIxNSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMGEzZTQ1ZDdlYzc2Y2M1ZjY1NTQ0NzRmN2Q1NmQ3MWRjZTRjNTM0NSJ9', '2019-05-18 11:33:05.614486');
INSERT INTO "django_session" VALUES ('k0txdr1cj4dfp8fglktqmzs6ea7aii3x', 'NjkzMGEyZjVmNzcxNDM3OTYzYTM5Y2Y2NzU4MTQzOTRlZjE3NDllMDp7Il9hdXRoX3VzZXJfaWQiOiIxNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZWQxNzQyYzBjOGVjZGFhMmYxYTAxMzRlOGJiOWUyMjFmNGI5ZTFlMCJ9', '2019-06-01 11:00:00.994638');
INSERT INTO "django_session" VALUES ('fzan27qeml8dgka7zjsh4tyudldz40wt', 'YzMxZDQwZmYwYzQ5OTVmMmE0NDBiZTU2NzNiYmY5M2M1YmUzODA3Yjp7Il9hdXRoX3VzZXJfaWQiOiIxNSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMjE4NTljOTg3YzJiNTZlOTRiNGJmOTA0MGYzNmQyMjg0MTVhZTkwZSJ9', '2019-06-14 13:01:03.252709');
INSERT INTO "django_session" VALUES ('kszh0shwcmch6eyhz8ali8euxti973jj', 'NjkzMGEyZjVmNzcxNDM3OTYzYTM5Y2Y2NzU4MTQzOTRlZjE3NDllMDp7Il9hdXRoX3VzZXJfaWQiOiIxNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZWQxNzQyYzBjOGVjZGFhMmYxYTAxMzRlOGJiOWUyMjFmNGI5ZTFlMCJ9', '2019-06-19 08:37:55.260898');
INSERT INTO "django_session" VALUES ('id2j4u3o0idwfin5ycvvh5xf7nm81ayo', 'MTIwZGY2Yjk4MTU0YjA2ZjQ1YzBkZjVkZWUyZDQ0NTg4MTZmODU1Njp7Il9hdXRoX3VzZXJfaWQiOiIzMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiODBiOWM0NWNjMDVlOGU1NWRiODE4M2RlYjM5OGNlMDQ2OWM0NjZlYiJ9', '2019-07-03 14:01:47.562839');
INSERT INTO "django_session" VALUES ('ytab818g1gn1k60rowz0q43y76x6olgm', 'MTIwZGY2Yjk4MTU0YjA2ZjQ1YzBkZjVkZWUyZDQ0NTg4MTZmODU1Njp7Il9hdXRoX3VzZXJfaWQiOiIzMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiODBiOWM0NWNjMDVlOGU1NWRiODE4M2RlYjM5OGNlMDQ2OWM0NjZlYiJ9', '2019-07-03 14:01:48.732174');
INSERT INTO "django_session" VALUES ('zas65zlkotcyh5xizgneout6lvebbpgt', 'NjkzMGEyZjVmNzcxNDM3OTYzYTM5Y2Y2NzU4MTQzOTRlZjE3NDllMDp7Il9hdXRoX3VzZXJfaWQiOiIxNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZWQxNzQyYzBjOGVjZGFhMmYxYTAxMzRlOGJiOWUyMjFmNGI5ZTFlMCJ9', '2019-07-05 12:30:50.921129');
INSERT INTO "django_session" VALUES ('jh78wbiaolm6eaibsbkwkqogk1f4v6jx', 'NjkzMGEyZjVmNzcxNDM3OTYzYTM5Y2Y2NzU4MTQzOTRlZjE3NDllMDp7Il9hdXRoX3VzZXJfaWQiOiIxNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZWQxNzQyYzBjOGVjZGFhMmYxYTAxMzRlOGJiOWUyMjFmNGI5ZTFlMCJ9', '2019-07-08 06:26:47.813627');
INSERT INTO "django_session" VALUES ('ls299pojh4n2md6p0djkl6r8w5zea4kz', 'NjkzMGEyZjVmNzcxNDM3OTYzYTM5Y2Y2NzU4MTQzOTRlZjE3NDllMDp7Il9hdXRoX3VzZXJfaWQiOiIxNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZWQxNzQyYzBjOGVjZGFhMmYxYTAxMzRlOGJiOWUyMjFmNGI5ZTFlMCJ9', '2019-07-20 16:31:29.929822');
INSERT INTO "django_session" VALUES ('q54yjga8szage1a6iwepoi12di75fcml', 'NjkzMGEyZjVmNzcxNDM3OTYzYTM5Y2Y2NzU4MTQzOTRlZjE3NDllMDp7Il9hdXRoX3VzZXJfaWQiOiIxNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZWQxNzQyYzBjOGVjZGFhMmYxYTAxMzRlOGJiOWUyMjFmNGI5ZTFlMCJ9', '2019-07-21 14:56:59.483563');
INSERT INTO "django_session" VALUES ('pjmmkasogajaluajldxh0hk8a1a7a6xn', 'NjkzMGEyZjVmNzcxNDM3OTYzYTM5Y2Y2NzU4MTQzOTRlZjE3NDllMDp7Il9hdXRoX3VzZXJfaWQiOiIxNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZWQxNzQyYzBjOGVjZGFhMmYxYTAxMzRlOGJiOWUyMjFmNGI5ZTFlMCJ9', '2019-07-24 13:45:15.708558');
INSERT INTO "django_session" VALUES ('4xojqq0m7soohexl5sfv27hwxihn5mf7', 'NjkzMGEyZjVmNzcxNDM3OTYzYTM5Y2Y2NzU4MTQzOTRlZjE3NDllMDp7Il9hdXRoX3VzZXJfaWQiOiIxNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZWQxNzQyYzBjOGVjZGFhMmYxYTAxMzRlOGJiOWUyMjFmNGI5ZTFlMCJ9', '2019-08-27 14:26:48.499207');
INSERT INTO "django_session" VALUES ('4gooobtlwmpphwgv1moo57o19g5lj4tg', 'MjZiMDg0NWYzOGU1YzQ0ODYyZTI0YzJmY2M2MTE5Y2JkMmRhODFhNDp7ImFjY291bnRfdmVyaWZpZWRfZW1haWwiOm51bGwsImFjY291bnRfdXNlciI6IjE1IiwiX2F1dGhfdXNlcl9pZCI6IjQxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYWxsYXV0aC5hY2NvdW50LmF1dGhfYmFja2VuZHMuQXV0aGVudGljYXRpb25CYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYWJhNmZhNWFhZjY1YjVkYjYyMDg0OTk3NzIxOThlYjhhMDhiMzQ3YSJ9', '2019-09-17 13:48:03.274796');
INSERT INTO "django_session" VALUES ('9sx3jr0jm72o9op4tf2tby3sqs6v3il2', 'NjkzMGEyZjVmNzcxNDM3OTYzYTM5Y2Y2NzU4MTQzOTRlZjE3NDllMDp7Il9hdXRoX3VzZXJfaWQiOiIxNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZWQxNzQyYzBjOGVjZGFhMmYxYTAxMzRlOGJiOWUyMjFmNGI5ZTFlMCJ9', '2019-10-08 13:57:13.531660');
INSERT INTO "django_session" VALUES ('9o576lr6b3iqr7e8gdfoch51defj9rzw', 'NDYwNDg5MGRkNzEzMTU1N2Q4ZWJjN2M3YTljMjE0MzljNjdiMjVmNDp7Il9hdXRoX3VzZXJfaWQiOiIxNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZWQxNzQyYzBjOGVjZGFhMmYxYTAxMzRlOGJiOWUyMjFmNGI5ZTFlMCIsIl9zZXNzaW9uX2V4cGlyeSI6MTIwOTYwMH0=', '2020-08-05 01:46:33.002590');
INSERT INTO "django_session" VALUES ('scts6n0fmiu6k28hyb6ikdsa1i7u8cqb', 'MjVjYjU0MzUxZGNlMDEyYzk2MjIyMjM4ZTE0Nzc1ZTU0MTBjYmEyOTp7InNvY2lhbGFjY291bnRfc3RhdGUiOlt7InByb2Nlc3MiOiJsb2dpbiIsInNjb3BlIjoiIiwiYXV0aF9wYXJhbXMiOiIifSwidTl4NERoUzh1dlpKIl19', '2022-10-11 03:58:38.209350');
INSERT INTO "django_session" VALUES ('daoire2pe6wq2h07m075cbtf9z9hzlik', 'Y2ZiYmNjMGE5YTFjYjIyNzAyNjg5OWVkZDkwNjRjYjUwN2ZhNTcyMDp7InNvY2lhbGFjY291bnRfc3RhdGUiOlt7InByb2Nlc3MiOiJsb2dpbiIsInNjb3BlIjoiIiwiYXV0aF9wYXJhbXMiOiIifSwiZUFKUTc4dlFQWjMwIl19', '2022-10-11 12:17:22.402177');

-- ----------------------------
-- Table structure for django_site
-- ----------------------------
DROP TABLE IF EXISTS "django_site";
CREATE TABLE "django_site" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "name" varchar(50) NOT NULL,
  "domain" varchar(100) NOT NULL,
  UNIQUE ("domain" ASC)
);

-- ----------------------------
-- Records of django_site
-- ----------------------------
INSERT INTO "django_site" VALUES (1, 'http://127.0.0.1:8000', 'http://127.0.0.1:8000');

-- ----------------------------
-- Table structure for notifications_notification
-- ----------------------------
DROP TABLE IF EXISTS "notifications_notification";
CREATE TABLE "notifications_notification" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "level" varchar(20) NOT NULL,
  "actor_object_id" varchar(255) NOT NULL,
  "verb" varchar(255) NOT NULL,
  "description" text,
  "target_object_id" varchar(255),
  "action_object_object_id" varchar(255),
  "timestamp" datetime NOT NULL,
  "public" bool NOT NULL,
  "action_object_content_type_id" integer,
  "actor_content_type_id" integer NOT NULL,
  "recipient_id" integer NOT NULL,
  "target_content_type_id" integer,
  "deleted" bool NOT NULL,
  "emailed" bool NOT NULL,
  "data" text,
  "unread" bool NOT NULL,
  FOREIGN KEY ("action_object_content_type_id") REFERENCES "django_content_type" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  FOREIGN KEY ("actor_content_type_id") REFERENCES "django_content_type" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  FOREIGN KEY ("recipient_id") REFERENCES "auth_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  FOREIGN KEY ("target_content_type_id") REFERENCES "django_content_type" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Records of notifications_notification
-- ----------------------------
INSERT INTO "notifications_notification" VALUES (1, 'info', 15, '回复了你', NULL, 32, 33, '2019-05-15 12:11:59.020534', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (2, 'info', 15, '回复了你', NULL, 32, 34, '2019-05-15 22:33:40.343421', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (3, 'info', 15, '回复了你', NULL, 20, 35, '2019-05-15 22:34:19.129303', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (4, 'info', 14, '回复了你', NULL, 32, 36, '2019-05-16 13:12:18.111898', 1, 9, 4, 15, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (5, 'info', 14, '回复了你', NULL, 32, 37, '2019-05-16 13:12:25.416954', 1, 9, 4, 15, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (6, 'info', 15, '回复了你', NULL, 32, 38, '2019-05-16 13:16:29.989405', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (7, 'info', 15, '回复了你', NULL, 32, 39, '2019-05-16 13:16:38.668431', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (8, 'info', 14, '回复了你', NULL, 32, 40, '2019-05-16 13:20:49.695797', 1, 9, 4, 15, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (9, 'info', 14, '回复了你', NULL, 32, 41, '2019-05-16 13:20:53.050268', 1, 9, 4, 15, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (10, 'info', 15, '回复了你', NULL, 32, 42, '2019-05-16 13:22:12.964977', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (11, 'info', 15, '回复了你', NULL, 32, 43, '2019-05-16 13:22:28.217466', 1, 9, 4, 15, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (12, 'info', 15, '回复了你', NULL, 32, 44, '2019-05-16 13:22:45.874870', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (13, 'info', 15, '回复了你', NULL, 32, 45, '2019-05-16 13:22:51.577240', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (14, 'info', 14, '回复了你', NULL, 31, NULL, '2019-05-18 06:54:24.257544', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (15, 'info', 15, '回复了你', NULL, 31, NULL, '2019-05-18 06:54:52.756668', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (16, 'info', 14, '回复了你', NULL, 31, NULL, '2019-05-18 06:57:50.934984', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (17, 'info', 14, '回复了你', NULL, 31, 49, '2019-05-18 06:57:51.240817', 1, 9, 4, 15, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (18, 'info', 14, '回复了你', NULL, 31, NULL, '2019-05-18 06:58:01.388950', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (19, 'info', 14, '回复了你', NULL, 31, 50, '2019-05-18 06:58:01.748144', 1, 9, 4, 15, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (20, 'info', 15, '回复了你', NULL, 30, NULL, '2019-05-18 07:00:43.254745', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (21, 'info', 15, '回复了你', NULL, 30, NULL, '2019-05-18 07:01:01.458805', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (22, 'info', 15, '回复了你', NULL, 30, 53, '2019-05-18 07:01:01.816336', 1, 9, 4, 15, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (23, 'info', 15, '回复了你', NULL, 30, NULL, '2019-05-18 07:01:10.002012', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (24, 'info', 14, '回复了你', NULL, 30, 55, '2019-05-18 07:01:47.709463', 1, 9, 4, 15, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (25, 'info', 14, '回复了你', NULL, 31, 56, '2019-05-18 09:33:42.691945', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (26, 'info', 15, '回复了你', NULL, 30, NULL, '2019-05-18 09:35:25.789794', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (27, 'info', 14, '回复了你', NULL, 31, 59, '2019-06-02 12:57:39.496579', 1, 9, 4, 15, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (28, 'info', 14, '回复了你', NULL, 31, 60, '2019-06-02 12:58:00.812573', 1, 9, 4, 15, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (29, 'info', 14, '回复了你', NULL, 32, 61, '2019-06-02 12:58:14.818711', 1, 9, 4, 15, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (30, 'info', 15, '回复了你', NULL, 30, NULL, '2019-06-02 13:09:49.535730', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (31, 'info', 15, '回复了你', NULL, 30, NULL, '2019-06-02 13:11:15.654756', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (32, 'info', 15, '回复了你', NULL, 28, NULL, '2019-06-02 13:12:20.013920', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (33, 'info', 15, '回复了你', NULL, 28, NULL, '2019-06-02 13:12:30.760262', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (34, 'info', 15, '回复了你', NULL, 28, NULL, '2019-06-02 13:14:20.640768', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (35, 'info', 15, '回复了你', NULL, 28, NULL, '2019-06-02 13:14:35.295771', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (36, 'info', 15, '回复了你', NULL, 28, NULL, '2019-06-02 13:35:36.303727', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (37, 'info', 15, '回复了你', NULL, 28, NULL, '2019-06-02 13:36:47.645218', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (38, 'info', 15, '回复了你', NULL, 28, NULL, '2019-06-02 13:38:35.030403', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (39, 'info', 15, '回复了你', NULL, 28, NULL, '2019-06-02 13:38:42.405028', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (40, 'info', 15, '回复了你', NULL, 28, NULL, '2019-06-03 12:11:40.506345', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (41, 'info', 15, '回复了你', NULL, 28, NULL, '2019-06-03 12:24:27.292687', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (42, 'info', 15, '回复了你', NULL, 28, NULL, '2019-06-03 12:39:50.300749', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (43, 'info', 15, '回复了你', NULL, 28, NULL, '2019-06-03 12:40:15.893591', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (44, 'info', 15, '回复了你', NULL, 28, NULL, '2019-06-03 12:41:52.033413', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (45, 'info', 15, '回复了你', NULL, 28, NULL, '2019-06-03 12:51:31.557580', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (46, 'info', 15, '回复了你', NULL, 28, NULL, '2019-06-03 12:51:35.465231', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (47, 'info', 15, '回复了你', NULL, 28, NULL, '2019-06-03 12:52:20.485504', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (48, 'info', 15, '回复了你', NULL, 28, NULL, '2019-06-03 12:52:24.122542', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (49, 'info', 15, '回复了你', NULL, 28, NULL, '2019-06-03 12:52:55.799781', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (50, 'info', 15, '回复了你', NULL, 28, NULL, '2019-06-03 12:53:58.187642', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (51, 'info', 15, '回复了你', NULL, 28, NULL, '2019-06-03 12:54:26.561968', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (52, 'info', 15, '回复了你', NULL, 28, NULL, '2019-06-03 12:54:56.677327', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (53, 'info', 15, '回复了你', NULL, 28, NULL, '2019-06-03 12:55:23.296893', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (54, 'info', 15, '回复了你', NULL, 31, NULL, '2019-06-03 12:55:44.763601', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (55, 'info', 15, '回复了你', NULL, 31, NULL, '2019-06-03 12:55:50.272924', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (56, 'info', 15, '回复了你', NULL, 31, NULL, '2019-06-03 12:55:55.266362', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (57, 'info', 15, '回复了你', NULL, 31, NULL, '2019-06-03 13:03:09.175372', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (58, 'info', 15, '回复了你', NULL, 32, NULL, '2019-06-04 11:58:05.298285', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (59, 'info', 15, '回复了你', NULL, 31, NULL, '2019-06-04 11:59:09.603683', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (60, 'info', 15, '回复了你', NULL, 32, 92, '2019-06-04 12:06:18.447757', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (61, 'info', 15, '回复了你', NULL, 30, 93, '2019-06-04 12:36:29.167925', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (62, 'info', 15, '回复了你', NULL, 31, 94, '2019-06-04 12:36:44.216352', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (63, 'info', 14, '回复了你', NULL, 30, 96, '2019-06-04 12:51:30.407883', 1, 9, 4, 15, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (64, 'info', 15, '回复了你', NULL, 32, 97, '2019-06-04 13:20:06.233256', 1, 9, 4, 14, 7, 0, 0, NULL, 1);
INSERT INTO "notifications_notification" VALUES (65, 'info', 15, '回复了你', NULL, 21, 101, '2019-06-05 08:32:36.619836', 1, 9, 4, 14, 7, 0, 0, NULL, 0);
INSERT INTO "notifications_notification" VALUES (66, 'info', 14, '回复了你', NULL, 21, 103, '2019-06-05 08:39:04.491563', 1, 9, 4, 15, 7, 0, 0, NULL, 1);
INSERT INTO "notifications_notification" VALUES (67, 'info', 14, '回复了你', NULL, 32, 106, '2019-09-24 13:57:24.410595', 1, 9, 4, 15, 7, 0, 0, NULL, 1);

-- ----------------------------
-- Table structure for socialaccount_socialaccount
-- ----------------------------
DROP TABLE IF EXISTS "socialaccount_socialaccount";
CREATE TABLE "socialaccount_socialaccount" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "provider" varchar(30) NOT NULL,
  "uid" varchar(191) NOT NULL,
  "last_login" datetime NOT NULL,
  "date_joined" datetime NOT NULL,
  "user_id" integer NOT NULL,
  "extra_data" text NOT NULL,
  FOREIGN KEY ("user_id") REFERENCES "auth_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Records of socialaccount_socialaccount
-- ----------------------------

-- ----------------------------
-- Table structure for socialaccount_socialapp
-- ----------------------------
DROP TABLE IF EXISTS "socialaccount_socialapp";
CREATE TABLE "socialaccount_socialapp" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "provider" varchar(30) NOT NULL,
  "name" varchar(40) NOT NULL,
  "client_id" varchar(191) NOT NULL,
  "key" varchar(191) NOT NULL,
  "secret" varchar(191) NOT NULL
);

-- ----------------------------
-- Records of socialaccount_socialapp
-- ----------------------------
INSERT INTO "socialaccount_socialapp" VALUES (1, 'github', 'GitHub', 'your_id', '', 'your_key');

-- ----------------------------
-- Table structure for socialaccount_socialapp_sites
-- ----------------------------
DROP TABLE IF EXISTS "socialaccount_socialapp_sites";
CREATE TABLE "socialaccount_socialapp_sites" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "socialapp_id" integer NOT NULL,
  "site_id" integer NOT NULL,
  FOREIGN KEY ("socialapp_id") REFERENCES "socialaccount_socialapp" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  FOREIGN KEY ("site_id") REFERENCES "django_site" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Records of socialaccount_socialapp_sites
-- ----------------------------
INSERT INTO "socialaccount_socialapp_sites" VALUES (1, 1, 1);

-- ----------------------------
-- Table structure for socialaccount_socialtoken
-- ----------------------------
DROP TABLE IF EXISTS "socialaccount_socialtoken";
CREATE TABLE "socialaccount_socialtoken" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "token" text NOT NULL,
  "token_secret" text NOT NULL,
  "expires_at" datetime,
  "account_id" integer NOT NULL,
  "app_id" integer NOT NULL,
  FOREIGN KEY ("account_id") REFERENCES "socialaccount_socialaccount" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  FOREIGN KEY ("app_id") REFERENCES "socialaccount_socialapp" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Records of socialaccount_socialtoken
-- ----------------------------

-- ----------------------------
-- Table structure for sqlite_sequence
-- ----------------------------
DROP TABLE IF EXISTS "sqlite_sequence";
CREATE TABLE "sqlite_sequence" (
  "name",
  "seq"
);

-- ----------------------------
-- Records of sqlite_sequence
-- ----------------------------
INSERT INTO "sqlite_sequence" VALUES ('django_migrations', 46);
INSERT INTO "sqlite_sequence" VALUES ('django_admin_log', 146);
INSERT INTO "sqlite_sequence" VALUES ('django_content_type', 19);
INSERT INTO "sqlite_sequence" VALUES ('auth_permission', 80);
INSERT INTO "sqlite_sequence" VALUES ('auth_user', 42);
INSERT INTO "sqlite_sequence" VALUES ('userprofile_profile', 21);
INSERT INTO "sqlite_sequence" VALUES ('article_articlecolumn', 3);
INSERT INTO "sqlite_sequence" VALUES ('taggit_tag', 19);
INSERT INTO "sqlite_sequence" VALUES ('taggit_taggeditem', 40);
INSERT INTO "sqlite_sequence" VALUES ('comment_comment', 106);
INSERT INTO "sqlite_sequence" VALUES ('notifications_notification', 67);
INSERT INTO "sqlite_sequence" VALUES ('account_emailaddress', 5);
INSERT INTO "sqlite_sequence" VALUES ('django_site', 1);
INSERT INTO "sqlite_sequence" VALUES ('socialaccount_socialapp', 1);
INSERT INTO "sqlite_sequence" VALUES ('socialaccount_socialaccount', 1);
INSERT INTO "sqlite_sequence" VALUES ('socialaccount_socialapp_sites', 1);
INSERT INTO "sqlite_sequence" VALUES ('socialaccount_socialtoken', 1);
INSERT INTO "sqlite_sequence" VALUES ('article_articlepost', 32);

-- ----------------------------
-- Table structure for taggit_tag
-- ----------------------------
DROP TABLE IF EXISTS "taggit_tag";
CREATE TABLE "taggit_tag" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "name" varchar(100) NOT NULL,
  "slug" varchar(100) NOT NULL,
  UNIQUE ("name" ASC),
  UNIQUE ("slug" ASC)
);

-- ----------------------------
-- Records of taggit_tag
-- ----------------------------
INSERT INTO "taggit_tag" VALUES (1, 'django', 'django');
INSERT INTO "taggit_tag" VALUES (2, 'django-taggit', 'django-taggit');
INSERT INTO "taggit_tag" VALUES (3, '标签', '');
INSERT INTO "taggit_tag" VALUES (4, 'django-taggit，标签', 'django-taggit_1');
INSERT INTO "taggit_tag" VALUES (5, 'django-taggit， 标签', 'django-taggit_2');
INSERT INTO "taggit_tag" VALUES (6, '标题图', '_1');
INSERT INTO "taggit_tag" VALUES (7, 'avatar', 'avatar');
INSERT INTO "taggit_tag" VALUES (8, 'HK', 'hk');
INSERT INTO "taggit_tag" VALUES (9, '香港', '_2');
INSERT INTO "taggit_tag" VALUES (10, '摄影', '_3');
INSERT INTO "taggit_tag" VALUES (11, 'HK,香港,文化', 'hk_1');
INSERT INTO "taggit_tag" VALUES (12, 'HK,香港', 'hk_2');
INSERT INTO "taggit_tag" VALUES (13, '港', '_4');
INSERT INTO "taggit_tag" VALUES (14, 'K', 'k');
INSERT INTO "taggit_tag" VALUES (15, ',', '_5');
INSERT INTO "taggit_tag" VALUES (16, 'H', 'h');
INSERT INTO "taggit_tag" VALUES (17, '香', '_6');
INSERT INTO "taggit_tag" VALUES (18, '', '_7');
INSERT INTO "taggit_tag" VALUES (19, '文化', '_8');

-- ----------------------------
-- Table structure for taggit_taggeditem
-- ----------------------------
DROP TABLE IF EXISTS "taggit_taggeditem";
CREATE TABLE "taggit_taggeditem" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "object_id" integer NOT NULL,
  "content_type_id" integer NOT NULL,
  "tag_id" integer NOT NULL,
  FOREIGN KEY ("content_type_id") REFERENCES "django_content_type" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  FOREIGN KEY ("tag_id") REFERENCES "taggit_tag" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED
);

-- ----------------------------
-- Records of taggit_taggeditem
-- ----------------------------
INSERT INTO "taggit_taggeditem" VALUES (3, 28, 7, 1);
INSERT INTO "taggit_taggeditem" VALUES (4, 28, 7, 2);
INSERT INTO "taggit_taggeditem" VALUES (5, 28, 7, 3);
INSERT INTO "taggit_taggeditem" VALUES (10, 26, 7, 1);
INSERT INTO "taggit_taggeditem" VALUES (12, 30, 7, 7);
INSERT INTO "taggit_taggeditem" VALUES (38, 31, 7, 8);
INSERT INTO "taggit_taggeditem" VALUES (39, 31, 7, 9);
INSERT INTO "taggit_taggeditem" VALUES (40, 32, 7, 10);

-- ----------------------------
-- Table structure for userprofile_profile
-- ----------------------------
DROP TABLE IF EXISTS "userprofile_profile";
CREATE TABLE "userprofile_profile" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "phone" varchar(20) NOT NULL,
  "avatar" varchar(100) NOT NULL,
  "bio" text NOT NULL,
  "user_id" integer NOT NULL,
  FOREIGN KEY ("user_id") REFERENCES "auth_user" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED,
  UNIQUE ("user_id" ASC)
);

-- ----------------------------
-- Records of userprofile_profile
-- ----------------------------
INSERT INTO "userprofile_profile" VALUES (1, 13812345673, 'avatar/20190707/ultrasmall.jpg', '我爱Django！！', 14);
INSERT INTO "userprofile_profile" VALUES (2, 12222222222, '', 'test', 15);

-- ----------------------------
-- Auto increment value for account_emailaddress
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 5 WHERE name = 'account_emailaddress';

-- ----------------------------
-- Indexes structure for table account_emailaddress
-- ----------------------------
CREATE INDEX "account_emailaddress_user_id_2c513194"
ON "account_emailaddress" (
  "user_id" ASC
);

-- ----------------------------
-- Indexes structure for table account_emailconfirmation
-- ----------------------------
CREATE INDEX "account_emailconfirmation_email_address_id_5b7f8c58"
ON "account_emailconfirmation" (
  "email_address_id" ASC
);

-- ----------------------------
-- Auto increment value for article_articlecolumn
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 3 WHERE name = 'article_articlecolumn';

-- ----------------------------
-- Auto increment value for article_articlepost
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 32 WHERE name = 'article_articlepost';

-- ----------------------------
-- Indexes structure for table article_articlepost
-- ----------------------------
CREATE INDEX "article_articlepost_author_id_b855d44d"
ON "article_articlepost" (
  "author_id" ASC
);
CREATE INDEX "article_articlepost_column_id_48f69d78"
ON "article_articlepost" (
  "column_id" ASC
);

-- ----------------------------
-- Indexes structure for table auth_group_permissions
-- ----------------------------
CREATE INDEX "auth_group_permissions_group_id_b120cbf9"
ON "auth_group_permissions" (
  "group_id" ASC
);
CREATE UNIQUE INDEX "auth_group_permissions_group_id_permission_id_0cd325b0_uniq"
ON "auth_group_permissions" (
  "group_id" ASC,
  "permission_id" ASC
);
CREATE INDEX "auth_group_permissions_permission_id_84c5c92e"
ON "auth_group_permissions" (
  "permission_id" ASC
);

-- ----------------------------
-- Auto increment value for auth_permission
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 80 WHERE name = 'auth_permission';

-- ----------------------------
-- Indexes structure for table auth_permission
-- ----------------------------
CREATE INDEX "auth_permission_content_type_id_2f476e4b"
ON "auth_permission" (
  "content_type_id" ASC
);
CREATE UNIQUE INDEX "auth_permission_content_type_id_codename_01ab375a_uniq"
ON "auth_permission" (
  "content_type_id" ASC,
  "codename" ASC
);

-- ----------------------------
-- Auto increment value for auth_user
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 42 WHERE name = 'auth_user';

-- ----------------------------
-- Indexes structure for table auth_user_groups
-- ----------------------------
CREATE INDEX "auth_user_groups_group_id_97559544"
ON "auth_user_groups" (
  "group_id" ASC
);
CREATE INDEX "auth_user_groups_user_id_6a12ed8b"
ON "auth_user_groups" (
  "user_id" ASC
);
CREATE UNIQUE INDEX "auth_user_groups_user_id_group_id_94350c0c_uniq"
ON "auth_user_groups" (
  "user_id" ASC,
  "group_id" ASC
);

-- ----------------------------
-- Indexes structure for table auth_user_user_permissions
-- ----------------------------
CREATE INDEX "auth_user_user_permissions_permission_id_1fbb5f2c"
ON "auth_user_user_permissions" (
  "permission_id" ASC
);
CREATE INDEX "auth_user_user_permissions_user_id_a95ead1b"
ON "auth_user_user_permissions" (
  "user_id" ASC
);
CREATE UNIQUE INDEX "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq"
ON "auth_user_user_permissions" (
  "user_id" ASC,
  "permission_id" ASC
);

-- ----------------------------
-- Auto increment value for comment_comment
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 106 WHERE name = 'comment_comment';

-- ----------------------------
-- Indexes structure for table comment_comment
-- ----------------------------
CREATE INDEX "comment_comment_article_id_3cc364fc"
ON "comment_comment" (
  "article_id" ASC
);
CREATE INDEX "comment_comment_parent_id_b612524c"
ON "comment_comment" (
  "parent_id" ASC
);
CREATE INDEX "comment_comment_reply_to_id_e0adcef8"
ON "comment_comment" (
  "reply_to_id" ASC
);
CREATE INDEX "comment_comment_tree_id_42ec2c80"
ON "comment_comment" (
  "tree_id" ASC
);
CREATE INDEX "comment_comment_user_id_6078e57b"
ON "comment_comment" (
  "user_id" ASC
);

-- ----------------------------
-- Auto increment value for django_admin_log
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 146 WHERE name = 'django_admin_log';

-- ----------------------------
-- Indexes structure for table django_admin_log
-- ----------------------------
CREATE INDEX "django_admin_log_content_type_id_c4bce8eb"
ON "django_admin_log" (
  "content_type_id" ASC
);
CREATE INDEX "django_admin_log_user_id_c564eba6"
ON "django_admin_log" (
  "user_id" ASC
);

-- ----------------------------
-- Auto increment value for django_content_type
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 19 WHERE name = 'django_content_type';

-- ----------------------------
-- Indexes structure for table django_content_type
-- ----------------------------
CREATE UNIQUE INDEX "django_content_type_app_label_model_76bd3d3b_uniq"
ON "django_content_type" (
  "app_label" ASC,
  "model" ASC
);

-- ----------------------------
-- Auto increment value for django_migrations
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 46 WHERE name = 'django_migrations';

-- ----------------------------
-- Indexes structure for table django_session
-- ----------------------------
CREATE INDEX "django_session_expire_date_a5c62663"
ON "django_session" (
  "expire_date" ASC
);

-- ----------------------------
-- Auto increment value for django_site
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 1 WHERE name = 'django_site';

-- ----------------------------
-- Auto increment value for notifications_notification
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 67 WHERE name = 'notifications_notification';

-- ----------------------------
-- Indexes structure for table notifications_notification
-- ----------------------------
CREATE INDEX "notifications_notification_action_object_content_type_id_7d2b8ee9"
ON "notifications_notification" (
  "action_object_content_type_id" ASC
);
CREATE INDEX "notifications_notification_actor_content_type_id_0c69d7b7"
ON "notifications_notification" (
  "actor_content_type_id" ASC
);
CREATE INDEX "notifications_notification_deleted_b32b69e6"
ON "notifications_notification" (
  "deleted" ASC
);
CREATE INDEX "notifications_notification_emailed_23a5ad81"
ON "notifications_notification" (
  "emailed" ASC
);
CREATE INDEX "notifications_notification_public_1bc30b1c"
ON "notifications_notification" (
  "public" ASC
);
CREATE INDEX "notifications_notification_recipient_id_d055f3f0"
ON "notifications_notification" (
  "recipient_id" ASC
);
CREATE INDEX "notifications_notification_target_content_type_id_ccb24d88"
ON "notifications_notification" (
  "target_content_type_id" ASC
);
CREATE INDEX "notifications_notification_unread_cce4be30"
ON "notifications_notification" (
  "unread" ASC
);

-- ----------------------------
-- Auto increment value for socialaccount_socialaccount
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 1 WHERE name = 'socialaccount_socialaccount';

-- ----------------------------
-- Indexes structure for table socialaccount_socialaccount
-- ----------------------------
CREATE UNIQUE INDEX "socialaccount_socialaccount_provider_uid_fc810c6e_uniq"
ON "socialaccount_socialaccount" (
  "provider" ASC,
  "uid" ASC
);
CREATE INDEX "socialaccount_socialaccount_user_id_8146e70c"
ON "socialaccount_socialaccount" (
  "user_id" ASC
);

-- ----------------------------
-- Auto increment value for socialaccount_socialapp
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 1 WHERE name = 'socialaccount_socialapp';

-- ----------------------------
-- Auto increment value for socialaccount_socialapp_sites
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 1 WHERE name = 'socialaccount_socialapp_sites';

-- ----------------------------
-- Indexes structure for table socialaccount_socialapp_sites
-- ----------------------------
CREATE INDEX "socialaccount_socialapp_sites_site_id_2579dee5"
ON "socialaccount_socialapp_sites" (
  "site_id" ASC
);
CREATE INDEX "socialaccount_socialapp_sites_socialapp_id_97fb6e7d"
ON "socialaccount_socialapp_sites" (
  "socialapp_id" ASC
);
CREATE UNIQUE INDEX "socialaccount_socialapp_sites_socialapp_id_site_id_71a9a768_uniq"
ON "socialaccount_socialapp_sites" (
  "socialapp_id" ASC,
  "site_id" ASC
);

-- ----------------------------
-- Auto increment value for socialaccount_socialtoken
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 1 WHERE name = 'socialaccount_socialtoken';

-- ----------------------------
-- Indexes structure for table socialaccount_socialtoken
-- ----------------------------
CREATE INDEX "socialaccount_socialtoken_account_id_951f210e"
ON "socialaccount_socialtoken" (
  "account_id" ASC
);
CREATE INDEX "socialaccount_socialtoken_app_id_636a42d7"
ON "socialaccount_socialtoken" (
  "app_id" ASC
);
CREATE UNIQUE INDEX "socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq"
ON "socialaccount_socialtoken" (
  "app_id" ASC,
  "account_id" ASC
);

-- ----------------------------
-- Auto increment value for taggit_tag
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 19 WHERE name = 'taggit_tag';

-- ----------------------------
-- Auto increment value for taggit_taggeditem
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 40 WHERE name = 'taggit_taggeditem';

-- ----------------------------
-- Indexes structure for table taggit_taggeditem
-- ----------------------------
CREATE INDEX "taggit_taggeditem_content_type_id_9957a03c"
ON "taggit_taggeditem" (
  "content_type_id" ASC
);
CREATE INDEX "taggit_taggeditem_content_type_id_object_id_196cc965_idx"
ON "taggit_taggeditem" (
  "content_type_id" ASC,
  "object_id" ASC
);
CREATE INDEX "taggit_taggeditem_object_id_e2d7d1df"
ON "taggit_taggeditem" (
  "object_id" ASC
);
CREATE INDEX "taggit_taggeditem_tag_id_f4f5b767"
ON "taggit_taggeditem" (
  "tag_id" ASC
);

-- ----------------------------
-- Auto increment value for userprofile_profile
-- ----------------------------
UPDATE "sqlite_sequence" SET seq = 21 WHERE name = 'userprofile_profile';

PRAGMA foreign_keys = true;
