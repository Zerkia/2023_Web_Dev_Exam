-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Vært: 127.0.0.1
-- Genereringstid: 16. 12 2023 kl. 17:45:15
-- Serverversion: 10.4.32-MariaDB
-- PHP-version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `company`
--
DROP DATABASE IF EXISTS `company`;

CREATE DATABASE IF NOT EXISTS `company` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `company`;

DELIMITER $$
--
-- Procedurer
--
DROP PROCEDURE IF EXISTS `get_all_orders`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_orders` ()   BEGIN
    SELECT 
	o.order_id,
        u.user_name AS order_user_name,
        p.product_name AS order_product_name,
        o.order_amount_paid,
        s.status_name as order_status
    FROM 
        orders o
    JOIN 
        users u ON o.order_user_fk = u.user_id
    JOIN 
        products p ON o.order_product_fk = p.product_id
    JOIN
        status s ON o.order_status_fk = s.status_id
    ORDER BY 
        o.order_id ASC;
END$$

DROP PROCEDURE IF EXISTS `get_all_own_orders`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_own_orders` (IN `the_users_id` BIGINT(20) UNSIGNED)   BEGIN
    SELECT 
        o.order_id,
        u.user_id,
        u.user_name AS order_user_name,
        p.product_name AS order_product_name,
        o.order_amount_paid
    FROM 
        orders o
    JOIN 
        users u ON o.order_user_fk = u.user_id
    JOIN 
        products p ON o.order_product_fk = p.product_id
    WHERE u.user_id = the_users_id
    ORDER BY 
        o.order_id ASC;
END$$

DROP PROCEDURE IF EXISTS `get_all_products`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_products` ()   BEGIN
    SELECT 
        p.product_id,
        p.product_name,
        p.product_price,
        c.category_name as product_category
    FROM 
        products p
    JOIN 
        categories c ON p.category_fk = c.category_id
    ORDER BY 
        p.product_id ASC;
END$$

DROP PROCEDURE IF EXISTS `get_all_users`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_users` ()   SELECT * FROM users order BY user_id asc$$

DROP PROCEDURE IF EXISTS `login`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `login` (IN `the_users_email` VARCHAR(100) CHARSET utf8mb4)   SELECT * FROM users WHERE user_email = the_users_email$$

DROP PROCEDURE IF EXISTS `search_by_product_or_category`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_by_product_or_category` (IN `search_term` VARCHAR(255))   BEGIN
    SELECT 
        p.product_id,
        p.product_name,
        p.product_price,
        c.category_name as product_category
    FROM 
        products p
    JOIN 
        categories c ON p.category_fk = c.category_id
    WHERE 
        p.product_name COLLATE utf8mb4_general_ci LIKE CONCAT('%', search_term, '%')
        OR c.category_name COLLATE utf8mb4_general_ci LIKE CONCAT('%', search_term, '%');
END$$

DROP PROCEDURE IF EXISTS `search_orders_by_name_product_or_status`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_orders_by_name_product_or_status` (IN `search_term` VARCHAR(255))   BEGIN
    SELECT 
        o.order_id,
        u.user_name as order_user_name,
        p.product_name as order_product_name,
        o.order_amount_paid,
        s.status_name as order_status
    FROM 
        orders o
    JOIN 
        users u ON o.order_user_fk = u.user_id
    JOIN 
        products p ON o.order_product_fk = p.product_id
    JOIN 
        status s ON o.order_status_fk = s.status_id
    WHERE 
        u.user_name COLLATE utf8mb4_general_ci LIKE CONCAT('%', search_term, '%')
        OR p.product_name COLLATE utf8mb4_general_ci LIKE CONCAT('%', search_term, '%')
        OR s.status_name COLLATE utf8mb4_general_ci LIKE CONCAT('%', search_term, '%');
END$$

DROP PROCEDURE IF EXISTS `search_own_orders_by_name_or_product`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_own_orders_by_name_or_product` (IN `search_term` VARCHAR(255), IN `the_users_id` BIGINT(20) UNSIGNED)   BEGIN
    SELECT 
        o.order_id,
        u.user_id,
        u.user_name as order_user_name,
        p.product_name as order_product_name,
        o.order_amount_paid
    FROM 
        orders o
    JOIN 
        users u ON o.order_user_fk = u.user_id
    JOIN 
        products p ON o.order_product_fk = p.product_id
    WHERE 
        u.user_name COLLATE utf8mb4_general_ci LIKE CONCAT('%', search_term, '%') && u.user_id = the_users_id
        OR p.product_name COLLATE utf8mb4_general_ci LIKE CONCAT('%', search_term, '%') && u.user_id = the_users_id;
END$$

DROP PROCEDURE IF EXISTS `search_users_by_name_or_blocked`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_users_by_name_or_blocked` (IN `query_text` VARCHAR(255))   BEGIN
    SELECT *,
           CASE 
               WHEN user_is_blocked = 1 THEN 'Blocked'
               WHEN user_is_blocked = 0 THEN 'Unblocked'
               ELSE 'Unknown' -- Handle any other cases if necessary
           END AS block_status
    FROM users 
    WHERE user_name COLLATE utf8mb4_general_ci LIKE CONCAT('%', query_text, '%') 
       OR user_last_name COLLATE utf8mb4_general_ci LIKE CONCAT('%', query_text, '%') 
       OR user_username COLLATE utf8mb4_general_ci LIKE CONCAT('%', query_text, '%')
       OR (user_is_blocked = 1 AND 'Blocked' COLLATE utf8mb4_general_ci LIKE CONCAT('%', query_text, '%'))
       OR (user_is_blocked = 0 AND 'Unblocked' COLLATE utf8mb4_general_ci LIKE CONCAT('%', query_text, '%'));
