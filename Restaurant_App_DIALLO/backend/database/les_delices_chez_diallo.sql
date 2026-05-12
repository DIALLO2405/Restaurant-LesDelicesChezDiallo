-- ============================================================
-- Base de données : LES DÉLICES CHEZ DIALLO
-- Restaurant de Cuisine Ivoirienne Authentique
-- Adapté par DIALLO CHEICK - 2024
-- ============================================================

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";
SET NAMES utf8mb4;

-- ─────────────────────────────────────────────────────────────
-- BASE DE DONNÉES
-- ─────────────────────────────────────────────────────────────
CREATE DATABASE IF NOT EXISTS `les_delices_chez_diallo`
  DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `les_delices_chez_diallo`;

-- ─────────────────────────────────────────────────────────────
-- TABLE : Roles
-- ─────────────────────────────────────────────────────────────
CREATE TABLE `Roles` (
  `id`        int NOT NULL AUTO_INCREMENT,
  `name`      varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `Roles` (`id`, `name`, `createdAt`, `updatedAt`) VALUES
(1, 'Administrateur', NOW(), NOW()),
(2, 'Serveur',        NOW(), NOW()),
(3, 'Cuisinier',      NOW(), NOW()),
(4, 'Caissier',       NOW(), NOW());

-- ─────────────────────────────────────────────────────────────
-- TABLE : Users
-- ─────────────────────────────────────────────────────────────
CREATE TABLE `Users` (
  `id`        int NOT NULL AUTO_INCREMENT,
  `name`      varchar(255) NOT NULL,
  `email`     varchar(255) NOT NULL,
  `password`  varchar(255) NOT NULL,
  `image`     varchar(255) NOT NULL DEFAULT '/avatar.png',
  `isAdmin`   tinyint(1) NOT NULL DEFAULT '0',
  `roleId`    int DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Mot de passe : admin123 (hashé avec bcrypt)
INSERT INTO `Users` (`id`, `name`, `email`, `password`, `image`, `isAdmin`, `roleId`, `createdAt`, `updatedAt`) VALUES
(1, 'DIALLO CHEICK', 'diallo@delices.ci', '$2b$10$CjajlLeZt0ZiB307hjqsJ.xKEVoMnJc4y/84TAoP8Ecaoqi8/2fQe', '/avatar.png', 1, 1, NOW(), NOW()),
(2, 'Serveur Test',  'serveur@delices.ci', '$2b$10$CjajlLeZt0ZiB307hjqsJ.xKEVoMnJc4y/84TAoP8Ecaoqi8/2fQe', '/avatar.png', 0, 2, NOW(), NOW());

-- ─────────────────────────────────────────────────────────────
-- TABLE : Categories
-- ─────────────────────────────────────────────────────────────
CREATE TABLE `Categories` (
  `id`        int NOT NULL AUTO_INCREMENT,
  `name`      varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `Categories` (`id`, `name`, `createdAt`, `updatedAt`) VALUES
(1, 'Plats Traditionnels',  NOW(), NOW()),
(2, 'Grillades & Braisés',  NOW(), NOW()),
(3, 'Accompagnements',      NOW(), NOW()),
(4, 'Soupes & Sauces',      NOW(), NOW()),
(5, 'Boissons',             NOW(), NOW()),
(6, 'Desserts & Snacks',    NOW(), NOW());

-- ─────────────────────────────────────────────────────────────
-- TABLE : Products (Menu Ivoirien)
-- ─────────────────────────────────────────────────────────────
CREATE TABLE `Products` (
  `id`         int NOT NULL AUTO_INCREMENT,
  `name`       varchar(255) NOT NULL,
  `price`      double NOT NULL,
  `stock`      int NOT NULL DEFAULT 50,
  `categoryId` int NOT NULL,
  `createdAt`  datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt`  datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `categoryId` (`categoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 🍽️ PLATS TRADITIONNELS
INSERT INTO `Products` (`id`, `name`, `price`, `stock`, `categoryId`, `createdAt`, `updatedAt`) VALUES
(1,  'Garba (Attiéké + Thon)',             1000, 100, 1, NOW(), NOW()),
(2,  'Placali sauce graine',               1500, 60,  1, NOW(), NOW()),
(3,  'Foutou banane sauce arachide',       1500, 60,  1, NOW(), NOW()),
(4,  'Foutou igname sauce claire',         1500, 50,  1, NOW(), NOW()),
(5,  'Riz sauce graine',                   1200, 80,  1, NOW(), NOW()),
(6,  'Riz sauce tomate au poulet',         1500, 80,  1, NOW(), NOW()),
(7,  'Attiéké poisson braisé',             1500, 70,  1, NOW(), NOW()),
(8,  'Alloco poulet braisé',               1500, 60,  1, NOW(), NOW()),
(9,  'Kedjenou de poulet (bicyclette)',     2500, 30,  1, NOW(), NOW()),
(10, 'Djoumblé (gombo viande)',             1500, 40,  1, NOW(), NOW()),

-- 🔥 GRILLADES & BRAISÉS
(11, 'Poisson braisé entier (Capitaine)',   3000, 20,  2, NOW(), NOW()),
(12, 'Poulet braisé entier',               3500, 15,  2, NOW(), NOW()),
(13, 'Demi-poulet braisé',                 2000, 30,  2, NOW(), NOW()),
(14, 'Brochettes de bœuf (6 pièces)',      1500, 50,  2, NOW(), NOW()),
(15, 'Tilapia braisé sauce piment',        2500, 25,  2, NOW(), NOW()),
(16, 'Pintade braisée',                    4000, 10,  2, NOW(), NOW()),
(17, 'Ailes de poulet grillées',           1000, 50,  2, NOW(), NOW()),
(18, 'Escargots braisés (sauce tomate)',   2000, 20,  2, NOW(), NOW()),

-- 🌿 ACCOMPAGNEMENTS
(19, 'Alloco (banane plantain frite)',      500,  100, 3, NOW(), NOW()),
(20, 'Attiéké (portion)',                   500,  100, 3, NOW(), NOW()),
(21, 'Riz blanc (portion)',                 500,  100, 3, NOW(), NOW()),
(22, 'Igname pilée',                        700,  60,  3, NOW(), NOW()),
(23, 'Banane plantain bouillie',            400,  80,  3, NOW(), NOW()),
(24, 'Salade de légumes',                   600,  50,  3, NOW(), NOW()),
(25, 'Frites de pomme de terre',            700,  60,  3, NOW(), NOW()),

-- 🥣 SOUPES & SAUCES
(26, 'Soupe de poisson (trimbal)',          1500, 40,  4, NOW(), NOW()),
(27, 'Sauce graine (portion)',              500,  60,  4, NOW(), NOW()),
(28, 'Sauce arachide (portion)',            500,  60,  4, NOW(), NOW()),
(29, 'Soupe de bœuf aux légumes',          2000, 30,  4, NOW(), NOW()),
(30, 'Sauce claire au gombo',              500,  60,  4, NOW(), NOW()),

-- 🥤 BOISSONS
(31, 'Eau minérale (50cl)',                 500,  200, 5, NOW(), NOW()),
(32, 'Eau minérale (1.5L)',                1000, 100, 5, NOW(), NOW()),
(33, 'Bissap (jus de fleur d\'hibiscus)',   500,  80,  5, NOW(), NOW()),
(34, 'Gnamankoudji (gingembre)',           500,  80,  5, NOW(), NOW()),
(35, 'Jus de fruit naturel (orange)',      700,  60,  5, NOW(), NOW()),
(36, 'Jus de fruit naturel (ananas)',      700,  60,  5, NOW(), NOW()),
(37, 'Coca-Cola / Fanta / Sprite',         500,  100, 5, NOW(), NOW()),
(38, 'Bière (Flag / Bock / Heineken)',     1000, 80,  5, NOW(), NOW()),
(39, 'Bangui (vin de palme)',              500,  40,  5, NOW(), NOW()),
(40, 'Café / Thé chaud',                   400,  100, 5, NOW(), NOW()),

-- 🍌 DESSERTS & SNACKS
(41, 'Beignets de banane (6 pièces)',      500,  80,  6, NOW(), NOW()),
(42, 'Bananier (gâteau banane)',           700,  40,  6, NOW(), NOW()),
(43, 'Kossam (fromage local)',             1000, 30,  6, NOW(), NOW()),
(44, 'Ananas frais tranché',               500,  60,  6, NOW(), NOW()),
(45, 'Mangue mûre',                        300,  60,  6, NOW(), NOW());

-- ─────────────────────────────────────────────────────────────
-- TABLE : Clients
-- ─────────────────────────────────────────────────────────────
CREATE TABLE `Clients` (
  `id`        int NOT NULL AUTO_INCREMENT,
  `name`      varchar(255) NOT NULL,
  `address`   varchar(255) NOT NULL DEFAULT 'Abidjan',
  `phone`     varchar(255) NOT NULL DEFAULT '0700000000',
  `email`     varchar(255) NOT NULL,
  `dni`       varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `dni` (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `Clients` (`id`, `name`, `address`, `phone`, `email`, `dni`, `createdAt`, `updatedAt`) VALUES
(1, 'Client Test',         'Cocody, Abidjan',     '0708001122', 'client@test.ci',   'CI-001', NOW(), NOW()),
(2, 'Kouamé Aya',          'Yopougon, Abidjan',   '0709223344', 'kouame@gmail.com', 'CI-002', NOW(), NOW()),
(3, 'Traoré Moussa',       'Adjamé, Abidjan',     '0701334455', 'traore@gmail.com', 'CI-003', NOW(), NOW()),
(4, 'N''Guessan Amoin',    'Marcory, Abidjan',    '0705445566', 'nguess@gmail.com', 'CI-004', NOW(), NOW()),
(5, 'Coulibaly Ibrahim',   'Abobo, Abidjan',      '0707556677', 'couliba@gmail.com','CI-005', NOW(), NOW());

-- ─────────────────────────────────────────────────────────────
-- TABLE : Tables (salle du restaurant)
-- ─────────────────────────────────────────────────────────────
CREATE TABLE `Tables` (
  `id`        int NOT NULL AUTO_INCREMENT,
  `name`      varchar(255) NOT NULL,
  `occupied`  tinyint(1) DEFAULT '0',
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `Tables` (`id`, `name`, `occupied`, `createdAt`, `updatedAt`) VALUES
(1,  'Table 1',     0, NOW(), NOW()),
(2,  'Table 2',     0, NOW(), NOW()),
(3,  'Table 3',     0, NOW(), NOW()),
(4,  'Table 4',     0, NOW(), NOW()),
(5,  'Table 5',     0, NOW(), NOW()),
(6,  'Table 6',     0, NOW(), NOW()),
(7,  'Table 7',     0, NOW(), NOW()),
(8,  'Table 8',     0, NOW(), NOW()),
(9,  'Terrasse 1',  0, NOW(), NOW()),
(10, 'Terrasse 2',  0, NOW(), NOW()),
(11, 'VIP 1',       0, NOW(), NOW()),
(12, 'VIP 2',       0, NOW(), NOW());

-- ─────────────────────────────────────────────────────────────
-- TABLE : Orders
-- ─────────────────────────────────────────────────────────────
CREATE TABLE `Orders` (
  `id`        int NOT NULL AUTO_INCREMENT,
  `total`     double NOT NULL,
  `isPaid`    tinyint(1) NOT NULL DEFAULT '0',
  `delivery`  tinyint(1) NOT NULL DEFAULT '0',
  `note`      varchar(255) DEFAULT NULL,
  `userId`    int NOT NULL,
  `clientId`  int NOT NULL,
  `tableId`   int DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `userId`   (`userId`),
  KEY `clientId` (`clientId`),
  KEY `tableId`  (`tableId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ─────────────────────────────────────────────────────────────
-- TABLE : OrderProducts
-- ─────────────────────────────────────────────────────────────
CREATE TABLE `OrderProducts` (
  `id`        int NOT NULL AUTO_INCREMENT,
  `quantity`  int DEFAULT NULL,
  `orderId`   int NOT NULL,
  `productId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `orderId`   (`orderId`),
  KEY `productId` (`productId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ─────────────────────────────────────────────────────────────
-- AUTO_INCREMENT
-- ─────────────────────────────────────────────────────────────
ALTER TABLE `Roles`         MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
ALTER TABLE `Users`         MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
ALTER TABLE `Categories`    MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
ALTER TABLE `Products`      MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;
ALTER TABLE `Clients`       MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
ALTER TABLE `Tables`        MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
ALTER TABLE `Orders`        MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
ALTER TABLE `OrderProducts` MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

-- ─────────────────────────────────────────────────────────────
-- CONTRAINTES
-- ─────────────────────────────────────────────────────────────
ALTER TABLE `Users`
  ADD CONSTRAINT `fk_user_role` FOREIGN KEY (`roleId`) REFERENCES `Roles` (`id`);

ALTER TABLE `Products`
  ADD CONSTRAINT `fk_product_category` FOREIGN KEY (`categoryId`) REFERENCES `Categories` (`id`);

ALTER TABLE `Orders`
  ADD CONSTRAINT `fk_order_user`   FOREIGN KEY (`userId`)   REFERENCES `Users`   (`id`),
  ADD CONSTRAINT `fk_order_client` FOREIGN KEY (`clientId`) REFERENCES `Clients` (`id`),
  ADD CONSTRAINT `fk_order_table`  FOREIGN KEY (`tableId`)  REFERENCES `Tables`  (`id`);

ALTER TABLE `OrderProducts`
  ADD CONSTRAINT `fk_op_order`   FOREIGN KEY (`orderId`)   REFERENCES `Orders`   (`id`),
  ADD CONSTRAINT `fk_op_product` FOREIGN KEY (`productId`) REFERENCES `Products` (`id`);

COMMIT;
