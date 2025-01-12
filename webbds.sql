/*
 Navicat Premium Dump SQL

 Source Server         : webbds
 Source Server Type    : MySQL
 Source Server Version : 80004 (8.0.4-rc-log)
 Source Host           : localhost:3306
 Source Schema         : webbds

 Target Server Type    : MySQL
 Target Server Version : 80004 (8.0.4-rc-log)
 File Encoding         : 65001

 Date: 03/01/2025 22:14:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for appointments
-- ----------------------------
DROP TABLE IF EXISTS `appointments`;
CREATE TABLE `appointments`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` time NOT NULL,
  `property_count` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `contacted` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of appointments
-- ----------------------------
INSERT INTO `appointments` VALUES (14, NULL, 'Bình Thạnh Hồ Chí Minh', '0986641965', '2024-12-28', '15:00:00', 4, '2024-12-27 10:48:11', 'admin', 1);
INSERT INTO `appointments` VALUES (15, NULL, 'Bình Thạnh Hồ Chí Minh', '0986641965', '2024-12-28', '15:00:00', 4, '2024-12-27 10:50:57', 'admin', 0);
INSERT INTO `appointments` VALUES (16, NULL, 'Bình Thạnh Hồ Chí Minh', '0986641965', '2024-12-28', '13:00:00', 2, '2024-12-27 10:51:19', 'john1234', 0);
INSERT INTO `appointments` VALUES (17, NULL, 'Bình Thạnh Hồ Chí Minh', '0986641965', '2025-01-11', '10:00:00', 3, '2024-12-27 10:52:19', 'johnn', 0);

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `cart_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`cart_id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 59 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES (58, 1);
INSERT INTO `cart` VALUES (29, 2);
INSERT INTO `cart` VALUES (33, 5);
INSERT INTO `cart` VALUES (57, 6);
INSERT INTO `cart` VALUES (54, 8);
INSERT INTO `cart` VALUES (32, 33);
INSERT INTO `cart` VALUES (34, 34);
INSERT INTO `cart` VALUES (53, 52);
INSERT INTO `cart` VALUES (56, 53);

-- ----------------------------
-- Table structure for cartitems
-- ----------------------------
DROP TABLE IF EXISTS `cartitems`;
CREATE TABLE `cartitems`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cart_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `area` decimal(10, 2) NOT NULL,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `quantity` int(11) NULL DEFAULT 1,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cart_id`(`cart_id` ASC) USING BTREE,
  INDEX `property_id`(`property_id` ASC) USING BTREE,
  CONSTRAINT `cartitems_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `cartitems_ibfk_2` FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 214 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cartitems
-- ----------------------------
INSERT INTO `cartitems` VALUES (148, 32, 186, 'nhà mặt phố bố làm to lắm ', 50.00, 50.00, 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733406034/x0pzx9nojc7v3m2ksjkz.jpg', 1, 'Quận 1 Thành Phố Hồ Chí Minh');
INSERT INTO `cartitems` VALUES (152, 32, 189, 'Nhà cực đẹp mọi ngườiu ơi hehe hehe', 50.00, 50.00, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733415400/us0kuwtsbnoxbnqpm7it.jpg', 1, 'Quận 1 Thành Phố Hồ Chí Minh');
INSERT INTO `cartitems` VALUES (154, 32, 191, 'nhà mặt phố bố làm to lắm ', 50.00, 50.00, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733453937/swsw13vl237mjjkd2jv2.jpg', 1, 'Quận 1 Thành Phố Hồ Chí Minh');
INSERT INTO `cartitems` VALUES (195, 29, 201, 'Nhà mặt phố bố làm to lắm ', 100.00, 50.00, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734104625/gbkyvunlsgckzzvooo5h.webp', 1, 'Quận 1 Thành Phố Hồ Chí Minh');
INSERT INTO `cartitems` VALUES (212, 58, 235, 'Nhà ngay hàng xanh cho thuê', 12.00, 80.00, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734695073/bhofute9v4o0eixwjtda.jpg', 1, 'Thành phố Long Khánh Biên Hòa Đồng Nai');
INSERT INTO `cartitems` VALUES (213, 57, 236, 'Nhà ngay hàng xanh cho thuê', 12.00, 90.00, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734695094/wlwzv2swpzburccp7cok.jpg', 1, 'Thành phố Long Khánh Biên Hòa Đồng Nai');

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `property_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `comment_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`) USING BTREE,
  INDEX `property_id`(`property_id` ASC) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (12, 5, 5, '123123', '2024-11-09 19:52:43');
INSERT INTO `comments` VALUES (14, 1, 5, '123123', '2024-11-09 20:39:00');
INSERT INTO `comments` VALUES (16, 1, 6, 'dep', '2024-11-09 20:49:23');
INSERT INTO `comments` VALUES (17, 1, 6, 'qua dep qua hay', '2024-11-09 20:49:28');
INSERT INTO `comments` VALUES (18, 1, 6, 'nai so`', '2024-11-09 20:49:33');
INSERT INTO `comments` VALUES (19, 2, 6, 'dep qa\r\n', '2024-11-09 20:50:34');
INSERT INTO `comments` VALUES (20, 2, 6, 'qa dep', '2024-11-09 20:50:41');
INSERT INTO `comments` VALUES (21, 1, 2, 'hehehe dep qa qa dep hihi', '2024-11-12 22:08:29');
INSERT INTO `comments` VALUES (22, 7, 6, 'dep du ta   ', '2024-11-26 20:19:22');
INSERT INTO `comments` VALUES (23, 3, 6, 'dep lam nha mng hih\r\n', '2024-12-04 21:13:08');
INSERT INTO `comments` VALUES (25, 17, 2, 'hehe dep nhe   ', '2024-12-09 15:18:26');
INSERT INTO `comments` VALUES (26, 201, 6, 'alo alo alo alo\r\nhello moi ng ', '2024-12-16 11:57:42');
INSERT INTO `comments` VALUES (27, 201, 6, 'nhà nhà nhà đẹp đẹp đẹp', '2024-12-16 11:57:51');
INSERT INTO `comments` VALUES (28, 235, 6, 'Nhà khá đẹp những nhà khác cũng nên ghé qua xem nhé', '2024-12-23 14:32:17');
INSERT INTO `comments` VALUES (29, 235, 6, 'Nhà đẹp nha anh em ráng ghé qua coi   ', '2024-12-27 23:12:12');

-- ----------------------------
-- Table structure for orderitems
-- ----------------------------
DROP TABLE IF EXISTS `orderitems`;
CREATE TABLE `orderitems`  (
  `order_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NULL DEFAULT NULL,
  `property_id` int(11) NULL DEFAULT NULL,
  `quantity` int(11) NULL DEFAULT 1,
  `price` double NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'pending',
  PRIMARY KEY (`order_item_id`) USING BTREE,
  INDEX `order_id`(`order_id` ASC) USING BTREE,
  INDEX `property_id`(`property_id` ASC) USING BTREE,
  CONSTRAINT `orderitems_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `orderitems_ibfk_2` FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 142 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orderitems
-- ----------------------------
INSERT INTO `orderitems` VALUES (133, 88, 236, 1, 12, 'Nhà ngay hàng xanh cho thuê', 'pending');
INSERT INTO `orderitems` VALUES (134, 88, 230, 1, 12, 'Nhà ngay hàng xanh cho thuê', 'pending');
INSERT INTO `orderitems` VALUES (135, 88, 217, 1, 12, 'Nhà ngay hàng xanh cho thuê', 'pending');
INSERT INTO `orderitems` VALUES (136, 88, 214, 1, 10, 'Nhà ngay hàng xanh cho thuê', 'pending');
INSERT INTO `orderitems` VALUES (137, 89, 235, 1, 12, 'Nhà ngay hàng xanh cho thuê', 'pending');
INSERT INTO `orderitems` VALUES (138, 89, 230, 1, 12, 'Nhà ngay hàng xanh cho thuê', 'pending');
INSERT INTO `orderitems` VALUES (139, 90, 199, 1, 20, 'Nhà kế vườn xoài cho xem nhé hehe', 'pending');
INSERT INTO `orderitems` VALUES (140, 90, 201, 1, 100, 'nhà mặt phố bố làm to lắm ', 'pending');
INSERT INTO `orderitems` VALUES (141, 90, 217, 1, 12, 'Nhà ngay hàng xanh cho thuê', 'pending');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `order_date` datetime NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 91 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (88, 6, '2024-12-27 10:47:37', 'admin');
INSERT INTO `orders` VALUES (89, 10, '2024-12-27 10:51:07', 'john1234');
INSERT INTO `orders` VALUES (90, 1, '2024-12-27 10:52:08', 'johnn');

-- ----------------------------
-- Table structure for posters
-- ----------------------------
DROP TABLE IF EXISTS `posters`;
CREATE TABLE `posters`  (
  `poster_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`poster_id`) USING BTREE,
  INDEX `fk_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 217 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of posters
-- ----------------------------
INSERT INTO `posters` VALUES (1, 'Nguyễn Văn A', 'nguyenvana@example.com', '0123456789', '2024-11-05 22:43:50', '2024-12-05 20:44:47', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733377326/vyeajpe7y1n8xfpedyjh.jpg', 1);
INSERT INTO `posters` VALUES (2, 'Trần Thị B', 'tranthib@example.com', '0987654321', '2024-11-05 22:43:50', '2024-12-03 20:16:59', 'https://th.bing.com/th/id/OIP.wq2tdv0O83VJsCilZpsQIQHaHa?https://images.genius.com/0bfbff035ddb4ae1ad83ddd2f835c3f9.1000x1000x1.jpg', 2);
INSERT INTO `posters` VALUES (3, 'Lê Hoàng C', 'lehoangc@example.com', '0912345678', '2024-11-05 22:43:50', '2024-12-03 20:17:00', 'https://th.bing.com/th/id/OIP.jKHBRVWDytTl9XLqRRQ7kAAAAA?rs=1&pid=ImgDetMain', 3);
INSERT INTO `posters` VALUES (7, 'Nguyễn Văn D', 'nguyenvand@example.com', '123456780', '2024-11-06 22:27:32', '2024-12-03 20:17:02', 'https://th.bing.com/th/id/R.497a35676bc7987716d1b52c2845792e?rik=Otbhf5DIl5aIxA&pid=ImgRaw&r=0', 4);
INSERT INTO `posters` VALUES (8, 'Lê Thị E', 'lethie@example.com', '987654320', '2024-11-06 22:27:32', '2024-12-03 20:17:03', 'https://th.bing.com/th/id/OIP.B1KrBTmxkdhOM9Omwjvj7AHaHa?rs=1&pid=ImgDetMain', 5);
INSERT INTO `posters` VALUES (9, 'Trần Văn F', 'tranvanf@example.com', '456789124', '2024-11-06 22:27:32', '2024-12-03 20:17:05', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 6);
INSERT INTO `posters` VALUES (10, 'Nguyễn Thị G', 'nguyenthig@example.com', '321654987', '2024-11-06 22:27:32', '2024-12-03 20:17:10', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 8);
INSERT INTO `posters` VALUES (11, 'Lê Văn H', 'levanh@example.com', '654321789', '2024-11-06 22:27:32', '2024-12-03 20:17:12', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 9);
INSERT INTO `posters` VALUES (12, 'Trần Thị I', 'tranthi@example.com', '789456123', '2024-11-06 22:27:32', '2024-12-03 20:17:13', 'https://media.yeah1.com/files/ngoctran/2022/07/01/289693821_582015943280803_2102006602626651935_n-205941.jpg', 10);
INSERT INTO `posters` VALUES (13, 'Nguyễn Văn J', 'nguyenvanj@example.com', '159753486', '2024-11-06 22:27:32', '2024-12-03 20:17:15', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 11);
INSERT INTO `posters` VALUES (14, 'Lê Thị K', 'lethik@example.com', '753159864', '2024-11-06 22:27:32', '2024-12-03 20:17:17', 'https://media.yeah1.com/files/ngoctran/2022/07/01/289693821_582015943280803_2102006602626651935_n-205941.jpg', 12);
INSERT INTO `posters` VALUES (15, 'Trần Văn L', 'tranvanl@example.com', '258963147', '2024-11-06 22:27:32', '2024-12-03 20:17:18', 'https://th.bing.com/th/id/R.497a35676bc7987716d1b52c2845792e?rik=Otbhf5DIl5aIxA&pid=ImgRaw&r=0', 13);
INSERT INTO `posters` VALUES (16, 'Nguyễn Thị M', 'nguyenthim@example.com', '654789123', '2024-11-06 22:27:32', '2024-12-03 20:17:20', 'https://images.genius.com/0bfbff035ddb4ae1ad83ddd2f835c3f9.1000x1000x1.jpg', 14);
INSERT INTO `posters` VALUES (17, 'Nguyễn Văn N', 'nguyenvann_1@example.com', '789123456', '2024-11-06 22:57:03', '2024-12-03 20:17:21', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 15);
INSERT INTO `posters` VALUES (18, 'Trần Thị O', 'tranthio_1@example.com', '456789123', '2024-11-06 22:57:03', '2024-12-03 20:17:23', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 16);
INSERT INTO `posters` VALUES (19, 'Lê Hoàng P', 'lehoangp_1@example.com', '321654987', '2024-11-06 22:57:03', '2024-12-03 20:17:25', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 17);
INSERT INTO `posters` VALUES (20, 'Nguyễn Thị Q', 'nguyenthiq_1@example.com', '654321789', '2024-11-06 22:57:03', '2024-12-03 20:17:52', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 23);
INSERT INTO `posters` VALUES (21, 'Lê Văn R', 'levanr_1@example.com', '987654321', '2024-11-06 22:57:03', '2024-12-03 20:17:54', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 24);
INSERT INTO `posters` VALUES (22, 'Trần Văn S', 'tranvans_1@example.com', '159753486', '2024-11-06 22:57:03', '2024-12-03 20:17:57', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 25);
INSERT INTO `posters` VALUES (23, 'Nguyễn Văn T', 'nguyenvant_1@example.com', '753159864', '2024-11-06 22:57:03', '2024-12-03 20:17:59', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 26);
INSERT INTO `posters` VALUES (24, 'Lê Thị U', 'lethiu_1@example.com', '258963147', '2024-11-06 22:57:03', '2024-12-03 20:18:03', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 27);
INSERT INTO `posters` VALUES (25, 'Trần Thị V', 'tranthiv_1@example.com', '369258147', '2024-11-06 22:57:03', '2024-12-03 20:18:26', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 31);
INSERT INTO `posters` VALUES (26, 'Nguyễn Văn W', 'nguyenvanw_1@example.com', '951753486', '2024-11-06 22:57:03', '2024-12-07 22:34:55', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 1);
INSERT INTO `posters` VALUES (27, 'Lê Thị X', 'lethix_1@example.com', '147258369', '2024-11-06 22:57:03', '2024-12-07 22:35:14', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 2);
INSERT INTO `posters` VALUES (31, 'Nguyễn Văn AB', 'nguyenvanab_1@example.com', '369852147', '2024-11-06 22:57:03', '2024-12-07 22:35:49', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 6);
INSERT INTO `posters` VALUES (160, 'khoangoquan123', 'khoangoquan@gmail.com', '0986641965', '2024-12-05 12:42:06', '2024-12-05 12:42:06', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733377326/vyeajpe7y1n8xfpedyjh.jpg', 2);
INSERT INTO `posters` VALUES (161, 'khoangoquan123', 'khoangoquan@gmail.com', '0986641965', '2024-12-05 19:35:53', '2024-12-05 19:35:53', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733402154/fxgcfvbgny7tqgha3r84.jpg', 2);
INSERT INTO `posters` VALUES (162, 'khoangoquan123', 'khoangoquan@gmail.com', '0986641965', '2024-12-05 19:39:48', '2024-12-05 19:39:48', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733402389/v0rl80endfuocsdkzij4.jpg', 2);
INSERT INTO `posters` VALUES (163, 'khoangoquan123', 'khoangoquan@gmail.com', '0986641965', '2024-12-05 19:41:16', '2024-12-05 19:41:16', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733402477/tgqg7zllb7g7mjh1sklk.jpg', 2);
INSERT INTO `posters` VALUES (164, 'khoangoquan123', 'khoangoquan@gmail.com', '0986641965', '2024-12-05 19:48:53', '2024-12-05 19:48:53', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733402934/opfvoapwpijuxukdhx7z.jpg', 2);
INSERT INTO `posters` VALUES (165, 'khoangoquan123', 'khoangoquan@gmail.com', '0986641965', '2024-12-05 19:54:16', '2024-12-05 19:54:16', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733403257/v9ddnrnzi5zykvk6efmk.jpg', 2);
INSERT INTO `posters` VALUES (166, 'khoangoquan123', 'khoangoquan@gmail.com', '0986641965', '2024-12-05 19:58:02', '2024-12-05 19:58:02', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733403483/dshoadmc7oheav2v2jhs.jpg', 2);
INSERT INTO `posters` VALUES (167, 'khoangoquan', 'khoangoquan@gmail.com', '0986641965', '2024-12-05 20:12:53', '2024-12-05 20:12:53', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733404374/nanfbs2oycq5viychmze.jpg', 2);
INSERT INTO `posters` VALUES (172, 'khoangoquan', 'khoangoquan@gmail.com', '0986641965', '2024-12-05 20:23:21', '2024-12-05 20:23:21', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733405002/tsbfdrmrvo59gkge7mc6.jpg', 2);
INSERT INTO `posters` VALUES (173, 'khoangoquan', 'khoangoquan@gmail.com', '0986641965', '2024-12-05 23:06:14', '2024-12-05 23:06:14', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733414775/osksdl7ww9zzzjd5fmvr.jpg', 10);
INSERT INTO `posters` VALUES (174, 'khoangoquan', 'khoangoquan@gmail.com', '0986641965', '2024-12-05 23:16:19', '2024-12-05 23:16:19', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733415379/xn2lco9lfpu6zxtyglxe.png', 10);
INSERT INTO `posters` VALUES (175, 'khoangoquan', 'khoangoquan@gmail.com', '0986641965', '2024-12-06 09:56:11', '2024-12-06 09:56:11', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733453770/ricklswdgmixouj9yluc.png', 10);
INSERT INTO `posters` VALUES (176, 'khoangoquan', 'khoangoquan@gmail.com', '0986641965', '2024-12-06 21:04:56', '2024-12-06 21:04:56', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733493896/vetev7wxgey5lxsceclm.jpg', 2);
INSERT INTO `posters` VALUES (177, 'khoangoquan', 'khoangoquan@gmail.com', '0986641965', '2024-12-06 21:06:55', '2024-12-06 21:06:55', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733494015/b70iawvyxv6pv8nxegbe.jpg', 2);
INSERT INTO `posters` VALUES (179, 'Ngô Quan Anh Khoa', 'khoangoquan@gmail.com', '0986641965', '2024-12-08 12:09:42', '2024-12-08 12:09:42', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733634581/vsiqhlgc35zsnkzrrwi6.jpg', 2);
INSERT INTO `posters` VALUES (180, 'Ngô Quan Anh Khoa', 'khoangoquan@gmail.com', '0986641965', '2024-12-08 12:11:47', '2024-12-08 12:11:47', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733634707/rllojvtldpwzgbxzgzoo.jpg', 2);
INSERT INTO `posters` VALUES (181, 'Ngô Quan Anh Khoa', 'khoangoquan@gmail.com', '0986641965', '2024-12-08 12:14:04', '2024-12-08 12:14:04', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733634844/ran4e3ufcv2vns3ds5e1.jpg', 2);
INSERT INTO `posters` VALUES (182, 'Ngô Quan Anh Khoa', 'khoangoquan@gmail.com', '0986641965', '2024-12-08 12:21:42', '2024-12-08 12:21:42', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733635301/xvt5dh63rfnauucp8lpy.jpg', 2);
INSERT INTO `posters` VALUES (183, 'Ngô Quan Anh Khoa', 'khoangoquan@gmail.com', '0986641965', '2024-12-08 12:22:54', '2024-12-08 12:22:54', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733635373/skjc2z7d1pojcyzgh1m0.jpg', 2);
INSERT INTO `posters` VALUES (184, 'Ngô Quan Anh Khoa', 'khoangoquan@gmail.com', '0986641965', '2024-12-08 12:24:47', '2024-12-08 12:24:47', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733635487/lqf59cv3e3cxokskhxg1.jpg', 2);
INSERT INTO `posters` VALUES (185, 'Ngô Quan Anh Khoa', 'khoangoquan@gmail.com', '0986641965', '2024-12-08 12:25:56', '2024-12-08 12:25:56', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733635555/aio2uug6bpx0i4fk9vym.jpg', 2);
INSERT INTO `posters` VALUES (188, 'Ngô Quan Anh Khoa', 'khoangoquan@gmail.com', '0986641965', '2024-12-17 18:27:26', '2024-12-17 18:27:26', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734434846/i8zxtmayxtg88h6zyxe5.jpg', 6);
INSERT INTO `posters` VALUES (189, 'Ngô Quan Anh Khoa', 'khoangoquan@gmail.com', '0986641965', '2024-12-17 18:28:17', '2024-12-17 18:28:17', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734434897/g1pywy3yqj4qf9a9oi6p.jpg', 6);
INSERT INTO `posters` VALUES (192, 'Ngô Quan Anh Khoa', 'khoangoquan@gmail.com', '0986641965', '2024-12-18 22:14:16', '2024-12-18 22:14:16', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734534857/jxlg1cnattq9htqnwmoe.jpg', 1);
INSERT INTO `posters` VALUES (193, 'Ngô Quan Anh Khoa', 'khoangoquan@gmail.com', '0986641965', '2024-12-18 22:17:21', '2024-12-18 22:17:21', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734535042/b9tjr33wl3fs19atf1ii.jpg', 1);
INSERT INTO `posters` VALUES (194, 'Ngô Quan Anh Khoa', 'khoangoquan@gmail.com', '0986641965', '2024-12-18 22:27:13', '2024-12-18 22:27:13', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734535633/dxxgyztko4tbrn5yvb2j.jpg', 1);
INSERT INTO `posters` VALUES (195, 'Ngô Quan Anh Khoa', 'khoangoquan@gmail.com', '0986641965', '2024-12-18 22:42:32', '2024-12-18 22:42:32', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734536553/usciduig3qikcrq8ytxw.jpg', 1);
INSERT INTO `posters` VALUES (197, 'Ngô Quan Anh Khoa', 'khoangoquan@gmail.com', '0986641965', '2024-12-20 17:08:22', '2024-12-20 17:08:22', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734689305/uk0mbjcrhio1io6nmwuu.jpg', 6);
INSERT INTO `posters` VALUES (198, 'Ngô Quan Anh Khoa', 'khoangoquan@gmail.com', '0986641965', '2024-12-20 17:16:56', '2024-12-20 17:16:56', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734689820/zbugovno1a86zgvrxkfw.jpg', 6);
INSERT INTO `posters` VALUES (199, 'Ngô Quan Anh Khoa', 'khoangoquan@gmail.com', '0986641965', '2024-12-20 17:20:13', '2024-12-20 17:20:13', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734690016/zqxyp8b1ndluljch3r4k.jpg', 6);
INSERT INTO `posters` VALUES (200, 'khoangoquan', 'khoangoquan@gmail.com', '0986641965', '2024-12-20 17:21:43', '2024-12-20 17:21:43', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734690106/hjvddby0vo3war815ou0.jpg', 6);
INSERT INTO `posters` VALUES (201, 'khoangoquan', 'khoangoquan@gmail.com', '0986641965', '2024-12-20 17:40:53', '2024-12-20 17:40:53', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734691256/yfg1blatu5sj4q4jdglz.jpg', 6);
INSERT INTO `posters` VALUES (202, 'khoangoquan', 'khoangoquan@gmail.com', '0986641965', '2024-12-20 17:49:49', '2024-12-20 17:49:49', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734691792/ju7hebtvsvcjakyfv4rk.jpg', 6);
INSERT INTO `posters` VALUES (203, 'khoangoquan', 'khoangoquan@gmail.com', '0986641965', '2024-12-20 18:44:14', '2024-12-20 18:44:14', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734695058/pbf4p1ibynymz3l4eojd.jpg', 6);
INSERT INTO `posters` VALUES (204, 'khoangoquan', 'khoangoquan@gmail.com', '0986641965', '2024-12-20 18:44:38', '2024-12-20 18:44:38', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734695083/tmxvkhzlqurgbnmabf60.webp', 6);
INSERT INTO `posters` VALUES (205, 'khoangoquan', 'khoangoquan@gmail.com', '0986641965', '2024-12-20 19:32:42', '2024-12-20 19:32:42', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734697966/zk2zxv7kq7vpdfdgrzef.jpg', 6);
INSERT INTO `posters` VALUES (206, 'khoangoquan', 'khoangoquan@gmail.com', '0986641965', '2024-12-20 19:36:56', '2024-12-20 19:36:56', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734698220/ydlscrl4e81ewuwlzev2.png', 6);
INSERT INTO `posters` VALUES (207, 'khoangoquan', 'khoangoquan@gmail.com', '0986641965', '2024-12-24 14:29:33', '2024-12-24 14:29:33', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1735025372/axjobcfyjhmlu4q40e7v.jpg', 6);
INSERT INTO `posters` VALUES (216, 'khoangoquan', 'khoangoquan@gmail.com', '0986641965', '2024-12-27 15:19:06', '2024-12-27 15:19:06', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1735287547/ewgofcahxwgyddotzc7k.jpg', 1);

-- ----------------------------
-- Table structure for properties
-- ----------------------------
DROP TABLE IF EXISTS `properties`;
CREATE TABLE `properties`  (
  `property_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `price` decimal(15, 2) NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `area` decimal(15, 2) NULL DEFAULT NULL,
  `poster_id` int(11) NULL DEFAULT NULL,
  `available` tinyint(4) NULL DEFAULT 1,
  PRIMARY KEY (`property_id`) USING BTREE,
  INDEX `fk_poster`(`poster_id` ASC) USING BTREE,
  CONSTRAINT `fk_poster` FOREIGN KEY (`poster_id`) REFERENCES `posters` (`poster_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 341 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of properties
-- ----------------------------
INSERT INTO `properties` VALUES (1, 'Tòa Nhà Sky Tower', 'Tòa nhà chọc trời hiện đại với thiết kế kiến trúc độc đáo, Sky Tower nổi bật giữa trung tâm thành phố. Với 30 tầng, tòa nhà cung cấp không gian làm việc và sinh hoạt tiện nghi, cùng với tầm nhìn tuyệt đẹp ra toàn cảnh thành phố.', 100.00, '234 Lê Văn Sỹ, Bình Tân, TP HCM', 'Nhà ở', '1', '2024-11-06 23:22:23', '2024-12-17 20:43:22', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734443002/spfrtx23swwekhmsrqff.webp', 50.00, 1, 1);
INSERT INTO `properties` VALUES (2, 'Tòa Nhà Green Living', 'Tòa nhà được thiết kế theo tiêu chí xanh, tích hợp nhiều công nghệ tiết kiệm năng lượng và thân thiện với môi trường. Green Living cung cấp các căn hộ hiện đại với sân vườn và không gian xanh, mang lại cảm giác gần gũi với thiên nhiên', 20.00, '234 Lê Văn Sỹ, Bình Tân, TP HCM', 'Căn hộ', '1', '2024-11-06 23:22:23', '2024-12-09 12:19:51', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733721592/zwpbbs2m3bk7kmm31jap.webp', 75.00, 2, 1);
INSERT INTO `properties` VALUES (3, 'Tòa Nhà Luxury Residence', 'Luxury Residence là tòa nhà cao cấp với các căn hộ sang trọng và tiện nghi đẳng cấp 5 sao. Tòa nhà có hồ bơi vô cực, phòng tập gym hiện đại, và dịch vụ quản lý chuyên nghiệp, phục vụ nhu cầu sống đẳng cấp của cư dân.', 30.00, '101 Hoàng Thị Loan, Quảng Trị', 'Biệt thự', '1', '2024-11-06 23:22:23', '2024-11-08 21:16:24', 'https://th.bing.com/th/id/OIP.cpkTLIbDFzRuNgrl6vMTowHaEW?pid=ImgDet&w=474&h=278&rs=1', 100.00, 3, 1);
INSERT INTO `properties` VALUES (4, 'Tòa Nhà Business Center', 'Tòa Nhà Business Center là trung tâm thương mại và văn phòng hiện đại, cung cấp các văn phòng cho thuê linh hoạt và các dịch vụ hỗ trợ doanh nghiệp. Với vị trí thuận lợi, tòa nhà là nơi lý tưởng cho các công ty khởi nghiệp và doanh nghiệp vừa và nhỏ.', 40.00, '999 Quốc Hương, Quận 2, TP HCM', 'Nhà phố', '2', '2024-11-06 23:22:23', '2024-11-08 21:31:32', 'https://th.bing.com/th/id/OIP.kx7Tdclm2qF2IJo1Jb3nvQHaEw?w=344&h=182&c=7&r=0&o=5&dpr=1.5&pid=1.7', 120.00, 7, 1);
INSERT INTO `properties` VALUES (5, 'Tòa Nhà Ocean View', 'Tòa nhà nằm ngay bên bờ biển, Ocean View cung cấp tầm nhìn đẹp.', 50.00, '789 Trần Hưng Đạo, Hà Nội', 'Khu nghỉ dưỡng', '1', '2024-11-06 23:22:23', '2024-12-09 11:59:06', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733720346/xgz6bnje5ysd84qjhxh1.jpg', 80.00, 8, 1);
INSERT INTO `properties` VALUES (6, 'Nhà phố rộng rãi có sân vườn', 'Ngôi nhà rộng rãi với sân vườn thoáng mát, gần công viên.', 30.00, '456 Đường Nguyễn Huệ, Quận 2, TP.HCM', 'house', '2', '2024-10-21 23:50:42', '2024-11-08 21:16:46', 'https://sieuthibanve.com/upload/images/202202/220757-products-2021-07-07-1625648623-oo.png', 150.00, 9, 1);
INSERT INTO `properties` VALUES (7, 'Đất nền khu dân cư mới', 'Lô đất nền nằm trong khu dân cư đang phát triển, phù hợp đầu tư lâu dài.', 28.00, '789 Đường Nguyễn Văn Cừ, Quận 7, TP.HCM', 'land', '3', '2024-10-21 23:50:42', '2024-11-07 00:06:07', 'https://i.pinimg.com/736x/f6/44/db/f644db98d8a832188024ea769dbc7b0b--diy-art-home-design.jpg', 120.00, 10, 1);
INSERT INTO `properties` VALUES (8, 'Mặt bằng kinh doanh tại trung tâm', 'Mặt bằng kinh doanh rộng rãi, gần các trung tâm mua sắm lớn.', 12.00, '12 Đường Nguyễn Trãi, Quận 5, TP.HCM', 'commercial', '2', '2024-10-21 23:50:42', '2024-11-08 21:35:24', 'https://th.bing.com/th/id/OIP.vWgKZ-gTouIU1anMcWSImgHaHa?pid=ImgDet&w=178&h=178&c=7&dpr=1.5', 200.00, 11, 1);
INSERT INTO `properties` VALUES (13, 'Biệt thự ven biển Đà Nẵng', 'Biệt thự hướng biển tuyệt đẹp', 30.00, '789 Võ Nguyên Giáp, Đà Nẵng', 'apartment', '3', '2024-10-22 19:12:45', '2024-12-05 22:09:44', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733411385/pfcissgdo5hucrbot3yc.jpg', 600.00, 12, 1);
INSERT INTO `properties` VALUES (14, 'Căn hộ mini Đà Nẵng', 'Căn hộ dành cho sinh viên', 10.00, '123 Nguyễn Văn Linh, Đà Nẵng', 'apartment', '1', '2024-10-22 19:12:45', '2024-11-06 23:39:00', 'https://i.pinimg.com/originals/ac/9e/3e/ac9e3e2fdf8fdd3784fa9fe123bec8fa.jpg', 50.00, 13, 1);
INSERT INTO `properties` VALUES (15, 'Nhà phố quận 2', 'Nhà phố gần cầu Thủ Thiêm', 20.00, '555 Trần Nao, Quận 2, TP HCM', 'apartment', '2', '2024-10-22 19:12:45', '2024-11-08 21:18:06', 'https://media.batdongsan.vn/crop/300x200/projects/20180719154500-7456.jpg', 140.00, 14, 1);
INSERT INTO `properties` VALUES (16, 'Nhà cấp 4 vùng quê Bạc Liêu', 'Nhà vùng quê, mở cửa thấy đồng ruộng', 100.00, '456 Điện Biên Phủ, Bạc Liêu', 'apartment', '1', '2024-10-22 19:12:45', '2024-11-06 23:38:58', 'https://th.bing.com/th/id/OIP.fjqwHfpCEbrpZXaW1cLCKAAAAA?rs=1&pid=ImgDetMain', 210.00, 15, 1);
INSERT INTO `properties` VALUES (17, 'Biệt thự Thảo Điền', 'Biệt thự sân vườn rộng', 30.00, '999 Quốc Hương, Quận 2, TP HCM', 'apartment', '2', '2024-10-22 19:12:45', '2024-11-08 21:19:17', 'https://media.batdongsan.vn/posts/123860_672dfdb1a5abe.jpg', 450.00, 16, 1);
INSERT INTO `properties` VALUES (18, 'Nhà liền kề Đồng Nai', 'Nhà liền kề giá tốt, gần khu công nghiệp', 10.00, '456 Biên Hòa, Đồng Nai', 'apartment', '1', '2024-10-22 19:12:45', '2024-11-06 23:38:55', 'https://i.pinimg.com/originals/c5/3f/7f/c53f7f7ed6ca13f7e70c7ca5c9a9bf0a.jpg', 180.00, 17, 1);
INSERT INTO `properties` VALUES (19, 'Căn hộ mới ở Bình Tân', 'Căn hộ dành cho gia đình trẻ', 10.00, '234 Lê Văn Sỹ, Bình Tân, TP HCM', 'project', '3', '2024-10-22 19:12:45', '2024-11-08 21:18:32', 'https://media.batdongsan.vn/posts/123849_672de1315ce2c.jpg', 90.00, 18, 1);
INSERT INTO `properties` VALUES (20, 'Nhà phố Vinhomes', 'Nhà phố khu đô thị Vinhomes', 20.00, '123 Vinhomes Central Park, TP HCM', 'project', '1', '2024-10-22 19:12:45', '2024-11-08 21:20:13', 'https://media.batdongsan.vn/posts/123860_672dfdb1a7b72.jpg', 190.00, 19, 1);
INSERT INTO `properties` VALUES (21, 'Biệt thự sang trọng', 'Biệt thự đẹp với sân vườn rộng rãi', 22.00, '123 Hoàng Diệu, Đà Nẵng', 'project', '2', '2024-10-22 19:12:45', '2024-11-08 21:20:15', 'https://media.batdongsan.vn/crop/800x600/projects/20181220133156-28e6.jpg', 350.00, 20, 1);
INSERT INTO `properties` VALUES (22, 'Căn hộ cao cấp', 'Căn hộ view biển tại Vũng Tàu', 22.00, '234 Lê Văn Sỹ, Bình Tân, TP HCM', 'project', '3', '2024-10-22 19:12:45', '2024-11-08 21:29:26', 'https://th.bing.com/th/id/OIP.Y8T-ohZfLyyLol5NP4Q0mAHaEC?w=290&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7', 250.00, 21, 1);
INSERT INTO `properties` VALUES (23, 'Nhà phố Đà Lạt', 'Nhà phố gần chợ, thích hợp kinh doanh', 15.00, '789 Phan Đình Phùng, Đà Lạt', 'project', '1', '2024-10-22 19:12:45', '2024-11-08 21:19:12', 'https://media.batdongsan.vn/posts/123861_672e009e181ad.jpg', 150.00, 22, 1);
INSERT INTO `properties` VALUES (24, 'Nhà cấp 4 vùng quê', 'Nhà rộng rãi tại vùng nông thôn, thích hợp nghỉ dưỡng', 17.00, '101 Hoàng Thị Loan, Quảng Trị', 'project', '1', '2024-10-22 19:12:45', '2024-11-06 23:38:46', 'https://th.bing.com/th/id/OIP.zZIVTP6fM3xDCYJTbYi5IAHaE8?rs=1&pid=ImgDetMain', 200.00, 23, 1);
INSERT INTO `properties` VALUES (39, 'Nhà cấp 4 vùng quê', 'Nhà rộng rãi tại vùng nông thôn, thích hợp nghỉ dưỡng', 30.00, '101 Hoàng Thị Loan, Quảng Trị', 'project', '1', '2024-10-24 21:23:29', '2024-11-08 21:20:36', 'https://file4.batdongsan.com.vn/2018/12/20/hmcVYWuR/20181220140319-5dfe.jpg', 100.00, 24, 1);
INSERT INTO `properties` VALUES (40, 'Chung cư cao cấp', 'Chung cư hiện đại, đầy đủ tiện nghi', 45.00, '456 Nguyễn Huệ, TP.HCM', 'Nhà phố', '2', '2024-10-24 21:23:29', '2024-12-30 21:06:01', 'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2021/6/18/921746/ANH-BAT-DONG-SAN-COV.jpg', 75.00, 25, 1);
INSERT INTO `properties` VALUES (41, 'Đất nền dự án', 'Đất nền khu vực trung tâm, tiềm năng phát triển cao', 35.00, '789 Trần Hưng Đạo, Hà Nội', 'Nhà phố', '1', '2024-10-24 21:23:29', '2024-12-30 21:06:00', 'https://bds.com.vn/images/products/2024/11/small/z6003905903271_a1e2cdd24a1e56f4ecb915559dbd7746.jpg', 150.00, 26, 1);
INSERT INTO `properties` VALUES (42, 'Biệt thự ven biển', 'Biệt thự sang trọng gần biển', 50.00, '123 Lê Lợi, Đà Nẵng', 'Nhà phố', '2', '2024-10-24 21:23:29', '2024-12-30 21:06:00', 'https://bds.com.vn/images/products/2024/11/small/1_1730796495_1.jpg', 300.00, 27, 1);
INSERT INTO `properties` VALUES (43, 'Nhà cấp 4 vùng quê', 'Nhà rộng rãi tại vùng nông thôn, thích hợp nghỉ dưỡng', 30.00, '101 Hoàng Thị Loan, Quảng Trị', 'Nhà phố', '1', '2024-10-24 21:23:35', '2024-12-30 21:05:59', 'https://bds.com.vn/images/products/2024/11/small/464691593_1970426023432173_2592127157516697485_n.jpg', 100.00, 1, 1);
INSERT INTO `properties` VALUES (44, 'Chung cư cao cấp', 'Chung cư hiện đại, đầy đủ tiện nghi', 45.00, '456 Nguyễn Huệ, TP.HCM', 'Nhà phố', '2', '2024-10-24 21:23:35', '2024-12-30 21:05:58', 'https://bds.com.vn/images/products/2024/11/small/z5959499788756_2fa53d5a876abd79267e46a5f04cac98.jpg', 75.00, 2, 1);
INSERT INTO `properties` VALUES (45, 'Đất nền dự án', 'Đất nền khu vực trung tâm, tiềm năng phát triển cao', 35.00, '789 Trần Hưng Đạo, Hà Nội', 'Nhà phố', '1', '2024-10-24 21:23:35', '2024-12-30 21:05:58', 'https://bds.com.vn/images/products/2024/11/small/1_1730967771_1.jpg', 150.00, 3, 1);
INSERT INTO `properties` VALUES (46, 'Biệt thự ven biển', 'Biệt thự sang trọng gần biển', 50.00, '123 Lê Lợi, Đà Nẵng', 'Nhà phố', '1', '2024-10-24 21:23:35', '2024-12-30 21:05:57', 'https://bds.com.vn/images/products/2024/10/small/5a5dd070-af73-4b05-9289-cf34a904bd2c.jpg', 300.00, 31, 1);
INSERT INTO `properties` VALUES (47, 'Nhà cấp 4 vùng quê', 'Nhà rộng rãi tại vùng nông thôn, thích hợp nghỉ dưỡng', 30.00, '101 Hoàng Thị Loan, Quảng Trị', 'Nhà phố', '2', '2024-10-24 21:23:36', '2024-12-30 21:05:52', 'https://bds.com.vn/images/products/2024/10/small/z5944888726512_66a2f95ec7f3718a0cd26261e4cba645.jpg', 100.00, 1, 1);
INSERT INTO `properties` VALUES (48, 'Chung cư cao cấp', 'Chung cư hiện đại, đầy đủ tiện nghi', 45.00, '456 Nguyễn Huệ, TP.HCM', 'Nhà phố', '1', '2024-10-24 21:23:36', '2024-12-30 21:05:52', 'https://i1-vnexpress.vnecdn.net/2024/11/07/n1-1730972241-1164-1730972333.jpg?w=300&h=180&q=100&dpr=2&fit=crop&s=oX7Wdnzck2BxH9jYAm4myQ', 75.00, 2, 1);
INSERT INTO `properties` VALUES (49, 'Đất nền dự án', 'Đất nền khu vực trung tâm, tiềm năng phát triển cao', 35.00, '789 Trần Hưng Đạo, Hà Nội', 'nha dat  ', '2', '2024-10-24 21:23:36', '2024-12-07 23:29:43', 'https://i1-vnexpress.vnecdn.net/2024/11/07/hinh-2-1730968333-4320-1730972489.jpg?w=300&h=180&q=100&dpr=2&fit=crop&s=dA6R4E7CEX7KnibKAMQ4Jw', 150.00, 2, 1);
INSERT INTO `properties` VALUES (50, 'Biệt thự ven biển', 'Biệt thự sang trọng gần biển', 50.00, '123 Lê Lợi, Đà Nẵng', 'Nhà phố', '2', '2024-10-24 21:23:36', '2024-12-30 21:05:50', 'https://i1-vnexpress.vnecdn.net/2024/11/08/picture1-1731067042-5215-1731067087.jpg?w=240&h=144&q=100&dpr=2&fit=crop&s=whP10BjAdJUEa3fF5aIMLA', 300.00, 1, 1);
INSERT INTO `properties` VALUES (51, 'Nhà cấp 4 vùng quê', 'Nhà rộng rãi tại vùng nông thôn, thích hợp nghỉ dưỡng', 30.00, '101 Hoàng Thị Loan, Quảng Trị', 'Nhà phố', '3', '2024-10-24 21:23:37', '2024-12-30 21:05:37', 'https://i1-vnexpress.vnecdn.net/2024/11/07/b1-1730972624-1730978274.jpg?w=240&h=144&q=100&dpr=2&fit=crop&s=47u9oceq3baYQ5R4R5Kk4Q', 100.00, 31, 1);
INSERT INTO `properties` VALUES (52, 'Chung cư cao cấp', 'Chung cư hiện đại, đầy đủ tiện nghi', 45.00, '456 Nguyễn Huệ, TP.HCM', 'Nhà phố', '1', '2024-10-24 21:23:37', '2024-12-30 21:05:38', 'https://i1-kinhdoanh.vnecdn.net/2024/11/05/dji-20241003102605-0066-d-enha-8156-2437-1730813924.jpg?w=240&h=144&q=100&dpr=2&fit=crop&s=PLZ0EMsEP2IoLnNW1o-Chg', 75.00, 1, 1);
INSERT INTO `properties` VALUES (53, 'Đất nền dự án', 'Đất nền khu vực trung tâm, tiềm năng phát triển cao', 35.00, '789 Trần Hưng Đạo, Hà Nội', 'Nhà phố', '2', '2024-10-24 21:23:37', '2024-12-30 21:05:38', 'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2021/6/18/921746/ANH-BAT-DONG-SAN-COV.jpg', 150.00, 2, 1);
INSERT INTO `properties` VALUES (54, 'Biệt thự ven biển', 'Biệt thự sang trọng gần biển', 50.00, '123 Lê Lợi, Đà Nẵng', 'Nhà phố', '3', '2024-10-24 21:23:37', '2024-12-30 21:05:36', 'https://bds.com.vn/images/products/2022/08/small/z3682786268626_14b1157ab419ab36095581375bfe64be_1661849171_1.jpg', 300.00, 3, 1);
INSERT INTO `properties` VALUES (55, 'Nhà cấp 4 vùng quê', 'Nhà rộng rãi tại vùng nông thôn, thích hợp nghỉ dưỡng', 30.00, '101 Hoàng Thị Loan, Quảng Trị', 'Nhà phố', '2', '2024-10-24 21:23:37', '2024-12-30 21:05:36', 'https://bds.com.vn/images/products/2022/08/small/289437193_144623198162827_2658448467521217615_n.jpg', 100.00, 7, 1);
INSERT INTO `properties` VALUES (56, 'Chung cư cao cấp', 'Chung cư hiện đại, đầy đủ tiện nghi', 45.00, '456 Nguyễn Huệ, TP.HCM', 'Nhà phố', '3', '2024-10-24 21:23:37', '2024-12-30 21:05:34', 'https://bds.com.vn/images/products/2022/08/small/d2.jpg', 75.00, 8, 1);
INSERT INTO `properties` VALUES (57, 'Đất nền dự án', 'Đất nền khu vực trung tâm, tiềm năng phát triển cao', 35.00, '789 Trần Hưng Đạo, Hà Nội', 'Nhà phố', '1', '2024-10-24 21:23:37', '2024-12-30 21:05:33', 'https://bds.com.vn/images/products/2022/08/small/z3580634621376_fa0b03bf8c05472d0dc07aae89cdb0c2.jpg', 150.00, 9, 1);
INSERT INTO `properties` VALUES (58, 'Biệt thự ven biển', 'Biệt thự sang trọng gần biển', 50.00, '123 Lê Lợi, Đà Nẵng', 'Nhà phố', '2', '2024-10-24 21:23:37', '2024-12-30 21:05:32', 'https://bds.com.vn/images/products/2022/08/small/300828494_1248475849300515_6614460256427424476_n_1661563948_1.jpg', 300.00, 10, 1);
INSERT INTO `properties` VALUES (59, 'Nhà cấp 4 vùng quê', 'Nhà rộng rãi tại vùng nông thôn, thích hợp nghỉ dưỡng', 30.00, '101 Hoàng Thị Loan, Quảng Trị', 'Khu nghỉ dưỡng', '3', '2024-10-24 21:23:37', '2024-12-30 21:05:30', 'https://bds.com.vn/images/products/2022/08/small/269865788_2448898655243643_8857017111725479234_n.jpg', 100.00, 2, 1);
INSERT INTO `properties` VALUES (60, 'Chung cư cao cấp', 'Chung cư hiện đại, đầy đủ tiện nghi', 45.00, '456 Nguyễn Huệ, TP.HCM', 'Khu nghỉ dưỡng', '3', '2024-10-24 21:23:37', '2024-12-30 21:05:28', 'https://bds.com.vn/images/products/2022/08/small/z3671330558218_a3964271bf368deda97300218056c41a.jpg', 75.00, 1, 1);
INSERT INTO `properties` VALUES (61, 'Đất nền dự án', 'Đất nền khu vực trung tâm, tiềm năng phát triển cao', 35.00, '789 Trần Hưng Đạo, Hà Nội', 'Nhà phố', '2', '2024-10-24 21:23:37', '2024-12-30 21:05:24', 'https://bds.com.vn/images/products/2022/08/small/1e45086b9253570d0e42.jpg', 150.00, 2, 1);
INSERT INTO `properties` VALUES (62, 'Biệt thự ven biển', 'Biệt thự sang trọng gần biển', 50.00, '123 Lê Lợi, Đà Nẵng', 'Căn hộ', '1', '2024-10-24 21:23:37', '2024-12-30 21:05:22', 'https://bds.com.vn/images/products/2022/08/small/z3313876333368_62f62823413373760a90ae534066125f.jpg', 300.00, 3, 1);
INSERT INTO `properties` VALUES (63, 'Nhà cấp 4 vùng quê', 'Nhà rộng rãi tại vùng nông thôn, thích hợp nghỉ dưỡng', 30.00, '101 Hoàng Thị Loan, Quảng Trị', 'Nhà ở', '3', '2024-10-24 21:23:38', '2024-12-30 21:05:20', 'https://bds.com.vn/images/products/2022/08/small/z3665708373769_a8040209d5b45e30bcefa24016a31b73.jpg', 100.00, 7, 1);
INSERT INTO `properties` VALUES (64, 'Chung cư cao cấp', 'Chung cư hiện đại, đầy đủ tiện nghi', 45.00, '456 Nguyễn Huệ, TP.HCM', 'Biệt thự', '1', '2024-10-24 21:23:38', '2024-12-30 21:05:19', 'https://bds.com.vn/images/products/2022/08/small/z3593262472742_593aefd71255ecb1b3df33e4fa99d5da.jpg', 75.00, 2, 1);
INSERT INTO `properties` VALUES (65, 'Đất nền dự án', 'Đất nền khu vực trung tâm, tiềm năng phát triển cao', 35.00, '789 Trần Hưng Đạo, Hà Nội', 'Biệt thự', '3', '2024-10-24 21:23:38', '2024-12-30 21:05:18', 'https://bds.com.vn/images/products/2022/08/small/6bbc2e28a1db6f8536ca.jpg', 150.00, 1, 1);
INSERT INTO `properties` VALUES (75, 'Nhà cấp 4 vùng quê ngoè khó đó', NULL, 12.00, '365 Võ nguyên giáp', 'Biệt thự', '3', '2024-11-01 18:14:11', '2024-12-19 17:06:24', 'https://bds.com.vn/images/products/2022/08/small/298205796_611983333757177_6254216012357455482_n.jpg', 100.00, 2, 1);
INSERT INTO `properties` VALUES (76, 'Nhà cấp 4 vùng quê ngoè khó đó', NULL, 12.00, '365 Võ nguyên giáp', 'Biệt thự', '1', '2024-11-01 18:16:38', '2024-12-30 21:05:17', 'https://bds.com.vn/images/products/2022/08/small/a12.jpg', 100.00, 3, 1);
INSERT INTO `properties` VALUES (77, 'Nhà cấp 4 vùng quê ngoè khó đó', NULL, 12.00, '365 Võ nguyên giáp', 'Biệt thự', '2', '2024-11-01 18:19:58', '2024-12-30 21:05:17', 'https://bds.com.vn/images/products/2022/08/small/z3585908069924_946ed1c7302c4a5f3c431fea74edac7f.jpg', 100.00, 1, 1);
INSERT INTO `properties` VALUES (79, 'Nhà cấp 4 vùng quê ngoè khó đó 123333', 'gahahahahaha123123123', 30.00, '365 Võ nguyên giáp', 'house', '3', '2024-11-01 19:42:30', '2024-12-07 22:37:11', 'https://bds.com.vn/images/products/2022/08/small/299118248_592137952397650_2941227279989738067_n.jpg', 100.00, 2, 1);
INSERT INTO `properties` VALUES (80, 'Nhà 1', 'Mô tả cho Nhà 1', 100.00, 'Địa chỉ Nhà 1', 'Nhà ở', '1', '2024-11-06 23:21:20', '2024-12-07 22:37:14', 'https://bds.com.vn/images/products/2023/08/small/291540197_2951683408454929_1222724089350958978_n.jpg', 50.00, 1, 1);
INSERT INTO `properties` VALUES (81, 'Nhà 2', 'Mô tả cho Nhà 2', 200.00, 'Địa chỉ Nhà 2', 'Căn hộ', '2', '2024-11-06 23:21:20', '2024-12-07 22:37:15', 'https://bds.com.vn/images/products/2022/09/small/z3692452328082_376756e966b92cccdcd757e3c57add90.jpg', 75.00, 2, 1);
INSERT INTO `properties` VALUES (82, 'Nhà 3', 'Mô tả cho Nhà 3', 300.00, 'Địa chỉ Nhà 3', 'Biệt thự', '3', '2024-11-06 23:21:20', '2024-12-07 22:37:17', 'https://bds.com.vn/images/products/2023/02/small/z4108552970301_8ad96c24371ea13df77a90df6464d8f5.jpg', 100.00, 1, 1);
INSERT INTO `properties` VALUES (83, 'Nhà 4', 'Mô tả cho Nhà 4', 400.00, 'Địa chỉ Nhà 4', 'Nhà phố', '2', '2024-11-06 23:21:20', '2024-12-07 22:37:18', 'https://bds.com.vn/images/products/2022/08/small/298960119_721430909019286_4401041735667710977_n_1660707945_1.jpg', 120.00, 2, 1);
INSERT INTO `properties` VALUES (84, 'Nhà 5', 'Mô tả cho Nhà 5', 500.00, 'Địa chỉ Nhà 5', 'Khu nghỉ dưỡng', '1', '2024-11-06 23:21:20', '2024-12-07 22:37:19', 'https://bds.com.vn/images/products/2024/10/small/z5944888726512_66a2f95ec7f3718a0cd26261e4cba645.jpg', 80.00, 1, 1);
INSERT INTO `properties` VALUES (85, 'Rangel Crest', 'Căn hộ tiện nghi, gần trung tâm, giao thông thuận lợi.', 80.00, '123 Đường Hoa Lan, Phường 2, Quận Phú Nhuận, TP. HCM', 'Đất nền', '3', '2024-01-26 05:35:10', '2024-12-05 12:48:57', 'https://th.bing.com/th/id/OIP.ZDwA5SFBwVRw0ROYNwxe9gAAAA?pid=ImgDet&w=178&h=133&c=7&dpr=1.5', 150.00, 1, 1);
INSERT INTO `properties` VALUES (86, 'Campbell Hill', 'Nhà phố 2 tầng, không gian rộng, nội thất hiện đại.', 70.00, '56 Đường Lý Thường Kiệt, Phường 12, Quận Tân Bình, TP. HCM', 'Đất nền', '2', '2024-11-05 21:42:00', '2024-12-05 12:48:54', 'https://th.bing.com/th/id/OIP.NezsjFMyzx-pvKG4-oX92QHaFB?pid=ImgDet&w=178&h=120&c=7&dpr=1.5', 114.00, 2, 1);
INSERT INTO `properties` VALUES (87, 'Dwayne Corners', 'Đất nền có tiềm năng, pháp lý rõ ràng.', 90.00, '789 Đường Nguyễn Văn Cừ, Quận 1, TP. HCM', 'Nhà phố', '2', '2024-03-14 02:11:24', '2024-12-05 12:48:58', 'https://th.bing.com/th/id/OIP.98bE-LwtdH8YHQRDM6dLHAAAAA?pid=ImgDet&w=178&h=133&c=7&dpr=1.5', 103.02, 3, 1);
INSERT INTO `properties` VALUES (88, 'Matthew Lights', 'Phòng làm việc thoáng mát, tiện nghi, giá hợp lý.', 100.00, '90 Đường Lê Lợi, Quận 3, TP. HCM', 'Văn phòng', '3', '2024-01-02 21:02:24', '2024-12-05 12:48:59', 'https://th.bing.com/th/id/OIP.t1tIRmnWzV5B58jIEoLybAHaEn?pid=ImgDet&w=178&h=110&c=7&dpr=1.5', 45.00, 11, 1);
INSERT INTO `properties` VALUES (89, 'Barr Land', 'Văn phòng cho thuê, vị trí đắc địa, đầy đủ nội thất.', 120.00, '102 Đường Bạch Đằng, Quận Bình Thạnh, TP. HCM', 'Căn hộ', '1', '2024-05-21 13:34:34', '2024-12-05 12:48:59', 'https://th.bing.com/th/id/OIP.vlQojNVM49rZGVJPlD9TaAHaDn?rs=1&pid=ImgDetMain', 120.00, 15, 1);
INSERT INTO `properties` VALUES (90, 'Johnson Dale', 'Biệt thự sân vườn, yên tĩnh, phong thủy tốt.', 140.00, '12 Đường Trường Sa, Quận Gò Vấp, TP. HCM', 'Nhà phố', '2', '2024-02-18 07:41:20', '2024-12-05 12:49:00', 'https://3dwarehouse.sketchup.com/warehouse/v1.0/content/public/0cc2629a-51f2-4efb-8b98-cf677cbbaed8', 85.00, 16, 1);
INSERT INTO `properties` VALUES (91, 'Miller Square', 'Căn hộ cao cấp, view đẹp, khu vực an ninh.', 200.00, '35 Đường Phan Đăng Lưu, Quận Phú Nhuận, TP. HCM', 'Căn hộ', '3', '2024-08-12 17:23:13', '2024-12-05 12:49:00', 'https://th.bing.com/th/id/OIP.01bKAHu5aSV__uYnQq0tCAHaEo?pid=ImgDet&w=178&h=111&c=7&dpr=1.5', 65.00, 7, 1);
INSERT INTO `properties` VALUES (92, 'Green Ridge', 'Nhà trọ gần trường, đầy đủ tiện nghi.', 90.00, '67 Đường Võ Văn Kiệt, Quận 5, TP. HCM', 'Nhà phố', '1', '2024-03-19 14:12:05', '2024-12-05 12:49:01', 'https://th.bing.com/th/id/OIP.rgDFlS7oTYtt7O3JnKRsFQHaHa?pid=ImgDet&w=178&h=178&c=7&dpr=1.5', 40.40, 8, 1);
INSERT INTO `properties` VALUES (93, 'White Lake', 'Đất mặt tiền, thuận tiện kinh doanh, sổ đỏ chính chủ.', 75.00, '89 Đường Nguyễn Trãi, Quận 7, TP. HCM', 'Đất nền', '2', '2024-07-25 16:40:59', '2024-12-05 12:49:01', 'https://th.bing.com/th/id/OIP.xuEE65aaNHyXNF0nsnTcqgHaF1?pid=ImgDet&w=178&h=140&c=7&dpr=1.5', 99.00, 9, 1);
INSERT INTO `properties` VALUES (94, 'Sunny Valley', 'Chung cư mini, thiết kế hợp lý, gần khu mua sắm.', 76.00, '45 Đường Hoàng Sa, Quận Tân Bình, TP. HCM', 'Căn hộ', '3', '2024-04-09 10:55:42', '2024-12-05 12:49:02', 'https://th.bing.com/th/id/OIP.k8nATvu-4HGpIPLvIt4M2gHaE8?pid=ImgDet&w=178&h=118&c=7&dpr=1.5', 50.00, 10, 1);
INSERT INTO `properties` VALUES (95, 'Sản phẩm 1', 'Căn hộ cao cấp với thiết kế hiện đại, đầy đủ tiện nghi.', 2500.00, 'Tòa nhà Sunrise, 120 Nguyễn Văn Cừ, Quận 1, TP.HCM', 'Căn hộ', '1', '2024-11-09 08:13:41', '2024-12-07 22:37:22', 'https://media.batdongsan.vn/posts/14-161-25-175-z4512238441430-2a13f3f36d000fe167e92e6fe148ea45.jpg', 45.00, 2, 1);
INSERT INTO `properties` VALUES (96, 'Sản phẩm 2', 'Nhà phố 3 tầng, thiết kế sang trọng, có sân vườn rộng', 270.00, 'Khu dân cư Green Park, 56 Đường số 5, Phường 3, Quận Tân Bình, TP.HCM', 'Nhà phố', '2', '2024-11-09 08:13:41', '2024-12-07 22:37:24', 'https://media.batdongsan.vn/crop/266x150/posts/14-191-32-226-315642204-6535708546446553-1811349874649622939-n.jpg', 80.00, 3, 1);
INSERT INTO `properties` VALUES (97, 'Sản phẩm 3', 'Biệt thự với sân vườn xanh mát, hồ bơi riêng biệt.', 230.00, 'Khu biệt thự Vinhome Central Park, 45 Lê Đức Thọ, Phường 13, Quận Gò Vấp, TP.HCM', 'Biệt thự', '2', '2024-11-09 08:13:41', '2024-12-07 22:37:26', 'https://media.batdongsan.vn/crop/266x150/posts/103-199-56-193-ban-nha-thoai-ngoc-hau-tan-phu-2.jpg', 120.00, 7, 1);
INSERT INTO `properties` VALUES (98, 'Sản phẩm 4', 'Căn hộ 2 phòng ngủ rộng rãi, nội thất đầy đủ, thuận tiện di chuyển đến các khu thương mại lớn.', 210.00, 'Tòa nhà Diamond Plaza, 26 Lê Duẩn, Quận 1, TP.HCM', 'Căn hộ', '3', '2024-11-09 08:13:41', '2024-12-07 22:37:27', 'https://media.batdongsan.vn/crop/266x150/posts/42-112-79-186-1.jpg', 60.00, 8, 1);
INSERT INTO `properties` VALUES (99, 'Sản phẩm 5', 'Nhà phố 2 mặt tiền, diện tích rộng, thuận tiện kinh doanh hoặc cho thuê', 250.00, '109 Nguyễn Thị Minh Khai, Phường 6, Quận 3, TP.HCM', 'Nhà phố', '3', '2024-11-09 08:13:41', '2024-12-07 22:37:28', 'https://media.batdongsan.vn/crop/266x150/posts/42-114-32-193-213.jpg', 95.00, 2, 1);
INSERT INTO `properties` VALUES (100, 'Sản phẩm 6', 'Căn hộ cao cấp với không gian sống thoáng đãng, tiện ích nội khu đầy đủ như phòng gym, hồ bơi.', 260.00, 'Tòa nhà Park Hill, 32 Lý Thường Kiệt, Quận Tân Bình, TP.HCM', 'Căn hộ', '1', '2024-11-09 08:13:41', '2024-12-07 22:37:32', 'https://media.batdongsan.vn/crop/266x150/posts/42-114-32-193-213.jpg', 70.00, 1, 1);
INSERT INTO `properties` VALUES (101, 'Sản phẩm 7', 'Biệt thự 5 phòng ngủ, phòng khách rộng rãi, sân vườn xanh tươi, có khu BBQ ngoài trời', 290.00, 'Khu biệt thự Riviera, 45 Trương Định, Quận 12, TP.HCM', 'Biệt thự', '2', '2024-11-09 08:13:41', '2024-12-07 22:37:34', 'https://media.batdongsan.vn/crop/266x150/posts/123781_672d8418d4ba2.jpg', 150.00, 2, 1);
INSERT INTO `properties` VALUES (102, 'Sản phẩm 8', 'Căn hộ 1 phòng ngủ, thích hợp cho người độc thân hoặc cặp vợ chồng trẻ. Nội thất hiện đại.', 220.00, 'Tòa nhà Central Point, 50 Bến Vân Đồn, Quận 4, TP.HCM', 'Căn hộ', '2', '2024-11-09 08:13:41', '2024-12-07 22:37:35', 'https://media.batdongsan.vn/crop/300x200/projects/20190812150524-3adc.jpg', 55.00, 1, 1);
INSERT INTO `properties` VALUES (103, 'Sản phẩm 9', 'Nhà phố có sân vườn, thiết kế thông minh, phù hợp với gia đình có từ 2-4 người.', 240.00, 'Khu đô thị Thảo Điền, 16 Phan Đăng Lưu, Quận Bình Thạnh, TP.HCM', 'Nhà phố', '3', '2024-11-09 08:13:41', '2024-12-07 22:37:36', 'https://media.batdongsan.vn/crop/300x200/projects/20161003150658-c2a0.jpg', 110.00, 3, 1);
INSERT INTO `properties` VALUES (104, 'Sản phẩm 10', 'Biệt thự sang trọng với không gian sống xanh, bao quanh là cây cối, hoa lá. Hồ bơi lớn.', 280.00, 'Khu đô thị Đại Quang Minh, 88 Nguyễn Văn Linh, Quận 7, TP.HCM', 'Biệt thự', '2', '2024-11-09 08:13:41', '2024-12-07 22:37:48', 'https://th.bing.com/th/id/OIP.4C73vDmzBmuXRhfwin7-UAAAAA?pid=ImgDet&w=178&h=178&c=7&dpr=1.5', 130.00, 7, 1);
INSERT INTO `properties` VALUES (105, 'Sản phẩm 11', 'Căn hộ 2 phòng ngủ, view sông, nội thất hiện đại.', 210.00, 'Tòa nhà Saigon Pearl, 13 Nguyễn Hữu Cảnh, Quận Bình Thạnh, TP.HCM', 'Căn hộ', '2', '2024-11-09 08:13:41', '2024-12-07 22:37:53', 'https://th.bing.com/th/id/R.4e1e85b4e263a09c6fb444018ad3db36?rik=XiHwG1rkBEMPsg&pid=ImgRaw&r=0', 45.00, 1, 1);
INSERT INTO `properties` VALUES (106, 'Sản phẩm 12', 'Nhà phố mới xây, thiết kế đẹp, có garage xe hơi, nằm trong khu vực phát triển nhanh chóng.', 300.00, '36 Hồ Văn Huê, Phường 9, Quận Phú Nhuận, TP.HCM', 'Nhà phố', '3', '2024-11-09 08:13:41', '2024-12-12 23:00:02', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734019205/sgfmnc8wxjrpepluyexh.jpg', 100.00, 2, 1);
INSERT INTO `properties` VALUES (107, 'Sản phẩm 13', 'Căn hộ 1 phòng ngủ, phòng khách rộng rãi, trang bị nội thất cao cấp, khu vực an ninh.', 230.00, 'Tòa nhà Orchard Garden, 22 Lương Định Của, Quận 2, TP.HCM', 'Căn hộ', '3', '2024-11-09 08:13:41', '2024-12-07 22:37:55', 'https://sieuthibanve.com/upload/images/202202/220757-products-2021-07-07-1625648623-oo.png', 80.00, 1, 1);
INSERT INTO `properties` VALUES (108, 'Sản phẩm 14', 'Biệt thự với thiết kế theo phong cách hiện đại, không gian sống rộng rãi và thoáng đãng.', 250.00, 'Khu biệt thự Mỹ Phước, 58 Nguyễn Văn Cừ, Quận 5, TP.HCM', 'Biệt thự', '2', '2024-11-09 08:13:41', '2024-12-07 22:37:57', 'https://th.bing.com/th/id/OIP.KNJkDmXwLBHGpHatoO74UgHaFj?w=305&h=183&c=7&r=0&o=5&dpr=1.5&pid=1.7', 110.00, 7, 1);
INSERT INTO `properties` VALUES (109, 'Sản phẩm 15', 'Căn hộ 3 phòng ngủ, view đẹp, không gian rộng, thiết kế hiện đại với đầy đủ tiện nghi.', 220.00, 'Tòa nhà Vinhomes Central Park, 36 Nguyễn Hữu Cảnh, Quận Bình Thạnh, TP.HCM', 'Căn hộ', '2', '2024-11-09 08:13:41', '2024-12-07 22:37:58', 'https://th.bing.com/th/id/OIP.HSOPnIpOvh5rvRRzuViSgAHaE1?w=280&h=183&c=7&r=0&o=5&dpr=1.5&pid=1.7', 50.00, 2, 1);
INSERT INTO `properties` VALUES (135, 'Nhà mặt phố bố làm to lắm ', 'nhà này rất đẹp mọi người nên ghé qua mà xem thử nha yêu mng', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', '3', '2024-12-03 19:51:11', '2024-12-17 18:20:42', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733340702/bxnthjl9jk4laxt1aldf.jpg', 50.00, 1, 1);
INSERT INTO `properties` VALUES (153, 'Nhà mặt phố bố làm to lắm ', 'nhà này rất đẹp mọi người nên ghé qua mà xem thử nha yêu mng', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', '1', '2024-12-03 21:27:26', '2024-12-17 18:20:54', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733236047/pgnkxhgd1zsfazhge796.jpg', 50.00, 2, 1);
INSERT INTO `properties` VALUES (158, 'Nhà mặt phố bố làm to lắm ', '12345564789', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', '3', '2024-12-04 12:18:34', '2024-12-17 18:20:58', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733289513/fxpj2mdptjjuxedvvuhc.jpg', 50.00, 2, 1);
INSERT INTO `properties` VALUES (159, 'Nhà mặt phố bố làm to lắm ', '1234556', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', '2', '2024-12-04 12:20:18', '2024-12-17 18:21:02', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733289617/mnpqdodymzlf8ywx2hxa.jpg', 50.00, 2, 1);
INSERT INTO `properties` VALUES (160, 'Nhà mặt phố bố làm to lắm ', '123456789', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', '1', '2024-12-04 12:20:31', '2024-12-17 18:21:05', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733289630/orvfxgiygjdbtv1a084u.jpg', 50.00, 2, 1);
INSERT INTO `properties` VALUES (161, 'Nhà mặt phố bố làm to lắm ', '123456789', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', '2', '2024-12-04 12:21:24', '2024-12-17 18:21:07', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733341852/bc0nzun0zeadmhcijzxa.jpg', 50.00, 2, 1);
INSERT INTO `properties` VALUES (167, 'Nhà mặt phố bố làm to lắm ', '1234569989', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', '1', '2024-12-05 02:52:50', '2024-12-17 18:21:09', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733720742/oo8z6mkrfa9oeewrnuhj.jpg', 50.00, 2, 1);
INSERT INTO `properties` VALUES (168, 'Nhà mặt phố bố làm to lắm ', '123456789', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', '2', '2024-12-05 02:58:15', '2024-12-17 18:21:12', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733342295/uh7afywqajmnuvlxlymq.jpg', 50.00, 2, 1);
INSERT INTO `properties` VALUES (169, 'Nhà mặt phố bố làm to lắm ', '1234546', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', '1', '2024-12-05 03:09:17', '2024-12-17 18:21:14', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733342957/p7nhv7fxxogakgqudd5f.jpg', 50.00, 2, 1);
INSERT INTO `properties` VALUES (175, 'Nhà mặt phố bố làm to lắm ', '123456546', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', '2', '2024-12-05 12:44:18', '2024-12-17 18:21:16', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733377458/dhemqqmbn5xo51o1zxmr.jpg', 50.00, 160, 1);
INSERT INTO `properties` VALUES (177, 'Nhà mặt phố bố làm to lắm ', '12345789', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', '2', '2024-12-05 19:36:09', '2024-12-17 18:21:19', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733402170/xhygr05uixwgefglueg0.jpg', 50.00, 161, 1);
INSERT INTO `properties` VALUES (179, 'Nhà mặt phố bố làm to lắm ', '1111', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', '2', '2024-12-05 19:41:28', '2024-12-17 18:21:27', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733720665/kosh4lpqmu7l97kcywsz.webp', 50.00, 163, 1);
INSERT INTO `properties` VALUES (185, 'Nhà mặt phố bố làm to lắm ', '123456', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', '1', '2024-12-05 20:23:33', '2024-12-17 18:21:32', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733405014/tvp9rz0og6iaitjeky6g.jpg', 50.00, 172, 1);
INSERT INTO `properties` VALUES (186, 'Nhà mặt phố bố làm to lắm ', '111232', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', '2', '2024-12-05 20:40:33', '2024-12-17 18:21:38', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733406034/x0pzx9nojc7v3m2ksjkz.jpg', 50.00, 1, 1);
INSERT INTO `properties` VALUES (187, 'Nhà mặt phố bố làm to lắm ', 'hehe', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', '1', '2024-12-05 20:43:16', '2024-12-17 18:21:40', 'https://media.batdongsan.vn/posts/14-161-25-175-z4512238441430-2a13f3f36d000fe167e92e6fe148ea45.jpg', 50.00, 1, 1);
INSERT INTO `properties` VALUES (188, 'Nhà cực đẹp mọi ngườiu ơi hehe hehe', 'nhà rộng rãi thoáng mát thích hơppj để xây dựng mái ấm', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', '1', '2024-12-05 23:07:53', '2024-12-05 23:07:53', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733414874/dl1n245jmkncagz2nik8.jpg', 50.00, 173, 1);
INSERT INTO `properties` VALUES (189, 'Nhà cực đẹp mọi ngườiu ơi hehe hehe', 'hehehe', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', '3', '2024-12-05 23:16:39', '2024-12-06 10:46:00', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733415400/us0kuwtsbnoxbnqpm7it.jpg', 50.00, 174, 1);
INSERT INTO `properties` VALUES (190, 'Nhà cực đẹp mọi ngườiu ơi hehe hehe', 'hehehhe', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', '1', '2024-12-06 09:56:32', '2024-12-06 10:53:51', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733453791/lpxi86hrx1pqnkdcrt0o.jpg', 50.00, 175, 1);
INSERT INTO `properties` VALUES (191, 'Nhà mặt phố bố làm to lắm ', 'nhà kế quận 7 bên hồ nước bờ hồ mọi nguồi ghé qua nha', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', '1', '2024-12-06 09:58:58', '2024-12-17 18:21:46', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733720811/qcxravbahmy4ccfbdasz.webp', 50.00, 1, 1);
INSERT INTO `properties` VALUES (192, 'Nhà kế vườn xoài nhé anh em ', 'Nhà rất đẹp bên trong có hồ bơi kế bên hồ bơi là công viên và bệnh viện trường học ', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat', '1', '2024-12-06 21:05:49', '2024-12-06 21:20:42', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733493949/iq5z0snha59kckbne8x1.jpg', 50.00, 176, 1);
INSERT INTO `properties` VALUES (194, 'Nhà kế vườn xoài cho xem nhé ', 'nhà đẹp lắm mọi người nên ghé mua nhé', 30.00, 'Số 365 Đường Võ Nguyên Giáp Phước Tân Biên Hòa tỉnh Đồng Nai', 'Nhà đất', '1', '2024-12-08 12:11:12', '2024-12-09 12:22:46', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733634671/vue8zgke8s5wqpwaidq1.jpg', 20.00, 179, 1);
INSERT INTO `properties` VALUES (195, 'Nhà kế vườn xoài cho xem nhé ', 'nhà đẹp zữ á anh em tới xem nhé mọi người ơi hehe', 30.00, 'Số 365 Đường Võ Nguyên Giáp Phước Tân Biên Hòa tỉnh Đồng Nai', 'Nhà đất', '1', '2024-12-08 12:12:23', '2024-12-09 12:22:38', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733634742/zzf00hfdiv2gqvgw1mmp.jpg', 30.00, 180, 1);
INSERT INTO `properties` VALUES (196, 'Nhà kế vườn xoài cho xem nhé ', 'Nhà kiot nha anh em ', 30.00, 'Số 365 Đường Võ Nguyên Giáp Phước Tân Biên Hòa tỉnh Đồng Nai', 'Nhà đất', '2', '2024-12-08 12:14:37', '2024-12-09 12:22:29', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733634876/e04ub6oqrcnyyqpwwvzf.jpg', 30.00, 181, 1);
INSERT INTO `properties` VALUES (197, 'Nhà kế vườn xoài cho xem nhé ', 'nha dep nha mng  ', 20.00, 'Số 365 Đường Võ Nguyên Giáp Phước Tân Biên Hòa tỉnh Đồng Nai', 'Nhà đất', '2', '2024-12-08 12:22:11', '2024-12-09 12:22:21', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733635331/bamegaa0izczimcv5lae.webp', 20.00, 182, 1);
INSERT INTO `properties` VALUES (198, 'Nhà kế vườn xoài cho xem nhé hehe', 'nha dep du luon nhe ', 20.00, 'Số 365 Đường Võ Nguyên Giáp Phước Tân Biên Hòa tỉnh Đồng Nai', 'Nhà đất', '1', '2024-12-08 12:24:12', '2024-12-09 12:22:09', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733720565/uwafa291eoiiye4h65sd.jpg', 20.00, 183, 1);
INSERT INTO `properties` VALUES (199, 'Nhà kế vườn xoài cho xem nhé hehe', 'nha hahaha dep qua anhahaha', 20.00, 'Số 365 Đường Võ Nguyên Giáp Phước Tân Biên Hòa tỉnh Đồng Nai', 'Nhà đất', '1', '2024-12-08 12:25:12', '2024-12-09 12:22:01', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733635512/swhiqb3vnn1ljct8ufa1.jpg', 20.00, 184, 1);
INSERT INTO `properties` VALUES (200, 'Nhà kế vườn xoài cho xem nhé hehe', 'nha hahha cao zu nhe ', 20.00, 'Số 365 Đường Võ Nguyên Giáp Phước Tân Biên Hòa tỉnh Đồng Nai', 'Nhà đất', '2', '2024-12-08 12:26:27', '2024-12-09 12:21:47', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733635586/psurfy5w32jlvarnelwu.jpg', 20.00, 185, 1);
INSERT INTO `properties` VALUES (201, 'Nhà mặt phố bố làm to lắm ', 'nhà đẹp lắm mà hàng xóm rất xóm làng ', 100.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', '1', '2024-12-13 22:43:45', '2024-12-17 18:21:52', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734104625/gbkyvunlsgckzzvooo5h.webp', 50.00, 1, 1);
INSERT INTO `properties` VALUES (208, 'Bán nhà nguyên căn tại Đồng Nai kế bên Vườn Xoài', 'nhà đẹp lắm nha mọi người ơi hehe', 10.00, 'Thành phố Long Khánh Biên Hòa Đồng Nai', 'Nhà đất', '1', '2024-12-18 22:43:36', '2024-12-30 21:04:51', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734536617/vmxcolv5wap86b0vqayb.webp', 30.00, 195, 1);
INSERT INTO `properties` VALUES (209, 'Nhà ngay Đồng Nai nhìn ra đường lớn', 'Nhà khá đẹp mọi người ghé qua xem nhé mọi người ơi', 30.00, 'Trảng Dài Đồng Nai', 'Nhà ở bán ', '1', '2024-12-18 23:09:38', '2024-12-18 23:09:38', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734538179/wemgjquo2zp5zuab4c9m.webp', 20.00, 1, 1);
INSERT INTO `properties` VALUES (211, 'Nhà ngay Đồng Nai nhìn ra đường lớn', 'Nhà khá đẹp luôn nhé', 30.00, 'Trảng Dài Đồng Nai', 'Nhà ở bán ', '1', '2024-12-19 16:56:30', '2024-12-19 16:56:30', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734602191/bkmovqnt8vgxrfpe24it.webp', 20.00, 1, 1);
INSERT INTO `properties` VALUES (212, 'Nhà mặt phố bố làm to lắm ', 'Nhà khá đẹp nhìn ra đường lớn', 30.00, 'Long Khánh Đồng Nai', 'Căn hộ dịch vụ', '1', '2024-12-19 17:03:32', '2024-12-30 21:04:59', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734602614/jaldv7cctzodahsto56z.jpg', 30.00, 1, 1);
INSERT INTO `properties` VALUES (213, 'Nhà mặt phố bố làm to lắm ', 'Nhà nhìn ra đường lớn khá đẹp á ', 30.00, 'Long Khánh Đồng Nai', 'Căn hộ dịch vụ', '2', '2024-12-19 17:05:34', '2024-12-19 17:05:34', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734602736/lak6ocyuve9wejhe3yjl.webp', 30.00, 1, 1);
INSERT INTO `properties` VALUES (214, 'Nhà ngay hàng xanh cho thuê', 'Nhà khá đẹp trong hẻm ', 10.00, 'Thành phố Long Khánh Biên Hòa Đồng Nai', 'Căn hộ dịch vụ', '2', '2024-12-20 17:09:00', '2024-12-30 21:05:00', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734689343/ofnpxq6jv8hovr0aln1i.webp', 30.00, 197, 1);
INSERT INTO `properties` VALUES (215, 'Nhà ngay hàng xanh cho thuê', 'Nhà kế ngay cơ sơ 2 hutech', 12.00, 'Thành phố Long Khánh Biên Hòa Đồng Nai', 'Căn hộ dịch vụ', '1', '2024-12-20 17:17:54', '2024-12-30 21:05:02', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734689877/tbncaqfzy2x2vozzjnif.webp', 20.00, 198, 1);
INSERT INTO `properties` VALUES (216, 'Nhà ngay hàng xanh cho thuê', 'ưqeqưeqưe', 12.00, 'Thành phố Long Khánh Biên Hòa Đồng Nai', 'Chung cư', '1', '2024-12-20 17:21:58', '2024-12-30 21:05:03', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734690122/gtjvswjyrgsep4yyglwp.jpg', 30.00, 200, 1);
INSERT INTO `properties` VALUES (217, 'Nhà ngay hàng xanh cho thuê', 'nhà đẹp', 12.00, 'Thành phố Long Khánh Biên Hòa Đồng Nai', 'Chung cư', '1', '2024-12-20 17:41:08', '2024-12-30 21:05:04', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734691271/s19iej1ed3x5moz2prp3.webp', 50.00, 201, 1);
INSERT INTO `properties` VALUES (230, 'Nhà ngay hàng xanh cho thuê', 'qweqweqwe', 12.00, 'Thành phố Long Khánh Biên Hòa Đồng Nai', 'Chung cư', '1', '2024-12-20 17:50:01', '2024-12-30 21:05:05', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734768423/qataqpix1e7w6g4s42ty.jpg', 70.00, 202, 1);
INSERT INTO `properties` VALUES (235, 'Nhà ngay hàng xanh cho thuê', 'nha dep ', 12.00, 'Thành phố Long Khánh Biên Hòa Đồng Nai', 'Chung cư', '1', '2024-12-20 18:44:29', '2024-12-30 21:05:06', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734695073/bhofute9v4o0eixwjtda.jpg', 80.00, 203, 1);
INSERT INTO `properties` VALUES (236, 'Nhà ngay hàng xanh cho thuê', 'nha dep lun ', 12.00, 'Thành phố Long Khánh Biên Hòa Đồng Nai', 'Chung cư', '1', '2024-12-20 18:44:50', '2024-12-30 21:05:07', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734695094/wlwzv2swpzburccp7cok.jpg', 90.00, 204, 1);
INSERT INTO `properties` VALUES (237, 'Nhà ngay hàng xanh cho thuê', 'nha dep\r\n', 12.00, 'Thành phố Long Khánh Biên Hòa Đồng Nai', 'Chung cư', '1', '2024-12-20 19:33:14', '2024-12-30 21:05:07', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734697998/z7edn3tm9ywrtukjaqik.png', 110.00, 205, 0);
INSERT INTO `properties` VALUES (238, 'Nhà ngay hàng xanh cho thuê', 'Nhà khá đẹp thks nhiều', 12.00, 'Thành phố Long Khánh Biên Hòa Đồng Nai', 'Chung cư', '1', '2024-12-20 19:37:30', '2024-12-21 15:13:38', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734768491/bjiely4y1sawtr5xd8vk.jpg', 20.00, 206, 0);
INSERT INTO `properties` VALUES (240, 'Nhà ngay hàng xanh cho thuê', 'nha dep', 12.00, 'Thành phố Long Khánh Biên Hòa Đồng Nai', 'Chung cư', '1', '2024-12-24 14:30:03', '2024-12-30 21:05:09', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1735025402/npia6ipamfbqyyb2fnq0.webp', 20.00, 207, 0);
INSERT INTO `properties` VALUES (241, 'Nhà ngay hàng xanh cho thuê', 'Nhà đẹp thoáng mát nhìn ra đường lớn', 12.00, 'Thành phố Long Khánh Biên Hòa Đồng Nai', 'Chung cư', '1', '2024-12-27 15:19:37', '2024-12-30 21:05:11', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1735287577/ofe4jwfuzno3b5uhwh6v.webp', 20.00, 216, 0);
INSERT INTO `properties` VALUES (242, 'Hot: Bán trục Hoa Hậu 3-4pn đẹp nhất The Opera, sở hữu vĩnh viễn view Bitexco toàn cảnh sông SG', 'The Opera Metropole Đại Lộ Vòng Cung, Thủ Thiêm, Quận 2, Hồ Chí Minh.\r\n\r\nBán 3PN trực diện sông, view Bitexco, tầm nhìn vĩnh viễn.\r\n- Diện tích: 137m², 3PN 2WC.\r\n- Giá: 47 tỷ bao gồm tất cả thuế phí.\r\n- Giá: 53 tỷ bao gồm tất cả thuế phí (suất SPA), người nước ngoài có thể mua và sở hữu.\r\n\r\nBán 4pn tầm nhìn vĩnh viễn, view Bitexco, ngắm pháo hoa...\r\n- Diện tích: 179m², 4pn, 3wc.\r\n- Giá bán: 55 tỷ tầng trung, bao gồm tất cả thuế phí.\r\n- Giá: 63 tỷ tầng cao, bao gồm thuế phí.\r\n\r\n- Đặc biệt các căn hộ 3 và 4pn đều có sánh có thang máy riêng lên tận cửa.\r\n- Nội thất cao cấp từ chủ đầu tư: Hệ thống máy lạnh âm trần, tủ quần áo âm tường, tủ lạnh, máy giặt, máy hấp quần áo, máy rửa chén, bếp từ, máy hút mùi, full tủ bếp, thiết bị vệ sinh..\r\n\r\n= Thiết kế hiện đại với tầm nhìn ra sông, không gian sống thoải mái, lý tưởng cho những ai yêu thích sự tiện nghi và phong cách sống năng động.\r\n+ Phong thủy tốt, không khí thoáng đãng.\r\n+ Khu vực sinh hoạt cộng đồng, hồ bơi tràn bờ, cafe, nhà hàng, trung tâm thương mại.\r\n+ Gym với huấn luyện viên cá nhân, công nghệ thông minh cho cuộc sống tiện ích.\r\n- Tiện ích: Hồ bơi, khu sinh hoạt cộng đồng, cửa hàng tiện ích, trung tâm thương mại, khu thư giãn riêng.\r\n- Thiết kế: 2 tòa tháp hiện đại, mang đến không gian sống đẳng cấp.\r\n+ Văn phòng ngay tại dự án, xem nhà mọi lúc.\r\n+ Giá tốt nhất thị trường, căn thật, giá thật.', 3.90, 'Dự án The Opera Residence, Đường Đại Lộ Vòng Cung, Phường Thủ Thiêm, Quận 2, Hồ Chí Minh', 'Nhà đất bán căn hộ chung cư', '2', '2024-12-08 12:26:27', '2025-01-03 21:51:27', 'https://nhadepshouse.com/picture/file/kien_truc_biet_thu_pho_co_hai_(1).jpg', 65.00, 185, 1);
INSERT INTO `properties` VALUES (243, 'Tòa Nhà Sky Tower', 'Tòa nhà chọc trời hiện đại với thiết kế kiến trúc độc đáo, Sky Tower nổi bật giữa trung tâm thành phố. Với 30 tầng, tòa nhà cung cấp không gian làm việc và sinh hoạt tiện nghi, cùng với tầm nhìn tuyệt đẹp ra toàn cảnh thành phố.', 100.00, '234 Lê Văn Sỹ, Bình Tân, TP HCM', '1', '1', '2024-11-06 23:22:23', '2024-12-27 19:45:53', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733732967/kdxzipxgaculxsyazjwf.webp', 50.00, 1, 1);
INSERT INTO `properties` VALUES (244, 'Tòa Nhà Green Living', 'Tòa nhà được thiết kế theo tiêu chí xanh, tích hợp nhiều công nghệ tiết kiệm năng lượng và thân thiện với môi trường. Green Living cung cấp các căn hộ hiện đại với sân vườn và không gian xanh, mang lại cảm giác gần gũi với thiên nhiên', 20.00, '234 Lê Văn Sỹ, Bình Tân, TP HCM', '1', '1', '2024-11-06 23:22:23', '2024-12-27 19:45:55', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733721592/zwpbbs2m3bk7kmm31jap.webp', 75.00, 2, 1);
INSERT INTO `properties` VALUES (245, 'Tòa Nhà Luxury Residence', 'Luxury Residence là tòa nhà cao cấp với các căn hộ sang trọng và tiện nghi đẳng cấp 5 sao. Tòa nhà có hồ bơi vô cực, phòng tập gym hiện đại, và dịch vụ quản lý chuyên nghiệp, phục vụ nhu cầu sống đẳng cấp của cư dân.', 30.00, '101 Hoàng Thị Loan, Quảng Trị', 'Biệt thự', '1', '2024-11-06 23:22:23', '2024-11-08 21:16:24', 'https://th.bing.com/th/id/OIP.cpkTLIbDFzRuNgrl6vMTowHaEW?pid=ImgDet&w=474&h=278&rs=1', 100.00, 3, 1);
INSERT INTO `properties` VALUES (246, 'Tòa Nhà Business Center', 'Tòa Nhà Business Center là trung tâm thương mại và văn phòng hiện đại, cung cấp các văn phòng cho thuê linh hoạt và các dịch vụ hỗ trợ doanh nghiệp. Với vị trí thuận lợi, tòa nhà là nơi lý tưởng cho các công ty khởi nghiệp và doanh nghiệp vừa và nhỏ.', 40.00, '999 Quốc Hương, Quận 2, TP HCM', 'Nhà phố', '2', '2024-11-06 23:22:23', '2024-11-08 21:31:32', 'https://th.bing.com/th/id/OIP.kx7Tdclm2qF2IJo1Jb3nvQHaEw?w=344&h=182&c=7&r=0&o=5&dpr=1.5&pid=1.7', 120.00, 7, 1);
INSERT INTO `properties` VALUES (247, 'Tòa Nhà Ocean View', 'Tòa nhà nằm ngay bên bờ biển, Ocean View cung cấp tầm nhìn đẹp.', 50.00, '789 Trần Hưng Đạo, Hà Nội', 'Khu nghỉ dưỡng', '1', '2024-11-06 23:22:23', '2024-12-09 11:59:06', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733720346/xgz6bnje5ysd84qjhxh1.jpg', 80.00, 8, 1);
INSERT INTO `properties` VALUES (248, 'Nhà phố rộng rãi có sân vườn', 'Ngôi nhà rộng rãi với sân vườn thoáng mát, gần công viên.', 30.00, '456 Đường Nguyễn Huệ, Quận 2, TP.HCM', 'house', '2', '2024-10-21 23:50:42', '2024-11-08 21:16:46', 'https://sieuthibanve.com/upload/images/202202/220757-products-2021-07-07-1625648623-oo.png', 150.00, 9, 1);
INSERT INTO `properties` VALUES (267, 'Căn hộ Central Park', 'Căn hộ Central Park nằm ngay trong trung tâm thành phố, gần các trung tâm thương mại và giải trí, rất thuận tiện cho cuộc sống đô thị hiện đại.', 65.00, '123 Đường Lê Duẩn, Quận 1, TP HCM', 'Căn hộ', '1', '2024-11-06 23:22:23', '2025-01-03 21:57:48', 'https://th.bing.com/th/id/OIP.T-e-UPudeK7H5_zZD6NHOQHaHa?w=2048&h=2048&rs=1&pid=ImgDetMain', 100.00, 20, 1);
INSERT INTO `properties` VALUES (268, 'Nhà khá đẹp', 'Nhà đc', 21.00, 'Khu đô thị Geleximco - Lê Trọng Tấn, Lê Trọng Tấn, Dương Nội, Hà Đông, Hà Nội', 'Nha dat ban biet thu', '2', '2024-12-05 19:41:28', '2025-01-03 22:11:43', 'https://th.bing.com/th/id/OIP.zMizMLqia28XkMHtEmHGmgHaJQ?w=640&h=800&rs=1&pid=ImgDetMain', 120.00, 163, 1);
INSERT INTO `properties` VALUES (269, 'Chính chủ bán ', 'Nhà 4 tầng', 9.60, 'Dự án Đông Dương Residence, Đường Quốc lộ 32, Xã Đức Thượng, Hoài Đức, Hà Nội', 'Nha dat ban biet thu', '1', '2024-12-05 20:23:33', '2025-01-03 22:09:03', 'https://th.bing.com/th/id/OIP.YdRN2kbe3AMLL2Hmq8RROQHaJ3?w=1280&h=1706&rs=1&pid=ImgDetMain', 80.00, 172, 1);
INSERT INTO `properties` VALUES (270, 'Top 1! Quỹ hàng thưởng Đại lý', 'Nhà ok nha', 26.00, 'Dự án Vinhomes Cổ Loa, Đường Cổ Loa, Xã Đông Hội, Đông Anh, Hà Nội', 'Nha dat ban biet thu', '2', '2024-12-05 20:40:33', '2025-01-03 22:12:05', 'https://th.bing.com/th/id/OIP.mK29hPSx9azWDSwkCA6J6wHaH_?w=1280&h=1380&rs=1&pid=ImgDetMain', 80.00, 1, 1);
INSERT INTO `properties` VALUES (271, 'Cho thuê biệt thự nguyên căn khuôn viên 240m2', 'Cho thuê Biệt thự nguyên căn 240m², DT xây dựng 90m² x 3,5 tầng đầy đủ nội thất, gần ngay nhiều KCN Đại Đồng, Hoàn Sơn... Tiện đi lại, độc lập, yên tĩnh.', 25.00, 'Dự án KCN Đại Đồng - Hoàn Sơn, Xã Hoàn Sơn, Tiên Du, Bắc Ninh', 'Cho thue biet thu', '3', '2024-11-09 08:13:41', '2025-01-03 22:08:40', 'https://www.emporioarchitect.com/upload/portofolio/1280/desain-rumah-modern-2-lantai-78091023-47523286091023085218-0.jpg', 240.00, 3, 1);
INSERT INTO `properties` VALUES (272, 'Cho thuê căn biệt thự ngay cổng chính Valora Fuji(đẹp nhất dự án)', 'Cho thuê căn biệt thự ngay cổng chính Valora Fuji(đẹp nhất dự án). + Ngay cổng chính Valora Fuji(đẹp nhất dự án) view sông (đối diện công viên, hồ bơi). + Diện tích: 169m² + diện tích đất công viên bên cạnh được sử dụng riêng. - Thiết kế: 1 trệt 1 lầu, 3PN 3WC - Full NT 100%. - Có thể dọn vào ở ngay. + Giá thuê: 35tr/tháng bao phí quản lý + Hồ cá coi nhiều cá giá trị lớn...', 35.00, 'Valora Fuji, Phước Hữu, Phước Long B, Quận 9, Hồ Chí Minh', 'Cho thue biet thu', '2', '2024-11-09 08:13:41', '2025-01-03 21:53:48', 'https://www.emporioarchitect.com/upload/portofolio/1280/desain-rumah-modern-2-lantai-78091023-47523286091023085218-0.jpg', 169.00, 7, 1);
INSERT INTO `properties` VALUES (273, 'Cho thuê BT đẹp tại Saigon Pearl, 100 triệu, 147m2, 5PN, 4WC', 'Biệt thự cho thuê cực chất tại Sài Gòn Pearl, 92 Nguyễn Hữu Cảnh, P. 22, Bình Thạnh, HCM. Chính chủ gởi cho thuê biệt thự Sài Gòn Pearl gần Quận 1, và bên sông Sài Gòn: 1. Biệt thự Sài Gòn Pearl nhìn sông. - Diện tích: 7 x 21 m; xây dựng: 1 hầm, 1 trệt, và 3 lầu. - Diện tích sàn: ~ 450 m². - Nhà hoàn thiện full nội thất. Giá thuê: 100 triệu / tháng. Tiện ích xung quanh: + Bệnh viện Bình Thạnh cơ sở 2, Vinmec Central Park. + Siêu thị điện máy Tự Do, Con Cưng. + Công viên Bình An, Vinhomes Tân Cảng. + Trường phổ thông song ngữ quốc tế Wellspring, mầm non Hooray.', 100.00, 'Dự án Saigon Pearl, Đường Nguyễn Hữu Cảnh, Phường 22, Bình Thạnh, Hồ Chí Minh', 'Cho thue biet thu', '2', '2024-11-09 08:13:41', '2025-01-03 21:53:41', 'https://i.pinimg.com/originals/41/ea/a5/41eaa5326392d4cd67446f9fc7da2f71.jpg', 147.00, 8, 1);
INSERT INTO `properties` VALUES (274, 'Cho thuê nhà Vạn Phúc City giá tốt T12 5x21m, 6x17m, 6x20m, 7x20m, 9x20m, 13x22m giá từ 27 triệu', 'Chuyên cho thuê nhà làm văn phòng hoặc ở tại Khu Đô Thị Vạn Phúc giá tốt tháng 12 với nhiều diện tích khác nhau phù hợp nhiều mục đích kinh doanh của khách thuê với mức giá tốt và vị trí đẹp.\r\n\r\n1. Nguyên căn 5x20m, kết cấu: 1 hầm, 4 tầng giá 27 triệu/tháng. (Hoàn thiện 4PN 5WC, có bếp).\r\n\r\n2. Nguyên căn 5x20m đường 20m, kết cấu: 1 hầm, 4 tầng giá 32 triệu/tháng (Hoàn thiện văn phòng, có bếp).\r\n\r\n3. Nguyên căn 6x17m, kết cấu: 1 hầm, 4 tầng giá 30 triệu/tháng (Hoàn thiện 4PN 5WC).\r\n\r\n4. Nguyên căn 6x20m, đường 25m, kết cấu: 1 hầm, 4 tầng giá 40 triệu/tháng (Hoàn thiện 5PN 6WC, có thang máy).\r\n\r\n5. Nguyên căn 7x20m, kết cấu: 1 hầm, 4 tầng giá 45 triệu/tháng (Hoàn thiện để ở và văn phòng, có thang máy).\r\n\r\n6. Nguyên căn 7x20m mới hoàn thiện 100%, kết cấu: 1 hầm, 4 tầng giá 55 - 60 triệu/tháng (Hoàn thiện văn phòng, có thang máy).\r\n\r\n7. Nguyên căn 7x21m mặt tiền Đường 7, kết cấu: 5 tầng k hầm, có sân trước nhà giá 50 triệu/tháng (Hoàn thiện văn phòng, có thang máy).\r\n\r\n8. Căn góc 11x18m mặt tiền đường 7, kết cấu: 1 hầm 4 tầng, giá 75 triệu (Hoàn thiện văn phòng, thang máy). Căn góc 13x22m, kết cấu: 1 hầm 4 tầng, giá 100 triệu (Hoàn thiện văn phòng, thang máy).\r\n\r\n9. Shophouse mặt tiền Nguyễn Thị Nhung, 6 tầng: 5x20m giá 38 triệu, 7x20m giá 55 triệu, 9x20m giá 65 triệu/tháng. (Hoàn thiện văn phòng, có thang máy).\r\n\r\nVà còn nhiều option khác sát với nhu cầu của khách hàng. ', 27.00, 'Dự án KĐT Vạn Phúc City, Đường Quốc Lộ 13, Phường Hiệp Bình Phước, Thủ Đức, Hồ Chí Minh', 'Cho thue nha pho', '2', '2024-11-01 18:19:58', '2025-01-03 22:13:24', 'https://th.bing.com/th/id/OIP.fSaCIuqaImKjrlQSms47owHaFs?w=1280&h=984&rs=1&pid=ImgDetMain', 100.00, 1, 1);
INSERT INTO `properties` VALUES (275, 'Chính chủ chào thuê', 'Chính chủ cần cho thuê nhà mặt phố Hàng Đào đoạn đẹp nhất ngay đầu Hồ Gươm cực đông khách du lịch qua lại, cuối tuần phố đi bộ cực nhộn nhịp kinh doanh sầm uất ngày đêm.\r\nChủ nhà cực dễ tính hỗ trợ mọi thủ tục, tạo mọi điều kiện hỗ trợ khách thuê.\r\n\r\nDIỆN TÍCH 200m x 3 tầng thông sàn rộng rãi thoáng nhất phố.\r\nMặt tiền rộng thoáng nhận diện thương hiệu rất tốt.\r\nVỉa hè rộng để xe kinh doanh thoải mái.\r\nGiá thuê 185tr/th có thương lượng thêm với khách thiện chí xem nhà sớm.\r\nThời gian sửa chữa ', 185.00, 'Phố Hàng Đào, Phường Hàng Đào, Hoàn Kiếm, Hà Nội', 'Cho thue nha pho', '3', '2024-11-01 19:42:30', '2025-01-03 22:09:12', 'https://th.bing.com/th/id/OIP.HGzvjMwYzjg7vVWDzNqwAQHaFj?w=1280&h=960&rs=1&pid=ImgDetMain', 600.00, 2, 1);
INSERT INTO `properties` VALUES (276, 'Cho thuê nhà mặt phố', 'Chính chủ cho thuê nhà mặt phố Nguyễn Trãi, phù hợp làm văn phòng, cửa hàng hoặc các mô hình kinh doanh khác', 65.00, 'Phố Nguyễn Trãi, Phường Thanh Xuân, Hà Nội', 'Cho thue nha pho', '1', '2024-12-01 08:15:22', '2025-01-03 22:09:38', 'https://i.pinimg.com/736x/2d/2d/15/2d2d15b93f7431bc78360b186fae1f05.jpg', 100.00, 3, 1);
INSERT INTO `properties` VALUES (278, 'Cho thuê nhà mặt phố', 'Chính chủ cho thuê', 65.00, 'Phố Nguyễn Trãi, Phường Thanh Xuân, Hà Nội', 'Cho thue nha pho', '1', '2024-12-01 08:15:22', '2025-01-03 22:09:44', 'https://i.pinimg.com/736x/26/2f/d6/262fd6f2afefc304a1e6ecbcb9d30b71.jpg', 100.00, 3, 1);
INSERT INTO `properties` VALUES (279, 'Biệt thự sang trọng cho thuê tại khu đô thị Ciputra', 'Cho thuê biệt thự cao cấp tại khu đô thị Ciputra. Nhà có sân vườn rộng, hồ bơi, nội thất cao cấp đầy đủ, phù hợp với gia đình hoặc làm văn phòng công ty. Diện tích lớn, không gian thoáng mát, môi trường sống sang trọng.', 200.00, 'Khu đô thị Ciputra, Phường Xuân La, Tây Hồ, Hà Nội', 'Cho thue biet thu', '2', '2024-11-20 10:30:45', '2025-01-03 21:52:52', 'https://th.bing.com/th/id/OIP.7R4UfzcUrsXzMoe6QKIYqgHaH7?w=950&h=1018&rs=1&pid=ImgDetMain', 350.00, 2, 1);
INSERT INTO `properties` VALUES (281, 'Cho thuê nhà mặt phố', 'Chính chủ cho thuê nhà', 65.00, 'Phố Nguyễn Trãi, Phường Thanh Xuân, Hà Nội', 'Cho thue nha pho', '1', '2024-12-01 08:15:22', '2025-01-03 22:10:05', 'https://i0.wp.com/www.emporioarchitect.com/upload/portofolio/desain-rumah-modern-3-lantai-36010322-614174691111022100006.jpg', 100.00, 3, 1);
INSERT INTO `properties` VALUES (282, 'Biệt thự sang trọng', 'Cho thuê biệt thự.', 200.00, 'Khu đô thị Ciputra, Phường Xuân La, Tây Hồ, Hà Nội', 'Cho thue biet thu', '2', '2024-11-20 10:30:45', '2025-01-03 22:10:24', 'https://th.bing.com/th/id/OIP.SF-F26dHkgDvpspTAweu6gHaE8?rs=1&pid=ImgDetMain', 350.00, 2, 1);
INSERT INTO `properties` VALUES (283, 'Căn hộ cao cấp cho thuê tại Times City, 3 phòng ngủ', 'Căn hộ sang trọng với 3 phòng ngủ tại khu Times City. Nội thất đầy đủ, thiết kế hiện đại, vị trí gần trung tâm thương mại, bệnh viện, trường học, giao thông thuận tiện.', 50.00, 'Times City, Phường Mai Động, Hoàng Mai, Hà Nội', 'Cho thue can ho', '1', '2024-12-05 11:10:15', '2025-01-03 21:52:06', 'https://th.bing.com/th/id/OIP.D0fVsq9Z-PKDKubE05jiYAHaEc?rs=1&pid=ImgDetMain', 120.00, 7, 1);
INSERT INTO `properties` VALUES (284, 'Mặt bằng cho thuê tại mặt phố Lê Duẩn,', 'Cho thuê mặt bằng', 100.00, 'Phố Lê Duẩn, Phường Cửa Nam, Hoàn Kiếm, Hà Nội', 'Cho thue mat bang', '3', '2024-12-10 12:20:05', '2025-01-03 22:10:42', 'https://i.pinimg.com/736x/e7/24/4f/e7244fd4b65bc1de0f070b6b48268b3d.jpg', 150.00, 8, 1);
INSERT INTO `properties` VALUES (285, 'Nhà phố thương mại tại Vinhome Ocean Park', 'Nhà phố thương mại tại Vinhome Ocean Park với diện tích 100m2, 4 tầng, đã hoàn thiện nội thất. Phù hợp với các mô hình kinh doanh kết hợp ở. Vị trí đẹp gần biển nhân tạo, khu vực sầm uất của thành phố.', 120.00, 'Vinhome Ocean Park, Gia Lâm, Hà Nội', 'Cho thue nha pho', '2', '2024-12-15 14:40:20', '2025-01-03 21:51:46', 'https://th.bing.com/th/id/OIP.VGy8vFCcCmUz0s-SeaQ7bQHaJH?w=736&h=906&rs=1&pid=ImgDetMain', 100.00, 7, 1);
INSERT INTO `properties` VALUES (286, 'Cho thuê văn phòng cao cấp tại Keangnam Tower', 'Văn phòng cho thuê tại Keangnam Tower, diện tích từ 100m2 đến 500m2, có thể chia nhỏ, phù hợp cho các doanh nghiệp vừa và nhỏ. Tòa nhà có hệ thống thang máy, bảo vệ 24/7, giao thông thuận tiện.', 150.00, 'Keangnam Tower, Phường Mễ Trì, Nam Từ Liêm, Hà Nội', 'Cho thue van phong', '1', '2024-12-18 16:50:35', '2025-01-03 21:51:40', 'https://3dmodelshare.org/wp-content/uploads/2024/03/1783.-House-Exterior-3dsmax-File-700x1077.jpg', 500.00, 8, 1);
INSERT INTO `properties` VALUES (287, 'Chính chủ cho thuê nhà mặt tiền Hoàng Hoa Thám', 'Chính chủ cho thuê nhà mặt tiền Hoàng Hoa Thám, diện tích 120m2, 3 tầng, có vỉa hè rộng, phù hợp với các mô hình kinh doanh như nhà hàng, quán cà phê, shop thời trang.', 80.00, 'Phố Hoàng Hoa Thám, Phường Ngọc Hà, Ba Đình, Hà Nội', 'Cho thue nha pho', '2', '2024-12-20 18:25:10', '2025-01-03 21:51:02', 'https://th.bing.com/th/id/OIP.9ufBVIN9TLJwk8o9CwbTwwHaEK?pid=ImgDet&w=474&h=266&rs=1', 120.00, 9, 1);
INSERT INTO `properties` VALUES (288, 'Căn hộ cho thuê tại Vinhomes Green Bay, 2 phòng ngủ', 'Căn hộ 2 phòng ngủ tại Vinhomes Green Bay, có đầy đủ nội thất, view đẹp, không gian thoáng đãng, khu vực yên tĩnh, rất phù hợp cho gia đình hoặc các chuyên gia nước ngoài. Giá cả hợp lý.', 40.00, 'Vinhomes Green Bay, Phường Mễ Trì, Nam Từ Liêm, Hà Nội', 'Cho thue can ho', '1', '2024-12-22 20:00:25', '2025-01-03 21:50:50', 'https://static.wixstatic.com/media/cbad0e_8547da6466694fe4a77c1d975e8c7f73~mv2.jpg/v1/fill/w_980,h_551,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/cbad0e_8547da6466694fe4a77c1d975e8c7f73~mv2.jpg', 85.00, 10, 1);
INSERT INTO `properties` VALUES (289, 'Chính chủ cho thuê căn hộ tại Mandarin Garden, 2 phòng ngủ', 'Căn hộ cao cấp cho thuê tại Mandarin Garden, 2 phòng ngủ, nội thất đầy đủ, thiết kế hiện đại, view đẹp, tiện ích đầy đủ như bể bơi, gym, gần các trung tâm thương mại.', 70.00, 'Mandarin Garden, Phường Trung Hòa, Cầu Giấy, Hà Nội', 'Cho thue can ho', '1', '2024-12-25 09:00:10', '2025-01-03 21:50:43', 'https://xaynhasaigon.vn/wp-content/uploads/2021/11/thiet-ke-nha-3x14m-5-768x960.jpg', 85.00, 11, 1);
INSERT INTO `properties` VALUES (290, 'Cho thuê nhà phố Trần Duy Hưng, diện tích 150m2, 4 tầng', 'Nhà cho thuê tại phố Trần Duy Hưng, diện tích 150m2, 4 tầng, có vỉa hè rộng, vị trí gần trung tâm thương mại, khu dân cư đông đúc, phù hợp làm văn phòng, cửa hàng.', 100.00, 'Phố Trần Duy Hưng, Phường Trung Hòa, Cầu Giấy, Hà Nội', 'Cho thue nha pho', '2', '2024-12-26 11:15:50', '2025-01-03 21:50:28', 'https://th.bing.com/th/id/OIP.mDdgG3K_uonFYWE5FyXGCQHaFj?rs=1&pid=ImgDetMain', 150.00, 12, 1);
INSERT INTO `properties` VALUES (291, 'Căn hộ 1 phòng ngủ cho thuê tại Eco Green, Hà Nội', 'Căn hộ 1 phòng ngủ cho thuê tại Eco Green, không gian sống thoáng mát, gần các trường học, siêu thị, giao thông thuận tiện. Phù hợp cho người đi làm hoặc vợ chồng trẻ.', 35.00, 'Eco Green, Phường Đại Mỗ, Nam Từ Liêm, Hà Nội', 'Cho thue can ho', '1', '2024-12-27 13:45:30', '2025-01-03 21:50:36', 'https://th.bing.com/th/id/OIP.s8Mnp1OEi2o2B33Y7MIFDwHaIt?w=870&h=1024&rs=1&pid=ImgDetMain', 60.00, 13, 1);
INSERT INTO `properties` VALUES (292, 'Mặt bằng cho thuê tại phố Láng Hạ, diện tích 200m2', 'Cho thuê mặt bằng rộng 200m2 tại phố Láng Hạ, khu vực kinh doanh sầm uất, thuận tiện làm cửa hàng, văn phòng. Vị trí đắc địa, giao thông thuận lợi.', 150.00, 'Phố Láng Hạ, Phường Láng Hạ, Đống Đa, Hà Nội', 'Cho thue mat bang', '2', '2024-12-28 15:30:00', '2025-01-03 21:50:13', 'https://th.bing.com/th/id/OIP.Lr5Ct50BXnN3ojcL17M5xgHaFj?w=1100&h=825&rs=1&pid=ImgDetMain', 200.00, 14, 1);
INSERT INTO `properties` VALUES (293, 'Biệt thự cho thuê tại Vinhomes Riverside', 'Cho thuê biệt thự tại Vinhomes Riverside, có diện tích rộng, sân vườn đẹp, nội thất cao cấp, không gian sống thoáng đãng, khu vực yên tĩnh, phù hợp cho gia đình lớn hoặc các chuyên gia nước ngoài.', 250.00, 'Vinhomes Riverside, Long Biên, Hà Nội', 'Cho thue biet thu', '1', '2024-12-29 17:10:20', '2025-01-03 21:50:03', 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/17/8e/81/18/main-pool.jpg?w=700&h=-1&s=1', 350.00, 15, 1);
INSERT INTO `properties` VALUES (294, 'Căn hộ 3 phòng ngủ cho thuê tại The Manor, Mỹ Đình', 'Căn hộ 3 phòng ngủ tại The Manor, Mỹ Đình, khu vực an ninh tốt, môi trường sống tiện nghi, gần các trung tâm thương mại, siêu thị, trường học. Phù hợp cho gia đình, thiết kế hiện đại.', 80.00, 'The Manor, Mỹ Đình, Nam Từ Liêm, Hà Nội', 'Cho thue can ho', '2', '2024-12-30 08:25:10', '2025-01-03 21:49:53', 'https://th.bing.com/th/id/OIP.hh7BFKhulh_v4eYX7ZNJrQHaEK?w=600&h=337&rs=1&pid=ImgDetMain', 120.00, 16, 1);
INSERT INTO `properties` VALUES (295, 'Căn hộ 2 phòng ngủ tại Times City, Minh Khai', 'Căn hộ 2 phòng ngủ tại Times City, không gian sống thoáng mát, đầy đủ tiện nghi, gần bệnh viện, trường học, trung tâm thương mại. Phù hợp cho gia đình.', 65.00, 'Times City, Minh Khai, Hai Bà Trưng, Hà Nội', 'Cho thue can ho', '1', '2024-12-31 10:20:00', '2025-01-03 21:49:47', 'https://balistarisland.com/wp-content/uploads/2017/10/puri-pandawa-view.jpg', 85.00, 17, 1);
INSERT INTO `properties` VALUES (296, 'Cho thuê biệt thự liền kề tại Ciputra, Hà Nội', 'Biệt thự liền kề cho thuê tại Ciputra, nội thất sang trọng, diện tích rộng, thích hợp cho các gia đình hoặc người nước ngoài. Khu vực an ninh tốt, giao thông thuận tiện.', 180.00, 'Ciputra, Tây Hồ, Hà Nội', 'Cho thue biet thu lien ke', '2', '2024-12-31 11:30:00', '2025-01-03 21:49:36', 'https://th.bing.com/th/id/OIP.faEHghI6NKnIssOqBdo9IgHaE7?w=1000&h=666&rs=1&pid=ImgDetMain', 200.00, 18, 1);
INSERT INTO `properties` VALUES (297, 'Mặt bằng cho thuê tại phố Cầu Giấy', 'Mặt bằng cho thuê tại phố Cầu Giấy, diện tích 120m2, mặt tiền rộng, thích hợp làm cửa hàng hoặc văn phòng. Khu vực đông dân cư, giao thông thuận tiện.', 120.00, 'Phố Cầu Giấy, Quận Cầu Giấy, Hà Nội', 'Cho thue mat bang', '1', '2024-12-31 14:15:30', '2025-01-03 21:49:24', 'https://th.bing.com/th/id/OIP.hztVhBUvLrq3QgTdsURnVAHaE8?w=2100&h=1400&rs=1&pid=ImgDetMain', 120.00, 19, 1);
INSERT INTO `properties` VALUES (298, 'Căn hộ cho thuê tại Golden Westlake, Quảng An', 'Căn hộ 2 phòng ngủ tại Golden Westlake, có ban công view Hồ Tây, nội thất cao cấp, không gian sống yên tĩnh, tiện ích đầy đủ, giao thông thuận lợi.', 100.00, 'Golden Westlake, Quảng An, Tây Hồ, Hà Nội', 'Cho thue can ho', '2', '2024-12-31 16:00:00', '2025-01-03 21:49:15', 'https://storage.googleapis.com/hotels2thailand-storage/pictures/products/00746202-213946.jpg', 120.00, 20, 1);
INSERT INTO `properties` VALUES (299, 'Biệt thự cho thuê tại Vinhomes Green Bay, Mễ Trì', 'Biệt thự cho thuê tại Vinhomes Green Bay, có sân vườn rộng, nội thất đầy đủ, khu vực an ninh tốt, giao thông thuận tiện, phù hợp cho các gia đình lớn hoặc người nước ngoài.', 220.00, 'Vinhomes Green Bay, Mễ Trì, Nam Từ Liêm, Hà Nội', 'Cho thue biet thu', '1', '2024-12-31 18:30:00', '2025-01-03 21:57:08', 'https://th.bing.com/th/id/OIP.T-e-UPudeK7H5_zZD6NHOQHaHa?w=2048&h=2048&rs=1&pid=ImgDetMain', 300.00, 21, 1);
INSERT INTO `properties` VALUES (300, 'Căn hộ studio cho thuê tại The Sun, Hoàng Mai', 'Căn hộ studio cho thuê tại The Sun, diện tích nhỏ nhưng đầy đủ tiện nghi, thiết kế hiện đại, gần các trung tâm mua sắm, trường học, phù hợp cho người đi làm hoặc sinh viên.', 25.00, 'The Sun, Hoàng Mai, Hà Nội', 'Cho thue can ho', '2', '2024-12-31 19:50:00', '2025-01-03 21:48:47', 'https://th.bing.com/th/id/OIP.qx22UYIhNMwDLT_6W9GBdQHaEx?w=900&h=580&rs=1&pid=ImgDetMain', 40.00, 22, 1);
INSERT INTO `properties` VALUES (301, 'Căn hộ 1 phòng ngủ tại Golden Palace, Mễ Trì', 'Căn hộ 1 phòng ngủ tại Golden Palace, nội thất hiện đại, đầy đủ tiện nghi, khu vực giao thông thuận tiện, gần các trung tâm thương mại, siêu thị.', 45.00, 'Golden Palace, Mễ Trì, Nam Từ Liêm, Hà Nội', 'Cho thue can ho', '1', '2024-12-31 20:10:00', '2025-01-03 21:48:55', 'https://i.pinimg.com/originals/7f/fe/e5/7ffee5966e55584aebe75af684562001.jpg', 55.00, 23, 1);
INSERT INTO `properties` VALUES (302, 'Mặt bằng cho thuê tại phố Bà Triệu', 'Mặt bằng cho thuê tại phố Bà Triệu, diện tích 150m2, mặt tiền rộng, thích hợp làm cửa hàng, showroom hoặc văn phòng. Vị trí trung tâm, dễ dàng di chuyển.', 150.00, 'Phố Bà Triệu, Hai Bà Trưng, Hà Nội', 'Cho thue mat bang', '2', '2024-12-31 21:20:00', '2025-01-03 21:48:46', 'https://th.bing.com/th/id/OIP.qx22UYIhNMwDLT_6W9GBdQHaEx?w=900&h=580&rs=1&pid=ImgDetMain', 150.00, 24, 1);
INSERT INTO `properties` VALUES (303, 'Biệt thự sân vườn tại khu đô thị Dương Nội', 'Biệt thự sân vườn tại khu đô thị Dương Nội, diện tích rộng, có hồ bơi, sân vườn riêng, thích hợp cho các gia đình lớn, gần các tiện ích như trường học, bệnh viện.', 250.00, 'Khu đô thị Dương Nội, Hà Đông, Hà Nội', 'Cho thue biet thu', '1', '2024-12-31 22:30:00', '2025-01-03 21:56:54', 'https://th.bing.com/th/id/OIP.T-e-UPudeK7H5_zZD6NHOQHaHa?w=2048&h=2048&rs=1&pid=ImgDetMain', 350.00, 25, 1);
INSERT INTO `properties` VALUES (304, 'Căn hộ 3 phòng ngủ tại Vinhomes Metropolis', 'Căn hộ 3 phòng ngủ tại Vinhomes Metropolis, nội thất sang trọng, view đẹp, gần các trung tâm thương mại, khu vực an ninh cao, giao thông thuận tiện.', 150.00, 'Vinhomes Metropolis, Liễu Giai, Ba Đình, Hà Nội', 'Cho thue can ho', '2', '2024-12-31 23:45:00', '2025-01-03 21:48:34', 'https://th.bing.com/th/id/OIP.nKWxJfFYyUL6Qmb3PbG9ewHaE8?w=490&h=327&rs=1&pid=ImgDetMain', 130.00, 26, 1);
INSERT INTO `properties` VALUES (305, 'Cho thuê nhà phố tại Tô Hiến Thành, Hai Bà Trưng', 'Nhà phố cho thuê tại Tô Hiến Thành, diện tích 100m2, 3 tầng, mặt tiền rộng, thích hợp làm cửa hàng hoặc văn phòng. Khu vực dân cư đông đúc, giao thông thuận tiện.', 120.00, 'Tô Hiến Thành, Hai Bà Trưng, Hà Nội', 'Cho thue nha pho', '1', '2024-12-31 23:59:00', '2025-01-03 21:56:13', 'https://th.bing.com/th/id/OIP.T-e-UPudeK7H5_zZD6NHOQHaHa?w=2048&h=2048&rs=1&pid=ImgDetMain', 100.00, 27, 1);
INSERT INTO `properties` VALUES (307, 'Căn hộ 1 phòng ngủ tại Golden Palace, Mễ Trì', 'Căn hộ 1 phòng ngủ tại Golden Palace, nội thất hiện đại, đầy đủ tiện nghi, khu vực giao thông thuận tiện, gần các trung tâm thương mại, siêu thị.', 45.00, 'Golden Palace, Mễ Trì, Nam Từ Liêm, Hà Nội', 'Cho thue can ho', '1', '2024-12-31 20:10:00', '2025-01-03 21:48:26', 'https://th.bing.com/th/id/OIP.NRBBI_DOYRmrurYQRAJ7aQHaEv?w=780&h=500&rs=1&pid=ImgDetMain', 55.00, 23, 1);
INSERT INTO `properties` VALUES (308, 'Mặt bằng cho thuê tại phố Bà Triệu', 'Mặt bằng cho thuê tại phố Bà Triệu, diện tích 150m2, mặt tiền rộng, thích hợp làm cửa hàng, showroom hoặc văn phòng. Vị trí trung tâm, dễ dàng di chuyển.', 150.00, 'Phố Bà Triệu, Hai Bà Trưng, Hà Nội', 'Cho thue mat bang', '2', '2024-12-31 21:20:00', '2025-01-03 21:48:18', 'https://img.thuthuatphanmem.vn/uploads/2018/10/09/hinh-anh-can-nha-mai-la-dep_041508451.jpg', 150.00, 24, 1);
INSERT INTO `properties` VALUES (309, 'Biệt thự sân vườn tại khu đô thị Dương Nội', 'Biệt thự sân vườn tại khu đô thị Dương Nội, diện tích rộng, có hồ bơi, sân vườn riêng, thích hợp cho các gia đình lớn, gần các tiện ích như trường học, bệnh viện.', 250.00, 'Khu đô thị Dương Nội, Hà Đông, Hà Nội', 'Cho thue biet thu', '1', '2024-12-31 22:30:00', '2025-01-03 21:48:07', 'https://th.bing.com/th/id/OIP.DMx5c6OmTruw5et3GGvUEAAAAA?pid=ImgDet&w=178&h=133&c=7&dpr=1.5', 350.00, 25, 1);
INSERT INTO `properties` VALUES (310, 'Căn hộ 3 phòng ngủ tại Vinhomes Metropolis', 'Căn hộ 3 phòng ngủ tại Vinhomes Metropolis, nội thất sang trọng, view đẹp, gần các trung tâm thương mại, khu vực an ninh cao, giao thông thuận tiện.', 150.00, 'Vinhomes Metropolis, Liễu Giai, Ba Đình, Hà Nội', 'Cho thue can ho', '2', '2024-12-31 23:45:00', '2025-01-03 21:47:58', 'https://th.bing.com/th/id/OIP.Y1w6hCqXLDgTYK6CNDJYmwAAAA?w=340&h=270&rs=1&pid=ImgDetMain', 130.00, 26, 1);
INSERT INTO `properties` VALUES (311, 'Cho thuê nhà phố tại Tô Hiến Thành, Hai Bà Trưng', 'Nhà phố cho thuê tại Tô Hiến Thành, diện tích 100m2, 3 tầng, mặt tiền rộng, thích hợp làm cửa hàng hoặc văn phòng. Khu vực dân cư đông đúc, giao thông thuận tiện.', 120.00, 'Tô Hiến Thành, Hai Bà Trưng, Hà Nội', 'Cho thue nha pho', '1', '2024-12-31 23:59:00', '2025-01-03 21:55:46', 'https://th.bing.com/th/id/OIP.T-e-UPudeK7H5_zZD6NHOQHaHa?w=2048&h=2048&rs=1&pid=ImgDetMain', 100.00, 27, 1);
INSERT INTO `properties` VALUES (313, 'Căn hộ 1 phòng ngủ tại Golden Palace, Mễ Trì', 'Căn hộ 1 phòng ngủ tại Golden Palace, nội thất hiện đại, đầy đủ tiện nghi, khu vực giao thông thuận tiện, gần các trung tâm thương mại, siêu thị.', 45.00, 'Golden Palace, Mễ Trì, Nam Từ Liêm, Hà Nội', 'Cho thue can ho', '1', '2024-12-31 20:10:00', '2025-01-03 21:46:32', 'https://th.bing.com/th/id/OIP.eDrg2VOwnKdVW0X6WXvA6wHaE8?pid=ImgDet&w=474&h=316&rs=1', 55.00, 23, 1);
INSERT INTO `properties` VALUES (314, 'Mặt bằng cho thuê tại phố Bà Triệu', 'Mặt bằng cho thuê tại phố Bà Triệu, diện tích 150m2, mặt tiền rộng, thích hợp làm cửa hàng, showroom hoặc văn phòng. Vị trí trung tâm, dễ dàng di chuyển.', 150.00, 'Phố Bà Triệu, Hai Bà Trưng, Hà Nội', 'Cho thue mat bang', '2', '2024-12-31 21:20:00', '2025-01-03 21:46:21', 'https://th.bing.com/th/id/OIP.xgvQGlBfhHAu5TsIcZmA0AHaE8?pid=ImgDet&w=474&h=316&rs=1', 150.00, 24, 1);
INSERT INTO `properties` VALUES (315, 'Biệt thự sân vườn tại khu đô thị Dương Nội', 'Biệt thự sân vườn tại khu đô thị Dương Nội, diện tích rộng, có hồ bơi, sân vườn riêng, thích hợp cho các gia đình lớn, gần các tiện ích như trường học, bệnh viện.', 250.00, 'Khu đô thị Dương Nội, Hà Đông, Hà Nội', 'Cho thue biet thu', '1', '2024-12-31 22:30:00', '2025-01-03 21:46:07', 'https://th.bing.com/th/id/OIP.fP8INwZgN4GaXgtgJ58HtgHaE7?w=2303&h=1531&rs=1&pid=ImgDetMain', 350.00, 25, 1);
INSERT INTO `properties` VALUES (316, 'Căn hộ 3 phòng ngủ tại Vinhomes Metropolis', 'Căn hộ 3 phòng ngủ tại Vinhomes Metropolis, nội thất sang trọng, view đẹp, gần các trung tâm thương mại, khu vực an ninh cao, giao thông thuận tiện.', 150.00, 'Vinhomes Metropolis, Liễu Giai, Ba Đình, Hà Nội', 'Cho thue can ho', '2', '2024-12-31 23:45:00', '2025-01-03 21:45:57', 'https://images.squarespace-cdn.com/content/v1/60e155da3e6d353c239ba417/6d1b8dc5-0fea-48b7-b9c0-86214ba86860/H-Flat+Modern+Carbnstudio+Architect+Tigoni+(2).jpg?format=1000w', 130.00, 26, 1);
INSERT INTO `properties` VALUES (317, 'Cho thuê nhà phố tại Tô Hiến Thành, Hai Bà Trưng', 'Nhà phố cho thuê tại Tô Hiến Thành, diện tích 100m2, 3 tầng, mặt tiền rộng, thích hợp làm cửa hàng hoặc văn phòng. Khu vực dân cư đông đúc, giao thông thuận tiện.', 120.00, 'Tô Hiến Thành, Hai Bà Trưng, Hà Nội', 'Cho thue nha pho', '1', '2024-12-31 23:59:00', '2025-01-03 21:45:42', 'https://images.squarespace-cdn.com/content/v1/60e155da3e6d353c239ba417/6d1b8dc5-0fea-48b7-b9c0-86214ba86860/H-Flat+Modern+Carbnstudio+Architect+Tigoni+(2).jpg?format=1000w', 100.00, 27, 1);
INSERT INTO `properties` VALUES (319, 'Căn hộ 1 phòng ngủ tại Golden Palace, Mễ Trì', 'Căn hộ 1 phòng ngủ tại Golden Palace, nội thất hiện đại, đầy đủ tiện nghi, khu vực giao thông thuận tiện, gần các trung tâm thương mại, siêu thị.', 45.00, 'Golden Palace, Mễ Trì, Nam Từ Liêm, Hà Nội', 'Cho thue can ho', '1', '2024-12-31 20:10:00', '2025-01-03 21:45:32', 'https://static.wixstatic.com/media/698296_73354fdcb0784e53a115d1807d473683~mv2.jpg/v1/fill/w_600,h_338,al_c,q_80,enc_auto/698296_73354fdcb0784e53a115d1807d473683~mv2.jpg', 55.00, 23, 1);
INSERT INTO `properties` VALUES (320, 'Mặt bằng cho thuê tại phố Bà Triệu', 'Mặt bằng cho thuê tại phố Bà Triệu, diện tích 150m2, mặt tiền rộng, thích hợp làm cửa hàng, showroom hoặc văn phòng. Vị trí trung tâm, dễ dàng di chuyển.', 150.00, 'Phố Bà Triệu, Hai Bà Trưng, Hà Nội', 'Cho thue mat bang', '2', '2024-12-31 21:20:00', '2025-01-03 21:45:14', 'https://th.bing.com/th/id/OIP.13ntnAAN6eIXZeNfZZRMvAHaEK?w=1920&h=1080&rs=1&pid=ImgDetMain', 150.00, 24, 1);
INSERT INTO `properties` VALUES (321, 'Biệt thự sân vườn tại khu đô thị Dương Nội', 'Biệt thự sân vườn tại khu đô thị Dương Nội, diện tích rộng, có hồ bơi, sân vườn riêng, thích hợp cho các gia đình lớn, gần các tiện ích như trường học, bệnh viện.', 250.00, 'Khu đô thị Dương Nội, Hà Đông, Hà Nội', 'Cho thue biet thu', '1', '2024-12-31 22:30:00', '2025-01-03 21:44:57', 'https://th.bing.com/th/id/OIP.5_qMjeEFGhiDlQMwCc8hPAHaE8?pid=ImgDet&w=178&h=118&c=7&dpr=1.5', 350.00, 25, 1);
INSERT INTO `properties` VALUES (322, 'Căn hộ 3 phòng ngủ tại Vinhomes Metropolis', 'Căn hộ 3 phòng ngủ tại Vinhomes Metropolis, nội thất sang trọng, view đẹp, gần các trung tâm thương mại, khu vực an ninh cao, giao thông thuận tiện.', 150.00, 'Vinhomes Metropolis, Liễu Giai, Ba Đình, Hà Nội', 'Cho thue can ho', '2', '2024-12-31 23:45:00', '2025-01-03 21:44:39', 'https://fiverr-res.cloudinary.com/images/t_main1,q_auto,f_auto,q_auto,f_auto/gigs/281808041/original/73473778f2f637ae3b3d593b9c83e6ed016c6cb5/create-a-3d-bim-architectural-model-in-revit.png', 130.00, 26, 1);
INSERT INTO `properties` VALUES (323, 'Cho thuê nhà phố tại Tô Hiến Thành, Hai Bà Trưng', 'Nhà phố cho thuê tại Tô Hiến Thành, diện tích 100m2, 3 tầng, mặt tiền rộng, thích hợp làm cửa hàng hoặc văn phòng. Khu vực dân cư đông đúc, giao thông thuận tiện.', 120.00, 'Tô Hiến Thành, Hai Bà Trưng, Hà Nội', 'Cho thue nha pho', '1', '2024-12-31 23:59:00', '2025-01-03 21:44:13', 'https://i.pinimg.com/736x/80/ca/79/80ca79befba2abd56dea632b1d1d77d0.jpg', 100.00, 27, 1);
INSERT INTO `properties` VALUES (324, 'Căn hộ cho thuê tại The Link, Long Biên', 'Căn hộ cho thuê tại The Link, Long Biên, đầy đủ tiện nghi, có ban công view thoáng, gần trường học, bệnh viện và các trung tâm mua sắm. Phù hợp cho các cặp vợ chồng trẻ hoặc người đi làm.', 50.00, 'The Link, Long Biên, Hà Nội', 'Cho thue can ho', '2', '2024-12-31 12:00:00', '2025-01-03 21:56:31', 'https://th.bing.com/th/id/OIP.T-e-UPudeK7H5_zZD6NHOQHaHa?w=2048&h=2048&rs=1&pid=ImgDetMain', 60.00, 7, 1);
INSERT INTO `properties` VALUES (325, 'Căn hộ 1 phòng ngủ tại Golden Palace, Mễ Trì', 'Căn hộ 1 phòng ngủ tại Golden Palace, nội thất hiện đại, đầy đủ tiện nghi, khu vực giao thông thuận tiện, gần các trung tâm thương mại, siêu thị.', 45.00, 'Golden Palace, Mễ Trì, Nam Từ Liêm, Hà Nội', 'Cho thue can ho', '1', '2024-12-31 20:10:00', '2025-01-03 21:44:01', 'https://i.pinimg.com/736x/7e/b2/ec/7eb2ece1c07cc98cd61cb26e297c2393.jpg', 55.00, 23, 1);
INSERT INTO `properties` VALUES (326, 'Mặt bằng cho thuê tại phố Bà Triệu', 'Mặt bằng cho thuê tại phố Bà Triệu, diện tích 150m2, mặt tiền rộng, thích hợp làm cửa hàng, showroom hoặc văn phòng. Vị trí trung tâm, dễ dàng di chuyển.', 150.00, 'Phố Bà Triệu, Hai Bà Trưng, Hà Nội', 'Cho thue mat bang', '2', '2024-12-31 21:20:00', '2025-01-03 21:43:52', 'https://smarthome.worldtech.vn/wp-content/uploads/2017/10/cac-mau-nha-vuon-dep-1024x716.jpg', 150.00, 24, 1);
INSERT INTO `properties` VALUES (327, 'Biệt thự sân vườn tại khu đô thị Dương Nội', 'Biệt thự sân vườn tại khu đô thị Dương Nội, diện tích rộng, có hồ bơi, sân vườn riêng', 250.00, 'Khu đô thị Dương Nội, Hà Đông, Hà Nội', 'Cho thue biet thu', '1', '2024-12-31 22:30:00', '2025-01-03 22:07:01', 'https://th.bing.com/th/id/OIP.cmPJ8EnFvTIh8N1DLymSOAHaEK?w=2560&h=1440&rs=1&pid=ImgDetMain', 350.00, 25, 1);
INSERT INTO `properties` VALUES (328, 'Căn hộ 3 phòng ngủ tại Vinhomes Metropolis', 'Căn hộ 3 phòng ngủ', 150.00, 'Vinhomes Metropolis, Liễu Giai, Ba Đình, Hà Nội', 'Cho thue can ho', '2', '2024-12-31 23:45:00', '2025-01-03 22:06:54', 'https://nhadeptana.vn/wp-content/uploads/2021/08/anh-du_00001-1536x1118.jpg', 130.00, 26, 1);
INSERT INTO `properties` VALUES (329, 'Cho thuê nhà phố tại Tô Hiến Thành, Hai Bà Trưng', 'Nhà phố cho thuê tại Tô Hiến Thành, diện tích 100m2, 3 tầng, mặt tiền rộng, thích hợp làm cửa hàng hoặc văn phòng. Khu vực dân cư đông đúc', 120.00, 'Tô Hiến Thành, Hai Bà Trưng, Hà Nội', 'Cho thue nha pho', '1', '2024-12-31 23:59:00', '2025-01-03 22:06:41', 'https://katahome.com/wp-content/uploads/2018/05/Mau-biet-thu-hien-dai-2-tang-don-gian-tai-Thai-Nguyen-BT-25058-03-600x424.jpg', 100.00, 27, 1);
INSERT INTO `properties` VALUES (331, 'Căn hộ 1 phòng ngủ tại Golden Palace, Mễ Trì', 'Căn hộ 1 phòng ngủ tại Golden Palace, nội thất hiện đại, đầy đủ tiện nghi, khu vực giao thông thuận tiện', 45.00, 'Golden Palace, Mễ Trì, Nam Từ Liêm, Hà Nội', 'Cho thue can ho', '1', '2024-12-31 20:10:00', '2025-01-03 22:06:32', 'https://luxviet.vn/wp-content/uploads/2020/12/Mau-nha-2-tang-hien-dai-don-gian-dep-tai-ha-tinh-luxviet-26102-03.jpg', 55.00, 23, 1);
INSERT INTO `properties` VALUES (332, 'Mặt bằng cho thuê tại phố Bà Triệu', 'Mặt bằng cho thuê tại phố Bà Triệu, diện tích 150m2, mặt tiền rộng, thích hợp làm cửa hàng, showroom hoặc văn phòng. Vị trí trung tâm', 150.00, 'Phố Bà Triệu, Hai Bà Trưng, Hà Nội', 'Cho thue mat bang', '2', '2024-12-31 21:20:00', '2025-01-03 22:06:25', 'https://nhadeptana.vn/wp-content/uploads/2022/03/z3237450524041_f5839c06959bf0b10707dd3d01d851c4.jpg', 150.00, 24, 1);
INSERT INTO `properties` VALUES (333, 'Biệt thự sân vườn tại khu đô thị Dương Nội', 'Biệt thự sân vườn', 250.00, 'Khu đô thị Dương Nội, Hà Đông, Hà Nội', 'Cho thue biet thu', '1', '2024-12-31 22:30:00', '2025-01-03 22:06:19', 'https://nhadeptana.vn/wp-content/uploads/2022/01/mau-thiet-ke-2-tang-hien-dai-dep-7-min-768x559.jpg', 350.00, 25, 1);
INSERT INTO `properties` VALUES (334, 'Căn hộ 3 phòng ngủ tại Vinhomes Metropolis', 'Căn hộ 3 phòng ngủ', 150.00, 'Vinhomes Metropolis, Liễu Giai, Ba Đình, Hà Nội', 'Cho thue can ho', '2', '2024-12-31 23:45:00', '2025-01-03 22:06:07', 'https://th.bing.com/th/id/OIP.9rS5wkBZkISBOoWwTtT4eAHaFY?pid=ImgDet&w=178&h=129&c=7&dpr=1.5', 130.00, 26, 1);
INSERT INTO `properties` VALUES (335, 'Cho thuê nhà phố tại Tô Hiến Thành, Hai Bà Trưng', 'Nhà phố cho thuê tại Tô Hiến Thành', 120.00, 'Tô Hiến Thành, Hai Bà Trưng, Hà Nội', 'Cho thue nha pho', '1', '2024-12-31 23:59:00', '2025-01-03 22:05:56', 'https://th.bing.com/th/id/OIP.u2Ppix_zfy4TCrdzvUEEhAHaFj?pid=ImgDet&w=474&h=355&rs=1', 100.00, 27, 1);
INSERT INTO `properties` VALUES (336, 'Căn hộ cho thuê tại The Link, Long Biên', 'Căn hộ cho thuê tại Hà Nội', 50.00, 'The Link, Long Biên, Hà Nội', 'Cho thue can ho', '2', '2024-12-31 12:00:00', '2025-01-03 22:05:41', 'https://nhadeptana.vn/wp-content/uploads/2022/10/2-tang-mai-nhat-dep-4.gif', 60.00, 7, 1);
INSERT INTO `properties` VALUES (337, 'Nhà bán đất ngay chỗ kế bên quận 3 HCM', 'Nhà đẹp nha mọi người ơi nhờ ghé qua xem ', 30.00, 'Quận 3 Thành Phố Hồ Chí Minh', 'Nhà ở', '1', '2025-01-03 22:00:25', '2025-01-03 22:00:25', 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1735916426/pnxmj9h4yysgdg2gg4bf.jpg', 20.00, 1, 0);
INSERT INTO `properties` VALUES (338, 'Nhà phố quận 2', 'Nhà phố gần cầu Thủ Thiêm', 20.00, '555 Trần Nao, Quận 2, TP HCM', 'apartment', '2', '2024-10-22 19:12:45', '2024-11-08 21:18:06', 'https://media.batdongsan.vn/crop/300x200/projects/20180719154500-7456.jpg', 140.00, 14, 1);
INSERT INTO `properties` VALUES (339, 'Nhà cấp 4 vùng quê Bạc Liêu', 'Nhà vùng quê, mở cửa thấy đồng ruộng', 100.00, '456 Điện Biên Phủ, Bạc Liêu', 'apartment', '1', '2024-10-22 19:12:45', '2024-11-06 23:38:58', 'https://th.bing.com/th/id/OIP.fjqwHfpCEbrpZXaW1cLCKAAAAA?rs=1&pid=ImgDetMain', 210.00, 15, 1);
INSERT INTO `properties` VALUES (340, 'Biệt thự Thảo Điền', 'Biệt thự sân vườn rộng', 30.00, '999 Quốc Hương, Quận 2, TP HCM', 'apartment', '2', '2024-10-22 19:12:45', '2024-11-08 21:19:17', 'https://media.batdongsan.vn/posts/123860_672dfdb1a5abe.jpg', 450.00, 16, 1);

-- ----------------------------
-- Table structure for property_details
-- ----------------------------
DROP TABLE IF EXISTS `property_details`;
CREATE TABLE `property_details`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property_id` int(11) NULL DEFAULT NULL,
  `area` decimal(10, 2) NOT NULL,
  `price` decimal(15, 2) NOT NULL,
  `frontage` decimal(10, 2) NOT NULL,
  `access_road` decimal(10, 2) NOT NULL,
  `floors` int(11) NOT NULL,
  `bedrooms` int(11) NOT NULL,
  `bathrooms` int(11) NOT NULL,
  `legal_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `furniture_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `property_id`(`property_id` ASC) USING BTREE,
  CONSTRAINT `property_details_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of property_details
-- ----------------------------
INSERT INTO `property_details` VALUES (11, 1, 100.00, 200.00, 10.00, 5.00, 2, 3, 2, 'Sổ đỏ', 'Đầy đủ');
INSERT INTO `property_details` VALUES (12, 2, 150.00, 300.00, 12.00, 6.00, 3, 4, 3, 'Sổ hồng', 'Đầy đủ');
INSERT INTO `property_details` VALUES (13, 3, 80.00, 150.00, 8.00, 4.00, 1, 2, 1, 'Sổ đỏ', 'Cơ bản');
INSERT INTO `property_details` VALUES (14, 4, 120.00, 250.00, 9.50, 5.50, 2, 3, 2, 'Sổ đỏ', 'Đầy đủ');
INSERT INTO `property_details` VALUES (15, 5, 200.00, 400.00, 15.00, 7.00, 4, 5, 4, 'Sổ hồng', 'Đầy đủ');
INSERT INTO `property_details` VALUES (16, 6, 110.00, 220.00, 10.00, 6.00, 2, 3, 2, 'Sổ đỏ', 'Cơ bản');
INSERT INTO `property_details` VALUES (17, 7, 95.00, 190.00, 11.00, 5.50, 2, 3, 2, 'Sổ hồng', 'Đầy đủ');
INSERT INTO `property_details` VALUES (18, 8, 130.00, 280.00, 12.50, 6.50, 3, 4, 3, 'Sổ đỏ', 'Đầy đủ');
INSERT INTO `property_details` VALUES (19, 13, 140.00, 320.00, 13.00, 7.00, 3, 4, 3, 'Sổ hồng', 'Đầy đủ');
INSERT INTO `property_details` VALUES (20, 14, 90.00, 180.00, 8.50, 4.50, 1, 2, 1, 'Sổ đỏ', 'Cơ bản');

-- ----------------------------
-- Table structure for property_images
-- ----------------------------
DROP TABLE IF EXISTS `property_images`;
CREATE TABLE `property_images`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property_id` int(11) NOT NULL,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `property_id`(`property_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 177 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of property_images
-- ----------------------------
INSERT INTO `property_images` VALUES (14, 14, 'https://hoangquan.com.vn/vnt_upload/news/12_2020/bat-dong-san61.jpg');
INSERT INTO `property_images` VALUES (21, 12, 'https://hoangquan.com.vn/vnt_upload/news/12_2020/bat-dong-san61.jpg');
INSERT INTO `property_images` VALUES (22, 13, 'https://hoangquan.com.vn/vnt_upload/news/12_2020/bat-dong-san61.jpg');
INSERT INTO `property_images` VALUES (23, 15, 'https://hoangquan.com.vn/vnt_upload/news/12_2020/bat-dong-san61.jpg');
INSERT INTO `property_images` VALUES (24, 16, 'https://hoangquan.com.vn/vnt_upload/news/12_2020/bat-dong-san61.jpg');
INSERT INTO `property_images` VALUES (25, 79, 'https://hoangquan.com.vn/vnt_upload/news/12_2020/bat-dong-san61.jpg');
INSERT INTO `property_images` VALUES (26, 77, 'https://hoangquan.com.vn/vnt_upload/news/12_2020/bat-dong-san61.jpg');
INSERT INTO `property_images` VALUES (27, 11, 'https://hoangquan.com.vn/vnt_upload/news/12_2020/bat-dong-san61.jpg');
INSERT INTO `property_images` VALUES (28, 64, 'https://hoangquan.com.vn/vnt_upload/news/12_2020/bat-dong-san61.jpg');
INSERT INTO `property_images` VALUES (29, 63, 'https://hoangquan.com.vn/vnt_upload/news/12_2020/bat-dong-san61.jpg');
INSERT INTO `property_images` VALUES (30, 65, 'https://hoangquan.com.vn/vnt_upload/news/12_2020/bat-dong-san61.jpg');
INSERT INTO `property_images` VALUES (62, 1, 'https://sketchup.cgtips.org/wp-content/uploads/2022/06/7270.-Sketchup-House-Exterior-Model-Download-by-Trung-Nguyen-1-768x747.jpg');
INSERT INTO `property_images` VALUES (63, 1, 'https://i.pinimg.com/736x/49/40/6a/49406a0c43f4e077f51891fa49b816f3.jpg');
INSERT INTO `property_images` VALUES (64, 1, 'https://i.pinimg.com/736x/79/da/04/79da04441df6189bedfa4d5efeb054c8.jpg');
INSERT INTO `property_images` VALUES (65, 2, 'https://th.bing.com/th/id/OIP.Cxi3eQBb-t6_TUUljQbqFAHaH-?rs=1&pid=ImgDetMain');
INSERT INTO `property_images` VALUES (66, 2, 'https://th.bing.com/th/id/OIP.bMAU81ujll4vooXpZMnNBgHaHa?w=1400&h=1400&rs=1&pid=ImgDetMain');
INSERT INTO `property_images` VALUES (67, 3, 'https://th.bing.com/th/id/OIP.5rBphtYWMY2FU1XUP2QApgHaFL?rs=1&pid=ImgDetMain');
INSERT INTO `property_images` VALUES (68, 3, 'https://th.bing.com/th/id/OIP.1eVQcfd_GsuJloHRQYgaFAHaHZ?w=720&h=719&rs=1&pid=ImgDetMain');
INSERT INTO `property_images` VALUES (69, 4, 'https://th.bing.com/th/id/OIP.ZVTg3mTZih0XHZC5GqnoxgHaFV?w=220&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7');
INSERT INTO `property_images` VALUES (70, 4, 'https://suanhaphattai.com/wp-content/uploads/2015/08/hinh-anh-nha-dep-3.jpg');
INSERT INTO `property_images` VALUES (71, 4, 'https://th.bing.com/th/id/OIP.vlQojNVM49rZGVJPlD9TaAHaDn?w=309&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7');
INSERT INTO `property_images` VALUES (72, 5, 'https://tuvannhadep.com.vn/uploads/images/hinh-anh-nha-dep-10.jpg');
INSERT INTO `property_images` VALUES (73, 5, 'https://cdna.artstation.com/p/assets/images/images/024/072/144/large/hamza-hanif-22.jpg?1581244941');
INSERT INTO `property_images` VALUES (74, 6, 'https://cdna.artstation.com/p/assets/images/images/024/072/144/large/hamza-hanif-22.jpg?1581244941');
INSERT INTO `property_images` VALUES (75, 6, 'https://th.bing.com/th/id/OIP.oHIFmCfZXrktPoSEVqfdzgHaEK?w=1000&h=563&rs=1&pid=ImgDetMain');
INSERT INTO `property_images` VALUES (78, 8, 'https://th.bing.com/th/id/OIP.IFrE7PPsGb1XNmYN4azZsAHaFj?rs=1&pid=ImgDetMain');
INSERT INTO `property_images` VALUES (79, 8, 'https://th.bing.com/th/id/OIP.Rf0-pX1rHJ3EVrg8D5yQTgHaFj?rs=1&pid=ImgDetMain');
INSERT INTO `property_images` VALUES (80, 7, 'https://scr.vn/wp-content/uploads/2020/08/%E1%BA%A2nh-nh%C3%A0-%C4%91%E1%BA%B9p-xe-sang.jpg');
INSERT INTO `property_images` VALUES (81, 7, 'https://scr.vn/wp-content/uploads/2020/08/H%C3%ACnh-nh%C3%A0-%C4%91%E1%BA%B9p-v%E1%BB%9Bi-xe-sang.jpg');
INSERT INTO `property_images` VALUES (82, 13, 'https://scr.vn/wp-content/uploads/2020/08/M%E1%BA%ABu-nh%C3%A0-%C4%91%E1%BA%B9p-xe-%C4%91%E1%BA%B9p.png');
INSERT INTO `property_images` VALUES (83, 13, 'https://scr.vn/wp-content/uploads/2020/08/Nh%C3%A0-2-t%E1%BA%A7ng-%C4%91%E1%BA%B9p-v%C3%A0-xe-%C4%91%E1%BA%B9p.jpg');
INSERT INTO `property_images` VALUES (84, 14, 'https://scr.vn/wp-content/uploads/2020/08/H%C3%ACnh-nh%C3%A0-%C4%91%E1%BA%B9p-xe-sang.jpg');
INSERT INTO `property_images` VALUES (100, 183, 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733404403/trjkpuwvb55py4gwxbrg.jpg');
INSERT INTO `property_images` VALUES (101, 183, 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733404405/kd2oyeupiy7zex87c6my.jpg');
INSERT INTO `property_images` VALUES (102, 183, 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733404408/gnujkdzsgr1we19w31tg.jpg');
INSERT INTO `property_images` VALUES (103, 185, 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733405016/poc9pfy3wxt3gor65j8e.jpg');
INSERT INTO `property_images` VALUES (104, 185, 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733405019/qxsbaferh2zaiepgrzcm.jpg');
INSERT INTO `property_images` VALUES (105, 186, 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733406036/q8rghwxarxemb5bp5f78.jpg');
INSERT INTO `property_images` VALUES (106, 186, 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733406038/tpmnudx4ziow5vggonty.jpg');
INSERT INTO `property_images` VALUES (107, 187, 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733406200/zmsxxrd3na3owgv1nxvv.jpg');
INSERT INTO `property_images` VALUES (108, 187, 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733406202/czdhflqzw92kjzbpdnzk.jpg');
INSERT INTO `property_images` VALUES (112, 2, 'https://sketchup.cgtips.org/wp-content/uploads/2022/06/7270.-Sketchup-House-Exterior-Model-Download-by-Trung-Nguyen-1-768x747.jpg');
INSERT INTO `property_images` VALUES (113, 187, 'https://th.bing.com/th/id/OIP.IFrE7PPsGb1XNmYN4azZsAHaFj?rs=1&pid=ImgDetMain');
INSERT INTO `property_images` VALUES (114, 187, 'https://sketchup.cgtips.org/wp-content/uploads/2022/06/7270.-Sketchup-House-Exterior-Model-Download-by-Trung-Nguyen-1-768x747.jpg');
INSERT INTO `property_images` VALUES (115, 187, 'https://cdna.artstation.com/p/assets/images/images/024/072/144/large/hamza-hanif-22.jpg?1581244941');
INSERT INTO `property_images` VALUES (117, 2, 'https://th.bing.com/th/id/OIP.IFrE7PPsGb1XNmYN4azZsAHaFj?rs=1&pid=ImgDetMain');
INSERT INTO `property_images` VALUES (118, 2, 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733414720/yoodfgwpupcwplrrtp7h.jpg');
INSERT INTO `property_images` VALUES (119, 188, 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733414879/kigtvanxxw0dcq00up3m.jpg');
INSERT INTO `property_images` VALUES (120, 188, 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733414882/gw79ed4fwbocfj2yjo1v.jpg');
INSERT INTO `property_images` VALUES (121, 188, 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733414884/t0vqe7ltdzfoeyeyvxac.jpg');
INSERT INTO `property_images` VALUES (122, 191, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733453941/slm09hixi22wsasnmryu.jpg');
INSERT INTO `property_images` VALUES (123, 194, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733634673/aufcjcmwvqumhanylubx.jpg');
INSERT INTO `property_images` VALUES (124, 194, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733634675/o1ecpqopkllucl6qwozb.jpg');
INSERT INTO `property_images` VALUES (125, 194, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733634676/crhett0awaczmsjlshgj.jpg');
INSERT INTO `property_images` VALUES (126, 195, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733634744/wbx8awzh9dwi0hgc4ce9.jpg');
INSERT INTO `property_images` VALUES (127, 195, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733634746/gnkgkswzc1zupsd23nch.jpg');
INSERT INTO `property_images` VALUES (128, 195, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733634748/g4eqhgxmh1eof0vtqu4y.jpg');
INSERT INTO `property_images` VALUES (129, 196, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733634879/xao8r5cypaftpz08i6pp.jpg');
INSERT INTO `property_images` VALUES (130, 196, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733634882/zpncjwovrp03nmauql8b.jpg');
INSERT INTO `property_images` VALUES (131, 196, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733634885/i27b10t0el5schekf6vb.jpg');
INSERT INTO `property_images` VALUES (132, 197, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733635334/pnmxkhxi42xrlbrhvx9w.webp');
INSERT INTO `property_images` VALUES (133, 197, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733635337/vmvpspzezm4yeedidsmt.webp');
INSERT INTO `property_images` VALUES (134, 197, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733635340/gszewxfvmbo9za8djdpe.webp');
INSERT INTO `property_images` VALUES (135, 198, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733635454/uut7t7o7s7popzeotzro.webp');
INSERT INTO `property_images` VALUES (136, 198, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733635456/ityug4x7up4o7e4334tp.webp');
INSERT INTO `property_images` VALUES (137, 198, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733635459/pd2s9jywdayizegcz8an.webp');
INSERT INTO `property_images` VALUES (138, 199, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733635514/arpflzbwwh8yrcphz6hn.webp');
INSERT INTO `property_images` VALUES (139, 199, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733635517/vmpgwtzyy7jxffo0rdxn.webp');
INSERT INTO `property_images` VALUES (140, 200, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733635589/yz9z1tdn8voavpyhybhc.webp');
INSERT INTO `property_images` VALUES (141, 200, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733635592/giob1jgbtmuves8qg0n9.webp');
INSERT INTO `property_images` VALUES (142, 200, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1733635595/wtpc4jjmifvoyveixxve.webp');
INSERT INTO `property_images` VALUES (143, 201, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734104628/lrimq0uwufjar604fhfx.webp');
INSERT INTO `property_images` VALUES (144, 201, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734104631/i8ypiisuhkgfisq68n5i.webp');
INSERT INTO `property_images` VALUES (145, 15, 'https://th.bing.com/th/id/OIP.IFrE7PPsGb1XNmYN4azZsAHaFj?rs=1&pid=ImgDetMain');
INSERT INTO `property_images` VALUES (146, 15, 'https://cdna.artstation.com/p/assets/images/images/024/072/144/large/hamza-hanif-22.jpg?1581244941');
INSERT INTO `property_images` VALUES (147, 202, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734434953/fki8dovfafou1f28jlu7.webp');
INSERT INTO `property_images` VALUES (148, 202, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734434956/kgtin5idg4tca4k7mqdq.webp');
INSERT INTO `property_images` VALUES (149, 202, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734434958/p5nx7ebcmpxwpiviwuc7.webp');
INSERT INTO `property_images` VALUES (150, 206, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734534907/a2oruvneb9oinmhtdhmv.webp');
INSERT INTO `property_images` VALUES (151, 206, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734534910/qkc2ocdtmb6rvdczihib.webp');
INSERT INTO `property_images` VALUES (152, 207, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734535124/hekdviinqtd5td6fttmo.webp');
INSERT INTO `property_images` VALUES (153, 207, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734535127/peolsvouy6gi741nwsqh.webp');
INSERT INTO `property_images` VALUES (154, 207, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734535131/wwz9xzytx58qt8zhxjnz.webp');
INSERT INTO `property_images` VALUES (155, 208, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734536620/tyjjoank7gm9w42n80tv.webp');
INSERT INTO `property_images` VALUES (156, 208, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734536624/upmjhp5f5b7vpiozkrjl.webp');
INSERT INTO `property_images` VALUES (157, 209, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734538183/o92vnoxaokv8tt0cpfph.webp');
INSERT INTO `property_images` VALUES (158, 209, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734538187/t7taknjvpujdvukqlaya.webp');
INSERT INTO `property_images` VALUES (159, 209, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734538189/q92o5ymixlot3v3eysyk.webp');
INSERT INTO `property_images` VALUES (160, 211, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734602195/ubyevcrvfqevsb8zuuom.webp');
INSERT INTO `property_images` VALUES (161, 211, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734602199/ekqyrpmo6pl2dnz0z9xb.webp');
INSERT INTO `property_images` VALUES (162, 211, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734602203/kxsv2pk8ozg5y5kzwqgf.webp');
INSERT INTO `property_images` VALUES (163, 212, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734602617/avphrom5klui6t8arage.webp');
INSERT INTO `property_images` VALUES (164, 212, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734602620/t9fauvzrjnrzlyjvp4wv.webp');
INSERT INTO `property_images` VALUES (165, 212, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734602623/qushnphdy78va9zizwyh.webp');
INSERT INTO `property_images` VALUES (166, 213, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734602739/ulkrdvgxwkr4nikiw0lo.webp');
INSERT INTO `property_images` VALUES (167, 213, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734602744/vebmyxsriqo23htcgfez.webp');
INSERT INTO `property_images` VALUES (168, 213, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734602749/vk9vantvqmnixqxd692i.webp');
INSERT INTO `property_images` VALUES (169, 240, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1735025404/szhanr1jgfzjnav7sffb.jpg');
INSERT INTO `property_images` VALUES (170, 240, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1735025407/hntxuxpwyfqg7fuxsals.jpg');
INSERT INTO `property_images` VALUES (171, 240, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1735025410/fjnuld1hcthvkt9sv1zu.jpg');
INSERT INTO `property_images` VALUES (172, 241, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1735287582/csebdgryih3rq3kf06h3.webp');
INSERT INTO `property_images` VALUES (173, 241, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1735287584/afdvrglykprvxz4o8jnw.webp');
INSERT INTO `property_images` VALUES (174, 241, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1735287587/gfllj24yatawfuet8ujj.webp');
INSERT INTO `property_images` VALUES (175, 337, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1735916432/g9lgovl6853pvhw8ow2t.webp');
INSERT INTO `property_images` VALUES (176, 337, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1735916437/ug2hqfquymeog70tzfm9.webp');

-- ----------------------------
-- Table structure for property_videos
-- ----------------------------
DROP TABLE IF EXISTS `property_videos`;
CREATE TABLE `property_videos`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property_id` int(11) NOT NULL,
  `video_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `property_id`(`property_id` ASC) USING BTREE,
  CONSTRAINT `property_videos_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of property_videos
-- ----------------------------
INSERT INTO `property_videos` VALUES (11, 1, '/uploads/Meet - dyp-cxch-kjq and 2 more pages - Personal - Microsoft​ Edge 2022-02-24 08-56-44.mp4');

-- ----------------------------
-- Table structure for review_imgs
-- ----------------------------
DROP TABLE IF EXISTS `review_imgs`;
CREATE TABLE `review_imgs`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `review_id` int(11) NULL DEFAULT NULL,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `review_id`(`review_id` ASC) USING BTREE,
  CONSTRAINT `review_imgs_ibfk_1` FOREIGN KEY (`review_id`) REFERENCES `reviews` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of review_imgs
-- ----------------------------
INSERT INTO `review_imgs` VALUES (2, 17, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734942959/ss2wtpugt0sklqktvqel.jpg');
INSERT INTO `review_imgs` VALUES (3, 17, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734942962/gasbl3ozdajohqinhhxi.jpg');
INSERT INTO `review_imgs` VALUES (4, 17, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1734942965/s0vtvoaxhhgcrvfxrxpp.jpg');
INSERT INTO `review_imgs` VALUES (5, 19, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1735016600/sqpac3p2oehv2pggsg5n.webp');
INSERT INTO `review_imgs` VALUES (6, 19, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1735016605/wfy5snbjzywlg99y2cup.webp');
INSERT INTO `review_imgs` VALUES (7, 19, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1735016610/lqsasvingqqgu0enxj0d.webp');
INSERT INTO `review_imgs` VALUES (8, 19, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1735016612/uind2ge3lnlguw61lypi.webp');
INSERT INTO `review_imgs` VALUES (9, 19, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1735016616/weiuatrt9ybbn4s4ktrv.webp');
INSERT INTO `review_imgs` VALUES (10, 19, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1735016621/qjuqe4mv9fklumczqp47.webp');
INSERT INTO `review_imgs` VALUES (11, 22, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1735140800/vj3fv1adqz6nk8t5kpbc.png');
INSERT INTO `review_imgs` VALUES (12, 23, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1735140975/pn5etlz0d3m86pzsgbbu.webp');
INSERT INTO `review_imgs` VALUES (13, 23, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1735140978/hscc8qpprbiykuxfw7ja.webp');
INSERT INTO `review_imgs` VALUES (14, 23, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1735140982/ac3d1fxuzpwkooihtga0.webp');
INSERT INTO `review_imgs` VALUES (15, 24, 'https://res.cloudinary.com/dg0f7bdho/image/upload/v1735375553/rxfj61swb0jtxjk8egcs.webp');

-- ----------------------------
-- Table structure for reviews
-- ----------------------------
DROP TABLE IF EXISTS `reviews`;
CREATE TABLE `reviews`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `review` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `property_id`(`property_id` ASC) USING BTREE,
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reviews
-- ----------------------------
INSERT INTO `reviews` VALUES (2, 201, 5, 'ok lắm nha mng hehe', '2024-12-16 09:24:23');
INSERT INTO `reviews` VALUES (3, 201, 3, 'ok nha mng oi ', '2024-12-16 09:28:47');
INSERT INTO `reviews` VALUES (6, 200, 5, 'nhà đẹp quá mọi người hehe tới xem nhá mng  ', '2024-12-16 10:45:07');
INSERT INTO `reviews` VALUES (7, 201, 5, 'đc nha mng xem dùm tui zới', '2024-12-16 11:15:15');
INSERT INTO `reviews` VALUES (8, 199, 5, 'ok nha mng toi xem dum tui voi     ', '2024-12-16 14:45:20');
INSERT INTO `reviews` VALUES (9, 1, 5, 'dep ma mng xem ik    ', '2024-12-16 23:05:05');
INSERT INTO `reviews` VALUES (10, 1, 5, 'hehe', '2024-12-16 23:05:13');
INSERT INTO `reviews` VALUES (13, 192, 5, 'ok ne mng oi\r\n', '2024-12-23 14:25:04');
INSERT INTO `reviews` VALUES (14, 235, 5, 'Trà sữa ngon nha mọi người ơi rất ngon nhớ ghé qua xem ', '2024-12-23 14:32:00');
INSERT INTO `reviews` VALUES (15, 236, 5, 'Traf sua ngon nhe mng oi ', '2024-12-23 15:04:04');
INSERT INTO `reviews` VALUES (17, 236, 5, 'Nhà đệp', '2024-12-23 15:35:55');
INSERT INTO `reviews` VALUES (19, 230, 5, 'Nhà đẹp nha mng ơi hehe', '2024-12-24 12:03:17');
INSERT INTO `reviews` VALUES (20, 230, 5, 'Nhà ok đó chứ alo  ', '2024-12-24 22:19:03');
INSERT INTO `reviews` VALUES (21, 216, 5, 'ngon nha mng ', '2024-12-24 22:32:58');
INSERT INTO `reviews` VALUES (22, 201, 5, 'Nhà khá đẹp ', '2024-12-25 22:33:01');
INSERT INTO `reviews` VALUES (23, 201, 5, 'nhà khá ok ', '2024-12-25 22:36:11');
INSERT INTO `reviews` VALUES (24, 214, 5, 'Dep nha mng ', '2024-12-28 15:45:49');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'inactive',
  `role` enum('admin','user') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'user',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'johnn', '202cb962ac59075b964b07152d234b70', 'khoangoquan@gmail.com', NULL, 'active', 'admin');
INSERT INTO `users` VALUES (2, 'khoa', '202cb962ac59075b964b07152d234b70', 'khoangoquan@gmail.com', NULL, 'active', 'admin');
INSERT INTO `users` VALUES (3, 'khoa12', '202cb962ac59075b964b07152d234b70', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (4, 'khoa1', '202cb962ac59075b964b07152d234b70', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (5, 'john123', '202cb962ac59075b964b07152d234b70', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (6, 'admin', '21232f297a57a5a743894a0e4a801fc3', '21130401@st.hcmuaf.edu.vn', NULL, 'active', 'admin');
INSERT INTO `users` VALUES (7, 'admin11', '202cb962ac59075b964b07152d234b70', '21130401@st.hcmuaf.edu.vn', NULL, 'active', 'admin');
INSERT INTO `users` VALUES (8, 'john', '21232f297a57a5a743894a0e4a801fc3', '21130401@st.hcmuaf.edu.vn', NULL, 'active', 'admin');
INSERT INTO `users` VALUES (9, 'john12', '202cb962ac59075b964b07152d234b70', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (10, 'john1234', '202cb962ac59075b964b07152d234b70', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (11, 'john12345', '202cb962ac59075b964b07152d234b70', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (12, 'john123456', '202cb962ac59075b964b07152d234b70', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (13, 'john1234567', '202cb962ac59075b964b07152d234b70', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (14, 'john12345678', '202cb962ac59075b964b07152d234b70', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (15, 'john123456789', '202cb962ac59075b964b07152d234b70', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (16, 'john1234567890', '202cb962ac59075b964b07152d234b70', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (17, 'john12345678901', '202cb962ac59075b964b07152d234b70', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (23, 'khoangoquan1', '202cb962ac59075b964b07152d234b70', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (24, 'khoangoquan', '202cb962ac59075b964b07152d234b70', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (25, 'khoangoquan11', '202cb962ac59075b964b07152d234b70', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (26, 'khoangoquan123', '202cb962ac59075b964b07152d234b70', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (27, 'admin1123', '21232f297a57a5a743894a0e4a801fc3', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (31, 'admin111', '21232f297a57a5a743894a0e4a801fc3', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (32, 'khoa123', '202cb962ac59075b964b07152d234b70', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (33, 'khoa2003', '202cb962ac59075b964b07152d234b70', 'khoangoquan@gmail.com', '', 'active', 'admin');
INSERT INTO `users` VALUES (34, 'khoa2002', '202cb962ac59075b964b07152d234b70', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (52, 'admin123', '21232f297a57a5a743894a0e4a801fc3', '21130401@st.hcmuaf.edu.vn', NULL, 'active', 'user');
INSERT INTO `users` VALUES (53, 'johnn1111', '202cb962ac59075b964b07152d234b70', '21130401@st.hcmuaf.edu.vn', NULL, 'active', 'user');
INSERT INTO `users` VALUES (56, 'Khoa Ngô', '', 'khoangoquan@gmail.com', NULL, 'active', 'user');

SET FOREIGN_KEY_CHECKS = 1;
