-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 24, 2026 at 01:04 PM
-- Server version: 8.4.3
-- PHP Version: 8.2.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kos_kosan`
--

-- --------------------------------------------------------

--
-- Table structure for table `aktivitas_kos`
--

CREATE TABLE `aktivitas_kos` (
  `id_aktivitas` bigint NOT NULL,
  `id_user` int DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `aktivitas` varchar(30) NOT NULL,
  `tabel_data` varchar(64) NOT NULL,
  `detail` text,
  `waktu` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `aktivitas_kos`
--

INSERT INTO `aktivitas_kos` (`id_aktivitas`, `id_user`, `username`, `aktivitas`, `tabel_data`, `detail`, `waktu`) VALUES
(1, 3, 'admin', 'tambah', 'penghuni', 'Tambah data ID 1', '2026-11-24 10:34:34'),
(2, 3, 'admin', 'tambah', 'penghuni', 'Tambah data ID 2', '2026-11-24 10:35:30'),
(3, 3, 'admin', 'tambah', 'kontrak_sewa', 'Tambah data ID 1', '2026-11-24 10:37:31'),
(4, 3, 'admin', 'edit', 'kontrak_sewa', 'Edit data ID 1', '2026-11-24 10:38:51'),
(5, 3, 'admin', 'tambah', 'tagihan_bulanan', 'Tambah data ID 1', '2026-11-24 10:41:18'),
(6, 3, 'admin', 'tambah', 'pembayaran', 'Tambah data ID 1', '2026-11-24 10:41:45'),
(7, 3, 'admin', 'tambah', 'pembayaran', 'Tambah data ID 2', '2026-11-24 10:41:45'),
(8, 3, 'admin', 'tambah', 'pembayaran', 'Tambah data ID 3', '2026-11-24 10:41:46'),
(9, 3, 'admin', 'hapus', 'pembayaran', 'Hapus data ID 1', '2026-11-24 10:41:50'),
(10, 3, 'admin', 'hapus', 'pembayaran', 'Hapus data ID 2', '2026-11-24 10:41:52'),
(11, 3, 'admin', 'hapus', 'pembayaran', 'Hapus data ID 3', '2026-11-24 10:41:59'),
(12, 3, 'admin', 'tambah', 'pembayaran', 'Tambah data ID 4', '2026-11-24 10:42:17'),
(13, 3, 'admin', 'tambah', 'kontrak_sewa', 'Tambah data ID 2', '2026-11-24 10:43:23'),
(14, 3, 'admin', 'edit', 'kontrak_sewa', 'Edit data ID 2', '2026-11-24 10:43:42'),
(15, 3, 'admin', 'edit', 'kontrak_sewa', 'Edit data ID 2', '2026-11-24 10:44:12'),
(16, 3, 'admin', 'edit', 'kontrak_sewa', 'Edit data ID 2', '2026-11-24 10:44:19'),
(17, 3, 'admin', 'tambah', 'tagihan_bulanan', 'Tambah data ID 2', '2026-11-24 10:45:09'),
(18, 3, 'admin', 'edit', 'tagihan_bulanan', 'Edit data ID 2', '2026-11-24 10:45:22'),
(19, 3, 'admin', 'tambah', 'pembayaran', 'Tambah data ID 5', '2026-11-24 10:47:09'),
(20, 3, 'admin', 'tambah', 'akun_pengguna', 'Tambah data ID 5', '2026-11-24 10:47:47'),
(21, 3, 'admin', 'tambah', 'akun_pengguna', 'Tambah data ID 6', '2026-11-24 10:48:04'),
(22, 3, 'admin', 'logout', 'akun_pengguna', 'Logout', '2026-11-24 10:48:14'),
(23, 5, 'aluna', 'login', 'akun_pengguna', 'Login aluna', '2026-11-24 10:48:18'),
(24, 5, 'aluna', 'logout', 'akun_pengguna', 'Logout', '2026-11-24 10:52:35'),
(25, 3, 'admin', 'login', 'akun_pengguna', 'Login admin', '2026-11-24 10:52:37'),
(26, 3, 'admin', 'logout', 'akun_pengguna', 'Logout', '2026-11-24 10:53:02'),
(27, 5, 'aluna', 'login', 'akun_pengguna', 'Login aluna', '2026-11-24 10:53:07'),
(28, 5, 'aluna', 'logout', 'akun_pengguna', 'Logout', '2026-11-24 10:53:55'),
(29, 3, 'admin', 'login', 'akun_pengguna', 'Login admin', '2026-11-24 10:53:56'),
(30, 3, 'admin', 'tambah', 'pemilik', 'Tambah data ID 2', '2026-11-24 10:54:31'),
(31, 3, 'admin', 'tambah', 'akun_pengguna', 'Tambah data ID 7', '2026-11-24 10:54:51'),
(32, 3, 'admin', 'logout', 'akun_pengguna', 'Logout', '2026-11-24 10:54:53'),
(33, 7, 'wowok', 'login', 'akun_pengguna', 'Login wowok', '2026-11-24 10:54:58'),
(34, 7, 'wowok', 'logout', 'akun_pengguna', 'Logout', '2026-11-24 10:56:35'),
(35, 3, 'admin', 'login', 'akun_pengguna', 'Login admin', '2026-11-24 10:56:37'),
(36, 3, 'admin', 'hapus', 'akun_pengguna', 'Hapus data ID 7', '2026-11-24 10:56:54'),
(37, 3, 'admin', 'logout', 'akun_pengguna', 'Logout', '2026-11-24 11:08:21'),
(38, 5, 'aluna', 'login', 'akun_pengguna', 'Login aluna', '2026-11-24 11:08:25'),
(39, 3, 'admin', 'login', 'akun_pengguna', 'Login admin', '2026-11-24 11:15:49'),
(40, 3, 'admin', 'logout', 'akun_pengguna', 'Logout', '2026-11-24 11:15:55'),
(41, 5, 'aluna', 'login', 'akun_pengguna', 'Login aluna', '2026-11-24 11:15:59'),
(42, 5, 'aluna', 'logout', 'akun_pengguna', 'Logout', '2026-11-24 11:18:10'),
(43, 6, 'mj', 'login', 'akun_pengguna', 'Login mj', '2026-11-24 11:18:15'),
(44, 6, 'mj', 'logout', 'akun_pengguna', 'Logout', '2026-11-24 11:18:34'),
(45, 5, 'aluna', 'login', 'akun_pengguna', 'Login aluna', '2026-11-24 11:18:38'),
(46, 5, 'aluna', 'logout', 'akun_pengguna', 'Logout', '2026-11-24 11:21:37'),
(47, 6, 'mj', 'login', 'akun_pengguna', 'Login mj', '2026-11-24 11:21:41'),
(48, 6, 'mj', 'logout', 'akun_pengguna', 'Logout', '2026-11-24 11:21:54'),
(49, 3, 'admin', 'login', 'akun_pengguna', 'Login admin', '2026-11-24 11:21:59'),
(50, 3, 'admin', 'hapus', 'pemilik', 'Hapus data ID 2', '2026-11-24 12:12:57'),
(51, 3, 'admin', 'tambah', 'pemilik', 'Tambah data ID 3', '2026-11-24 12:13:05'),
(52, 3, 'admin', 'logout', 'akun_pengguna', 'Logout', '2026-11-24 12:55:52'),
(53, 5, 'aluna', 'login', 'akun_pengguna', 'Login aluna', '2026-11-24 12:55:54');

-- --------------------------------------------------------

--
-- Table structure for table `akun_pengguna`
--

CREATE TABLE `akun_pengguna` (
  `id_user` int NOT NULL,
  `id_penghuni` int DEFAULT NULL,
  `id_pemilik` int DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `akun_pengguna`
--

INSERT INTO `akun_pengguna` (`id_user`, `id_penghuni`, `id_pemilik`, `username`, `password`, `role`) VALUES
(3, NULL, 1, 'admin', 'scrypt:32768:8:1$3RcOl7qWI8fhNSXT$54e613ffb50e73940e534c556ff2ed0e4f936a2acf341e3c1a831d16a688fa4ba0b51419a42506ef284661d9830d74d53ced0cf9583fd99212bed506ebeaa346', 'admin'),
(5, 1, NULL, 'aluna', 'scrypt:32768:8:1$9Y8Iv3maqRIqzknA$ba309e90ec1cd08ea9d30d55e84aae157605150aacfec6ee760f4b49e684595c685d0eb77164edce8a39c21c891aca58147510b3ed24b50dc28fdaf128119955', 'penghuni'),
(6, 2, NULL, 'mj', 'scrypt:32768:8:1$jFnm0MpUoAni0gFR$3e80723ca61a9131fc447f259e57c0a989de7db24196d4ee2a227af91a3ca9e16afb9e377e61b7b4de3bd39c356e89d33d952a571999ba9b6468db019d025b17', 'penghuni');

-- --------------------------------------------------------

--
-- Table structure for table `fasilitas_kamar`
--

CREATE TABLE `fasilitas_kamar` (
  `id_fasilitas` int NOT NULL,
  `id_kamar` int NOT NULL,
  `nama_fasilitas` varchar(100) NOT NULL,
  `kondisi` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `fasilitas_kamar`
--

INSERT INTO `fasilitas_kamar` (`id_fasilitas`, `id_kamar`, `nama_fasilitas`, `kondisi`) VALUES
(1, 1, 'AC', 'Baik'),
(2, 2, 'AC', 'Baik'),
(3, 3, 'AC', 'Baik'),
(4, 4, 'AC', 'Baik'),
(5, 5, 'AC', 'Baik'),
(6, 6, 'AC', 'Baik'),
(7, 1, 'Spring Bed', 'Baik'),
(8, 2, 'Spring Bed', 'Baik'),
(9, 3, 'Spring Bed', 'Baik'),
(10, 4, 'Spring Bed', 'Baik'),
(11, 5, 'Spring Bed', 'Baik'),
(12, 6, 'Spring Bed', 'Baik'),
(13, 1, 'Lemari', 'Baik'),
(14, 2, 'Lemari', 'Baik'),
(15, 3, 'Lemari', 'Baik'),
(16, 4, 'Lemari', 'Baik'),
(17, 5, 'Lemari', 'Baik'),
(18, 6, 'Lemari', 'Baik'),
(19, 1, 'Meja Belajar', 'Baik'),
(20, 2, 'Meja Belajar', 'Baik'),
(21, 3, 'Meja Belajar', 'Baik'),
(22, 4, 'Meja Belajar', 'Baik'),
(23, 5, 'Meja Belajar', 'Baik'),
(24, 6, 'Meja Belajar', 'Baik'),
(25, 1, 'Kursi', 'Baik'),
(26, 2, 'Kursi', 'Baik'),
(27, 3, 'Kursi', 'Baik'),
(28, 4, 'Kursi', 'Baik'),
(29, 5, 'Kursi', 'Baik'),
(30, 6, 'Kursi', 'Baik'),
(31, 1, 'Kamar Mandi Dalam', 'Baik'),
(32, 2, 'Kamar Mandi Dalam', 'Baik'),
(33, 3, 'Kamar Mandi Dalam', 'Baik'),
(34, 4, 'Kamar Mandi Dalam', 'Baik'),
(35, 5, 'Kamar Mandi Dalam', 'Baik'),
(36, 6, 'Kamar Mandi Dalam', 'Baik'),
(37, 1, 'WiFi', 'Baik'),
(38, 2, 'WiFi', 'Baik'),
(39, 3, 'WiFi', 'Baik'),
(40, 4, 'WiFi', 'Baik'),
(41, 5, 'WiFi', 'Baik'),
(42, 6, 'WiFi', 'Baik'),
(43, 1, 'Listrik Termasuk', 'Baik'),
(44, 2, 'Listrik Termasuk', 'Baik'),
(45, 3, 'Listrik Termasuk', 'Baik'),
(46, 4, 'Listrik Termasuk', 'Baik'),
(47, 5, 'Listrik Termasuk', 'Baik'),
(48, 6, 'Listrik Termasuk', 'Baik'),
(49, 1, 'Air Termasuk', 'Baik'),
(50, 2, 'Air Termasuk', 'Baik'),
(51, 3, 'Air Termasuk', 'Baik'),
(52, 4, 'Air Termasuk', 'Baik'),
(53, 5, 'Air Termasuk', 'Baik'),
(54, 6, 'Air Termasuk', 'Baik'),
(55, 1, 'TV', 'Baik'),
(56, 2, 'TV', 'Baik'),
(57, 3, 'TV', 'Baik'),
(58, 4, 'TV', 'Baik'),
(59, 5, 'TV', 'Baik'),
(60, 6, 'TV', 'Baik'),
(61, 7, 'Kipas Angin', 'Baik'),
(62, 8, 'Kipas Angin', 'Baik'),
(63, 9, 'Kipas Angin', 'Baik'),
(64, 10, 'Kipas Angin', 'Baik'),
(65, 11, 'Kipas Angin', 'Baik'),
(66, 12, 'Kipas Angin', 'Baik'),
(67, 7, 'Kasur', 'Baik'),
(68, 8, 'Kasur', 'Baik'),
(69, 9, 'Kasur', 'Baik'),
(70, 10, 'Kasur', 'Baik'),
(71, 11, 'Kasur', 'Baik'),
(72, 12, 'Kasur', 'Baik'),
(73, 7, 'Lemari', 'Baik'),
(74, 8, 'Lemari', 'Baik'),
(75, 9, 'Lemari', 'Baik'),
(76, 10, 'Lemari', 'Baik'),
(77, 11, 'Lemari', 'Baik'),
(78, 12, 'Lemari', 'Baik'),
(79, 7, 'Kamar Mandi Dalam', 'Baik'),
(80, 8, 'Kamar Mandi Dalam', 'Baik'),
(81, 9, 'Kamar Mandi Dalam', 'Baik'),
(82, 10, 'Kamar Mandi Dalam', 'Baik'),
(83, 11, 'Kamar Mandi Dalam', 'Baik'),
(84, 12, 'Kamar Mandi Dalam', 'Baik'),
(85, 7, 'WiFi', 'Baik'),
(86, 8, 'WiFi', 'Baik'),
(87, 9, 'WiFi', 'Baik'),
(88, 10, 'WiFi', 'Baik'),
(89, 11, 'WiFi', 'Baik'),
(90, 12, 'WiFi', 'Baik'),
(91, 7, 'Listrik Termasuk', 'Baik'),
(92, 8, 'Listrik Termasuk', 'Baik'),
(93, 9, 'Listrik Termasuk', 'Baik'),
(94, 10, 'Listrik Termasuk', 'Baik'),
(95, 11, 'Listrik Termasuk', 'Baik'),
(96, 12, 'Listrik Termasuk', 'Baik'),
(97, 7, 'Air Termasuk', 'Baik'),
(98, 8, 'Air Termasuk', 'Baik'),
(99, 9, 'Air Termasuk', 'Baik'),
(100, 10, 'Air Termasuk', 'Baik'),
(101, 11, 'Air Termasuk', 'Baik'),
(102, 12, 'Air Termasuk', 'Baik'),
(103, 13, 'AC', 'Baik'),
(104, 14, 'AC', 'Baik'),
(105, 15, 'AC', 'Baik'),
(106, 16, 'AC', 'Baik'),
(107, 17, 'AC', 'Baik'),
(108, 18, 'AC', 'Baik'),
(109, 13, 'Kasur', 'Baik'),
(110, 14, 'Kasur', 'Baik'),
(111, 15, 'Kasur', 'Baik'),
(112, 16, 'Kasur', 'Baik'),
(113, 17, 'Kasur', 'Baik'),
(114, 18, 'Kasur', 'Baik'),
(115, 13, 'Lemari', 'Baik'),
(116, 14, 'Lemari', 'Baik'),
(117, 15, 'Lemari', 'Baik'),
(118, 16, 'Lemari', 'Baik'),
(119, 17, 'Lemari', 'Baik'),
(120, 18, 'Lemari', 'Baik'),
(121, 13, 'Meja Belajar', 'Baik'),
(122, 14, 'Meja Belajar', 'Baik'),
(123, 15, 'Meja Belajar', 'Baik'),
(124, 16, 'Meja Belajar', 'Baik'),
(125, 17, 'Meja Belajar', 'Baik'),
(126, 18, 'Meja Belajar', 'Baik'),
(127, 13, 'Kamar Mandi Dalam', 'Baik'),
(128, 14, 'Kamar Mandi Dalam', 'Baik'),
(129, 15, 'Kamar Mandi Dalam', 'Baik'),
(130, 16, 'Kamar Mandi Dalam', 'Baik'),
(131, 17, 'Kamar Mandi Dalam', 'Baik'),
(132, 18, 'Kamar Mandi Dalam', 'Baik'),
(133, 13, 'WiFi', 'Baik'),
(134, 14, 'WiFi', 'Baik'),
(135, 15, 'WiFi', 'Baik'),
(136, 16, 'WiFi', 'Baik'),
(137, 17, 'WiFi', 'Baik'),
(138, 18, 'WiFi', 'Baik'),
(139, 13, 'Listrik Termasuk', 'Baik'),
(140, 14, 'Listrik Termasuk', 'Baik'),
(141, 15, 'Listrik Termasuk', 'Baik'),
(142, 16, 'Listrik Termasuk', 'Baik'),
(143, 17, 'Listrik Termasuk', 'Baik'),
(144, 18, 'Listrik Termasuk', 'Baik'),
(145, 13, 'Air Termasuk', 'Baik'),
(146, 14, 'Air Termasuk', 'Baik'),
(147, 15, 'Air Termasuk', 'Baik'),
(148, 16, 'Air Termasuk', 'Baik'),
(149, 17, 'Air Termasuk', 'Baik'),
(150, 18, 'Air Termasuk', 'Baik'),
(151, 19, 'Kipas Angin', 'Baik'),
(152, 20, 'Kipas Angin', 'Baik'),
(153, 21, 'Kipas Angin', 'Baik'),
(154, 22, 'Kipas Angin', 'Baik'),
(155, 23, 'Kipas Angin', 'Baik'),
(156, 24, 'Kipas Angin', 'Baik'),
(157, 19, 'Kasur', 'Baik'),
(158, 20, 'Kasur', 'Baik'),
(159, 21, 'Kasur', 'Baik'),
(160, 22, 'Kasur', 'Baik'),
(161, 23, 'Kasur', 'Baik'),
(162, 24, 'Kasur', 'Baik'),
(163, 19, 'Lemari', 'Baik'),
(164, 20, 'Lemari', 'Baik'),
(165, 21, 'Lemari', 'Baik'),
(166, 22, 'Lemari', 'Baik'),
(167, 23, 'Lemari', 'Baik'),
(168, 24, 'Lemari', 'Baik'),
(169, 19, 'Kamar Mandi Dalam', 'Baik'),
(170, 20, 'Kamar Mandi Dalam', 'Baik'),
(171, 21, 'Kamar Mandi Dalam', 'Baik'),
(172, 22, 'Kamar Mandi Dalam', 'Baik'),
(173, 23, 'Kamar Mandi Dalam', 'Baik'),
(174, 24, 'Kamar Mandi Dalam', 'Baik'),
(175, 19, 'WiFi', 'Baik'),
(176, 20, 'WiFi', 'Baik'),
(177, 21, 'WiFi', 'Baik'),
(178, 22, 'WiFi', 'Baik'),
(179, 23, 'WiFi', 'Baik'),
(180, 24, 'WiFi', 'Baik'),
(181, 19, 'Listrik Termasuk', 'Baik'),
(182, 20, 'Listrik Termasuk', 'Baik'),
(183, 21, 'Listrik Termasuk', 'Baik'),
(184, 22, 'Listrik Termasuk', 'Baik'),
(185, 23, 'Listrik Termasuk', 'Baik'),
(186, 24, 'Listrik Termasuk', 'Baik'),
(187, 19, 'Air Termasuk', 'Baik'),
(188, 20, 'Air Termasuk', 'Baik'),
(189, 21, 'Air Termasuk', 'Baik'),
(190, 22, 'Air Termasuk', 'Baik'),
(191, 23, 'Air Termasuk', 'Baik'),
(192, 24, 'Air Termasuk', 'Baik');

-- --------------------------------------------------------

--
-- Table structure for table `gedung_kos`
--

CREATE TABLE `gedung_kos` (
  `id_gedung` int NOT NULL,
  `id_pemilik` int NOT NULL,
  `nama_gedung` varchar(100) NOT NULL,
  `total_kamar` int NOT NULL,
  `jumlah_lantai` int NOT NULL,
  `alamat` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `gedung_kos`
--

INSERT INTO `gedung_kos` (`id_gedung`, `id_pemilik`, `nama_gedung`, `total_kamar`, `jumlah_lantai`, `alamat`) VALUES
(1, 1, 'Gedung Peony', 12, 2, 'Surakarta'),
(2, 1, 'Gedung Anggrek', 12, 2, 'Surakarta');

-- --------------------------------------------------------

--
-- Table structure for table `kamar`
--

CREATE TABLE `kamar` (
  `id_kamar` int NOT NULL,
  `id_gedung` int NOT NULL,
  `no_kamar` varchar(20) NOT NULL,
  `lantai` int NOT NULL,
  `harga_sewa` decimal(12,2) NOT NULL,
  `status_kamar` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kamar`
