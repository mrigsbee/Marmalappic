-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Oct 24, 2016 at 07:34 PM
-- Server version: 10.1.16-MariaDB
-- PHP Version: 5.6.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `marmalappic`
--

-- --------------------------------------------------------

--
-- Table structure for table `datetheme`
--

CREATE TABLE `datetheme` (
  `date` date NOT NULL,
  `theme` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `datetheme`
--

INSERT INTO `datetheme` (`date`, `theme`) VALUES
('2016-10-23', 'Autumn in Blacksburg'),
('2016-10-24', 'Invent the Future');

-- --------------------------------------------------------

--
-- Table structure for table `picture`
--

CREATE TABLE `picture` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `NumVotes` int(11) NOT NULL,
  `NumFlags` int(11) NOT NULL,
  `Date` date NOT NULL,
  `isWinner` tinyint(1) NOT NULL,
  `file` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `picture`
--

INSERT INTO `picture` (`id`, `username`, `NumVotes`, `NumFlags`, `Date`, `isWinner`, `file`) VALUES
(1, 'HokieBird12', 19, 0, '2016-10-23', 0, '/public/media/torg.jpg'),
(2, 'HokieBird12', 203, 0, '2016-10-24', 1, '/public/media/garden.jpg'),
(4, 'HokieBird1', 102, 1, '2016-10-23', 1, '/public/media/garden.jpg'),
(5, 'Freshman10', 23, 0, '2016-10-24', 0, '/public/media/pylons.jpg'),
(6, 'MarmaladeFan101', 34, 2, '2016-10-24', 0, '/public/media/torg.jpg'),
(7, 'VPIVPIVPI', 343, 2, '2016-10-24', 0, '/public/media/garden.jpg'),
(8, 'Alumni1009', 345, 1, '2016-10-24', 0, '/public/media/torg.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `team`
--

CREATE TABLE `team` (
  `teamname` varchar(100) NOT NULL,
  `score` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `team`
--

INSERT INTO `team` (`teamname`, `score`) VALUES
('HokieBird', 390),
('LeeHall2020', 39),
('VPIVPIVPI', 234);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `teamname` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `score` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `teamname`, `email`, `password`, `score`) VALUES
(1, 'VTFreshman2020', 'HokieBird', 'qwerty@vt.edu', '1234', 109),
(2, 'HokieBird12', 'Marmalade', 'hokies@vt.edu', '1234', 230);

-- --------------------------------------------------------

--
-- Table structure for table `uservote`
--

CREATE TABLE `uservote` (
  `username` varchar(100) NOT NULL,
  `picid` int(11) NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `uservote`
--

INSERT INTO `uservote` (`username`, `picid`, `id`) VALUES
('HokieBird12', 4, 1),
('HokieBird12', 5, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `datetheme`
--
ALTER TABLE `datetheme`
  ADD UNIQUE KEY `Date` (`date`),
  ADD UNIQUE KEY `Theme` (`theme`);

--
-- Indexes for table `picture`
--
ALTER TABLE `picture`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `team`
--
ALTER TABLE `team`
  ADD UNIQUE KEY `TeamName` (`teamname`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Username` (`username`),
  ADD UNIQUE KEY `Email` (`email`);

--
-- Indexes for table `uservote`
--
ALTER TABLE `uservote`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `picture`
--
ALTER TABLE `picture`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `uservote`
--
ALTER TABLE `uservote`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