END$$

DROP PROCEDURE IF EXISTS `user_info`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_info` (IN `the_users_id` BIGINT(20) UNSIGNED)   SELECT users.*, roles.role_name as user_role
FROM users
JOIN roles ON users.user_role_fk = roles.role_id
WHERE users.user_id = the_users_id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `category_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Data dump for tabellen `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`) VALUES
(1, 'Toys'),
(2, 'Fruits & Vegetables'),
(3, 'Frozen'),
(4, 'Drinks');

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `order_user_fk` bigint(20) UNSIGNED NOT NULL,
  `order_product_fk` bigint(20) UNSIGNED NOT NULL,
  `order_amount_paid` int(10) NOT NULL,
  `order_status_fk` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Data dump for tabellen `orders`
--

INSERT INTO `orders` (`order_id`, `order_user_fk`, `order_product_fk`, `order_amount_paid`, `order_status_fk`) VALUES
(1, 7, 1, 195, 2),
(2, 7, 1, 838, 2),
(3, 5, 1, 895, 4),
(4, 6, 4, 951, 3),
(5, 9, 4, 302, 3),
(6, 1, 3, 477, 3),
(7, 7, 4, 923, 2),
(8, 4, 3, 173, 3),
(9, 5, 3, 654, 4),
(10, 3, 3, 829, 1);

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `product_price` int(10) NOT NULL,
  `category_fk` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Data dump for tabellen `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `product_price`, `category_fk`) VALUES
(1, 'Thomas the Tank Engine', 250, 1),
(2, 'Banana', 4, 2),
(3, 'Frozen Chicken', 30, 3),
(4, 'Monster Energy', 12, 4);

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `role_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Data dump for tabellen `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`) VALUES
(1, 'Customer'),
(2, 'Partner'),
(3, 'Admin');

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `status`
--