--

INSERT INTO `kamar` (`id_kamar`, `id_gedung`, `no_kamar`, `lantai`, `harga_sewa`, `status_kamar`) VALUES
(1, 1, '1', 1, 1400000.00, 'tersedia'),
(2, 1, '2', 1, 1400000.00, 'tersedia'),
(3, 1, '3', 1, 1400000.00, 'tersedia'),
(4, 1, '4', 1, 1400000.00, 'tersedia'),
(5, 1, '5', 1, 1400000.00, 'tersedia'),
(6, 1, '6', 1, 1400000.00, 'tersedia'),
(7, 1, '7', 1, 700000.00, 'tersedia'),
(8, 1, '8', 1, 700000.00, 'tersedia'),
(9, 1, '9', 2, 700000.00, 'tersedia'),
(10, 1, '10', 2, 700000.00, 'tersedia'),
(11, 1, '11', 2, 700000.00, 'tersedia'),
(12, 1, '12', 2, 700000.00, 'tersedia'),
(13, 2, '1', 1, 850000.00, 'tersedia'),
(14, 2, '2', 1, 850000.00, 'tersedia'),
(15, 2, '3', 1, 850000.00, 'tersedia'),
(16, 2, '4', 1, 850000.00, 'tersedia'),
(17, 2, '5', 1, 850000.00, 'tersedia'),
(18, 2, '6', 1, 850000.00, 'tersedia'),
(19, 2, '7', 2, 700000.00, 'tersedia'),
(20, 2, '8', 2, 700000.00, 'tersedia'),
(21, 2, '9', 2, 700000.00, 'tersedia'),
(22, 2, '10', 2, 700000.00, 'tersedia'),
(23, 2, '11', 2, 700000.00, 'tersedia'),
(24, 2, '12', 2, 700000.00, 'tersedia');

