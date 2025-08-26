-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 29, 2024 at 01:54 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `secure_user_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `encrypted_content` text NOT NULL,
  `iv` varchar(32) NOT NULL,
  `mac` varchar(64) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `user_id`, `encrypted_content`, `iv`, `mac`, `created_at`) VALUES
(7, 1, 'qG3ye8BFBrRKuSwG0shEQQ==', 'b0e2f2cf36ed1412f74b99fffc234200', 'e5a8250d095ee254a6cee905652ba29aac3b74608bbb0477828a30e02797c38e', '2024-12-28 19:38:38'),
(8, 2, 'KbMEJWbege7VDhzwZGaJYA==', 'd6dd1cb2e910a91e505371dcf4a02c54', '76a4d2b10e9361041f2f8e338e688ce2d135c277e2264b2ced5897221eea4549', '2024-12-28 19:39:09');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `salt` varchar(32) NOT NULL,
  `encryption_key` varchar(255) NOT NULL,
  `iv` varchar(32) NOT NULL,
  `email` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password_hash`, `salt`, `encryption_key`, `iv`, `email`, `created_at`) VALUES
(1, 'Imranul Hasan', '$2y$10$MiQcnr3p6oh50l9xh/0Hj.fI98FG89kJGyPRkLC7dYI4Bd1oe.426', '565d28959d3d0688a0fb74f2f49c7306', 'e6d547ddee9ea8c2d3911962a09e25bf9783c483ec880fc476ae0b9f8fbdc4c0', '5522ff79a9e40aeca6e5acd767ca5d79', 'dF6PdI2wRF3PoKUfi6You2Bq7hYoBpFrhpondXIsIsY=', '2025-01-02 16:22:26'),
(2, 'Emon', '$2y$10$ujKoJeF1yh7Krx7FbNsCTe5spU5CH2kmieNZIQCwWEsFohP3OeLES', 'bd376b61c41cedd36a430af19a8798f7', '0660b71a6eba31f3c6582d1e19b2f0f2902767dda7ae56a60f85ab5573be44f8', 'e7f1f01fce1731d5de75f715252e8e60', 'KhoexdegYCWWME0UlHKk+uqLdmmdkcrHf3BcuoDZaj0=', '2024-01-03 15:55:39');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