DROP TABLE IF EXISTS `status`;
CREATE TABLE `status` (
  `status_id` bigint(20) UNSIGNED NOT NULL,
  `status_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Data dump for tabellen `status`
--

INSERT INTO `status` (`status_id`, `status_name`) VALUES
(1, 'In Transit'),
(2, 'Shipped'),
(3, 'Delivered'),
(4, 'Cancelled');

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `user_name` varchar(20) NOT NULL,
  `user_last_name` varchar(20) NOT NULL,
  `user_username` varchar(25) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_address` varchar(50) NOT NULL,
  `user_zip_code` int(10) NOT NULL,
  `user_city` varchar(50) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_role_fk` bigint(20) UNSIGNED NOT NULL,
  `user_created_at` char(10) NOT NULL,
  `user_updated_at` char(10) NOT NULL,
  `user_is_blocked` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Data dump for tabellen `users`
--

INSERT INTO `users` (`user_id`, `user_name`, `user_last_name`, `user_username`, `user_email`, `user_address`, `user_zip_code`, `user_city`, `user_password`, `user_role_fk`, `user_created_at`, `user_updated_at`, `user_is_blocked`) VALUES
(1, 'Shanon', 'Orn', 'kjerde', 'kyle.grady@hermann.net', '87947 Hermann Well Apt. 505', 16681, 'South Saigeburgh', '$2y$10$ljmlyomMm7oTvTQ6YaFEb.bVsVptGMnBV7iVoPq.EZuanyctJ7AXm', 1, '1702740789', '0', 1),
(2, 'Ofelia', 'Hartmann', 'payton60', 'lamont00@gmail.com', '307 Trycia Union Suite 259', 51183, 'Moenmouth', '$2y$10$ljmlyomMm7oTvTQ6YaFEb.bVsVptGMnBV7iVoPq.EZuanyctJ7AXm', 2, '1702740789', '0', 1),
(3, 'Grayson', 'Nikolaus', 'block.natalie', 'helene38@berge.com', '413 Streich Plain Apt. 405', 65785, 'Gladyceshire', '$2y$10$ljmlyomMm7oTvTQ6YaFEb.bVsVptGMnBV7iVoPq.EZuanyctJ7AXm', 2, '1702740789', '0', 0),
(4, 'Orlo', 'Davis', 'bwisozk', 'isabell.mccullough@yahoo.com', '259 Mraz Extension', 76434, 'West Christopher', '$2y$10$ljmlyomMm7oTvTQ6YaFEb.bVsVptGMnBV7iVoPq.EZuanyctJ7AXm', 2, '1702740789', '0', 1),
(5, 'Gaston', 'Marvin', 'marina.howell', 'treva.dickinson@cole.com', '487 Rolfson Plaza', 69541, 'Rodgerland', '$2y$10$ljmlyomMm7oTvTQ6YaFEb.bVsVptGMnBV7iVoPq.EZuanyctJ7AXm', 1, '1702740789', '0', 1),
(6, 'Keshaun', 'Koepp', 'smetz', 'oliver.lebsack@yahoo.com', '99047 Jensen Greens Suite 224', 90802, 'Gordonshire', '$2y$10$ljmlyomMm7oTvTQ6YaFEb.bVsVptGMnBV7iVoPq.EZuanyctJ7AXm', 2, '1702740789', '0', 0),
(7, 'Marilie', 'Fahey', 'gerald.brekke', 'scotty27@gmail.com', '926 Deron Stravenue', 12564, 'Mafaldashire', '$2y$10$ljmlyomMm7oTvTQ6YaFEb.bVsVptGMnBV7iVoPq.EZuanyctJ7AXm', 1, '1702740789', '0', 1),
(8, 'Abigayle', 'Dach', 'tlegros', 'moen.marvin@monahan.net', '971 Sister Parks', 63407, 'North Moseport', '$2y$10$ljmlyomMm7oTvTQ6YaFEb.bVsVptGMnBV7iVoPq.EZuanyctJ7AXm', 2, '1702740789', '0', 1),
(9, 'Torrey', 'Weimann', 'leo.koepp', 'glen22@yahoo.com', '3651 Jackson Flat', 637, 'Port Shannyburgh', '$2y$10$ljmlyomMm7oTvTQ6YaFEb.bVsVptGMnBV7iVoPq.EZuanyctJ7AXm', 2, '1702740789', '0', 0),
(10, 'Palma', 'Metz', 'deron.turner', 'psawayn@yahoo.com', '54346 Thad Rest', 50152, 'Edgardostad', '$2y$10$ljmlyomMm7oTvTQ6YaFEb.bVsVptGMnBV7iVoPq.EZuanyctJ7AXm', 1, '1702740789', '0', 1),
(11, 'Admin', 'Admin', 'Admin', 'admin@admin.com', 'Admin Street 12', 1234, 'Admin City', '$2y$10$ljmlyomMm7oTvTQ6YaFEb.bVsVptGMnBV7iVoPq.EZuanyctJ7AXm', 3, '1702740789', '0', 0),
(12, 'Partner', 'Partner', 'Partner', 'partner@partner.com', 'Partner Street 12', 1234, 'Partner City', '$2y$10$ljmlyomMm7oTvTQ6YaFEb.bVsVptGMnBV7iVoPq.EZuanyctJ7AXm', 2, '1702740789', '0', 0),
(13, 'Customer', 'Customer', 'Customer', 'customer@customer.com', 'Customer Street 12', 1234, 'Customer City', '$2y$10$ljmlyomMm7oTvTQ6YaFEb.bVsVptGMnBV7iVoPq.EZuanyctJ7AXm', 1, '1702740789', '0', 0);

--
-- Begrænsninger for dumpede tabeller
--

--
-- Indeks for tabel `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indeks for tabel `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`) USING BTREE,
  ADD KEY `order_user_fk` (`order_user_fk`,`order_product_fk`,`order_status_fk`),
  ADD KEY `fk_order_product` (`order_product_fk`),
  ADD KEY `fk_order_status` (`order_status_fk`);

--
-- Indeks for tabel `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`) USING BTREE,
  ADD KEY `categories_ibfk_1` (`category_fk`);

--
-- Indeks for tabel `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`);

--
-- Indeks for tabel `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`status_id`);

--
-- Indeks for tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`) USING BTREE,
  ADD KEY `users_roles_fk` (`user_role_fk`);

--
-- Brug ikke AUTO_INCREMENT for slettede tabeller
--

--
-- Tilføj AUTO_INCREMENT i tabel `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Tilføj AUTO_INCREMENT i tabel `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Tilføj AUTO_INCREMENT i tabel `products`
--
ALTER TABLE `products`
  MODIFY `product_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Tilføj AUTO_INCREMENT i tabel `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tilføj AUTO_INCREMENT i tabel `status`
--
ALTER TABLE `status`
  MODIFY `status_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Tilføj AUTO_INCREMENT i tabel `users`
--
ALTER TABLE `users`
  MODIFY `user_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Begrænsninger for dumpede tabeller
--

--
-- Begrænsninger for tabel `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_order_product` FOREIGN KEY (`order_product_fk`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_order_status` FOREIGN KEY (`order_status_fk`) REFERENCES `status` (`status_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_order_user` FOREIGN KEY (`order_user_fk`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Begrænsninger for tabel `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_categories_fk` FOREIGN KEY (`category_fk`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Begrænsninger for tabel `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_roles_fk` FOREIGN KEY (`user_role_fk`) REFERENCES `roles` (`role_id`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
