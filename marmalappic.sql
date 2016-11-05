-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 04, 2016 at 06:50 PM
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
('2016-11-04', 'Autumn in Blacksburg'),
('2016-11-01', 'Bird''s Eye View'),
('2016-11-02', 'No Shave November'),
('2016-11-03', 'Ut Prosim');

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
(5, 'Freshman10', 23, 0, '2016-11-01', 1, '/public/media/user_uploads/pylons.jpg'),
(8, 'Alumni1009', 345, 1, '2016-11-04', 0, '/public/media/user_uploads/torg.jpg'),
(13, 'EngineerVT22', 65, 0, '2016-11-02', 1, '/public/media/user_uploads/torg.jpg'),
(22, 'HokieBird12', 0, 0, '2016-11-03', 1, '/public/media/user_uploads/torg.jpg'),
(23, '78', 0, 0, '2016-11-04', 0, '/public/media/user_uploads/upload2.png');

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
('HokieBird', 340),
('Marmalade', 123),
('Winners', 604);

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
(2, 'HokieBird12', 'Marmalade', 'hokies@vt.edu', '1234', 230),
(3, 'Megan', 'Marmalappic', 'megan@gmail.com', '1234', 0),
(4, 'Megan2', 'M', 'mr@gmail.com', '1234', 0),
(5, '123', '123', '124', '123', 0),
(6, '445', '45', '45', '45', 0),
(7, '1', '1', '1', '1', 0),
(8, '2', '5', '3', '4', 0),
(10, '4', '4', '4', '4', 0),
(11, '9', '9', '9', '9', 0),
(12, '10', '1010', '10', '10101', 0),
(13, '78', '78', '78', '78', 0);

-- --------------------------------------------------------

--
-- Table structure for table `userflag`
--

CREATE TABLE `userflag` (
  `username` varchar(100) NOT NULL,
  `id` int(11) NOT NULL,
  `picid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
('HokieBird12', 8, 1),
('VTFreshman2020', 8, 15),
('HokieBird12', 8, 16);

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
-- Indexes for table `userflag`
--
ALTER TABLE `userflag`
  ADD PRIMARY KEY (`id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `userflag`
--
ALTER TABLE `userflag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `uservote`
--
ALTER TABLE `uservote`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
