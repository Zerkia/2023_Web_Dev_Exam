-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 27, 2023 at 08:39 AM
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

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `user_name` varchar(20) NOT NULL,
  `user_last_name` varchar(20) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_role` varchar(10) NOT NULL,
  `user_created_at` char(10) NOT NULL,
  `user_updated_at` char(10) NOT NULL,
  `user_deleted_at` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `user_name`, `user_last_name`, `user_email`, `user_password`, `user_role`, `user_created_at`, `user_updated_at`, `user_deleted_at`) VALUES
(1, 'Reina', 'Stark', 'elyssa71@berge.com', '$2y$10$eqyMUeW9KEOaRQX914fXrOQ..GxsjHoaF3Yyzt24lDT7oHE421rca', 'user', '1695479823', '0', '0'),
(2, 'Lacy', 'Ortiz', 'ignacio.howell@yahoo.com', '$2y$10$Cj/gXehovTZ8CH1ogwPS6uujOMgA.LZSu3MweexzZ7/.0m16q4r0m', 'user', '1695479823', '0', '0'),
(3, 'Tierra', 'Howell', 'towne.parker@gmail.com', '$2y$10$oXfNntLykKWjM2IPMYQhauxRg1QUUrx/Ya/W.iHWOFmaJSWFc4VUC', 'user', '1695479823', '0', '0'),
(4, 'Jordy', 'Murray', 'boyer.emilia@hotmail.com', '$2y$10$neUkP61RwsHUaE2CXJ6YquKbAltUGHQ1yZhj5evtVQqdL7oqvfUYC', 'user', '1695479823', '0', '0'),
(5, 'Westley', 'Runolfsdottir', 'welch.lola@yahoo.com', '$2y$10$HVn03gkn3Oh6XGpfi2xwpuqSWu4pjAVvl7efaCXyUdrMQ0QJgTQGe', 'user', '1695479824', '0', '0'),
(6, 'Schuyler', 'Grady', 'hweissnat@yahoo.com', '$2y$10$cuFS57jyeG9/hJPaM9RC3eGPkMsw1JeLssW5Gjk6iI3nZKZ3fnxNC', 'user', '1695479824', '0', '0'),
(7, 'Amos', 'McLaughlin', 'dibbert.sadye@yahoo.com', '$2y$10$IVqX6D5HE.lI21bxt3uPGO1dVagAuJmULK4aObjGQZTmYcuUikWsq', 'user', '1695479824', '0', '0'),
(8, 'Alfred', 'Carter', 'trenton.schimmel@franecki.biz', '$2y$10$f9YtCGgTJ8n42CLpdOYg.eQRcfE4T0V2xWSwRa0dHFKlEURxmMYza', 'user', '1695479824', '0', '0'),
(9, 'Tyree', 'Gerlach', 'chloe10@gusikowski.com', '$2y$10$XEqO3CWwYWmqIQHITRTyOu5N4Akh8FnmhBocJWEOETcXOaWMvv2vC', 'user', '1695479824', '0', '0'),
(10, 'Russel', 'Haag', 'alexandria85@skiles.net', '$2y$10$i5EyzcYUoMvaEXMQPYxpye8CIvkEHK/prK6viXl6cMlg7duNkEr5y', 'user', '1695479824', '0', '0'),
(11, 'Sandrine', 'Schimmel', 'agustina.west@gmail.com', '$2y$10$0hFWUCFGqzho3zdmtx1S4ug9.oIoP7gaANSXk7N0Lv9fNEb51eq/m', 'user', '1695479893', '0', '0'),
(12, 'Phoebe', 'Moore', 'malachi.runolfsson@hotmail.com', '$2y$10$W8CBYFPfuyK5XLMtVXlY/eu2XmejVLkxP7YZWoiGwL30pUhN6oXA2', 'user', '1695479893', '0', '0'),
(13, 'Devante', 'Donnelly', 'jayden95@king.net', '$2y$10$S5/9.AS.b.uSNC5BJZMQe.nlbZXuQBOmew7L7pEcAg/0Ljy4gg9qS', 'user', '1695479893', '0', '0'),
(14, 'Rafael', 'Kreiger', 'xjakubowski@rosenbaum.com', '$2y$10$cwNf8D.XrKdsCpp6WCT/0eNLnimGNsysXGqcVXPD32SimtqWKthDq', 'user', '1695479894', '0', '0'),
(15, 'Amely', 'Ruecker', 'feeney.rickey@hotmail.com', '$2y$10$b0xKGWEAxt/RKgCiNb0wVeNjt3h5OPn0PMSqef6PH8Bnr7YqGuhP6', 'user', '1695479894', '0', '0'),
(16, 'Toni', 'Hodkiewicz', 'simonis.lafayette@gmail.com', '$2y$10$obWs5xbvl/tHa8R1cDYOCO0IjZjUucibWnRVnustgcYL0KTNJMzjG', 'user', '1695479894', '0', '0'),
(17, 'Otho', 'Schroeder', 'rturner@hotmail.com', '$2y$10$gZW0JDgD6FdNLM2V4NgZTeR1.D.7PIxkz8BbFm3ZxK7g.4xc.UMkW', 'user', '1695479894', '0', '0'),
(18, 'Brigitte', 'Bergnaum', 'waelchi.reina@gmail.com', '$2y$10$9OzpoL5ey4UFxvjYf5SdPeAobnf73s3qy9a.JvXip7o2v75i4eB5G', 'user', '1695479894', '0', '0'),
(19, 'Nick', 'Koelpin', 'glittle@collins.com', '$2y$10$HLbh7LrOz5KkdK8GW5xBsuSKTHXWseolcvdrU9QkykW07ihAjbV4W', 'user', '1695479894', '0', '0'),
(20, 'Leta', 'McGlynn', 'zulauf.retta@schneider.com', '$2y$10$eb4LMpN0QDrJYZ2gMUIsA.X/nrlZfJIIK6yehtMJmXWmY/8OzNbIi', 'user', '1695479894', '0', '0'),
(21, 'Damien', 'Funk', 'wyman.jace@yahoo.com', '$2y$10$68CXIp5sKp68JmJiEKtiseTJvTS377vpHDpnD6nYscsJPIGWo5gxa', 'user', '1695479919', '0', '0'),
(22, 'Logan', 'Christiansen', 'shanahan.raven@gmail.com', '$2y$10$mdQ4HrJh99BjjKvGflN81ucwCZ1yFIum76hHP0did7lZewGD75oZK', 'user', '1695479919', '0', '0'),
(23, 'Elbert', 'Moore', 'wilfred.kub@yahoo.com', '$2y$10$pyuDiK6psc2ddRzTDt6S5OSyNVYDXrXwGGU7oVZMSZaK0iq0x.tEy', 'user', '1695479920', '0', '0'),
(24, 'Xander', 'Steuber', 'korn@gmail.com', '$2y$10$E3pka/BDWpbTaYgMTDD/n.a1scgqYlfWlQn69NIn3YpcfOnqbD7He', 'user', '1695479920', '0', '0'),
(25, 'Sienna', 'Hahn', 'verna84@gmail.com', '$2y$10$yMpYtZyqReq2stSnMi.SUe4LxfTQupZlFrib.RQyJUJtmy35VuDlK', 'user', '1695479920', '0', '0'),
(26, 'Demond', 'Cremin', 'rozella.bartoletti@gmail.com', '$2y$10$6FOyJBx1nzLFH2NtOYNLIOtNXG3oZQCic5TKNXxu14l/TK7qnf3jS', 'user', '1695479920', '0', '0'),
(27, 'Lukas', 'Bednar', 'halvorson.dashawn@jenkins.info', '$2y$10$sQa2KYIc42xpL9K3/CX4iOKaM30/6dmKodPy2hcj7ujkLm4ZJrggi', 'user', '1695479920', '0', '0'),
(28, 'Edwardo', 'Corkery', 'gtillman@gmail.com', '$2y$10$NxJIeze/svrZu97MM4z6p.fY020FTbeBo2E4.SPkSIB4wwH8EtXS.', 'user', '1695479920', '0', '0'),
(29, 'Elfrieda', 'Considine', 'philip86@gmail.com', '$2y$10$jjLoXuUFthkc0.qQKoJ1Feoz.gfmTfVtSZ9p8Cmw40cVoXKwPAfVC', 'user', '1695479920', '0', '0'),
(30, 'Scarlett', 'Friesen', 'morar.florida@gmail.com', '$2y$10$xxLfGjAhAeyrn0wNu7J7aejSDTH4Vd.wBT3lNtodEhfcxFeNX4FAa', 'user', '1695479920', '0', '0');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