-- --------------------------------------------------------

--
-- Table structure for table `keluhan`
--

CREATE TABLE `keluhan` (
  `id_keluhan` int NOT NULL,
  `id_penghuni` int NOT NULL,
  `id_kamar` int NOT NULL,
  `tanggal_keluhan` date NOT NULL,
  `deskripsi_keluhan` text NOT NULL,
  `status_keluhan` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kontrak_sewa`
--

CREATE TABLE `kontrak_sewa` (
  `id_kontrak` int NOT NULL,
  `id_penghuni` int NOT NULL,
  `id_kamar` int NOT NULL,
  `tanggal_mulai` date NOT NULL,
  `tanggal_selesai` date NOT NULL,
  `status_kontrak` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kontrak_sewa`
--

INSERT INTO `kontrak_sewa` (`id_kontrak`, `id_penghuni`, `id_kamar`, `tanggal_mulai`, `tanggal_selesai`, `status_kontrak`) VALUES
(1, 1, 1, '2026-11-24', '2027-02-24', 'aktif'),
(2, 2, 18, '2026-11-24', '2027-04-24', 'aktif');

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id_pembayaran` int NOT NULL,
  `id_tagihan` int NOT NULL,
  `tanggal_pembayaran` date NOT NULL,
  `jumlah_pembayaran` decimal(12,2) NOT NULL,
  `metode_pembayaran` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `pembayaran`
--

INSERT INTO `pembayaran` (`id_pembayaran`, `id_tagihan`, `tanggal_pembayaran`, `jumlah_pembayaran`, `metode_pembayaran`) VALUES
(4, 1, '2026-11-17', 4200000.00, 'Transfer'),
(5, 2, '2026-11-24', 3400000.00, 'Transfer');

-- --------------------------------------------------------

--
-- Table structure for table `pemilik`
--

CREATE TABLE `pemilik` (
  `id_pemilik` int NOT NULL,
  `nama_pemilik` varchar(100) NOT NULL,
  `no_telp` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `pemilik`
--

INSERT INTO `pemilik` (`id_pemilik`, `nama_pemilik`, `no_telp`) VALUES
(1, 'Fuad', '081234567890'),
(3, 'wowok', '08123456789');

-- --------------------------------------------------------

--
-- Table structure for table `penghuni`
--

CREATE TABLE `penghuni` (
  `id_penghuni` int NOT NULL,
  `nama_penghuni` varchar(100) NOT NULL,
  `no_telp` varchar(20) NOT NULL,
  `asal` varchar(100) NOT NULL,
  `pekerjaan` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `penghuni`
--

INSERT INTO `penghuni` (`id_penghuni`, `nama_penghuni`, `no_telp`, `asal`, `pekerjaan`) VALUES
(1, 'Aluna', '08123456789', 'Palur', 'Pengangguran'),
(2, 'Michael Jackson', '0812174624', 'US', 'Singer');

-- --------------------------------------------------------

--
-- Table structure for table `tagihan_bulanan`
--

CREATE TABLE `tagihan_bulanan` (
  `id_tagihan` int NOT NULL,
  `id_kontrak` int NOT NULL,
  `bulan_tagihan` date NOT NULL,
  `jumlah_tagihan` decimal(12,2) NOT NULL,
  `tanggal_jatuh_tempo` date NOT NULL,
  `status_tagihan` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tagihan_bulanan`
--

INSERT INTO `tagihan_bulanan` (`id_tagihan`, `id_kontrak`, `bulan_tagihan`, `jumlah_tagihan`, `tanggal_jatuh_tempo`, `status_tagihan`) VALUES
(1, 1, '2026-11-24', 4200000.00, '2026-11-24', 'lunas'),
(2, 2, '2026-11-24', 3400000.00, '2026-11-24', 'lunas');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `aktivitas_kos`
--
ALTER TABLE `aktivitas_kos`
  ADD PRIMARY KEY (`id_aktivitas`),
  ADD KEY `idx_aktivitas_waktu` (`waktu`),
  ADD KEY `idx_aktivitas_user` (`id_user`);

--
-- Indexes for table `akun_pengguna`
--
ALTER TABLE `akun_pengguna`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `id_penghuni` (`id_penghuni`),
  ADD UNIQUE KEY `id_pemilik` (`id_pemilik`);

--
-- Indexes for table `fasilitas_kamar`
--
ALTER TABLE `fasilitas_kamar`
  ADD PRIMARY KEY (`id_fasilitas`),
  ADD KEY `id_kamar` (`id_kamar`);

--
-- Indexes for table `gedung_kos`
--
ALTER TABLE `gedung_kos`
  ADD PRIMARY KEY (`id_gedung`),
  ADD KEY `id_pemilik` (`id_pemilik`);

--
-- Indexes for table `kamar`
--
ALTER TABLE `kamar`
  ADD PRIMARY KEY (`id_kamar`),
  ADD KEY `id_gedung` (`id_gedung`);

--
-- Indexes for table `keluhan`
--
ALTER TABLE `keluhan`
  ADD PRIMARY KEY (`id_keluhan`),
  ADD KEY `id_penghuni` (`id_penghuni`),
  ADD KEY `id_kamar` (`id_kamar`);

--
-- Indexes for table `kontrak_sewa`
--
ALTER TABLE `kontrak_sewa`
  ADD PRIMARY KEY (`id_kontrak`),
  ADD KEY `id_penghuni` (`id_penghuni`),
  ADD KEY `id_kamar` (`id_kamar`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id_pembayaran`),
  ADD KEY `id_tagihan` (`id_tagihan`);

--
-- Indexes for table `pemilik`
--
ALTER TABLE `pemilik`
  ADD PRIMARY KEY (`id_pemilik`);

--
-- Indexes for table `penghuni`
--
ALTER TABLE `penghuni`
  ADD PRIMARY KEY (`id_penghuni`);

--
-- Indexes for table `tagihan_bulanan`
--
ALTER TABLE `tagihan_bulanan`
  ADD PRIMARY KEY (`id_tagihan`),
  ADD KEY `id_kontrak` (`id_kontrak`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `aktivitas_kos`
--
ALTER TABLE `aktivitas_kos`
  MODIFY `id_aktivitas` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `akun_pengguna`
--
ALTER TABLE `akun_pengguna`
  MODIFY `id_user` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `fasilitas_kamar`
--
ALTER TABLE `fasilitas_kamar`
  MODIFY `id_fasilitas` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=256;

--
-- AUTO_INCREMENT for table `gedung_kos`
--
ALTER TABLE `gedung_kos`
  MODIFY `id_gedung` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `kamar`
--
ALTER TABLE `kamar`
  MODIFY `id_kamar` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `keluhan`
--
ALTER TABLE `keluhan`
  MODIFY `id_keluhan` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kontrak_sewa`
--
ALTER TABLE `kontrak_sewa`
  MODIFY `id_kontrak` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `id_pembayaran` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pemilik`
--
ALTER TABLE `pemilik`
  MODIFY `id_pemilik` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `penghuni`
--
ALTER TABLE `penghuni`
  MODIFY `id_penghuni` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tagihan_bulanan`
--
ALTER TABLE `tagihan_bulanan`
  MODIFY `id_tagihan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `akun_pengguna`
--
ALTER TABLE `akun_pengguna`
  ADD CONSTRAINT `akun_pengguna_ibfk_1` FOREIGN KEY (`id_penghuni`) REFERENCES `penghuni` (`id_penghuni`),
  ADD CONSTRAINT `akun_pengguna_ibfk_2` FOREIGN KEY (`id_pemilik`) REFERENCES `pemilik` (`id_pemilik`);

--
-- Constraints for table `fasilitas_kamar`
--
ALTER TABLE `fasilitas_kamar`
  ADD CONSTRAINT `fasilitas_kamar_ibfk_1` FOREIGN KEY (`id_kamar`) REFERENCES `kamar` (`id_kamar`);

--
-- Constraints for table `gedung_kos`
--
ALTER TABLE `gedung_kos`
  ADD CONSTRAINT `gedung_kos_ibfk_1` FOREIGN KEY (`id_pemilik`) REFERENCES `pemilik` (`id_pemilik`);

--
-- Constraints for table `kamar`
--
ALTER TABLE `kamar`
  ADD CONSTRAINT `kamar_ibfk_1` FOREIGN KEY (`id_gedung`) REFERENCES `gedung_kos` (`id_gedung`);

--
-- Constraints for table `keluhan`
--
ALTER TABLE `keluhan`
  ADD CONSTRAINT `keluhan_ibfk_1` FOREIGN KEY (`id_penghuni`) REFERENCES `penghuni` (`id_penghuni`),
  ADD CONSTRAINT `keluhan_ibfk_2` FOREIGN KEY (`id_kamar`) REFERENCES `kamar` (`id_kamar`);

--
-- Constraints for table `kontrak_sewa`
--
ALTER TABLE `kontrak_sewa`
  ADD CONSTRAINT `kontrak_sewa_ibfk_1` FOREIGN KEY (`id_penghuni`) REFERENCES `penghuni` (`id_penghuni`),
  ADD CONSTRAINT `kontrak_sewa_ibfk_2` FOREIGN KEY (`id_kamar`) REFERENCES `kamar` (`id_kamar`);

--
-- Constraints for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `pembayaran_ibfk_1` FOREIGN KEY (`id_tagihan`) REFERENCES `tagihan_bulanan` (`id_tagihan`);

--
-- Constraints for table `tagihan_bulanan`
--
ALTER TABLE `tagihan_bulanan`
  ADD CONSTRAINT `tagihan_bulanan_ibfk_1` FOREIGN KEY (`id_kontrak`) REFERENCES `kontrak_sewa` (`id_kontrak`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
