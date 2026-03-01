-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 01, 2026 at 08:46 AM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 8.0.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ocean_view_resort`
--

-- --------------------------------------------------------

--
-- Table structure for table `bills`
--

CREATE TABLE `bills` (
  `bill_id` int(11) NOT NULL,
  `reservation_number` int(11) NOT NULL,
  `number_of_nights` int(11) NOT NULL,
  `total_amount` double NOT NULL,
  `generated_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `guests`
--

CREATE TABLE `guests` (
  `guest_id` int(11) NOT NULL,
  `guest_name` varchar(255) DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `contact_number` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `guests`
--

INSERT INTO `guests` (`guest_id`, `guest_name`, `address`, `contact_number`) VALUES
(1, 'alfed', '31', '0712526716'),
(2, 'ALfed', '39129031', '3902183091283'),
(3, 'alfred', '24', '0712526515'),
(4, 'alfed', 'upstair road', '09230981309182'),
(5, 'alfred', 'upstair road', '071252615'),
(6, 'anonymous', 'upstair', '9230913091283'),
(7, 'wilfred', 'mmmmm', '078898991'),
(8, 'willll', 'ffefewefw', '008908120938'),
(9, 'willll', 'ffefewefw', '008908120938'),
(10, 'willll', 'ffefewefw', '008908120938'),
(11, 'willll', 'ffefewefw', '008908120938'),
(12, 'willll', 'ffefewefw', '008908120938'),
(13, 'willll', 'ffefewefw', '008908120938'),
(14, 'willll', 'ffefewefw', '008908120938'),
(15, 'willll', 'ffefewefw', '008908120938'),
(16, 'willll', 'ffefewefw', '008908120938'),
(17, 'willll', 'ffefewefw', '008908120938'),
(18, 'willll', 'ffefewefw', '008908120938'),
(19, 'willll', 'ffefewefw', '008908120938'),
(20, 'willll', 'ffefewefw', '008908120938'),
(21, 'wilfed', 'qndoiqjwdoiqj', '0999998991'),
(22, 'wilfeed', 'iaodjoisajdasds', '380912830192'),
(23, 'Wilfed', 'adwdcqwdcqwd', '12937092830913'),
(24, 'WIlfred', 'batticaloa', '0712526515'),
(25, 'Wilfred', 'Meea', '0879098871'),
(26, 'wilfred', 'andom', '0712526515'),
(27, 'wilfred', 'iohoiqwqd', '3792139072109'),
(28, 'alfed', '2112312', '123123123'),
(29, 'wilfred', 'constant', '739012301'),
(30, 'dqwdqwdqwd', 'qfqfqwdqw', 'dfqdqwdqwdqw'),
(31, 'Samole', 'estdfhmkfd', '0766571968');

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--

CREATE TABLE `reservations` (
  `reservation_number` int(11) NOT NULL,
  `guest_id` int(11) NOT NULL,
  `room_number` varchar(10) NOT NULL,
  `check_in_date` date NOT NULL,
  `check_out_date` date NOT NULL,
  `status` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `reservations`
--

INSERT INTO `reservations` (`reservation_number`, `guest_id`, `room_number`, `check_in_date`, `check_out_date`, `status`) VALUES
(25, 25, '1005', '2026-02-24', '2026-02-26', 'Confirmed'),
(27, 27, '1001', '2026-03-02', '2026-03-04', 'Confirmed'),
(28, 28, '1006', '2026-03-02', '2026-03-04', 'Confirmed'),
(29, 29, '1002', '2026-03-01', '2026-03-05', 'Confirmed'),
(30, 30, '1016', '2026-03-01', '2026-03-25', 'Confirmed'),
(31, 31, '1009', '2026-03-11', '2026-03-11', 'Confirmed');

--
-- Triggers `reservations`
--
DELIMITER $$
CREATE TRIGGER `after_reservation_created` AFTER INSERT ON `reservations` FOR EACH ROW BEGIN
    UPDATE rooms 
    SET is_available = FALSE 
    WHERE room_number = NEW.room_number;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `room_number` varchar(10) NOT NULL,
  `room_type` varchar(255) DEFAULT NULL,
  `daily_rate` double NOT NULL,
  `is_available` tinyint(1) DEFAULT 1,
  `ac_status` varchar(255) DEFAULT NULL,
  `suite_type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`room_number`, `room_type`, `daily_rate`, `is_available`, `ac_status`, `suite_type`) VALUES
('1001', 'Standard', 100, 0, 'Non-AC', 'Single'),
('1002', 'Standard', 100, 0, 'Non-AC', 'Single'),
('1003', 'Standard', 100, 1, 'Non-AC', 'Single'),
('1004', 'Standard', 100, 1, 'Non-AC', 'Single'),
('1005', 'Standard', 100, 0, 'Non-AC', 'Single'),
('1006', 'Standard', 100, 0, 'Non-AC', 'Single'),
('1007', 'Standard', 100, 1, 'Non-AC', 'Single'),
('1008', 'Standard', 100, 1, 'Non-AC', 'Single'),
('1009', 'Standard', 100, 0, 'Non-AC', 'Single'),
('1010', 'Standard', 100, 1, 'Non-AC', 'Single'),
('1011', 'Premium', 150, 0, 'AC', 'Double'),
('1012', 'Premium', 150, 1, 'AC', 'Double'),
('1013', 'Premium', 150, 1, 'AC', 'Double'),
('1014', 'Premium', 150, 1, 'AC', 'Double'),
('1015', 'Premium', 150, 1, 'AC', 'Double'),
('1016', 'Premium', 150, 0, 'AC', 'Double'),
('1017', 'Premium', 150, 1, 'AC', 'Double'),
('1018', 'Premium', 150, 0, 'AC', 'Double'),
('1019', 'Premium', 150, 1, 'AC', 'Double'),
('1020', 'Premium', 150, 1, 'AC', 'Double'),
('1021', 'VIP', 300, 1, 'AC', 'Luxury Suite'),
('1022', 'VIP', 300, 1, 'AC', 'Luxury Suite'),
('1023', 'VIP', 300, 1, 'AC', 'Luxury Suite'),
('1024', 'VIP', 300, 1, 'AC', 'Luxury Suite'),
('1025', 'VIP', 300, 1, 'AC', 'Luxury Suite'),
('1026', 'VIP', 300, 1, 'AC', 'Luxury Suite'),
('1027', 'VIP', 300, 1, 'AC', 'Luxury Suite'),
('1028', 'VIP', 300, 1, 'AC', 'Luxury Suite'),
('1029', 'VIP', 300, 1, 'AC', 'Luxury Suite'),
('1030', 'VIP', 300, 1, 'AC', 'Luxury Suite');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`) VALUES
(1, 'admin', '$2a$10$KpVGDlexYxDyb/pSI/.0YepFjmH8A2sDRvgwbxdKSQYxv9CJ9rfvG', 'ADMIN');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bills`
--
ALTER TABLE `bills`
  ADD PRIMARY KEY (`bill_id`),
  ADD KEY `reservation_number` (`reservation_number`);

--
-- Indexes for table `guests`
--
ALTER TABLE `guests`
  ADD PRIMARY KEY (`guest_id`);

--
-- Indexes for table `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`reservation_number`),
  ADD KEY `guest_id` (`guest_id`),
  ADD KEY `room_number` (`room_number`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`room_number`);

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
-- AUTO_INCREMENT for table `bills`
--
ALTER TABLE `bills`
  MODIFY `bill_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `guests`
--
ALTER TABLE `guests`
  MODIFY `guest_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `reservation_number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bills`
--
ALTER TABLE `bills`
  ADD CONSTRAINT `bills_ibfk_1` FOREIGN KEY (`reservation_number`) REFERENCES `reservations` (`reservation_number`) ON DELETE CASCADE;

--
-- Constraints for table `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`guest_id`) REFERENCES `guests` (`guest_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reservations_ibfk_2` FOREIGN KEY (`room_number`) REFERENCES `rooms` (`room_number`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
