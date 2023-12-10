-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 10, 2023 at 05:37 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

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
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_users` ()   SELECT * FROM users order BY user_name asc$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `login` (IN `the_users_email` VARCHAR(100) CHARSET utf8mb4)   SELECT * FROM users WHERE user_email = the_users_email$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `user_info` (IN `the_users_id` BIGINT(20) UNSIGNED)   SELECT * FROM users WHERE user_id = the_users_id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `category_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`) VALUES
(2, 'fruits & vegetables'),
(1, 'toys');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `order_user_fk` bigint(20) UNSIGNED NOT NULL,
  `order_product_fk` bigint(20) UNSIGNED NOT NULL,
  `order_amount_paid` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `order_user_fk`, `order_product_fk`, `order_amount_paid`) VALUES
(1, 10, 1, 1000),
(2, 10, 2, 2000),
(3, 9, 2, 2000),
(4, 8, 1, 1000);

-- --------------------------------------------------------

--
-- Table structure for table `partners`
--

CREATE TABLE `partners` (
  `user_partner_fk` bigint(20) UNSIGNED NOT NULL,
  `partner_geo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `product_price` int(10) UNSIGNED NOT NULL,
  `category_fk` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `product_price`, `category_fk`) VALUES
(1, 'p1', 1000, 1),
(2, 'p2', 2000, 2);

-- --------------------------------------------------------

--
-- Table structure for table `stats`
--

CREATE TABLE `stats` (
  `total_users` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stats`
--

INSERT INTO `stats` (`total_users`) VALUES
(1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `user_name` varchar(20) NOT NULL,
  `user_last_name` varchar(20) NOT NULL,
  `user_username` varchar(25) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_address` varchar(50) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_role` varchar(10) NOT NULL,
  `user_created_at` char(10) NOT NULL,
  `user_updated_at` char(10) NOT NULL,
  `user_deleted_at` char(10) NOT NULL,
  `user_is_blocked` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `user_name`, `user_last_name`, `user_username`, `user_email`, `user_address`, `user_password`, `user_role`, `user_created_at`, `user_updated_at`, `user_deleted_at`, `user_is_blocked`) VALUES
(1, 'Misty', 'Gutkowski', 'madelyn48', 'henri.gaylord@carter.biz', '3066 Nitzsche Fall\nZboncakview, AK 70645', '$2y$10$ZPLlsJtRA3rkDfe3/M7PjeqY7JcisnFbCGcAP/sCYdfMr0ptqhGme', 'user', '1696418976', '0', '0', 1),
(2, 'Palma', 'Stroman', 'fidel91', 'goldner.victor@padberg.com', '385 Morar Parks\nJaydonport, UT 05387', '$2y$10$HDJFyckRjECzPJJrAjMsP..H76B1ED1pIYAFIdGn.2Rcf77fA669a', 'user', '1696418976', '0', '0', 1),
(3, 'Kole', 'Hintz', 'jaylon.halvorson', 'jenkins.garrison@yahoo.com', '24671 Emmerich Square Apt. 004\nYazminmouth, IN 799', '$2y$10$jR7dpZAaG/s68I3fn9NduuZB73e8l9zV28ODgcAFX2BHHN5HUgBxK', 'user', '1696418976', '0', '0', 0),
(4, 'Helga', 'Parker', 'jacques99', 'evert70@wiegand.com', '3695 Block Unions Suite 574\nAmiechester, ME 83600-', '$2y$10$cMhzN2oV4NxEhQUcS.27YuSInsWMFi3UMUb8VUDsDdlTDrBVTXL5C', 'user', '1696418976', '0', '0', 1),
(5, 'Bobby', 'Miller', 'lauretta48', 'sleffler@yahoo.com', '22555 Hintz Flats\nDeangelofort, NC 25660-5990', '$2y$10$rRFwOZDtDHLOnjXb4mf7ieY95WpY5.t3lA./A067XlGD4FBcP8Rui', 'user', '1696418976', '0', '0', 1),
(6, 'Efren', 'Gusikowski', 'greenfelder.macy', 'stiedemann.bud@yahoo.com', '9399 Hane Groves Apt. 440\nSouth Tellyside, MN 2624', '$2y$10$iOYc7AWSNSpU4eYMhNkP8OlCnP0IEASuTNAT8Ofs/FNlEyUuY3Xga', 'user', '1696418976', '0', '0', 0),
(7, 'Marielle', 'Jast', 'allen.fay', 'barton.trystan@gmail.com', '2087 Kautzer Keys Suite 761\nEast Ursulamouth, HI 6', '$2y$10$9vY6Xg3YDJ.L5buwf.1UkeT0qTMKu11eTicASqqcuXzUjkdTMxPM.', 'user', '1696418976', '0', '0', 0),
(8, 'Lenny', 'Hermiston', 'becker.candido', 'friesen.eddie@yahoo.com', '703 Oberbrunner Groves\nSouth Effieville, WV 91790', '$2y$10$G1k.OY6lXicvGtm2Zk650.l0GobLMl.jnwpqOOKpnxTRFiO5dU1Di', 'user', '1696418977', '0', '0', 0),
(9, 'Janet', 'Oberbrunner', 'littel.genevieve', 'aufderhar.marvin@heathcote.com', '156 Dach Rest Apt. 182\nNitzschechester, UT 07532', '$2y$10$2bt3KXYpx0eD6KSnfz2Maep3YdiwhiHvRyzANIyNk302AHudVBSZ6', 'user', '1696418977', '0', '0', 1),
(10, 'Aisha', 'Ledner', 'destiny.beer', 'hhudson@yahoo.com', '40100 Zboncak Manor\nGeneralbury, MT 75900-4017', '$2y$10$S.hHhSSfga/PphZrQB7vP.rTKGquaTiK9boiOmUsdnud0hXbGHFB6', 'user', '1696418977', '0', '0', 1),
(12, 'a', 'a', 'a', 'a@a.com', 'a', 'aaaa', '1', '', '', '', 0);

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `increase_user_count` AFTER INSERT ON `users` FOR EACH ROW UPDATE stats
SET total_users = total_users + 1
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `category_name` (`category_name`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD UNIQUE KEY `order_id` (`order_id`);

--
-- Indexes for table `partners`
--
ALTER TABLE `partners`
  ADD UNIQUE KEY `user_partner_fk` (`user_partner_fk`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD UNIQUE KEY `product_id` (`product_id`),
  ADD KEY `categories_ibfk_1` (`category_fk`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `partners`
--
ALTER TABLE `partners`
  ADD CONSTRAINT `partners_ibfk_1` FOREIGN KEY (`user_partner_fk`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`category_fk`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
