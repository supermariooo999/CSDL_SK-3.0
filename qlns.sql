-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th9 22, 2026 lúc 06:10 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `qlns`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cau_hinh`
--

CREATE TABLE `cau_hinh` (
  `id` bigint(20) NOT NULL,
  `nhom` varchar(100) DEFAULT NULL,
  `khoa_cau_hinh` varchar(100) DEFAULT NULL,
  `gia_tri` text DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chuc_vu`
--

CREATE TABLE `chuc_vu` (
  `id` bigint(20) NOT NULL,
  `ma_chuc_vu` varchar(50) DEFAULT NULL,
  `ten_chuc_vu` varchar(255) NOT NULL,
  `ten_tat` varchar(100) DEFAULT NULL,
  `thu_tu_cap` int(11) DEFAULT 1,
  `la_quan_ly` tinyint(4) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `chuc_vu`
--

INSERT INTO `chuc_vu` (`id`, `ma_chuc_vu`, `ten_chuc_vu`, `ten_tat`, `thu_tu_cap`, `la_quan_ly`, `created_at`) VALUES
(1, 'NV', 'Nhân viên', NULL, 6, 0, '2026-04-28 00:23:54'),
(2, 'CC', 'Công chức', NULL, 5, 0, '2026-04-28 00:23:54'),
(3, 'PTOT', 'Phó Tổ trưởng', NULL, 4, 1, '2026-04-28 00:23:54'),
(5, 'PTCS', 'Phó trưởng Thuế cơ sở', NULL, 2, 1, '2026-04-28 00:23:54'),
(6, 'TTCS', 'Trưởng Thuế cơ sở', NULL, 1, 1, '2026-04-28 00:23:54'),
(10, 'TOT', 'Tổ trưởng', 'TOT', 3, 1, '2026-04-29 09:55:28'),
(12, 'QTHT', 'Quản trị hệ thống', 'QTHT', 7, 0, '2026-04-30 10:30:18');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cong_tac`
--

CREATE TABLE `cong_tac` (
  `id` bigint(20) NOT NULL,
  `so_giay` bigint(20) NOT NULL,
  `id_nhan_vien` bigint(20) NOT NULL,
  `noi_dung` text DEFAULT NULL,
  `so_cong_lenh` varchar(100) DEFAULT NULL,
  `tu_ngay` date DEFAULT NULL,
  `den_ngay` date DEFAULT NULL,
  `loai_cong_tac` enum('cong_tac','tap_huan','hoc') DEFAULT 'cong_tac',
  `luong_ung_truoc` decimal(12,2) DEFAULT 0.00 COMMENT 'Lương ứng trước',
  `cong_tac_phi_ung_truoc` decimal(12,2) DEFAULT 0.00 COMMENT 'Công tác phí ứng trước',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `cong_tac`
--

INSERT INTO `cong_tac` (`id`, `so_giay`, `id_nhan_vien`, `noi_dung`, `so_cong_lenh`, `tu_ngay`, `den_ngay`, `loai_cong_tac`, `luong_ung_truoc`, `cong_tac_phi_ung_truoc`, `created_at`, `updated_at`) VALUES
(33, 2026013, 57, 'Niêm yết công khai thủ tục hành chính', '2017/CMA-VP', '2026-07-31', '2026-08-03', 'cong_tac', 0.00, 0.00, '2026-08-10 08:16:39', '2026-08-10 08:16:39'),
(34, 2026014, 60, 'Niêm yết công khai thủ tục hành chính', '2017/CMA-VP', '2026-07-31', '2026-06-02', 'cong_tac', 0.00, 0.00, '2026-08-10 08:16:39', '2026-08-10 08:16:39');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `lich_su_duyet_nghi`
--

CREATE TABLE `lich_su_duyet_nghi` (
  `id` bigint(20) NOT NULL,
  `id_nghi_phep` bigint(20) NOT NULL,
  `buoc_so` int(11) NOT NULL,
  `id_tai_khoan` bigint(20) NOT NULL,
  `hanh_dong` varchar(50) NOT NULL,
  `ghi_chu` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `loai_nghi`
--

CREATE TABLE `loai_nghi` (
  `id` bigint(20) NOT NULL,
  `ma_loai` varchar(50) DEFAULT NULL,
  `ten_loai` varchar(255) NOT NULL,
  `huong_luong` tinyint(4) DEFAULT 1,
  `co_tru_phep` tinyint(1) NOT NULL DEFAULT 0,
  `so_ngay_toi_da` decimal(5,2) DEFAULT 0.00,
  `thu_tu_cap` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `loai_nghi`
--

INSERT INTO `loai_nghi` (`id`, `ma_loai`, `ten_loai`, `huong_luong`, `co_tru_phep`, `so_ngay_toi_da`, `thu_tu_cap`) VALUES
(1, 'PN', '🏖️ Phép năm', 1, 1, NULL, 1),
(2, 'NO', '😷 Nghỉ ốm', 1, 0, 0.00, 2),
(3, 'VR', '💒 Việc riêng', 1, 0, 0.00, 3),
(4, 'KHL', '🍺 Không hưởng lương', 0, 0, 0.00, 5),
(5, 'TS', '🤰 Thai sản', 1, 0, 0.00, 4);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `luong_duyet`
--

CREATE TABLE `luong_duyet` (
  `id` bigint(20) NOT NULL,
  `module` varchar(100) NOT NULL,
  `id_chuc_vu_ap_dung` bigint(20) NOT NULL,
  `buoc_so` int(11) NOT NULL,
  `id_chuc_vu_duyet` bigint(20) NOT NULL,
  `bat_buoc` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `luong_duyet`
--

INSERT INTO `luong_duyet` (`id`, `module`, `id_chuc_vu_ap_dung`, `buoc_so`, `id_chuc_vu_duyet`, `bat_buoc`) VALUES
(14, 'leave', 1, 2, 6, 1),
(15, 'leave', 2, 1, 10, 1),
(16, 'leave', 2, 2, 6, 1),
(17, 'leave', 1, 1, 10, 1),
(18, 'leave', 3, 1, 10, 1),
(19, 'leave', 3, 2, 6, 1),
(20, 'leave', 10, 1, 6, 1),
(21, 'leave', 6, 1, 6, 0),
(22, 'leave', 5, 1, 6, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `menu_he_thong`
--

CREATE TABLE `menu_he_thong` (
  `id` bigint(20) NOT NULL,
  `id_cha` bigint(20) DEFAULT NULL,
  `ma_menu` varchar(100) DEFAULT NULL,
  `ten_menu` varchar(255) NOT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `duong_dan` varchar(255) DEFAULT NULL,
  `component` varchar(255) DEFAULT NULL,
  `thu_tu` int(11) DEFAULT 0,
  `hien_thi` tinyint(4) DEFAULT 1,
  `ma_quyen` varchar(100) DEFAULT NULL,
  `id_trang_thai` bigint(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `menu_he_thong`
--

INSERT INTO `menu_he_thong` (`id`, `id_cha`, `ma_menu`, `ten_menu`, `icon`, `duong_dan`, `component`, `thu_tu`, `hien_thi`, `ma_quyen`, `id_trang_thai`, `created_at`) VALUES
(1, NULL, 'dashboard', 'Trang chủ', 'home', '/trang-chu', NULL, 1, 1, 'dashboard.view', 11, '2026-04-28 00:23:54'),
(2, NULL, 'leave', 'Quản lý nghỉ phép', 'calendar', '/nghi-phep', NULL, 2, 1, 'leave.create', 11, '2026-04-28 00:23:54'),
(3, NULL, 'trip', 'Quản lý công tác', 'briefcase', '/cong-tac', NULL, 3, 1, 'trip.view', 11, '2026-04-28 00:23:54'),
(4, NULL, 'employee', 'Quản lý nhân viên', 'users', '/nhan-vien', NULL, 4, 1, 'employee.manage', 11, '2026-04-28 00:23:54'),
(5, NULL, 'report', 'Báo cáo tổng hợp', 'chart-bar', '/bao-cao', NULL, 5, 1, 'report.view', 11, '2026-04-28 00:23:54'),
(6, NULL, 'system', 'Cấu hình hệ thống', 'settings', NULL, NULL, 6, 1, NULL, 11, '2026-04-28 00:23:54'),
(7, 6, 'role', 'Phân quyền', 'shield-check', '/phan-quyen', NULL, 3, 1, 'role.manage', 11, '2026-04-28 00:23:54'),
(8, 6, 'account', 'Tài khoản', 'user-cog', '/tai-khoan', NULL, 2, 1, 'system.config', 11, '2026-04-28 00:23:54'),
(9, 6, 'catalog', 'Danh mục', 'list', '/danh-muc', NULL, 1, 1, 'system.config', 11, '2026-04-28 00:23:54'),
(10, 2, 'leave.apply', 'Đăng ký nghỉ phép', 'circle-fading-plus', '/dang-ky-nghi-phep', NULL, 1, 1, 'leave.apply', 11, '2026-04-30 16:48:28'),
(11, 2, 'leave.balance', 'Số dư phép năm', 'database', '/so-du-phep', NULL, 3, 1, 'leave.balance', 11, '2026-05-01 17:05:47'),
(12, 2, 'leave.approve', 'Quản lý đơn nghỉ', 'land-plot', '/duyet-don', NULL, 2, 1, 'leave.approve', 11, '2026-05-03 02:48:43'),
(13, 6, 'flow', 'Cấu hình luồng duyệt', 'cable', '/luong-duyet', NULL, 4, 1, 'flow', 11, '2026-05-10 13:28:09');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `menu_vai_tro`
--

CREATE TABLE `menu_vai_tro` (
  `id` bigint(20) NOT NULL,
  `id_menu` bigint(20) NOT NULL,
  `id_vai_tro` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `menu_vai_tro`
--

INSERT INTO `menu_vai_tro` (`id`, `id_menu`, `id_vai_tro`) VALUES
(16, 1, 14),
(58, 1, 15),
(52, 1, 16),
(59, 1, 17),
(55, 1, 18),
(51, 1, 19),
(17, 2, 14),
(36, 2, 15),
(53, 2, 16),
(39, 2, 17),
(56, 2, 18),
(31, 2, 19),
(18, 3, 14),
(19, 4, 14),
(20, 5, 14),
(61, 5, 15),
(60, 5, 17),
(62, 5, 18),
(21, 6, 14),
(22, 7, 14),
(23, 8, 14),
(24, 9, 14),
(29, 10, 14),
(37, 10, 15),
(54, 10, 16),
(40, 10, 17),
(57, 10, 18),
(32, 10, 19),
(30, 11, 14),
(38, 11, 15),
(48, 11, 16),
(41, 11, 17),
(49, 11, 18),
(50, 11, 19),
(44, 12, 14),
(43, 12, 15),
(45, 12, 16),
(42, 12, 17),
(46, 12, 18),
(47, 12, 19),
(63, 13, 14);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2019_12_14_000001_create_personal_access_tokens_table', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nghi_phep`
--

CREATE TABLE `nghi_phep` (
  `id` bigint(20) NOT NULL,
  `so_don_nghi` varchar(20) DEFAULT NULL,
  `id_nhan_vien` bigint(20) NOT NULL,
  `id_loai_nghi` bigint(20) NOT NULL,
  `buoi_tu_ngay` varchar(5) NOT NULL,
  `buoi_den_ngay` varchar(5) NOT NULL,
  `tu_ngay` date NOT NULL,
  `den_ngay` date NOT NULL,
  `so_ngay` decimal(5,2) NOT NULL,
  `ly_do` text DEFAULT NULL,
  `id_trang_thai` bigint(20) DEFAULT NULL,
  `buoc_hien_tai` int(11) DEFAULT 1,
  `id_nguoi_duyet_hien_tai` bigint(20) DEFAULT NULL,
  `nop_luc` datetime DEFAULT NULL,
  `duyet_luc` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `nghi_phep`
--

INSERT INTO `nghi_phep` (`id`, `so_don_nghi`, `id_nhan_vien`, `id_loai_nghi`, `buoi_tu_ngay`, `buoi_den_ngay`, `tu_ngay`, `den_ngay`, `so_ngay`, `ly_do`, `id_trang_thai`, `buoc_hien_tai`, `id_nguoi_duyet_hien_tai`, `nop_luc`, `duyet_luc`, `created_at`, `updated_at`) VALUES
(100, '02-2026', 58, 1, '07', '17', '2026-08-03', '2026-08-05', 3.00, 'Nghỉ phép năm giải quyết việc riêng', 5, 2, NULL, '2026-07-28 08:00:00', '2026-07-29 09:30:00', '2026-07-28 01:00:00', '2026-07-29 02:30:00'),
(101, '03-2026', 59, 2, '07', '17', '2026-08-04', '2026-08-04', 1.00, 'Khám sức khỏe định kỳ', 5, 2, NULL, '2026-08-03 16:00:00', '2026-08-04 07:30:00', '2026-08-03 09:00:00', '2026-08-04 00:30:00'),
(102, '04-2026', 61, 3, '07', '12', '2026-08-05', '2026-08-05', 0.50, 'Giải quyết công việc cá nhân buổi sáng', 4, 1, 23, '2026-08-04 09:15:00', NULL, '2026-08-04 02:15:00', '2026-08-04 02:15:00'),
(103, '05-2026', 62, 1, '07', '17', '2026-08-06', '2026-08-07', 2.00, 'Nghỉ phép năm giải quyết việc riêng', 4, 1, 23, '2026-08-04 10:00:00', NULL, '2026-08-04 03:00:00', '2026-08-04 03:00:00'),
(104, '06-2026', 63, 2, '07', '17', '2026-08-07', '2026-08-07', 1.00, 'Bị sốt siêu vi cần điều trị', 5, 2, NULL, '2026-08-06 17:00:00', '2026-08-07 07:30:00', '2026-08-06 10:00:00', '2026-08-07 00:30:00'),
(105, '07-2026', 58, 1, '07', '17', '2026-01-12', '2026-01-13', 2.00, 'Nghỉ giải quyết việc gia đình', 5, 2, NULL, '2026-01-10 09:00:00', '2026-01-11 10:00:00', '2026-01-10 02:00:00', '2026-01-11 03:00:00'),
(106, '08-2026', 60, 3, '07', '17', '2026-02-02', '2026-02-03', 2.00, 'Nghỉ chuẩn bị Tết nguyên đán', 5, 2, NULL, '2026-01-28 14:00:00', '2026-01-29 08:30:00', '2026-01-28 07:00:00', '2026-01-29 01:30:00'),
(107, '09-2026', 61, 2, '07', '17', '2026-02-16', '2026-02-17', 2.00, 'Bị cúm mùa cần điều trị tại nhà', 5, 2, NULL, '2026-02-16 07:15:00', '2026-02-16 09:00:00', '2026-02-16 00:15:00', '2026-02-16 02:00:00'),
(108, '10-2026', 65, 1, '07', '17', '2026-03-02', '2026-03-04', 3.00, 'Nghỉ phép năm đợt 1', 5, 2, NULL, '2026-02-25 08:30:00', '2026-02-26 11:00:00', '2026-02-25 01:30:00', '2026-02-26 04:00:00'),
(109, '11-2026', 66, 3, '07', '12', '2026-03-16', '2026-03-16', 0.50, 'Đi làm thủ tục giấy tờ cá nhân', 5, 2, NULL, '2026-03-15 16:00:00', '2026-03-16 07:30:00', '2026-03-15 09:00:00', '2026-03-16 00:30:00'),
(110, '12-2026', 67, 1, '07', '17', '2026-04-06', '2026-04-07', 2.00, 'Nghỉ giỗ tổ gia đình', 5, 2, NULL, '2026-04-02 10:00:00', '2026-04-03 14:00:00', '2026-04-02 03:00:00', '2026-04-03 07:00:00'),
(111, '13-2026', 72, 2, '07', '17', '2026-04-20', '2026-04-22', 3.00, 'Điều trị chấn thương chân', 5, 2, NULL, '2026-04-20 08:00:00', '2026-04-20 10:30:00', '2026-04-20 01:00:00', '2026-04-20 03:30:00'),
(112, '14-2026', 73, 1, '07', '17', '2026-05-11', '2026-05-13', 3.00, 'Nghỉ phép năm gia đình', 5, 2, NULL, '2026-05-05 09:00:00', '2026-05-06 15:00:00', '2026-05-05 02:00:00', '2026-05-06 08:00:00'),
(113, '15-2026', 74, 1, '07', '17', '2026-05-18', '2026-05-20', 3.00, 'Nghỉ phép cá nhân đi du lịch', 5, 2, NULL, '2026-05-12 11:00:00', '2026-05-13 09:00:00', '2026-05-12 04:00:00', '2026-05-13 02:00:00'),
(114, '16-2026', 75, 4, '07', '17', '2026-06-01', '2026-06-05', 5.00, 'Việc gia đình không hưởng lương', 5, 2, NULL, '2026-05-25 14:00:00', '2026-05-26 10:00:00', '2026-05-25 07:00:00', '2026-05-26 03:00:00'),
(115, '17-2026', 76, 2, '07', '17', '2026-06-15', '2026-06-16', 2.00, 'Sốt đau mắt đỏ', 5, 2, NULL, '2026-06-15 07:00:00', '2026-06-15 08:30:00', '2026-06-15 00:00:00', '2026-06-15 01:30:00'),
(116, '18-2026', 77, 1, '07', '17', '2026-07-06', '2026-07-08', 3.00, 'Nghỉ phép đi tham quan', 5, 2, NULL, '2026-07-01 09:30:00', '2026-07-02 11:00:00', '2026-07-01 02:30:00', '2026-07-02 04:00:00'),
(117, '19-2026', 78, 3, '13', '17', '2026-07-20', '2026-07-20', 0.50, 'Đi đám cưới bạn thân', 5, 2, NULL, '2026-07-19 15:00:00', '2026-07-20 07:30:00', '2026-07-19 08:00:00', '2026-07-20 00:30:00'),
(118, '20-2026', 79, 1, '07', '17', '2026-09-07', '2026-09-09', 3.00, 'Nghỉ phép sau đợt công tác dài', 4, 1, 43, '2026-09-01 08:00:00', NULL, '2026-09-01 01:00:00', '2026-09-01 01:00:00'),
(119, '21-2026', 80, 2, '07', '17', '2026-09-21', '2026-09-22', 2.00, 'Nghỉ ốm điều trị tại nhà', 4, 1, 43, '2026-09-21 07:00:00', NULL, '2026-09-21 00:00:00', '2026-09-21 00:00:00'),
(120, '22-2026', 81, 1, '07', '17', '2026-10-05', '2026-10-06', 2.00, 'Nghỉ phép năm cá nhân', 4, 1, 43, '2026-09-30 10:00:00', NULL, '2026-09-30 03:00:00', '2026-09-30 03:00:00'),
(121, '23-2026', 82, 3, '07', '17', '2026-10-19', '2026-10-19', 1.00, 'Sửa chữa nhà cửa', 4, 1, 43, '2026-10-18 14:00:00', NULL, '2026-10-18 07:00:00', '2026-10-18 07:00:00'),
(122, '24-2026', 83, 1, '07', '17', '2026-11-09', '2026-11-11', 3.00, 'Nghỉ phép giải quyết công việc', 4, 1, 43, '2026-11-04 09:00:00', NULL, '2026-11-04 02:00:00', '2026-11-04 02:00:00'),
(123, '25-2026', 84, 2, '07', '17', '2026-11-23', '2026-11-23', 1.00, 'Nghỉ do nhức răng đi khám điều trị', 4, 1, 43, '2026-11-23 07:30:00', NULL, '2026-11-23 00:30:00', '2026-11-23 00:30:00'),
(124, '26-2026', 85, 1, '07', '17', '2026-12-14', '2026-12-18', 5.00, 'Nghỉ hết số phép còn lại trong năm', 4, 1, 43, '2026-12-08 08:30:00', NULL, '2026-12-08 01:30:00', '2026-12-08 01:30:00'),
(125, '27-2026', 64, 1, '07', '17', '2026-12-21', '2026-12-23', 3.00, 'Nghỉ phép gia đình', 4, 1, 23, '2026-12-15 10:00:00', NULL, '2026-12-15 03:00:00', '2026-12-15 03:00:00'),
(126, '28-2026', 68, 2, '07', '17', '2026-09-14', '2026-09-15', 2.00, 'Khám sức khỏe tổng quát', 5, 2, NULL, '2026-09-13 14:00:00', '2026-09-14 07:30:00', '2026-09-13 07:00:00', '2026-09-14 00:30:00'),
(127, '29-2026', 69, 3, '07', '17', '2026-10-12', '2026-10-12', 1.00, 'Giải quyết việc gia đình', 5, 2, NULL, '2026-10-10 08:00:00', '2026-10-11 15:00:00', '2026-10-10 01:00:00', '2026-10-11 08:00:00'),
(128, '30-2026', 70, 1, '07', '17', '2026-11-16', '2026-11-17', 2.00, 'Nghỉ phép cá nhân', 4, 1, 31, '2026-11-10 09:00:00', NULL, '2026-11-10 02:00:00', '2026-11-10 02:00:00'),
(129, '31-2026', 71, 2, '07', '17', '2026-12-01', '2026-12-02', 2.00, 'Nghỉ ốm điều trị', 5, 2, NULL, '2026-12-01 07:00:00', '2026-12-01 08:30:00', '2026-12-01 00:00:00', '2026-12-01 01:30:00');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nhan_vien`
--

CREATE TABLE `nhan_vien` (
  `id` bigint(20) NOT NULL,
  `ma_nhan_vien` varchar(50) DEFAULT NULL,
  `ho_ten` varchar(255) NOT NULL,
  `ngay_sinh` date DEFAULT NULL,
  `gioi_tinh` enum('Nam','Nu','Khac') DEFAULT 'Nam',
  `email` varchar(255) DEFAULT NULL,
  `so_dien_thoai` varchar(20) DEFAULT NULL,
  `dia_chi` text DEFAULT NULL,
  `id_phong_ban` bigint(20) NOT NULL,
  `id_chuc_vu` bigint(20) NOT NULL,
  `id_cap_tren` bigint(20) DEFAULT NULL,
  `ngay_vao_lam` date DEFAULT NULL,
  `ngay_nghi_viec` date DEFAULT NULL,
  `id_trang_thai` bigint(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  `anh_dai_dien` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `nhan_vien`
--

INSERT INTO `nhan_vien` (`id`, `ma_nhan_vien`, `ho_ten`, `ngay_sinh`, `gioi_tinh`, `email`, `so_dien_thoai`, `dia_chi`, `id_phong_ban`, `id_chuc_vu`, `id_cap_tren`, `ngay_vao_lam`, `ngay_nghi_viec`, `id_trang_thai`, `created_at`, `updated_at`, `deleted_at`, `anh_dai_dien`) VALUES
(54, 'dvan.cma', 'Đào Văn An', '1972-01-01', 'Nam', 'dvan.cma@gdt.gov.vn', NULL, NULL, 1, 6, NULL, '1991-05-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(55, 'tttrang.cma', 'Trần Thùy Trang', '1976-08-23', 'Nu', 'tttrang.cma@gdt.gov.vn', NULL, NULL, 1, 5, NULL, '2012-12-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(56, 'tmthuong.cma', 'Trương Mỹ Thương', '1985-10-14', 'Nu', 'tmthuong.cma@gdt.gov.vn', NULL, NULL, 2, 10, NULL, '2009-09-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(57, 'clhung.cma', 'Chung Long Hưng', '1978-10-06', 'Nam', 'clhung.cma@gdt.gov.vn', NULL, NULL, 2, 3, NULL, '1996-12-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-10 09:34:45', NULL, NULL),
(58, 'mctien.cma', 'Mã Chí Tiến', '2000-07-20', 'Nam', 'mctien.cma@gdt.gov.vn', NULL, NULL, 2, 2, NULL, '2024-10-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(59, 'nqtuong.cma', 'Nguyễn Quốc Tưởng', '1992-03-01', 'Nam', 'nqtuong.cma@gdt.gov.vn', NULL, NULL, 2, 2, NULL, '2024-10-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(60, 'tmtri.cma', 'Trịnh Minh Trí', '1996-02-24', 'Nam', 'tmtri.cma@gdt.gov.vn', NULL, NULL, 2, 2, NULL, '2024-10-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-10 09:34:26', NULL, 'avatars/q4IPWaYIGeZ6FahnodCESwznma922llK4uJo4kxY.jpg'),
(61, 'mtaloc.cma', 'Mã Thị An Lộc', '1990-10-30', 'Nu', 'mtaloc.cma@gdt.gov.vn', NULL, NULL, 2, 2, NULL, '2021-07-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(62, 'pnngan.cma', 'Phạm Ngọc Ngân', '1990-11-29', 'Nu', 'pnngan.cma@gdt.gov.vn', NULL, NULL, 2, 2, NULL, '2021-07-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(63, 'tdttvi.cma', 'Trần Đoàn Thanh Vị', '1988-10-22', 'Nam', 'tdtvi.cma@gdt.gov.vn', NULL, NULL, 2, 2, NULL, '2013-07-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(64, 'ttvu.cma', 'Thái Trường Vũ', '1975-03-05', 'Nam', 'ttvu.cma@gdt.gov.vn', NULL, NULL, 2, 2, NULL, '1994-01-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(65, 'hqhung.cma', 'Huỳnh Quốc Hưng', '1974-12-20', 'Nam', 'hqhung.cma@gdt.gov.vn', NULL, NULL, 5, 10, NULL, '1994-10-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(66, 'dqdat.cma', 'Đinh Quốc Đạt', '1975-10-25', 'Nam', 'dqdat.cma@gdt.gov.vn', NULL, NULL, 5, 3, NULL, '1995-12-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(67, 'tqtuan.cma', 'Trịnh Quốc Tuấn', '1979-08-17', 'Nam', 'tqtuan.cma@gdt.gov.vn', NULL, NULL, 4, 3, NULL, '2001-05-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(68, 'thhue.cma', 'Thái Hồng Huệ', '1988-05-26', 'Nu', 'thhhue.cma@gdt.gov.vn', NULL, NULL, 5, 2, NULL, '2021-07-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(69, 'ntvanh.cma', 'Nguyễn Thị Vân Anh', '1984-10-10', 'Nu', 'ntvanh.cma@gdt.gov.vn', NULL, NULL, 4, 2, NULL, '2004-10-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-09 18:53:13', NULL, NULL),
(70, 'tccuong.cma', 'Trần Chí Cường', '1991-08-06', 'Nam', 'tccuong.cma@gdt.gov.vn', NULL, NULL, 4, 2, NULL, '2023-06-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(71, 'ntduy.cma', 'Nguyễn Thúy Duy', '2001-01-01', 'Nu', 'ntduy.cma@gdt.gov.vn', NULL, NULL, 5, 2, NULL, '2024-02-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-09 18:53:47', NULL, NULL),
(72, 'dvpha.cma', 'Dương Văn Pha', '1971-02-28', 'Nam', 'dvpha.cma@gdt.gov.vn', NULL, NULL, 4, 10, NULL, '2009-07-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(73, 'lthien.cma', 'Lâm Thanh Hiền', '1980-09-01', 'Nu', 'lthien.cma@gdt.gov.vn', NULL, NULL, 4, 3, NULL, '2004-10-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(74, 'lvtoan.cma', 'Lâm Văn Toàn', '1979-09-27', 'Nam', 'lvtoan.cma@gdt.gov.vn', NULL, NULL, 4, 2, NULL, '2008-03-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(75, 'pnlai.cma', 'Phạm Ngọc Lài', '1986-07-01', 'Nu', 'pnlai.cma@gdt.gov.vn', NULL, NULL, 5, 2, NULL, '2024-02-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(76, 'tgphung.cma', 'Trần Giang Phụng', '1996-07-20', 'Nu', 'tgphung.cma@gdt.gov.vn', NULL, NULL, 4, 2, NULL, '2022-06-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(77, 'nptung.cma', 'Nguyễn Phương Tùng', '1990-01-08', 'Nam', 'nptung.cma@gdt.gov.vn', NULL, NULL, 4, 2, NULL, '2018-04-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(78, 'lththao.cma', 'Lê Thị Hiếu Thảo', '1982-03-29', 'Nu', 'lththao.cma@gdt.gov.vn', NULL, NULL, 5, 2, NULL, '2006-11-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(79, 'dnvien.cma', 'Đoàn Ngọc Viễn', '1978-04-12', 'Nam', 'dnvien.cma@gdt.gov.vn', NULL, NULL, 3, 10, NULL, '1999-11-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-09 18:55:02', NULL, NULL),
(80, 'lvmun.cma', 'Lê Văn Mun', '1980-05-20', 'Nam', 'lvmun.cma@gdt.gov.vn', NULL, NULL, 3, 3, NULL, '2006-03-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(81, 'ttduy.cma', 'Thái Trường Duy', '1979-11-09', 'Nam', 'ttduy.cma@gdt.gov.vn', NULL, NULL, 3, 3, NULL, '2004-10-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(82, 'lhthi.cma', 'Lâm Hoàng Thi', '1984-09-17', 'Nam', 'lhthi.cma@gdt.gov.vn', NULL, NULL, 3, 2, NULL, '2008-02-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(83, 'ctkhue.cma', 'Chiêm Thị Kim Huê', '1990-08-31', 'Nu', 'ctkhue.cma@gdt.gov.vn', NULL, NULL, 3, 2, NULL, '2013-07-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(84, 'pbha.cma', 'Phan Bích Hà', '1988-07-01', 'Nu', 'pbha.cma@gdt.gov.vn', NULL, NULL, 3, 2, NULL, '2014-07-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(85, 'pttthuy.cma', 'Phạm Thị Thu Thủy', '1984-03-23', 'Nu', 'pttthuy.cma@gdt.gov.vn', NULL, NULL, 3, 2, NULL, '2005-08-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(86, 'tbthuy.cma', 'Trần Bé Thúy', '1990-08-10', 'Nu', 'tbthuy.cma@gdt.gov.vn', NULL, NULL, 3, 2, NULL, '2013-07-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(87, 'tttlam.cma', 'Trần Thị Thùy Lam', '1984-03-22', 'Nu', 'tttlam.cma@gdt.gov.vn', NULL, NULL, 3, 2, NULL, '2009-08-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(88, 'vtlinh.cma', 'Võ Thị Lịnh', '1985-04-12', 'Nu', NULL, NULL, NULL, 2, 1, NULL, '2008-12-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(89, 'ptmlinh.cma', 'Phạm Thị Mỹ Linh', '1991-02-28', 'Nu', NULL, NULL, NULL, 2, 1, NULL, '2011-08-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(90, 'ntmduyen.cma', 'Nguyễn Thị Mỹ Duyên', '1975-04-01', 'Nu', NULL, NULL, NULL, 2, 1, NULL, '2006-03-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(91, 'nthue.cma', 'Nguyễn Thị Huệ', '1983-01-01', 'Nu', NULL, NULL, NULL, 2, 1, NULL, '2005-10-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(92, 'nmtruong.cma', 'Nguyễn Minh Trường', '1983-06-08', 'Nam', NULL, NULL, NULL, 2, 1, NULL, '2008-07-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL),
(93, 'qpminh.cma', 'Quách Phương Minh', '1980-03-13', 'Nam', NULL, NULL, NULL, 2, 1, NULL, '2007-07-01', NULL, 1, '2026-05-07 17:26:55', '2026-05-07 17:26:55', NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nhat_ky_he_thong`
--

CREATE TABLE `nhat_ky_he_thong` (
  `id` bigint(20) NOT NULL,
  `id_tai_khoan` bigint(20) DEFAULT NULL,
  `module` varchar(100) DEFAULT NULL,
  `hanh_dong` varchar(100) DEFAULT NULL,
  `id_ban_ghi` bigint(20) DEFAULT NULL,
  `du_lieu_cu` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`du_lieu_cu`)),
  `du_lieu_moi` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`du_lieu_moi`)),
  `ip` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `noi_den_cong_tac`
