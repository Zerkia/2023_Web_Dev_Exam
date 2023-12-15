-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Vært: 127.0.0.1
-- Genereringstid: 15. 12 2023 kl. 19:57:53
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

DELIMITER $$
--
-- Procedurer
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_orders` ()   BEGIN
    SELECT 
        o.order_id,
        u.user_name AS order_user_name,
        p.product_name AS order_product_name,
        o.order_amount_paid
    FROM 
        orders o
    JOIN 
        users u ON o.order_user_fk = u.user_id
    JOIN 
        products p ON o.order_product_fk = p.product_id
    ORDER BY 
        o.order_id ASC;
END$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_users` ()   SELECT * FROM users order BY user_id asc$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `login` (IN `the_users_email` VARCHAR(100) CHARSET utf8mb4)   SELECT * FROM users WHERE user_email = the_users_email$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `search_orders_by_name_or_product` (IN `search_term` VARCHAR(255))   BEGIN
    SELECT 
        o.order_id,
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
        u.user_name COLLATE utf8mb4_general_ci LIKE CONCAT('%', search_term, '%')
        OR p.product_name COLLATE utf8mb4_general_ci LIKE CONCAT('%', search_term, '%');
END$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `search_users_by_name` (IN `query_text` VARCHAR(255))   BEGIN
    SELECT * 
    FROM users 
    WHERE user_name COLLATE utf8mb4_general_ci LIKE CONCAT('%', query_text, '%') 
       OR user_last_name COLLATE utf8mb4_general_ci LIKE CONCAT('%', query_text, '%') 
       OR user_username COLLATE utf8mb4_general_ci LIKE CONCAT('%', query_text, '%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `user_info` (IN `the_users_id` BIGINT(20) UNSIGNED)   SELECT users.*, roles.role_name as user_role
FROM users
JOIN roles ON users.user_role_fk = roles.role_id
WHERE users.user_id = the_users_id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `categories`
--

CREATE TABLE `categories` (
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `category_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Data dump for tabellen `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`) VALUES
(2, 'Fruits & Vegetables'),
(1, 'Toys');

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `orders`
--

CREATE TABLE `orders` (
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `order_user_fk` bigint(20) UNSIGNED NOT NULL,
  `order_product_fk` bigint(20) UNSIGNED NOT NULL,
  `order_amount_paid` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Data dump for tabellen `orders`
--

INSERT INTO `orders` (`order_id`, `order_user_fk`, `order_product_fk`, `order_amount_paid`) VALUES
(1, 10, 1, 1000),
(2, 10, 2, 2000),
(6, 33, 2, 123);

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `partners`
--

CREATE TABLE `partners` (
  `user_partner_fk` bigint(20) UNSIGNED NOT NULL,
  `partner_geo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `products`
--

CREATE TABLE `products` (
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `product_price` int(10) UNSIGNED NOT NULL,
  `category_fk` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Data dump for tabellen `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `product_price`, `category_fk`) VALUES
(1, 'Banana', 4, 2),
(2, 'Thomas the Tank Engine', 250, 1);

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `roles`
--

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
-- Struktur-dump for tabellen `stats`
--

CREATE TABLE `stats` (
  `total_users` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Data dump for tabellen `stats`
--

INSERT INTO `stats` (`total_users`) VALUES
(22);

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `users`
--

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
  `user_deleted_at` char(10) NOT NULL,
  `user_is_blocked` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Data dump for tabellen `users`
--

INSERT INTO `users` (`user_id`, `user_name`, `user_last_name`, `user_username`, `user_email`, `user_address`, `user_zip_code`, `user_city`, `user_password`, `user_role_fk`, `user_created_at`, `user_updated_at`, `user_deleted_at`, `user_is_blocked`) VALUES
(1, 'Misty', 'Gutkowski', 'madelyn48', 'henri.gaylord@carter.biz', '3066 Nitzsche Fall\nZboncakview, AK 70645', 0, '', '$2y$10$ZPLlsJtRA3rkDfe3/M7PjeqY7JcisnFbCGcAP/sCYdf', 1, '1696418976', '0', '0', 0),
(3, 'Kole', 'Hintz', 'jaylon.halvorson', 'jenkins.garrison@yahoo.com', '24671 Emmerich Square Apt. 004\nYazminmouth, IN 799', 0, '', '$2y$10$jR7dpZAaG/s68I3fn9NduuZB73e8l9zV28ODgcAFX2B', 1, '1696418976', '0', '0', 0),
(4, 'Helga', 'Parker', 'jacques99', 'evert70@wiegand.com', '3695 Block Unions Suite 574\nAmiechester, ME 83600-', 0, '', '$2y$10$cMhzN2oV4NxEhQUcS.27YuSInsWMFi3UMUb8VUDsDdl', 1, '1696418976', '0', '0', 1),
(6, 'Efren', 'Gusikowski', 'greenfelder.macy', 'stiedemann.bud@yahoo.com', '9399 Hane Groves Apt. 440\nSouth Tellyside, MN 2624', 0, '', '$2y$10$iOYc7AWSNSpU4eYMhNkP8OlCnP0IEASuTNAT8Ofs/FN', 1, '1696418976', '0', '0', 1),
(7, 'Marielle', 'Jast', 'allen.fay', 'barton.trystan@gmail.com', '2087 Kautzer Keys Suite 761\nEast Ursulamouth, HI 6', 0, '', '$2y$10$9vY6Xg3YDJ.L5buwf.1UkeT0qTMKu11eTicASqqcuXz', 1, '1696418976', '0', '0', 0),
(8, 'Lenny', 'Hermiston', 'becker.candido', 'friesen.eddie@yahoo.com', '703 Oberbrunner Groves\nSouth Effieville, WV 91790', 0, '', '$2y$10$G1k.OY6lXicvGtm2Zk650.l0GobLMl.jnwpqOOKpnxT', 1, '1696418977', '0', '0', 0),
(9, 'Janet', 'Oberbrunner', 'littel.genevieve', 'aufderhar.marvin@heathcote.com', '156 Dach Rest Apt. 182\nNitzschechester, UT 07532', 0, '', '$2y$10$2bt3KXYpx0eD6KSnfz2Maep3YdiwhiHvRyzANIyNk30', 1, '1696418977', '0', '0', 1),
(10, 'Aisha', 'Ledner', 'destiny.beer', 'hhudson@yahoo.com', '40100 Zboncak Manor\nGeneralbury, MT 75900-4017', 0, '', '$2y$10$S.hHhSSfga/PphZrQB7vP.rTKGquaTiK9boiOmUsdnu', 1, '1696418977', '0', '0', 1),
(32, 'admin', 'admin', 'admin', 'admin@admin.com', 'admin', 2300, 'admin', '$2y$10$lG.tnlm.npNk0W9AQ03fe.tmaBFvLBxipvuND6U9POWNEcNKEOwVm', 3, '1702659253', '0', '0', 0),
(33, 'updateddddd', 'updated', 'updateuser', 'updateuser@user.com', 'updated', 9999, 'updateddddd', '$2y$10$D3Nr9VRDxybICOaLYXrOKeuxBS3X21ni5fffvE4GcDoqSrQtyenPe', 1, '1702659286', '1702663755', '0', 0),
(34, 'Nikolaj', 'Pregaard', 'Zerkia', 'nikolajpregaard@gmail.com', 'Gyldenrisvej 52 2th', 2300, 'Copenhagen S', '$2a$12$eEfn/1lcSQLDH3SFoqjp3uFHGVkKp4FmCJ5s3x8aVibP6bRXReFA2', 1, '0', '1702666388', '0', 0);

--
-- Triggers/udløsere `users`
--
DELIMITER $$
CREATE TRIGGER `increase_user_count` AFTER INSERT ON `users` FOR EACH ROW UPDATE stats
SET total_users = total_users + 1
$$
DELIMITER ;

--
-- Begrænsninger for dumpede tabeller
--

--
-- Indeks for tabel `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `category_name` (`category_name`);

--
-- Indeks for tabel `orders`
--
ALTER TABLE `orders`
  ADD UNIQUE KEY `order_id` (`order_id`),
  ADD KEY `orders_users_fk` (`order_user_fk`),
  ADD KEY `orders_products_fk` (`order_product_fk`);

--
-- Indeks for tabel `partners`
--
ALTER TABLE `partners`
  ADD UNIQUE KEY `user_partner_fk` (`user_partner_fk`);

--
-- Indeks for tabel `products`
--
ALTER TABLE `products`
  ADD UNIQUE KEY `product_id` (`product_id`),
  ADD KEY `categories_ibfk_1` (`category_fk`);

--
-- Indeks for tabel `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`);

--
-- Indeks for tabel `users`
--
ALTER TABLE `users`
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `users_roles_fk` (`user_role_fk`);

--
-- Brug ikke AUTO_INCREMENT for slettede tabeller
--

--
-- Tilføj AUTO_INCREMENT i tabel `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Tilføj AUTO_INCREMENT i tabel `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Tilføj AUTO_INCREMENT i tabel `products`
--
ALTER TABLE `products`
  MODIFY `product_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Tilføj AUTO_INCREMENT i tabel `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tilføj AUTO_INCREMENT i tabel `users`
--
ALTER TABLE `users`
  MODIFY `user_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- Begrænsninger for dumpede tabeller
--

--
-- Begrænsninger for tabel `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_products_fk` FOREIGN KEY (`order_product_fk`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `orders_users_fk` FOREIGN KEY (`order_user_fk`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Begrænsninger for tabel `partners`
--
ALTER TABLE `partners`
  ADD CONSTRAINT `partners_ibfk_1` FOREIGN KEY (`user_partner_fk`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Begrænsninger for tabel `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`category_fk`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Begrænsninger for tabel `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_roles_fk` FOREIGN KEY (`user_role_fk`) REFERENCES `roles` (`role_id`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
