-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Vært: 127.0.0.1
-- Genereringstid: 16. 12 2023 kl. 20:23:33
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_own_orders` (IN `the_users_id` BIGINT(20) UNSIGNED)   BEGIN
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

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `orders`
--

CREATE TABLE `orders` (
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `order_user_fk` bigint(20) UNSIGNED NOT NULL,
  `order_product_fk` bigint(20) UNSIGNED NOT NULL,
  `order_amount_paid` int(10) NOT NULL,
  `order_status_fk` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `products`
--

CREATE TABLE `products` (
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `product_price` int(10) NOT NULL,
  `category_fk` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `roles`
--

CREATE TABLE `roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `role_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `status`
--

CREATE TABLE `status` (
  `status_id` bigint(20) UNSIGNED NOT NULL,
  `status_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `user_is_blocked` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  MODIFY `category_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `products`
--
ALTER TABLE `products`
  MODIFY `product_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `status`
--
ALTER TABLE `status`
  MODIFY `status_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `users`
--
ALTER TABLE `users`
  MODIFY `user_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

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