--

CREATE TABLE `noi_den_cong_tac` (
  `id` bigint(20) NOT NULL,
  `id_cong_tac` bigint(20) NOT NULL COMMENT 'ID giấy đi đường',
  `noi_den` varchar(255) NOT NULL COMMENT 'Địa chỉ nơi đến',
  `dia_chi` varchar(500) NOT NULL,
  `vi_do` decimal(10,8) DEFAULT NULL COMMENT 'Vĩ độ',
  `kinh_do` decimal(11,8) DEFAULT NULL COMMENT 'Kinh độ',
  `khoang_cach_km` decimal(10,2) DEFAULT NULL COMMENT 'Khoảng cách từ điểm xuất phát (km)',
  `thoi_gian_phut` int(11) DEFAULT NULL COMMENT 'Thời gian di chuyển (phút)',
  `thu_tu` int(11) DEFAULT 0 COMMENT 'Thứ tự các nơi đến trong chuyến công tác',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Bảng lưu nhiều nơi đến cho giấy đi đường';

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(161, 'App\\Models\\TaiKhoan', 16, 'auth_token', '51dc7034df4bf942d1758e900b74390f24ee8f8e5c64c1efd556fe13fce9ca8e', '[\"*\"]', '2026-05-11 01:36:03', NULL, '2026-05-11 00:02:50', '2026-05-11 01:36:03'),
(162, 'App\\Models\\TaiKhoan', 24, 'auth_token', 'ebf69ff44d2131ce042e351df2ab2f1b250dd5d95d34f5233fcca8434323b7f8', '[\"*\"]', '2026-05-11 00:18:33', NULL, '2026-05-11 00:15:44', '2026-05-11 00:18:33'),
(163, 'App\\Models\\TaiKhoan', 16, 'auth_token', '92fb64fd6e8c1e2644de92738bdd8c7680991c0bc596c809262029f8007c389c', '[\"*\"]', '2026-05-11 00:43:04', NULL, '2026-05-11 00:41:05', '2026-05-11 00:43:04'),
(164, 'App\\Models\\TaiKhoan', 16, 'auth_token', 'a159aa9a9418b0dc8c5ed2de8fcbf3e598b5664feb99cf0b29237cc59c71bea4', '[\"*\"]', '2026-05-11 00:46:09', NULL, '2026-05-11 00:43:12', '2026-05-11 00:46:09'),
(165, 'App\\Models\\TaiKhoan', 16, 'auth_token', '5bdcf12b37abb613b712bb2682cd52cfe60a3817d43b6cabd7f69872476355fd', '[\"*\"]', '2026-08-04 21:32:32', NULL, '2026-08-04 20:45:31', '2026-08-04 21:32:32'),
(166, 'App\\Models\\TaiKhoan', 16, 'auth_token', 'a819be83c6806e90f1c53f0b752b6e90670f86b61f168a341c3c4acfbabdaa78', '[\"*\"]', '2026-08-10 02:52:40', NULL, '2026-08-09 23:58:49', '2026-08-10 02:52:40'),
(167, 'App\\Models\\TaiKhoan', 16, 'auth_token', '63477a642be0f54f4d764a0233b9f8ceeb1995179a85b7006973be01158dabc3', '[\"*\"]', '2026-08-10 01:50:17', NULL, '2026-08-10 00:59:04', '2026-08-10 01:50:17');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `phan_quyen_vai_tro`
--

CREATE TABLE `phan_quyen_vai_tro` (
  `id` bigint(20) NOT NULL,
  `id_vai_tro` bigint(20) NOT NULL,
  `id_quyen` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `phan_quyen_vai_tro`
--

INSERT INTO `phan_quyen_vai_tro` (`id`, `id_vai_tro`, `id_quyen`) VALUES
(74, 14, 44),
(86, 14, 45),
(82, 14, 46),
(85, 14, 47),
(83, 14, 48),
(81, 14, 49),
(99, 14, 51),
(95, 14, 52),
(98, 14, 53),
(96, 14, 54),
(97, 14, 55),
(80, 14, 56),
(75, 14, 57),
(79, 14, 58),
(76, 14, 59),
(78, 14, 60),
(77, 14, 61),
(73, 14, 62),
(70, 14, 63),
(72, 14, 64),
(71, 14, 65),
(88, 14, 66),
(87, 14, 67),
(94, 14, 68),
(93, 14, 69),
(90, 14, 70),
(92, 14, 71),
(91, 14, 72),
(89, 14, 73),
(69, 14, 74),
(66, 14, 75),
(68, 14, 76),
(67, 14, 77),
(108, 14, 78),
(103, 14, 79),
(104, 14, 80),
(102, 14, 81);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `phien_dang_nhap`
--

CREATE TABLE `phien_dang_nhap` (
  `id` bigint(20) NOT NULL,
  `id_tai_khoan` bigint(20) NOT NULL,
  `token` varchar(255) NOT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `thiet_bi` varchar(255) DEFAULT NULL,
  `het_han_luc` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `phong_ban`
--

CREATE TABLE `phong_ban` (
  `id` bigint(20) NOT NULL,
  `ma_phong` varchar(50) DEFAULT NULL,
  `ten_phong` varchar(255) NOT NULL,
  `ten_tat` varchar(100) NOT NULL,
  `id_phong_cha` bigint(20) DEFAULT NULL,
  `thu_tu_cap` int(11) DEFAULT 1,
  `id_trang_thai` bigint(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `phong_ban`
--

INSERT INTO `phong_ban` (`id`, `ma_phong`, `ten_phong`, `ten_tat`, `id_phong_cha`, `thu_tu_cap`, `id_trang_thai`, `created_at`, `updated_at`) VALUES
(1, 'BLĐ', 'Ban Lãnh đạo', 'BLĐ', NULL, 1, NULL, '2026-04-29 07:43:31', '2026-04-29 07:43:31'),
(2, 'NVDPC', 'Tổ Nghiệp vụ, dự toán, pháp chế', 'Tổ NVDPC', NULL, 2, NULL, '2026-04-29 07:47:53', '2026-04-29 07:47:53'),
(3, 'QLHTDN', 'Tổ Quản lý, hỗ trợ doanh nghiệp', 'Tổ QLHTDN', NULL, 3, NULL, '2026-04-29 07:48:40', '2026-04-29 07:48:40'),
(4, 'QLHTCNHKD', 'Tổ Quản lý, hỗ trợ cá nhân, hộ kinh doanh', 'Tổ QLHTCNHKD', NULL, 4, NULL, '2026-04-29 07:49:22', '2026-04-29 07:50:45'),
(5, 'QLCKTK', 'Tổ Quản lý các khoản thu khác', 'Tổ QLCKTK', NULL, 5, NULL, '2026-04-29 07:50:18', '2026-04-29 07:50:18');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `qlsk_diem`
--

CREATE TABLE `qlsk_diem` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `phan_cong_cham_id` bigint(20) UNSIGNED NOT NULL,
  `diem` decimal(4,2) NOT NULL,
  `nhan_xet` text DEFAULT NULL,
  `ngay_cham` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `version` int(10) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `qlsk_file`
--

CREATE TABLE `qlsk_file` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sang_kien_id` bigint(20) UNSIGNED NOT NULL,
  `loai_file` enum('MAU_01','MAU_05','MAU_06','MINH_CHUNG') NOT NULL,
  `ten_file` varchar(255) NOT NULL,
  `ten_file_luu` varchar(255) NOT NULL,
  `duong_dan` varchar(500) NOT NULL,
  `dinh_dang` varchar(20) DEFAULT NULL,
  `mime_type` varchar(100) DEFAULT NULL,
  `kich_thuoc` bigint(20) UNSIGNED DEFAULT NULL,
  `ghi_chu` varchar(500) DEFAULT NULL,
  `ngay_tai_len` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `qlsk_file`
--

INSERT INTO `qlsk_file` (`id`, `sang_kien_id`, `loai_file`, `ten_file`, `ten_file_luu`, `duong_dan`, `dinh_dang`, `mime_type`, `kich_thuoc`, `ghi_chu`, `ngay_tai_len`) VALUES
(14, 23, 'MAU_05', '1.SK-TCCB-001.docx', '6e815b49c202dfe661158a12dc562db0.docx', 'storage/sang-kien/23/6e815b49c202dfe661158a12dc562db0.docx', 'docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 107329, NULL, '2026-09-21 13:51:55'),
(15, 24, 'MAU_05', '2.SK-TCCB-002.docx', '4b90ed1fa9381fb8d01ccdc96b7d2f4d.docx', 'storage/sang-kien/24/4b90ed1fa9381fb8d01ccdc96b7d2f4d.docx', 'docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 38332, NULL, '2026-09-21 13:52:50'),
(21, 27, 'MAU_05', '3.SK-TCCB-003.docx', '035c8d025e62e50a13497243e1f401bc.docx', 'storage/sang-kien/27/035c8d025e62e50a13497243e1f401bc.docx', 'docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 37740, NULL, '2026-09-21 16:06:22');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `qlsk_file_noi_dung`
--

CREATE TABLE `qlsk_file_noi_dung` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `file_id` bigint(20) UNSIGNED NOT NULL,
  `sang_kien_id` bigint(20) UNSIGNED NOT NULL,
  `noi_dung` longtext DEFAULT NULL,
  `noi_dung_html` longtext DEFAULT NULL,
  `hash_noi_dung` char(64) DEFAULT NULL,
  `ngay_trich_xuat` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `qlsk_file_noi_dung`
--

INSERT INTO `qlsk_file_noi_dung` (`id`, `file_id`, `sang_kien_id`, `noi_dung`, `noi_dung_html`, `hash_noi_dung`, `ngay_trich_xuat`) VALUES
(2, 14, 23, 'BÁO CÁO MÔ TẢ SÁNG KIẾN\n1. Tên sáng kiến (thể hiện được bản chất của giải pháp): Kỹ năng xây dựng phương án giao biên chế cho các đơn vị”.\n2. Họ và tên nhóm tác giả sáng kiến, chức danh, trình độ chuyên môn:\n3. Lĩnh vực áp dụng: Tổ chức cán bộ.\n4. Mô tả sáng kiến:\na. Khái quát đặc điểm, tình hình trước khi có sáng kiến.\n- Việc quản lý, bố trí biên chế bảo đảm phù hợp với chức năng, nhiệm vụ, quyền hạn và cơ cấu tổ chức của cơ quan, tổ chức, đơn vị; yêu cầu của vị trí việc làm, cải cách hành chính gắn với tinh giản biên chế và cơ cấu lại, nâng cao chất lượng đội ngũ, bảo đảm tinh, gọn, hiệu năng, hiệu lực, hiệu quả. Những năm trước khi có sáng kiến, việc xây dựng và triển khai giao biên chế dựa vào báo cáo của các đơn vị về nhu cầu biên chế, khối lượng công việc. Các đơn vị đa phần đều báo cáo biên chế tại đơn vị thiếu nhiều. Thuế tỉnh chưa có đủ cơ sở khoa học để phân bổ biên chế về các đơn vị đảm bảo đúng nhu cầu thực tế. Về biên chế ở các đơn vị hiện nay đa phần đều thiếu so với số được Cục Thuế giao, tuy nhiên cần phải xác định lại đơn vị nào thiếu biên chế nhiều hơn để phân bổ, vì nguồn lực có hạn nên việc phân bổ cần phải cân nhắc để đảm bảo đủ người làm việc cho các đơn vị trong tình hình thiếu nhân sự toàn tỉnh. Nhận thấy việc tìm ra các giải pháp, quy trình để xác định đúng đơn vị thật sự đang thiếu nhiều biên chế so với các đơn vị thiếu còn lại để có phương án giao và có kế hoạch điều động nhân sự cho đơn vị kịp thời.\n- Với lý do trên, tác giả đã nghiên cứu văn bản, vận dụng kinh nghiệm thực tiễn để đưa ra sáng kiến “Kỹ năng xây dựng phương án giao biên chế cho các đơn vị” góp phần xây dựng phương án giao biên chế sát với thực tế, triển khai có hiệu lực hiệu quả trong công việc; kịp thời có kế hoạch điều động, bố trí nhân sự tại các đơn vị giúp hoàn thành tốt các nhiệm vụ chính trị được cấp trên giao.\nb. Nội dung sáng kiến.\n- Việc thực hiện giao và theo dõi, kiểm soát biên chế tại các đơn vị là quy định bắt buộc, phải thực hiện thường xuyên theo đúng quy định của Đảng, nhà nước và của ngành. Hàng năm, trong Quý I cấp trên đều có quyết định giao số lượng biên chế. Căn cứ vào số biên chế được giao, Thuế tỉnh lập phương án giao biên chế lại cho các đơn vị thuộc Thuế tỉnh nhằm kiểm soát biên chế và điều động nhân sự bổ sung cho nơi thiếu. Nhận thấy được tầm quan trọng và thực trạng tại cơ quan, Nhóm tác giả đã có sáng kiến đưa ra các giải pháp thực hiện trọng tâm để có cơ sở phân tích, giao biên chế sát với nhu cầu của các đơn vị, là tiền đề, cơ sở để xây dựng Kế hoạch luân chuyển, điều động để kịp thời bổ sung nguồn nhân lực cho các đơn vị đang thiếu.\n- Chi tiết về các chỉ tiêu làm cơ sở trong phương án giao biên chế như sau:\n+ Số công chức của đơn vị hiện tại.\n+ Số thu của đơn vị được giao trong năm.\n+ Số cuộc kiểm tra được giao trong năm.\n+ Số lượng Tổ chức, doanh nghiệp đang quản lý (bao gồm: Doanh nghiệp và Hợp tác xã, tổ chức khác).\n+ Số lượng Hộ kinh doanh đang quản lý tính đến thời điểm hiện tại (bao gồm Hộ trên ngưỡng nộp thuế và Hộ dưới ngưỡng nộp thuế).\nTừ các số liệu trên sẽ tính toán được:\n+ Trung bình số lượng Doanh nghiệp mà các Phòng Quản lý, hỗ trợ doanh nghiệp, các Thuế cơ sở đang quản lý, so sánh đơn vị nào đang quản lý nhiều doanh nghiệp hơn, đang có số thu được giao cao hơn so với số trung bình để có cơ sở giao biên chế tăng hoặc giảm, từ đó là cơ sở để có kế hoạch điều động công chức về phân bổ cho các đơn vị.\n+ Trung bình số cuộc kiểm tra mà các Phòng Kiểm tra, các Thuế cơ sở được giao để so sánh xem đơn vị nào có số lượng cuộc kiểm tra được giao nhiều hơn so với số trung bình từ đó có cơ sở tăng hoặc giảm biên chế và là cơ sở để có kế hoạch điều động công chức về phân bổ cho các đơn vị.\n+ Trung bình số lượng Doanh nghiệp, hộ kinh doanh mà các Thuế cơ sở đang quản lý; Trung bình số cuộc kiểm tra được giao; Trung bình số thu/công chức đang đảm nhiệm từ đó có cơ sở giao biên chế tăng hoặc giảm và là cơ sở để có kế hoạch điều động công chức về phân bổ cho các đơn vị.\n- Dựa vào các dữ liệu thu thập được từ báo cáo của các Phòng, các Thuế cơ sở. Bộ phận tổ chức cán bộ lập bảng so sánh về các tiêu chí giữa các Phòng cùng chức năng, nhiệm vụ; so sánh giữa các Thuế cơ sở; so sánh giữa các Phòng và các Thuế cơ sở để đề xuất Lãnh đạo giao biên chế cho các đơn vị sát với thực tế. Việc giao biên chế hàng năm, Cục Thuế đều giao năm hiện tại thấp hơn năm trước liền kề. Sau sắp xếp có nhiều công chức xin nghỉ hưởng chế độ, chính sách dẫn đến biên chế tại các đơn vị thiếu nhiều. Việc bổ sung biên chế chỉ có khi Cục Thuế tổ chức tuyển dụng. Việc tuyển dụng diễn ra cần quy trình và thời gian khá lâu, trong khi nhu cầu công việc cấp bách. Do đó, Thuế tỉnh chỉ có cách cân đối nguồn lực hiện có, phân bổ biên chế ở nơi thiếu ít sang nơi thiếu nhiều để đảm bảo công việc.\n- Việc rà soát có cơ sở khoa học để đề xuất tăng giảm biên chế tại các đơn vị dựa vào nguồn lực hiện có để đảm bảo các đơn vị hoàn thành nhiệm vụ được giao.\nTính mới của sáng kiến\n- Tránh được tình trạng giao biên chế cảm tính theo báo cáo của các đơn vị.\n- Đảm bảo việc giao biên chế theo nguyên tắc khoa học, hợp lý và phát huy trách nhiệm, quyền hạn của người đứng đầu đơn vị; dựa vào các yêu cầu công tác, vị trí việc làm, quy mô quản lý, thực trạng tại đơn vị để bổ sung biên chế nhằm nâng cao chất lượng và hiệu quả hoạt động của cơ quan.\n- Giúp tiết kiệm thời gian và chủ động trong công tác giao biên chế hàng năm. Là cơ sở để xác định nhu cầu biên chế của toàn tỉnh, xác định nhu cầu biên chế trống để có cơ sở đề xuất phân bổ chỉ tiêu tuyển dụng công chức và chỉ tiêu giao biên chế cho năm sau.\nc. Hiệu quả và phạm vi áp dụng của sáng kiến, giải pháp\nKể từ khi áp dụng sáng kiến từ 24/3/2025 đến nay đã giúp:\n- Khắc phục được một hạn chế đang tồn tại lâu nay là giao biên chế theo báo cáo của đơn vị (các đơn vị đều báo cáo thiếu biên chế, xin thêm người về đơn vị mình). Nhằm tăng cường tính chủ động và hiệu quả trong quản lý, sử dụng công chức, xây dựng cơ cấu đội ngũ công chức hợp lý; tăng cường nhân sự cho các đơn vị có khó khăn về công tác nhân sự; để sắp xếp, kiện toàn tổ chức, bộ máy. Kịp thời chủ động phân bổ nhân sự cho các nơi thật sự thiếu nhiều trong tình hình chung các đơn vị đều thiếu, phân bổ ở nơi thiếu ít về nơi thiếu nhiều dựa vào nguồn lực hiện có.\n- Đối với cấp Thuế tỉnh: Giúp Lãnh đạo có cái nhìn tổng quan, phân tích trên cơ sở khoa học, khách quan khi xây dựng phương án giao biên chế. Tiết kiệm được thời gian khi phải rà soát chi tiết từng đơn vị. Kịp thời, chủ động trong công tác thực hiện các quy trình điều động, bổ sung từ các đơn vị thừa nhân sự sang các đơn vị thiếu để thực hiện tốt nhiệm vụ chính trị được giao.\n- Đối với cấp Thuế cơ sở: Từ bộ tiêu chí xây dựng như trên đã triển khai, hướng dẫn giúp Thuế cơ sở có cơ sở khoa học khi tự rà soát xây dựng phương án giao biên chế hàng năm sát với thực tế, đúng theo yêu cầu công việc tại các Tổ, đảm bảo khoa học, minh bạch, hợp lý, đặc biệt tiết kiệm thời gian trong việc rà soát, tham mưu với Lãnh đạo. Trên cơ sở khoa học, rút ngắn thời gian từ đó phương án được phê duyệt sớm, đảm bảo được việc triển khai thực hiện điều động, chuyển đổi vị trí công tác kịp thời.\nPhạm vi ảnh hưởng, khả năng nhân rộng của sáng kiến: Có hiệu quả áp dụng, phạm vi ảnh hưởng và khả năng nhân rộng tại cấp Thuế tỉnh và cấp Bộ Tài chính.\n5. Hội đồng cơ sở đã xét công nhận sáng kiến: Quyết định số 1109/QĐ-CMA ngày 23 tháng 10 năm 2025 của Trưởng Thuế tỉnh Cà Mau.\n6. Thời gian áp dụng: Từ 24/3/2025 đến nay.\nCà Mau, ngày 27 tháng 10 năm 2025\nTRƯỞNG THUẾ TỈNH NGƯỜI NỘP ĐƠN\nLê Văn Sơn Đỗ Thanh Thảo\nĐỒNG TÁC GIẢ SÁNG KIẾN\nTrần Ty Na Phạm Nhật Trường', '<p>BÁO CÁO MÔ TẢ SÁNG KIẾN</p><p>1. Tên sáng kiến (thể hiện được bản chất của giải pháp): Kỹ năng xây dựng phương án giao biên chế cho các đơn vị”.</p><p>2. Họ và tên nhóm tác giả sáng kiến, chức danh, trình độ chuyên môn:</p><p>3. Lĩnh vực áp dụng: Tổ chức cán bộ.</p><p>4. Mô tả sáng kiến:</p><p>a. Khái quát đặc điểm, tình hình trước khi có sáng kiến.</p><p>- Việc quản lý, bố trí biên chế bảo đảm phù hợp với chức năng, nhiệm vụ, quyền hạn và cơ cấu tổ chức của cơ quan, tổ chức, đơn vị; yêu cầu của vị trí việc làm, cải cách hành chính gắn với tinh giản biên chế và cơ cấu lại, nâng cao chất lượng đội ngũ, bảo đảm tinh, gọn, hiệu năng, hiệu lực, hiệu quả. Những năm trước khi có sáng kiến, việc xây dựng và triển khai giao biên chế dựa vào báo cáo của các đơn vị về nhu cầu biên chế, khối lượng công việc. Các đơn vị đa phần đều báo cáo biên chế tại đơn vị thiếu nhiều. Thuế tỉnh chưa có đủ cơ sở khoa học để phân bổ biên chế về các đơn vị đảm bảo đúng nhu cầu thực tế. Về biên chế ở các đơn vị hiện nay đa phần đều thiếu so với số được Cục Thuế giao, tuy nhiên cần phải xác định lại đơn vị nào thiếu biên chế nhiều hơn để phân bổ, vì nguồn lực có hạn nên việc phân bổ cần phải cân nhắc để đảm bảo đủ người làm việc cho các đơn vị trong tình hình thiếu nhân sự toàn tỉnh. Nhận thấy việc tìm ra các giải pháp, quy trình để xác định đúng đơn vị thật sự đang thiếu nhiều biên chế so với các đơn vị thiếu còn lại để có phương án giao và có kế hoạch điều động nhân sự cho đơn vị kịp thời.</p><p>- Với lý do trên, tác giả đã nghiên cứu văn bản, vận dụng kinh nghiệm thực tiễn để đưa ra sáng kiến “Kỹ năng xây dựng phương án giao biên chế cho các đơn vị” góp phần xây dựng phương án giao biên chế sát với thực tế, triển khai có hiệu lực hiệu quả trong công việc; kịp thời có kế hoạch điều động, bố trí nhân sự tại các đơn vị giúp hoàn thành tốt các nhiệm vụ chính trị được cấp trên giao.</p><p>b. Nội dung sáng kiến.</p><p>- Việc thực hiện giao và theo dõi, kiểm soát biên chế tại các đơn vị là quy định bắt buộc, phải thực hiện thường xuyên theo đúng quy định của Đảng, nhà nước và của ngành. Hàng năm, trong Quý I cấp trên đều có quyết định giao số lượng biên chế. Căn cứ vào số biên chế được giao, Thuế tỉnh lập phương án giao biên chế lại cho các đơn vị thuộc Thuế tỉnh nhằm kiểm soát biên chế và điều động nhân sự bổ sung cho nơi thiếu. Nhận thấy được tầm quan trọng và thực trạng tại cơ quan, Nhóm tác giả đã có sáng kiến đưa ra các giải pháp thực hiện trọng tâm để có cơ sở phân tích, giao biên chế sát với nhu cầu của các đơn vị, là tiền đề, cơ sở để xây dựng Kế hoạch luân chuyển, điều động để kịp thời bổ sung nguồn nhân lực cho các đơn vị đang thiếu.</p><p>- Chi tiết về các chỉ tiêu làm cơ sở trong phương án giao biên chế như sau:</p><p>+ Số công chức của đơn vị hiện tại.</p><p>+ Số thu của đơn vị được giao trong năm.</p><p>+ Số cuộc kiểm tra được giao trong năm.</p><p>+ Số lượng Tổ chức, doanh nghiệp đang quản lý  (bao gồm: Doanh nghiệp và Hợp tác xã, tổ chức khác).</p><p>+ Số lượng Hộ kinh doanh đang quản lý tính đến thời điểm hiện tại (bao gồm Hộ trên ngưỡng nộp thuế và Hộ dưới ngưỡng nộp thuế).</p><p>Từ các số liệu trên sẽ tính toán được:</p><p>+ Trung bình số lượng Doanh nghiệp mà các Phòng Quản lý, hỗ trợ doanh nghiệp, các Thuế cơ sở đang quản lý, so sánh đơn vị nào đang quản lý nhiều doanh nghiệp hơn, đang có số thu được giao cao hơn so với số trung bình để có cơ sở giao biên chế tăng hoặc giảm, từ đó là cơ sở để có kế hoạch điều động công chức về phân bổ cho các đơn vị.</p><p>+ Trung bình số cuộc kiểm tra mà các Phòng Kiểm tra, các Thuế cơ sở được giao để so sánh xem đơn vị nào có số lượng cuộc kiểm tra được giao nhiều hơn so với số trung bình từ đó có cơ sở tăng hoặc giảm biên chế và là cơ sở để có kế hoạch điều động công chức về phân bổ cho các đơn vị.</p><p>+ Trung bình số lượng Doanh nghiệp, hộ kinh doanh mà các Thuế cơ sở đang quản lý; Trung bình số cuộc kiểm tra được giao; Trung bình số thu/công chức đang đảm nhiệm từ đó có cơ sở giao biên chế tăng hoặc giảm và là cơ sở để có kế hoạch điều động công chức về phân bổ cho các đơn vị.</p><p>- Dựa vào các dữ liệu thu thập được từ báo cáo của các Phòng, các Thuế cơ sở. Bộ phận tổ chức cán bộ lập bảng so sánh về các tiêu chí giữa các Phòng cùng chức năng, nhiệm vụ; so sánh giữa các Thuế cơ sở; so sánh giữa các Phòng và các Thuế cơ sở để đề xuất Lãnh đạo giao biên chế cho các đơn vị sát với thực tế. Việc giao biên chế hàng năm, Cục Thuế đều giao năm hiện tại thấp hơn năm trước liền kề. Sau sắp xếp có nhiều công chức xin nghỉ hưởng chế độ, chính sách dẫn đến biên chế tại các đơn vị thiếu nhiều. Việc bổ sung biên chế chỉ có khi Cục Thuế tổ chức tuyển dụng. Việc tuyển dụng diễn ra cần quy trình và thời gian khá lâu, trong khi nhu cầu công việc cấp bách. Do đó, Thuế tỉnh chỉ có cách cân đối nguồn lực hiện có, phân bổ biên chế ở nơi thiếu ít sang nơi thiếu nhiều để đảm bảo công việc.</p><p>- Việc rà soát có cơ sở khoa học để đề xuất tăng giảm biên chế tại các đơn vị dựa vào nguồn lực hiện có để đảm bảo các đơn vị hoàn thành nhiệm vụ được giao.</p><p>Tính mới của sáng kiến</p><p>- Tránh được tình trạng giao biên chế cảm tính theo báo cáo của các đơn vị.</p><p>- Đảm bảo việc giao biên chế theo nguyên tắc khoa học, hợp lý và phát huy trách nhiệm, quyền hạn của người đứng đầu đơn vị; dựa vào các yêu cầu công tác, vị trí việc làm, quy mô quản lý, thực trạng tại đơn vị để bổ sung biên chế nhằm nâng cao chất lượng và hiệu quả hoạt động của cơ quan.</p><p>- Giúp tiết kiệm thời gian và chủ động trong công tác giao biên chế hàng năm. Là cơ sở để xác định nhu cầu biên chế của toàn tỉnh, xác định nhu cầu biên chế trống để có cơ sở đề xuất phân bổ chỉ tiêu tuyển dụng công chức và chỉ tiêu giao biên chế cho năm sau.</p><p>c. Hiệu quả và phạm vi áp dụng của sáng kiến, giải pháp</p><p>Kể từ khi áp dụng sáng kiến từ 24/3/2025 đến nay đã giúp:</p><p>- Khắc phục được một hạn chế đang tồn tại lâu nay là giao biên chế theo báo cáo của đơn vị (các đơn vị đều báo cáo thiếu biên chế, xin thêm người về đơn vị mình). Nhằm tăng cường tính chủ động và hiệu quả trong quản lý, sử dụng công chức, xây dựng cơ cấu đội ngũ công chức hợp lý; tăng cường nhân sự cho các đơn vị có khó khăn về công tác nhân sự; để sắp xếp, kiện toàn tổ chức, bộ máy. Kịp thời chủ động phân bổ nhân sự cho các nơi thật sự thiếu nhiều trong tình hình chung các đơn vị đều thiếu, phân bổ ở nơi thiếu ít về nơi thiếu nhiều dựa vào nguồn lực hiện có.</p><p>- Đối với cấp Thuế tỉnh: Giúp Lãnh đạo có cái nhìn tổng quan, phân tích trên cơ sở khoa học, khách quan khi xây dựng phương án giao biên chế. Tiết kiệm được thời gian khi phải rà soát chi tiết từng đơn vị. Kịp thời, chủ động trong công tác thực hiện các quy trình điều động, bổ sung từ các đơn vị thừa nhân sự sang các đơn vị thiếu để thực hiện tốt nhiệm vụ chính trị được giao.</p><p>- Đối với cấp Thuế cơ sở: Từ bộ tiêu chí xây dựng như trên đã triển khai, hướng dẫn giúp Thuế cơ sở có cơ sở khoa học khi tự rà soát xây dựng phương án giao biên chế hàng năm sát với thực tế, đúng theo yêu cầu công việc tại các Tổ, đảm bảo khoa học, minh bạch, hợp lý, đặc biệt tiết kiệm thời gian trong việc rà soát, tham mưu với Lãnh đạo. Trên cơ sở khoa học, rút ngắn thời gian từ đó phương án được phê duyệt sớm, đảm bảo được việc triển khai thực hiện điều động, chuyển đổi vị trí công tác kịp thời.</p><p>Phạm vi ảnh hưởng, khả năng nhân rộng của sáng kiến: Có hiệu quả áp dụng, phạm vi ảnh hưởng và khả năng nhân rộng tại cấp Thuế tỉnh và cấp Bộ Tài chính.</p><p>5. Hội đồng cơ sở đã xét công nhận sáng kiến: Quyết định số 1109/QĐ-CMA ngày 23 tháng 10 năm 2025 của Trưởng Thuế tỉnh Cà Mau.</p><p>6. Thời gian áp dụng: Từ 24/3/2025 đến nay.</p><p>Cà Mau, ngày 27 tháng 10 năm 2025</p><p>TRƯỞNG THUẾ TỈNH                                    NGƯỜI NỘP ĐƠN</p><p>Lê Văn Sơn                                             Đỗ Thanh Thảo</p><p>ĐỒNG TÁC GIẢ SÁNG KIẾN</p><p>Trần Ty Na                    Phạm Nhật Trường</p>', 'f75defbc4e9d038ff036b7eef16c0f3a9f9a213392da1c5b6f36383570fbce56', '2026-09-21 13:51:55'),
(3, 15, 24, 'BÁO CÁO MÔ TẢ SÁNG KIẾN\n1. Tên sáng kiến: Một số giải pháp góp phần nâng cao trách nhiệm công chức thuế trong thực thi công vụ.\n2. Họ và tên nhóm tác giả sáng kiến, chức danh, trình độ chuyên môn:\n3. Lĩnh vực áp dụng: Lĩnh vực khác, nâng cao chất lượng công tác chuyên môn nghiệp vụ\n4. Mô tả sáng kiến\na. Khái quát đặc điểm, tình hình trước khi có sáng kiến:\n* Đặc điểm, tình hình trước khi có sáng kiến:\nTrong điều kiện kinh tế, khoa học công nghệ ngày càng phát triển với tốc độ cao, các thành phần kinh tế, các hình thức kinh doanh, số lượng đối tượng nộp thuế phát triển một cách nhanh chóng, đa dạng, theo đó quy mô hoạt động của các doanh nghiệp được mở rộng và mang tính toàn cầu, việc quản lý kinh doanh và các giao dịch thương mại ngày càng được tin học hóa nên nhiệm vụ quản lý thuế trở nên khó khăn, phức tạp. Nhất là trong giai đoạn hiện nay, thực hiện Nghị quyết số 18/NQ-TW ngày 25/10/2017 của Ban Chấp hành Trung ương về đổi mới, sắp xếp tổ chức bộ máy của hệ thống chính trị theo hướng tinh gọn, hiệu lực, hiệu quả; cùng với chỉ đạo của Chính phủ, Bộ Tài chính, Cục Thuế, ngành Thuế tỉnh đã triển khai các biện pháp cải cách, hiện đại hóa nhằm nâng cao hiệu quả quản lý thuế và phục vụ tốt hơn cho người nộp thuế. Tuy nhiên, theo phản ánh ở một số địa phương, vẫn còn tình trạng một số cán bộ, công chức thuế có biểu hiện tiêu cực trong quá trình thực thi công vụ, gây phiền hà, nhũng nhiễu, ảnh hướng đến quyền lợi hợp pháp của người nộp thuế.\nTừ những lý do trên, việc đưa ra sáng kiến “Một số giải pháp góp phần nâng cao trách nhiệm công chức thuế trong thực thi công vụ” trong giai đoạn hiện nay là rất cần thiết.\n* Sự cần thiết, mục đích của việc thực hiện sáng kiến:\nCông chức thuế có vị trí vai trò rất quan trọng trong bộ máy cơ quan thuế. Để đáp ứng yêu cầu quản lý thuế trong sự nghiệp đổi mới đòi hỏi công chức thuế “có tâm trong sáng, có nghề tinh thông” không những phải thành thạo về chuyên môn, tinh thông nghiệp vụ mà còn phải có phẩm chất đạo đức lối sống lành mạnh, liêm chính. Thời gian qua, ngành Thuế đã thực hiện hai lần sắp xếp bộ máy. Lần thứ nhất từ ngày 01/3/2025 theo Quyết định 381/QĐ-BTC của Bộ Tài chính, Cục Thuế tỉnh Kiên Giang, Cục Thuế tỉnh Cà Mau và Cục Thuế tỉnh Bạc Liêu sáp nhập thành Chi cục Thuế khu vực XX, cơ cấu tổ chức bộ máy gồm: 02 Bộ phận một cửa, 11 đơn vị cấp phòng và 14 Đội Thuế liên huyện, thành phố; có tổng cố 1.407 công chức và người lao động, trong đó: Biên chế: 1.275 công chức và 132 lao động hợp động. Tiếp đó, thực hiện Nghị quyết 60-NQ/TW ngày 12/4/2025 của Ban Chấp hành Trung ương Đảng về mô hình chính quyền địa phương 2 cấp, Bộ Tài chính ban hành Quyết định 2229/QĐ-BTC (có hiệu lực từ 1/7/2025). Theo đó, sắp xếp Thuế tỉnh Cà Mau gồm có 9 phòng và 8 đơn vị Thuế cơ sở, 35 tổ, có tổng số 529 công chức và người lao động, trong đó: Biên chế: 472 công chức và 57 người lao động. Trong quá trình sắp xếp tổ chức bộ máy mới, ngành Thuế tỉnh Cà Mau mặc dù gặp nhiều khó khăn, nhưng với sự nổ lực, vượt khó của tập thể công chức và người lao động của ngành đã đưa hoạt động công vụ của Thuế tỉnh Cà Mau vận hành cơ bản đạt yêu cầu. Tuy nhiên, qua thực hiện đã bộc lộ một số tồn tại nhất định: Việc thực hiện nhiệm vụ của một bộ phận công chức có nơi bị xao nhãng, hiệu quả thấp; hoạt động công vụ của một số Phòng chưa được quan tâm, lãnh đạo, chỉ đạo cũng như quán triệt thực hiện, nhất là công tác phối hợp của công chức giữa các bộ phận, các phòng, ...thiếu thường xuyên, từ đó ảnh hưởng không nhỏ đến hiệu quả hoạt động công vụ của toàn đơn vị. Để góp phần tăng cường kỷ luật, kỷ cương, nâng cao hiệu quả thực thi pháp luật, phát huy vai trò của công chức thuế và sự lãnh đạo, chỉ đạo, điều hành, trách nhiệm của Người đứng đầu các đơn vị trong thực thi công vụ. Chúng tôi đã nghiên cứu đề ra “Một số giải pháp góp phần nâng cao trách nhiệm công chức thuế trong thực thi công vụ” nhằm đóng góp ý kiến của mình để phần nào đó nâng cao trách nhiệm trong thực thi công vụ của công chức Thuế và trách nhiệm Người đứng đầu trong cơ quan, đơn vị.\nb. Nội dung sáng kiến:\nĐể đảm bảo kỷ luật, kỷ cương hành chính trong thực thi công vụ đồng thời nâng cao tinh thần trách nhiệm của mỗi đơn vị, cá nhân trong thực thi nhiệm vụ và phối hợp công tác. Nhóm đưa ra một số giải pháp duy trì và nghiêm túc thực hiện như sau:\n1. Quán triệt thực hiện nghiêm quy định về chức năng, nhiệm vụ, quyền hạn của Văn phòng, các Phòng, các Thuế cơ sở đến toàn thể công chức trong đơn vị. Hoàn thành việc phân công nhiệm vụ bằng văn bản trong tập thể lãnh đạo, công chức tại các Phòng, các Thuế cơ sở và Tổ. Thông báo bằng văn bản công khai danh sách công chức hỗ trợ NNT tại các đơn vị thuộc Thuế tỉnh cà Mau.\n2. Giao lãnh đạo các đơn vị siết chặt kỷ luật, kỷ cương; tăng cường kiểm tra công vụ, xử lý ngay các trường hợp xao nhãng, lơ là công việc chuyên môn và các hành vi gây phiền hà, sách nhiễu người nộp thuế. Nâng cao tinh thần, trách nhiệm, sự tận tụy, sáng tạo của công chức trong công tác chuyển đổi số, tái thiết kế quy trình, đơn giản hóa thủ tục hành chính theo hướng hiện đại. Các Phòng, Văn phòng, Thuế cơ sở tăng cường trao đổi chia sẽ, triển khai nhanh, đồng bộ ứng dụng quản lý thuế, thực hiện có hiệu quả nhằm nâng cao năng suất làm việc, hiệu quả quản lý thuế, chống thất thu ngân sách nhà nước.\n3. Quán triệt thực hiện nghiêm túc Nghị quyết số 18/NQ-TW ngày 25/10/2017 của Ban Chấp hành Trung ương về đổi mới, sắp xếp tổ chức bộ máy của hệ thống chính trị theo hướng tinh gọn, hiệu lực, hiệu quả; Chỉ thị số 05-CT/TW ngày 15/5/2016 của Bộ Chính trị về “Đẩy mạnh học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh”; Công văn số 11184/BTC-TCCB ngày 22/7/2025 của Bộ Tài chính; Quyết định số 828/QĐ-BTC ngày 8/6/2020 của Bộ trưởng Bộ Tài chính ban hành Quy chế văn hóa công sở tại các đơn vị thuộc trực thuộc Bộ Tài chính và các văn bản chỉ đạo của Cục Thuế như: Công văn số 176/CT-VP ngày 18/3/2025 về việc tiếp tục chấn chỉnh, tăng cường kỷ luật, kỷ cương trong giải quyết thủ tục hành chính, xử lý văn bản của Bộ Tài chính, Công văn số 261/CT-TTKT ngày 21/3/2025 về việc chấn chỉnh kỷ cương, kỷ luật trong thực thi công vụ, Công văn số 2002/CT-TCCB ngày 24/6/2025 về việc tăng cường kỷ luật, kỷ cương và văn hóa công sở tại đơn vị.\n4. Đề cao trách nhiệm người đứng đầu, cấp phó của người đứng đầu và trách nhiệm cá nhân của công chức trong thực thi công vụ. Tuân thủ nghiêm quy định trách nhiệm giải quyết công việc. Chủ động giải quyết công việc theo đúng thẩm quyền, trong phạm vi trách nhiệm của đơn vị, cá nhân phụ trách. Không chuyển công việc thuộc thẩm quyền lên cấp trên hoặc sang đơn vị khác, không đùn đẩy né tránh trách nhiệm.\n5. Tăng cường công tác tuyên truyền, phổ biến pháp luật sâu rộng với nhiều hình thức về phòng chống tham nhũng, lãng phí. Thực hiện tốt công tác kiểm tra, đôn đốc, giám sát việc thực hiện các biện pháp phòng chống tham nhũng. Cán bộ, đảng viên, công chức khi vi phạm kỷ luật, kỷ cương hành chính phải bị xem xét xử lý kỷ luật theo quy định của Đảng và pháp luật của Nhà nước. Triển khai Quyết định số 154/QĐ-CMA ngày 29/7/2025 của Thuế tỉnh Cà Mau ban hành quy chế làm việc của Thuế tỉnh Cà Mau đến toàn thể công chức và người lao động, xây dựng tác phong làm việc theo hướng khoa học, hiện đại, trang phục lịch sự, gọn gàng trong khi làm việc, giải quyết công việc với tổ chức, công dân; nâng cao nhận thức của cán bộ, công chức nhất là công chức tiếp xúc trực tiếp, thực hiện kiểm tra, làm việc với người nộp thuế.\n6. Quán triệt, triển khai đối với cán bộ, công chức chấp hành kỷ luật, kỷ cương hành chính, văn hóa công sở và sử dụng có hiệu quả thời gian làm việc; cụ thể hóa trách nhiệm của từng cá nhân, đơn vị trong việc thực hiện nhiệm vụ được giao, bảo đảm cấp dưới phục tùng sự lãnh đạo, chỉ đạo và chấp hành nghiêm chỉnh các quyết định của cấp trên. Rà soát nhiệm vụ cụ thể đối với từng vị trí việc làm của công chức; xác định rõ những vị trí dễ phát sinh tiêu cực, những vị trí không đáp ứng yêu cầu để bố trí lại cho phù hợp với năng lực, sở trường, tinh thần trách nhiệm.\n7. Chú trọng công tác bảo vệ chính trị nội bộ nhất là trong công tác tuyển chọn, quy hoạch, bổ nhiệm và luân chuyển công chức bảo đảm đúng tiêu chuẩn chính trị, thủ tục, nguyên tắc quy định nhằm tăng cường đoàn kết và phòng ngừa tiêu cực trong nội bộ đơn vị.\n8. Người đứng đầu cấp ủy, Thủ trưởng đơn vị nêu cao tính tiên phong, gương mẫu trong việc thực hiện Quy định số 55-QĐ/TW của Bộ Chính trị; tăng cường công tác kiểm tra, giám sát và chịu trách nhiệm trước cấp có thẩm quyền trong công tác quản lý, đánh giá, phân loại, bố trí, sử dụng cán bộ, đảng viên, công chức tại đơn vị mình.\n9. Từng cán bộ, đảng viên, công chức, nhất là công chức giữ chức vụ lãnh đạo, quản lý phải tuân thủ quy trình, quy định và trật tự hành chính; gương mẫu thực hiện nhiệm vụ được giao. Thực hiện nghiêm các quy định về đạo đức công vụ, văn hóa công sở; phấn đấu làm việc với tinh thần, trách nhiệm cao nhất theo phương châm “Làm hết việc chứ không hết giờ”. Trong thực thi nhiệm vụ, công vụ phải tuân thủ tính thứ bậc, kỷ cương và trật tự hành chính, đúng thẩm quyền. Nghiêm túc thực hiện công việc, nhiệm vụ được giao, không để quá hạn, bỏ sót nhiệm vụ; không đùn đẩy trách nhiệm, không né tránh công việc. Nghiêm cấm lợi dụng chức năng, nhiệm vụ để gây nhũng nhiễu, phiền hà, trục lợi khi xử lý, giải quyết công việc liên quan đến người nộp thuế.\n10. Triển khai thực hiện đồng bộ các chủ trương, chính sách, quy định của pháp luật về tiếp công dân, giải quyết khiếu nại, tố cáo. Nâng cao chất lượng, hiệu quả công tác tiếp công dân, xử lý đơn thư và giải quyết khiếu nại, tố cáo, hạn chế khiếu nại, tố cáo vượt cấp.\n11. Tăng cường công tác kiểm tra công vụ để kịp thời chấn chỉnh các vi phạm kỷ luật, kỷ cương hành chính, quy trình nghiệp vụ, quy tắc ứng xử, đạo đức nghề nghiệp trong thực thi công vụ nhất là đối với công chức thường xuyên tiếp xúc với người nộp thuế.\n12. Cấp ủy, Thủ trưởng đơn vị là người chịu trách nhiệm trong công tác lãnh đạo, chỉ đạo toàn diện công tác quản lý cán bộ tại đơn vị; nghiêm túc thực hiện và công khai minh bạch các quy định có liên quan trong công tác tổ chức cán bộ, kiên quyết không để xảy ra sai phạm, tiêu cực. Tăng cường công tác kiểm tra, giám sát công tác tổ chức cán bộ, chú trọng kiểm tra, giám sát người đứng đầu đơn vị trong việc thực hiện chức trách nhiệm vụ được giao, việc thực hiện các kết luận, chấn chỉnh sau thanh tra, kiểm tra, việc thực hiện các quy định, quy chế về công tác tổ chức cán bộ; kịp thời phát hiện, chấn chỉnh và xử lý nghiêm theo quy định của pháp luật đối với thủ trưởng các đơn vị đã để xảy ra sai phạm, cá nhân công chức có biểu hiện chuyên quyền, độc đoán, thiếu dân chủ và có sai phạm trong công tác quản lý thuế.\n* Tính mới của sáng kiến:\nĐối với tập thể: Xây dựng và tổ chức thực hiện chương trình, kế hoạch công tác cụ thể trên cơ sở nhiệm vụ được giao và phù hợp với nhiệm vụ của cơ quan, đơn vị; trong thực hiện nhiệm vụ chọn một số công việc, vấn đề cụ thể mang tính đột phá, lấy kết quả thực hiện kế hoạch là một trong những tiêu chí đánh giá phân loại tập thể cuối năm.\nĐối với cá nhân: Từng đảng viên, công chức nhận thức sâu sắc được tầm quan trọng của công tác Thuế, cũng như vị trí, vai trò của bản thân mình trong từng nhiệm vụ cụ thể được Lãnh đạo phân công phụ trách; Tuyệt đối tin tưởng vào sự lãnh đạo của Đảng, có lập trường tư tưởng vững vàng; dám nghĩ, dám làm và dám tự chịu trách nhiệm trong công việc được lãnh đạo phân công. Mỗi cá nhân khi được phân công nhiệm vụ, tự xác định được trách nhiệm của bản thân sẽ thực hiện những công việc gì? và phải làm như thế nào? từ đó tự xây dựng cho mình bản mô tả công việc đồng thời xây dựng kế hoạch và đề ra những giải pháp thực hiện cho từng mãng công việc. Cuối cùng là thời gian hoàn thành công việc, để có sự sắp xếp hợp lý, khoa học trong quá trình giải quyết công việc. Trong quá trình thực hiện nếu có vướng mắc hay gặp những khó khăn, công chức trình lãnh đạo cấp trên để có những phương hướng giải quyết kịp thời, không gây ảnh hưởng đến công việc và phiền hà đến người nộp thuế. Chỉ có “Nhận thức đúng thì Hành động đúng”, là một công chức ngành Thuế, bản thân nhận thức được trách nhiệm cũng như vị trí, vai trò của mình trong từng nhiệm vụ cụ thể thì đối với việc hoàn thành nhiệm vụ chính trị của ngành hay để giữ gìn kỷ luật, kỷ cương, nâng cao hiệu quả thực thi pháp luật trong thực hiện nhiệm vụ trên tinh thần “Chỉ tiêu một - Kế hoạch năm - Quyết tâm phải là mười” sẽ luôn đạt được kết quả cao nhất.\nc. Hiệu quả và phạm vi áp dụng của sáng kiến, giải pháp:Sự quyết tâm hoàn thành nhiệm vụ chính trị của ngành, dưới sự lãnh đạo của cấp ủy Đảng và Tập thể Lãnh đạo cùng với sự cố gắng phấn đấu của toàn thể công chức, người lao động trong ngành Thuế tỉnh. Kết quả thu ngân sách 9 tháng đầu năm 2025, Thuế tỉnh Cà Mau đạt tỷ lệ 84% (8.400 tỷ đồng/10.053 tỷ đồng). Nhất là thời điểm hiện tại, Một số giải pháp góp phần nâng cao trách nhiệm công chức thuế trong thực thi công vụ đã góp phần cùng ngành Thuế tỉnh trước, trong và sau khi sắp xếp tổ chức bộ máy theo chính quyền địa phương 2 cấp đã đi vào hoạt động, ổn định quá trình triển khai diễn ra thông suốt, không bị gián đoạn. Mô hình mới tạo thuận lợi cho người nộp thuế trong thực hiện thủ tục hành chính, đồng thời đáp ứng yêu cầu ứng dụng công nghệ thông tin, chuyển đổi số và hiện đại hóa ngành Thuế. Qua đó, giúp mỗi công chức thuế luôn ý thức khi làm bất cứ việc gì trước hết xác định được mục đích rõ ràng, đúng đắn, phải có chương trình, kế hoạch, giải pháp cụ thể để thực hiện. Kịp thời đề xuất những giải pháp hữu hiệu để hoàn thành xuất sắc chỉ tiêu, nhiệm vụ của cấp trên giao hàng tháng, quý, năm, góp phần hoàn thành xuất sắc nhiệm vụ thu ngân sách của ngành. Luôn giữ gìn đoàn kết tốt trong nội bộ, sẵn sàng chia sẽ, hỗ trợ nhau để cùng hoàn thành nhiệm vụ, cùng nhau tiến bộ.\n- Đối tượng, đơn vị áp dụng: Toàn thể Công chức và người lao động thuộc Thuế tỉnh Cà Mau.\n- Phạm vi, khả năng nhân rộng: Thuế tỉnh Cà Mau.\n5. Hội đồng cơ sở đã xét công nhận sáng kiến: Quyết định số 1109/QĐ-CMA ngày 23 tháng 10 năm 2025.\n6. Thời gian áp dụng: 01/10/2024./.', '<p>BÁO CÁO MÔ TẢ SÁNG KIẾN</p><p>1. Tên sáng kiến: Một số giải pháp góp phần nâng cao trách nhiệm công chức thuế trong thực thi công vụ.</p><p>2. Họ và tên nhóm tác giả sáng kiến, chức danh, trình độ chuyên môn:</p><p>3. Lĩnh vực áp dụng: Lĩnh vực khác, nâng cao chất lượng công tác chuyên môn nghiệp vụ</p><p>4. Mô tả sáng kiến</p><p>a. Khái quát đặc điểm, tình hình trước khi có sáng kiến:</p><p>* Đặc điểm, tình hình trước khi có sáng kiến:</p><p>Trong điều kiện kinh tế, khoa học công nghệ ngày càng phát triển với tốc độ cao, các thành phần kinh tế, các hình thức kinh doanh, số lượng đối tượng nộp thuế phát triển một cách nhanh chóng, đa dạng, theo đó quy mô hoạt động của các doanh nghiệp được mở rộng và mang tính toàn cầu, việc quản lý kinh doanh và các giao dịch thương mại ngày càng được tin học hóa nên nhiệm vụ quản lý thuế trở nên khó khăn, phức tạp. Nhất là trong giai đoạn hiện nay, thực hiện Nghị quyết số 18/NQ-TW ngày 25/10/2017 của Ban Chấp hành Trung ương về đổi mới, sắp xếp tổ chức bộ máy của hệ thống chính trị theo hướng tinh gọn, hiệu lực, hiệu quả; cùng với chỉ đạo của Chính phủ, Bộ Tài chính, Cục Thuế, ngành Thuế tỉnh đã triển khai các biện pháp cải cách, hiện đại hóa nhằm nâng cao hiệu quả quản lý thuế và phục vụ tốt hơn cho người nộp thuế. Tuy nhiên, theo phản ánh ở một số địa phương, vẫn còn tình trạng một số cán bộ, công chức thuế có biểu hiện tiêu cực trong quá trình thực thi công vụ, gây phiền hà, nhũng nhiễu, ảnh hướng đến quyền lợi hợp pháp của người nộp thuế.</p><p>Từ những lý do trên, việc đưa ra sáng kiến “Một số giải pháp góp phần nâng cao trách nhiệm công chức thuế trong thực thi công vụ” trong giai đoạn hiện nay là rất cần thiết.</p><p>* Sự cần thiết, mục đích của việc thực hiện sáng kiến:</p><p>Công chức thuế có vị trí vai trò rất quan trọng trong bộ máy cơ quan thuế. Để đáp ứng yêu cầu quản lý thuế trong sự nghiệp đổi mới đòi hỏi công chức thuế “có tâm trong sáng, có nghề tinh thông” không những phải thành thạo về chuyên môn, tinh thông nghiệp vụ mà còn phải có phẩm chất đạo đức lối sống lành mạnh, liêm chính. Thời gian qua, ngành Thuế đã thực hiện hai lần sắp xếp bộ máy. Lần thứ nhất từ ngày 01/3/2025 theo Quyết định 381/QĐ-BTC của Bộ Tài chính, Cục Thuế tỉnh Kiên Giang, Cục Thuế tỉnh Cà Mau và Cục Thuế tỉnh Bạc Liêu sáp nhập thành Chi cục Thuế khu vực XX, cơ cấu tổ chức bộ máy gồm: 02 Bộ phận một cửa, 11 đơn vị cấp phòng và 14 Đội Thuế liên huyện, thành phố; có tổng cố 1.407 công chức và người lao động, trong đó: Biên chế: 1.275 công chức và 132 lao động hợp động. Tiếp đó, thực hiện Nghị quyết 60-NQ/TW ngày 12/4/2025 của Ban Chấp hành Trung ương Đảng về mô hình chính quyền địa phương 2 cấp, Bộ Tài chính ban hành Quyết định 2229/QĐ-BTC (có hiệu lực từ 1/7/2025). Theo đó, sắp xếp Thuế tỉnh Cà Mau gồm có 9 phòng và 8 đơn vị Thuế cơ sở, 35 tổ, có tổng số 529 công chức và người lao động, trong đó: Biên chế: 472 công chức và 57 người lao động. Trong quá trình sắp xếp tổ chức bộ máy mới, ngành Thuế tỉnh Cà Mau mặc dù gặp nhiều khó khăn, nhưng với sự nổ lực, vượt khó của tập thể công chức và người lao động của ngành đã đưa hoạt động công vụ của Thuế tỉnh Cà Mau vận hành cơ bản đạt yêu cầu. Tuy nhiên, qua thực hiện đã bộc lộ một số tồn tại nhất định: Việc thực hiện nhiệm vụ của một bộ phận công chức có nơi bị xao nhãng, hiệu quả thấp; hoạt động công vụ của một số Phòng chưa được quan tâm, lãnh đạo, chỉ đạo cũng như quán triệt thực hiện, nhất là công tác phối hợp của công chức giữa các bộ phận, các phòng, ...thiếu thường xuyên, từ đó ảnh hưởng không nhỏ đến hiệu quả hoạt động công vụ của toàn đơn vị. Để góp phần tăng cường kỷ luật, kỷ cương, nâng cao hiệu quả thực thi pháp luật, phát huy vai trò của công chức thuế và sự lãnh đạo, chỉ đạo, điều hành, trách nhiệm của Người đứng đầu các đơn vị trong thực thi công vụ. Chúng tôi đã nghiên cứu đề ra “Một số giải pháp góp phần nâng cao trách nhiệm công chức thuế trong thực thi công vụ” nhằm đóng góp ý kiến của mình để phần nào đó nâng cao trách nhiệm trong thực thi công vụ của công chức Thuế và trách nhiệm Người đứng đầu trong cơ quan, đơn vị.</p><p>b. Nội dung sáng kiến:</p><p>Để đảm bảo kỷ luật, kỷ cương hành chính trong thực thi công vụ đồng thời nâng cao tinh thần trách nhiệm của mỗi đơn vị, cá nhân trong thực thi nhiệm vụ và phối hợp công tác. Nhóm đưa ra một số giải pháp duy trì và nghiêm túc thực hiện như sau:</p><p>1. Quán triệt thực hiện nghiêm quy định về chức năng, nhiệm vụ, quyền hạn của Văn phòng, các Phòng, các Thuế cơ sở đến toàn thể công chức trong đơn vị. Hoàn thành việc phân công nhiệm vụ bằng văn bản trong tập thể lãnh đạo, công chức tại các Phòng, các Thuế cơ sở và Tổ. Thông báo bằng văn bản công khai danh sách công chức hỗ trợ NNT tại các đơn vị thuộc Thuế tỉnh cà Mau.</p><p>2. Giao lãnh đạo các đơn vị siết chặt kỷ luật, kỷ cương; tăng cường kiểm tra công vụ, xử lý ngay các trường hợp xao nhãng, lơ là công việc chuyên môn và các hành vi gây phiền hà, sách nhiễu người nộp thuế. Nâng cao tinh thần, trách nhiệm, sự tận tụy, sáng tạo của công chức trong công tác chuyển đổi số, tái thiết kế quy trình, đơn giản hóa thủ tục hành chính theo hướng hiện đại. Các Phòng, Văn phòng, Thuế cơ sở tăng cường trao đổi chia sẽ, triển khai nhanh, đồng bộ ứng dụng quản lý thuế, thực hiện có hiệu quả nhằm nâng cao năng suất làm việc, hiệu quả quản lý thuế, chống thất thu ngân sách nhà nước.</p><p>3. Quán triệt thực hiện nghiêm túc Nghị quyết số 18/NQ-TW ngày 25/10/2017 của Ban Chấp hành Trung ương về đổi mới, sắp xếp tổ chức bộ máy của hệ thống chính trị theo hướng tinh gọn, hiệu lực, hiệu quả; Chỉ thị số 05-CT/TW ngày 15/5/2016 của Bộ Chính trị về “Đẩy mạnh học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh”; Công văn số 11184/BTC-TCCB ngày 22/7/2025 của Bộ Tài chính; Quyết định số 828/QĐ-BTC ngày 8/6/2020 của Bộ trưởng Bộ Tài chính ban hành Quy chế văn hóa công sở tại các đơn vị thuộc trực thuộc Bộ Tài chính và các văn bản chỉ đạo của Cục Thuế như: Công văn số 176/CT-VP ngày 18/3/2025 về việc tiếp tục chấn chỉnh, tăng cường kỷ luật, kỷ cương trong giải quyết thủ tục hành chính, xử lý văn bản của Bộ Tài chính, Công văn số 261/CT-TTKT ngày 21/3/2025 về việc chấn chỉnh kỷ cương, kỷ luật trong thực thi công vụ, Công văn số 2002/CT-TCCB ngày 24/6/2025 về việc tăng cường kỷ luật, kỷ cương và văn hóa công sở tại đơn vị.</p><p>4. Đề cao trách nhiệm người đứng đầu, cấp phó của người đứng đầu và trách nhiệm cá nhân của công chức trong thực thi công vụ. Tuân thủ nghiêm quy định trách nhiệm giải quyết công việc. Chủ động giải quyết công việc theo đúng thẩm quyền, trong phạm vi trách nhiệm của đơn vị, cá nhân phụ trách. Không chuyển công việc thuộc thẩm quyền lên cấp trên hoặc sang đơn vị khác, không đùn đẩy né tránh trách nhiệm.</p><p>5. Tăng cường công tác tuyên truyền, phổ biến pháp luật sâu rộng với nhiều hình thức về phòng chống tham nhũng, lãng phí. Thực hiện tốt công tác kiểm tra, đôn đốc, giám sát việc thực hiện các biện pháp phòng chống tham nhũng. Cán bộ, đảng viên, công chức khi vi phạm kỷ luật, kỷ cương hành chính phải bị xem xét xử lý kỷ luật theo quy định của Đảng và pháp luật của Nhà nước. Triển khai Quyết định số 154/QĐ-CMA ngày 29/7/2025 của Thuế tỉnh Cà Mau ban hành quy chế làm việc của Thuế tỉnh Cà Mau đến toàn thể công chức và người lao động, xây dựng tác phong làm việc theo hướng khoa học, hiện đại, trang phục lịch sự, gọn gàng trong khi làm việc, giải quyết công việc với tổ chức, công dân; nâng cao nhận thức của cán bộ, công chức nhất là công chức tiếp xúc trực tiếp, thực hiện kiểm tra, làm việc với người nộp thuế.</p><p>6. Quán triệt, triển khai đối với cán bộ, công chức chấp hành kỷ luật, kỷ cương hành chính, văn hóa công sở và sử dụng có hiệu quả thời gian làm việc; cụ thể hóa trách nhiệm của từng cá nhân, đơn vị trong việc thực hiện nhiệm vụ được giao, bảo đảm cấp dưới phục tùng sự lãnh đạo, chỉ đạo và chấp hành nghiêm chỉnh các quyết định của cấp trên. Rà soát nhiệm vụ cụ thể đối với từng vị trí việc làm của công chức; xác định rõ những vị trí dễ phát sinh tiêu cực, những vị trí không đáp ứng yêu cầu để bố trí lại cho phù hợp với năng lực, sở trường, tinh thần trách nhiệm.</p><p>7. Chú trọng công tác bảo vệ chính trị nội bộ nhất là trong công tác tuyển chọn, quy hoạch, bổ nhiệm và luân chuyển công chức bảo đảm đúng tiêu chuẩn chính trị, thủ tục, nguyên tắc quy định nhằm tăng cường đoàn kết và phòng ngừa tiêu cực trong nội bộ đơn vị.</p><p>8. Người đứng đầu cấp ủy, Thủ trưởng đơn vị nêu cao tính tiên phong, gương mẫu trong việc thực hiện Quy định số 55-QĐ/TW của Bộ Chính trị; tăng cường công tác kiểm tra, giám sát và chịu trách nhiệm trước cấp có thẩm quyền trong công tác quản lý, đánh giá, phân loại, bố trí, sử dụng cán bộ, đảng viên, công chức tại đơn vị mình.</p><p>9. Từng cán bộ, đảng viên, công chức, nhất là công chức giữ chức vụ lãnh đạo, quản lý phải tuân thủ quy trình, quy định và trật tự hành chính; gương mẫu thực hiện nhiệm vụ được giao. Thực hiện nghiêm các quy định về đạo đức công vụ, văn hóa công sở; phấn đấu làm việc với tinh thần, trách nhiệm cao nhất theo phương châm “Làm hết việc chứ không hết giờ”. Trong thực thi nhiệm vụ, công vụ phải tuân thủ tính thứ bậc, kỷ cương và trật tự hành chính, đúng thẩm quyền. Nghiêm túc thực hiện công việc, nhiệm vụ được giao, không để quá hạn, bỏ sót nhiệm vụ; không đùn đẩy trách nhiệm, không né tránh công việc. Nghiêm cấm lợi dụng chức năng, nhiệm vụ để gây nhũng nhiễu, phiền hà, trục lợi khi xử lý, giải quyết công việc liên quan đến người nộp thuế.</p><p>10. Triển khai thực hiện đồng bộ các chủ trương, chính sách, quy định của pháp luật về tiếp công dân, giải quyết khiếu nại, tố cáo. Nâng cao chất lượng, hiệu quả công tác tiếp công dân, xử lý đơn thư và giải quyết khiếu nại, tố cáo, hạn chế khiếu nại, tố cáo vượt cấp.</p><p>11. Tăng cường công tác kiểm tra công vụ để kịp thời chấn chỉnh các vi phạm kỷ luật, kỷ cương hành chính, quy trình nghiệp vụ, quy tắc ứng xử, đạo đức nghề nghiệp trong thực thi công vụ nhất là đối với công chức thường xuyên tiếp xúc với người nộp thuế.</p><p>12. Cấp ủy, Thủ trưởng đơn vị là người chịu trách nhiệm trong công tác lãnh đạo, chỉ đạo toàn diện công tác quản lý cán bộ tại đơn vị; nghiêm túc thực hiện và công khai minh bạch các quy định có liên quan trong công tác tổ chức cán bộ, kiên quyết không để xảy ra sai phạm, tiêu cực. Tăng cường công tác kiểm tra, giám sát công tác tổ chức cán bộ, chú trọng kiểm tra, giám sát người đứng đầu đơn vị trong việc thực hiện chức trách nhiệm vụ được giao, việc thực hiện các kết luận, chấn chỉnh sau thanh tra, kiểm tra, việc thực hiện các quy định, quy chế về công tác tổ chức cán bộ; kịp thời phát hiện, chấn chỉnh và xử lý nghiêm theo quy định của pháp luật đối với thủ trưởng các đơn vị đã để xảy ra sai phạm, cá nhân công chức có biểu hiện chuyên quyền, độc đoán, thiếu dân chủ và có sai phạm trong công tác quản lý thuế.</p><p>* Tính mới của sáng kiến:</p><p>Đối với tập thể: Xây dựng và tổ chức thực hiện chương trình, kế hoạch công tác cụ thể trên cơ sở nhiệm vụ được giao và phù hợp với nhiệm vụ của cơ quan, đơn vị; trong thực hiện nhiệm vụ chọn một số công việc, vấn đề cụ thể mang tính đột phá, lấy kết quả thực hiện kế hoạch là một trong những tiêu chí đánh giá phân loại tập thể cuối năm.</p><p>Đối với cá nhân: Từng đảng viên, công chức nhận thức sâu sắc được tầm quan trọng của công tác Thuế, cũng như vị trí, vai trò của bản thân mình trong từng nhiệm vụ cụ thể được Lãnh đạo phân công phụ trách; Tuyệt đối tin tưởng vào sự lãnh đạo của Đảng, có lập trường tư tưởng vững vàng; dám nghĩ, dám làm và dám tự chịu trách nhiệm trong công việc được lãnh đạo phân công. Mỗi cá nhân khi được phân công nhiệm vụ, tự xác định được trách nhiệm của bản thân sẽ thực hiện những công việc gì? và phải làm như thế nào? từ đó tự xây dựng cho mình bản mô tả công việc đồng thời xây dựng kế hoạch và đề ra những giải pháp thực hiện cho từng mãng công việc. Cuối cùng là thời gian hoàn thành công việc, để có sự sắp xếp hợp lý, khoa học trong quá trình giải quyết công việc. Trong quá trình thực hiện nếu có vướng mắc hay gặp những khó khăn, công chức trình lãnh đạo cấp trên để có những phương hướng giải quyết kịp thời, không gây ảnh hưởng đến công việc và phiền hà đến người nộp thuế. Chỉ có “Nhận thức đúng thì Hành động đúng”, là một công chức ngành Thuế, bản thân nhận thức được trách nhiệm cũng như vị trí, vai trò của mình trong từng nhiệm vụ cụ thể thì đối với việc hoàn thành nhiệm vụ chính trị của ngành hay để giữ gìn kỷ luật, kỷ cương, nâng cao hiệu quả thực thi pháp luật trong thực hiện nhiệm vụ trên tinh thần “Chỉ tiêu một - Kế hoạch năm - Quyết tâm phải là mười” sẽ luôn đạt được kết quả cao nhất.</p><p>c. Hiệu quả và phạm vi áp dụng của sáng kiến, giải pháp:Sự quyết tâm hoàn thành nhiệm vụ chính trị của ngành, dưới sự lãnh đạo của cấp ủy Đảng và Tập thể Lãnh đạo cùng với sự cố gắng phấn đấu của toàn thể công chức, người lao động trong ngành Thuế tỉnh. Kết quả thu ngân sách 9 tháng đầu năm 2025, Thuế tỉnh Cà Mau đạt tỷ lệ 84% (8.400 tỷ đồng/10.053 tỷ đồng). Nhất là thời điểm hiện tại, Một số giải pháp góp phần nâng cao trách nhiệm công chức thuế trong thực thi công vụ đã góp phần cùng ngành Thuế tỉnh trước, trong và sau khi sắp xếp tổ chức bộ máy theo chính quyền địa phương 2 cấp đã đi vào hoạt động, ổn định quá trình triển khai diễn ra thông suốt, không bị gián đoạn. Mô hình mới tạo thuận lợi cho người nộp thuế trong thực hiện thủ tục hành chính, đồng thời đáp ứng yêu cầu ứng dụng công nghệ thông tin, chuyển đổi số và hiện đại hóa ngành Thuế. Qua đó, giúp mỗi công chức thuế luôn ý thức khi làm bất cứ việc gì trước hết xác định được mục đích rõ ràng, đúng đắn, phải có chương trình, kế hoạch, giải pháp cụ thể để thực hiện.  Kịp thời đề xuất những giải pháp hữu hiệu để hoàn thành xuất sắc chỉ tiêu, nhiệm vụ của cấp trên giao hàng tháng, quý, năm, góp phần hoàn thành xuất sắc nhiệm vụ thu ngân sách của ngành. Luôn giữ gìn đoàn kết tốt trong nội bộ, sẵn sàng chia sẽ, hỗ trợ nhau để cùng hoàn thành nhiệm vụ, cùng nhau tiến bộ.</p><p>- Đối tượng, đơn vị áp dụng: Toàn thể Công chức và người lao động thuộc Thuế tỉnh Cà Mau.</p><p>- Phạm vi, khả năng nhân rộng: Thuế tỉnh Cà Mau.</p><p>5. Hội đồng cơ sở đã xét công nhận sáng kiến: Quyết định số 1109/QĐ-CMA ngày 23 tháng 10 năm 2025.</p><p>6. Thời gian áp dụng: 01/10/2024./.</p>', '336dab69ddddf88a1efaf8ef4889e8dcdf53b011ff786bed4b6c76be231cf2ba', '2026-09-21 13:52:50'),
(7, 19, 25, 'BÁO CÁO MÔ TẢ SÁNG KIẾN\n1. Tên sáng kiến: Giải pháp nâng cao trách nhiệm công chức thuế trong thực thi công vụ.\n2. Họ và tên nhóm tác giả sáng kiến, chức danh, trình độ chuyên môn:\n3. Lĩnh vực áp dụng: Lĩnh vực khác, nâng cao chất lượng công tác chuyên môn nghiệp vụ\n4. Mô tả sáng kiến\na. Khái quát đặc điểm, tình hình trước khi có sáng kiến:\n* Đặc điểm, tình hình trước khi có sáng kiến:\nTrong điều kiện kinh tế, khoa học công nghệ ngày càng phát triển với tốc độ cao, các thành phần kinh tế, các hình thức kinh doanh, số lượng đối tượng nộp thuế phát triển một cách nhanh chóng, đa dạng, theo đó quy mô hoạt động của các doanh nghiệp được mở rộng và mang tính toàn cầu, việc quản lý kinh doanh và các giao dịch thương mại ngày càng được tin học hóa nên nhiệm vụ quản lý thuế trở nên khó khăn, phức tạp. Nhất là trong giai đoạn hiện nay, thực hiện Nghị quyết số 18/NQ-TW ngày 25/10/2017 của Ban Chấp hành Trung ương về đổi mới, sắp xếp tổ chức bộ máy của hệ thống chính trị theo hướng tinh gọn, hiệu lực, hiệu quả; cùng với chỉ đạo của Chính phủ, Bộ Tài chính, Cục Thuế, ngành Thuế tỉnh đã triển khai các biện pháp cải cách, hiện đại hóa nhằm nâng cao hiệu quả quản lý thuế và phục vụ tốt hơn cho người nộp thuế. Tuy nhiên, theo phản ánh ở một số địa phương, vẫn còn tình trạng một số cán bộ, công chức thuế có biểu hiện tiêu cực trong quá trình thực thi công vụ, gây phiền hà, nhũng nhiễu, ảnh hướng đến quyền lợi hợp pháp của người nộp thuế.\nTừ những lý do trên, việc đưa ra sáng kiến “Một số giải pháp góp phần nâng cao trách nhiệm công chức thuế trong thực thi công vụ” trong giai đoạn hiện nay là rất cần thiết.\n* Sự cần thiết, mục đích của việc thực hiện sáng kiến:\nCông chức thuế có vị trí vai trò rất quan trọng trong bộ máy cơ quan thuế. Để đáp ứng yêu cầu quản lý thuế trong sự nghiệp đổi mới đòi hỏi công chức thuế “có tâm trong sáng, có nghề tinh thông” không những phải thành thạo về', '<p>BÁO CÁO MÔ TẢ SÁNG KIẾN</p><p>1. Tên sáng kiến: Giải pháp nâng cao trách nhiệm công chức thuế trong thực thi công vụ.</p><p>2. Họ và tên nhóm tác giả sáng kiến, chức danh, trình độ chuyên môn:</p><p>3. Lĩnh vực áp dụng: Lĩnh vực khác, nâng cao chất lượng công tác chuyên môn nghiệp vụ</p><p>4. Mô tả sáng kiến</p><p>a. Khái quát đặc điểm, tình hình trước khi có sáng kiến:</p><p>* Đặc điểm, tình hình trước khi có sáng kiến:</p><p>Trong điều kiện kinh tế, khoa học công nghệ ngày càng phát triển với tốc độ cao, các thành phần kinh tế, các hình thức kinh doanh, số lượng đối tượng nộp thuế phát triển một cách nhanh chóng, đa dạng, theo đó quy mô hoạt động của các doanh nghiệp được mở rộng và mang tính toàn cầu, việc quản lý kinh doanh và các giao dịch thương mại ngày càng được tin học hóa nên nhiệm vụ quản lý thuế trở nên khó khăn, phức tạp. Nhất là trong giai đoạn hiện nay, thực hiện Nghị quyết số 18/NQ-TW ngày 25/10/2017 của Ban Chấp hành Trung ương về đổi mới, sắp xếp tổ chức bộ máy của hệ thống chính trị theo hướng tinh gọn, hiệu lực, hiệu quả; cùng với chỉ đạo của Chính phủ, Bộ Tài chính, Cục Thuế, ngành Thuế tỉnh đã triển khai các biện pháp cải cách, hiện đại hóa nhằm nâng cao hiệu quả quản lý thuế và phục vụ tốt hơn cho người nộp thuế. Tuy nhiên, theo phản ánh ở một số địa phương, vẫn còn tình trạng một số cán bộ, công chức thuế có biểu hiện tiêu cực trong quá trình thực thi công vụ, gây phiền hà, nhũng nhiễu, ảnh hướng đến quyền lợi hợp pháp của người nộp thuế.</p><p>Từ những lý do trên, việc đưa ra sáng kiến “Một số giải pháp góp phần nâng cao trách nhiệm công chức thuế trong thực thi công vụ” trong giai đoạn hiện nay là rất cần thiết.</p><p>* Sự cần thiết, mục đích của việc thực hiện sáng kiến:</p><p>Công chức thuế có vị trí vai trò rất quan trọng trong bộ máy cơ quan thuế. Để đáp ứng yêu cầu quản lý thuế trong sự nghiệp đổi mới đòi hỏi công chức thuế “có tâm trong sáng, có nghề tinh thông” không những phải thành thạo về</p>', 'ad9445a1df3965f9103998d3fbca4fd08110bd61b7c1f1f14d42170fd8320e7b', '2026-09-21 14:24:02');
INSERT INTO `qlsk_file_noi_dung` (`id`, `file_id`, `sang_kien_id`, `noi_dung`, `noi_dung_html`, `hash_noi_dung`, `ngay_trich_xuat`) VALUES
(8, 20, 26, 'BÁO CÁO MÔ TẢ SÁNG KIẾN\n1. Tên sáng kiến (thể hiện được bản chất của giải pháp): Kỹ năng xây dựng phương án giao biên chế cho các đơn vị”.\n2. Họ và tên nhóm tác giả sáng kiến, chức danh, trình độ chuyên môn:\n3. Lĩnh vực áp dụng: Tổ chức cán bộ.\n4. Mô tả sáng kiến:\na. Khái quát đặc điểm, tình hình trước khi có sáng kiến.\n- Việc quản lý, bố trí biên chế bảo đảm phù hợp với chức năng, nhiệm vụ, quyền hạn và cơ cấu tổ chức của cơ quan, tổ chức, đơn vị; yêu cầu của vị trí việc làm, cải cách hành chính gắn với tinh giản biên chế và cơ cấu lại, nâng cao chất lượng đội ngũ, bảo đảm tinh, gọn, hiệu năng, hiệu lực, hiệu quả. Những năm trước khi có sáng kiến, việc xây dựng và triển khai giao biên chế dựa vào báo cáo của các đơn vị về nhu cầu biên chế, khối lượng công việc. Các đơn vị đa phần đều báo cáo biên chế tại đơn vị thiếu nhiều. Thuế tỉnh chưa có đủ cơ sở khoa học để phân bổ biên chế về các đơn vị đảm bảo đúng nhu cầu thực tế. Về biên chế ở các đơn vị hiện nay đa phần đều thiếu so với số được Cục Thuế giao, tuy nhiên cần phải xác định lại đơn vị nào thiếu biên chế nhiều hơn để phân bổ, vì nguồn lực có hạn nên việc phân bổ cần phải cân nhắc để đảm bảo đủ người làm việc cho các đơn vị trong tình hình thiếu nhân sự toàn tỉnh. Nhận thấy việc tìm ra các giải pháp, quy trình để xác định đúng đơn vị thật sự đang thiếu nhiều biên chế so với các đơn vị thiếu còn lại để có phương án giao và có kế hoạch điều động nhân sự cho đơn vị kịp thời.\n- Với lý do trên, tác giả đã nghiên cứu văn bản, vận dụng kinh nghiệm thực tiễn để đưa ra sáng kiến “Kỹ năng xây dựng phương án giao biên chế cho các đơn vị” góp phần xây dựng phương án giao biên chế sát với thực tế, triển khai có hiệu lực hiệu quả trong công việc; kịp thời có kế hoạch điều động, bố trí nhân sự tại các đơn vị giúp hoàn thành tốt các nhiệm vụ chính trị được cấp trên giao.\nb. Nội dung sáng kiến.\n- Việc thực hiện giao và theo dõi, kiểm soát biên chế tại các đơn vị là quy định bắt buộc, phải thực hiện thường xuyên theo đúng quy định của Đảng, nhà nước và của ngành. Hàng năm, trong Quý I cấp trên đều có quyết định giao số lượng biên chế. Căn cứ vào số biên chế được giao, Thuế tỉnh lập phương án giao biên chế lại cho các đơn vị thuộc Thuế tỉnh nhằm kiểm soát biên chế và điều động nhân sự bổ sung cho nơi thiếu. Nhận thấy được tầm quan trọng và thực trạng tại cơ quan, Nhóm tác giả đã có sáng kiến đưa ra các giải pháp thực hiện trọng tâm để có cơ sở phân tích, giao biên chế sát với nhu cầu của các đơn vị, là tiền đề, cơ sở để xây dựng Kế hoạch luân chuyển, điều động để kịp thời bổ sung nguồn nhân lực cho các đơn vị đang thiếu.\n- Chi tiết về các chỉ tiêu làm cơ sở trong phương án giao biên chế như sau:\n+ Số công chức của đơn vị hiện tại.\n+ Số thu của đơn vị được giao trong năm.\n+ Số cuộc kiểm tra được giao trong năm.\n+ Số lượng Tổ chức, doanh nghiệp đang quản lý (bao gồm: Doanh nghiệp và Hợp tác xã, tổ chức khác).\n+ Số lượng Hộ kinh doanh đang quản lý tính đến thời điểm hiện tại (bao gồm Hộ trên ngưỡng nộp thuế và Hộ dưới ngưỡng nộp thuế).\nTừ các số liệu trên sẽ tính toán được:\n+ Trung bình số lượng Doanh nghiệp mà các Phòng Quản lý, hỗ trợ doanh nghiệp, các Thuế cơ sở đang quản lý, so sánh đơn vị nào đang quản lý nhiều doanh nghiệp hơn, đang có số thu được giao cao hơn so với số trung bình để có cơ sở giao biên chế tăng hoặc giảm, từ đó là cơ sở để có kế hoạch điều động công chức về phân bổ cho các đơn vị.\n+ Trung bình số cuộc kiểm tra mà các Phòng Kiểm tra, các Thuế cơ sở được giao để so sánh xem đơn vị nào có số lượng cuộc kiểm tra được giao nhiều hơn so với số trung bình từ đó có cơ sở tăng hoặc giảm biên chế và là cơ sở để có kế hoạch điều động công chức về phân bổ cho các đơn vị.\n+ Trung bình số lượng Doanh nghiệp, hộ kinh doanh mà các Thuế cơ sở đang quản lý; Trung bình số cuộc kiểm tra được giao; Trung bình số thu/công chức đang đảm nhiệm từ đó có cơ sở giao biên chế tăng hoặc giảm và là cơ sở để có kế hoạch điều động công chức về phân bổ cho các đơn vị.\n- Dựa vào các dữ liệu thu thập được từ báo cáo của các Phòng, các Thuế cơ sở. Bộ phận tổ chức cán bộ lập bảng so sánh về các tiêu chí giữa các Phòng cùng chức năng, nhiệm vụ; so sánh giữa các Thuế cơ sở; so sánh giữa các Phòng và các Thuế cơ sở để đề xuất Lãnh đạo giao biên chế cho các đơn vị sát với thực tế. Việc giao biên chế hàng năm, Cục Thuế đều giao năm hiện tại thấp hơn năm trước liền kề. Sau sắp xếp có nhiều công chức xin nghỉ hưởng chế độ, chính sách dẫn đến biên chế tại các đơn vị thiếu nhiều. Việc bổ sung biên chế chỉ có khi Cục Thuế tổ chức tuyển dụng. Việc tuyển dụng diễn ra cần quy trình và thời gian khá lâu, trong khi nhu cầu công việc cấp bách. Do đó, Thuế tỉnh chỉ có cách cân đối nguồn lực hiện có, phân bổ biên chế ở nơi thiếu ít sang nơi thiếu nhiều để đảm bảo công việc.\n- Việc rà soát có cơ sở khoa học để đề xuất tăng giảm biên chế tại các đơn vị dựa vào nguồn lực hiện có để đảm bảo các đơn vị hoàn thành nhiệm vụ được giao.\nTính mới của sáng kiến\n- Tránh được tình trạng giao biên chế cảm tính theo báo cáo của các đơn vị.\n- Đảm bảo việc giao biên chế theo nguyên tắc khoa học, hợp lý và phát huy trách nhiệm, quyền hạn của người đứng đầu đơn vị; dựa vào các yêu cầu công tác, vị trí việc làm, quy mô quản lý, thực trạng tại đơn vị để bổ sung biên chế nhằm nâng cao chất lượng và hiệu quả hoạt động của cơ quan.\n- Giúp tiết kiệm thời gian và chủ động trong công tác giao biên chế hàng năm. Là cơ sở để xác định nhu cầu biên chế của toàn tỉnh, xác định nhu cầu biên chế trống để có cơ sở đề xuất phân bổ chỉ tiêu tuyển dụng công chức và chỉ tiêu giao biên chế cho năm sau.\nc. Hiệu quả và phạm vi áp dụng của sáng kiến, giải pháp\nKể từ khi áp dụng sáng kiến từ 24/3/2025 đến nay đã giúp:\n- Khắc phục được một hạn chế đang tồn tại lâu nay là giao biên chế theo báo cáo của đơn vị (các đơn vị đều báo cáo thiếu biên chế, xin thêm người về đơn vị mình). Nhằm tăng cường tính chủ động và hiệu quả trong quản lý, sử dụng công chức, xây dựng cơ cấu đội ngũ công chức hợp lý; tăng cường nhân sự cho các đơn vị có khó khăn về công tác nhân sự; để sắp xếp, kiện toàn tổ chức, bộ máy. Kịp thời chủ động phân bổ nhân sự cho các nơi thật sự thiếu nhiều trong tình hình chung các đơn vị đều thiếu, phân bổ ở nơi thiếu ít về nơi thiếu nhiều dựa vào nguồn lực hiện có.\n- Đối với cấp Thuế tỉnh: Giúp Lãnh đạo có cái nhìn tổng quan, phân tích trên cơ sở khoa học, khách quan khi xây dựng phương án giao biên chế. Tiết kiệm được thời gian khi phải rà soát chi tiết từng đơn vị. Kịp thời, chủ động trong công tác thực hiện các quy trình điều động, bổ sung từ các đơn vị thừa nhân sự sang các đơn vị thiếu để thực hiện tốt nhiệm vụ chính trị được giao.\n- Đối với cấp Thuế cơ sở: Từ bộ tiêu chí xây dựng như trên đã triển khai, hướng dẫn giúp Thuế cơ sở có cơ sở khoa học khi tự rà soát xây dựng phương án giao biên chế hàng năm sát với thực tế, đúng theo yêu cầu công việc tại các Tổ, đảm bảo khoa học, minh bạch, hợp lý, đặc biệt tiết kiệm thời gian trong việc rà soát, tham mưu với Lãnh đạo. Trên cơ sở khoa học, rút ngắn thời gian từ đó phương án được phê duyệt sớm, đảm bảo được việc triển khai thực hiện điều động, chuyển đổi vị trí công tác kịp thời.\nPhạm vi ảnh hưởng, khả năng nhân rộng của sáng kiến: Có hiệu quả áp dụng, phạm vi ảnh hưởng và khả năng nhân rộng tại cấp Thuế tỉnh và cấp Bộ Tài chính.\n5. Hội đồng cơ sở đã xét công nhận sáng kiến: Quyết định số 1109/QĐ-CMA ngày 23 tháng 10 năm 2025 của Trưởng Thuế tỉnh Cà Mau.\n6. Thời gian áp dụng: Từ 24/3/2025 đến nay.\nCà Mau, ngày 27 tháng 10 năm 2025\nTRƯỞNG THUẾ TỈNH NGƯỜI NỘP ĐƠN\nLê Văn Sơn Đỗ Thanh Thảo\nĐỒNG TÁC GIẢ SÁNG KIẾN\nTrần Ty Na Phạm Nhật Trường', '<p>BÁO CÁO MÔ TẢ SÁNG KIẾN</p><p>1. Tên sáng kiến (thể hiện được bản chất của giải pháp): Kỹ năng xây dựng phương án giao biên chế cho các đơn vị”.</p><p>2. Họ và tên nhóm tác giả sáng kiến, chức danh, trình độ chuyên môn:</p><p>3. Lĩnh vực áp dụng: Tổ chức cán bộ.</p><p>4. Mô tả sáng kiến:</p><p>a. Khái quát đặc điểm, tình hình trước khi có sáng kiến.</p><p>- Việc quản lý, bố trí biên chế bảo đảm phù hợp với chức năng, nhiệm vụ, quyền hạn và cơ cấu tổ chức của cơ quan, tổ chức, đơn vị; yêu cầu của vị trí việc làm, cải cách hành chính gắn với tinh giản biên chế và cơ cấu lại, nâng cao chất lượng đội ngũ, bảo đảm tinh, gọn, hiệu năng, hiệu lực, hiệu quả. Những năm trước khi có sáng kiến, việc xây dựng và triển khai giao biên chế dựa vào báo cáo của các đơn vị về nhu cầu biên chế, khối lượng công việc. Các đơn vị đa phần đều báo cáo biên chế tại đơn vị thiếu nhiều. Thuế tỉnh chưa có đủ cơ sở khoa học để phân bổ biên chế về các đơn vị đảm bảo đúng nhu cầu thực tế. Về biên chế ở các đơn vị hiện nay đa phần đều thiếu so với số được Cục Thuế giao, tuy nhiên cần phải xác định lại đơn vị nào thiếu biên chế nhiều hơn để phân bổ, vì nguồn lực có hạn nên việc phân bổ cần phải cân nhắc để đảm bảo đủ người làm việc cho các đơn vị trong tình hình thiếu nhân sự toàn tỉnh. Nhận thấy việc tìm ra các giải pháp, quy trình để xác định đúng đơn vị thật sự đang thiếu nhiều biên chế so với các đơn vị thiếu còn lại để có phương án giao và có kế hoạch điều động nhân sự cho đơn vị kịp thời.</p><p>- Với lý do trên, tác giả đã nghiên cứu văn bản, vận dụng kinh nghiệm thực tiễn để đưa ra sáng kiến “Kỹ năng xây dựng phương án giao biên chế cho các đơn vị” góp phần xây dựng phương án giao biên chế sát với thực tế, triển khai có hiệu lực hiệu quả trong công việc; kịp thời có kế hoạch điều động, bố trí nhân sự tại các đơn vị giúp hoàn thành tốt các nhiệm vụ chính trị được cấp trên giao.</p><p>b. Nội dung sáng kiến.</p><p>- Việc thực hiện giao và theo dõi, kiểm soát biên chế tại các đơn vị là quy định bắt buộc, phải thực hiện thường xuyên theo đúng quy định của Đảng, nhà nước và của ngành. Hàng năm, trong Quý I cấp trên đều có quyết định giao số lượng biên chế. Căn cứ vào số biên chế được giao, Thuế tỉnh lập phương án giao biên chế lại cho các đơn vị thuộc Thuế tỉnh nhằm kiểm soát biên chế và điều động nhân sự bổ sung cho nơi thiếu. Nhận thấy được tầm quan trọng và thực trạng tại cơ quan, Nhóm tác giả đã có sáng kiến đưa ra các giải pháp thực hiện trọng tâm để có cơ sở phân tích, giao biên chế sát với nhu cầu của các đơn vị, là tiền đề, cơ sở để xây dựng Kế hoạch luân chuyển, điều động để kịp thời bổ sung nguồn nhân lực cho các đơn vị đang thiếu.</p><p>- Chi tiết về các chỉ tiêu làm cơ sở trong phương án giao biên chế như sau:</p><p>+ Số công chức của đơn vị hiện tại.</p><p>+ Số thu của đơn vị được giao trong năm.</p><p>+ Số cuộc kiểm tra được giao trong năm.</p><p>+ Số lượng Tổ chức, doanh nghiệp đang quản lý  (bao gồm: Doanh nghiệp và Hợp tác xã, tổ chức khác).</p><p>+ Số lượng Hộ kinh doanh đang quản lý tính đến thời điểm hiện tại (bao gồm Hộ trên ngưỡng nộp thuế và Hộ dưới ngưỡng nộp thuế).</p><p>Từ các số liệu trên sẽ tính toán được:</p><p>+ Trung bình số lượng Doanh nghiệp mà các Phòng Quản lý, hỗ trợ doanh nghiệp, các Thuế cơ sở đang quản lý, so sánh đơn vị nào đang quản lý nhiều doanh nghiệp hơn, đang có số thu được giao cao hơn so với số trung bình để có cơ sở giao biên chế tăng hoặc giảm, từ đó là cơ sở để có kế hoạch điều động công chức về phân bổ cho các đơn vị.</p><p>+ Trung bình số cuộc kiểm tra mà các Phòng Kiểm tra, các Thuế cơ sở được giao để so sánh xem đơn vị nào có số lượng cuộc kiểm tra được giao nhiều hơn so với số trung bình từ đó có cơ sở tăng hoặc giảm biên chế và là cơ sở để có kế hoạch điều động công chức về phân bổ cho các đơn vị.</p><p>+ Trung bình số lượng Doanh nghiệp, hộ kinh doanh mà các Thuế cơ sở đang quản lý; Trung bình số cuộc kiểm tra được giao; Trung bình số thu/công chức đang đảm nhiệm từ đó có cơ sở giao biên chế tăng hoặc giảm và là cơ sở để có kế hoạch điều động công chức về phân bổ cho các đơn vị.</p><p>- Dựa vào các dữ liệu thu thập được từ báo cáo của các Phòng, các Thuế cơ sở. Bộ phận tổ chức cán bộ lập bảng so sánh về các tiêu chí giữa các Phòng cùng chức năng, nhiệm vụ; so sánh giữa các Thuế cơ sở; so sánh giữa các Phòng và các Thuế cơ sở để đề xuất Lãnh đạo giao biên chế cho các đơn vị sát với thực tế. Việc giao biên chế hàng năm, Cục Thuế đều giao năm hiện tại thấp hơn năm trước liền kề. Sau sắp xếp có nhiều công chức xin nghỉ hưởng chế độ, chính sách dẫn đến biên chế tại các đơn vị thiếu nhiều. Việc bổ sung biên chế chỉ có khi Cục Thuế tổ chức tuyển dụng. Việc tuyển dụng diễn ra cần quy trình và thời gian khá lâu, trong khi nhu cầu công việc cấp bách. Do đó, Thuế tỉnh chỉ có cách cân đối nguồn lực hiện có, phân bổ biên chế ở nơi thiếu ít sang nơi thiếu nhiều để đảm bảo công việc.</p><p>- Việc rà soát có cơ sở khoa học để đề xuất tăng giảm biên chế tại các đơn vị dựa vào nguồn lực hiện có để đảm bảo các đơn vị hoàn thành nhiệm vụ được giao.</p><p>Tính mới của sáng kiến</p><p>- Tránh được tình trạng giao biên chế cảm tính theo báo cáo của các đơn vị.</p><p>- Đảm bảo việc giao biên chế theo nguyên tắc khoa học, hợp lý và phát huy trách nhiệm, quyền hạn của người đứng đầu đơn vị; dựa vào các yêu cầu công tác, vị trí việc làm, quy mô quản lý, thực trạng tại đơn vị để bổ sung biên chế nhằm nâng cao chất lượng và hiệu quả hoạt động của cơ quan.</p><p>- Giúp tiết kiệm thời gian và chủ động trong công tác giao biên chế hàng năm. Là cơ sở để xác định nhu cầu biên chế của toàn tỉnh, xác định nhu cầu biên chế trống để có cơ sở đề xuất phân bổ chỉ tiêu tuyển dụng công chức và chỉ tiêu giao biên chế cho năm sau.</p><p>c. Hiệu quả và phạm vi áp dụng của sáng kiến, giải pháp</p><p>Kể từ khi áp dụng sáng kiến từ 24/3/2025 đến nay đã giúp:</p><p>- Khắc phục được một hạn chế đang tồn tại lâu nay là giao biên chế theo báo cáo của đơn vị (các đơn vị đều báo cáo thiếu biên chế, xin thêm người về đơn vị mình). Nhằm tăng cường tính chủ động và hiệu quả trong quản lý, sử dụng công chức, xây dựng cơ cấu đội ngũ công chức hợp lý; tăng cường nhân sự cho các đơn vị có khó khăn về công tác nhân sự; để sắp xếp, kiện toàn tổ chức, bộ máy. Kịp thời chủ động phân bổ nhân sự cho các nơi thật sự thiếu nhiều trong tình hình chung các đơn vị đều thiếu, phân bổ ở nơi thiếu ít về nơi thiếu nhiều dựa vào nguồn lực hiện có.</p><p>- Đối với cấp Thuế tỉnh: Giúp Lãnh đạo có cái nhìn tổng quan, phân tích trên cơ sở khoa học, khách quan khi xây dựng phương án giao biên chế. Tiết kiệm được thời gian khi phải rà soát chi tiết từng đơn vị. Kịp thời, chủ động trong công tác thực hiện các quy trình điều động, bổ sung từ các đơn vị thừa nhân sự sang các đơn vị thiếu để thực hiện tốt nhiệm vụ chính trị được giao.</p><p>- Đối với cấp Thuế cơ sở: Từ bộ tiêu chí xây dựng như trên đã triển khai, hướng dẫn giúp Thuế cơ sở có cơ sở khoa học khi tự rà soát xây dựng phương án giao biên chế hàng năm sát với thực tế, đúng theo yêu cầu công việc tại các Tổ, đảm bảo khoa học, minh bạch, hợp lý, đặc biệt tiết kiệm thời gian trong việc rà soát, tham mưu với Lãnh đạo. Trên cơ sở khoa học, rút ngắn thời gian từ đó phương án được phê duyệt sớm, đảm bảo được việc triển khai thực hiện điều động, chuyển đổi vị trí công tác kịp thời.</p><p>Phạm vi ảnh hưởng, khả năng nhân rộng của sáng kiến: Có hiệu quả áp dụng, phạm vi ảnh hưởng và khả năng nhân rộng tại cấp Thuế tỉnh và cấp Bộ Tài chính.</p><p>5. Hội đồng cơ sở đã xét công nhận sáng kiến: Quyết định số 1109/QĐ-CMA ngày 23 tháng 10 năm 2025 của Trưởng Thuế tỉnh Cà Mau.</p><p>6. Thời gian áp dụng: Từ 24/3/2025 đến nay.</p><p>Cà Mau, ngày 27 tháng 10 năm 2025</p><p>TRƯỞNG THUẾ TỈNH                                    NGƯỜI NỘP ĐƠN</p><p>Lê Văn Sơn                                             Đỗ Thanh Thảo</p><p>ĐỒNG TÁC GIẢ SÁNG KIẾN</p><p>Trần Ty Na                    Phạm Nhật Trường</p>', 'f75defbc4e9d038ff036b7eef16c0f3a9f9a213392da1c5b6f36383570fbce56', '2026-09-21 16:03:27'),
(9, 21, 27, 'BÁO CÁO MÔ TẢ SÁNG KIẾN\n1. Tên sáng kiến: Một số giải pháp chủ yếu nhằm làm tốt công tác tư tưởng trước, trong và sau khi sắp xếp tổ chức bộ máy ngành Thuế tỉnh theo Nghị quyết số 18-NQ/TW ngày 25/10/2017 của Ban Chấp hành Trung ương gắn với việc học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh. \n2. Họ và tên nhóm tác giả sáng kiến, chức danh, trình độ chuyên môn:\n3. Lĩnh vực áp dụng: Lĩnh vực khác, nâng cao chất lượng công tác chuyên môn nghiệp vụ\n4. Mô tả sáng kiến\na. Khái quát đặc điểm, tình hình trước khi có sáng kiến:\n* Đặc điểm tình hình trước khi có sáng kiến: Chủ tịch Hồ Chí Minh cho rằng, việc tinh giản bộ máy nhà nước luôn đi liền với vấn đề tiết kiệm chi phí, chống lãng phí, chống quan liêu, cửa quyền. Khi bàn về tinh giản bộ máy nhà nước, Người khẳng định: “Riêng cơ quan cung cấp tổ chức còn kềnh càng, thừa người, phải sắp xếp cho gọn gàng, hợp lý, mọi người đều có công việc thiết thực, những người thừa phải đưa đi chỗ thiếu, những người ở lại phải thi đua nâng cao năng suất của mình. Thế là tinh giản, tinh là năng suất lên cao, làm cho mau, cho tốt, giản là vừa phải, không kềnh càng, tránh hình thức”. Những nội dung, quan điểm, tư tưởng của Chủ tịch Hồ Chí Minh về tinh giản bộ máy nhà nước vẫn còn nguyên về mặt giá trị lý luận và thực tiễn; tiếp tục trở thành nền tảng tư tưởng và kim chỉ nam cho Đảng, Nhà nước kế thừa, phát huy, vận dụng và phát triển một cách sáng tạo trong xây dựng Nhà nước pháp quyền xã hội chủ nghĩa Việt Nam trong giai đoạn hiện nay. Việc sắp xếp tố chức bộ máy ngành Thuế theo Nghị quyết số 18-NQ/TW ngày 25/10/2017 của Ban Chấp hành Trung ương gắn với việc học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh thông qua việc xây dựng bộ máy hành chính nhà nước, trong đó có ngành Thuế, tinh gọn, hiệu lực, hiệu quả. Điều này đòi hỏi các đơn vị thuộc ngành Thuế phải tăng cường quản lý nội ngành, kỷ luật, kỷ cương, nhằm hoàn thành tốt nhiệm vụ thu ngân sách nhà nước, phục vụ người dân và doanh nghiệp tốt hơn, thể hiện rõ nét tinh thần trách nhiệm và “Vì nhân dân phục vụ” mà Chủ tịch Hồ Chí Minh đã dạy.\n* Sự cần thiết, mục đích của việc thực hiện sáng kiến:\nSinh thời, Chủ tịch Hồ Chí Minh rất quan tâm đến công tác tư tưởng. Người cho rằng: “Trong đảng và ngoài đảng có nhận rõ tình hình mới, hiểu rõ nhiệm vụ mới thì tư tưởng mới thống nhất, tư tưởng thống nhất thì hành động mới thống nhất”. Công tác tư tưởng tự bản thân nó đã hàm chứa những vấn đề nhạy cảm, phức tạp, đa chiều liên quan đến tâm tư, nguyện vọng của đảng viên, công chức.\nHiện nay, việc sắp xếp, tinh gọn bộ máy đã và đang được triển khai quyết liệt ở các cấp, các ngành từ Trung ương đến địa phương, với mục tiêu xây dựng một hệ thống chính trị, gọn nhẹ, minh bạch, vững mạnh, hoạt động hiệu lực, hiệu quả. Lợi dụng vấn đề, các thế lực thù địch tăng cường tung tin, vu khống, xuyên tạc, chống phá Đảng và Nhà nước ta. Vì lẽ đó, đội ngũ cán bộ, đảng viên, công chức cần thống nhất trong nhận thức và hành động, tỉnh táo trước những luận điệu xuyên tác, lực lượng thù địch. Thực hiện Nghị quyết số 18-NQ/TW của Ban Chấp hành Trung ương khóa XII về một số vấn đề tiếp tục đổi mới, sắp xếp tổ chức bộ máy của hệ thống chính trị tinh gọn, hoạt động hiệu lực, hiệu quả; Kết luận số 09-KL/BCĐ ngày 24/11/2024 của Ban Chỉ đạo Trung ương về việc tiếp tục đẩy mạnh việc sắp xếp, tinh gọn bộ máy; Chỉ thị số 03/CT-BTC ngày 03/12/2024 của Bộ trưởng Bộ Tài chính về công tác đổi mới, sắp xếp tổ chức bộ máy Bộ Tài chính. Theo đó, trong thời gian qua, ngành Thuế đã quyết liệt, chủ động trong xây dựng và hoàn thiện phương án sắp xếp, tinh gọn tổ chức, bộ máy cơ quan thuế các cấp theo đúng chủ trương, định hướng của Đảng, Nhà nước và của Bộ Tài chính. Bên cạnh việc tinh gọn bộ máy giúp cơ quan thuế nâng cao hiệu năng, hiệu lực, hiệu quả hoạt động, thì quá trình sắp xếp cơ cấu tổ chức cũng sẽ phát sinh những vấn đề nhạy cảm, phức tạp như: cắt giảm biên chế, sắp xếp lại đội ngũ, dôi dư cấp lãnh đạo, khoảng cách địa lý, môi trường làm việc thay đổi,...ảnh hưởng trực tiếp đến tâm lý và quyền lợi của công chức, người lao động, đòi hỏi phải có sự thống nhất cao về nhận thức và hành động, quyết tâm chính trị mạnh mẽ. Đặc biệt, Cục Thuế tỉnh Bạc Liêu thuộc địa bàn tỉnh Bạc Liêu (trước sắp xếp) là đơn vị chịu sự tác động trực tiếp khi sắp xếp chính quyền địa phương 02 cấp. Sự đổi mới này không tránh khỏi những khó khăn, thách thức. Mỗi quyết định đưa ra đều là kết quả của những trăn trở, cân nhắc kỹ lưỡng để hài hòa giữa lợi ích chung và nguyện vọng chính đáng của từng công chức. Xuất phát từ tình hình trên, nhóm chúng tôi đã đưa ra “Một số giải pháp chủ yếu nhằm làm tốt công tác tư tưởng trước, trong và sau khi sắp xếp tổ chức bộ máy ngành Thuế tỉnh theo Nghị quyết số 18-NQ/TW ngày 25/10/2017 của Ban Chấp hành Trung ương gắn với việc học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh”.\nb. Nội dung sáng kiến:\nTrước ngày 01/3/2025, Cục Thuế tỉnh Cà Mau và Cục Thuế tỉnh Bạc Liêu gồm có: 22 phòng, 08 Chi cục Thuế thành phố, khu vực, 47 đội thuế, có tổng số 756 công chức và người lao động, trong đó: Biên chế: 681 công chức, 75 hợp đồng. Ngành Thuế đã thực hiện hai lần sắp xếp bộ máy. Lần thứ nhất từ ngày 01/3/2025 theo Quyết định 381/QĐ-BTC của Bộ Tài chính. Tiếp đó, thực hiện Nghị quyết 60-NQ/TW ngày 12/4/2025 của Ban Chấp hành Trung ương Đảng về mô hình chính quyền địa phương 2 cấp, Bộ Tài chính ban hành Quyết định 2229/QĐ-BTC (có hiệu lực từ 1/7/2025). Theo đó, sắp xếp Thuế tỉnh Cà Mau gồm có 9 phòng và 8 đơn vị Thuế cơ sở, 35 tổ, có tổng số 529 công chức và người lao động, trong đó: Biên chế: 472 công chức và 57 người lao động. Như vậy ngành Thuế đã đồng bộ với mô hình chính quyền địa phương 2 cấp, đã cắt giảm mạnh từ hơn 77 đầu mối xuống còn hơn 52 đầu mối. Bằng việc chuyển đổi từ mô hình “quản lý thuế theo chức năng, kết hợp với đối tượng” sang mô hình “quản lý theo đối tượng, kết hợp với chức năng” là bước ngoặt mang tính chiến lược. Mỗi công chức thuế giờ đây không chỉ thực hiện chuyên môn đơn lẻ mà còn là người đồng hành, hỗ trợ toàn diện cho người nộp thuế. Điều này không chỉ đòi hỏi năng lực chuyên môn cao mà còn là sự tận tâm, trách nhiệm và sẵn sàng thích nghi với sự thay đổi. Bên cạnh đó, ngày 14/02/2025, Tổng Cục Thuế có Công văn số 640/TCT-TCCB yêu cầu toàn ngành Thuế quán triệt thực hiện tốt công tác chính trị, tư tưởng, công tác chuyên môn khi sắp xếp, tinh gọn bộ máy. Qua đó, nhóm rút ra một số giải pháp chủ yếu nhằm làm tốt công tác tư tưởng trước, trong và sau khi sắp xếp tổ chức bộ máy ngành Thuế tỉnh theo Nghị quyết số 18-NQ/TW ngày 25/10/2017 của Ban Chấp hành Trung ương như sau:\nMột là. Tăng cường kỷ luật, kỷ cương nội ngành: Ngành Thuế tỉnh tăng cường tái cấu trúc bộ máy, thực hiện siết chặt kỷ luật, kỷ cương trong thực thi công vụ và trong công tác quản lý thuế, đảm bảo hoàn thành xuất sắc các nhiệm vụ được giao. Xác định rõ việc sắp xếp, tinh gọn bộ máy là nhiệm vụ đặc biệt quan trọng, là đòi hỏi tất yếu nhằm nâng cao hiệu năng, hiệu lực, hiệu quả hoạt động của bộ máy vì sự phát triển bền vững của đất nước trong kỷ nguyên mới; tạo sự đồng thuận, thống nhất trong đội ngũ công chức, người lao động khi thực hiện việc sắp xếp, tinh gọn bộ máy.\nHai là, Xác định tầm quan trọng trong công tác giáo dục chính trị, tư tưởng có ý nghĩa quyết định đến việc xây dựng Đảng vững mạnh về chính trị, tư tưởng, đạo đức, tổ chức và cán bộ, làm cơ sở để nâng cao năng lực lãnh đạo, năng lực cầm quyền, sức chiến đấu của Đảng và hiệu lực hiệu quả quản lý Nhà nước. Đảng ủy thường xuyên chỉ đạo cấp ủy trực thuộc nâng cao chất lượng công tác tuyên truyền, giáo dục, học tập, quán triệt chủ nghĩa Mác-Lênin, tư tưởng Hồ Chí Minh cho cán bộ, đảng viên, công chức. Ngoài ra còn tổ chức các cuộc hội nghị để kịp thời thông tin thời sự về tình hình quốc tế, trong nước và trong tỉnh cho toàn thể cán bộ, đảng viên, công chức trong cơ quan theo chỉ đạo của Ban Thường vụ Tỉnh ủy, Ban Thường vụ Đảng ủy Khối...\nĐặc biệt Đảng ủy Cục Thuế đẩy mạnh việc học tập và làm theo tư tưởng, đạo đức phong cách Hồ Chí Minh theo Kết luận số 21-KL/TW của Bộ Chính trị về tiếp tục thực hiện Chỉ thị số 05-CT/TW, ngày 15/5/2016 của Bộ Chính trị về “Đẩy mạnh học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh”. Để tăng cường sự đoàn kết thống nhất ở cấp ủy và các chi bộ trực thuộc Đảng bộ, từ Cục Thuế đến các Chi cục Thuế trực thuộc, tạo nên sự thống nhất từ tư tưởng đến hành động của mỗi đảng viên, công chức. Hàng năm căn cứ vào văn bản hướng dẫn của Đảng ủy Khối. Đảng ủy Cục Thuế đã xây dựng và ban hành Kế hoạch học tập, đề ra phương hướng, nhiệm vụ, các giải pháp để thực hiện nhằm đảm bảo tính kịp thời và phù hợp với định hướng chỉ đạo của cấp trên. Nội dung triển khai thực hiện việc học tập và làm theo Bác trên tinh thần sáng tạo và phù hợp với điều kiện, hoàn cảnh, thực tế của đơn vị theo từng giai đoạn nhất định. Đảng ủy Cục Thuế đề nghị mỗi một chi bộ xây dựng mô hình học tập Bác, gắn với nhiệm vụ chuyên môn của ngành, với phong trào thi đua: “Vì người nghèo - Không để ai bị bỏ lại phía sau”, “Cả nước chung sức xây dựng nông thôn mới”, phong trào thi đua: “Đẩy mạnh phát triển kết cấu hạ tầng đồng bộ, hiện đại; thực hành tiết kiệm, chống lãng phí”, phong trào Ba không: “Không né tránh công việc, không đùn đẩy công việc sang người khác, không làm việc vì lợi ích và động cơ cá nhân”, phong trào vượt qua khó khăn, thách thức vươn lên hoàn thành tốt nhiệm vụ được giao của cá nhân, của cơ quan, đơn vị và của ngành....Mô hình được thực hiện bằng công trình, phần việc cụ thể. Các chi bộ đăng ký mô hình, xây dựng kế hoạch và có báo cáo kết quả thực hiện mô hình về Ban thường vụ Đảng ủy để theo dõi, đánh giá và biểu dương điển hình tiên tiến. Từng cán bộ, đảng viên, công chức xây dựng kế hoạch đăng ký công trình, phần việc cụ thể nội dung học tập và làm theo tư tưởng, đạo đức, phong cách của Bác đúng theo hướng dẫn, phù hợp với bản thân về chức năng, nhiệm vụ chuyên môn được giao, để có giải pháp học tập và làm theo. Qua việc học tập và làm theo Bác, nhận thức của đảng viên, công chức được nâng lên rõ rệt, nâng cao ý thức tự giác, có trách nhiệm hơn trong công việc; có tinh thần, thái độ phục vụ Nhân dân. Từ đó góp phần làm tốt công tác chính trị, tư tưởng đối với cán bộ, đảng viên, công chức, người lao động tại đơn vị; nâng cao tinh thần trách nhiệm, thống nhất nhận thức và hành động của từng cấp đơn vị và mỗi công chức, người lao động trong hệ thống thuế, nhất là đảng viên, công chức lãnh đạo để vừa hoàn thành tốt nhiệm vụ công tác sắp xếp, tinh gọn bộ máy theo chủ trương, chỉ đạo của Đảng, Nhà nước và Bộ Tài chính, vừa hoàn thành toàn diện các nhiệm vụ công tác được giao.\nBa là. Công tác sắp xếp, bố trí nhân sự căn cứ vào năng lực, phẩm chất và nhu cầu thực tế công việc đảm bảo công bằng, khách quan. Quán triệt, tuyên truyền công chức, người lao động về việc sau khi bộ máy mới đi vào hoạt động, dù trên cương vị nào cũng phải nỗ lực cao nhất, khắc phục mọi khó khăn, thách thức, bắt tay ngay vào công việc mới để hoàn thành tốt các nhiệm vụ được giao.\nBốn là. Phát huy vai trò các tổ chức đoàn thể quan tâm, lắng nghe, chia sẽ, nắm bắt tâm tư, nguyện vọng của công chức, người lao động từ đó kịp thời phản ánh và đề xuất các giải pháp giải quyết vấn đề phát sinh trong quá trình sắp xếp, đảm bảo quyền lợi chính đáng của công chức, người lao động. Đồng thời, kiên quyết đấu tranh đối với những biểu hiện tiêu cực, cản trở quá trình tinh gọn bộ máy, phản bác những luận điệu xuyên tạc, kích động, trái với chủ trương của Đảng và Nhà nước, gây mất đoàn kết trong cơ quan, đơn vị.\nNăm là. Đẩy nhanh tiến độ xử lý công việc đúng hạn rà soát xử lý dứt điểm các công việc, hồ sơ hành chính về thuế, kiến nghị, phản ánh vướng mắc của người nộp thuế. Trường hợp quá hạn không có lý do chính đáng, đúng pháp luật sẽ bị xem xét trách nhiệm theo quy định.\n* Tính mới của sáng kiến: Điểm mới của sáng kiến chính là công tác giáo dục chính trị, tư tưởng, đạo đức, lối sống đảng viên, công chức thông qua các kế hoạch học tập, từ chủ đề đến hình thức học tập, nội dung triển khai thực hiện được xây dựng phù hợp điều kiện, hoàn cảnh, tình hình đất nước. Các chủ đề học tập do Đảng ủy soạn thảo đảm bảo tính kịp thời và phù hợp với quan điểm chỉ đạo của Đảng, Nhà nước với chuyên môn nghiệp vụ của ngành theo từng thời điểm, từng giai đoạn nhất định. Từ đó, tạo được mối quan hệ chặt chẽ, thống nhất giữa “học tập, làm theo và nêu gương”, nhận thức và hành động, giữa học và hành, giữa lời nói và việc làm. Được Đảng ủy Cục Thuế (nay là Đảng ủy Thuế tỉnh) quán triệt nhận thức từ trong Đảng ủy đến các Chi bộ trực thuộc, tổ đảng; từ Cơ quan Thuế tỉnh đến các Chi cục Thuế, đội thuế (nay là các Thuế cơ sở, tổ). Từ đó nâng cao nhận thức cán bộ, đảng viên, công chức thông qua học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh trong tình hình hiện nay. Góp phần nâng cao năng lực lãnh đạo và sức chiến đấu trong Đảng bộ Thuế tỉnh, góp phần xây dựng Đảng bộ Thuế tỉnh trong sạch, vững mạnh. Các mô hình, công trình, phần việc được các Chi bộ thực hiện gắn với nhiệm vụ chuyên môn của ngành, với các phong trào thi đua yêu nước. Tạo sự liên kết chặt chẽ giữa Tổ chức Đảng, chính quyền, đoàn thể quần chúng trong toàn ngành Thuế của Tỉnh. Chỉ có “Nhận thức đúng thì Hành động đúng”, là một công chức ngành Thuế, bản thân nhận thức được trách nhiệm cũng như vị trí, vai trò của mình trong từng nhiệm vụ cụ thể thì đối với việc hoàn thành nhiệm vụ chính trị của ngành hay để giữ gìn kỷ luật, kỷ cương, nâng cao hiệu quả thực thi pháp luật trong thực hiện nhiệm vụ trên tinh thần “Chỉ tiêu một - Kế hoạch năm - Quyết tâm phải là mười” sẽ luôn đạt được kết quả cao nhất.\nc. Hiệu quả và phạm vi áp dụng của sáng kiến, giải pháp: Đến nay, hệ thống tổ chức mới đã đi vào hoạt động ổn định, quá trình triển khai diễn ra thông suốt, không bị gián đoạn. Mô hình mới tạo thuận lợi cho người nộp thuế trong thực hiện thủ tục hành chính, đồng thời đáp ứng yêu cầu ứng dụng công nghệ thông tin, chuyển đổi số và hiện đại hóa ngành Thuế. Bố trí nhân sự đảm bảo công bằng, khách quan. Quán triệt, tuyên truyền công chức, người lao động về việc trước, trong và sau khi bộ máy mới đi vào hoạt động, dù trên cương vị nào cũng phải nổ lực cao nhất, khắc phục mọi khó khăn, thách thức, bắt tay ngay vào công việc mới để hoàn thành tốt các nhiệm vụ được giao. Với mục tiêu xây dựng bộ máy cơ quan thuế hiện đại, tinh gọn, hoạt động hiệu lực, hiệu quả, có đủ quyền hạn và năng lực chủ động thực thi pháp luật Thuế, đồng thời để phát triển nguồn nhân lực chất lượng cao, chuyên sâu, chuyên nghiệp, liêm chính, đổi mới, đáp ứng yêu cầu quản lý Thuế trong bối cảnh nền kinh tế số, phù hợp với xu thuế hội nhập quốc tế. Rèn luyện đội ngũ công chức ngành Thuế của Tỉnh biết Chấp nhận thử thách - Vượt qua khó khăn - Cọ sát thực tiễn - Hoàn thành nhiệm vụ. Kết quả thu ngân sách 9 tháng đầu năm 2025, Thuế tỉnh Cà Mau đạt tỷ lệ 84% (8.400 tỷ đồng/10.053 tỷ đồng) là minh chứng tiêu biểu cho sự đồng lòng, quyết tâm chính trị của ngành Thuế tỉnh Cà Mau.\n- Đối tượng, đơn vị áp dụng: Toàn thể Công chức và người lao động thuộc Thuế tỉnh Cà Mau.\n- Phạm vi, khả năng nhân rộng: Thuế tỉnh Cà Mau và Bộ Tài chính\n5. Hội đồng cơ sở đã xét công nhận sáng kiến: Quyết định số 1109/QĐ-CMA ngày 23 tháng 10 năm 2025.\n6. Thời gian áp dụng: 01/10/2024./.', '<p>BÁO CÁO MÔ TẢ SÁNG KIẾN</p><p>1. Tên sáng kiến: Một số giải pháp chủ yếu nhằm làm tốt công tác tư tưởng trước, trong và sau khi sắp xếp tổ chức bộ máy ngành Thuế tỉnh theo Nghị quyết số 18-NQ/TW ngày 25/10/2017 của Ban Chấp hành Trung ương gắn với việc học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh. </p><p>2. Họ và tên nhóm tác giả sáng kiến, chức danh, trình độ chuyên môn:</p><p>3. Lĩnh vực áp dụng: Lĩnh vực khác, nâng cao chất lượng công tác chuyên môn nghiệp vụ</p><p>4. Mô tả sáng kiến</p><p>a. Khái quát đặc điểm, tình hình trước khi có sáng kiến:</p><p>* Đặc điểm tình hình trước khi có sáng kiến: Chủ tịch Hồ Chí Minh cho rằng, việc tinh giản bộ máy nhà nước luôn đi liền với vấn đề tiết kiệm chi phí, chống lãng phí, chống quan liêu, cửa quyền. Khi bàn về tinh giản bộ máy nhà nước, Người khẳng định: “Riêng cơ quan cung cấp tổ chức còn kềnh càng, thừa người, phải sắp xếp cho gọn gàng, hợp lý, mọi người đều có công việc thiết thực, những người thừa phải đưa đi chỗ thiếu, những người ở lại phải thi đua nâng cao năng suất của mình. Thế là tinh giản, tinh là năng suất lên cao, làm cho mau, cho tốt, giản là vừa phải, không kềnh càng, tránh hình thức”. Những nội dung, quan điểm, tư tưởng của Chủ tịch Hồ Chí Minh về tinh giản bộ máy nhà nước vẫn còn nguyên về mặt giá trị lý luận và thực tiễn; tiếp tục trở thành nền tảng tư tưởng và kim chỉ nam cho Đảng, Nhà nước kế thừa, phát huy, vận dụng và phát triển một cách sáng tạo trong xây dựng Nhà nước pháp quyền xã hội chủ nghĩa Việt Nam trong giai đoạn hiện nay. Việc sắp xếp tố chức bộ máy ngành Thuế theo Nghị quyết số 18-NQ/TW ngày 25/10/2017 của Ban Chấp hành Trung ương gắn với việc học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh thông qua việc xây dựng bộ máy hành chính nhà nước, trong đó có ngành Thuế, tinh gọn, hiệu lực, hiệu quả. Điều này đòi hỏi các đơn vị thuộc ngành Thuế phải tăng cường quản lý nội ngành, kỷ luật, kỷ cương, nhằm hoàn thành tốt nhiệm vụ thu ngân sách nhà nước, phục vụ người dân và doanh nghiệp tốt hơn, thể hiện rõ nét tinh thần trách nhiệm và “Vì nhân dân phục vụ” mà Chủ tịch Hồ Chí Minh đã dạy.</p><p>* Sự cần thiết, mục đích của việc thực hiện sáng kiến:</p><p>Sinh thời, Chủ tịch Hồ Chí Minh rất quan tâm đến công tác tư tưởng. Người cho rằng: “Trong đảng và ngoài đảng có nhận rõ tình hình mới, hiểu rõ nhiệm vụ mới thì tư tưởng mới thống nhất, tư tưởng thống nhất thì hành động mới thống nhất”. Công tác tư tưởng tự bản thân nó đã hàm chứa những vấn đề nhạy cảm, phức tạp, đa chiều liên quan đến tâm tư, nguyện vọng của đảng viên, công chức.</p><p>Hiện nay, việc sắp xếp, tinh gọn bộ máy đã và đang được triển khai quyết liệt ở các cấp, các ngành từ Trung ương đến địa phương, với mục tiêu xây dựng một hệ thống chính trị, gọn nhẹ, minh bạch, vững mạnh, hoạt động hiệu lực, hiệu quả. Lợi dụng vấn đề, các thế lực thù địch tăng cường tung tin, vu khống, xuyên tạc, chống phá Đảng và Nhà nước ta. Vì lẽ đó, đội ngũ cán bộ, đảng viên, công chức cần thống nhất trong nhận thức và hành động, tỉnh táo trước những luận điệu xuyên tác, lực lượng thù địch. Thực hiện Nghị quyết số 18-NQ/TW của Ban Chấp hành Trung ương khóa XII về một số vấn đề tiếp tục đổi mới, sắp xếp tổ chức bộ máy của hệ thống chính trị tinh gọn, hoạt động hiệu lực, hiệu quả; Kết luận số 09-KL/BCĐ ngày 24/11/2024 của Ban Chỉ đạo Trung ương về việc tiếp tục đẩy mạnh việc sắp xếp, tinh gọn bộ máy; Chỉ thị số 03/CT-BTC ngày 03/12/2024 của Bộ trưởng Bộ Tài chính về công tác đổi mới, sắp xếp tổ chức bộ máy Bộ Tài chính. Theo đó, trong thời gian qua, ngành Thuế đã quyết liệt, chủ động trong xây dựng và hoàn thiện phương án sắp xếp, tinh gọn tổ chức, bộ máy cơ quan thuế các cấp theo đúng chủ trương, định hướng của Đảng, Nhà nước và của Bộ Tài chính. Bên cạnh việc tinh gọn bộ máy giúp cơ quan thuế nâng cao hiệu năng, hiệu lực, hiệu quả hoạt động, thì quá trình sắp xếp cơ cấu tổ chức cũng sẽ phát sinh những vấn đề nhạy cảm, phức tạp như: cắt giảm biên chế, sắp xếp lại đội ngũ, dôi dư cấp lãnh đạo, khoảng cách địa lý, môi trường làm việc thay đổi,...ảnh hưởng trực tiếp đến tâm lý và quyền lợi của công chức, người lao động, đòi hỏi phải có sự thống nhất cao về nhận thức và hành động, quyết tâm chính trị mạnh mẽ. Đặc biệt, Cục Thuế tỉnh Bạc Liêu thuộc địa bàn tỉnh Bạc Liêu (trước sắp xếp) là đơn vị chịu sự tác động trực tiếp khi sắp xếp chính quyền địa phương 02 cấp. Sự đổi mới này không tránh khỏi những khó khăn, thách thức. Mỗi quyết định đưa ra đều là kết quả của những trăn trở, cân nhắc kỹ lưỡng để hài hòa giữa lợi ích chung và nguyện vọng chính đáng của từng công chức. Xuất phát từ tình hình trên, nhóm chúng tôi đã đưa ra “Một số giải pháp chủ yếu nhằm làm tốt công tác tư tưởng trước, trong và sau khi sắp xếp tổ chức bộ máy ngành Thuế tỉnh theo Nghị quyết số 18-NQ/TW ngày 25/10/2017 của Ban Chấp hành Trung ương gắn với việc học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh”.</p><p>b. Nội dung sáng kiến:</p><p>Trước ngày 01/3/2025, Cục Thuế tỉnh Cà Mau và Cục Thuế tỉnh Bạc Liêu gồm có: 22 phòng, 08 Chi cục Thuế thành phố, khu vực, 47 đội thuế, có tổng số 756 công chức và người lao động, trong đó: Biên chế: 681 công chức, 75 hợp đồng.  Ngành Thuế đã thực hiện hai lần sắp xếp bộ máy. Lần thứ nhất từ ngày 01/3/2025 theo Quyết định 381/QĐ-BTC của Bộ Tài chính. Tiếp đó, thực hiện Nghị quyết 60-NQ/TW ngày 12/4/2025 của Ban Chấp hành Trung ương Đảng về mô hình chính quyền địa phương 2 cấp, Bộ Tài chính ban hành Quyết định 2229/QĐ-BTC (có hiệu lực từ 1/7/2025). Theo đó, sắp xếp Thuế tỉnh Cà Mau gồm có 9 phòng và 8 đơn vị Thuế cơ sở, 35 tổ, có tổng số 529 công chức và người lao động, trong đó: Biên chế: 472 công chức và 57 người lao động. Như vậy ngành Thuế đã đồng bộ với mô hình chính quyền địa phương 2 cấp, đã cắt giảm mạnh từ hơn 77 đầu mối xuống còn hơn 52 đầu mối. Bằng việc chuyển đổi từ mô hình “quản lý thuế theo chức năng, kết hợp với đối tượng” sang mô hình “quản lý theo đối tượng, kết hợp với chức năng” là bước ngoặt mang tính chiến lược. Mỗi công chức thuế giờ đây không chỉ thực hiện chuyên môn đơn lẻ mà còn là người đồng hành, hỗ trợ toàn diện cho người nộp thuế. Điều này không chỉ đòi hỏi năng lực chuyên môn cao mà còn là sự tận tâm, trách nhiệm và sẵn sàng thích nghi với sự thay đổi. Bên cạnh đó, ngày 14/02/2025, Tổng Cục Thuế có Công văn số 640/TCT-TCCB yêu cầu toàn ngành Thuế quán triệt thực hiện tốt công tác chính trị, tư tưởng, công tác chuyên môn khi sắp xếp, tinh gọn bộ máy. Qua đó, nhóm rút ra một số giải pháp chủ yếu nhằm làm tốt công tác tư tưởng trước, trong và sau khi sắp xếp tổ chức bộ máy ngành Thuế tỉnh theo Nghị quyết số 18-NQ/TW ngày 25/10/2017 của Ban Chấp hành Trung ương như sau:</p><p>Một là. Tăng cường kỷ luật, kỷ cương nội ngành: Ngành Thuế tỉnh tăng cường tái cấu trúc bộ máy, thực hiện siết chặt kỷ luật, kỷ cương trong thực thi công vụ và trong công tác quản lý thuế, đảm bảo hoàn thành xuất sắc các nhiệm vụ được giao. Xác định rõ việc sắp xếp, tinh gọn bộ máy là nhiệm vụ đặc biệt quan trọng, là đòi hỏi tất yếu nhằm nâng cao hiệu năng, hiệu lực, hiệu quả hoạt động của bộ máy vì sự phát triển bền vững của đất nước trong kỷ nguyên mới; tạo sự đồng thuận, thống nhất trong đội ngũ công chức, người lao động khi thực hiện việc sắp xếp, tinh gọn bộ máy.</p><p>Hai là, Xác định tầm quan trọng trong công tác giáo dục chính trị, tư tưởng có ý nghĩa quyết định đến việc xây dựng Đảng vững mạnh về chính trị, tư tưởng, đạo đức, tổ chức và cán bộ, làm cơ sở để nâng cao năng lực lãnh đạo, năng lực cầm quyền, sức chiến đấu của Đảng và hiệu lực hiệu quả quản lý Nhà nước. Đảng ủy thường xuyên chỉ đạo cấp ủy trực thuộc nâng cao chất lượng công tác tuyên truyền, giáo dục, học tập, quán triệt chủ nghĩa Mác-Lênin, tư tưởng Hồ Chí Minh cho cán bộ, đảng viên, công chức. Ngoài ra còn tổ chức các cuộc hội nghị để kịp thời thông tin thời sự về tình hình quốc tế, trong nước và trong tỉnh cho toàn thể cán bộ, đảng viên, công chức trong cơ quan theo chỉ đạo của Ban Thường vụ Tỉnh ủy, Ban Thường vụ Đảng ủy Khối...</p><p>Đặc biệt Đảng ủy Cục Thuế đẩy mạnh việc học tập và làm theo tư tưởng, đạo đức phong cách Hồ Chí Minh theo Kết luận số 21-KL/TW của Bộ Chính trị về tiếp tục thực hiện Chỉ thị số 05-CT/TW, ngày 15/5/2016 của Bộ Chính trị về “Đẩy mạnh học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh”. Để tăng cường sự đoàn kết thống nhất ở cấp ủy và các chi bộ trực thuộc Đảng bộ, từ Cục Thuế đến các Chi cục Thuế trực thuộc, tạo nên sự thống nhất từ tư tưởng đến hành động của mỗi đảng viên, công chức. Hàng năm căn cứ vào văn bản hướng dẫn của Đảng ủy Khối. Đảng ủy Cục Thuế đã xây dựng và ban hành Kế hoạch học tập, đề ra phương hướng, nhiệm vụ, các giải pháp để thực hiện nhằm đảm bảo tính kịp thời và phù hợp với định hướng chỉ đạo của cấp trên. Nội dung triển khai thực hiện việc học tập và làm theo Bác trên tinh thần sáng tạo và phù hợp với điều kiện, hoàn cảnh, thực tế của đơn vị theo từng giai đoạn nhất định. Đảng ủy Cục Thuế đề nghị mỗi một chi bộ xây dựng mô hình học tập Bác, gắn với nhiệm vụ chuyên môn của ngành, với phong trào thi đua: “Vì người nghèo - Không để ai bị bỏ lại phía sau”, “Cả nước chung sức xây dựng nông thôn mới”, phong trào thi đua: “Đẩy mạnh phát triển kết cấu hạ tầng đồng bộ, hiện đại; thực hành tiết kiệm, chống lãng phí”, phong trào Ba không: “Không né tránh công việc, không đùn đẩy công việc sang người khác, không làm việc vì lợi ích và động cơ cá nhân”, phong trào vượt qua khó khăn, thách thức vươn lên hoàn thành tốt nhiệm vụ được giao của cá nhân, của cơ quan, đơn vị và của ngành....Mô hình được thực hiện bằng công trình, phần việc cụ thể. Các chi bộ đăng ký mô hình, xây dựng kế hoạch và có báo cáo kết quả thực hiện mô hình về Ban thường vụ Đảng ủy để theo dõi, đánh giá và biểu dương điển hình tiên tiến. Từng cán bộ, đảng viên, công chức xây dựng kế hoạch đăng ký công trình, phần việc cụ thể nội dung học tập và làm theo tư tưởng, đạo đức, phong cách của Bác đúng theo hướng dẫn, phù hợp với bản thân về chức năng, nhiệm vụ chuyên môn được giao, để có giải pháp học tập và làm theo. Qua việc học tập và làm theo Bác, nhận thức của đảng viên, công chức được nâng lên rõ rệt, nâng cao ý thức tự giác, có trách nhiệm hơn trong công việc; có tinh thần, thái độ phục vụ Nhân dân. Từ đó góp phần làm tốt công tác chính trị, tư tưởng đối với cán bộ, đảng viên, công chức, người lao động tại đơn vị; nâng cao tinh thần trách nhiệm, thống nhất nhận thức và hành động của từng cấp đơn vị và mỗi công chức, người lao động trong hệ thống thuế, nhất là đảng viên, công chức lãnh đạo để vừa hoàn thành tốt nhiệm vụ công tác sắp xếp, tinh gọn bộ máy theo chủ trương, chỉ đạo của Đảng, Nhà nước và Bộ Tài chính, vừa hoàn thành toàn diện các nhiệm vụ công tác được giao.</p><p>Ba là. Công tác sắp xếp, bố trí nhân sự căn cứ vào năng lực, phẩm chất và nhu cầu thực tế công việc đảm bảo công bằng, khách quan. Quán triệt, tuyên truyền công chức, người lao động về việc sau khi bộ máy mới đi vào hoạt động, dù trên cương vị nào cũng phải nỗ lực cao nhất, khắc phục mọi khó khăn, thách thức, bắt tay ngay vào công việc mới để hoàn thành tốt các nhiệm vụ được giao.</p><p>Bốn là. Phát huy vai trò các tổ chức đoàn thể quan tâm, lắng nghe, chia sẽ, nắm bắt tâm tư, nguyện vọng của công chức, người lao động từ đó kịp thời phản ánh và đề xuất các giải pháp giải quyết vấn đề phát sinh trong quá trình sắp xếp, đảm bảo quyền lợi chính đáng của công chức, người lao động. Đồng thời, kiên quyết đấu tranh đối với những biểu hiện tiêu cực, cản trở quá trình tinh gọn bộ máy, phản bác những luận điệu xuyên tạc, kích động, trái với chủ trương của Đảng và Nhà nước, gây mất đoàn kết trong cơ quan, đơn vị.</p><p>Năm là. Đẩy nhanh tiến độ xử lý công việc đúng hạn rà soát xử lý dứt điểm các công việc, hồ sơ hành chính về thuế, kiến nghị, phản ánh vướng mắc của người nộp thuế. Trường hợp quá hạn không có lý do chính đáng, đúng pháp luật sẽ bị xem xét trách nhiệm theo quy định.</p><p>* Tính mới của sáng kiến: Điểm mới của sáng kiến chính là công tác giáo dục chính trị, tư tưởng, đạo đức, lối sống đảng viên, công chức thông qua các kế hoạch học tập, từ chủ đề đến hình thức học tập, nội dung triển khai thực hiện được xây dựng phù hợp điều kiện, hoàn cảnh, tình hình đất nước. Các chủ đề học tập do Đảng ủy soạn thảo đảm bảo tính kịp thời và phù hợp với quan điểm chỉ đạo của Đảng, Nhà nước với chuyên môn nghiệp vụ của ngành theo từng thời điểm, từng giai đoạn nhất định. Từ đó, tạo được mối quan hệ chặt chẽ, thống nhất giữa “học tập, làm theo và nêu gương”, nhận thức và hành động, giữa học và hành, giữa lời nói và việc làm. Được Đảng ủy Cục Thuế (nay là Đảng ủy Thuế tỉnh) quán triệt nhận thức từ trong Đảng ủy đến các Chi bộ trực thuộc, tổ đảng; từ Cơ quan Thuế tỉnh đến các Chi cục Thuế, đội thuế (nay là các Thuế cơ sở, tổ). Từ đó nâng cao nhận thức cán bộ, đảng viên, công chức thông qua học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh trong tình hình hiện nay. Góp phần nâng cao năng lực lãnh đạo và sức chiến đấu trong Đảng bộ Thuế tỉnh, góp phần xây dựng Đảng bộ Thuế tỉnh trong sạch, vững mạnh. Các mô hình, công trình, phần việc được các Chi bộ thực hiện gắn với nhiệm vụ chuyên môn của ngành, với các phong trào thi đua yêu nước. Tạo sự liên kết chặt chẽ giữa Tổ chức Đảng, chính quyền, đoàn thể quần chúng trong toàn ngành Thuế của Tỉnh. Chỉ có “Nhận thức đúng thì Hành động đúng”, là một công chức ngành Thuế, bản thân nhận thức được trách nhiệm cũng như vị trí, vai trò của mình trong từng nhiệm vụ cụ thể thì đối với việc hoàn thành nhiệm vụ chính trị của ngành hay để giữ gìn kỷ luật, kỷ cương, nâng cao hiệu quả thực thi pháp luật trong thực hiện nhiệm vụ trên tinh thần “Chỉ tiêu một - Kế hoạch năm - Quyết tâm phải là mười” sẽ luôn đạt được kết quả cao nhất.</p><p>c. Hiệu quả và phạm vi áp dụng của sáng kiến, giải pháp: Đến nay, hệ thống tổ chức mới đã đi vào hoạt động ổn định, quá trình triển khai diễn ra thông suốt, không bị gián đoạn. Mô hình mới tạo thuận lợi cho người nộp thuế trong thực hiện thủ tục hành chính, đồng thời đáp ứng yêu cầu ứng dụng công nghệ thông tin, chuyển đổi số và hiện đại hóa ngành Thuế. Bố trí nhân sự đảm bảo công bằng, khách quan. Quán triệt, tuyên truyền công chức, người lao động về việc trước, trong và sau khi bộ máy mới đi vào hoạt động, dù trên cương vị nào cũng phải nổ lực cao nhất, khắc phục mọi khó khăn, thách thức, bắt tay ngay vào công việc mới để hoàn thành tốt các nhiệm vụ được giao. Với mục tiêu xây dựng bộ máy cơ quan thuế hiện đại, tinh gọn, hoạt động hiệu lực, hiệu quả, có đủ quyền hạn và năng lực chủ động thực thi pháp luật Thuế, đồng thời để phát triển nguồn nhân lực chất lượng cao, chuyên sâu, chuyên nghiệp, liêm chính, đổi mới, đáp ứng yêu cầu quản lý Thuế trong bối cảnh nền kinh tế số, phù hợp với xu thuế hội nhập quốc tế. Rèn luyện đội ngũ công chức ngành Thuế của Tỉnh biết Chấp nhận thử thách -  Vượt qua khó khăn - Cọ sát thực tiễn - Hoàn thành nhiệm vụ. Kết quả thu ngân sách 9 tháng đầu năm 2025, Thuế tỉnh Cà Mau đạt tỷ lệ 84% (8.400 tỷ đồng/10.053 tỷ đồng) là minh chứng tiêu biểu cho sự đồng lòng, quyết tâm chính trị của ngành Thuế tỉnh Cà Mau.</p><p>- Đối tượng, đơn vị áp dụng: Toàn thể Công chức và người lao động thuộc Thuế tỉnh Cà Mau.</p><p>- Phạm vi, khả năng nhân rộng: Thuế tỉnh Cà Mau và Bộ Tài chính</p><p>5. Hội đồng cơ sở đã xét công nhận sáng kiến: Quyết định số 1109/QĐ-CMA ngày 23 tháng 10 năm 2025.</p><p>6. Thời gian áp dụng: 01/10/2024./.</p>', '231ff6d92192d68d6dd2cb888f7f6354b920e735a24251ca373c051232b30553', '2026-09-21 16:06:22');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `qlsk_hoi_dong`
--

CREATE TABLE `qlsk_hoi_dong` (
  `id` int(10) UNSIGNED NOT NULL,
  `nam_id` int(10) UNSIGNED NOT NULL,
  `ma` varchar(50) NOT NULL,
  `ten` varchar(255) NOT NULL,
  `ngay_thanh_lap` date NOT NULL,
  `mo_ta` varchar(1000) DEFAULT NULL,
  `trang_thai` enum('DU_KIEN','DANG_HOAT_DONG','DA_HOAN_THANH','DA_HUY') NOT NULL DEFAULT 'DU_KIEN',
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `version` int(10) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `qlsk_kiem_tra_trung_dot`
--

CREATE TABLE `qlsk_kiem_tra_trung_dot` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nam_id` int(10) UNSIGNED NOT NULL,
  `trang_thai` enum('CHO_XU_LY','DANG_XU_LY','HOAN_TAT','LOI') NOT NULL DEFAULT 'CHO_XU_LY',
  `tong_so` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `da_xu_ly` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `so_phat_hien` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `started_at` datetime DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `qlsk_kiem_tra_trung_ket_qua`
--

CREATE TABLE `qlsk_kiem_tra_trung_ket_qua` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `dot_id` bigint(20) UNSIGNED NOT NULL,
  `sang_kien_id` bigint(20) UNSIGNED NOT NULL,
  `doi_tuong_sang_kien_id` bigint(20) UNSIGNED NOT NULL,
  `ty_le_ten` decimal(5,2) DEFAULT NULL,
  `ty_le_tai_lieu` decimal(5,2) DEFAULT NULL,
  `ty_le_tfidf` decimal(5,2) DEFAULT NULL,
  `ty_le_semantic` decimal(5,2) DEFAULT NULL,
  `ty_le_tong` decimal(5,2) DEFAULT NULL,
  `ket_qua` enum('THAP','TRUNG_BINH','CAO','RAT_CAO') NOT NULL DEFAULT 'THAP',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `qlsk_lich_su_trang_thai`
--

CREATE TABLE `qlsk_lich_su_trang_thai` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sang_kien_id` bigint(20) UNSIGNED NOT NULL,
  `trang_thai_cu` varchar(30) DEFAULT NULL,
  `trang_thai_moi` varchar(30) NOT NULL,
  `nguoi_thuc_hien_id` bigint(20) DEFAULT NULL,
  `ly_do` varchar(1000) DEFAULT NULL,
  `ghi_chu` varchar(1000) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `qlsk_linh_vuc`
--

CREATE TABLE `qlsk_linh_vuc` (
  `id` int(10) UNSIGNED NOT NULL,
  `ma` varchar(30) NOT NULL,
  `ten` varchar(255) NOT NULL,
  `mo_ta` varchar(1000) DEFAULT NULL,
  `thu_tu` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `trang_thai` enum('HOAT_DONG','NGUNG') NOT NULL DEFAULT 'HOAT_DONG',
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `version` int(10) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `qlsk_linh_vuc`
--

INSERT INTO `qlsk_linh_vuc` (`id`, `ma`, `ten`, `mo_ta`, `thu_tu`, `trang_thai`, `created_by`, `updated_by`, `created_at`, `updated_at`, `version`) VALUES
(1, 'CNTT', 'Công nghệ thông tin', 'Ứng dụng CNTT, phần mềm, chuyển đổi số', 1, 'HOAT_DONG', NULL, NULL, '2026-09-21 02:17:06', '2026-09-21 02:17:06', 1),
(2, 'DT', 'Dự toán', 'Dự toán', 2, 'HOAT_DONG', NULL, NULL, '2026-09-21 02:21:19', '2026-09-21 02:21:19', 1),
(3, 'HTNNT', 'Hỗ trợ người nộp thuế', 'Hỗ trợ người nộp thuế', 3, 'HOAT_DONG', NULL, NULL, '2026-09-21 02:21:19', '2026-09-21 02:21:19', 1),
(4, 'HCTVTCNS', 'Hành chính, Tài vụ, Tổ chức, Nhân sự', 'Hành chính, Tài vụ, Tổ chức, Nhân sự', 4, 'HOAT_DONG', NULL, NULL, '2026-09-21 02:21:19', '2026-09-21 02:21:19', 1),
(5, 'KT', 'Kiểm tra', 'Kiểm tra', 5, 'HOAT_DONG', NULL, NULL, '2026-09-21 02:21:19', '2026-09-21 02:21:19', 1),
(6, 'TK', 'Thống kê', 'Thống kê', 6, 'HOAT_DONG', NULL, NULL, '2026-09-21 02:21:19', '2026-09-21 02:21:19', 1),
(7, 'K', 'Khác', 'Khác', 6, 'HOAT_DONG', NULL, NULL, '2026-09-21 02:21:19', '2026-09-21 02:21:19', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `qlsk_nam`
--

CREATE TABLE `qlsk_nam` (
  `id` int(10) UNSIGNED NOT NULL,
  `nam` smallint(5) UNSIGNED NOT NULL,
  `ten` varchar(255) NOT NULL,
  `tu_ngay` date NOT NULL,
  `den_ngay` date NOT NULL,
  `tu_dong_mo` tinyint(1) NOT NULL DEFAULT 1,
  `tu_dong_khoa` tinyint(1) NOT NULL DEFAULT 1,
  `trang_thai` enum('CHUA_MO','DANG_MO','DA_KHOA') NOT NULL DEFAULT 'CHUA_MO',
  `mo_ta` varchar(1000) DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `version` int(10) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `qlsk_nam`
--

INSERT INTO `qlsk_nam` (`id`, `nam`, `ten`, `tu_ngay`, `den_ngay`, `tu_dong_mo`, `tu_dong_khoa`, `trang_thai`, `mo_ta`, `created_by`, `updated_by`, `created_at`, `updated_at`, `version`) VALUES
(1, 2024, '', '0000-00-00', '0000-00-00', 1, 1, 'DANG_MO', NULL, NULL, NULL, '2026-09-21 02:15:14', '2026-09-21 02:16:07', 1),
(2, 2025, '', '0000-00-00', '0000-00-00', 1, 1, 'DANG_MO', NULL, NULL, NULL, '2026-09-21 02:15:14', '2026-09-21 02:16:10', 1),
(3, 2026, '', '0000-00-00', '0000-00-00', 1, 1, 'DANG_MO', NULL, NULL, NULL, '2026-09-21 02:15:14', '2026-09-21 02:16:13', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `qlsk_phan_cong_cham`
--

CREATE TABLE `qlsk_phan_cong_cham` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `thanh_vien_hoi_dong_id` bigint(20) UNSIGNED NOT NULL,
  `sang_kien_id` bigint(20) UNSIGNED NOT NULL,
  `trang_thai` enum('CHUA_CHAM','DANG_CHAM','DA_CHAM','HUY') NOT NULL DEFAULT 'CHUA_CHAM',
  `ngay_phan_cong` datetime NOT NULL DEFAULT current_timestamp(),
  `ngay_bat_dau_cham` datetime DEFAULT NULL,
  `ngay_hoan_thanh` datetime DEFAULT NULL,
  `ghi_chu` varchar(1000) DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `version` int(10) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `qlsk_sang_kien`
--

CREATE TABLE `qlsk_sang_kien` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nam_id` int(10) UNSIGNED NOT NULL,
  `linh_vuc_id` int(10) UNSIGNED DEFAULT NULL,
  `loai_sang_kien` enum('NOI_BO','KHAC_CQT') NOT NULL DEFAULT 'NOI_BO',
  `ten_co_quan_thue` varchar(255) DEFAULT NULL,
  `ma` varchar(50) NOT NULL,
  `ten` varchar(500) NOT NULL,
  `noi_dung` longtext DEFAULT NULL,
  `muc_tieu` longtext DEFAULT NULL,
  `ket_qua_du_kien` longtext DEFAULT NULL,
  `ngay_nop` datetime DEFAULT NULL,
  `trang_thai` enum('DA_NOP','DANG_CHAM','DA_CHAM') DEFAULT NULL,
  `ghi_chu` text DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `version` int(10) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `qlsk_sang_kien`
--

INSERT INTO `qlsk_sang_kien` (`id`, `nam_id`, `linh_vuc_id`, `loai_sang_kien`, `ten_co_quan_thue`, `ma`, `ten`, `noi_dung`, `muc_tieu`, `ket_qua_du_kien`, `ngay_nop`, `trang_thai`, `ghi_chu`, `created_by`, `updated_by`, `created_at`, `updated_at`, `version`) VALUES
(23, 2, 4, 'KHAC_CQT', 'Phòng TCCB - Thuế tỉnh Cà Mau', 'SK-TCCB-001', 'Kỹ năng xây dựng phương án giao biên chế cho các đơn vị', '', '', '', NULL, NULL, '', NULL, NULL, '2026-09-21 06:51:55', '2026-09-22 02:56:09', 1),
(24, 2, 7, 'KHAC_CQT', 'Phòng TCCB - Thuế tỉnh Cà Mau', 'SK-TCCB-002', 'Một số giải pháp góp phần nâng cao trách nhiệm công chức thuế trong thực thi công vụ', '', '', '', NULL, NULL, '', NULL, NULL, '2026-09-21 06:52:50', '2026-09-21 06:52:50', 1),
(27, 2, 7, 'KHAC_CQT', 'Phòng TCCB - Thuế tỉnh Cà Mau', 'SK-TCCB-003', 'Một số giải pháp chủ yếu nhằm làm tốt công tác tư tưởng trước, trong và sau khi sắp xếp tổ chức bộ máy ngành Thuế tỉnh theo Nghị quyết số 18-NQ/TW ngày 25/10/2017 của Ban Chấp hành Trung ương gắn với việc học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh', '', '', '', NULL, NULL, '', NULL, NULL, '2026-09-21 09:06:22', '2026-09-21 09:06:22', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `qlsk_sang_kien_tac_gia`
--

CREATE TABLE `qlsk_sang_kien_tac_gia` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sang_kien_id` bigint(20) UNSIGNED NOT NULL,
  `nhan_vien_id` bigint(20) NOT NULL,
  `vai_tro` enum('TAC_GIA','DONG_TAC_GIA') NOT NULL,
  `thu_tu` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `qlsk_thanh_vien_hoi_dong`
--

CREATE TABLE `qlsk_thanh_vien_hoi_dong` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `hoi_dong_id` int(10) UNSIGNED NOT NULL,
  `nhan_vien_id` bigint(20) NOT NULL,
  `vai_tro` enum('CHU_TICH','PHO_CHU_TICH','THU_KY','UY_VIEN') NOT NULL DEFAULT 'UY_VIEN',
  `thu_tu` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `trang_thai` enum('HOAT_DONG','NGUNG') NOT NULL DEFAULT 'HOAT_DONG',
  `ghi_chu` varchar(1000) DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `version` int(10) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `quyen`
--

CREATE TABLE `quyen` (
  `id` bigint(20) NOT NULL,
  `module` varchar(100) DEFAULT NULL,
  `ma_quyen` varchar(100) DEFAULT NULL,
  `ten_quyen` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `quyen`
--

INSERT INTO `quyen` (`id`, `module`, `ma_quyen`, `ten_quyen`) VALUES
(44, 'dashboard', 'dashboard.view', 'Xem trang chủ'),
(45, 'leave.approve', 'leave.approve.view', 'Xem nghỉ phép'),
(46, 'leave.apply', 'leave.apply.create', 'Tạo đơn nghỉ phép'),
(47, 'leave.approve', 'leave.approve.update', 'Sửa đơn nghỉ phép'),
(48, 'leave.approve', 'leave.approve.delete', 'Xóa đơn nghỉ phép'),
(49, 'leave.approve', 'leave.approve.approve', 'Duyệt nghỉ phép'),
(51, 'trip', 'trip.view', 'Xem công tác'),
(52, 'trip', 'trip.create', 'Tạo công tác'),
(53, 'trip', 'trip.update', 'Sửa công tác'),
(54, 'trip', 'trip.delete', 'Xóa công tác'),
(55, 'trip', 'trip.export', 'Xuất Excel công tác'),
(56, 'employee', 'employee.view', 'Xem nhân viên'),
(57, 'employee', 'employee.create', 'Thêm nhân viên'),
(58, 'employee', 'employee.update', 'Sửa nhân viên'),
(59, 'employee', 'employee.delete', 'Xóa nhân viên'),
(60, 'employee', 'employee.reset_password', 'Đặt lại mật khẩu'),
(61, 'employee', 'employee.export', 'Xuất Excel nhân viên'),
(62, 'catalog', 'catalog.view', 'Xem danh mục'),
(63, 'catalog', 'catalog.create', 'Thêm danh mục'),
(64, 'catalog', 'catalog.update', 'Sửa danh mục'),
(65, 'catalog', 'catalog.delete', 'Xóa danh mục'),
(66, 'report', 'report.view', 'Xem báo cáo'),
(67, 'report', 'report.export', 'Xuất báo cáo'),
(68, 'system', 'system.config', 'Cấu hình hệ thống'),
(69, 'system', 'role.view', 'Xem phân quyền'),
(70, 'system', 'role.create', 'Tạo vai trò'),
(71, 'system', 'role.update', 'Sửa vai trò'),
(72, 'system', 'role.delete', 'Xóa vai trò'),
(73, 'system', 'role.assign_permission', 'Gán quyền vai trò'),
(74, 'system', 'account.view', 'Xem tài khoản'),
(75, 'system', 'account.create', 'Tạo tài khoản'),
(76, 'system', 'account.update', 'Sửa tài khoản'),
(77, 'system', 'account.delete', 'Xóa tài khoản'),
(78, 'leave', 'leave.balance', 'Số dư phép năm'),
(79, 'leave.balance', 'leave.balance.create', 'Tạo phép năm'),
(80, 'leave.balance', 'leave.balance.transfer', 'Kết chuyển phép tồn'),
(81, 'leave.balance', 'leave.balance.edit', 'Cập nhật số dư phép');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `so_du_phep`
--

CREATE TABLE `so_du_phep` (
  `id` bigint(20) NOT NULL,
  `id_nhan_vien` bigint(20) NOT NULL,
  `nam` int(11) NOT NULL,
  `tong_ngay` decimal(5,2) DEFAULT 12.00,
  `da_dung` decimal(5,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `so_du_phep`
--

INSERT INTO `so_du_phep` (`id`, `id_nhan_vien`, `nam`, `tong_ngay`, `da_dung`) VALUES
(9, 54, 2026, 19.00, 0.00),
(10, 55, 2026, 14.00, 0.00),
(11, 56, 2026, 15.00, 0.00),
(12, 57, 2026, 18.00, 0.00),
(13, 58, 2026, 12.00, 0.00),
(14, 59, 2026, 12.00, 0.00),
(15, 60, 2026, 12.00, 3.00),
(16, 61, 2026, 13.00, 0.00),
(17, 62, 2026, 13.00, 0.00),
(18, 63, 2026, 14.00, 0.00),
(19, 64, 2026, 18.00, 0.00),
(20, 65, 2026, 18.00, 0.00),
(21, 66, 2026, 18.00, 0.00),
(22, 67, 2026, 17.00, 0.00),
(23, 68, 2026, 13.00, 0.00),
(24, 69, 2026, 16.00, 0.00),
(25, 70, 2026, 12.00, 0.00),
(26, 71, 2026, 12.00, 0.00),
(27, 72, 2026, 15.00, 0.00),
(28, 73, 2026, 16.00, 0.00),
(29, 74, 2026, 15.00, 0.00),
(30, 75, 2026, 12.00, 0.00),
(31, 76, 2026, 12.00, 0.00),
(32, 77, 2026, 13.00, 0.00),
(33, 78, 2026, 16.00, 0.00),
(34, 79, 2026, 17.00, 0.00),
(35, 80, 2026, 16.00, 0.00),
(36, 81, 2026, 16.00, 0.00),
(37, 82, 2026, 15.00, 0.00),
(38, 83, 2026, 14.00, 0.00),
(39, 84, 2026, 14.00, 0.00),
(40, 85, 2026, 16.00, 0.00),
(41, 86, 2026, 14.00, 0.00),
(42, 87, 2026, 15.00, 0.00),
(43, 88, 2026, 15.00, 0.00),
(44, 89, 2026, 15.00, 0.00),
(45, 90, 2026, 16.00, 0.00),
(46, 91, 2026, 16.00, 0.00),
(47, 92, 2026, 15.00, 0.00),
(48, 93, 2026, 15.00, 0.00);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tai_khoan`
--

CREATE TABLE `tai_khoan` (
  `id` bigint(20) NOT NULL,
  `id_nhan_vien` bigint(20) NOT NULL,
  `ten_dang_nhap` varchar(100) NOT NULL,
  `mat_khau` varchar(255) NOT NULL,
  `dang_hoat_dong` tinyint(4) DEFAULT 1,
  `lan_dang_nhap_cuoi` datetime DEFAULT NULL,
  `ip_cuoi` varchar(50) DEFAULT NULL,
  `doi_mat_khau_luc` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tai_khoan`
--

INSERT INTO `tai_khoan` (`id`, `id_nhan_vien`, `ten_dang_nhap`, `mat_khau`, `dang_hoat_dong`, `lan_dang_nhap_cuoi`, `ip_cuoi`, `doi_mat_khau_luc`, `created_at`, `updated_at`) VALUES
(16, 60, 'tmtri.cma', '$2y$12$PzlJXlC99hGGpqXr2sho5ur9Jity1KsPZPr/i7XWNat5vZv4T0ij6', 1, NULL, NULL, NULL, '2026-05-07 17:28:24', '2026-05-10 10:37:58'),
(19, 59, 'nqtuong.cma', '$2y$12$i8DvmGNJ1T5Gqi/kZXD5Zuhc6iXqBfYrqcUvo5INK4nLfClMiA9D2', 1, NULL, NULL, NULL, '2026-05-09 11:23:31', '2026-05-09 11:23:31'),
(20, 54, 'dvan.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(21, 55, 'tttrang.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(22, 56, 'tmthuong.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(23, 57, 'clhung.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(24, 58, 'mctien.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(25, 61, 'mtaloc.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(26, 62, 'pnngan.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(27, 63, 'tdtvi.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(28, 64, 'ttvu.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(29, 65, 'hqhung.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(30, 66, 'dqdat.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(31, 67, 'tqtuan.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(32, 68, 'thhue.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(33, 69, 'ntvanh.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(34, 70, 'tccuong.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(35, 71, 'ntduy.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(36, 72, 'dvpha.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(37, 73, 'lthien.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(38, 74, 'lvtoan.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(39, 75, 'pnlai.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(40, 76, 'tgphung.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(41, 77, 'nptung.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(42, 78, 'lththao.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(43, 79, 'dnvien.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(44, 80, 'lvmun.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(45, 81, 'ttduy.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(46, 82, 'lhthi.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(47, 83, 'ctkhue.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(48, 84, 'pbha.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(49, 85, 'pttthuy.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(50, 86, 'tbthuy.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(51, 87, 'tttlam.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(52, 88, 'vtlinh.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(53, 89, 'ptmlinh.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(54, 90, 'ntmduyen.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(55, 91, 'nthue.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(56, 92, 'nmtruong.cma', '$2y$10$2b7Wq80MTjD.Zh8M.pd6Z.68QxrfCVcpd.IyqixyMxR.Bz4eHfuR.', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-09 18:59:13'),
(57, 93, 'qpminh.cma', '$2y$12$CphL/NZUEbAGZOET9NexFe9.ATMnEukQWwNO6z0vJaG4G0yMx6I0C', 1, NULL, NULL, NULL, '2026-05-09 18:59:13', '2026-05-10 04:51:51');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tai_khoan_vai_tro`
--

CREATE TABLE `tai_khoan_vai_tro` (
  `id` bigint(20) NOT NULL,
  `id_tai_khoan` bigint(20) NOT NULL,
  `id_vai_tro` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tai_khoan_vai_tro`
--

INSERT INTO `tai_khoan_vai_tro` (`id`, `id_tai_khoan`, `id_vai_tro`) VALUES
(8, 16, 14),
(9, 19, 19),
(10, 20, 15),
(12, 21, 16),
(26, 22, 17),
(27, 23, 18),
(28, 24, 14),
(22, 25, 19),
(21, 26, 19),
(20, 27, 19),
(19, 28, 19),
(52, 29, 17),
(53, 30, 18),
(49, 31, 18),
(57, 32, 19),
(47, 33, 19),
(46, 34, 19),
(56, 35, 19),
(51, 36, 17),
(50, 37, 18),
(43, 38, 19),
(55, 39, 19),
(42, 40, 19),
(41, 41, 19),
(54, 42, 19),
(38, 43, 17),
(39, 44, 18),
(40, 45, 18),
(34, 46, 19),
(33, 47, 19),
(32, 48, 19),
(31, 49, 19),
(30, 50, 19),
(29, 51, 19),
(18, 52, 19),
(17, 53, 19),
(16, 54, 19),
(15, 55, 19),
(14, 56, 19),
(13, 57, 19);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `trang_thai_danh_muc`
--

CREATE TABLE `trang_thai_danh_muc` (
  `id` bigint(20) NOT NULL,
  `module` varchar(100) NOT NULL,
  `ma_trang_thai` varchar(100) NOT NULL,
  `ten_trang_thai` varchar(255) NOT NULL,
  `mau_sac` varchar(30) DEFAULT NULL,
  `thu_tu` int(11) DEFAULT 0,
  `mac_dinh` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `trang_thai_danh_muc`
--

INSERT INTO `trang_thai_danh_muc` (`id`, `module`, `ma_trang_thai`, `ten_trang_thai`, `mau_sac`, `thu_tu`, `mac_dinh`) VALUES
(1, 'employee', 'dang_lam', 'Đang làm', 'green', 1, 1),
(2, 'employee', 'tam_nghi', 'Tạm nghỉ', 'orange', 2, 0),
(3, 'employee', 'nghi_viec', 'Nghỉ việc', 'red', 3, 0),
(4, 'leave', 'cho_duyet', 'Chờ duyệt', 'orange', 1, 1),
(5, 'leave', 'da_duyet', 'Đã duyệt', 'green', 2, 0),
(6, 'leave', 'tu_choi', 'Từ chối', 'red', 3, 0),
(7, 'leave', 'da_huy', 'Đã huỷ', 'gray', 4, 0),
(8, 'trip', 'da_tao', 'Đã tạo', 'blue', 1, 1),
(9, 'trip', 'dang_di', 'Đang đi', 'orange', 2, 0),
(10, 'trip', 'hoan_thanh', 'Hoàn thành', 'green', 3, 0),
(11, 'menu', 'hoat_dong', 'Hoạt động', 'green', 1, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `vai_tro`
--

CREATE TABLE `vai_tro` (
  `id` bigint(20) NOT NULL,
  `ma_vai_tro` varchar(50) DEFAULT NULL,
  `ten_vai_tro` varchar(255) NOT NULL,
  `mo_ta` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `vai_tro`
--

INSERT INTO `vai_tro` (`id`, `ma_vai_tro`, `ten_vai_tro`, `mo_ta`) VALUES
(14, 'quan_tri', 'Quản trị hệ thống', 'Toàn quyền hệ thống'),
(15, 'thu_truong', 'Thủ trưởng', 'Người đứng đầu đơn vị'),
(16, 'pho_thu_truong', 'Phó thủ trưởng', 'Cấp phó đơn vị'),
(17, 'truong_phong', 'Trưởng phòng', 'Quản lý phòng ban'),
(18, 'pho_truong_phong', 'Phó trưởng phòng', 'Cấp phó phòng ban'),
(19, 'nhan_vien', 'Nhân viên', 'Người dùng thông thường');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `cau_hinh`
--
ALTER TABLE `cau_hinh`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `khoa_cau_hinh` (`khoa_cau_hinh`);

--
-- Chỉ mục cho bảng `chuc_vu`
--
ALTER TABLE `chuc_vu`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ma_chuc_vu` (`ma_chuc_vu`);

--
-- Chỉ mục cho bảng `cong_tac`
--
ALTER TABLE `cong_tac`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_nhan_vien` (`id_nhan_vien`);

--
-- Chỉ mục cho bảng `lich_su_duyet_nghi`
--
ALTER TABLE `lich_su_duyet_nghi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_lsdn_np` (`id_nghi_phep`),
  ADD KEY `fk_lsdn_tk` (`id_tai_khoan`);

--
-- Chỉ mục cho bảng `loai_nghi`
--
ALTER TABLE `loai_nghi`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ma_loai` (`ma_loai`);

--
-- Chỉ mục cho bảng `luong_duyet`
--
ALTER TABLE `luong_duyet`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_ld_cv1` (`id_chuc_vu_ap_dung`),
  ADD KEY `fk_ld_cv2` (`id_chuc_vu_duyet`);

--
-- Chỉ mục cho bảng `menu_he_thong`
--
ALTER TABLE `menu_he_thong`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ma_menu` (`ma_menu`),
  ADD KEY `fk_menu_cha` (`id_cha`),
  ADD KEY `fk_menu_tt` (`id_trang_thai`);

--
-- Chỉ mục cho bảng `menu_vai_tro`
--
ALTER TABLE `menu_vai_tro`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_menu_vt` (`id_menu`,`id_vai_tro`),
  ADD KEY `fk_mvt_vt` (`id_vai_tro`);

--
-- Chỉ mục cho bảng `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `nghi_phep`
--
ALTER TABLE `nghi_phep`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_np_nv` (`id_nhan_vien`),
  ADD KEY `fk_np_ln` (`id_loai_nghi`),
  ADD KEY `fk_np_tt` (`id_trang_thai`),
  ADD KEY `fk_np_duyet` (`id_nguoi_duyet_hien_tai`),
  ADD KEY `idx_so_don_nghi` (`so_don_nghi`);

--
-- Chỉ mục cho bảng `nhan_vien`
--
ALTER TABLE `nhan_vien`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ma_nhan_vien` (`ma_nhan_vien`),
  ADD KEY `fk_nv_pb` (`id_phong_ban`),
  ADD KEY `fk_nv_cv` (`id_chuc_vu`),
  ADD KEY `fk_nv_captren` (`id_cap_tren`),
  ADD KEY `fk_nv_tt` (`id_trang_thai`);

--
-- Chỉ mục cho bảng `nhat_ky_he_thong`
--
ALTER TABLE `nhat_ky_he_thong`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_nkht_tk` (`id_tai_khoan`);

--
-- Chỉ mục cho bảng `noi_den_cong_tac`
--
ALTER TABLE `noi_den_cong_tac`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cong_tac` (`id_cong_tac`),
  ADD KEY `idx_thu_tu` (`thu_tu`);

--
-- Chỉ mục cho bảng `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Chỉ mục cho bảng `phan_quyen_vai_tro`
--
ALTER TABLE `phan_quyen_vai_tro`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_vt_q` (`id_vai_tro`,`id_quyen`),
  ADD KEY `fk_pq_q` (`id_quyen`);

--
-- Chỉ mục cho bảng `phien_dang_nhap`
--
ALTER TABLE `phien_dang_nhap`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_pdn_tk` (`id_tai_khoan`);

--
-- Chỉ mục cho bảng `phong_ban`
--
ALTER TABLE `phong_ban`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ma_phong` (`ma_phong`),
  ADD KEY `fk_pb_cha` (`id_phong_cha`),
  ADD KEY `fk_pb_tt` (`id_trang_thai`);

--
-- Chỉ mục cho bảng `qlsk_diem`
--
ALTER TABLE `qlsk_diem`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_qlsk_diem_phan_cong` (`phan_cong_cham_id`),
  ADD KEY `idx_qlsk_diem_diem` (`diem`),
  ADD KEY `idx_qlsk_diem_ngay_cham` (`ngay_cham`),
  ADD KEY `idx_qlsk_diem_created_by` (`created_by`);

--
-- Chỉ mục cho bảng `qlsk_file`
--
ALTER TABLE `qlsk_file`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_qlsk_file_sang_kien` (`sang_kien_id`),
  ADD KEY `idx_qlsk_file_loai` (`loai_file`);

--
-- Chỉ mục cho bảng `qlsk_file_noi_dung`
--
ALTER TABLE `qlsk_file_noi_dung`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_file_id` (`file_id`),
  ADD KEY `idx_sang_kien_id` (`sang_kien_id`),
  ADD KEY `idx_hash_noi_dung` (`hash_noi_dung`);

--
-- Chỉ mục cho bảng `qlsk_hoi_dong`
--
ALTER TABLE `qlsk_hoi_dong`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_qlsk_hoi_dong_ma` (`ma`),
  ADD UNIQUE KEY `uk_qlsk_hoi_dong_id_nam` (`id`,`nam_id`),
  ADD KEY `idx_qlsk_hoi_dong_nam` (`nam_id`),
  ADD KEY `idx_qlsk_hoi_dong_nam_trang_thai` (`nam_id`,`trang_thai`),
  ADD KEY `idx_qlsk_hoi_dong_trang_thai` (`trang_thai`);

--
-- Chỉ mục cho bảng `qlsk_kiem_tra_trung_dot`
--
ALTER TABLE `qlsk_kiem_tra_trung_dot`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_nam_id` (`nam_id`),
  ADD KEY `idx_trang_thai` (`trang_thai`);

--
-- Chỉ mục cho bảng `qlsk_kiem_tra_trung_ket_qua`
--
ALTER TABLE `qlsk_kiem_tra_trung_ket_qua`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_dot_pair` (`dot_id`,`sang_kien_id`,`doi_tuong_sang_kien_id`),
  ADD KEY `idx_dot_id` (`dot_id`),
  ADD KEY `idx_sang_kien_id` (`sang_kien_id`),
  ADD KEY `idx_doi_tuong_id` (`doi_tuong_sang_kien_id`);

--
-- Chỉ mục cho bảng `qlsk_lich_su_trang_thai`
--
ALTER TABLE `qlsk_lich_su_trang_thai`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_qlsk_lstt_sang_kien` (`sang_kien_id`),
  ADD KEY `idx_qlsk_lstt_sang_kien_created` (`sang_kien_id`,`created_at`),
  ADD KEY `idx_qlsk_lstt_nguoi_thuc_hien` (`nguoi_thuc_hien_id`),
  ADD KEY `idx_qlsk_lstt_created_at` (`created_at`);

--
-- Chỉ mục cho bảng `qlsk_linh_vuc`
--
ALTER TABLE `qlsk_linh_vuc`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_qlsk_linh_vuc_ma` (`ma`),
  ADD UNIQUE KEY `uk_qlsk_linh_vuc_ten` (`ten`),
  ADD KEY `idx_qlsk_linh_vuc_trang_thai` (`trang_thai`),
  ADD KEY `idx_qlsk_linh_vuc_thu_tu` (`thu_tu`),
  ADD KEY `idx_qlsk_linh_vuc_created_by` (`created_by`),
  ADD KEY `idx_qlsk_linh_vuc_updated_by` (`updated_by`);

--
-- Chỉ mục cho bảng `qlsk_nam`
--
ALTER TABLE `qlsk_nam`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_qlsk_nam_nam` (`nam`),
  ADD KEY `idx_qlsk_nam_trang_thai` (`trang_thai`),
  ADD KEY `idx_qlsk_nam_thoi_gian` (`tu_ngay`,`den_ngay`),
  ADD KEY `idx_qlsk_nam_created_by` (`created_by`),
  ADD KEY `idx_qlsk_nam_updated_by` (`updated_by`);

--
-- Chỉ mục cho bảng `qlsk_phan_cong_cham`
--
ALTER TABLE `qlsk_phan_cong_cham`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_qlsk_pcc_thanh_vien_sang_kien` (`thanh_vien_hoi_dong_id`,`sang_kien_id`),
  ADD KEY `idx_qlsk_pcc_sang_kien` (`sang_kien_id`),
  ADD KEY `idx_qlsk_pcc_trang_thai` (`trang_thai`),
  ADD KEY `idx_qlsk_pcc_tv_trang_thai` (`thanh_vien_hoi_dong_id`,`trang_thai`),
  ADD KEY `idx_qlsk_pcc_sang_kien_trang_thai` (`sang_kien_id`,`trang_thai`),
  ADD KEY `idx_qlsk_pcc_ngay_phan_cong` (`ngay_phan_cong`);

--
-- Chỉ mục cho bảng `qlsk_sang_kien`
--
ALTER TABLE `qlsk_sang_kien`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_qlsk_sang_kien_ma` (`ma`),
  ADD UNIQUE KEY `uk_qlsk_sang_kien_id_nam` (`id`,`nam_id`),
  ADD KEY `idx_qlsk_sang_kien_nam` (`nam_id`),
  ADD KEY `idx_qlsk_sang_kien_nam_trang_thai` (`nam_id`,`trang_thai`),
  ADD KEY `idx_qlsk_sang_kien_linh_vuc` (`linh_vuc_id`),
  ADD KEY `idx_qlsk_sang_kien_trang_thai` (`trang_thai`),
  ADD KEY `idx_qlsk_sang_kien_ngay_nop` (`ngay_nop`),
  ADD KEY `idx_qlsk_sang_kien_created_by` (`created_by`),
  ADD KEY `idx_qlsk_sang_kien_updated_by` (`updated_by`);

--
-- Chỉ mục cho bảng `qlsk_sang_kien_tac_gia`
--
ALTER TABLE `qlsk_sang_kien_tac_gia`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_qlsk_sktg_sang_kien_nhan_vien` (`sang_kien_id`,`nhan_vien_id`),
  ADD KEY `idx_qlsk_sktg_nhan_vien` (`nhan_vien_id`),
  ADD KEY `idx_qlsk_sktg_vai_tro` (`vai_tro`),
  ADD KEY `idx_qlsk_sktg_sang_kien_vai_tro` (`sang_kien_id`,`vai_tro`),
  ADD KEY `idx_qlsk_sktg_thu_tu` (`sang_kien_id`,`thu_tu`);

--
-- Chỉ mục cho bảng `qlsk_thanh_vien_hoi_dong`
--
ALTER TABLE `qlsk_thanh_vien_hoi_dong`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_qlsk_tvhd_hoi_dong_nhan_vien` (`hoi_dong_id`,`nhan_vien_id`),
  ADD KEY `idx_qlsk_tvhd_nhan_vien` (`nhan_vien_id`),
  ADD KEY `idx_qlsk_tvhd_vai_tro` (`vai_tro`),
  ADD KEY `idx_qlsk_tvhd_hoi_dong_trang_thai` (`hoi_dong_id`,`trang_thai`),
  ADD KEY `idx_qlsk_tvhd_thu_tu` (`hoi_dong_id`,`thu_tu`);

--
-- Chỉ mục cho bảng `quyen`
--
ALTER TABLE `quyen`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ma_quyen` (`ma_quyen`);

--
-- Chỉ mục cho bảng `so_du_phep`
--
ALTER TABLE `so_du_phep`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_sdp` (`id_nhan_vien`,`nam`);

--
-- Chỉ mục cho bảng `tai_khoan`
--
ALTER TABLE `tai_khoan`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ten_dang_nhap` (`ten_dang_nhap`);

--
-- Chỉ mục cho bảng `tai_khoan_vai_tro`
--
ALTER TABLE `tai_khoan_vai_tro`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_tk_vt` (`id_tai_khoan`,`id_vai_tro`),
  ADD KEY `fk_tkvt_vt` (`id_vai_tro`);

--
-- Chỉ mục cho bảng `trang_thai_danh_muc`
--
ALTER TABLE `trang_thai_danh_muc`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_tt` (`module`,`ma_trang_thai`);

--
-- Chỉ mục cho bảng `vai_tro`
--
ALTER TABLE `vai_tro`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ma_vai_tro` (`ma_vai_tro`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `cau_hinh`
--
ALTER TABLE `cau_hinh`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `chuc_vu`
--
ALTER TABLE `chuc_vu`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT cho bảng `cong_tac`
--
ALTER TABLE `cong_tac`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT cho bảng `lich_su_duyet_nghi`
--
ALTER TABLE `lich_su_duyet_nghi`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `loai_nghi`
--
ALTER TABLE `loai_nghi`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `luong_duyet`
--
ALTER TABLE `luong_duyet`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT cho bảng `menu_he_thong`
--
ALTER TABLE `menu_he_thong`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT cho bảng `menu_vai_tro`
--
ALTER TABLE `menu_vai_tro`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT cho bảng `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `nghi_phep`
--
ALTER TABLE `nghi_phep`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=130;

--
-- AUTO_INCREMENT cho bảng `nhan_vien`
--
ALTER TABLE `nhan_vien`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;

--
-- AUTO_INCREMENT cho bảng `nhat_ky_he_thong`
--
ALTER TABLE `nhat_ky_he_thong`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `noi_den_cong_tac`
--
ALTER TABLE `noi_den_cong_tac`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT cho bảng `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=168;

--
-- AUTO_INCREMENT cho bảng `phan_quyen_vai_tro`
--
ALTER TABLE `phan_quyen_vai_tro`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT cho bảng `phien_dang_nhap`
--
ALTER TABLE `phien_dang_nhap`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `phong_ban`
--
ALTER TABLE `phong_ban`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `qlsk_diem`
--
ALTER TABLE `qlsk_diem`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `qlsk_file`
--
ALTER TABLE `qlsk_file`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT cho bảng `qlsk_file_noi_dung`
--
ALTER TABLE `qlsk_file_noi_dung`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT cho bảng `qlsk_hoi_dong`
--
ALTER TABLE `qlsk_hoi_dong`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `qlsk_kiem_tra_trung_dot`
--
ALTER TABLE `qlsk_kiem_tra_trung_dot`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT cho bảng `qlsk_kiem_tra_trung_ket_qua`
--
ALTER TABLE `qlsk_kiem_tra_trung_ket_qua`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT cho bảng `qlsk_lich_su_trang_thai`
--
ALTER TABLE `qlsk_lich_su_trang_thai`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `qlsk_linh_vuc`
--
ALTER TABLE `qlsk_linh_vuc`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `qlsk_nam`
--
ALTER TABLE `qlsk_nam`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `qlsk_phan_cong_cham`
--
ALTER TABLE `qlsk_phan_cong_cham`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `qlsk_sang_kien`
--
ALTER TABLE `qlsk_sang_kien`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT cho bảng `qlsk_sang_kien_tac_gia`
--
ALTER TABLE `qlsk_sang_kien_tac_gia`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT cho bảng `qlsk_thanh_vien_hoi_dong`
--
ALTER TABLE `qlsk_thanh_vien_hoi_dong`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `quyen`
--
ALTER TABLE `quyen`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT cho bảng `so_du_phep`
--
ALTER TABLE `so_du_phep`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT cho bảng `tai_khoan`
--
ALTER TABLE `tai_khoan`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT cho bảng `tai_khoan_vai_tro`
--
ALTER TABLE `tai_khoan_vai_tro`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT cho bảng `trang_thai_danh_muc`
--
ALTER TABLE `trang_thai_danh_muc`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT cho bảng `vai_tro`
--
ALTER TABLE `vai_tro`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `lich_su_duyet_nghi`
--
ALTER TABLE `lich_su_duyet_nghi`
  ADD CONSTRAINT `fk_lsdn_np` FOREIGN KEY (`id_nghi_phep`) REFERENCES `nghi_phep` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_lsdn_tk` FOREIGN KEY (`id_tai_khoan`) REFERENCES `tai_khoan` (`id`);

--
-- Các ràng buộc cho bảng `luong_duyet`
--
ALTER TABLE `luong_duyet`
  ADD CONSTRAINT `fk_ld_cv1` FOREIGN KEY (`id_chuc_vu_ap_dung`) REFERENCES `chuc_vu` (`id`),
  ADD CONSTRAINT `fk_ld_cv2` FOREIGN KEY (`id_chuc_vu_duyet`) REFERENCES `chuc_vu` (`id`);

--
-- Các ràng buộc cho bảng `menu_he_thong`
--
ALTER TABLE `menu_he_thong`
  ADD CONSTRAINT `fk_menu_cha` FOREIGN KEY (`id_cha`) REFERENCES `menu_he_thong` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_menu_tt` FOREIGN KEY (`id_trang_thai`) REFERENCES `trang_thai_danh_muc` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `menu_vai_tro`
--
ALTER TABLE `menu_vai_tro`
  ADD CONSTRAINT `fk_mvt_menu` FOREIGN KEY (`id_menu`) REFERENCES `menu_he_thong` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_mvt_vt` FOREIGN KEY (`id_vai_tro`) REFERENCES `vai_tro` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `nghi_phep`
--
ALTER TABLE `nghi_phep`
  ADD CONSTRAINT `fk_np_duyet` FOREIGN KEY (`id_nguoi_duyet_hien_tai`) REFERENCES `tai_khoan` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_np_ln` FOREIGN KEY (`id_loai_nghi`) REFERENCES `loai_nghi` (`id`),
  ADD CONSTRAINT `fk_np_nv` FOREIGN KEY (`id_nhan_vien`) REFERENCES `nhan_vien` (`id`),
  ADD CONSTRAINT `fk_np_tt` FOREIGN KEY (`id_trang_thai`) REFERENCES `trang_thai_danh_muc` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `nhan_vien`
--
ALTER TABLE `nhan_vien`
  ADD CONSTRAINT `fk_nv_captren` FOREIGN KEY (`id_cap_tren`) REFERENCES `nhan_vien` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_nv_cv` FOREIGN KEY (`id_chuc_vu`) REFERENCES `chuc_vu` (`id`),
  ADD CONSTRAINT `fk_nv_pb` FOREIGN KEY (`id_phong_ban`) REFERENCES `phong_ban` (`id`),
  ADD CONSTRAINT `fk_nv_tt` FOREIGN KEY (`id_trang_thai`) REFERENCES `trang_thai_danh_muc` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `nhat_ky_he_thong`
--
ALTER TABLE `nhat_ky_he_thong`
  ADD CONSTRAINT `fk_nkht_tk` FOREIGN KEY (`id_tai_khoan`) REFERENCES `tai_khoan` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `noi_den_cong_tac`
--
ALTER TABLE `noi_den_cong_tac`
  ADD CONSTRAINT `fk_noi_den_cong_tac` FOREIGN KEY (`id_cong_tac`) REFERENCES `cong_tac` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `phan_quyen_vai_tro`
--
ALTER TABLE `phan_quyen_vai_tro`
  ADD CONSTRAINT `fk_pq_q` FOREIGN KEY (`id_quyen`) REFERENCES `quyen` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pq_vt` FOREIGN KEY (`id_vai_tro`) REFERENCES `vai_tro` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `phien_dang_nhap`
--
ALTER TABLE `phien_dang_nhap`
  ADD CONSTRAINT `fk_pdn_tk` FOREIGN KEY (`id_tai_khoan`) REFERENCES `tai_khoan` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `phong_ban`
--
ALTER TABLE `phong_ban`
  ADD CONSTRAINT `fk_pb_cha` FOREIGN KEY (`id_phong_cha`) REFERENCES `phong_ban` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_pb_tt` FOREIGN KEY (`id_trang_thai`) REFERENCES `trang_thai_danh_muc` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `qlsk_diem`
--
ALTER TABLE `qlsk_diem`
  ADD CONSTRAINT `fk_qlsk_diem_phan_cong` FOREIGN KEY (`phan_cong_cham_id`) REFERENCES `qlsk_phan_cong_cham` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `qlsk_file`
--
ALTER TABLE `qlsk_file`
  ADD CONSTRAINT `fk_qlsk_file_sang_kien` FOREIGN KEY (`sang_kien_id`) REFERENCES `qlsk_sang_kien` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `qlsk_hoi_dong`
--
ALTER TABLE `qlsk_hoi_dong`
  ADD CONSTRAINT `fk_qlsk_hoi_dong_nam` FOREIGN KEY (`nam_id`) REFERENCES `qlsk_nam` (`id`) ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `qlsk_kiem_tra_trung_ket_qua`
--
ALTER TABLE `qlsk_kiem_tra_trung_ket_qua`
  ADD CONSTRAINT `fk_kiem_tra_dot` FOREIGN KEY (`dot_id`) REFERENCES `qlsk_kiem_tra_trung_dot` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `qlsk_lich_su_trang_thai`
--
ALTER TABLE `qlsk_lich_su_trang_thai`
  ADD CONSTRAINT `fk_qlsk_lstt_nguoi_thuc_hien` FOREIGN KEY (`nguoi_thuc_hien_id`) REFERENCES `nhan_vien` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_qlsk_lstt_sang_kien` FOREIGN KEY (`sang_kien_id`) REFERENCES `qlsk_sang_kien` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `qlsk_phan_cong_cham`
--
ALTER TABLE `qlsk_phan_cong_cham`
  ADD CONSTRAINT `fk_qlsk_pcc_sang_kien` FOREIGN KEY (`sang_kien_id`) REFERENCES `qlsk_sang_kien` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_qlsk_pcc_thanh_vien` FOREIGN KEY (`thanh_vien_hoi_dong_id`) REFERENCES `qlsk_thanh_vien_hoi_dong` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `qlsk_sang_kien`
--
ALTER TABLE `qlsk_sang_kien`
  ADD CONSTRAINT `fk_qlsk_sang_kien_linh_vuc` FOREIGN KEY (`linh_vuc_id`) REFERENCES `qlsk_linh_vuc` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_qlsk_sang_kien_nam` FOREIGN KEY (`nam_id`) REFERENCES `qlsk_nam` (`id`) ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `qlsk_sang_kien_tac_gia`
--
ALTER TABLE `qlsk_sang_kien_tac_gia`
  ADD CONSTRAINT `fk_qlsk_sktg_nhan_vien` FOREIGN KEY (`nhan_vien_id`) REFERENCES `nhan_vien` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_qlsk_sktg_sang_kien` FOREIGN KEY (`sang_kien_id`) REFERENCES `qlsk_sang_kien` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `qlsk_thanh_vien_hoi_dong`
--
ALTER TABLE `qlsk_thanh_vien_hoi_dong`
  ADD CONSTRAINT `fk_qlsk_tvhd_hoi_dong` FOREIGN KEY (`hoi_dong_id`) REFERENCES `qlsk_hoi_dong` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_qlsk_tvhd_nhan_vien` FOREIGN KEY (`nhan_vien_id`) REFERENCES `nhan_vien` (`id`) ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `so_du_phep`
--
ALTER TABLE `so_du_phep`
  ADD CONSTRAINT `fk_sdp_nv` FOREIGN KEY (`id_nhan_vien`) REFERENCES `nhan_vien` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `tai_khoan_vai_tro`
--
ALTER TABLE `tai_khoan_vai_tro`
  ADD CONSTRAINT `fk_tkvt_tk` FOREIGN KEY (`id_tai_khoan`) REFERENCES `tai_khoan` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_tkvt_vt` FOREIGN KEY (`id_vai_tro`) REFERENCES `vai_tro` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
