-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 30, 2022 at 12:08 AM
-- Server version: 10.4.20-MariaDB
-- PHP Version: 8.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dev_es_extended`
--

-- --------------------------------------------------------

--
-- Table structure for table `storageunits`
--

CREATE TABLE `storageunits` (
  `identifier` varchar(250) DEFAULT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `storageunits`
--

INSERT INTO `storageunits` (`identifier`, `id`) VALUES
(NULL, 1),
(NULL, 2),
(NULL, 3),
(NULL, 4),
(NULL, 5),
(NULL, 6),
(NULL, 7),
(NULL, 8),
(NULL, 9),
(NULL, 10),
(NULL, 11),
(NULL, 12),
(NULL, 13),
(NULL, 14);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `storageunits`
--
ALTER TABLE `storageunits`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
