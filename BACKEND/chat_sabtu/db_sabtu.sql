-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Waktu pembuatan: 27 Feb 2021 pada 05.33
-- Versi server: 10.4.17-MariaDB
-- Versi PHP: 8.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_sabtu`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_order`
--

CREATE TABLE `tb_order` (
  `id` int(11) NOT NULL,
  `id_customer` int(11) NOT NULL,
  `id_seller` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_order`
--

INSERT INTO `tb_order` (`id`, `id_customer`, `id_seller`) VALUES
(1, 1, 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `firebase_token` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `firebase_token`) VALUES
(1, 'user_a', '123123', 'e-0U8s3NTS-9jKy8aVbZKX:APA91bFpjn9sAd7TBr3ttW7gVOkw2iH1ncVXGysKnRV-JZe4qKspiqIlN_YNnP_bHPDSsxTkpaftpZKHt6delj7A7TuXDTCGVHRdFZY--5C8TILSRrCh4Lnkbvg1b84-pHRlPXCDABUA'),
(2, 'user_b', '123123', 'eS7Ur87mS4aICxQOQp8WkG:APA91bEXR96ZViWOmfJEGJo8G-bokqNJuabAjSXlkWY69xYTCGiu4lT7-CVZzWi_LwQajDYnxS9ATyKfsfcVBzKK2Xtc0sScYP9RLtRxTgXKHCz0a-KdDuom_Uabt5awAka1d4iwlQfc');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tb_order`
--
ALTER TABLE `tb_order`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tb_order`
--
ALTER TABLE `tb_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
