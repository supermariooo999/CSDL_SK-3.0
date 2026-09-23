-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th9 23, 2026 lúc 02:04 AM
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
(28, 35, 'MAU_05', '1.SK-TCCB-001.docx', '62aed2f4f5008823f76aa7048a59d7bf.docx', 'storage/sang-kien/35/62aed2f4f5008823f76aa7048a59d7bf.docx', 'docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 107329, NULL, '2026-09-22 19:39:34'),
(29, 36, 'MAU_05', '2.SK-TCCB-002.docx', 'fdd606955c8e229607c6f111c589a3ac.docx', 'storage/sang-kien/36/fdd606955c8e229607c6f111c589a3ac.docx', 'docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 38332, NULL, '2026-09-22 19:40:17'),
(30, 37, 'MAU_05', '3.SK-TCCB-003.docx', '9dc95a7488edf4d7cd3d8618c819f247.docx', 'storage/sang-kien/37/9dc95a7488edf4d7cd3d8618c819f247.docx', 'docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 37740, NULL, '2026-09-22 19:43:09'),
(31, 38, 'MAU_05', '4.SK-TCCB-004.docx', 'ea31c68914ad148b3543df9870abbd3a.docx', 'storage/sang-kien/38/ea31c68914ad148b3543df9870abbd3a.docx', 'docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 31010, NULL, '2026-09-22 19:49:46'),
(32, 39, 'MAU_05', '5.SK-TCS7-005.docx', 'bb419a6de15980cdf0fa1d0ee431b4dc.docx', 'storage/sang-kien/39/bb419a6de15980cdf0fa1d0ee431b4dc.docx', 'docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 40009, NULL, '2026-09-22 19:58:18'),
(33, 40, 'MAU_05', '6.SK-TCS7-006.docx', '84fd44219e31ed6b38badd6f1a4bb921.docx', 'storage/sang-kien/40/84fd44219e31ed6b38badd6f1a4bb921.docx', 'docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 38446, NULL, '2026-09-22 20:19:07'),
(36, 43, 'MAU_05', '5.SK-TCS7-005.docx', 'dec6ec6d6f89cc73693d3988e2cb50d0.docx', 'storage/sang-kien/43/dec6ec6d6f89cc73693d3988e2cb50d0.docx', 'docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 40009, NULL, '2026-09-22 22:32:00'),
(37, 44, 'MAU_05', '8.SK-TCS7-008.docx', '16f3105fe80c45563e4594bacaf8f165.docx', 'storage/sang-kien/44/16f3105fe80c45563e4594bacaf8f165.docx', 'docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 44233, NULL, '2026-09-22 22:33:28'),
(44, 51, 'MAU_05', '9.SK-TCS2-009.docx', '04fcbe30dc68114ffe208c715d4d4cff.docx', 'storage/sang-kien/51/04fcbe30dc68114ffe208c715d4d4cff.docx', 'docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 38116, NULL, '2026-09-22 22:51:15');

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
(12, 28, 35, 'BÁO CÁO MÔ TẢ SÁNG KIẾN\n1. Tên sáng kiến (thể hiện được bản chất của giải pháp): Kỹ năng xây dựng phương án giao biên chế cho các đơn vị”.\n2. Họ và tên nhóm tác giả sáng kiến, chức danh, trình độ chuyên môn:\n3. Lĩnh vực áp dụng: Tổ chức cán bộ.\n4. Mô tả sáng kiến:\na. Khái quát đặc điểm, tình hình trước khi có sáng kiến.\n- Việc quản lý, bố trí biên chế bảo đảm phù hợp với chức năng, nhiệm vụ, quyền hạn và cơ cấu tổ chức của cơ quan, tổ chức, đơn vị; yêu cầu của vị trí việc làm, cải cách hành chính gắn với tinh giản biên chế và cơ cấu lại, nâng cao chất lượng đội ngũ, bảo đảm tinh, gọn, hiệu năng, hiệu lực, hiệu quả. Những năm trước khi có sáng kiến, việc xây dựng và triển khai giao biên chế dựa vào báo cáo của các đơn vị về nhu cầu biên chế, khối lượng công việc. Các đơn vị đa phần đều báo cáo biên chế tại đơn vị thiếu nhiều. Thuế tỉnh chưa có đủ cơ sở khoa học để phân bổ biên chế về các đơn vị đảm bảo đúng nhu cầu thực tế. Về biên chế ở các đơn vị hiện nay đa phần đều thiếu so với số được Cục Thuế giao, tuy nhiên cần phải xác định lại đơn vị nào thiếu biên chế nhiều hơn để phân bổ, vì nguồn lực có hạn nên việc phân bổ cần phải cân nhắc để đảm bảo đủ người làm việc cho các đơn vị trong tình hình thiếu nhân sự toàn tỉnh. Nhận thấy việc tìm ra các giải pháp, quy trình để xác định đúng đơn vị thật sự đang thiếu nhiều biên chế so với các đơn vị thiếu còn lại để có phương án giao và có kế hoạch điều động nhân sự cho đơn vị kịp thời.\n- Với lý do trên, tác giả đã nghiên cứu văn bản, vận dụng kinh nghiệm thực tiễn để đưa ra sáng kiến “Kỹ năng xây dựng phương án giao biên chế cho các đơn vị” góp phần xây dựng phương án giao biên chế sát với thực tế, triển khai có hiệu lực hiệu quả trong công việc; kịp thời có kế hoạch điều động, bố trí nhân sự tại các đơn vị giúp hoàn thành tốt các nhiệm vụ chính trị được cấp trên giao.\nb. Nội dung sáng kiến.\n- Việc thực hiện giao và theo dõi, kiểm soát biên chế tại các đơn vị là quy định bắt buộc, phải thực hiện thường xuyên theo đúng quy định của Đảng, nhà nước và của ngành. Hàng năm, trong Quý I cấp trên đều có quyết định giao số lượng biên chế. Căn cứ vào số biên chế được giao, Thuế tỉnh lập phương án giao biên chế lại cho các đơn vị thuộc Thuế tỉnh nhằm kiểm soát biên chế và điều động nhân sự bổ sung cho nơi thiếu. Nhận thấy được tầm quan trọng và thực trạng tại cơ quan, Nhóm tác giả đã có sáng kiến đưa ra các giải pháp thực hiện trọng tâm để có cơ sở phân tích, giao biên chế sát với nhu cầu của các đơn vị, là tiền đề, cơ sở để xây dựng Kế hoạch luân chuyển, điều động để kịp thời bổ sung nguồn nhân lực cho các đơn vị đang thiếu.\n- Chi tiết về các chỉ tiêu làm cơ sở trong phương án giao biên chế như sau:\n+ Số công chức của đơn vị hiện tại.\n+ Số thu của đơn vị được giao trong năm.\n+ Số cuộc kiểm tra được giao trong năm.\n+ Số lượng Tổ chức, doanh nghiệp đang quản lý (bao gồm: Doanh nghiệp và Hợp tác xã, tổ chức khác).\n+ Số lượng Hộ kinh doanh đang quản lý tính đến thời điểm hiện tại (bao gồm Hộ trên ngưỡng nộp thuế và Hộ dưới ngưỡng nộp thuế).\nTừ các số liệu trên sẽ tính toán được:\n+ Trung bình số lượng Doanh nghiệp mà các Phòng Quản lý, hỗ trợ doanh nghiệp, các Thuế cơ sở đang quản lý, so sánh đơn vị nào đang quản lý nhiều doanh nghiệp hơn, đang có số thu được giao cao hơn so với số trung bình để có cơ sở giao biên chế tăng hoặc giảm, từ đó là cơ sở để có kế hoạch điều động công chức về phân bổ cho các đơn vị.\n+ Trung bình số cuộc kiểm tra mà các Phòng Kiểm tra, các Thuế cơ sở được giao để so sánh xem đơn vị nào có số lượng cuộc kiểm tra được giao nhiều hơn so với số trung bình từ đó có cơ sở tăng hoặc giảm biên chế và là cơ sở để có kế hoạch điều động công chức về phân bổ cho các đơn vị.\n+ Trung bình số lượng Doanh nghiệp, hộ kinh doanh mà các Thuế cơ sở đang quản lý; Trung bình số cuộc kiểm tra được giao; Trung bình số thu/công chức đang đảm nhiệm từ đó có cơ sở giao biên chế tăng hoặc giảm và là cơ sở để có kế hoạch điều động công chức về phân bổ cho các đơn vị.\n- Dựa vào các dữ liệu thu thập được từ báo cáo của các Phòng, các Thuế cơ sở. Bộ phận tổ chức cán bộ lập bảng so sánh về các tiêu chí giữa các Phòng cùng chức năng, nhiệm vụ; so sánh giữa các Thuế cơ sở; so sánh giữa các Phòng và các Thuế cơ sở để đề xuất Lãnh đạo giao biên chế cho các đơn vị sát với thực tế. Việc giao biên chế hàng năm, Cục Thuế đều giao năm hiện tại thấp hơn năm trước liền kề. Sau sắp xếp có nhiều công chức xin nghỉ hưởng chế độ, chính sách dẫn đến biên chế tại các đơn vị thiếu nhiều. Việc bổ sung biên chế chỉ có khi Cục Thuế tổ chức tuyển dụng. Việc tuyển dụng diễn ra cần quy trình và thời gian khá lâu, trong khi nhu cầu công việc cấp bách. Do đó, Thuế tỉnh chỉ có cách cân đối nguồn lực hiện có, phân bổ biên chế ở nơi thiếu ít sang nơi thiếu nhiều để đảm bảo công việc.\n- Việc rà soát có cơ sở khoa học để đề xuất tăng giảm biên chế tại các đơn vị dựa vào nguồn lực hiện có để đảm bảo các đơn vị hoàn thành nhiệm vụ được giao.\nTính mới của sáng kiến\n- Tránh được tình trạng giao biên chế cảm tính theo báo cáo của các đơn vị.\n- Đảm bảo việc giao biên chế theo nguyên tắc khoa học, hợp lý và phát huy trách nhiệm, quyền hạn của người đứng đầu đơn vị; dựa vào các yêu cầu công tác, vị trí việc làm, quy mô quản lý, thực trạng tại đơn vị để bổ sung biên chế nhằm nâng cao chất lượng và hiệu quả hoạt động của cơ quan.\n- Giúp tiết kiệm thời gian và chủ động trong công tác giao biên chế hàng năm. Là cơ sở để xác định nhu cầu biên chế của toàn tỉnh, xác định nhu cầu biên chế trống để có cơ sở đề xuất phân bổ chỉ tiêu tuyển dụng công chức và chỉ tiêu giao biên chế cho năm sau.\nc. Hiệu quả và phạm vi áp dụng của sáng kiến, giải pháp\nKể từ khi áp dụng sáng kiến từ 24/3/2025 đến nay đã giúp:\n- Khắc phục được một hạn chế đang tồn tại lâu nay là giao biên chế theo báo cáo của đơn vị (các đơn vị đều báo cáo thiếu biên chế, xin thêm người về đơn vị mình). Nhằm tăng cường tính chủ động và hiệu quả trong quản lý, sử dụng công chức, xây dựng cơ cấu đội ngũ công chức hợp lý; tăng cường nhân sự cho các đơn vị có khó khăn về công tác nhân sự; để sắp xếp, kiện toàn tổ chức, bộ máy. Kịp thời chủ động phân bổ nhân sự cho các nơi thật sự thiếu nhiều trong tình hình chung các đơn vị đều thiếu, phân bổ ở nơi thiếu ít về nơi thiếu nhiều dựa vào nguồn lực hiện có.\n- Đối với cấp Thuế tỉnh: Giúp Lãnh đạo có cái nhìn tổng quan, phân tích trên cơ sở khoa học, khách quan khi xây dựng phương án giao biên chế. Tiết kiệm được thời gian khi phải rà soát chi tiết từng đơn vị. Kịp thời, chủ động trong công tác thực hiện các quy trình điều động, bổ sung từ các đơn vị thừa nhân sự sang các đơn vị thiếu để thực hiện tốt nhiệm vụ chính trị được giao.\n- Đối với cấp Thuế cơ sở: Từ bộ tiêu chí xây dựng như trên đã triển khai, hướng dẫn giúp Thuế cơ sở có cơ sở khoa học khi tự rà soát xây dựng phương án giao biên chế hàng năm sát với thực tế, đúng theo yêu cầu công việc tại các Tổ, đảm bảo khoa học, minh bạch, hợp lý, đặc biệt tiết kiệm thời gian trong việc rà soát, tham mưu với Lãnh đạo. Trên cơ sở khoa học, rút ngắn thời gian từ đó phương án được phê duyệt sớm, đảm bảo được việc triển khai thực hiện điều động, chuyển đổi vị trí công tác kịp thời.\nPhạm vi ảnh hưởng, khả năng nhân rộng của sáng kiến: Có hiệu quả áp dụng, phạm vi ảnh hưởng và khả năng nhân rộng tại cấp Thuế tỉnh và cấp Bộ Tài chính.\n5. Hội đồng cơ sở đã xét công nhận sáng kiến: Quyết định số 1109/QĐ-CMA ngày 23 tháng 10 năm 2025 của Trưởng Thuế tỉnh Cà Mau.\n6. Thời gian áp dụng: Từ 24/3/2025 đến nay.\nCà Mau, ngày 27 tháng 10 năm 2025\nTRƯỞNG THUẾ TỈNH NGƯỜI NỘP ĐƠN\nLê Văn Sơn Đỗ Thanh Thảo\nĐỒNG TÁC GIẢ SÁNG KIẾN\nTrần Ty Na Phạm Nhật Trường', '<p>BÁO CÁO MÔ TẢ SÁNG KIẾN</p><p>1. Tên sáng kiến (thể hiện được bản chất của giải pháp): Kỹ năng xây dựng phương án giao biên chế cho các đơn vị”.</p><p>2. Họ và tên nhóm tác giả sáng kiến, chức danh, trình độ chuyên môn:</p><p>3. Lĩnh vực áp dụng: Tổ chức cán bộ.</p><p>4. Mô tả sáng kiến:</p><p>a. Khái quát đặc điểm, tình hình trước khi có sáng kiến.</p><p>- Việc quản lý, bố trí biên chế bảo đảm phù hợp với chức năng, nhiệm vụ, quyền hạn và cơ cấu tổ chức của cơ quan, tổ chức, đơn vị; yêu cầu của vị trí việc làm, cải cách hành chính gắn với tinh giản biên chế và cơ cấu lại, nâng cao chất lượng đội ngũ, bảo đảm tinh, gọn, hiệu năng, hiệu lực, hiệu quả. Những năm trước khi có sáng kiến, việc xây dựng và triển khai giao biên chế dựa vào báo cáo của các đơn vị về nhu cầu biên chế, khối lượng công việc. Các đơn vị đa phần đều báo cáo biên chế tại đơn vị thiếu nhiều. Thuế tỉnh chưa có đủ cơ sở khoa học để phân bổ biên chế về các đơn vị đảm bảo đúng nhu cầu thực tế. Về biên chế ở các đơn vị hiện nay đa phần đều thiếu so với số được Cục Thuế giao, tuy nhiên cần phải xác định lại đơn vị nào thiếu biên chế nhiều hơn để phân bổ, vì nguồn lực có hạn nên việc phân bổ cần phải cân nhắc để đảm bảo đủ người làm việc cho các đơn vị trong tình hình thiếu nhân sự toàn tỉnh. Nhận thấy việc tìm ra các giải pháp, quy trình để xác định đúng đơn vị thật sự đang thiếu nhiều biên chế so với các đơn vị thiếu còn lại để có phương án giao và có kế hoạch điều động nhân sự cho đơn vị kịp thời.</p><p>- Với lý do trên, tác giả đã nghiên cứu văn bản, vận dụng kinh nghiệm thực tiễn để đưa ra sáng kiến “Kỹ năng xây dựng phương án giao biên chế cho các đơn vị” góp phần xây dựng phương án giao biên chế sát với thực tế, triển khai có hiệu lực hiệu quả trong công việc; kịp thời có kế hoạch điều động, bố trí nhân sự tại các đơn vị giúp hoàn thành tốt các nhiệm vụ chính trị được cấp trên giao.</p><p>b. Nội dung sáng kiến.</p><p>- Việc thực hiện giao và theo dõi, kiểm soát biên chế tại các đơn vị là quy định bắt buộc, phải thực hiện thường xuyên theo đúng quy định của Đảng, nhà nước và của ngành. Hàng năm, trong Quý I cấp trên đều có quyết định giao số lượng biên chế. Căn cứ vào số biên chế được giao, Thuế tỉnh lập phương án giao biên chế lại cho các đơn vị thuộc Thuế tỉnh nhằm kiểm soát biên chế và điều động nhân sự bổ sung cho nơi thiếu. Nhận thấy được tầm quan trọng và thực trạng tại cơ quan, Nhóm tác giả đã có sáng kiến đưa ra các giải pháp thực hiện trọng tâm để có cơ sở phân tích, giao biên chế sát với nhu cầu của các đơn vị, là tiền đề, cơ sở để xây dựng Kế hoạch luân chuyển, điều động để kịp thời bổ sung nguồn nhân lực cho các đơn vị đang thiếu.</p><p>- Chi tiết về các chỉ tiêu làm cơ sở trong phương án giao biên chế như sau:</p><p>+ Số công chức của đơn vị hiện tại.</p><p>+ Số thu của đơn vị được giao trong năm.</p><p>+ Số cuộc kiểm tra được giao trong năm.</p><p>+ Số lượng Tổ chức, doanh nghiệp đang quản lý  (bao gồm: Doanh nghiệp và Hợp tác xã, tổ chức khác).</p><p>+ Số lượng Hộ kinh doanh đang quản lý tính đến thời điểm hiện tại (bao gồm Hộ trên ngưỡng nộp thuế và Hộ dưới ngưỡng nộp thuế).</p><p>Từ các số liệu trên sẽ tính toán được:</p><p>+ Trung bình số lượng Doanh nghiệp mà các Phòng Quản lý, hỗ trợ doanh nghiệp, các Thuế cơ sở đang quản lý, so sánh đơn vị nào đang quản lý nhiều doanh nghiệp hơn, đang có số thu được giao cao hơn so với số trung bình để có cơ sở giao biên chế tăng hoặc giảm, từ đó là cơ sở để có kế hoạch điều động công chức về phân bổ cho các đơn vị.</p><p>+ Trung bình số cuộc kiểm tra mà các Phòng Kiểm tra, các Thuế cơ sở được giao để so sánh xem đơn vị nào có số lượng cuộc kiểm tra được giao nhiều hơn so với số trung bình từ đó có cơ sở tăng hoặc giảm biên chế và là cơ sở để có kế hoạch điều động công chức về phân bổ cho các đơn vị.</p><p>+ Trung bình số lượng Doanh nghiệp, hộ kinh doanh mà các Thuế cơ sở đang quản lý; Trung bình số cuộc kiểm tra được giao; Trung bình số thu/công chức đang đảm nhiệm từ đó có cơ sở giao biên chế tăng hoặc giảm và là cơ sở để có kế hoạch điều động công chức về phân bổ cho các đơn vị.</p><p>- Dựa vào các dữ liệu thu thập được từ báo cáo của các Phòng, các Thuế cơ sở. Bộ phận tổ chức cán bộ lập bảng so sánh về các tiêu chí giữa các Phòng cùng chức năng, nhiệm vụ; so sánh giữa các Thuế cơ sở; so sánh giữa các Phòng và các Thuế cơ sở để đề xuất Lãnh đạo giao biên chế cho các đơn vị sát với thực tế. Việc giao biên chế hàng năm, Cục Thuế đều giao năm hiện tại thấp hơn năm trước liền kề. Sau sắp xếp có nhiều công chức xin nghỉ hưởng chế độ, chính sách dẫn đến biên chế tại các đơn vị thiếu nhiều. Việc bổ sung biên chế chỉ có khi Cục Thuế tổ chức tuyển dụng. Việc tuyển dụng diễn ra cần quy trình và thời gian khá lâu, trong khi nhu cầu công việc cấp bách. Do đó, Thuế tỉnh chỉ có cách cân đối nguồn lực hiện có, phân bổ biên chế ở nơi thiếu ít sang nơi thiếu nhiều để đảm bảo công việc.</p><p>- Việc rà soát có cơ sở khoa học để đề xuất tăng giảm biên chế tại các đơn vị dựa vào nguồn lực hiện có để đảm bảo các đơn vị hoàn thành nhiệm vụ được giao.</p><p>Tính mới của sáng kiến</p><p>- Tránh được tình trạng giao biên chế cảm tính theo báo cáo của các đơn vị.</p><p>- Đảm bảo việc giao biên chế theo nguyên tắc khoa học, hợp lý và phát huy trách nhiệm, quyền hạn của người đứng đầu đơn vị; dựa vào các yêu cầu công tác, vị trí việc làm, quy mô quản lý, thực trạng tại đơn vị để bổ sung biên chế nhằm nâng cao chất lượng và hiệu quả hoạt động của cơ quan.</p><p>- Giúp tiết kiệm thời gian và chủ động trong công tác giao biên chế hàng năm. Là cơ sở để xác định nhu cầu biên chế của toàn tỉnh, xác định nhu cầu biên chế trống để có cơ sở đề xuất phân bổ chỉ tiêu tuyển dụng công chức và chỉ tiêu giao biên chế cho năm sau.</p><p>c. Hiệu quả và phạm vi áp dụng của sáng kiến, giải pháp</p><p>Kể từ khi áp dụng sáng kiến từ 24/3/2025 đến nay đã giúp:</p><p>- Khắc phục được một hạn chế đang tồn tại lâu nay là giao biên chế theo báo cáo của đơn vị (các đơn vị đều báo cáo thiếu biên chế, xin thêm người về đơn vị mình). Nhằm tăng cường tính chủ động và hiệu quả trong quản lý, sử dụng công chức, xây dựng cơ cấu đội ngũ công chức hợp lý; tăng cường nhân sự cho các đơn vị có khó khăn về công tác nhân sự; để sắp xếp, kiện toàn tổ chức, bộ máy. Kịp thời chủ động phân bổ nhân sự cho các nơi thật sự thiếu nhiều trong tình hình chung các đơn vị đều thiếu, phân bổ ở nơi thiếu ít về nơi thiếu nhiều dựa vào nguồn lực hiện có.</p><p>- Đối với cấp Thuế tỉnh: Giúp Lãnh đạo có cái nhìn tổng quan, phân tích trên cơ sở khoa học, khách quan khi xây dựng phương án giao biên chế. Tiết kiệm được thời gian khi phải rà soát chi tiết từng đơn vị. Kịp thời, chủ động trong công tác thực hiện các quy trình điều động, bổ sung từ các đơn vị thừa nhân sự sang các đơn vị thiếu để thực hiện tốt nhiệm vụ chính trị được giao.</p><p>- Đối với cấp Thuế cơ sở: Từ bộ tiêu chí xây dựng như trên đã triển khai, hướng dẫn giúp Thuế cơ sở có cơ sở khoa học khi tự rà soát xây dựng phương án giao biên chế hàng năm sát với thực tế, đúng theo yêu cầu công việc tại các Tổ, đảm bảo khoa học, minh bạch, hợp lý, đặc biệt tiết kiệm thời gian trong việc rà soát, tham mưu với Lãnh đạo. Trên cơ sở khoa học, rút ngắn thời gian từ đó phương án được phê duyệt sớm, đảm bảo được việc triển khai thực hiện điều động, chuyển đổi vị trí công tác kịp thời.</p><p>Phạm vi ảnh hưởng, khả năng nhân rộng của sáng kiến: Có hiệu quả áp dụng, phạm vi ảnh hưởng và khả năng nhân rộng tại cấp Thuế tỉnh và cấp Bộ Tài chính.</p><p>5. Hội đồng cơ sở đã xét công nhận sáng kiến: Quyết định số 1109/QĐ-CMA ngày 23 tháng 10 năm 2025 của Trưởng Thuế tỉnh Cà Mau.</p><p>6. Thời gian áp dụng: Từ 24/3/2025 đến nay.</p><p>Cà Mau, ngày 27 tháng 10 năm 2025</p><p>TRƯỞNG THUẾ TỈNH                                    NGƯỜI NỘP ĐƠN</p><p>Lê Văn Sơn                                             Đỗ Thanh Thảo</p><p>ĐỒNG TÁC GIẢ SÁNG KIẾN</p><p>Trần Ty Na                    Phạm Nhật Trường</p>', 'f75defbc4e9d038ff036b7eef16c0f3a9f9a213392da1c5b6f36383570fbce56', '2026-09-22 19:39:36'),
(13, 29, 36, 'BÁO CÁO MÔ TẢ SÁNG KIẾN\n1. Tên sáng kiến: Một số giải pháp góp phần nâng cao trách nhiệm công chức thuế trong thực thi công vụ.\n2. Họ và tên nhóm tác giả sáng kiến, chức danh, trình độ chuyên môn:\n3. Lĩnh vực áp dụng: Lĩnh vực khác, nâng cao chất lượng công tác chuyên môn nghiệp vụ\n4. Mô tả sáng kiến\na. Khái quát đặc điểm, tình hình trước khi có sáng kiến:\n* Đặc điểm, tình hình trước khi có sáng kiến:\nTrong điều kiện kinh tế, khoa học công nghệ ngày càng phát triển với tốc độ cao, các thành phần kinh tế, các hình thức kinh doanh, số lượng đối tượng nộp thuế phát triển một cách nhanh chóng, đa dạng, theo đó quy mô hoạt động của các doanh nghiệp được mở rộng và mang tính toàn cầu, việc quản lý kinh doanh và các giao dịch thương mại ngày càng được tin học hóa nên nhiệm vụ quản lý thuế trở nên khó khăn, phức tạp. Nhất là trong giai đoạn hiện nay, thực hiện Nghị quyết số 18/NQ-TW ngày 25/10/2017 của Ban Chấp hành Trung ương về đổi mới, sắp xếp tổ chức bộ máy của hệ thống chính trị theo hướng tinh gọn, hiệu lực, hiệu quả; cùng với chỉ đạo của Chính phủ, Bộ Tài chính, Cục Thuế, ngành Thuế tỉnh đã triển khai các biện pháp cải cách, hiện đại hóa nhằm nâng cao hiệu quả quản lý thuế và phục vụ tốt hơn cho người nộp thuế. Tuy nhiên, theo phản ánh ở một số địa phương, vẫn còn tình trạng một số cán bộ, công chức thuế có biểu hiện tiêu cực trong quá trình thực thi công vụ, gây phiền hà, nhũng nhiễu, ảnh hướng đến quyền lợi hợp pháp của người nộp thuế.\nTừ những lý do trên, việc đưa ra sáng kiến “Một số giải pháp góp phần nâng cao trách nhiệm công chức thuế trong thực thi công vụ” trong giai đoạn hiện nay là rất cần thiết.\n* Sự cần thiết, mục đích của việc thực hiện sáng kiến:\nCông chức thuế có vị trí vai trò rất quan trọng trong bộ máy cơ quan thuế. Để đáp ứng yêu cầu quản lý thuế trong sự nghiệp đổi mới đòi hỏi công chức thuế “có tâm trong sáng, có nghề tinh thông” không những phải thành thạo về chuyên môn, tinh thông nghiệp vụ mà còn phải có phẩm chất đạo đức lối sống lành mạnh, liêm chính. Thời gian qua, ngành Thuế đã thực hiện hai lần sắp xếp bộ máy. Lần thứ nhất từ ngày 01/3/2025 theo Quyết định 381/QĐ-BTC của Bộ Tài chính, Cục Thuế tỉnh Kiên Giang, Cục Thuế tỉnh Cà Mau và Cục Thuế tỉnh Bạc Liêu sáp nhập thành Chi cục Thuế khu vực XX, cơ cấu tổ chức bộ máy gồm: 02 Bộ phận một cửa, 11 đơn vị cấp phòng và 14 Đội Thuế liên huyện, thành phố; có tổng cố 1.407 công chức và người lao động, trong đó: Biên chế: 1.275 công chức và 132 lao động hợp động. Tiếp đó, thực hiện Nghị quyết 60-NQ/TW ngày 12/4/2025 của Ban Chấp hành Trung ương Đảng về mô hình chính quyền địa phương 2 cấp, Bộ Tài chính ban hành Quyết định 2229/QĐ-BTC (có hiệu lực từ 1/7/2025). Theo đó, sắp xếp Thuế tỉnh Cà Mau gồm có 9 phòng và 8 đơn vị Thuế cơ sở, 35 tổ, có tổng số 529 công chức và người lao động, trong đó: Biên chế: 472 công chức và 57 người lao động. Trong quá trình sắp xếp tổ chức bộ máy mới, ngành Thuế tỉnh Cà Mau mặc dù gặp nhiều khó khăn, nhưng với sự nổ lực, vượt khó của tập thể công chức và người lao động của ngành đã đưa hoạt động công vụ của Thuế tỉnh Cà Mau vận hành cơ bản đạt yêu cầu. Tuy nhiên, qua thực hiện đã bộc lộ một số tồn tại nhất định: Việc thực hiện nhiệm vụ của một bộ phận công chức có nơi bị xao nhãng, hiệu quả thấp; hoạt động công vụ của một số Phòng chưa được quan tâm, lãnh đạo, chỉ đạo cũng như quán triệt thực hiện, nhất là công tác phối hợp của công chức giữa các bộ phận, các phòng, ...thiếu thường xuyên, từ đó ảnh hưởng không nhỏ đến hiệu quả hoạt động công vụ của toàn đơn vị. Để góp phần tăng cường kỷ luật, kỷ cương, nâng cao hiệu quả thực thi pháp luật, phát huy vai trò của công chức thuế và sự lãnh đạo, chỉ đạo, điều hành, trách nhiệm của Người đứng đầu các đơn vị trong thực thi công vụ. Chúng tôi đã nghiên cứu đề ra “Một số giải pháp góp phần nâng cao trách nhiệm công chức thuế trong thực thi công vụ” nhằm đóng góp ý kiến của mình để phần nào đó nâng cao trách nhiệm trong thực thi công vụ của công chức Thuế và trách nhiệm Người đứng đầu trong cơ quan, đơn vị.\nb. Nội dung sáng kiến:\nĐể đảm bảo kỷ luật, kỷ cương hành chính trong thực thi công vụ đồng thời nâng cao tinh thần trách nhiệm của mỗi đơn vị, cá nhân trong thực thi nhiệm vụ và phối hợp công tác. Nhóm đưa ra một số giải pháp duy trì và nghiêm túc thực hiện như sau:\n1. Quán triệt thực hiện nghiêm quy định về chức năng, nhiệm vụ, quyền hạn của Văn phòng, các Phòng, các Thuế cơ sở đến toàn thể công chức trong đơn vị. Hoàn thành việc phân công nhiệm vụ bằng văn bản trong tập thể lãnh đạo, công chức tại các Phòng, các Thuế cơ sở và Tổ. Thông báo bằng văn bản công khai danh sách công chức hỗ trợ NNT tại các đơn vị thuộc Thuế tỉnh cà Mau.\n2. Giao lãnh đạo các đơn vị siết chặt kỷ luật, kỷ cương; tăng cường kiểm tra công vụ, xử lý ngay các trường hợp xao nhãng, lơ là công việc chuyên môn và các hành vi gây phiền hà, sách nhiễu người nộp thuế. Nâng cao tinh thần, trách nhiệm, sự tận tụy, sáng tạo của công chức trong công tác chuyển đổi số, tái thiết kế quy trình, đơn giản hóa thủ tục hành chính theo hướng hiện đại. Các Phòng, Văn phòng, Thuế cơ sở tăng cường trao đổi chia sẽ, triển khai nhanh, đồng bộ ứng dụng quản lý thuế, thực hiện có hiệu quả nhằm nâng cao năng suất làm việc, hiệu quả quản lý thuế, chống thất thu ngân sách nhà nước.\n3. Quán triệt thực hiện nghiêm túc Nghị quyết số 18/NQ-TW ngày 25/10/2017 của Ban Chấp hành Trung ương về đổi mới, sắp xếp tổ chức bộ máy của hệ thống chính trị theo hướng tinh gọn, hiệu lực, hiệu quả; Chỉ thị số 05-CT/TW ngày 15/5/2016 của Bộ Chính trị về “Đẩy mạnh học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh”; Công văn số 11184/BTC-TCCB ngày 22/7/2025 của Bộ Tài chính; Quyết định số 828/QĐ-BTC ngày 8/6/2020 của Bộ trưởng Bộ Tài chính ban hành Quy chế văn hóa công sở tại các đơn vị thuộc trực thuộc Bộ Tài chính và các văn bản chỉ đạo của Cục Thuế như: Công văn số 176/CT-VP ngày 18/3/2025 về việc tiếp tục chấn chỉnh, tăng cường kỷ luật, kỷ cương trong giải quyết thủ tục hành chính, xử lý văn bản của Bộ Tài chính, Công văn số 261/CT-TTKT ngày 21/3/2025 về việc chấn chỉnh kỷ cương, kỷ luật trong thực thi công vụ, Công văn số 2002/CT-TCCB ngày 24/6/2025 về việc tăng cường kỷ luật, kỷ cương và văn hóa công sở tại đơn vị.\n4. Đề cao trách nhiệm người đứng đầu, cấp phó của người đứng đầu và trách nhiệm cá nhân của công chức trong thực thi công vụ. Tuân thủ nghiêm quy định trách nhiệm giải quyết công việc. Chủ động giải quyết công việc theo đúng thẩm quyền, trong phạm vi trách nhiệm của đơn vị, cá nhân phụ trách. Không chuyển công việc thuộc thẩm quyền lên cấp trên hoặc sang đơn vị khác, không đùn đẩy né tránh trách nhiệm.\n5. Tăng cường công tác tuyên truyền, phổ biến pháp luật sâu rộng với nhiều hình thức về phòng chống tham nhũng, lãng phí. Thực hiện tốt công tác kiểm tra, đôn đốc, giám sát việc thực hiện các biện pháp phòng chống tham nhũng. Cán bộ, đảng viên, công chức khi vi phạm kỷ luật, kỷ cương hành chính phải bị xem xét xử lý kỷ luật theo quy định của Đảng và pháp luật của Nhà nước. Triển khai Quyết định số 154/QĐ-CMA ngày 29/7/2025 của Thuế tỉnh Cà Mau ban hành quy chế làm việc của Thuế tỉnh Cà Mau đến toàn thể công chức và người lao động, xây dựng tác phong làm việc theo hướng khoa học, hiện đại, trang phục lịch sự, gọn gàng trong khi làm việc, giải quyết công việc với tổ chức, công dân; nâng cao nhận thức của cán bộ, công chức nhất là công chức tiếp xúc trực tiếp, thực hiện kiểm tra, làm việc với người nộp thuế.\n6. Quán triệt, triển khai đối với cán bộ, công chức chấp hành kỷ luật, kỷ cương hành chính, văn hóa công sở và sử dụng có hiệu quả thời gian làm việc; cụ thể hóa trách nhiệm của từng cá nhân, đơn vị trong việc thực hiện nhiệm vụ được giao, bảo đảm cấp dưới phục tùng sự lãnh đạo, chỉ đạo và chấp hành nghiêm chỉnh các quyết định của cấp trên. Rà soát nhiệm vụ cụ thể đối với từng vị trí việc làm của công chức; xác định rõ những vị trí dễ phát sinh tiêu cực, những vị trí không đáp ứng yêu cầu để bố trí lại cho phù hợp với năng lực, sở trường, tinh thần trách nhiệm.\n7. Chú trọng công tác bảo vệ chính trị nội bộ nhất là trong công tác tuyển chọn, quy hoạch, bổ nhiệm và luân chuyển công chức bảo đảm đúng tiêu chuẩn chính trị, thủ tục, nguyên tắc quy định nhằm tăng cường đoàn kết và phòng ngừa tiêu cực trong nội bộ đơn vị.\n8. Người đứng đầu cấp ủy, Thủ trưởng đơn vị nêu cao tính tiên phong, gương mẫu trong việc thực hiện Quy định số 55-QĐ/TW của Bộ Chính trị; tăng cường công tác kiểm tra, giám sát và chịu trách nhiệm trước cấp có thẩm quyền trong công tác quản lý, đánh giá, phân loại, bố trí, sử dụng cán bộ, đảng viên, công chức tại đơn vị mình.\n9. Từng cán bộ, đảng viên, công chức, nhất là công chức giữ chức vụ lãnh đạo, quản lý phải tuân thủ quy trình, quy định và trật tự hành chính; gương mẫu thực hiện nhiệm vụ được giao. Thực hiện nghiêm các quy định về đạo đức công vụ, văn hóa công sở; phấn đấu làm việc với tinh thần, trách nhiệm cao nhất theo phương châm “Làm hết việc chứ không hết giờ”. Trong thực thi nhiệm vụ, công vụ phải tuân thủ tính thứ bậc, kỷ cương và trật tự hành chính, đúng thẩm quyền. Nghiêm túc thực hiện công việc, nhiệm vụ được giao, không để quá hạn, bỏ sót nhiệm vụ; không đùn đẩy trách nhiệm, không né tránh công việc. Nghiêm cấm lợi dụng chức năng, nhiệm vụ để gây nhũng nhiễu, phiền hà, trục lợi khi xử lý, giải quyết công việc liên quan đến người nộp thuế.\n10. Triển khai thực hiện đồng bộ các chủ trương, chính sách, quy định của pháp luật về tiếp công dân, giải quyết khiếu nại, tố cáo. Nâng cao chất lượng, hiệu quả công tác tiếp công dân, xử lý đơn thư và giải quyết khiếu nại, tố cáo, hạn chế khiếu nại, tố cáo vượt cấp.\n11. Tăng cường công tác kiểm tra công vụ để kịp thời chấn chỉnh các vi phạm kỷ luật, kỷ cương hành chính, quy trình nghiệp vụ, quy tắc ứng xử, đạo đức nghề nghiệp trong thực thi công vụ nhất là đối với công chức thường xuyên tiếp xúc với người nộp thuế.\n12. Cấp ủy, Thủ trưởng đơn vị là người chịu trách nhiệm trong công tác lãnh đạo, chỉ đạo toàn diện công tác quản lý cán bộ tại đơn vị; nghiêm túc thực hiện và công khai minh bạch các quy định có liên quan trong công tác tổ chức cán bộ, kiên quyết không để xảy ra sai phạm, tiêu cực. Tăng cường công tác kiểm tra, giám sát công tác tổ chức cán bộ, chú trọng kiểm tra, giám sát người đứng đầu đơn vị trong việc thực hiện chức trách nhiệm vụ được giao, việc thực hiện các kết luận, chấn chỉnh sau thanh tra, kiểm tra, việc thực hiện các quy định, quy chế về công tác tổ chức cán bộ; kịp thời phát hiện, chấn chỉnh và xử lý nghiêm theo quy định của pháp luật đối với thủ trưởng các đơn vị đã để xảy ra sai phạm, cá nhân công chức có biểu hiện chuyên quyền, độc đoán, thiếu dân chủ và có sai phạm trong công tác quản lý thuế.\n* Tính mới của sáng kiến:\nĐối với tập thể: Xây dựng và tổ chức thực hiện chương trình, kế hoạch công tác cụ thể trên cơ sở nhiệm vụ được giao và phù hợp với nhiệm vụ của cơ quan, đơn vị; trong thực hiện nhiệm vụ chọn một số công việc, vấn đề cụ thể mang tính đột phá, lấy kết quả thực hiện kế hoạch là một trong những tiêu chí đánh giá phân loại tập thể cuối năm.\nĐối với cá nhân: Từng đảng viên, công chức nhận thức sâu sắc được tầm quan trọng của công tác Thuế, cũng như vị trí, vai trò của bản thân mình trong từng nhiệm vụ cụ thể được Lãnh đạo phân công phụ trách; Tuyệt đối tin tưởng vào sự lãnh đạo của Đảng, có lập trường tư tưởng vững vàng; dám nghĩ, dám làm và dám tự chịu trách nhiệm trong công việc được lãnh đạo phân công. Mỗi cá nhân khi được phân công nhiệm vụ, tự xác định được trách nhiệm của bản thân sẽ thực hiện những công việc gì? và phải làm như thế nào? từ đó tự xây dựng cho mình bản mô tả công việc đồng thời xây dựng kế hoạch và đề ra những giải pháp thực hiện cho từng mãng công việc. Cuối cùng là thời gian hoàn thành công việc, để có sự sắp xếp hợp lý, khoa học trong quá trình giải quyết công việc. Trong quá trình thực hiện nếu có vướng mắc hay gặp những khó khăn, công chức trình lãnh đạo cấp trên để có những phương hướng giải quyết kịp thời, không gây ảnh hưởng đến công việc và phiền hà đến người nộp thuế. Chỉ có “Nhận thức đúng thì Hành động đúng”, là một công chức ngành Thuế, bản thân nhận thức được trách nhiệm cũng như vị trí, vai trò của mình trong từng nhiệm vụ cụ thể thì đối với việc hoàn thành nhiệm vụ chính trị của ngành hay để giữ gìn kỷ luật, kỷ cương, nâng cao hiệu quả thực thi pháp luật trong thực hiện nhiệm vụ trên tinh thần “Chỉ tiêu một - Kế hoạch năm - Quyết tâm phải là mười” sẽ luôn đạt được kết quả cao nhất.\nc. Hiệu quả và phạm vi áp dụng của sáng kiến, giải pháp:Sự quyết tâm hoàn thành nhiệm vụ chính trị của ngành, dưới sự lãnh đạo của cấp ủy Đảng và Tập thể Lãnh đạo cùng với sự cố gắng phấn đấu của toàn thể công chức, người lao động trong ngành Thuế tỉnh. Kết quả thu ngân sách 9 tháng đầu năm 2025, Thuế tỉnh Cà Mau đạt tỷ lệ 84% (8.400 tỷ đồng/10.053 tỷ đồng). Nhất là thời điểm hiện tại, Một số giải pháp góp phần nâng cao trách nhiệm công chức thuế trong thực thi công vụ đã góp phần cùng ngành Thuế tỉnh trước, trong và sau khi sắp xếp tổ chức bộ máy theo chính quyền địa phương 2 cấp đã đi vào hoạt động, ổn định quá trình triển khai diễn ra thông suốt, không bị gián đoạn. Mô hình mới tạo thuận lợi cho người nộp thuế trong thực hiện thủ tục hành chính, đồng thời đáp ứng yêu cầu ứng dụng công nghệ thông tin, chuyển đổi số và hiện đại hóa ngành Thuế. Qua đó, giúp mỗi công chức thuế luôn ý thức khi làm bất cứ việc gì trước hết xác định được mục đích rõ ràng, đúng đắn, phải có chương trình, kế hoạch, giải pháp cụ thể để thực hiện. Kịp thời đề xuất những giải pháp hữu hiệu để hoàn thành xuất sắc chỉ tiêu, nhiệm vụ của cấp trên giao hàng tháng, quý, năm, góp phần hoàn thành xuất sắc nhiệm vụ thu ngân sách của ngành. Luôn giữ gìn đoàn kết tốt trong nội bộ, sẵn sàng chia sẽ, hỗ trợ nhau để cùng hoàn thành nhiệm vụ, cùng nhau tiến bộ.\n- Đối tượng, đơn vị áp dụng: Toàn thể Công chức và người lao động thuộc Thuế tỉnh Cà Mau.\n- Phạm vi, khả năng nhân rộng: Thuế tỉnh Cà Mau.\n5. Hội đồng cơ sở đã xét công nhận sáng kiến: Quyết định số 1109/QĐ-CMA ngày 23 tháng 10 năm 2025.\n6. Thời gian áp dụng: 01/10/2024./.', '<p>BÁO CÁO MÔ TẢ SÁNG KIẾN</p><p>1. Tên sáng kiến: Một số giải pháp góp phần nâng cao trách nhiệm công chức thuế trong thực thi công vụ.</p><p>2. Họ và tên nhóm tác giả sáng kiến, chức danh, trình độ chuyên môn:</p><p>3. Lĩnh vực áp dụng: Lĩnh vực khác, nâng cao chất lượng công tác chuyên môn nghiệp vụ</p><p>4. Mô tả sáng kiến</p><p>a. Khái quát đặc điểm, tình hình trước khi có sáng kiến:</p><p>* Đặc điểm, tình hình trước khi có sáng kiến:</p><p>Trong điều kiện kinh tế, khoa học công nghệ ngày càng phát triển với tốc độ cao, các thành phần kinh tế, các hình thức kinh doanh, số lượng đối tượng nộp thuế phát triển một cách nhanh chóng, đa dạng, theo đó quy mô hoạt động của các doanh nghiệp được mở rộng và mang tính toàn cầu, việc quản lý kinh doanh và các giao dịch thương mại ngày càng được tin học hóa nên nhiệm vụ quản lý thuế trở nên khó khăn, phức tạp. Nhất là trong giai đoạn hiện nay, thực hiện Nghị quyết số 18/NQ-TW ngày 25/10/2017 của Ban Chấp hành Trung ương về đổi mới, sắp xếp tổ chức bộ máy của hệ thống chính trị theo hướng tinh gọn, hiệu lực, hiệu quả; cùng với chỉ đạo của Chính phủ, Bộ Tài chính, Cục Thuế, ngành Thuế tỉnh đã triển khai các biện pháp cải cách, hiện đại hóa nhằm nâng cao hiệu quả quản lý thuế và phục vụ tốt hơn cho người nộp thuế. Tuy nhiên, theo phản ánh ở một số địa phương, vẫn còn tình trạng một số cán bộ, công chức thuế có biểu hiện tiêu cực trong quá trình thực thi công vụ, gây phiền hà, nhũng nhiễu, ảnh hướng đến quyền lợi hợp pháp của người nộp thuế.</p><p>Từ những lý do trên, việc đưa ra sáng kiến “Một số giải pháp góp phần nâng cao trách nhiệm công chức thuế trong thực thi công vụ” trong giai đoạn hiện nay là rất cần thiết.</p><p>* Sự cần thiết, mục đích của việc thực hiện sáng kiến:</p><p>Công chức thuế có vị trí vai trò rất quan trọng trong bộ máy cơ quan thuế. Để đáp ứng yêu cầu quản lý thuế trong sự nghiệp đổi mới đòi hỏi công chức thuế “có tâm trong sáng, có nghề tinh thông” không những phải thành thạo về chuyên môn, tinh thông nghiệp vụ mà còn phải có phẩm chất đạo đức lối sống lành mạnh, liêm chính. Thời gian qua, ngành Thuế đã thực hiện hai lần sắp xếp bộ máy. Lần thứ nhất từ ngày 01/3/2025 theo Quyết định 381/QĐ-BTC của Bộ Tài chính, Cục Thuế tỉnh Kiên Giang, Cục Thuế tỉnh Cà Mau và Cục Thuế tỉnh Bạc Liêu sáp nhập thành Chi cục Thuế khu vực XX, cơ cấu tổ chức bộ máy gồm: 02 Bộ phận một cửa, 11 đơn vị cấp phòng và 14 Đội Thuế liên huyện, thành phố; có tổng cố 1.407 công chức và người lao động, trong đó: Biên chế: 1.275 công chức và 132 lao động hợp động. Tiếp đó, thực hiện Nghị quyết 60-NQ/TW ngày 12/4/2025 của Ban Chấp hành Trung ương Đảng về mô hình chính quyền địa phương 2 cấp, Bộ Tài chính ban hành Quyết định 2229/QĐ-BTC (có hiệu lực từ 1/7/2025). Theo đó, sắp xếp Thuế tỉnh Cà Mau gồm có 9 phòng và 8 đơn vị Thuế cơ sở, 35 tổ, có tổng số 529 công chức và người lao động, trong đó: Biên chế: 472 công chức và 57 người lao động. Trong quá trình sắp xếp tổ chức bộ máy mới, ngành Thuế tỉnh Cà Mau mặc dù gặp nhiều khó khăn, nhưng với sự nổ lực, vượt khó của tập thể công chức và người lao động của ngành đã đưa hoạt động công vụ của Thuế tỉnh Cà Mau vận hành cơ bản đạt yêu cầu. Tuy nhiên, qua thực hiện đã bộc lộ một số tồn tại nhất định: Việc thực hiện nhiệm vụ của một bộ phận công chức có nơi bị xao nhãng, hiệu quả thấp; hoạt động công vụ của một số Phòng chưa được quan tâm, lãnh đạo, chỉ đạo cũng như quán triệt thực hiện, nhất là công tác phối hợp của công chức giữa các bộ phận, các phòng, ...thiếu thường xuyên, từ đó ảnh hưởng không nhỏ đến hiệu quả hoạt động công vụ của toàn đơn vị. Để góp phần tăng cường kỷ luật, kỷ cương, nâng cao hiệu quả thực thi pháp luật, phát huy vai trò của công chức thuế và sự lãnh đạo, chỉ đạo, điều hành, trách nhiệm của Người đứng đầu các đơn vị trong thực thi công vụ. Chúng tôi đã nghiên cứu đề ra “Một số giải pháp góp phần nâng cao trách nhiệm công chức thuế trong thực thi công vụ” nhằm đóng góp ý kiến của mình để phần nào đó nâng cao trách nhiệm trong thực thi công vụ của công chức Thuế và trách nhiệm Người đứng đầu trong cơ quan, đơn vị.</p><p>b. Nội dung sáng kiến:</p><p>Để đảm bảo kỷ luật, kỷ cương hành chính trong thực thi công vụ đồng thời nâng cao tinh thần trách nhiệm của mỗi đơn vị, cá nhân trong thực thi nhiệm vụ và phối hợp công tác. Nhóm đưa ra một số giải pháp duy trì và nghiêm túc thực hiện như sau:</p><p>1. Quán triệt thực hiện nghiêm quy định về chức năng, nhiệm vụ, quyền hạn của Văn phòng, các Phòng, các Thuế cơ sở đến toàn thể công chức trong đơn vị. Hoàn thành việc phân công nhiệm vụ bằng văn bản trong tập thể lãnh đạo, công chức tại các Phòng, các Thuế cơ sở và Tổ. Thông báo bằng văn bản công khai danh sách công chức hỗ trợ NNT tại các đơn vị thuộc Thuế tỉnh cà Mau.</p><p>2. Giao lãnh đạo các đơn vị siết chặt kỷ luật, kỷ cương; tăng cường kiểm tra công vụ, xử lý ngay các trường hợp xao nhãng, lơ là công việc chuyên môn và các hành vi gây phiền hà, sách nhiễu người nộp thuế. Nâng cao tinh thần, trách nhiệm, sự tận tụy, sáng tạo của công chức trong công tác chuyển đổi số, tái thiết kế quy trình, đơn giản hóa thủ tục hành chính theo hướng hiện đại. Các Phòng, Văn phòng, Thuế cơ sở tăng cường trao đổi chia sẽ, triển khai nhanh, đồng bộ ứng dụng quản lý thuế, thực hiện có hiệu quả nhằm nâng cao năng suất làm việc, hiệu quả quản lý thuế, chống thất thu ngân sách nhà nước.</p><p>3. Quán triệt thực hiện nghiêm túc Nghị quyết số 18/NQ-TW ngày 25/10/2017 của Ban Chấp hành Trung ương về đổi mới, sắp xếp tổ chức bộ máy của hệ thống chính trị theo hướng tinh gọn, hiệu lực, hiệu quả; Chỉ thị số 05-CT/TW ngày 15/5/2016 của Bộ Chính trị về “Đẩy mạnh học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh”; Công văn số 11184/BTC-TCCB ngày 22/7/2025 của Bộ Tài chính; Quyết định số 828/QĐ-BTC ngày 8/6/2020 của Bộ trưởng Bộ Tài chính ban hành Quy chế văn hóa công sở tại các đơn vị thuộc trực thuộc Bộ Tài chính và các văn bản chỉ đạo của Cục Thuế như: Công văn số 176/CT-VP ngày 18/3/2025 về việc tiếp tục chấn chỉnh, tăng cường kỷ luật, kỷ cương trong giải quyết thủ tục hành chính, xử lý văn bản của Bộ Tài chính, Công văn số 261/CT-TTKT ngày 21/3/2025 về việc chấn chỉnh kỷ cương, kỷ luật trong thực thi công vụ, Công văn số 2002/CT-TCCB ngày 24/6/2025 về việc tăng cường kỷ luật, kỷ cương và văn hóa công sở tại đơn vị.</p><p>4. Đề cao trách nhiệm người đứng đầu, cấp phó của người đứng đầu và trách nhiệm cá nhân của công chức trong thực thi công vụ. Tuân thủ nghiêm quy định trách nhiệm giải quyết công việc. Chủ động giải quyết công việc theo đúng thẩm quyền, trong phạm vi trách nhiệm của đơn vị, cá nhân phụ trách. Không chuyển công việc thuộc thẩm quyền lên cấp trên hoặc sang đơn vị khác, không đùn đẩy né tránh trách nhiệm.</p><p>5. Tăng cường công tác tuyên truyền, phổ biến pháp luật sâu rộng với nhiều hình thức về phòng chống tham nhũng, lãng phí. Thực hiện tốt công tác kiểm tra, đôn đốc, giám sát việc thực hiện các biện pháp phòng chống tham nhũng. Cán bộ, đảng viên, công chức khi vi phạm kỷ luật, kỷ cương hành chính phải bị xem xét xử lý kỷ luật theo quy định của Đảng và pháp luật của Nhà nước. Triển khai Quyết định số 154/QĐ-CMA ngày 29/7/2025 của Thuế tỉnh Cà Mau ban hành quy chế làm việc của Thuế tỉnh Cà Mau đến toàn thể công chức và người lao động, xây dựng tác phong làm việc theo hướng khoa học, hiện đại, trang phục lịch sự, gọn gàng trong khi làm việc, giải quyết công việc với tổ chức, công dân; nâng cao nhận thức của cán bộ, công chức nhất là công chức tiếp xúc trực tiếp, thực hiện kiểm tra, làm việc với người nộp thuế.</p><p>6. Quán triệt, triển khai đối với cán bộ, công chức chấp hành kỷ luật, kỷ cương hành chính, văn hóa công sở và sử dụng có hiệu quả thời gian làm việc; cụ thể hóa trách nhiệm của từng cá nhân, đơn vị trong việc thực hiện nhiệm vụ được giao, bảo đảm cấp dưới phục tùng sự lãnh đạo, chỉ đạo và chấp hành nghiêm chỉnh các quyết định của cấp trên. Rà soát nhiệm vụ cụ thể đối với từng vị trí việc làm của công chức; xác định rõ những vị trí dễ phát sinh tiêu cực, những vị trí không đáp ứng yêu cầu để bố trí lại cho phù hợp với năng lực, sở trường, tinh thần trách nhiệm.</p><p>7. Chú trọng công tác bảo vệ chính trị nội bộ nhất là trong công tác tuyển chọn, quy hoạch, bổ nhiệm và luân chuyển công chức bảo đảm đúng tiêu chuẩn chính trị, thủ tục, nguyên tắc quy định nhằm tăng cường đoàn kết và phòng ngừa tiêu cực trong nội bộ đơn vị.</p><p>8. Người đứng đầu cấp ủy, Thủ trưởng đơn vị nêu cao tính tiên phong, gương mẫu trong việc thực hiện Quy định số 55-QĐ/TW của Bộ Chính trị; tăng cường công tác kiểm tra, giám sát và chịu trách nhiệm trước cấp có thẩm quyền trong công tác quản lý, đánh giá, phân loại, bố trí, sử dụng cán bộ, đảng viên, công chức tại đơn vị mình.</p><p>9. Từng cán bộ, đảng viên, công chức, nhất là công chức giữ chức vụ lãnh đạo, quản lý phải tuân thủ quy trình, quy định và trật tự hành chính; gương mẫu thực hiện nhiệm vụ được giao. Thực hiện nghiêm các quy định về đạo đức công vụ, văn hóa công sở; phấn đấu làm việc với tinh thần, trách nhiệm cao nhất theo phương châm “Làm hết việc chứ không hết giờ”. Trong thực thi nhiệm vụ, công vụ phải tuân thủ tính thứ bậc, kỷ cương và trật tự hành chính, đúng thẩm quyền. Nghiêm túc thực hiện công việc, nhiệm vụ được giao, không để quá hạn, bỏ sót nhiệm vụ; không đùn đẩy trách nhiệm, không né tránh công việc. Nghiêm cấm lợi dụng chức năng, nhiệm vụ để gây nhũng nhiễu, phiền hà, trục lợi khi xử lý, giải quyết công việc liên quan đến người nộp thuế.</p><p>10. Triển khai thực hiện đồng bộ các chủ trương, chính sách, quy định của pháp luật về tiếp công dân, giải quyết khiếu nại, tố cáo. Nâng cao chất lượng, hiệu quả công tác tiếp công dân, xử lý đơn thư và giải quyết khiếu nại, tố cáo, hạn chế khiếu nại, tố cáo vượt cấp.</p><p>11. Tăng cường công tác kiểm tra công vụ để kịp thời chấn chỉnh các vi phạm kỷ luật, kỷ cương hành chính, quy trình nghiệp vụ, quy tắc ứng xử, đạo đức nghề nghiệp trong thực thi công vụ nhất là đối với công chức thường xuyên tiếp xúc với người nộp thuế.</p><p>12. Cấp ủy, Thủ trưởng đơn vị là người chịu trách nhiệm trong công tác lãnh đạo, chỉ đạo toàn diện công tác quản lý cán bộ tại đơn vị; nghiêm túc thực hiện và công khai minh bạch các quy định có liên quan trong công tác tổ chức cán bộ, kiên quyết không để xảy ra sai phạm, tiêu cực. Tăng cường công tác kiểm tra, giám sát công tác tổ chức cán bộ, chú trọng kiểm tra, giám sát người đứng đầu đơn vị trong việc thực hiện chức trách nhiệm vụ được giao, việc thực hiện các kết luận, chấn chỉnh sau thanh tra, kiểm tra, việc thực hiện các quy định, quy chế về công tác tổ chức cán bộ; kịp thời phát hiện, chấn chỉnh và xử lý nghiêm theo quy định của pháp luật đối với thủ trưởng các đơn vị đã để xảy ra sai phạm, cá nhân công chức có biểu hiện chuyên quyền, độc đoán, thiếu dân chủ và có sai phạm trong công tác quản lý thuế.</p><p>* Tính mới của sáng kiến:</p><p>Đối với tập thể: Xây dựng và tổ chức thực hiện chương trình, kế hoạch công tác cụ thể trên cơ sở nhiệm vụ được giao và phù hợp với nhiệm vụ của cơ quan, đơn vị; trong thực hiện nhiệm vụ chọn một số công việc, vấn đề cụ thể mang tính đột phá, lấy kết quả thực hiện kế hoạch là một trong những tiêu chí đánh giá phân loại tập thể cuối năm.</p><p>Đối với cá nhân: Từng đảng viên, công chức nhận thức sâu sắc được tầm quan trọng của công tác Thuế, cũng như vị trí, vai trò của bản thân mình trong từng nhiệm vụ cụ thể được Lãnh đạo phân công phụ trách; Tuyệt đối tin tưởng vào sự lãnh đạo của Đảng, có lập trường tư tưởng vững vàng; dám nghĩ, dám làm và dám tự chịu trách nhiệm trong công việc được lãnh đạo phân công. Mỗi cá nhân khi được phân công nhiệm vụ, tự xác định được trách nhiệm của bản thân sẽ thực hiện những công việc gì? và phải làm như thế nào? từ đó tự xây dựng cho mình bản mô tả công việc đồng thời xây dựng kế hoạch và đề ra những giải pháp thực hiện cho từng mãng công việc. Cuối cùng là thời gian hoàn thành công việc, để có sự sắp xếp hợp lý, khoa học trong quá trình giải quyết công việc. Trong quá trình thực hiện nếu có vướng mắc hay gặp những khó khăn, công chức trình lãnh đạo cấp trên để có những phương hướng giải quyết kịp thời, không gây ảnh hưởng đến công việc và phiền hà đến người nộp thuế. Chỉ có “Nhận thức đúng thì Hành động đúng”, là một công chức ngành Thuế, bản thân nhận thức được trách nhiệm cũng như vị trí, vai trò của mình trong từng nhiệm vụ cụ thể thì đối với việc hoàn thành nhiệm vụ chính trị của ngành hay để giữ gìn kỷ luật, kỷ cương, nâng cao hiệu quả thực thi pháp luật trong thực hiện nhiệm vụ trên tinh thần “Chỉ tiêu một - Kế hoạch năm - Quyết tâm phải là mười” sẽ luôn đạt được kết quả cao nhất.</p><p>c. Hiệu quả và phạm vi áp dụng của sáng kiến, giải pháp:Sự quyết tâm hoàn thành nhiệm vụ chính trị của ngành, dưới sự lãnh đạo của cấp ủy Đảng và Tập thể Lãnh đạo cùng với sự cố gắng phấn đấu của toàn thể công chức, người lao động trong ngành Thuế tỉnh. Kết quả thu ngân sách 9 tháng đầu năm 2025, Thuế tỉnh Cà Mau đạt tỷ lệ 84% (8.400 tỷ đồng/10.053 tỷ đồng). Nhất là thời điểm hiện tại, Một số giải pháp góp phần nâng cao trách nhiệm công chức thuế trong thực thi công vụ đã góp phần cùng ngành Thuế tỉnh trước, trong và sau khi sắp xếp tổ chức bộ máy theo chính quyền địa phương 2 cấp đã đi vào hoạt động, ổn định quá trình triển khai diễn ra thông suốt, không bị gián đoạn. Mô hình mới tạo thuận lợi cho người nộp thuế trong thực hiện thủ tục hành chính, đồng thời đáp ứng yêu cầu ứng dụng công nghệ thông tin, chuyển đổi số và hiện đại hóa ngành Thuế. Qua đó, giúp mỗi công chức thuế luôn ý thức khi làm bất cứ việc gì trước hết xác định được mục đích rõ ràng, đúng đắn, phải có chương trình, kế hoạch, giải pháp cụ thể để thực hiện.  Kịp thời đề xuất những giải pháp hữu hiệu để hoàn thành xuất sắc chỉ tiêu, nhiệm vụ của cấp trên giao hàng tháng, quý, năm, góp phần hoàn thành xuất sắc nhiệm vụ thu ngân sách của ngành. Luôn giữ gìn đoàn kết tốt trong nội bộ, sẵn sàng chia sẽ, hỗ trợ nhau để cùng hoàn thành nhiệm vụ, cùng nhau tiến bộ.</p><p>- Đối tượng, đơn vị áp dụng: Toàn thể Công chức và người lao động thuộc Thuế tỉnh Cà Mau.</p><p>- Phạm vi, khả năng nhân rộng: Thuế tỉnh Cà Mau.</p><p>5. Hội đồng cơ sở đã xét công nhận sáng kiến: Quyết định số 1109/QĐ-CMA ngày 23 tháng 10 năm 2025.</p><p>6. Thời gian áp dụng: 01/10/2024./.</p>', '336dab69ddddf88a1efaf8ef4889e8dcdf53b011ff786bed4b6c76be231cf2ba', '2026-09-22 19:40:17');
INSERT INTO `qlsk_file_noi_dung` (`id`, `file_id`, `sang_kien_id`, `noi_dung`, `noi_dung_html`, `hash_noi_dung`, `ngay_trich_xuat`) VALUES
(14, 30, 37, 'BÁO CÁO MÔ TẢ SÁNG KIẾN\n1. Tên sáng kiến: Một số giải pháp chủ yếu nhằm làm tốt công tác tư tưởng trước, trong và sau khi sắp xếp tổ chức bộ máy ngành Thuế tỉnh theo Nghị quyết số 18-NQ/TW ngày 25/10/2017 của Ban Chấp hành Trung ương gắn với việc học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh. \n2. Họ và tên nhóm tác giả sáng kiến, chức danh, trình độ chuyên môn:\n3. Lĩnh vực áp dụng: Lĩnh vực khác, nâng cao chất lượng công tác chuyên môn nghiệp vụ\n4. Mô tả sáng kiến\na. Khái quát đặc điểm, tình hình trước khi có sáng kiến:\n* Đặc điểm tình hình trước khi có sáng kiến: Chủ tịch Hồ Chí Minh cho rằng, việc tinh giản bộ máy nhà nước luôn đi liền với vấn đề tiết kiệm chi phí, chống lãng phí, chống quan liêu, cửa quyền. Khi bàn về tinh giản bộ máy nhà nước, Người khẳng định: “Riêng cơ quan cung cấp tổ chức còn kềnh càng, thừa người, phải sắp xếp cho gọn gàng, hợp lý, mọi người đều có công việc thiết thực, những người thừa phải đưa đi chỗ thiếu, những người ở lại phải thi đua nâng cao năng suất của mình. Thế là tinh giản, tinh là năng suất lên cao, làm cho mau, cho tốt, giản là vừa phải, không kềnh càng, tránh hình thức”. Những nội dung, quan điểm, tư tưởng của Chủ tịch Hồ Chí Minh về tinh giản bộ máy nhà nước vẫn còn nguyên về mặt giá trị lý luận và thực tiễn; tiếp tục trở thành nền tảng tư tưởng và kim chỉ nam cho Đảng, Nhà nước kế thừa, phát huy, vận dụng và phát triển một cách sáng tạo trong xây dựng Nhà nước pháp quyền xã hội chủ nghĩa Việt Nam trong giai đoạn hiện nay. Việc sắp xếp tố chức bộ máy ngành Thuế theo Nghị quyết số 18-NQ/TW ngày 25/10/2017 của Ban Chấp hành Trung ương gắn với việc học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh thông qua việc xây dựng bộ máy hành chính nhà nước, trong đó có ngành Thuế, tinh gọn, hiệu lực, hiệu quả. Điều này đòi hỏi các đơn vị thuộc ngành Thuế phải tăng cường quản lý nội ngành, kỷ luật, kỷ cương, nhằm hoàn thành tốt nhiệm vụ thu ngân sách nhà nước, phục vụ người dân và doanh nghiệp tốt hơn, thể hiện rõ nét tinh thần trách nhiệm và “Vì nhân dân phục vụ” mà Chủ tịch Hồ Chí Minh đã dạy.\n* Sự cần thiết, mục đích của việc thực hiện sáng kiến:\nSinh thời, Chủ tịch Hồ Chí Minh rất quan tâm đến công tác tư tưởng. Người cho rằng: “Trong đảng và ngoài đảng có nhận rõ tình hình mới, hiểu rõ nhiệm vụ mới thì tư tưởng mới thống nhất, tư tưởng thống nhất thì hành động mới thống nhất”. Công tác tư tưởng tự bản thân nó đã hàm chứa những vấn đề nhạy cảm, phức tạp, đa chiều liên quan đến tâm tư, nguyện vọng của đảng viên, công chức.\nHiện nay, việc sắp xếp, tinh gọn bộ máy đã và đang được triển khai quyết liệt ở các cấp, các ngành từ Trung ương đến địa phương, với mục tiêu xây dựng một hệ thống chính trị, gọn nhẹ, minh bạch, vững mạnh, hoạt động hiệu lực, hiệu quả. Lợi dụng vấn đề, các thế lực thù địch tăng cường tung tin, vu khống, xuyên tạc, chống phá Đảng và Nhà nước ta. Vì lẽ đó, đội ngũ cán bộ, đảng viên, công chức cần thống nhất trong nhận thức và hành động, tỉnh táo trước những luận điệu xuyên tác, lực lượng thù địch. Thực hiện Nghị quyết số 18-NQ/TW của Ban Chấp hành Trung ương khóa XII về một số vấn đề tiếp tục đổi mới, sắp xếp tổ chức bộ máy của hệ thống chính trị tinh gọn, hoạt động hiệu lực, hiệu quả; Kết luận số 09-KL/BCĐ ngày 24/11/2024 của Ban Chỉ đạo Trung ương về việc tiếp tục đẩy mạnh việc sắp xếp, tinh gọn bộ máy; Chỉ thị số 03/CT-BTC ngày 03/12/2024 của Bộ trưởng Bộ Tài chính về công tác đổi mới, sắp xếp tổ chức bộ máy Bộ Tài chính. Theo đó, trong thời gian qua, ngành Thuế đã quyết liệt, chủ động trong xây dựng và hoàn thiện phương án sắp xếp, tinh gọn tổ chức, bộ máy cơ quan thuế các cấp theo đúng chủ trương, định hướng của Đảng, Nhà nước và của Bộ Tài chính. Bên cạnh việc tinh gọn bộ máy giúp cơ quan thuế nâng cao hiệu năng, hiệu lực, hiệu quả hoạt động, thì quá trình sắp xếp cơ cấu tổ chức cũng sẽ phát sinh những vấn đề nhạy cảm, phức tạp như: cắt giảm biên chế, sắp xếp lại đội ngũ, dôi dư cấp lãnh đạo, khoảng cách địa lý, môi trường làm việc thay đổi,...ảnh hưởng trực tiếp đến tâm lý và quyền lợi của công chức, người lao động, đòi hỏi phải có sự thống nhất cao về nhận thức và hành động, quyết tâm chính trị mạnh mẽ. Đặc biệt, Cục Thuế tỉnh Bạc Liêu thuộc địa bàn tỉnh Bạc Liêu (trước sắp xếp) là đơn vị chịu sự tác động trực tiếp khi sắp xếp chính quyền địa phương 02 cấp. Sự đổi mới này không tránh khỏi những khó khăn, thách thức. Mỗi quyết định đưa ra đều là kết quả của những trăn trở, cân nhắc kỹ lưỡng để hài hòa giữa lợi ích chung và nguyện vọng chính đáng của từng công chức. Xuất phát từ tình hình trên, nhóm chúng tôi đã đưa ra “Một số giải pháp chủ yếu nhằm làm tốt công tác tư tưởng trước, trong và sau khi sắp xếp tổ chức bộ máy ngành Thuế tỉnh theo Nghị quyết số 18-NQ/TW ngày 25/10/2017 của Ban Chấp hành Trung ương gắn với việc học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh”.\nb. Nội dung sáng kiến:\nTrước ngày 01/3/2025, Cục Thuế tỉnh Cà Mau và Cục Thuế tỉnh Bạc Liêu gồm có: 22 phòng, 08 Chi cục Thuế thành phố, khu vực, 47 đội thuế, có tổng số 756 công chức và người lao động, trong đó: Biên chế: 681 công chức, 75 hợp đồng. Ngành Thuế đã thực hiện hai lần sắp xếp bộ máy. Lần thứ nhất từ ngày 01/3/2025 theo Quyết định 381/QĐ-BTC của Bộ Tài chính. Tiếp đó, thực hiện Nghị quyết 60-NQ/TW ngày 12/4/2025 của Ban Chấp hành Trung ương Đảng về mô hình chính quyền địa phương 2 cấp, Bộ Tài chính ban hành Quyết định 2229/QĐ-BTC (có hiệu lực từ 1/7/2025). Theo đó, sắp xếp Thuế tỉnh Cà Mau gồm có 9 phòng và 8 đơn vị Thuế cơ sở, 35 tổ, có tổng số 529 công chức và người lao động, trong đó: Biên chế: 472 công chức và 57 người lao động. Như vậy ngành Thuế đã đồng bộ với mô hình chính quyền địa phương 2 cấp, đã cắt giảm mạnh từ hơn 77 đầu mối xuống còn hơn 52 đầu mối. Bằng việc chuyển đổi từ mô hình “quản lý thuế theo chức năng, kết hợp với đối tượng” sang mô hình “quản lý theo đối tượng, kết hợp với chức năng” là bước ngoặt mang tính chiến lược. Mỗi công chức thuế giờ đây không chỉ thực hiện chuyên môn đơn lẻ mà còn là người đồng hành, hỗ trợ toàn diện cho người nộp thuế. Điều này không chỉ đòi hỏi năng lực chuyên môn cao mà còn là sự tận tâm, trách nhiệm và sẵn sàng thích nghi với sự thay đổi. Bên cạnh đó, ngày 14/02/2025, Tổng Cục Thuế có Công văn số 640/TCT-TCCB yêu cầu toàn ngành Thuế quán triệt thực hiện tốt công tác chính trị, tư tưởng, công tác chuyên môn khi sắp xếp, tinh gọn bộ máy. Qua đó, nhóm rút ra một số giải pháp chủ yếu nhằm làm tốt công tác tư tưởng trước, trong và sau khi sắp xếp tổ chức bộ máy ngành Thuế tỉnh theo Nghị quyết số 18-NQ/TW ngày 25/10/2017 của Ban Chấp hành Trung ương như sau:\nMột là. Tăng cường kỷ luật, kỷ cương nội ngành: Ngành Thuế tỉnh tăng cường tái cấu trúc bộ máy, thực hiện siết chặt kỷ luật, kỷ cương trong thực thi công vụ và trong công tác quản lý thuế, đảm bảo hoàn thành xuất sắc các nhiệm vụ được giao. Xác định rõ việc sắp xếp, tinh gọn bộ máy là nhiệm vụ đặc biệt quan trọng, là đòi hỏi tất yếu nhằm nâng cao hiệu năng, hiệu lực, hiệu quả hoạt động của bộ máy vì sự phát triển bền vững của đất nước trong kỷ nguyên mới; tạo sự đồng thuận, thống nhất trong đội ngũ công chức, người lao động khi thực hiện việc sắp xếp, tinh gọn bộ máy.\nHai là, Xác định tầm quan trọng trong công tác giáo dục chính trị, tư tưởng có ý nghĩa quyết định đến việc xây dựng Đảng vững mạnh về chính trị, tư tưởng, đạo đức, tổ chức và cán bộ, làm cơ sở để nâng cao năng lực lãnh đạo, năng lực cầm quyền, sức chiến đấu của Đảng và hiệu lực hiệu quả quản lý Nhà nước. Đảng ủy thường xuyên chỉ đạo cấp ủy trực thuộc nâng cao chất lượng công tác tuyên truyền, giáo dục, học tập, quán triệt chủ nghĩa Mác-Lênin, tư tưởng Hồ Chí Minh cho cán bộ, đảng viên, công chức. Ngoài ra còn tổ chức các cuộc hội nghị để kịp thời thông tin thời sự về tình hình quốc tế, trong nước và trong tỉnh cho toàn thể cán bộ, đảng viên, công chức trong cơ quan theo chỉ đạo của Ban Thường vụ Tỉnh ủy, Ban Thường vụ Đảng ủy Khối...\nĐặc biệt Đảng ủy Cục Thuế đẩy mạnh việc học tập và làm theo tư tưởng, đạo đức phong cách Hồ Chí Minh theo Kết luận số 21-KL/TW của Bộ Chính trị về tiếp tục thực hiện Chỉ thị số 05-CT/TW, ngày 15/5/2016 của Bộ Chính trị về “Đẩy mạnh học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh”. Để tăng cường sự đoàn kết thống nhất ở cấp ủy và các chi bộ trực thuộc Đảng bộ, từ Cục Thuế đến các Chi cục Thuế trực thuộc, tạo nên sự thống nhất từ tư tưởng đến hành động của mỗi đảng viên, công chức. Hàng năm căn cứ vào văn bản hướng dẫn của Đảng ủy Khối. Đảng ủy Cục Thuế đã xây dựng và ban hành Kế hoạch học tập, đề ra phương hướng, nhiệm vụ, các giải pháp để thực hiện nhằm đảm bảo tính kịp thời và phù hợp với định hướng chỉ đạo của cấp trên. Nội dung triển khai thực hiện việc học tập và làm theo Bác trên tinh thần sáng tạo và phù hợp với điều kiện, hoàn cảnh, thực tế của đơn vị theo từng giai đoạn nhất định. Đảng ủy Cục Thuế đề nghị mỗi một chi bộ xây dựng mô hình học tập Bác, gắn với nhiệm vụ chuyên môn của ngành, với phong trào thi đua: “Vì người nghèo - Không để ai bị bỏ lại phía sau”, “Cả nước chung sức xây dựng nông thôn mới”, phong trào thi đua: “Đẩy mạnh phát triển kết cấu hạ tầng đồng bộ, hiện đại; thực hành tiết kiệm, chống lãng phí”, phong trào Ba không: “Không né tránh công việc, không đùn đẩy công việc sang người khác, không làm việc vì lợi ích và động cơ cá nhân”, phong trào vượt qua khó khăn, thách thức vươn lên hoàn thành tốt nhiệm vụ được giao của cá nhân, của cơ quan, đơn vị và của ngành....Mô hình được thực hiện bằng công trình, phần việc cụ thể. Các chi bộ đăng ký mô hình, xây dựng kế hoạch và có báo cáo kết quả thực hiện mô hình về Ban thường vụ Đảng ủy để theo dõi, đánh giá và biểu dương điển hình tiên tiến. Từng cán bộ, đảng viên, công chức xây dựng kế hoạch đăng ký công trình, phần việc cụ thể nội dung học tập và làm theo tư tưởng, đạo đức, phong cách của Bác đúng theo hướng dẫn, phù hợp với bản thân về chức năng, nhiệm vụ chuyên môn được giao, để có giải pháp học tập và làm theo. Qua việc học tập và làm theo Bác, nhận thức của đảng viên, công chức được nâng lên rõ rệt, nâng cao ý thức tự giác, có trách nhiệm hơn trong công việc; có tinh thần, thái độ phục vụ Nhân dân. Từ đó góp phần làm tốt công tác chính trị, tư tưởng đối với cán bộ, đảng viên, công chức, người lao động tại đơn vị; nâng cao tinh thần trách nhiệm, thống nhất nhận thức và hành động của từng cấp đơn vị và mỗi công chức, người lao động trong hệ thống thuế, nhất là đảng viên, công chức lãnh đạo để vừa hoàn thành tốt nhiệm vụ công tác sắp xếp, tinh gọn bộ máy theo chủ trương, chỉ đạo của Đảng, Nhà nước và Bộ Tài chính, vừa hoàn thành toàn diện các nhiệm vụ công tác được giao.\nBa là. Công tác sắp xếp, bố trí nhân sự căn cứ vào năng lực, phẩm chất và nhu cầu thực tế công việc đảm bảo công bằng, khách quan. Quán triệt, tuyên truyền công chức, người lao động về việc sau khi bộ máy mới đi vào hoạt động, dù trên cương vị nào cũng phải nỗ lực cao nhất, khắc phục mọi khó khăn, thách thức, bắt tay ngay vào công việc mới để hoàn thành tốt các nhiệm vụ được giao.\nBốn là. Phát huy vai trò các tổ chức đoàn thể quan tâm, lắng nghe, chia sẽ, nắm bắt tâm tư, nguyện vọng của công chức, người lao động từ đó kịp thời phản ánh và đề xuất các giải pháp giải quyết vấn đề phát sinh trong quá trình sắp xếp, đảm bảo quyền lợi chính đáng của công chức, người lao động. Đồng thời, kiên quyết đấu tranh đối với những biểu hiện tiêu cực, cản trở quá trình tinh gọn bộ máy, phản bác những luận điệu xuyên tạc, kích động, trái với chủ trương của Đảng và Nhà nước, gây mất đoàn kết trong cơ quan, đơn vị.\nNăm là. Đẩy nhanh tiến độ xử lý công việc đúng hạn rà soát xử lý dứt điểm các công việc, hồ sơ hành chính về thuế, kiến nghị, phản ánh vướng mắc của người nộp thuế. Trường hợp quá hạn không có lý do chính đáng, đúng pháp luật sẽ bị xem xét trách nhiệm theo quy định.\n* Tính mới của sáng kiến: Điểm mới của sáng kiến chính là công tác giáo dục chính trị, tư tưởng, đạo đức, lối sống đảng viên, công chức thông qua các kế hoạch học tập, từ chủ đề đến hình thức học tập, nội dung triển khai thực hiện được xây dựng phù hợp điều kiện, hoàn cảnh, tình hình đất nước. Các chủ đề học tập do Đảng ủy soạn thảo đảm bảo tính kịp thời và phù hợp với quan điểm chỉ đạo của Đảng, Nhà nước với chuyên môn nghiệp vụ của ngành theo từng thời điểm, từng giai đoạn nhất định. Từ đó, tạo được mối quan hệ chặt chẽ, thống nhất giữa “học tập, làm theo và nêu gương”, nhận thức và hành động, giữa học và hành, giữa lời nói và việc làm. Được Đảng ủy Cục Thuế (nay là Đảng ủy Thuế tỉnh) quán triệt nhận thức từ trong Đảng ủy đến các Chi bộ trực thuộc, tổ đảng; từ Cơ quan Thuế tỉnh đến các Chi cục Thuế, đội thuế (nay là các Thuế cơ sở, tổ). Từ đó nâng cao nhận thức cán bộ, đảng viên, công chức thông qua học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh trong tình hình hiện nay. Góp phần nâng cao năng lực lãnh đạo và sức chiến đấu trong Đảng bộ Thuế tỉnh, góp phần xây dựng Đảng bộ Thuế tỉnh trong sạch, vững mạnh. Các mô hình, công trình, phần việc được các Chi bộ thực hiện gắn với nhiệm vụ chuyên môn của ngành, với các phong trào thi đua yêu nước. Tạo sự liên kết chặt chẽ giữa Tổ chức Đảng, chính quyền, đoàn thể quần chúng trong toàn ngành Thuế của Tỉnh. Chỉ có “Nhận thức đúng thì Hành động đúng”, là một công chức ngành Thuế, bản thân nhận thức được trách nhiệm cũng như vị trí, vai trò của mình trong từng nhiệm vụ cụ thể thì đối với việc hoàn thành nhiệm vụ chính trị của ngành hay để giữ gìn kỷ luật, kỷ cương, nâng cao hiệu quả thực thi pháp luật trong thực hiện nhiệm vụ trên tinh thần “Chỉ tiêu một - Kế hoạch năm - Quyết tâm phải là mười” sẽ luôn đạt được kết quả cao nhất.\nc. Hiệu quả và phạm vi áp dụng của sáng kiến, giải pháp: Đến nay, hệ thống tổ chức mới đã đi vào hoạt động ổn định, quá trình triển khai diễn ra thông suốt, không bị gián đoạn. Mô hình mới tạo thuận lợi cho người nộp thuế trong thực hiện thủ tục hành chính, đồng thời đáp ứng yêu cầu ứng dụng công nghệ thông tin, chuyển đổi số và hiện đại hóa ngành Thuế. Bố trí nhân sự đảm bảo công bằng, khách quan. Quán triệt, tuyên truyền công chức, người lao động về việc trước, trong và sau khi bộ máy mới đi vào hoạt động, dù trên cương vị nào cũng phải nổ lực cao nhất, khắc phục mọi khó khăn, thách thức, bắt tay ngay vào công việc mới để hoàn thành tốt các nhiệm vụ được giao. Với mục tiêu xây dựng bộ máy cơ quan thuế hiện đại, tinh gọn, hoạt động hiệu lực, hiệu quả, có đủ quyền hạn và năng lực chủ động thực thi pháp luật Thuế, đồng thời để phát triển nguồn nhân lực chất lượng cao, chuyên sâu, chuyên nghiệp, liêm chính, đổi mới, đáp ứng yêu cầu quản lý Thuế trong bối cảnh nền kinh tế số, phù hợp với xu thuế hội nhập quốc tế. Rèn luyện đội ngũ công chức ngành Thuế của Tỉnh biết Chấp nhận thử thách - Vượt qua khó khăn - Cọ sát thực tiễn - Hoàn thành nhiệm vụ. Kết quả thu ngân sách 9 tháng đầu năm 2025, Thuế tỉnh Cà Mau đạt tỷ lệ 84% (8.400 tỷ đồng/10.053 tỷ đồng) là minh chứng tiêu biểu cho sự đồng lòng, quyết tâm chính trị của ngành Thuế tỉnh Cà Mau.\n- Đối tượng, đơn vị áp dụng: Toàn thể Công chức và người lao động thuộc Thuế tỉnh Cà Mau.\n- Phạm vi, khả năng nhân rộng: Thuế tỉnh Cà Mau và Bộ Tài chính\n5. Hội đồng cơ sở đã xét công nhận sáng kiến: Quyết định số 1109/QĐ-CMA ngày 23 tháng 10 năm 2025.\n6. Thời gian áp dụng: 01/10/2024./.', '<p>BÁO CÁO MÔ TẢ SÁNG KIẾN</p><p>1. Tên sáng kiến: Một số giải pháp chủ yếu nhằm làm tốt công tác tư tưởng trước, trong và sau khi sắp xếp tổ chức bộ máy ngành Thuế tỉnh theo Nghị quyết số 18-NQ/TW ngày 25/10/2017 của Ban Chấp hành Trung ương gắn với việc học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh. </p><p>2. Họ và tên nhóm tác giả sáng kiến, chức danh, trình độ chuyên môn:</p><p>3. Lĩnh vực áp dụng: Lĩnh vực khác, nâng cao chất lượng công tác chuyên môn nghiệp vụ</p><p>4. Mô tả sáng kiến</p><p>a. Khái quát đặc điểm, tình hình trước khi có sáng kiến:</p><p>* Đặc điểm tình hình trước khi có sáng kiến: Chủ tịch Hồ Chí Minh cho rằng, việc tinh giản bộ máy nhà nước luôn đi liền với vấn đề tiết kiệm chi phí, chống lãng phí, chống quan liêu, cửa quyền. Khi bàn về tinh giản bộ máy nhà nước, Người khẳng định: “Riêng cơ quan cung cấp tổ chức còn kềnh càng, thừa người, phải sắp xếp cho gọn gàng, hợp lý, mọi người đều có công việc thiết thực, những người thừa phải đưa đi chỗ thiếu, những người ở lại phải thi đua nâng cao năng suất của mình. Thế là tinh giản, tinh là năng suất lên cao, làm cho mau, cho tốt, giản là vừa phải, không kềnh càng, tránh hình thức”. Những nội dung, quan điểm, tư tưởng của Chủ tịch Hồ Chí Minh về tinh giản bộ máy nhà nước vẫn còn nguyên về mặt giá trị lý luận và thực tiễn; tiếp tục trở thành nền tảng tư tưởng và kim chỉ nam cho Đảng, Nhà nước kế thừa, phát huy, vận dụng và phát triển một cách sáng tạo trong xây dựng Nhà nước pháp quyền xã hội chủ nghĩa Việt Nam trong giai đoạn hiện nay. Việc sắp xếp tố chức bộ máy ngành Thuế theo Nghị quyết số 18-NQ/TW ngày 25/10/2017 của Ban Chấp hành Trung ương gắn với việc học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh thông qua việc xây dựng bộ máy hành chính nhà nước, trong đó có ngành Thuế, tinh gọn, hiệu lực, hiệu quả. Điều này đòi hỏi các đơn vị thuộc ngành Thuế phải tăng cường quản lý nội ngành, kỷ luật, kỷ cương, nhằm hoàn thành tốt nhiệm vụ thu ngân sách nhà nước, phục vụ người dân và doanh nghiệp tốt hơn, thể hiện rõ nét tinh thần trách nhiệm và “Vì nhân dân phục vụ” mà Chủ tịch Hồ Chí Minh đã dạy.</p><p>* Sự cần thiết, mục đích của việc thực hiện sáng kiến:</p><p>Sinh thời, Chủ tịch Hồ Chí Minh rất quan tâm đến công tác tư tưởng. Người cho rằng: “Trong đảng và ngoài đảng có nhận rõ tình hình mới, hiểu rõ nhiệm vụ mới thì tư tưởng mới thống nhất, tư tưởng thống nhất thì hành động mới thống nhất”. Công tác tư tưởng tự bản thân nó đã hàm chứa những vấn đề nhạy cảm, phức tạp, đa chiều liên quan đến tâm tư, nguyện vọng của đảng viên, công chức.</p><p>Hiện nay, việc sắp xếp, tinh gọn bộ máy đã và đang được triển khai quyết liệt ở các cấp, các ngành từ Trung ương đến địa phương, với mục tiêu xây dựng một hệ thống chính trị, gọn nhẹ, minh bạch, vững mạnh, hoạt động hiệu lực, hiệu quả. Lợi dụng vấn đề, các thế lực thù địch tăng cường tung tin, vu khống, xuyên tạc, chống phá Đảng và Nhà nước ta. Vì lẽ đó, đội ngũ cán bộ, đảng viên, công chức cần thống nhất trong nhận thức và hành động, tỉnh táo trước những luận điệu xuyên tác, lực lượng thù địch. Thực hiện Nghị quyết số 18-NQ/TW của Ban Chấp hành Trung ương khóa XII về một số vấn đề tiếp tục đổi mới, sắp xếp tổ chức bộ máy của hệ thống chính trị tinh gọn, hoạt động hiệu lực, hiệu quả; Kết luận số 09-KL/BCĐ ngày 24/11/2024 của Ban Chỉ đạo Trung ương về việc tiếp tục đẩy mạnh việc sắp xếp, tinh gọn bộ máy; Chỉ thị số 03/CT-BTC ngày 03/12/2024 của Bộ trưởng Bộ Tài chính về công tác đổi mới, sắp xếp tổ chức bộ máy Bộ Tài chính. Theo đó, trong thời gian qua, ngành Thuế đã quyết liệt, chủ động trong xây dựng và hoàn thiện phương án sắp xếp, tinh gọn tổ chức, bộ máy cơ quan thuế các cấp theo đúng chủ trương, định hướng của Đảng, Nhà nước và của Bộ Tài chính. Bên cạnh việc tinh gọn bộ máy giúp cơ quan thuế nâng cao hiệu năng, hiệu lực, hiệu quả hoạt động, thì quá trình sắp xếp cơ cấu tổ chức cũng sẽ phát sinh những vấn đề nhạy cảm, phức tạp như: cắt giảm biên chế, sắp xếp lại đội ngũ, dôi dư cấp lãnh đạo, khoảng cách địa lý, môi trường làm việc thay đổi,...ảnh hưởng trực tiếp đến tâm lý và quyền lợi của công chức, người lao động, đòi hỏi phải có sự thống nhất cao về nhận thức và hành động, quyết tâm chính trị mạnh mẽ. Đặc biệt, Cục Thuế tỉnh Bạc Liêu thuộc địa bàn tỉnh Bạc Liêu (trước sắp xếp) là đơn vị chịu sự tác động trực tiếp khi sắp xếp chính quyền địa phương 02 cấp. Sự đổi mới này không tránh khỏi những khó khăn, thách thức. Mỗi quyết định đưa ra đều là kết quả của những trăn trở, cân nhắc kỹ lưỡng để hài hòa giữa lợi ích chung và nguyện vọng chính đáng của từng công chức. Xuất phát từ tình hình trên, nhóm chúng tôi đã đưa ra “Một số giải pháp chủ yếu nhằm làm tốt công tác tư tưởng trước, trong và sau khi sắp xếp tổ chức bộ máy ngành Thuế tỉnh theo Nghị quyết số 18-NQ/TW ngày 25/10/2017 của Ban Chấp hành Trung ương gắn với việc học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh”.</p><p>b. Nội dung sáng kiến:</p><p>Trước ngày 01/3/2025, Cục Thuế tỉnh Cà Mau và Cục Thuế tỉnh Bạc Liêu gồm có: 22 phòng, 08 Chi cục Thuế thành phố, khu vực, 47 đội thuế, có tổng số 756 công chức và người lao động, trong đó: Biên chế: 681 công chức, 75 hợp đồng.  Ngành Thuế đã thực hiện hai lần sắp xếp bộ máy. Lần thứ nhất từ ngày 01/3/2025 theo Quyết định 381/QĐ-BTC của Bộ Tài chính. Tiếp đó, thực hiện Nghị quyết 60-NQ/TW ngày 12/4/2025 của Ban Chấp hành Trung ương Đảng về mô hình chính quyền địa phương 2 cấp, Bộ Tài chính ban hành Quyết định 2229/QĐ-BTC (có hiệu lực từ 1/7/2025). Theo đó, sắp xếp Thuế tỉnh Cà Mau gồm có 9 phòng và 8 đơn vị Thuế cơ sở, 35 tổ, có tổng số 529 công chức và người lao động, trong đó: Biên chế: 472 công chức và 57 người lao động. Như vậy ngành Thuế đã đồng bộ với mô hình chính quyền địa phương 2 cấp, đã cắt giảm mạnh từ hơn 77 đầu mối xuống còn hơn 52 đầu mối. Bằng việc chuyển đổi từ mô hình “quản lý thuế theo chức năng, kết hợp với đối tượng” sang mô hình “quản lý theo đối tượng, kết hợp với chức năng” là bước ngoặt mang tính chiến lược. Mỗi công chức thuế giờ đây không chỉ thực hiện chuyên môn đơn lẻ mà còn là người đồng hành, hỗ trợ toàn diện cho người nộp thuế. Điều này không chỉ đòi hỏi năng lực chuyên môn cao mà còn là sự tận tâm, trách nhiệm và sẵn sàng thích nghi với sự thay đổi. Bên cạnh đó, ngày 14/02/2025, Tổng Cục Thuế có Công văn số 640/TCT-TCCB yêu cầu toàn ngành Thuế quán triệt thực hiện tốt công tác chính trị, tư tưởng, công tác chuyên môn khi sắp xếp, tinh gọn bộ máy. Qua đó, nhóm rút ra một số giải pháp chủ yếu nhằm làm tốt công tác tư tưởng trước, trong và sau khi sắp xếp tổ chức bộ máy ngành Thuế tỉnh theo Nghị quyết số 18-NQ/TW ngày 25/10/2017 của Ban Chấp hành Trung ương như sau:</p><p>Một là. Tăng cường kỷ luật, kỷ cương nội ngành: Ngành Thuế tỉnh tăng cường tái cấu trúc bộ máy, thực hiện siết chặt kỷ luật, kỷ cương trong thực thi công vụ và trong công tác quản lý thuế, đảm bảo hoàn thành xuất sắc các nhiệm vụ được giao. Xác định rõ việc sắp xếp, tinh gọn bộ máy là nhiệm vụ đặc biệt quan trọng, là đòi hỏi tất yếu nhằm nâng cao hiệu năng, hiệu lực, hiệu quả hoạt động của bộ máy vì sự phát triển bền vững của đất nước trong kỷ nguyên mới; tạo sự đồng thuận, thống nhất trong đội ngũ công chức, người lao động khi thực hiện việc sắp xếp, tinh gọn bộ máy.</p><p>Hai là, Xác định tầm quan trọng trong công tác giáo dục chính trị, tư tưởng có ý nghĩa quyết định đến việc xây dựng Đảng vững mạnh về chính trị, tư tưởng, đạo đức, tổ chức và cán bộ, làm cơ sở để nâng cao năng lực lãnh đạo, năng lực cầm quyền, sức chiến đấu của Đảng và hiệu lực hiệu quả quản lý Nhà nước. Đảng ủy thường xuyên chỉ đạo cấp ủy trực thuộc nâng cao chất lượng công tác tuyên truyền, giáo dục, học tập, quán triệt chủ nghĩa Mác-Lênin, tư tưởng Hồ Chí Minh cho cán bộ, đảng viên, công chức. Ngoài ra còn tổ chức các cuộc hội nghị để kịp thời thông tin thời sự về tình hình quốc tế, trong nước và trong tỉnh cho toàn thể cán bộ, đảng viên, công chức trong cơ quan theo chỉ đạo của Ban Thường vụ Tỉnh ủy, Ban Thường vụ Đảng ủy Khối...</p><p>Đặc biệt Đảng ủy Cục Thuế đẩy mạnh việc học tập và làm theo tư tưởng, đạo đức phong cách Hồ Chí Minh theo Kết luận số 21-KL/TW của Bộ Chính trị về tiếp tục thực hiện Chỉ thị số 05-CT/TW, ngày 15/5/2016 của Bộ Chính trị về “Đẩy mạnh học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh”. Để tăng cường sự đoàn kết thống nhất ở cấp ủy và các chi bộ trực thuộc Đảng bộ, từ Cục Thuế đến các Chi cục Thuế trực thuộc, tạo nên sự thống nhất từ tư tưởng đến hành động của mỗi đảng viên, công chức. Hàng năm căn cứ vào văn bản hướng dẫn của Đảng ủy Khối. Đảng ủy Cục Thuế đã xây dựng và ban hành Kế hoạch học tập, đề ra phương hướng, nhiệm vụ, các giải pháp để thực hiện nhằm đảm bảo tính kịp thời và phù hợp với định hướng chỉ đạo của cấp trên. Nội dung triển khai thực hiện việc học tập và làm theo Bác trên tinh thần sáng tạo và phù hợp với điều kiện, hoàn cảnh, thực tế của đơn vị theo từng giai đoạn nhất định. Đảng ủy Cục Thuế đề nghị mỗi một chi bộ xây dựng mô hình học tập Bác, gắn với nhiệm vụ chuyên môn của ngành, với phong trào thi đua: “Vì người nghèo - Không để ai bị bỏ lại phía sau”, “Cả nước chung sức xây dựng nông thôn mới”, phong trào thi đua: “Đẩy mạnh phát triển kết cấu hạ tầng đồng bộ, hiện đại; thực hành tiết kiệm, chống lãng phí”, phong trào Ba không: “Không né tránh công việc, không đùn đẩy công việc sang người khác, không làm việc vì lợi ích và động cơ cá nhân”, phong trào vượt qua khó khăn, thách thức vươn lên hoàn thành tốt nhiệm vụ được giao của cá nhân, của cơ quan, đơn vị và của ngành....Mô hình được thực hiện bằng công trình, phần việc cụ thể. Các chi bộ đăng ký mô hình, xây dựng kế hoạch và có báo cáo kết quả thực hiện mô hình về Ban thường vụ Đảng ủy để theo dõi, đánh giá và biểu dương điển hình tiên tiến. Từng cán bộ, đảng viên, công chức xây dựng kế hoạch đăng ký công trình, phần việc cụ thể nội dung học tập và làm theo tư tưởng, đạo đức, phong cách của Bác đúng theo hướng dẫn, phù hợp với bản thân về chức năng, nhiệm vụ chuyên môn được giao, để có giải pháp học tập và làm theo. Qua việc học tập và làm theo Bác, nhận thức của đảng viên, công chức được nâng lên rõ rệt, nâng cao ý thức tự giác, có trách nhiệm hơn trong công việc; có tinh thần, thái độ phục vụ Nhân dân. Từ đó góp phần làm tốt công tác chính trị, tư tưởng đối với cán bộ, đảng viên, công chức, người lao động tại đơn vị; nâng cao tinh thần trách nhiệm, thống nhất nhận thức và hành động của từng cấp đơn vị và mỗi công chức, người lao động trong hệ thống thuế, nhất là đảng viên, công chức lãnh đạo để vừa hoàn thành tốt nhiệm vụ công tác sắp xếp, tinh gọn bộ máy theo chủ trương, chỉ đạo của Đảng, Nhà nước và Bộ Tài chính, vừa hoàn thành toàn diện các nhiệm vụ công tác được giao.</p><p>Ba là. Công tác sắp xếp, bố trí nhân sự căn cứ vào năng lực, phẩm chất và nhu cầu thực tế công việc đảm bảo công bằng, khách quan. Quán triệt, tuyên truyền công chức, người lao động về việc sau khi bộ máy mới đi vào hoạt động, dù trên cương vị nào cũng phải nỗ lực cao nhất, khắc phục mọi khó khăn, thách thức, bắt tay ngay vào công việc mới để hoàn thành tốt các nhiệm vụ được giao.</p><p>Bốn là. Phát huy vai trò các tổ chức đoàn thể quan tâm, lắng nghe, chia sẽ, nắm bắt tâm tư, nguyện vọng của công chức, người lao động từ đó kịp thời phản ánh và đề xuất các giải pháp giải quyết vấn đề phát sinh trong quá trình sắp xếp, đảm bảo quyền lợi chính đáng của công chức, người lao động. Đồng thời, kiên quyết đấu tranh đối với những biểu hiện tiêu cực, cản trở quá trình tinh gọn bộ máy, phản bác những luận điệu xuyên tạc, kích động, trái với chủ trương của Đảng và Nhà nước, gây mất đoàn kết trong cơ quan, đơn vị.</p><p>Năm là. Đẩy nhanh tiến độ xử lý công việc đúng hạn rà soát xử lý dứt điểm các công việc, hồ sơ hành chính về thuế, kiến nghị, phản ánh vướng mắc của người nộp thuế. Trường hợp quá hạn không có lý do chính đáng, đúng pháp luật sẽ bị xem xét trách nhiệm theo quy định.</p><p>* Tính mới của sáng kiến: Điểm mới của sáng kiến chính là công tác giáo dục chính trị, tư tưởng, đạo đức, lối sống đảng viên, công chức thông qua các kế hoạch học tập, từ chủ đề đến hình thức học tập, nội dung triển khai thực hiện được xây dựng phù hợp điều kiện, hoàn cảnh, tình hình đất nước. Các chủ đề học tập do Đảng ủy soạn thảo đảm bảo tính kịp thời và phù hợp với quan điểm chỉ đạo của Đảng, Nhà nước với chuyên môn nghiệp vụ của ngành theo từng thời điểm, từng giai đoạn nhất định. Từ đó, tạo được mối quan hệ chặt chẽ, thống nhất giữa “học tập, làm theo và nêu gương”, nhận thức và hành động, giữa học và hành, giữa lời nói và việc làm. Được Đảng ủy Cục Thuế (nay là Đảng ủy Thuế tỉnh) quán triệt nhận thức từ trong Đảng ủy đến các Chi bộ trực thuộc, tổ đảng; từ Cơ quan Thuế tỉnh đến các Chi cục Thuế, đội thuế (nay là các Thuế cơ sở, tổ). Từ đó nâng cao nhận thức cán bộ, đảng viên, công chức thông qua học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh trong tình hình hiện nay. Góp phần nâng cao năng lực lãnh đạo và sức chiến đấu trong Đảng bộ Thuế tỉnh, góp phần xây dựng Đảng bộ Thuế tỉnh trong sạch, vững mạnh. Các mô hình, công trình, phần việc được các Chi bộ thực hiện gắn với nhiệm vụ chuyên môn của ngành, với các phong trào thi đua yêu nước. Tạo sự liên kết chặt chẽ giữa Tổ chức Đảng, chính quyền, đoàn thể quần chúng trong toàn ngành Thuế của Tỉnh. Chỉ có “Nhận thức đúng thì Hành động đúng”, là một công chức ngành Thuế, bản thân nhận thức được trách nhiệm cũng như vị trí, vai trò của mình trong từng nhiệm vụ cụ thể thì đối với việc hoàn thành nhiệm vụ chính trị của ngành hay để giữ gìn kỷ luật, kỷ cương, nâng cao hiệu quả thực thi pháp luật trong thực hiện nhiệm vụ trên tinh thần “Chỉ tiêu một - Kế hoạch năm - Quyết tâm phải là mười” sẽ luôn đạt được kết quả cao nhất.</p><p>c. Hiệu quả và phạm vi áp dụng của sáng kiến, giải pháp: Đến nay, hệ thống tổ chức mới đã đi vào hoạt động ổn định, quá trình triển khai diễn ra thông suốt, không bị gián đoạn. Mô hình mới tạo thuận lợi cho người nộp thuế trong thực hiện thủ tục hành chính, đồng thời đáp ứng yêu cầu ứng dụng công nghệ thông tin, chuyển đổi số và hiện đại hóa ngành Thuế. Bố trí nhân sự đảm bảo công bằng, khách quan. Quán triệt, tuyên truyền công chức, người lao động về việc trước, trong và sau khi bộ máy mới đi vào hoạt động, dù trên cương vị nào cũng phải nổ lực cao nhất, khắc phục mọi khó khăn, thách thức, bắt tay ngay vào công việc mới để hoàn thành tốt các nhiệm vụ được giao. Với mục tiêu xây dựng bộ máy cơ quan thuế hiện đại, tinh gọn, hoạt động hiệu lực, hiệu quả, có đủ quyền hạn và năng lực chủ động thực thi pháp luật Thuế, đồng thời để phát triển nguồn nhân lực chất lượng cao, chuyên sâu, chuyên nghiệp, liêm chính, đổi mới, đáp ứng yêu cầu quản lý Thuế trong bối cảnh nền kinh tế số, phù hợp với xu thuế hội nhập quốc tế. Rèn luyện đội ngũ công chức ngành Thuế của Tỉnh biết Chấp nhận thử thách -  Vượt qua khó khăn - Cọ sát thực tiễn - Hoàn thành nhiệm vụ. Kết quả thu ngân sách 9 tháng đầu năm 2025, Thuế tỉnh Cà Mau đạt tỷ lệ 84% (8.400 tỷ đồng/10.053 tỷ đồng) là minh chứng tiêu biểu cho sự đồng lòng, quyết tâm chính trị của ngành Thuế tỉnh Cà Mau.</p><p>- Đối tượng, đơn vị áp dụng: Toàn thể Công chức và người lao động thuộc Thuế tỉnh Cà Mau.</p><p>- Phạm vi, khả năng nhân rộng: Thuế tỉnh Cà Mau và Bộ Tài chính</p><p>5. Hội đồng cơ sở đã xét công nhận sáng kiến: Quyết định số 1109/QĐ-CMA ngày 23 tháng 10 năm 2025.</p><p>6. Thời gian áp dụng: 01/10/2024./.</p>', '231ff6d92192d68d6dd2cb888f7f6354b920e735a24251ca373c051232b30553', '2026-09-22 19:43:09'),
(15, 31, 38, 'BÁO CÁO MÔ TẢ SÁNG KIẾN\n1. Tên sáng kiến: Giải pháp nâng cao chất lượng công tác đào tạo, bồi dưỡng công chức ngành Thuế.\n2. Họ và tên tác giả sáng kiến, chức danh, trình độ chuyên môn:\n3. Lĩnh vực áp dụng: Lĩnh vực Tổ chức, nhân sự\n4. Mô tả sáng kiến\na) Khái quát đặc điểm, tình hình trước khi có sáng kiến\nTrong những năm qua, ngành Thuế đã có nhiều nỗ lực trong công tác đào tạo và bồi dưỡng công chức, giúp đội ngũ ngày càng có chất lượng và trình độ cao hơn. Tuy nhiên, việc phân bổ nhân lực còn chưa hợp lý, năng lực thực tiễn của một bộ phận công chức chưa đáp ứng yêu cầu phát triển và hiện đại hóa ngành trong bối cảnh chuyển đổi số.\nĐội ngũ công chức Thuế đóng vai trò nòng cốt trong việc triển khai, tuyên truyền và thực hiện chính sách pháp luật thuế, do đó cần được trang bị đầy đủ kiến thức, kỹ năng chuyên môn và nghiệp vụ quản lý thuế. Việc bồi dưỡng, nâng cao năng lực cho công chức là hết sức cần thiết để đáp ứng yêu cầu cải cách, hiện đại hóa, đồng thời tạo động lực đổi mới, phát huy năng lực và hoàn thành tốt nhiệm vụ được giao.\nTừ thực tiễn đó, nhóm tác giả đề xuất sáng kiến “Giải pháp nâng cao chất lượng công tác đào tạo, bồi dưỡng công chức ngành Thuế”, với mục tiêu khắc phục hạn chế trong đào tạo hiện nay, đổi mới nội dung và phương thức bồi dưỡng theo hướng thực tiễn, thiết thực, gắn với yêu cầu công vụ và nâng cao kỹ năng hành chính cho đội ngũ công chức Thuế\nb) Nội dung sáng kiến\nThực tế kết quả triển khai thực hiện công tác đào tạo, bồi dưỡng thời gian qua đạt được khá cao, song vẫn còn số lượng lớn công chức vẫn chưa được đào tạo, bồi dưỡng những kiến thức từ cơ bản tới chuyên sâu về nghiệp vụ chuyên môn của 04 chức năng quản lý thuế gồm: Công tác Thanh tra, kiểm tra thuế; công tác Kê khai và kế toán thuế; công tác Tuyên truyền, hỗ trợ người nộp thuế; công tác Quản lý nợ và cưỡng chế nợ thuế. Ở một số đơn vị, tỷ lệ cán bộ, công chức được đào tạo, bồi dưỡng trong năm còn thấp. Số lượng công chức được đào tạo chuyên sâu và theo chức danh vị trí việc làm còn ít so với yêu cầu.\nĐể nhằm khắc phục những hạn chế Nhóm nghiên cứu đưa ra gồm 03 giải pháp chủ yếu nhằm đổi mới công tác đào tạo, bồi dưỡng công chức trong ngành Thuế tỉnh Cà Mau, qua thực hiện đã mang lại hiệu quả tốt, được mô tả tóm tắt như sau:\nGiải pháp 1: Xác định đối tượng và kiến thức đào tạo, bồi dưỡng cho từng công chức Thuế\n- Xác định đúng đối tượng gồm công chức, lãnh đạo, cán bộ quy hoạch lãnh đạo và công chức cần nâng cao kỹ năng nghiệp vụ.\n- Xác định nội dung đào tạo phù hợp cho từng vị trí, chú trọng các kỹ năng chuyên sâu về nghiệp vụ quản lý thuế, công nghệ hiện đại, xử lý tình huống thực tế. Mục tiêu là giúp công chức nắm vững và áp dụng hiệu quả kiến thức vào công việc.\nGiải pháp 2: Xác định mục tiêu công tác đào tạo, bồi dưỡng\n- Xây dựng đội ngũ công chức có bản lĩnh chính trị, trình độ chuyên môn và kỹ năng nghiệp vụ vững vàng, đáp ứng yêu cầu cải cách và hiện đại hóa ngành Thuế.\n- Hướng đến phát triển đa kỹ năng, tăng cường năng lực làm việc, tự giác học tập, nghiên cứu và sẵn sàng đảm nhận nhiệm vụ mới.\nGiải pháp 3: Đổi mới nội dung, chương trình và hình thức đào tạo\n- Về nội dung, chương trình: Đào tạo sát thực tế, thiết thực và đa dạng, bao gồm lý luận chính trị, quản lý nhà nước, kỹ năng lãnh đạo, nghiệp vụ chuyên sâu theo từng bộ phận thuế. Chú trọng tính thực tiễn, tránh lý thuyết suông.\n- Về hình thức: Kết hợp giữa đào tạo trực tiếp và trực tuyến.\n+ Đào tạo trực tiếp: tăng tính tương tác, hiệu quả trao đổi, nhưng chi phí cao và hạn chế về thời gian, địa điểm.\n+ Đào tạo trực tuyến: tiết kiệm chi phí, linh hoạt thời gian, mở rộng đối tượng học, nhưng hạn chế về tương tác và phụ thuộc vào hạ tầng công nghệ.\n- Cần linh hoạt kết hợp hai hình thức để phát huy ưu điểm, nâng cao chất lượng và hiệu quả đào tạo\n* Tính mới của sáng kiến:\n- Đưa ra những giải pháp để cụ thể hóa các mục tiêu, nội dung, chương trình đào tạo, bồi dưỡng công chức hàng năm hướng đến đào tạo những kỹ năng, kiến thức cần thiết giúp ích cho công việc hàng ngày của công chức, tránh đào tạo, bồi dưỡng một cách tràn lan, không đúng đối tượng, không đúng nội dung gây lãng phí thời gian, công sức, kinh phí nhưng hiệu quả thấp.\n- Đảm bảo các hoạt động triển khai về công tác đào tạo, bồi dưỡng đúng đối tượng để giải quyết các khó khăn, vướng mắc đang gặp phải và phục vụ cho các công tác khác trong ngành.\n- Góp phần đổi mới công tác đào tạo, bồi dưỡng để từng bước nâng cao chất lượng nguồn nhân lực của Thuế tỉnh; góp phần xây dựng ngành Thuế ngày càng trong sạch, vững mạnh, đáp ứng yêu cầu hiện đại hóa ngành Thuế theo chỉ đạo của Bộ Tài chính.\nc) Hiệu quả và phạm vi áp dụng của sáng kiến, giải pháp\nQua áp dụng sáng kiến, hiệu quả thu được là công tác đào tạo, bồi dưỡng của ngành Thuế tỉnh đã có những bước tiến rõ rệt, đã đi sâu vào đào tạo, bồi dưỡng các kỹ năng thực thi công việc của công chức, song song đó đã bồi dưỡng các kiến thức chuyên môn nghiệp vụ từ cơ bản đến chuyên sâu của 04 chức năng quản lý thuế và theo chức danh vị trí việc làm.\nQua đó, Tiết kiệm được chi phí tiết kiệm về mặt thời gian công sức và giành thời gian cho việc thực hiện nhiệm vụ được giao. Số lượng công chức làm việc tại các bộ phận chức năng quản lý thuế và bộ phận thường xuyên trực tiếp với người nộp thuế về nghiệp vụ, chính sách thuế, thủ tục hành chính thuế được cử tham gia đào tạo, tập huấn và bồi dưỡng đã được tăng lên đáng kể. Trang bị, bổ sung, nâng cao kiến thức, kỹ năng liên quan đến công việc; giúp công chức luôn phát triển để có thể đáp ứng dược nhu cầu về trình độ, nhu cầu nhân lực trong tương lai.\n- Đối tượng, đơn vị áp dụng: Toàn thể công chức và người lao động thuộc Thuế tỉnh Cà Mau.\n- Phạm vi, khả năng nhân rộng: Thuế tỉnh Cà Mau.\n5. Hội đồng cơ sở đã xét công nhận sáng kiến: Quyết định số 1109/QĐ-CMA ngày 23 tháng 10 năm 2025.\n6. Thời gian áp dụng: 01/10/2024.', '<p>BÁO CÁO MÔ TẢ SÁNG KIẾN</p><p>1. Tên sáng kiến: Giải pháp nâng cao chất lượng công tác đào tạo, bồi dưỡng công chức ngành Thuế.</p><p>2. Họ và tên tác giả sáng kiến, chức danh, trình độ chuyên môn:</p><p>3. Lĩnh vực áp dụng: Lĩnh vực Tổ chức, nhân sự</p><p>4. Mô tả sáng kiến</p><p>a) Khái quát đặc điểm, tình hình trước khi có sáng kiến</p><p>Trong những năm qua, ngành Thuế đã có nhiều nỗ lực trong công tác đào tạo và bồi dưỡng công chức, giúp đội ngũ ngày càng có chất lượng và trình độ cao hơn. Tuy nhiên, việc phân bổ nhân lực còn chưa hợp lý, năng lực thực tiễn của một bộ phận công chức chưa đáp ứng yêu cầu phát triển và hiện đại hóa ngành trong bối cảnh chuyển đổi số.</p><p>Đội ngũ công chức Thuế đóng vai trò nòng cốt trong việc triển khai, tuyên truyền và thực hiện chính sách pháp luật thuế, do đó cần được trang bị đầy đủ kiến thức, kỹ năng chuyên môn và nghiệp vụ quản lý thuế. Việc bồi dưỡng, nâng cao năng lực cho công chức là hết sức cần thiết để đáp ứng yêu cầu cải cách, hiện đại hóa, đồng thời tạo động lực đổi mới, phát huy năng lực và hoàn thành tốt nhiệm vụ được giao.</p><p>Từ thực tiễn đó, nhóm tác giả đề xuất sáng kiến “Giải pháp nâng cao chất lượng công tác đào tạo, bồi dưỡng công chức ngành Thuế”, với mục tiêu khắc phục hạn chế trong đào tạo hiện nay, đổi mới nội dung và phương thức bồi dưỡng theo hướng thực tiễn, thiết thực, gắn với yêu cầu công vụ và nâng cao kỹ năng hành chính cho đội ngũ công chức Thuế</p><p>b) Nội dung sáng kiến</p><p>Thực tế kết quả triển khai thực hiện công tác đào tạo, bồi dưỡng thời gian qua đạt được khá cao, song vẫn còn số lượng lớn công chức vẫn chưa được đào tạo, bồi dưỡng những kiến thức từ cơ bản tới chuyên sâu về nghiệp vụ chuyên môn của 04 chức năng quản lý thuế gồm: Công tác Thanh tra, kiểm tra thuế; công tác Kê khai và kế toán thuế; công tác Tuyên truyền, hỗ trợ người nộp thuế; công tác Quản lý nợ và cưỡng chế nợ thuế. Ở một số đơn vị, tỷ lệ cán bộ, công chức được đào tạo, bồi dưỡng trong năm còn thấp. Số lượng công chức được đào tạo chuyên sâu và theo chức danh vị trí việc làm còn ít so với yêu cầu.</p><p>Để nhằm khắc phục những hạn chế Nhóm nghiên cứu đưa ra gồm 03 giải pháp chủ yếu nhằm đổi mới công tác đào tạo, bồi dưỡng công chức trong ngành Thuế tỉnh Cà Mau, qua thực hiện đã mang lại hiệu quả tốt, được mô tả tóm tắt như sau:</p><p>Giải pháp 1: Xác định đối tượng và kiến thức đào tạo, bồi dưỡng cho từng công chức Thuế</p><p>- Xác định đúng đối tượng gồm công chức, lãnh đạo, cán bộ quy hoạch lãnh đạo và công chức cần nâng cao kỹ năng nghiệp vụ.</p><p>- Xác định nội dung đào tạo phù hợp cho từng vị trí, chú trọng các kỹ năng chuyên sâu về nghiệp vụ quản lý thuế, công nghệ hiện đại, xử lý tình huống thực tế. Mục tiêu là giúp công chức nắm vững và áp dụng hiệu quả kiến thức vào công việc.</p><p>Giải pháp 2: Xác định mục tiêu công tác đào tạo, bồi dưỡng</p><p>- Xây dựng đội ngũ công chức có bản lĩnh chính trị, trình độ chuyên môn và kỹ năng nghiệp vụ vững vàng, đáp ứng yêu cầu cải cách và hiện đại hóa ngành Thuế.</p><p>- Hướng đến phát triển đa kỹ năng, tăng cường năng lực làm việc, tự giác học tập, nghiên cứu và sẵn sàng đảm nhận nhiệm vụ mới.</p><p>Giải pháp 3: Đổi mới nội dung, chương trình và hình thức đào tạo</p><p>- Về nội dung, chương trình: Đào tạo sát thực tế, thiết thực và đa dạng, bao gồm lý luận chính trị, quản lý nhà nước, kỹ năng lãnh đạo, nghiệp vụ chuyên sâu theo từng bộ phận thuế. Chú trọng tính thực tiễn, tránh lý thuyết suông.</p><p>- Về hình thức: Kết hợp giữa đào tạo trực tiếp và trực tuyến.</p><p>+ Đào tạo trực tiếp: tăng tính tương tác, hiệu quả trao đổi, nhưng chi phí cao và hạn chế về thời gian, địa điểm.</p><p>+ Đào tạo trực tuyến: tiết kiệm chi phí, linh hoạt thời gian, mở rộng đối tượng học, nhưng hạn chế về tương tác và phụ thuộc vào hạ tầng công nghệ.</p><p>- Cần linh hoạt kết hợp hai hình thức để phát huy ưu điểm, nâng cao chất lượng và hiệu quả đào tạo</p><p>* Tính mới của sáng kiến:</p><p>- Đưa ra những giải pháp để cụ thể hóa các mục tiêu, nội dung, chương trình đào tạo, bồi dưỡng công chức hàng năm hướng đến đào tạo những kỹ năng, kiến thức cần thiết giúp ích cho công việc hàng ngày của công chức, tránh đào tạo, bồi dưỡng một cách tràn lan, không đúng đối tượng, không đúng nội dung gây lãng phí thời gian, công sức, kinh phí nhưng hiệu quả thấp.</p><p>- Đảm bảo các hoạt động triển khai về công tác đào tạo, bồi dưỡng đúng đối tượng để giải quyết các khó khăn, vướng mắc đang gặp phải và phục vụ cho các công tác khác trong ngành.</p><p>- Góp phần đổi mới công tác đào tạo, bồi dưỡng để từng bước nâng cao chất lượng nguồn nhân lực của Thuế tỉnh; góp phần xây dựng ngành Thuế ngày càng trong sạch, vững mạnh, đáp ứng yêu cầu hiện đại hóa ngành Thuế theo chỉ đạo của Bộ Tài chính.</p><p>c) Hiệu quả và phạm vi áp dụng của sáng kiến, giải pháp</p><p>Qua áp dụng sáng kiến, hiệu quả thu được là công tác đào tạo, bồi dưỡng của ngành Thuế tỉnh đã có những bước tiến rõ rệt, đã đi sâu vào đào tạo, bồi dưỡng các kỹ năng thực thi công việc của công chức, song song đó đã bồi dưỡng các kiến thức chuyên môn nghiệp vụ từ cơ bản đến chuyên sâu của 04 chức năng quản lý thuế và theo chức danh vị trí việc làm.</p><p>Qua đó, Tiết kiệm được chi phí tiết kiệm về mặt thời gian công sức và giành thời gian cho việc thực hiện nhiệm vụ được giao. Số lượng công chức làm việc tại các bộ phận chức năng quản lý thuế và bộ phận thường xuyên trực tiếp với người nộp thuế về nghiệp vụ, chính sách thuế, thủ tục hành chính thuế được cử tham gia đào tạo, tập huấn và bồi dưỡng đã được tăng lên đáng kể. Trang bị, bổ sung, nâng cao kiến thức, kỹ năng liên quan đến công việc; giúp công chức luôn phát triển để có thể đáp ứng dược nhu cầu về trình độ, nhu cầu nhân lực trong tương lai.</p><p>-  Đối tượng, đơn vị áp dụng: Toàn thể công chức và người lao động thuộc Thuế tỉnh Cà Mau.</p><p>- Phạm vi, khả năng nhân rộng: Thuế tỉnh Cà Mau.</p><p>5. Hội đồng cơ sở đã xét công nhận sáng kiến: Quyết định số 1109/QĐ-CMA ngày 23 tháng 10 năm 2025.</p><p>6. Thời gian áp dụng: 01/10/2024.</p>', '0458436fb3967311002b5509043e57d57c821e61163e37b6a8c10863c8349600', '2026-09-22 19:49:47');
INSERT INTO `qlsk_file_noi_dung` (`id`, `file_id`, `sang_kien_id`, `noi_dung`, `noi_dung_html`, `hash_noi_dung`, `ngay_trich_xuat`) VALUES
(16, 32, 39, 'THUẾ TỈNH CÀ MAU CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM\nTHUẾ CƠ SỞ 7 TỈNH CÀ MAU Độc lập - Tự do - Hạnh phúc\nBÁO CÁO MÔ TẢ SÁNG KIẾN\n1. Tên sáng kiến: Những giải pháp chủ yếu tăng cường kỷ luật lao động và văn hóa công sở tại Thuế cơ sở\n2. Nhóm tác giải:\n3. Lĩnh vực áp dụng: Tổ chức, nhân sự; Vấn đề sáng kiến giải quyết: tăng cường kỷ luật lao động và văn hóa công sở tại Thuế cơ sở.\n4. Mô tả sáng kiến:\na. Khái quát đặc điểm, tình hình trước khi có sáng kiến:\nThời gian qua ngành Thuế đã tập trung triển khai mô hình tổ chức mới theo hướng tinh gọn, hiệu lực, hiệu quả; hoàn thiện chức năng, nhiệm vụ và cơ cấu tổ chức trong toàn ngành; tích cực chỉ đạo, triển khai, quán triệt thực hiện nhiều văn bản về tăng cường kỷ luật, kỷ cương, kỷ luật lao động, văn hóa công sở và trách nhiệm của công chức, viên chức trong thực thi công vụ. Nhằm xây dựng môi trường văn hóa công sở văn minh, lịch sự bảo đảm tính trang nghiêm và hiệu quả hoạt động của đơn vị nhằm hoàn thành xuất sắc nhiệm vụ được giao.\nTuy nhiên, thực tế vẫn còn một số hạn chế nhất định:\nVi phạm thời giờ làm việc, lãng phí thời gian làm việc “sáng cắp ô đi, tối cắp ô về; vẫn còn biểu hiện thiếu văn hóa nơi công sở khi thực thi công vụ, thái độ thờ ơ, vô cảm, thủ tục nhũng nhiễu, thiếu tôn trọng hoặc coi thường kết quả công việc của đồng nghiệp; dùng từ ngữ thiếu “tế nhị”; tạo khoản cách giữa cấp trên với cấp dưới, giữa đồng nghiệp với đồng nghiệp, hình thành “lợi ích nhóm”; phát sinh hiện tượng mất đoàn kết; việc giám sát công chức chưa được thường xuyên, thiếu kiểm tra đôn đốc nhắc nhỡ để chấn chỉnh kịp thời; từ đó làm giảm lòng tin với Nhân dân và với người nộp thuế, làm giảm hiệu lực, hiệu quả trong thực thi nhiệm vụ, ảnh hưởng xấu “hình ảnh của công chức” và của ngành Thuế.\nTừ những hiện trạng nói trên, với trách nhiệm của người công chức thuế trong giai đoạn hiện nay, với tinh thần trách nhiệm và bằng những kinh nghiệm thực tiễn trong công tác, xét thấy việc đề xuất giải pháp mới nhằm khắc phục nhược điểm đã qua là thật sự cần thiết.\nĐối với Thuế cơ sở thực hiện chức năng quản lý Nhà nước về thuế thuộc địa bàn quản lý, số lượng cán bộ, công chức tương đối nhiều. Phạm vi hoạt động gồm một thị xã và một huyện, số lượng người nộp thuế gần 4000 người, điều này đòi hỏi Thuế cơ sở phải có những cách làm mới đề nâng cao hiệu quả thực hiện kỷ luật lao động và văn hóa công sở là nhiệm vụ quan trọng và cấp bách. Xuất phát từ đó nhóm tác giả quyết định chọn đề tài “Những số giải pháp chủ yếu tăng cường kỷ luật lao động và văn hóa công sở tại Thuế cơ sở”. Qua đó xây dựng đội ngũ công chức thuế tuân thủ kỷ luật lao động và tác phong, lề lối làm việc chuyên nghiệp, văn minh công sở, hiện đại, gương mẫu trong việc chấp hành kỷ luật lao động và văn hóa công sở, nâng cao tinh thần trách nhiệm, giữ vững kỷ luật, kỷ cương trong thực thi công vụ.\nb. Nội dung sáng kiến:\nBước 1. Công tác tuyên truyền, giáo dục chính trị tư tưởng. Gồm 2 nội dung:\nThứ nhất, Tuyên truyền, giáo dục văn bản của cấp trên:\nQuyết định số 828/QĐ-BTC ngày 08 tháng 6 năm 2020 về việc ban hành Quy chế văn hóa công sở tại các đơn vị thuộc và trực thuộc bộ tài chính; Quyết định số 2181/QĐ-TCT ngày 27/12/2012 Tổng cục trưởng Tổng cục Thuế về việc Quy định Tiêu chuẩn văn hoá công sở và Đạo đức công chức, viên chức ngành Thuế; Quyết định số 443/QĐ-BTC ngày 14/3/2024 của Bộ Tài chính về kiểm tra việc chấp hành kỷ luật lao động và văn hóa công sở; Quyết định số 316/QĐ-TCT ngày 26/3/2024 của Tổng cục Thuế về kiểm tra nội bộ việc chấp hành kỷ luật lao động và văn hóa công sở; Công văn số 226/TCT-TCCB ngày 15/01/2025 của Tổng cục Thuế về việc tăng cường kỷ cương, kỷ luật trong triển khai công tác sắp xếp, tinh gọn bộ máy; Công văn số 176/CT-VP ngày 15/3/2025 của Cục Thuế về việc tiếp tục chấn chính, tăng cường kỷ cương, kỷ luật trong giải quyết thủ tục hành chính, văn bản của Bộ Tài chính; Công văn số 261/CT-TTKT ngày 21/3/2025 của Cục Thuế về việc chấn chỉnh kỷ luật, kỷ cương trong thực thi công vụ; Công văn số 2847/CT-VP ngày 31/7/2025 của Cục Thuế về việc nâng cao chất lượng sự phục vụ của cơ quan thuế đối với người nộp thuế.\nThứ hai, Tuyên truyền, giáo dục bằng hình thức trực quan: là phương pháp, hình thức tác động trực tiếp chủ yếu vào mắt con người, tạo nên ấn tượng về một vấn đề nhất định theo mục đích để người xem hiểu và làm theo. Theo đó mỗi Tổ treo một khẩu hiệu gắn với chức năng nhiệm vụ của Tổ đó (kèm theo Phụ lục số 01).\nBước 2: Giám sát quá trình thực thi nhiệm vụ. Gồm có 2 nội dung:\nThứ nhất, Giám sát việc chấp hành kỷ luật lao động và thực hiện văn hóa công sở:\n- Giám sát từng Tổ: Tổ trưởng chịu trách nhiệm\n- Giám sát toàn đơn vị: Tổ trưởng Tổ Nghiệp vụ, dự toán, pháp chế (Bao gồm: Tổ Hành chính, tổng hợp và Tổ Nghiệp vụ, dự toán, pháp chế) chịu trách nhiệm giám sát chung toàn đơn vị và tổng hợp các báo cáo của các Tổ. Giám sát công chức, viên chức thực hiện giờ công, ngày công và văn hóa công sở có đúng quy định không. Đồng thời tổng hợp báo cáo cho Trưởng Thuế cơ sở vào ngày họp báo đầu tháng sau.\nThứ hai, Tiếp nhận thông tin và xử lý thông tin trong quá trình thực thi công vụ: Công việc này do tập thể lãnh đạo đơn vị; Tổ trưởng Tổ Nghiệp vụ, dự toán, pháp chế và lãnh Tổ Quản lý, hỗ trợ doanh nghiệp phụ trách kiểm tra nội bộ thực hiện:\n* Tiếp nhận thông tin:\n- Nắm chính xác nguồn thông tin để khai thác, thu thập, cung cấp hợp lý, đúng lúc, đúng mục đích, phù hợp với quy định của pháp luật;\n- Trong quá trình giao tiếp với người nộp thuế có vi phạm kỷ cương, kỷ luật, đạo đức công vụ, văn hóa ứng xử không.\n- Tiếp nhận thông tin đa chiều: Từ người nộp thuế, từ phương tiện thông tin đại chúng, từ các ban ngành có liên quan, từ nội bộ đơn vị…\n* Phân tích thông tin:\n- Phân loại thông tin thành: thông tin chính và thông tin hỗ trợ; thông tin có giá trị, ít giá trị hoặc không có giá trị; phải loại bỏ hoặc nghi ngờ những thông tin thiếu căn cứ, thiếu cơ sở khoa học.\n- Tiến hành so sánh, đối chiếu để kiểm tra tính chính xác, tính khoa học, hợp lý của thông tin, nhằm mục đích xác định rõ những thông tin nào đáng tin và thông tin nào không đáng tin. Qua đó phát hiện những điều bất hợp lý, mâu thuẫn, phi logic trong nội dung thông tin.\n* Tổng hợp thông tin: Sắp xếp các thông tin và số liệu đã được kiểm tra, xác minh, phân tích, chọn lọc và phân theo thẩm quyền để giải quyết vấn đề:\n- Thông tin thuộc thẩm quyền giải quyết của Phó Trưởng thuế phụ trách các Tổ và bộ phận;\n- Thông tin thuộc thẩm quyền giải quyết của Trưởng Thuế và thông tin phải kiểm tra nội.\nBước 3: Nhận xét đánh giá và quyết định vấn đề:\nThủ trưởng đơn vị thực hiện:\n- Từ các nguồn dữ liệu, cứ liệu đã được cung cấp, lựa chọn những thông tin chủ yếu cần giải quyết để xử lý trước và sau đó đến các vấn đề khác.\n- Đối với những Tổ và bộ phận có nhiều cá nhân vi phạm kỷ luật lao động và văn hóa công sở (nhưng chưa đến mức phải có hình thức kỷ luật) thì trực tiếp tham dự cuộc họp vào đầu tháng sau, hoặc dự họp hàng tuần (nếu có những vấn đề cấp thiết) để tập thể nhận xét, đánh giá và mức độ vi phạm từng cá nhân, gồm có mức độ vi phạm như sau:\nMột là, trường hợp vi phạm lần đầu, thì Phó Trưởng thuế phụ trách các Tổ và bộ phận họp kiểm điểm khắc phục, sửa chữa;\nHai là, Trường hợp vi phạm lần thứ hai trở đi thì ban hành công văn nhắc nhỡ chung trong toàn đơn vị.\n- Những trường hợp qua quá trình giám ở bước 2 hoặc phản ánh bằng văn bản thì chỉ đạo cho đồng chí cấp phó, phụ trách Bộ phận kiểm tra nội bộ, thực hiện kiểm tra theo quy trình hoặc kiểm tra đột xuất. Đặc biệt những Tổ và bộ phận có nhiều cá nhân vi phạm thì họp kiểm điểm trách nhiệm người đứng đầu.\nSau đó, nếu các cá nhân vi phạm không khắc phục, sửa chữa thì ngày đầu tháng của quý sau, Hội đồng Thi đua – Khen thưởng kết hợp vào kết quả đạt được trong quý và Bảng tự chấm điểm, tiến hành nhận xét đánh giá và viết bản kiểm điểm và cam kết sẽ khắc phục những hạn chế, yếu kém.\n- Những trường hợp có ý kiến phản ánh bằng văn bản của người nộp thuế sau khi có kết quả kiểm tra nội bộ, báo cáo cấp trên xử lý kịp thời, nghiêm khắc các trường hợp vi phạm để răn đe, làm gương. Đồng thời, tổng hợp lưu trữ, làm cơ sở đánh giá cán bộ, công chức cuối năm, cũng như công tác luân phiên, điều động cán bộ.\n* Tính mới của sáng kiến:\n- Tuyên truyền hình thức trực quan. Phương pháp tuyên truyền trực quan có sức thuyết phục, lôi cuốn mạnh mẽ đến cán bộ, công chức và người dân, gắn kết giữa công tác tuyên truyền và triển khai thực hiện.\n- Lãnh đạo đơn vị giám sát chặt chẽ quá trình thực hiện kỷ luật lao động và văn hóa công sở, cũng như nắm bắt thông tin đa chiều trong quá trình thực thi công vụ của cán bộ, công chức. Nếu một đơn vị làm tốt công tác giám sát, kiểm tra thường xuyên hoặc đột xuất và thực hiện giải pháp khép kín từ khâu tuyên truyền, giáo dục đến kiểm tra giáp sát và xử lý thì công chức sẽ “khép mình vào khuôn khổ pháp luật” chấp hành kỷ luật lao động và văn hóa công sở, nâng cao tinh thần trách nhiệm, giữ vững kỷ luật, kỷ cương trong thực thi công vụ và hoàn thành tốt nhiệm vụ được giao.\n- Công chức sử dụng hết quỹ thời gian theo quy định, không còn thời gian nhàn rỗi và phối hợp chặt chẽ giữa các cá nhân và các tập thể trong đơn vị, “làm hết giờ” sang “làm hết việc; gắn trách nhiệm với chế độ khen thưởng, kỷ luật đối với công chức trong hoạt động thực thi công vụ. Cũng như trách nhiệm của người đứng đầu.\nHiệu quả và phạm vi áp dụng của sáng kiến, giải pháp:\n* Về hiệu quả kinh tế xã hội:\nXây dựng hệ thống thuế Việt Nam “tinh - gọn - mạnh - hiệu năng - hiệu lực - hiệu quả” thực hiện đúng phương châm “Lấy người nộp thuế làm trung tâm phục vụ” với mục tiêu ngày càng nâng cao chất lượng công tác quản lý thuế; đảm bảo cơ cấu tổ chức mới vận hành thông suốt, ổn định; phục vụ, giải quyết các TTHC thuế cho cộng đồng doanh nghiệp và người dân kịp thời, nhanh chóng và hiệu quả, tạo không gian, môi trường làm việc khoa học, văn minh.\nGóp phần cùng địa phương phát triển kinh kinh tế, xã hội, thể hiện qua kết quả thu ngân sách 7 tháng năm 2024 là 117 tỷ 852/224 tỷ , đạt 52,61%, và 7 tháng đầu năm 2025 thu toàn đơn vị là 128 tỷ 710/224 tỷ, đạt 57,5% dự toán năm.\n* Hiệu quả từ việc xây dựng bộ máy:\nGiúp cho lãnh đạo đơn vị xây dựng bộ máy trong sạch, vững mạnh, hoạt động hiệu quả, vận hành đồng bộ và kiểm soát trách nhiệm, nâng cao hiệu quả công tác và giữ nghiêm kỷ luật, kỷ cương trong thực thi công vụ, nêu cao trách nhiệm của người đứng đầu và nhiệm vụ chính trị của Ngành trong thời gian tới;\nCông chức chấp hành tốt quy chế văn minh công sở và đạo đức cán bộ Thuế, thực hiện tốt nội quy, quy chế làm việc của ngành; không vi phạm kỷ luật lao động và văn hóa công sở; trong thực hiện nhiệm vụ: Không trốn tránh, không thoái thác, không áp đặt, không bè phái; Biết lắng nghe, biết hướng dẫn, biết giúp đỡ, biết cảm ơn, biết xin lỗi; trong giao tiếp với tổ chức, cá nhân người nộp thuế: Xin chào, xin lỗi, xin cảm ơn, xin phép; Luôn mỉm cười, luôn nhẹ nhàng, luôn lắng nghe, luôn giúp đỡ... Qua đó, Tạo động lực cho cán bộ, công chức thuế có trách nhiệm, quyết tâm với công việc; sẵn sàng công tâm giúp đỡ người nộp thuế, để xứng đáng với khẩu hiệu “Minh bạch - Chuyên nghiệp - Liêm chính - Đổi mới”.\nLàm thước đo sự văn minh của mỗi cán bộ, công chức hay nói khác đi chính là sự phản ánh nhận thức của mỗi cá nhân trong môi trường làm việc nơi công sở và xây dựng môi trường làm việc hiện đại, chuyên nghiệp, thân thiện và hiệu quả. Ứng xử có văn hóa nơi công sở mang lại rất nhiều lợi ích góp phần tạo dựng niềm tin, sự đoàn kết, thống nhất của tập thể, từ đó tạo bầu không khí làm việc cởi mở, tích cực, nâng cao chất lượng và hiệu quả công việc.\n* Khả năng nhân rộng: Sáng kiến này có thể áp dụng cho nhiều năm tiếp theo nhằm nâng cao tinh thần trách nhiệm, chấp hành nghiêm kỷ cương, kỷ luật lao động và văn hóa công sở của công chức trong thực thi chức trách nhiệm vụ được giao trong phạm vi Thuế tỉnh.\n* Phạm vi áp dụng: Trong phạm vi Thuế tỉnh\n5. Hội đồng cơ sở đã xét công nhận sáng kiến: Quyết định số 1109/QĐ-CMA ngày 23/10/2025.\n6. Thời gian áp dụng: Ngày 01/3/2025', '<p>THUẾ TỈNH CÀ MAU            CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM</p><p>THUẾ CƠ SỞ 7 TỈNH CÀ MAU                   Độc lập - Tự do - Hạnh phúc</p><p>BÁO CÁO MÔ TẢ SÁNG KIẾN</p><p>1. Tên sáng kiến: Những giải pháp chủ yếu tăng cường kỷ luật lao động và văn hóa công sở tại Thuế cơ sở</p><p>2. Nhóm tác giải:</p><p>3. Lĩnh vực áp dụng: Tổ chức, nhân sự; Vấn đề sáng kiến giải quyết: tăng cường kỷ luật lao động và văn hóa công sở tại Thuế cơ sở.</p><p>4. Mô tả sáng kiến:</p><p>a. Khái quát đặc điểm, tình hình trước khi có sáng kiến:</p><p>Thời gian qua ngành Thuế đã tập trung triển khai mô hình tổ chức mới theo hướng tinh gọn, hiệu lực, hiệu quả; hoàn thiện chức năng, nhiệm vụ và cơ cấu tổ chức trong toàn ngành; tích cực chỉ đạo, triển khai, quán triệt thực hiện nhiều văn bản về tăng cường kỷ luật, kỷ cương, kỷ luật lao động, văn hóa công sở và trách nhiệm của công chức, viên chức trong thực thi công vụ. Nhằm xây dựng môi trường văn hóa công sở văn minh, lịch sự bảo đảm tính trang nghiêm và hiệu quả hoạt động của đơn vị nhằm hoàn thành xuất sắc nhiệm vụ được giao.</p><p>Tuy nhiên, thực tế vẫn còn một số hạn chế nhất định:</p><p>Vi phạm thời giờ làm việc, lãng phí thời gian làm việc “sáng cắp ô đi, tối cắp ô về; vẫn còn biểu hiện thiếu văn hóa nơi công sở khi thực thi công vụ, thái độ thờ ơ, vô cảm, thủ tục nhũng nhiễu, thiếu tôn trọng hoặc coi thường kết quả công việc của đồng nghiệp; dùng từ ngữ thiếu “tế nhị”; tạo khoản cách giữa cấp trên với cấp dưới, giữa đồng nghiệp với đồng nghiệp, hình thành “lợi ích nhóm”; phát sinh hiện tượng mất đoàn kết; việc giám sát công chức chưa được thường xuyên, thiếu kiểm tra đôn đốc nhắc nhỡ để chấn chỉnh kịp thời; từ đó làm giảm lòng tin với Nhân dân và với người nộp thuế, làm giảm hiệu lực, hiệu quả trong thực thi nhiệm vụ, ảnh hưởng xấu “hình ảnh của công chức” và của ngành Thuế.</p><p>Từ những hiện trạng nói trên, với trách nhiệm của người công chức thuế trong giai đoạn hiện nay, với tinh thần trách nhiệm và bằng những kinh nghiệm thực tiễn trong công tác, xét thấy việc đề xuất giải pháp mới nhằm khắc phục nhược điểm đã qua là thật sự cần thiết.</p><p>Đối với Thuế cơ sở thực hiện chức năng quản lý Nhà nước về thuế thuộc địa bàn quản lý, số lượng cán bộ, công chức tương đối nhiều. Phạm vi hoạt động gồm một thị xã và một huyện, số lượng người nộp thuế gần 4000 người, điều này đòi hỏi Thuế cơ sở phải có những cách làm mới đề nâng cao hiệu quả thực hiện kỷ luật lao động và văn hóa công sở là nhiệm vụ quan trọng và cấp bách. Xuất phát từ đó nhóm tác giả quyết định chọn đề tài “Những số giải pháp chủ yếu tăng cường kỷ luật lao động và văn hóa công sở tại Thuế cơ sở”. Qua đó xây dựng đội ngũ công chức thuế tuân thủ kỷ luật lao động và tác phong, lề lối làm việc chuyên nghiệp, văn minh công sở, hiện đại, gương mẫu trong việc chấp hành kỷ luật lao động và văn hóa công sở, nâng cao tinh thần trách nhiệm, giữ vững kỷ luật, kỷ cương trong thực thi công vụ.</p><p>b. Nội dung sáng kiến:</p><p>Bước 1. Công tác tuyên truyền, giáo dục chính trị tư tưởng. Gồm 2 nội dung:</p><p>Thứ nhất, Tuyên truyền, giáo dục văn bản của cấp trên:</p><p>Quyết định số 828/QĐ-BTC ngày 08 tháng 6 năm 2020 về việc ban hành Quy chế văn hóa công sở tại các đơn vị thuộc và trực thuộc bộ tài chính; Quyết định số 2181/QĐ-TCT ngày 27/12/2012 Tổng cục trưởng Tổng cục Thuế về việc Quy định Tiêu chuẩn văn hoá công sở và Đạo đức công chức, viên chức ngành Thuế; Quyết định số 443/QĐ-BTC ngày 14/3/2024 của Bộ Tài chính về kiểm tra việc chấp hành kỷ luật lao động và văn hóa công sở; Quyết định số 316/QĐ-TCT ngày 26/3/2024 của Tổng cục Thuế về kiểm tra nội bộ việc chấp hành kỷ luật lao động và văn hóa công sở; Công văn số 226/TCT-TCCB ngày 15/01/2025 của Tổng cục Thuế về việc tăng cường kỷ cương, kỷ luật trong triển khai công tác sắp xếp, tinh gọn bộ máy; Công văn số 176/CT-VP ngày 15/3/2025 của Cục Thuế về việc tiếp tục chấn chính, tăng cường kỷ cương, kỷ luật trong giải quyết thủ tục hành chính, văn bản của Bộ Tài chính; Công văn số 261/CT-TTKT ngày 21/3/2025 của Cục Thuế về việc chấn chỉnh kỷ luật, kỷ cương trong thực thi công vụ; Công văn số 2847/CT-VP ngày 31/7/2025 của Cục Thuế về việc nâng cao chất lượng sự phục vụ của cơ quan thuế đối với người nộp thuế.</p><p>Thứ hai, Tuyên truyền, giáo dục bằng hình thức trực quan: là phương pháp, hình thức tác động trực tiếp chủ yếu vào mắt con người, tạo nên ấn tượng về một vấn đề nhất định theo mục đích để người xem hiểu và làm theo. Theo đó mỗi Tổ treo một khẩu hiệu gắn với chức năng nhiệm vụ của Tổ đó (kèm theo Phụ lục số 01).</p><p>Bước 2: Giám sát quá trình thực thi nhiệm vụ. Gồm có 2 nội dung:</p><p>Thứ nhất, Giám sát việc chấp hành kỷ luật lao động và thực hiện văn hóa công sở:</p><p>- Giám sát từng Tổ: Tổ trưởng chịu trách nhiệm</p><p>- Giám sát toàn đơn vị: Tổ trưởng Tổ Nghiệp vụ, dự toán, pháp chế (Bao gồm: Tổ Hành chính, tổng hợp và Tổ Nghiệp vụ, dự toán, pháp chế) chịu trách nhiệm giám sát chung toàn đơn vị và tổng hợp các báo cáo của các Tổ. Giám sát công chức, viên chức thực hiện giờ công, ngày công và văn hóa công sở có đúng quy định không. Đồng thời tổng hợp báo cáo cho Trưởng Thuế cơ sở vào ngày họp báo đầu tháng sau.</p><p>Thứ hai, Tiếp nhận thông tin và xử lý thông tin trong quá trình thực thi công vụ: Công việc này do tập thể lãnh đạo đơn vị; Tổ trưởng Tổ Nghiệp vụ, dự toán, pháp chế và lãnh Tổ Quản lý, hỗ trợ doanh nghiệp phụ trách kiểm tra nội bộ thực hiện:</p><p>* Tiếp nhận thông tin:</p><p>- Nắm chính xác nguồn thông tin để khai thác, thu thập, cung cấp hợp lý, đúng lúc, đúng mục đích, phù hợp với quy định của pháp luật;</p><p>- Trong quá trình giao tiếp với người nộp thuế có vi phạm kỷ cương, kỷ luật, đạo đức công vụ, văn hóa ứng xử không.</p><p>- Tiếp nhận thông tin đa chiều: Từ người nộp thuế, từ phương tiện thông tin đại chúng, từ các ban ngành có liên quan, từ nội bộ đơn vị…</p><p>* Phân tích thông tin:</p><p>- Phân loại thông tin thành: thông tin chính và thông tin hỗ trợ; thông tin có giá trị, ít giá trị hoặc không có giá trị; phải loại bỏ hoặc nghi ngờ những thông tin thiếu căn cứ, thiếu cơ sở khoa học.</p><p>- Tiến hành so sánh, đối chiếu để kiểm tra tính chính xác, tính khoa học, hợp lý của thông tin, nhằm mục đích xác định rõ những thông tin nào đáng tin và thông tin nào không đáng tin. Qua đó phát hiện những điều bất hợp lý, mâu thuẫn, phi logic trong nội dung thông tin.</p><p>* Tổng hợp thông tin: Sắp xếp các thông tin và số liệu đã được kiểm tra, xác minh, phân tích, chọn lọc và phân theo thẩm quyền để giải quyết vấn đề:</p><p>- Thông tin thuộc thẩm quyền giải quyết của Phó Trưởng thuế phụ trách các Tổ và bộ phận;</p><p>- Thông tin thuộc thẩm quyền giải quyết của Trưởng Thuế và thông tin phải kiểm tra nội.</p><p>Bước 3: Nhận xét đánh giá và quyết định vấn đề:</p><p>Thủ trưởng đơn vị thực hiện:</p><p>- Từ các nguồn dữ liệu, cứ liệu đã được cung cấp, lựa chọn những thông tin chủ yếu cần giải quyết để xử lý trước và sau đó đến các vấn đề khác.</p><p>- Đối với những Tổ và bộ phận có nhiều cá nhân vi phạm kỷ luật lao động và văn hóa công sở (nhưng chưa đến mức phải có hình thức kỷ luật) thì trực tiếp tham dự cuộc họp vào đầu tháng sau, hoặc dự họp hàng tuần (nếu có những vấn đề cấp thiết) để tập thể nhận xét, đánh giá và mức độ vi phạm từng cá nhân, gồm có mức độ vi phạm như sau:</p><p>Một là, trường hợp vi phạm lần đầu, thì Phó Trưởng thuế phụ trách các Tổ và bộ phận họp kiểm điểm khắc phục, sửa chữa;</p><p>Hai là, Trường hợp vi phạm lần thứ hai trở đi thì ban hành công văn nhắc nhỡ chung trong toàn đơn vị.</p><p>- Những trường hợp qua quá trình giám ở bước 2 hoặc phản ánh bằng văn bản thì chỉ đạo cho đồng chí cấp phó, phụ trách Bộ phận kiểm tra nội bộ, thực hiện kiểm tra theo quy trình hoặc kiểm tra đột xuất. Đặc biệt những Tổ và bộ phận có nhiều cá nhân vi phạm thì họp kiểm điểm trách nhiệm người đứng đầu.</p><p>Sau đó, nếu các cá nhân vi phạm không khắc phục, sửa chữa thì ngày đầu tháng của quý sau, Hội đồng Thi đua – Khen thưởng kết hợp vào kết quả đạt được trong quý và Bảng tự chấm điểm, tiến hành nhận xét đánh giá và viết bản kiểm điểm và cam kết sẽ khắc phục những hạn chế, yếu kém.</p><p>- Những trường hợp có ý kiến phản ánh bằng văn bản của người nộp thuế sau khi có kết quả kiểm tra nội bộ, báo cáo cấp trên xử lý kịp thời, nghiêm khắc các trường hợp vi phạm để răn đe, làm gương. Đồng thời, tổng hợp lưu trữ, làm cơ sở đánh giá cán bộ, công chức cuối năm, cũng như công tác luân phiên, điều động cán bộ.</p><p>* Tính mới của sáng kiến:</p><p>- Tuyên truyền hình thức trực quan. Phương pháp tuyên truyền trực quan có sức thuyết phục, lôi cuốn mạnh mẽ đến cán bộ, công chức và người dân, gắn kết giữa công tác tuyên truyền và triển khai thực hiện.</p><p>- Lãnh đạo đơn vị giám sát chặt chẽ quá trình thực hiện kỷ luật lao động và văn hóa công sở, cũng như nắm bắt thông tin đa chiều trong quá trình thực thi công vụ của cán bộ, công chức. Nếu một đơn vị làm tốt công tác giám sát, kiểm tra thường xuyên hoặc đột xuất và thực hiện giải pháp khép kín từ khâu tuyên truyền, giáo dục đến kiểm tra giáp sát và xử lý thì công chức sẽ “khép mình vào khuôn khổ pháp luật” chấp hành kỷ luật lao động và văn hóa công sở, nâng cao tinh thần trách nhiệm, giữ vững kỷ luật, kỷ cương trong thực thi công vụ và hoàn thành tốt nhiệm vụ được giao.</p><p>- Công chức sử dụng hết quỹ thời gian theo quy định, không còn thời gian nhàn rỗi và phối hợp chặt chẽ giữa các cá nhân và các tập thể trong đơn vị, “làm hết giờ” sang “làm hết việc; gắn trách nhiệm với chế độ khen thưởng, kỷ luật đối với công chức trong hoạt động thực thi công vụ. Cũng như trách nhiệm của người đứng đầu.</p><p>Hiệu quả và phạm vi áp dụng của sáng kiến, giải pháp:</p><p>* Về hiệu quả kinh tế xã hội:</p><p>Xây dựng hệ thống thuế Việt Nam “tinh - gọn - mạnh - hiệu năng - hiệu lực - hiệu quả” thực hiện đúng phương châm “Lấy người nộp thuế làm trung tâm phục vụ” với mục tiêu ngày càng nâng cao chất lượng công tác quản lý thuế; đảm bảo cơ cấu tổ chức mới vận hành thông suốt, ổn định; phục vụ, giải quyết các TTHC thuế cho cộng đồng doanh nghiệp và người dân kịp thời, nhanh chóng và hiệu quả, tạo không gian, môi trường làm việc khoa học, văn minh.</p><p>Góp phần cùng địa phương phát triển kinh kinh tế, xã hội, thể hiện qua kết quả thu ngân sách 7 tháng năm 2024 là 117 tỷ 852/224 tỷ , đạt 52,61%, và 7 tháng đầu năm 2025 thu toàn đơn vị là 128 tỷ 710/224 tỷ, đạt 57,5% dự toán năm.</p><p>* Hiệu quả từ việc xây dựng bộ máy:</p><p>Giúp cho lãnh đạo đơn vị xây dựng bộ máy trong sạch, vững mạnh, hoạt động hiệu quả, vận hành đồng bộ và kiểm soát trách nhiệm, nâng cao hiệu quả công tác và giữ nghiêm kỷ luật, kỷ cương trong thực thi công vụ, nêu cao trách nhiệm của người đứng đầu và nhiệm vụ chính trị của Ngành trong thời gian tới;</p><p>Công chức chấp hành tốt quy chế văn minh công sở và đạo đức cán bộ Thuế, thực hiện tốt nội quy, quy chế làm việc của ngành; không vi phạm kỷ luật lao động và văn hóa công sở; trong thực hiện nhiệm vụ: Không trốn tránh, không thoái thác, không áp đặt, không bè phái; Biết lắng nghe, biết hướng dẫn, biết giúp đỡ, biết cảm ơn, biết xin lỗi; trong giao tiếp với tổ chức, cá nhân người nộp thuế: Xin chào, xin lỗi, xin cảm ơn, xin phép; Luôn mỉm cười, luôn nhẹ nhàng, luôn lắng nghe, luôn giúp đỡ... Qua đó, Tạo động lực cho cán bộ, công chức thuế có trách nhiệm, quyết tâm với công việc; sẵn sàng công tâm giúp đỡ người nộp thuế, để xứng đáng với khẩu hiệu “Minh bạch - Chuyên nghiệp - Liêm chính - Đổi mới”.</p><p>Làm thước đo sự văn minh của mỗi cán bộ, công chức hay nói khác đi chính là sự phản ánh nhận thức của mỗi cá nhân trong môi trường làm việc nơi công sở và xây dựng môi trường làm việc hiện đại, chuyên nghiệp, thân thiện và hiệu quả. Ứng xử có văn hóa nơi công sở mang lại rất nhiều lợi ích góp phần tạo dựng niềm tin, sự đoàn kết, thống nhất của tập thể, từ đó tạo bầu không khí làm việc cởi mở, tích cực, nâng cao chất lượng và hiệu quả công việc.</p><p>* Khả năng nhân rộng: Sáng kiến này có thể áp dụng cho nhiều năm tiếp theo nhằm nâng cao tinh thần trách nhiệm, chấp hành nghiêm kỷ cương, kỷ luật lao động và văn hóa công sở của công chức trong thực thi chức trách nhiệm vụ được giao trong phạm vi Thuế tỉnh.</p><p>* Phạm vi áp dụng: Trong phạm vi Thuế tỉnh</p><p>5. Hội đồng cơ sở đã xét công nhận sáng kiến: Quyết định số 1109/QĐ-CMA ngày 23/10/2025.</p><p>6. Thời gian áp dụng: Ngày 01/3/2025</p>', '781e8508428850c55d754eac401b3f7481d515e2711832e59a755f110ef7e13c', '2026-09-22 19:58:18'),
(17, 33, 40, 'THUẾ TỈNH CÀ MAU CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM\nTHUẾ CƠ SỞ 7 TỈNH CÀ MAU Độc lập - Tự do - Hạnh phúc\nBÁO CÁO MÔ TẢ SÁNG KIẾN\n1. Tên sáng kiến: “CẢI TIẾN CÔNG TÁC TUYÊN TRUYỀN VÀ HỖ TRỢ NGƯỜI NỘP THUẾ SAU KHI SÁP NHẬP CƠ QUAN THUẾ THEO MÔ HÌNH CHÍNH QUYỀN ĐỊA PHƯƠNG 2 CẤP TỪ NGÀY 01/07/2025 THUẾ CƠ SỞ 7 TỈNH CÀ MAU”\n2. Nhóm tác giải:\n3. Lĩnh vực áp dụng: Tuyên truyền - Hỗ trợ NNT.\n4. Mô tả sáng kiến:\na. Khái quát đặc điểm, tình hình trước khi có sáng kiến:\nTrước ngày 01/07/2025, công tác tuyên truyền và hỗ trợ Người nộp thuế tại Thuế cơ sở chủ yếu dựa trên mô hình tổ chức 3 cấp (Chi cục Thuế khu vực, Đội Thuế liên huyện và Các Tổ liên xã/phường). Hệ thống này đã vận hành từ năm 2010, với các Tổ liên xã/phường đóng vai trò then chốt trong việc tiếp cận trực tiếp Người nộp thuế tại cơ sở, đặc biệt ở khu vực nông thôn và ven biển của huyện Đông Hải và Thị xã Giá Rai.\nCông tác tuyên truyền chủ yếu sử dụng các hình thức truyền thống như phát tờ rơi, dán áp phích tại UBND xã, tổ chức hội nghị tuyên truyền tại huyện (trung bình 4-6 hội nghị/năm), và hỗ trợ trực tiếp tại quầy hoặc qua đường dây nóng. Hỗ trợ người nộp thuế tập trung vào giải đáp thắc mắc về kê khai thuế thu nhập cá nhân (TNCN), thuế giá trị gia tăng (GTGT), hoàn thuế cho hộ kinh doanh nuôi trồng thủy sản, với sự tham gia của khoảng 15-20 cán bộ tại các cấp. Tuy nhiên, do tổ chức phân tán, thông tin tuyên truyền thường thiếu đồng bộ cụ thể: Một số chính sách mới như miễn giảm, gia hạn nộp thuế cho Doanh nghiệp và hộ kinh doanh theo các Nghị định hướng dẫn của Chính phủ thường bị chậm trễ triển khai tại cấp xã, dẫn đến thông tin không nhất quán giữa các Đội Thuế. Theo báo cáo nội bộ của Thuế cơ sở năm 2025, tỷ lệ người nộp thuế tại Thị xã Giá Rai và huyện huyện Đông Hải tiếp cận thông tin qua kênh trực tuyến chỉ đạt 55% (thấp hơn mức trung bình tỉnh 65%), trong khi 45% vẫn phụ thuộc hỗ trợ trực tiếp, gây ùn tắc tại Đội Thuế. Số lượng khiếu nại về thủ tục thuế tăng 12% so cùng kỳ năm 2024, chủ yếu từ hộ kinh doanh nhỏ lẻ do thiếu hướng dẫn kịp thời.\nĐể hỗ trợ tối đa NNT trong việc khai thuế, nộp thuế và thực hiện các thủ tục hành chính về thuế đầy đủ mà nhanh gọn, Đơn vị chú trọng đến công tác đổi mới, đa dạng hoá hình thức tuyên truyền các chủ trương, chính sách mới về Thuế, tạo điều kiện để NNT tiếp cận nhanh nhất để nâng cao tính tuân thủ pháp luật thuế đối với Người nộp thuế.\n+ Sự cần thiết, mục đích của việc thực hiện sáng kiến:\nTăng cường tuyên truyền, đồng hành, hỗ trợ NNT là một trong những nhiệm vụ trọng tâm luôn được Thuế cơ sở đặt lên hàng đầu trong các chương trình hành động, nhằm nâng cao chất lượng phục vụ mang lại thuận lợi nhất cho NNT.\nCông tác tuyên truyền, hỗ trợ NNT được xác định rõ phải đạt mục đích giúp cho các DN, hộ kinh doanh, cá nhân kinh doanh và mọi người dân hiểu được bản chất của thuế, mục đích sử dụng tiền thuế, lợi ích từ tiền thuế mà mỗi người dân được hưởng và lợi ích chung toàn xã hội. \nĐồng thời, qua đó cung cấp, hướng dẫn cho NNT các thông tin về nội dung, chính sách thuế, các quy trình nghiệp vụ, các cải cách về thủ tục hành chính thuế; tạo lập mối quan hệ bình đẳng, thân thiện giữa cơ quan thuế và NNT theo hướng NNT là người được phục vụ, là khách hàng của cơ quan thuế... \nNgoài ra, đơn vị cũng đặc biệt quan tâm đến công tác hỗ trợ NNT trong việc thực hiện kê khai kế toán thuế. Đặc biệt là thực hiện hóa đơn điện tử khởi tạo từ máy tính tiền có kết nối dữ liệu với Cơ quan Thuế theo Nghị định 70/2025/NĐ-CP. Theo đó, tổ chức triển khai thực hiện các chính sách mới như đăng ký thuế, hoàn thuế, kế toán thuế, phối hợp với các nhà mạng triển khai tới tận hộ kinh doanh đăng ký sử dụng hóa đơn điện tử khởi tạo từ máy tính tiền; triển khai công tác cải cách thủ tục hành chính theo Nghị quyết của Chính phủ trong công tác Kê khai thuế, đăng ký thuế, nộp thuế, hoàn thuế… \nb. Nội dung sáng kiến:\nVới nhận định trong quá trình thực thi chính sách pháp luật thuế, đặc biệt những chính sách thuế mới, NNT không thể tránh khỏi những vướng mắc, lúng túng trong thực hiện. Vì vậy, để kịp thời hỗ trợ NNT cũng như đưa chính sách thuế vào cuộc sống, Đơn vị cũng đã tổ chức nhiều lớp tập huấn (miễn phí) chính sách thuế mới cho NNT; thường xuyên tổ chức hỗ trợ NNT thông qua nhiều hình thức: Hỗ trợ trực tiếp, qua điện thoại hoặc giải đáp chính sách thuế bằng văn bản, hướng dẫn tra cứu văn bản thuế trên các trang điện tử…\nKết quả đạt được từ khi áp dụng sáng kiến vào thực tiễn tại Thuế cơ sở đã giúp NNT tiếp cận công tác quản lý thuế mới. Tuy nhiên, đã qua còn một số tồn tại khách quan như nhân lực làm công tác tuyên truyền, năng lực của NNT, đặc thù địa lý…, nên công tác tuyên truyền hỗ trợ NNT chưa thật sự đạt yêu cầu đặt ra. Mặt khác hoạt động tuyên truyền chưa thật phong phú, chưa đáp ứng nhu cầu cao của NNT. Hạn chế tiếp theo của hoạt động tuyên truyền là chưa nhanh nhạy kịp thời. Bên cạnh đó ý thức chấp hành pháp luật về thuế của một bộ phận NNT chưa cao. Một số NNT còn có thói quen ỷ lại vào cơ quan thuế, ít cập nhật thông tin, chính sách thuế mới.\nTừ thực trạng đó, chúng tôi đã đề xuất đến Ban Lãnh đạo Thuế cơ sở thực hiện những giải pháp đa dạng hóa các hình thức tuyên truyền hỗ trợ về thuế để NNT tiếp cận với những chính sách thuế hiện hành, tuân thủ pháp luật thuế theo cấp độ cao.\nĐể công tác tuyên truyền được toàn diện, bài bản, chúng tôi đã hệ thống hóa, biên soạn lại những thay đổi về chính sách thuế dưới dạng các tập tin văn bản như M.O Word hay tập tin PDF, đặc biệt biên soạn những tình huống dẫn đến các sai phạm DN thường gặp khi sử dụng hóa đơn hay khi kê khai thuế dưới dạng file trình chiếu tự chạy (M.O PowerPoint), sinh động, cụ thể đối với từng loại hình DN; các quy định hiện hành về ngừng nghỉ, giảm miễn thuế đối với hộ gia đình và cá nhân kinh doanh, sử dụng hóa đơn điện tử, sổ sách kế toán đối với hộ kê khai ... truyền tải thông qua nhiều hình thức khác như: gửi thư điện tử (email) tới 100% doanh nghiệp có địa chỉ email kết nối với cơ quan Thuế; niêm yết công khai tại Bộ phận một cửa cơ quan Thuế hay triển khai tại các cuộc tập huấn, đối thoại với NNT tại cơ quan Thuế hoặc hỗ trợ qua hình thức chép tập tin qua ổ đĩa di động ( USB) cho DN; qua zalo... Ngoài ra còn thành lập nhóm zalo Thuế cơ sở hỗ trợ NNT trực tuyến để NNT dễ dàng gởi những yêu cầu cần cơ quan thuế quản lý trực tiếp giải đáp.\nTừ Ứng dụng nộp thuế điện tử dành cho cá nhân, hộ kinh doanh (EtaxMobile) được ngành thuế triển khai đã trở thành một công cụ đáng tin cậy của NNT, cung cấp các dịch vụ tra cứu thông tin, nhận thông báo và nộp thuế chỉ với vài thao tác đơn giản trên chiếc điện thoại thông minh. Việc đăng ký tài khoản thuế điện tử cũng trở nên vô cùng thuận tiện. Nếu NNT đã có tài khoản định danh điện tử VNeID mức 2 thì có thể thực hiện toàn bộ quy trình đăng ký ngay trên điện thoại mà không cần phải đến trực tiếp cơ quan thuế để nộp hồ sơ xác nhận. Mọi thông tin cá nhân sẽ được cập nhật tự động từ cơ sở dữ liệu quốc gia.\nNgoài việc tham mưu cho lãnh đạo cơ quan tổ chức tập huấn, tổ chức hỗ trợ cài đặt dụng EtaxMobile cho hộ kinh doanh, cá nhân kinh doanh, chúng tôi phổ biến cho tất cã cán bộ công chức trong đơn vị sử dụng thành thạo để chia sẽ cho NNT; phối hợp với các ngân hàng hỗ trợ NNT mở tài khoản để nộp thuế điện tử; tăng cường kết nối với NNT qua các ứng dụng zalo, facebook … chia sẽ các buổi livestream trực tuyến do ngành thuế tổ chức; các videos clip hướng dẫn cài đặt, sử dụng và sẳn sàng giải đáp các thắc mắc của NNT mọi lúc, mọi nơi giúp NNT mạnh dạn trao đổi và hiểu yên tâm sử dụng EtaxMobile một cách dễ dàng và hiệu quả.\nSưu tập những tập tin dạng sổ tay điện tử (ebook) về thuế, kế toán hay các văn bản Luật có liên quan đến các hoạt động SXKD từ các đơn vị hoạt động chuyên ngành có uy tín như Phòng Thương mại và Công nghiệp Việt Nam (VCCI); Cục Thuế tỉnh Quảng Ninh; Hội Kiểm toán viên hành nghề Việt Nam (VACPA) để gửi đến NNT…\n- Tính mới của sáng kiến:\nKhác với mô hình cũ chỉ dựa vào tuyên truyền truyền thống và hỗ trợ thủ công tại cấp xã, giải pháp mới xây dựng Trung tâm Hỗ trợ Người nộp thuế Kỹ thuật số địa phương tại Thuế cơ sở, tích hợp với Cổng thông tin điện tử Cục Thuế và ứng dụng địa phương. Sự khác biệt nổi bật là sử dụng AI và dữ liệu lớn (Big Data) của ngành, để phân tích tình huống, hành vi người nộp thuế để hỗ trợ những sai sót kịp thời. Góp phần quản lý thuế hiệu năng, hiệu lực, hiệu quả.\nĐể thực hiện tốt các nội dung nêu trên cũng như cập nhật đầy đủ, kịp thời chính sách thuế có liên quan đã được sửa đổi, bổ sung đến với NNT, nhất là đối với các DN thực hiện nộp thuế theo hình thức kê khai thuế. Hạn chế sai phạm dẫn đến thất thu NSNN mà không làm ảnh hưởng đến kết quả hoạt động SXKD bình thường của NNT. Nhóm tham gia viết Sáng kiến, đề xuất đến Ban Chi ủy, Người đứng đầu Thuế cơ sở đề ra một số giải pháp sau:\n- Ban Lãnh đạo Thuế cơ sở chỉ đạo các bộ phận có liên quan (Tổ Nghiệp vụ - Dự toán - Pháp chế chủ trì) phối hợp biên soạn ngắn gọn một số nội dung quan trọng về chính sách thuế mới đã được sửa đổi, bổ sung; biên soạn lại những trường hợp các hành vi vi phạm qua việc kê khai thuế, nộp thuế, kiểm tra thuế,... Đặc biệt là việc tuyên truyền sử dụng hóa đơn điện tử khởi tạo từ máy tính tiền.\nc. Hiệu quả và phạm vi áp dụng của sáng kiến, giải pháp:\nQua Đa dạng hoá các hình thức tuyên truyền hỗ trợ NNT bằng các ứng dụng qua mạng Internet NNT sẽ nâng cao nhận thức hơn và thực hiện đầy đủ, đúng nội dung quy định của pháp luật về kế toán. Phản ánh đúng, đủ và trung thực các số liệu kê khai và nộp kịp thời theo quy định;\nHạn chế được tình trạng suy bì, thắc mắc giữa DN này với DN khác, giữa hộ kinh doanh này với hộ kinh doanh khác về doanh thu cũng như số thuế phải nộp, nhất là các DN, hộ kinh doanh, kinh doanh cùng ngành nghề, địa bàn;\nTạo sự công bằng trong việc sản xuất kinh doanh cũng như sản xuất theo máy móc công nghệ có công suất lớn, tiêu thụ hàng nhanh, doanh thu cao thì nộp thuế nhiều và ngược lại máy móc công nghệ có công suất nhỏ, tiêu thụ hàng chậm, doanh thu thấp thì nộp thuế ít;\nLàm cho nguồn thu ngân sách nhà nước tăng đáng kể mà công chức thuế không cần phải tốn nhiều thời gian để phân tích, giải thích, tuyên truyền về các văn bản hướng dẫn về việc kê khai doanh thu, số thuế phải nộp, cũng như gian lận, trốn thuế khi phát hiện sẽ chịu xử phạt theo quy định.\nNếu thực hiện đồng bộ các hình thức tuyên truyền hỗ trợ NNT bằng những ứng dụng phổ thông qua mạng Internet như đã nêu trên thì số thuế kê khai phải nộp chắc chắn sẽ tăng so với số thuế kê khai trước đây do NNT đã nắm bắt, cập nhật các thông tin có liên quan đến việc kê khai thuế đầy đủ, kịp thời, giảm thiểu tối đa những sai sót hạn chế mà các tài liệu tuyên truyền đã khuyến cáo, từ đó giảm thiểu tổn thất tài chính do bị xử phạt vi phạm hành chính về thuế, nâng cao mức độ tuân thủ về thuế, tăng số nộp NSNN.\nNhờ làm tốt công tác tuyên truyền mà kết quả công tác đăng ký sử dụng hóa đơn điện tử khởi tạo từ máy tính tiền của hộ kinh doanh theo Nghị định 70/2025/NĐ-CP. Tính đến ngày 31/8/2025 đơn vị có 373/373 hộ kinh doanh thuộc diện sử dụng hóa đơn điện tử khởi tạo từ máy tính tiền, đã đăng ký kết nối với Cơ quan Thuế đạt 100%. Ngoài ra công tác cài đặt EtaxMobile của Thuế cơ sở 7 đạt 100% và sô hộ nộp thuế đạt 95%.\n* Đối tượng áp dụng: Tất cả các doanh nghiệp và hộ kinh doanh, cá nhân kinh doanh.\n* Khả năng áp dụng, nhân rộng sáng kiến: Trong Thuế tỉnh.\n* Phạm vi áp dụng: Trong phạm vi Thuế tỉnh.\n5. Hội đồng cơ sở đã xét công nhận sáng kiến: Quyết định số 1109/QĐ-CMA ngày 23/10/2025.\n6. Thời gian áp dụng: Ngày 01/06/2025.', '<p>THUẾ TỈNH CÀ MAU               CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM</p><p>THUẾ CƠ SỞ 7 TỈNH CÀ MAU                  Độc lập - Tự do - Hạnh phúc</p><p>BÁO CÁO MÔ TẢ SÁNG KIẾN</p><p>1. Tên sáng kiến: “CẢI TIẾN CÔNG TÁC TUYÊN TRUYỀN VÀ HỖ TRỢ NGƯỜI NỘP THUẾ SAU KHI SÁP NHẬP CƠ QUAN THUẾ THEO MÔ HÌNH CHÍNH QUYỀN ĐỊA PHƯƠNG 2 CẤP TỪ NGÀY 01/07/2025 THUẾ CƠ SỞ 7 TỈNH CÀ MAU”</p><p>2. Nhóm tác giải:</p><p>3. Lĩnh vực áp dụng: Tuyên truyền -  Hỗ trợ NNT.</p><p>4. Mô tả sáng kiến:</p><p>a. Khái quát đặc điểm, tình hình trước khi có sáng kiến:</p><p>Trước ngày 01/07/2025, công tác tuyên truyền và hỗ trợ Người nộp thuế tại Thuế cơ sở chủ yếu dựa trên mô hình tổ chức 3 cấp (Chi cục Thuế khu vực, Đội Thuế liên huyện và Các Tổ liên xã/phường). Hệ thống này đã vận hành từ năm 2010, với các Tổ liên xã/phường đóng vai trò then chốt trong việc tiếp cận trực tiếp Người nộp thuế tại cơ sở, đặc biệt ở khu vực nông thôn và ven biển của huyện Đông Hải và Thị xã Giá Rai.</p><p>Công tác tuyên truyền chủ yếu sử dụng các hình thức truyền thống như phát tờ rơi, dán áp phích tại UBND xã, tổ chức hội nghị tuyên truyền tại huyện (trung bình 4-6 hội nghị/năm), và hỗ trợ trực tiếp tại quầy hoặc qua đường dây nóng. Hỗ trợ người nộp thuế tập trung vào giải đáp thắc mắc về kê khai thuế thu nhập cá nhân (TNCN), thuế giá trị gia tăng (GTGT), hoàn thuế cho hộ kinh doanh nuôi trồng thủy sản, với sự tham gia của khoảng 15-20 cán bộ tại các cấp. Tuy nhiên, do tổ chức phân tán, thông tin tuyên truyền thường thiếu đồng bộ cụ thể: Một số chính sách mới như miễn giảm, gia hạn nộp thuế cho Doanh nghiệp và hộ kinh doanh theo các Nghị định hướng dẫn của Chính phủ thường bị chậm trễ triển khai tại cấp xã, dẫn đến thông tin không nhất quán giữa các Đội Thuế. Theo báo cáo nội bộ của Thuế cơ sở năm 2025, tỷ lệ người nộp thuế tại Thị xã Giá Rai và huyện huyện Đông Hải tiếp cận thông tin qua kênh trực tuyến chỉ đạt 55% (thấp hơn mức trung bình tỉnh 65%), trong khi 45% vẫn phụ thuộc hỗ trợ trực tiếp, gây ùn tắc tại Đội Thuế. Số lượng khiếu nại về thủ tục thuế tăng 12% so cùng kỳ năm 2024, chủ yếu từ hộ kinh doanh nhỏ lẻ do thiếu hướng dẫn kịp thời.</p><p>Để hỗ trợ tối đa NNT trong việc khai thuế, nộp thuế và thực hiện các thủ tục hành chính về thuế đầy đủ mà nhanh gọn, Đơn vị chú trọng đến công tác đổi mới, đa dạng hoá hình thức tuyên truyền các chủ trương, chính sách mới về Thuế, tạo điều kiện để NNT tiếp cận nhanh nhất để nâng cao tính tuân thủ pháp luật thuế đối với Người nộp thuế.</p><p>+ Sự cần thiết, mục đích của việc thực hiện sáng kiến:</p><p>Tăng cường tuyên truyền, đồng hành, hỗ trợ NNT là một trong những nhiệm vụ trọng tâm luôn được Thuế cơ sở đặt lên hàng đầu trong các chương trình hành động, nhằm nâng cao chất lượng phục vụ mang lại thuận lợi nhất cho NNT.</p><p>Công tác tuyên truyền, hỗ trợ NNT được xác định rõ phải đạt mục đích giúp cho các DN, hộ kinh doanh, cá nhân kinh doanh và mọi người dân hiểu được bản chất của thuế, mục đích sử dụng tiền thuế, lợi ích từ tiền thuế mà mỗi người dân được hưởng và lợi ích chung toàn xã hội. </p><p>Đồng thời, qua đó cung cấp, hướng dẫn cho NNT các thông tin về nội dung, chính sách thuế, các quy trình nghiệp vụ, các cải cách về thủ tục hành chính thuế; tạo lập mối quan hệ bình đẳng, thân thiện giữa cơ quan thuế và NNT theo hướng NNT là người được phục vụ, là khách hàng của cơ quan thuế... </p><p>Ngoài ra, đơn vị cũng đặc biệt quan tâm đến công tác hỗ trợ NNT trong việc thực hiện kê khai kế toán thuế. Đặc biệt là thực hiện hóa đơn điện tử khởi tạo từ máy tính tiền có kết nối dữ liệu với Cơ quan Thuế theo Nghị định 70/2025/NĐ-CP. Theo đó, tổ chức triển khai thực hiện các chính sách mới như đăng ký thuế, hoàn thuế, kế toán thuế, phối hợp với các nhà mạng triển khai tới tận hộ kinh doanh đăng ký sử dụng hóa đơn điện tử khởi tạo từ máy tính tiền; triển khai công tác cải cách thủ tục hành chính theo Nghị quyết của Chính phủ trong công tác Kê khai thuế, đăng ký thuế, nộp thuế, hoàn thuế… </p><p>b. Nội dung sáng kiến:</p><p>Với nhận định trong quá trình thực thi chính sách pháp luật thuế, đặc biệt những chính sách thuế mới, NNT không thể tránh khỏi những vướng mắc, lúng túng trong thực hiện. Vì vậy, để kịp thời hỗ trợ NNT cũng như đưa chính sách thuế vào cuộc sống, Đơn vị cũng đã tổ chức nhiều lớp tập huấn (miễn phí) chính sách thuế mới cho NNT; thường xuyên tổ chức hỗ trợ NNT thông qua nhiều hình thức: Hỗ trợ trực tiếp, qua điện thoại hoặc giải đáp chính sách thuế bằng văn bản, hướng dẫn tra cứu văn bản thuế trên các trang điện tử…</p><p>Kết quả đạt được từ khi áp dụng sáng kiến vào thực tiễn tại Thuế cơ sở đã giúp NNT tiếp cận công tác quản lý thuế mới. Tuy nhiên, đã qua còn một số tồn tại khách quan như nhân lực làm công tác tuyên truyền, năng lực của NNT, đặc thù địa lý…, nên công tác tuyên truyền hỗ trợ NNT chưa thật sự đạt yêu cầu đặt ra. Mặt khác hoạt động tuyên truyền chưa thật phong phú, chưa đáp ứng nhu cầu cao của NNT. Hạn chế tiếp theo của hoạt động tuyên truyền là chưa nhanh nhạy kịp thời. Bên cạnh đó ý thức chấp hành pháp luật về thuế của một bộ phận NNT chưa cao. Một số NNT còn có thói quen ỷ lại vào cơ quan thuế, ít cập nhật thông tin, chính sách thuế mới.</p><p>Từ thực trạng đó, chúng tôi đã đề xuất đến Ban Lãnh đạo Thuế cơ sở thực hiện những giải pháp đa dạng hóa các hình thức tuyên truyền hỗ trợ về thuế để NNT tiếp cận với những chính sách thuế hiện hành, tuân thủ pháp luật thuế theo cấp độ cao.</p><p>Để công tác tuyên truyền được toàn diện, bài bản, chúng tôi đã hệ thống hóa, biên soạn lại những thay đổi về chính sách thuế dưới dạng các tập tin văn bản như M.O Word hay tập tin PDF, đặc biệt biên soạn những tình huống dẫn đến các sai phạm DN thường gặp khi sử dụng hóa đơn hay khi kê khai thuế dưới dạng file trình chiếu tự chạy (M.O PowerPoint), sinh động, cụ thể đối với từng loại hình DN; các quy định hiện hành về ngừng nghỉ, giảm miễn thuế đối với hộ gia đình và cá nhân kinh doanh, sử dụng hóa đơn điện tử, sổ sách kế toán đối với hộ kê khai ... truyền tải thông qua nhiều hình thức khác như: gửi thư điện tử (email) tới 100% doanh nghiệp có địa chỉ email kết nối với cơ quan Thuế; niêm yết công khai tại Bộ phận một cửa cơ quan Thuế hay triển khai tại các cuộc tập huấn, đối thoại với NNT tại cơ quan Thuế hoặc hỗ trợ qua hình thức chép tập tin qua ổ đĩa di động ( USB) cho DN; qua zalo... Ngoài ra còn thành lập nhóm zalo Thuế cơ sở hỗ trợ NNT trực tuyến để NNT dễ dàng gởi những yêu cầu cần cơ quan thuế quản lý trực tiếp giải đáp.</p><p>Từ Ứng dụng nộp thuế điện tử dành cho cá nhân, hộ kinh doanh (EtaxMobile) được ngành thuế triển khai đã trở thành một công cụ đáng tin cậy của NNT, cung cấp các dịch vụ tra cứu thông tin, nhận thông báo và nộp thuế chỉ với vài thao tác đơn giản trên chiếc điện thoại thông minh. Việc đăng ký tài khoản thuế điện tử cũng trở nên vô cùng thuận tiện. Nếu NNT đã có tài khoản định danh điện tử VNeID mức 2 thì có thể thực hiện toàn bộ quy trình đăng ký ngay trên điện thoại mà không cần phải đến trực tiếp cơ quan thuế để nộp hồ sơ xác nhận. Mọi thông tin cá nhân sẽ được cập nhật tự động từ cơ sở dữ liệu quốc gia.</p><p>Ngoài việc tham mưu cho lãnh đạo cơ quan tổ chức tập huấn, tổ chức hỗ trợ cài đặt dụng EtaxMobile cho hộ kinh doanh, cá nhân kinh doanh, chúng tôi phổ biến cho tất cã cán bộ công chức trong đơn vị sử dụng thành thạo để chia sẽ cho NNT; phối hợp với các ngân hàng hỗ trợ NNT mở tài khoản để nộp thuế điện tử; tăng cường kết nối với NNT qua các ứng dụng zalo, facebook …  chia sẽ các buổi livestream trực tuyến do ngành thuế tổ chức; các videos clip hướng dẫn cài đặt, sử dụng và sẳn sàng giải đáp các thắc mắc của NNT mọi lúc, mọi nơi giúp NNT mạnh dạn trao đổi và hiểu yên tâm sử dụng EtaxMobile một cách dễ dàng và hiệu quả.</p><p>Sưu tập những tập tin dạng sổ tay điện tử (ebook) về thuế, kế toán hay các văn bản Luật có liên quan đến các hoạt động SXKD từ các đơn vị hoạt động chuyên ngành có uy tín như Phòng Thương mại và Công nghiệp Việt Nam (VCCI); Cục Thuế tỉnh Quảng Ninh; Hội Kiểm toán viên hành nghề Việt Nam (VACPA) để gửi đến NNT…</p><p>- Tính mới của sáng kiến:</p><p>Khác với mô hình cũ chỉ dựa vào tuyên truyền truyền thống và hỗ trợ thủ công tại cấp xã, giải pháp mới xây dựng Trung tâm Hỗ trợ Người nộp thuế Kỹ thuật số địa phương tại Thuế cơ sở, tích hợp với Cổng thông tin điện tử Cục Thuế và ứng dụng địa phương. Sự khác biệt nổi bật là sử dụng AI và dữ liệu lớn (Big Data) của ngành, để phân tích tình huống, hành vi người nộp thuế để hỗ trợ những sai sót kịp thời. Góp phần quản lý thuế hiệu năng, hiệu lực, hiệu quả.</p><p>Để thực hiện tốt các nội dung nêu trên cũng như cập nhật đầy đủ, kịp thời chính sách thuế có liên quan đã được sửa đổi, bổ sung đến với NNT, nhất là đối với các DN thực hiện nộp thuế theo hình thức kê khai thuế. Hạn chế sai phạm dẫn đến thất thu NSNN mà không làm ảnh hưởng đến kết quả hoạt động SXKD bình thường của NNT. Nhóm tham gia viết Sáng kiến, đề xuất đến Ban Chi ủy, Người đứng đầu Thuế cơ sở đề ra một số giải pháp sau:</p><p>- Ban Lãnh đạo Thuế cơ sở chỉ đạo các bộ phận có liên quan (Tổ Nghiệp vụ - Dự toán - Pháp chế chủ trì) phối hợp biên soạn ngắn gọn một số nội dung quan trọng về chính sách thuế mới đã được sửa đổi, bổ sung; biên soạn lại những trường hợp các hành vi vi phạm qua việc kê khai thuế, nộp thuế, kiểm tra thuế,... Đặc biệt là việc tuyên truyền sử dụng hóa đơn điện tử khởi tạo từ máy tính tiền.</p><p>c. Hiệu quả và phạm vi áp dụng của sáng kiến, giải pháp:</p><p>Qua Đa dạng hoá các hình thức tuyên truyền hỗ trợ NNT bằng các ứng dụng qua mạng Internet NNT sẽ nâng cao nhận thức hơn và thực hiện đầy đủ, đúng nội dung quy định của pháp luật về kế toán. Phản ánh đúng, đủ và trung thực các số liệu kê khai và nộp kịp thời theo quy định;</p><p>Hạn chế được tình trạng suy bì, thắc mắc giữa DN này với DN khác, giữa hộ kinh doanh này với hộ kinh doanh khác về doanh thu cũng như số thuế phải nộp, nhất là các DN, hộ kinh doanh, kinh doanh cùng ngành nghề, địa bàn;</p><p>Tạo sự công bằng trong việc sản xuất kinh doanh cũng như sản xuất theo máy móc công nghệ có công suất lớn, tiêu thụ hàng nhanh, doanh thu cao thì nộp thuế nhiều và ngược lại máy móc công nghệ có công suất nhỏ, tiêu thụ hàng chậm, doanh thu thấp thì nộp thuế ít;</p><p>Làm cho nguồn thu ngân sách nhà nước tăng đáng kể mà công chức thuế không cần phải tốn nhiều thời gian để phân tích, giải thích, tuyên truyền về các văn bản hướng dẫn về việc kê khai doanh thu, số thuế phải nộp, cũng như gian lận, trốn thuế khi phát hiện sẽ chịu xử phạt theo quy định.</p><p>Nếu thực hiện đồng bộ các hình thức tuyên truyền hỗ trợ NNT bằng những ứng dụng phổ thông qua mạng Internet như đã nêu trên thì số thuế kê khai phải nộp chắc chắn sẽ tăng so với số thuế kê khai trước đây do NNT đã nắm bắt, cập nhật các thông tin có liên quan đến việc kê khai thuế đầy đủ, kịp thời, giảm thiểu tối đa những sai sót hạn chế mà các tài liệu tuyên truyền đã khuyến cáo, từ đó giảm thiểu tổn thất tài chính do bị xử phạt vi phạm hành chính về thuế, nâng cao mức độ tuân thủ về thuế, tăng số nộp NSNN.</p><p>Nhờ làm tốt công tác tuyên truyền mà kết quả công tác đăng ký sử dụng hóa đơn điện tử khởi tạo từ máy tính tiền của hộ kinh doanh theo Nghị định 70/2025/NĐ-CP. Tính đến ngày 31/8/2025 đơn vị có 373/373 hộ kinh doanh thuộc diện sử dụng hóa đơn điện tử khởi tạo từ máy tính tiền, đã đăng ký kết nối với Cơ quan Thuế đạt 100%. Ngoài ra công tác cài đặt EtaxMobile của Thuế cơ sở 7 đạt 100% và sô hộ nộp thuế đạt 95%.</p><p>* Đối tượng áp dụng: Tất cả các doanh nghiệp và hộ kinh doanh, cá nhân kinh doanh.</p><p>* Khả năng áp dụng, nhân rộng sáng kiến: Trong Thuế tỉnh.</p><p>* Phạm vi áp dụng: Trong  phạm vi Thuế tỉnh.</p><p>5. Hội đồng cơ sở đã xét công nhận sáng kiến: Quyết định số 1109/QĐ-CMA ngày 23/10/2025.</p><p>6. Thời gian áp dụng: Ngày 01/06/2025.</p>', '36a8f2fcc287bf9e3276acc398c224886e5b543bb816a060a13567be6cf782a1', '2026-09-22 20:19:07');
INSERT INTO `qlsk_file_noi_dung` (`id`, `file_id`, `sang_kien_id`, `noi_dung`, `noi_dung_html`, `hash_noi_dung`, `ngay_trich_xuat`) VALUES
(20, 36, 43, 'THUẾ TỈNH CÀ MAU CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM\nTHUẾ CƠ SỞ 7 TỈNH CÀ MAU Độc lập - Tự do - Hạnh phúc\nBÁO CÁO MÔ TẢ SÁNG KIẾN\n1. Tên sáng kiến: Những giải pháp chủ yếu tăng cường kỷ luật lao động và văn hóa công sở tại Thuế cơ sở\n2. Nhóm tác giải:\n3. Lĩnh vực áp dụng: Tổ chức, nhân sự; Vấn đề sáng kiến giải quyết: tăng cường kỷ luật lao động và văn hóa công sở tại Thuế cơ sở.\n4. Mô tả sáng kiến:\na. Khái quát đặc điểm, tình hình trước khi có sáng kiến:\nThời gian qua ngành Thuế đã tập trung triển khai mô hình tổ chức mới theo hướng tinh gọn, hiệu lực, hiệu quả; hoàn thiện chức năng, nhiệm vụ và cơ cấu tổ chức trong toàn ngành; tích cực chỉ đạo, triển khai, quán triệt thực hiện nhiều văn bản về tăng cường kỷ luật, kỷ cương, kỷ luật lao động, văn hóa công sở và trách nhiệm của công chức, viên chức trong thực thi công vụ. Nhằm xây dựng môi trường văn hóa công sở văn minh, lịch sự bảo đảm tính trang nghiêm và hiệu quả hoạt động của đơn vị nhằm hoàn thành xuất sắc nhiệm vụ được giao.\nTuy nhiên, thực tế vẫn còn một số hạn chế nhất định:\nVi phạm thời giờ làm việc, lãng phí thời gian làm việc “sáng cắp ô đi, tối cắp ô về; vẫn còn biểu hiện thiếu văn hóa nơi công sở khi thực thi công vụ, thái độ thờ ơ, vô cảm, thủ tục nhũng nhiễu, thiếu tôn trọng hoặc coi thường kết quả công việc của đồng nghiệp; dùng từ ngữ thiếu “tế nhị”; tạo khoản cách giữa cấp trên với cấp dưới, giữa đồng nghiệp với đồng nghiệp, hình thành “lợi ích nhóm”; phát sinh hiện tượng mất đoàn kết; việc giám sát công chức chưa được thường xuyên, thiếu kiểm tra đôn đốc nhắc nhỡ để chấn chỉnh kịp thời; từ đó làm giảm lòng tin với Nhân dân và với người nộp thuế, làm giảm hiệu lực, hiệu quả trong thực thi nhiệm vụ, ảnh hưởng xấu “hình ảnh của công chức” và của ngành Thuế.\nTừ những hiện trạng nói trên, với trách nhiệm của người công chức thuế trong giai đoạn hiện nay, với tinh thần trách nhiệm và bằng những kinh nghiệm thực tiễn trong công tác, xét thấy việc đề xuất giải pháp mới nhằm khắc phục nhược điểm đã qua là thật sự cần thiết.\nĐối với Thuế cơ sở thực hiện chức năng quản lý Nhà nước về thuế thuộc địa bàn quản lý, số lượng cán bộ, công chức tương đối nhiều. Phạm vi hoạt động gồm một thị xã và một huyện, số lượng người nộp thuế gần 4000 người, điều này đòi hỏi Thuế cơ sở phải có những cách làm mới đề nâng cao hiệu quả thực hiện kỷ luật lao động và văn hóa công sở là nhiệm vụ quan trọng và cấp bách. Xuất phát từ đó nhóm tác giả quyết định chọn đề tài “Những số giải pháp chủ yếu tăng cường kỷ luật lao động và văn hóa công sở tại Thuế cơ sở”. Qua đó xây dựng đội ngũ công chức thuế tuân thủ kỷ luật lao động và tác phong, lề lối làm việc chuyên nghiệp, văn minh công sở, hiện đại, gương mẫu trong việc chấp hành kỷ luật lao động và văn hóa công sở, nâng cao tinh thần trách nhiệm, giữ vững kỷ luật, kỷ cương trong thực thi công vụ.\nb. Nội dung sáng kiến:\nBước 1. Công tác tuyên truyền, giáo dục chính trị tư tưởng. Gồm 2 nội dung:\nThứ nhất, Tuyên truyền, giáo dục văn bản của cấp trên:\nQuyết định số 828/QĐ-BTC ngày 08 tháng 6 năm 2020 về việc ban hành Quy chế văn hóa công sở tại các đơn vị thuộc và trực thuộc bộ tài chính; Quyết định số 2181/QĐ-TCT ngày 27/12/2012 Tổng cục trưởng Tổng cục Thuế về việc Quy định Tiêu chuẩn văn hoá công sở và Đạo đức công chức, viên chức ngành Thuế; Quyết định số 443/QĐ-BTC ngày 14/3/2024 của Bộ Tài chính về kiểm tra việc chấp hành kỷ luật lao động và văn hóa công sở; Quyết định số 316/QĐ-TCT ngày 26/3/2024 của Tổng cục Thuế về kiểm tra nội bộ việc chấp hành kỷ luật lao động và văn hóa công sở; Công văn số 226/TCT-TCCB ngày 15/01/2025 của Tổng cục Thuế về việc tăng cường kỷ cương, kỷ luật trong triển khai công tác sắp xếp, tinh gọn bộ máy; Công văn số 176/CT-VP ngày 15/3/2025 của Cục Thuế về việc tiếp tục chấn chính, tăng cường kỷ cương, kỷ luật trong giải quyết thủ tục hành chính, văn bản của Bộ Tài chính; Công văn số 261/CT-TTKT ngày 21/3/2025 của Cục Thuế về việc chấn chỉnh kỷ luật, kỷ cương trong thực thi công vụ; Công văn số 2847/CT-VP ngày 31/7/2025 của Cục Thuế về việc nâng cao chất lượng sự phục vụ của cơ quan thuế đối với người nộp thuế.\nThứ hai, Tuyên truyền, giáo dục bằng hình thức trực quan: là phương pháp, hình thức tác động trực tiếp chủ yếu vào mắt con người, tạo nên ấn tượng về một vấn đề nhất định theo mục đích để người xem hiểu và làm theo. Theo đó mỗi Tổ treo một khẩu hiệu gắn với chức năng nhiệm vụ của Tổ đó (kèm theo Phụ lục số 01).\nBước 2: Giám sát quá trình thực thi nhiệm vụ. Gồm có 2 nội dung:\nThứ nhất, Giám sát việc chấp hành kỷ luật lao động và thực hiện văn hóa công sở:\n- Giám sát từng Tổ: Tổ trưởng chịu trách nhiệm\n- Giám sát toàn đơn vị: Tổ trưởng Tổ Nghiệp vụ, dự toán, pháp chế (Bao gồm: Tổ Hành chính, tổng hợp và Tổ Nghiệp vụ, dự toán, pháp chế) chịu trách nhiệm giám sát chung toàn đơn vị và tổng hợp các báo cáo của các Tổ. Giám sát công chức, viên chức thực hiện giờ công, ngày công và văn hóa công sở có đúng quy định không. Đồng thời tổng hợp báo cáo cho Trưởng Thuế cơ sở vào ngày họp báo đầu tháng sau.\nThứ hai, Tiếp nhận thông tin và xử lý thông tin trong quá trình thực thi công vụ: Công việc này do tập thể lãnh đạo đơn vị; Tổ trưởng Tổ Nghiệp vụ, dự toán, pháp chế và lãnh Tổ Quản lý, hỗ trợ doanh nghiệp phụ trách kiểm tra nội bộ thực hiện:\n* Tiếp nhận thông tin:\n- Nắm chính xác nguồn thông tin để khai thác, thu thập, cung cấp hợp lý, đúng lúc, đúng mục đích, phù hợp với quy định của pháp luật;\n- Trong quá trình giao tiếp với người nộp thuế có vi phạm kỷ cương, kỷ luật, đạo đức công vụ, văn hóa ứng xử không.\n- Tiếp nhận thông tin đa chiều: Từ người nộp thuế, từ phương tiện thông tin đại chúng, từ các ban ngành có liên quan, từ nội bộ đơn vị…\n* Phân tích thông tin:\n- Phân loại thông tin thành: thông tin chính và thông tin hỗ trợ; thông tin có giá trị, ít giá trị hoặc không có giá trị; phải loại bỏ hoặc nghi ngờ những thông tin thiếu căn cứ, thiếu cơ sở khoa học.\n- Tiến hành so sánh, đối chiếu để kiểm tra tính chính xác, tính khoa học, hợp lý của thông tin, nhằm mục đích xác định rõ những thông tin nào đáng tin và thông tin nào không đáng tin. Qua đó phát hiện những điều bất hợp lý, mâu thuẫn, phi logic trong nội dung thông tin.\n* Tổng hợp thông tin: Sắp xếp các thông tin và số liệu đã được kiểm tra, xác minh, phân tích, chọn lọc và phân theo thẩm quyền để giải quyết vấn đề:\n- Thông tin thuộc thẩm quyền giải quyết của Phó Trưởng thuế phụ trách các Tổ và bộ phận;\n- Thông tin thuộc thẩm quyền giải quyết của Trưởng Thuế và thông tin phải kiểm tra nội.\nBước 3: Nhận xét đánh giá và quyết định vấn đề:\nThủ trưởng đơn vị thực hiện:\n- Từ các nguồn dữ liệu, cứ liệu đã được cung cấp, lựa chọn những thông tin chủ yếu cần giải quyết để xử lý trước và sau đó đến các vấn đề khác.\n- Đối với những Tổ và bộ phận có nhiều cá nhân vi phạm kỷ luật lao động và văn hóa công sở (nhưng chưa đến mức phải có hình thức kỷ luật) thì trực tiếp tham dự cuộc họp vào đầu tháng sau, hoặc dự họp hàng tuần (nếu có những vấn đề cấp thiết) để tập thể nhận xét, đánh giá và mức độ vi phạm từng cá nhân, gồm có mức độ vi phạm như sau:\nMột là, trường hợp vi phạm lần đầu, thì Phó Trưởng thuế phụ trách các Tổ và bộ phận họp kiểm điểm khắc phục, sửa chữa;\nHai là, Trường hợp vi phạm lần thứ hai trở đi thì ban hành công văn nhắc nhỡ chung trong toàn đơn vị.\n- Những trường hợp qua quá trình giám ở bước 2 hoặc phản ánh bằng văn bản thì chỉ đạo cho đồng chí cấp phó, phụ trách Bộ phận kiểm tra nội bộ, thực hiện kiểm tra theo quy trình hoặc kiểm tra đột xuất. Đặc biệt những Tổ và bộ phận có nhiều cá nhân vi phạm thì họp kiểm điểm trách nhiệm người đứng đầu.\nSau đó, nếu các cá nhân vi phạm không khắc phục, sửa chữa thì ngày đầu tháng của quý sau, Hội đồng Thi đua – Khen thưởng kết hợp vào kết quả đạt được trong quý và Bảng tự chấm điểm, tiến hành nhận xét đánh giá và viết bản kiểm điểm và cam kết sẽ khắc phục những hạn chế, yếu kém.\n- Những trường hợp có ý kiến phản ánh bằng văn bản của người nộp thuế sau khi có kết quả kiểm tra nội bộ, báo cáo cấp trên xử lý kịp thời, nghiêm khắc các trường hợp vi phạm để răn đe, làm gương. Đồng thời, tổng hợp lưu trữ, làm cơ sở đánh giá cán bộ, công chức cuối năm, cũng như công tác luân phiên, điều động cán bộ.\n* Tính mới của sáng kiến:\n- Tuyên truyền hình thức trực quan. Phương pháp tuyên truyền trực quan có sức thuyết phục, lôi cuốn mạnh mẽ đến cán bộ, công chức và người dân, gắn kết giữa công tác tuyên truyền và triển khai thực hiện.\n- Lãnh đạo đơn vị giám sát chặt chẽ quá trình thực hiện kỷ luật lao động và văn hóa công sở, cũng như nắm bắt thông tin đa chiều trong quá trình thực thi công vụ của cán bộ, công chức. Nếu một đơn vị làm tốt công tác giám sát, kiểm tra thường xuyên hoặc đột xuất và thực hiện giải pháp khép kín từ khâu tuyên truyền, giáo dục đến kiểm tra giáp sát và xử lý thì công chức sẽ “khép mình vào khuôn khổ pháp luật” chấp hành kỷ luật lao động và văn hóa công sở, nâng cao tinh thần trách nhiệm, giữ vững kỷ luật, kỷ cương trong thực thi công vụ và hoàn thành tốt nhiệm vụ được giao.\n- Công chức sử dụng hết quỹ thời gian theo quy định, không còn thời gian nhàn rỗi và phối hợp chặt chẽ giữa các cá nhân và các tập thể trong đơn vị, “làm hết giờ” sang “làm hết việc; gắn trách nhiệm với chế độ khen thưởng, kỷ luật đối với công chức trong hoạt động thực thi công vụ. Cũng như trách nhiệm của người đứng đầu.\nHiệu quả và phạm vi áp dụng của sáng kiến, giải pháp:\n* Về hiệu quả kinh tế xã hội:\nXây dựng hệ thống thuế Việt Nam “tinh - gọn - mạnh - hiệu năng - hiệu lực - hiệu quả” thực hiện đúng phương châm “Lấy người nộp thuế làm trung tâm phục vụ” với mục tiêu ngày càng nâng cao chất lượng công tác quản lý thuế; đảm bảo cơ cấu tổ chức mới vận hành thông suốt, ổn định; phục vụ, giải quyết các TTHC thuế cho cộng đồng doanh nghiệp và người dân kịp thời, nhanh chóng và hiệu quả, tạo không gian, môi trường làm việc khoa học, văn minh.\nGóp phần cùng địa phương phát triển kinh kinh tế, xã hội, thể hiện qua kết quả thu ngân sách 7 tháng năm 2024 là 117 tỷ 852/224 tỷ , đạt 52,61%, và 7 tháng đầu năm 2025 thu toàn đơn vị là 128 tỷ 710/224 tỷ, đạt 57,5% dự toán năm.\n* Hiệu quả từ việc xây dựng bộ máy:\nGiúp cho lãnh đạo đơn vị xây dựng bộ máy trong sạch, vững mạnh, hoạt động hiệu quả, vận hành đồng bộ và kiểm soát trách nhiệm, nâng cao hiệu quả công tác và giữ nghiêm kỷ luật, kỷ cương trong thực thi công vụ, nêu cao trách nhiệm của người đứng đầu và nhiệm vụ chính trị của Ngành trong thời gian tới;\nCông chức chấp hành tốt quy chế văn minh công sở và đạo đức cán bộ Thuế, thực hiện tốt nội quy, quy chế làm việc của ngành; không vi phạm kỷ luật lao động và văn hóa công sở; trong thực hiện nhiệm vụ: Không trốn tránh, không thoái thác, không áp đặt, không bè phái; Biết lắng nghe, biết hướng dẫn, biết giúp đỡ, biết cảm ơn, biết xin lỗi; trong giao tiếp với tổ chức, cá nhân người nộp thuế: Xin chào, xin lỗi, xin cảm ơn, xin phép; Luôn mỉm cười, luôn nhẹ nhàng, luôn lắng nghe, luôn giúp đỡ... Qua đó, Tạo động lực cho cán bộ, công chức thuế có trách nhiệm, quyết tâm với công việc; sẵn sàng công tâm giúp đỡ người nộp thuế, để xứng đáng với khẩu hiệu “Minh bạch - Chuyên nghiệp - Liêm chính - Đổi mới”.\nLàm thước đo sự văn minh của mỗi cán bộ, công chức hay nói khác đi chính là sự phản ánh nhận thức của mỗi cá nhân trong môi trường làm việc nơi công sở và xây dựng môi trường làm việc hiện đại, chuyên nghiệp, thân thiện và hiệu quả. Ứng xử có văn hóa nơi công sở mang lại rất nhiều lợi ích góp phần tạo dựng niềm tin, sự đoàn kết, thống nhất của tập thể, từ đó tạo bầu không khí làm việc cởi mở, tích cực, nâng cao chất lượng và hiệu quả công việc.\n* Khả năng nhân rộng: Sáng kiến này có thể áp dụng cho nhiều năm tiếp theo nhằm nâng cao tinh thần trách nhiệm, chấp hành nghiêm kỷ cương, kỷ luật lao động và văn hóa công sở của công chức trong thực thi chức trách nhiệm vụ được giao trong phạm vi Thuế tỉnh.\n* Phạm vi áp dụng: Trong phạm vi Thuế tỉnh\n5. Hội đồng cơ sở đã xét công nhận sáng kiến: Quyết định số 1109/QĐ-CMA ngày 23/10/2025.\n6. Thời gian áp dụng: Ngày 01/3/2025', '<p>THUẾ TỈNH CÀ MAU            CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM</p><p>THUẾ CƠ SỞ 7 TỈNH CÀ MAU                   Độc lập - Tự do - Hạnh phúc</p><p>BÁO CÁO MÔ TẢ SÁNG KIẾN</p><p>1. Tên sáng kiến: Những giải pháp chủ yếu tăng cường kỷ luật lao động và văn hóa công sở tại Thuế cơ sở</p><p>2. Nhóm tác giải:</p><p>3. Lĩnh vực áp dụng: Tổ chức, nhân sự; Vấn đề sáng kiến giải quyết: tăng cường kỷ luật lao động và văn hóa công sở tại Thuế cơ sở.</p><p>4. Mô tả sáng kiến:</p><p>a. Khái quát đặc điểm, tình hình trước khi có sáng kiến:</p><p>Thời gian qua ngành Thuế đã tập trung triển khai mô hình tổ chức mới theo hướng tinh gọn, hiệu lực, hiệu quả; hoàn thiện chức năng, nhiệm vụ và cơ cấu tổ chức trong toàn ngành; tích cực chỉ đạo, triển khai, quán triệt thực hiện nhiều văn bản về tăng cường kỷ luật, kỷ cương, kỷ luật lao động, văn hóa công sở và trách nhiệm của công chức, viên chức trong thực thi công vụ. Nhằm xây dựng môi trường văn hóa công sở văn minh, lịch sự bảo đảm tính trang nghiêm và hiệu quả hoạt động của đơn vị nhằm hoàn thành xuất sắc nhiệm vụ được giao.</p><p>Tuy nhiên, thực tế vẫn còn một số hạn chế nhất định:</p><p>Vi phạm thời giờ làm việc, lãng phí thời gian làm việc “sáng cắp ô đi, tối cắp ô về; vẫn còn biểu hiện thiếu văn hóa nơi công sở khi thực thi công vụ, thái độ thờ ơ, vô cảm, thủ tục nhũng nhiễu, thiếu tôn trọng hoặc coi thường kết quả công việc của đồng nghiệp; dùng từ ngữ thiếu “tế nhị”; tạo khoản cách giữa cấp trên với cấp dưới, giữa đồng nghiệp với đồng nghiệp, hình thành “lợi ích nhóm”; phát sinh hiện tượng mất đoàn kết; việc giám sát công chức chưa được thường xuyên, thiếu kiểm tra đôn đốc nhắc nhỡ để chấn chỉnh kịp thời; từ đó làm giảm lòng tin với Nhân dân và với người nộp thuế, làm giảm hiệu lực, hiệu quả trong thực thi nhiệm vụ, ảnh hưởng xấu “hình ảnh của công chức” và của ngành Thuế.</p><p>Từ những hiện trạng nói trên, với trách nhiệm của người công chức thuế trong giai đoạn hiện nay, với tinh thần trách nhiệm và bằng những kinh nghiệm thực tiễn trong công tác, xét thấy việc đề xuất giải pháp mới nhằm khắc phục nhược điểm đã qua là thật sự cần thiết.</p><p>Đối với Thuế cơ sở thực hiện chức năng quản lý Nhà nước về thuế thuộc địa bàn quản lý, số lượng cán bộ, công chức tương đối nhiều. Phạm vi hoạt động gồm một thị xã và một huyện, số lượng người nộp thuế gần 4000 người, điều này đòi hỏi Thuế cơ sở phải có những cách làm mới đề nâng cao hiệu quả thực hiện kỷ luật lao động và văn hóa công sở là nhiệm vụ quan trọng và cấp bách. Xuất phát từ đó nhóm tác giả quyết định chọn đề tài “Những số giải pháp chủ yếu tăng cường kỷ luật lao động và văn hóa công sở tại Thuế cơ sở”. Qua đó xây dựng đội ngũ công chức thuế tuân thủ kỷ luật lao động và tác phong, lề lối làm việc chuyên nghiệp, văn minh công sở, hiện đại, gương mẫu trong việc chấp hành kỷ luật lao động và văn hóa công sở, nâng cao tinh thần trách nhiệm, giữ vững kỷ luật, kỷ cương trong thực thi công vụ.</p><p>b. Nội dung sáng kiến:</p><p>Bước 1. Công tác tuyên truyền, giáo dục chính trị tư tưởng. Gồm 2 nội dung:</p><p>Thứ nhất, Tuyên truyền, giáo dục văn bản của cấp trên:</p><p>Quyết định số 828/QĐ-BTC ngày 08 tháng 6 năm 2020 về việc ban hành Quy chế văn hóa công sở tại các đơn vị thuộc và trực thuộc bộ tài chính; Quyết định số 2181/QĐ-TCT ngày 27/12/2012 Tổng cục trưởng Tổng cục Thuế về việc Quy định Tiêu chuẩn văn hoá công sở và Đạo đức công chức, viên chức ngành Thuế; Quyết định số 443/QĐ-BTC ngày 14/3/2024 của Bộ Tài chính về kiểm tra việc chấp hành kỷ luật lao động và văn hóa công sở; Quyết định số 316/QĐ-TCT ngày 26/3/2024 của Tổng cục Thuế về kiểm tra nội bộ việc chấp hành kỷ luật lao động và văn hóa công sở; Công văn số 226/TCT-TCCB ngày 15/01/2025 của Tổng cục Thuế về việc tăng cường kỷ cương, kỷ luật trong triển khai công tác sắp xếp, tinh gọn bộ máy; Công văn số 176/CT-VP ngày 15/3/2025 của Cục Thuế về việc tiếp tục chấn chính, tăng cường kỷ cương, kỷ luật trong giải quyết thủ tục hành chính, văn bản của Bộ Tài chính; Công văn số 261/CT-TTKT ngày 21/3/2025 của Cục Thuế về việc chấn chỉnh kỷ luật, kỷ cương trong thực thi công vụ; Công văn số 2847/CT-VP ngày 31/7/2025 của Cục Thuế về việc nâng cao chất lượng sự phục vụ của cơ quan thuế đối với người nộp thuế.</p><p>Thứ hai, Tuyên truyền, giáo dục bằng hình thức trực quan: là phương pháp, hình thức tác động trực tiếp chủ yếu vào mắt con người, tạo nên ấn tượng về một vấn đề nhất định theo mục đích để người xem hiểu và làm theo. Theo đó mỗi Tổ treo một khẩu hiệu gắn với chức năng nhiệm vụ của Tổ đó (kèm theo Phụ lục số 01).</p><p>Bước 2: Giám sát quá trình thực thi nhiệm vụ. Gồm có 2 nội dung:</p><p>Thứ nhất, Giám sát việc chấp hành kỷ luật lao động và thực hiện văn hóa công sở:</p><p>- Giám sát từng Tổ: Tổ trưởng chịu trách nhiệm</p><p>- Giám sát toàn đơn vị: Tổ trưởng Tổ Nghiệp vụ, dự toán, pháp chế (Bao gồm: Tổ Hành chính, tổng hợp và Tổ Nghiệp vụ, dự toán, pháp chế) chịu trách nhiệm giám sát chung toàn đơn vị và tổng hợp các báo cáo của các Tổ. Giám sát công chức, viên chức thực hiện giờ công, ngày công và văn hóa công sở có đúng quy định không. Đồng thời tổng hợp báo cáo cho Trưởng Thuế cơ sở vào ngày họp báo đầu tháng sau.</p><p>Thứ hai, Tiếp nhận thông tin và xử lý thông tin trong quá trình thực thi công vụ: Công việc này do tập thể lãnh đạo đơn vị; Tổ trưởng Tổ Nghiệp vụ, dự toán, pháp chế và lãnh Tổ Quản lý, hỗ trợ doanh nghiệp phụ trách kiểm tra nội bộ thực hiện:</p><p>* Tiếp nhận thông tin:</p><p>- Nắm chính xác nguồn thông tin để khai thác, thu thập, cung cấp hợp lý, đúng lúc, đúng mục đích, phù hợp với quy định của pháp luật;</p><p>- Trong quá trình giao tiếp với người nộp thuế có vi phạm kỷ cương, kỷ luật, đạo đức công vụ, văn hóa ứng xử không.</p><p>- Tiếp nhận thông tin đa chiều: Từ người nộp thuế, từ phương tiện thông tin đại chúng, từ các ban ngành có liên quan, từ nội bộ đơn vị…</p><p>* Phân tích thông tin:</p><p>- Phân loại thông tin thành: thông tin chính và thông tin hỗ trợ; thông tin có giá trị, ít giá trị hoặc không có giá trị; phải loại bỏ hoặc nghi ngờ những thông tin thiếu căn cứ, thiếu cơ sở khoa học.</p><p>- Tiến hành so sánh, đối chiếu để kiểm tra tính chính xác, tính khoa học, hợp lý của thông tin, nhằm mục đích xác định rõ những thông tin nào đáng tin và thông tin nào không đáng tin. Qua đó phát hiện những điều bất hợp lý, mâu thuẫn, phi logic trong nội dung thông tin.</p><p>* Tổng hợp thông tin: Sắp xếp các thông tin và số liệu đã được kiểm tra, xác minh, phân tích, chọn lọc và phân theo thẩm quyền để giải quyết vấn đề:</p><p>- Thông tin thuộc thẩm quyền giải quyết của Phó Trưởng thuế phụ trách các Tổ và bộ phận;</p><p>- Thông tin thuộc thẩm quyền giải quyết của Trưởng Thuế và thông tin phải kiểm tra nội.</p><p>Bước 3: Nhận xét đánh giá và quyết định vấn đề:</p><p>Thủ trưởng đơn vị thực hiện:</p><p>- Từ các nguồn dữ liệu, cứ liệu đã được cung cấp, lựa chọn những thông tin chủ yếu cần giải quyết để xử lý trước và sau đó đến các vấn đề khác.</p><p>- Đối với những Tổ và bộ phận có nhiều cá nhân vi phạm kỷ luật lao động và văn hóa công sở (nhưng chưa đến mức phải có hình thức kỷ luật) thì trực tiếp tham dự cuộc họp vào đầu tháng sau, hoặc dự họp hàng tuần (nếu có những vấn đề cấp thiết) để tập thể nhận xét, đánh giá và mức độ vi phạm từng cá nhân, gồm có mức độ vi phạm như sau:</p><p>Một là, trường hợp vi phạm lần đầu, thì Phó Trưởng thuế phụ trách các Tổ và bộ phận họp kiểm điểm khắc phục, sửa chữa;</p><p>Hai là, Trường hợp vi phạm lần thứ hai trở đi thì ban hành công văn nhắc nhỡ chung trong toàn đơn vị.</p><p>- Những trường hợp qua quá trình giám ở bước 2 hoặc phản ánh bằng văn bản thì chỉ đạo cho đồng chí cấp phó, phụ trách Bộ phận kiểm tra nội bộ, thực hiện kiểm tra theo quy trình hoặc kiểm tra đột xuất. Đặc biệt những Tổ và bộ phận có nhiều cá nhân vi phạm thì họp kiểm điểm trách nhiệm người đứng đầu.</p><p>Sau đó, nếu các cá nhân vi phạm không khắc phục, sửa chữa thì ngày đầu tháng của quý sau, Hội đồng Thi đua – Khen thưởng kết hợp vào kết quả đạt được trong quý và Bảng tự chấm điểm, tiến hành nhận xét đánh giá và viết bản kiểm điểm và cam kết sẽ khắc phục những hạn chế, yếu kém.</p><p>- Những trường hợp có ý kiến phản ánh bằng văn bản của người nộp thuế sau khi có kết quả kiểm tra nội bộ, báo cáo cấp trên xử lý kịp thời, nghiêm khắc các trường hợp vi phạm để răn đe, làm gương. Đồng thời, tổng hợp lưu trữ, làm cơ sở đánh giá cán bộ, công chức cuối năm, cũng như công tác luân phiên, điều động cán bộ.</p><p>* Tính mới của sáng kiến:</p><p>- Tuyên truyền hình thức trực quan. Phương pháp tuyên truyền trực quan có sức thuyết phục, lôi cuốn mạnh mẽ đến cán bộ, công chức và người dân, gắn kết giữa công tác tuyên truyền và triển khai thực hiện.</p><p>- Lãnh đạo đơn vị giám sát chặt chẽ quá trình thực hiện kỷ luật lao động và văn hóa công sở, cũng như nắm bắt thông tin đa chiều trong quá trình thực thi công vụ của cán bộ, công chức. Nếu một đơn vị làm tốt công tác giám sát, kiểm tra thường xuyên hoặc đột xuất và thực hiện giải pháp khép kín từ khâu tuyên truyền, giáo dục đến kiểm tra giáp sát và xử lý thì công chức sẽ “khép mình vào khuôn khổ pháp luật” chấp hành kỷ luật lao động và văn hóa công sở, nâng cao tinh thần trách nhiệm, giữ vững kỷ luật, kỷ cương trong thực thi công vụ và hoàn thành tốt nhiệm vụ được giao.</p><p>- Công chức sử dụng hết quỹ thời gian theo quy định, không còn thời gian nhàn rỗi và phối hợp chặt chẽ giữa các cá nhân và các tập thể trong đơn vị, “làm hết giờ” sang “làm hết việc; gắn trách nhiệm với chế độ khen thưởng, kỷ luật đối với công chức trong hoạt động thực thi công vụ. Cũng như trách nhiệm của người đứng đầu.</p><p>Hiệu quả và phạm vi áp dụng của sáng kiến, giải pháp:</p><p>* Về hiệu quả kinh tế xã hội:</p><p>Xây dựng hệ thống thuế Việt Nam “tinh - gọn - mạnh - hiệu năng - hiệu lực - hiệu quả” thực hiện đúng phương châm “Lấy người nộp thuế làm trung tâm phục vụ” với mục tiêu ngày càng nâng cao chất lượng công tác quản lý thuế; đảm bảo cơ cấu tổ chức mới vận hành thông suốt, ổn định; phục vụ, giải quyết các TTHC thuế cho cộng đồng doanh nghiệp và người dân kịp thời, nhanh chóng và hiệu quả, tạo không gian, môi trường làm việc khoa học, văn minh.</p><p>Góp phần cùng địa phương phát triển kinh kinh tế, xã hội, thể hiện qua kết quả thu ngân sách 7 tháng năm 2024 là 117 tỷ 852/224 tỷ , đạt 52,61%, và 7 tháng đầu năm 2025 thu toàn đơn vị là 128 tỷ 710/224 tỷ, đạt 57,5% dự toán năm.</p><p>* Hiệu quả từ việc xây dựng bộ máy:</p><p>Giúp cho lãnh đạo đơn vị xây dựng bộ máy trong sạch, vững mạnh, hoạt động hiệu quả, vận hành đồng bộ và kiểm soát trách nhiệm, nâng cao hiệu quả công tác và giữ nghiêm kỷ luật, kỷ cương trong thực thi công vụ, nêu cao trách nhiệm của người đứng đầu và nhiệm vụ chính trị của Ngành trong thời gian tới;</p><p>Công chức chấp hành tốt quy chế văn minh công sở và đạo đức cán bộ Thuế, thực hiện tốt nội quy, quy chế làm việc của ngành; không vi phạm kỷ luật lao động và văn hóa công sở; trong thực hiện nhiệm vụ: Không trốn tránh, không thoái thác, không áp đặt, không bè phái; Biết lắng nghe, biết hướng dẫn, biết giúp đỡ, biết cảm ơn, biết xin lỗi; trong giao tiếp với tổ chức, cá nhân người nộp thuế: Xin chào, xin lỗi, xin cảm ơn, xin phép; Luôn mỉm cười, luôn nhẹ nhàng, luôn lắng nghe, luôn giúp đỡ... Qua đó, Tạo động lực cho cán bộ, công chức thuế có trách nhiệm, quyết tâm với công việc; sẵn sàng công tâm giúp đỡ người nộp thuế, để xứng đáng với khẩu hiệu “Minh bạch - Chuyên nghiệp - Liêm chính - Đổi mới”.</p><p>Làm thước đo sự văn minh của mỗi cán bộ, công chức hay nói khác đi chính là sự phản ánh nhận thức của mỗi cá nhân trong môi trường làm việc nơi công sở và xây dựng môi trường làm việc hiện đại, chuyên nghiệp, thân thiện và hiệu quả. Ứng xử có văn hóa nơi công sở mang lại rất nhiều lợi ích góp phần tạo dựng niềm tin, sự đoàn kết, thống nhất của tập thể, từ đó tạo bầu không khí làm việc cởi mở, tích cực, nâng cao chất lượng và hiệu quả công việc.</p><p>* Khả năng nhân rộng: Sáng kiến này có thể áp dụng cho nhiều năm tiếp theo nhằm nâng cao tinh thần trách nhiệm, chấp hành nghiêm kỷ cương, kỷ luật lao động và văn hóa công sở của công chức trong thực thi chức trách nhiệm vụ được giao trong phạm vi Thuế tỉnh.</p><p>* Phạm vi áp dụng: Trong phạm vi Thuế tỉnh</p><p>5. Hội đồng cơ sở đã xét công nhận sáng kiến: Quyết định số 1109/QĐ-CMA ngày 23/10/2025.</p><p>6. Thời gian áp dụng: Ngày 01/3/2025</p>', '781e8508428850c55d754eac401b3f7481d515e2711832e59a755f110ef7e13c', '2026-09-22 22:32:00'),
(21, 37, 44, 'BÁO CÁO MÔ TẢ SÁNG KIẾN\n1. Tên sáng kiến: Tăng cường giám sát, quản lý đối với doanh nghiệp mới thành lập khi thực hiện đăng ký sử dụng hóa đơn điện tử, nhằm ngăn chặn kịp thời hành vi mua bán hóa đơn bất hợp pháp.\n2. Nhóm tác giả:\n3. Lĩnh vực áp dụng:\nKiểm tra thuế nhằm nâng cao chất lượng công tác quản lý doanh nghiệp mới phát sinh khi đăng ký sử dụng hóa đơn điện tử.\n4. Mô tả sáng kiến\na. Khái quát đặc điểm, tình hình trước khi có sáng kiến\n* Đặc điểm, tình hình trước khi có sáng kiến:\nVới xu thế chuyển đổi số phát triển mạnh như hiện nay, việc triển khai hóa đơn điện tử thay thế cho hóa đơn giấy đã mang lại nhiều lợi ích thiết thực: Giảm được các rủi ro do mất mát hóa đơn, tăng tính an toàn, bảo mật, tiện lợi cho doanh nghiệp trong kiểm tra truy xuất nguồn gốc hóa đơn, thông tin, độ an toàn, chính xác cao, hóa đơn có mã xác thực của cơ quan thuế. Bên cạnh đó còn nhiều tiện ích khác như: Phát hành đồng thời số lượng lớn hóa đơn, không tốn không gian lưu trữ để bảo quản hóa đơn, giảm chi phí in ấn, vận chuyển, nhân lực, dễ dàng tra cứu thông tin, không sợ thất lạc hóa đơn, ký phát hành hóa đơn với chữ ký số tiện lợi và nhanh chóng, hạn chế tình trạng bị phạt hành chính do tình trạng hỏng hay mất hóa đơn. Ứng dụng công nghệ thông tin trong hóa đơn điện tử là giải pháp quan trọng đối với công tác quản lý thuế trong thời kỳ hiện nay.\nTuy nhiên, cùng với sự phát triển và tính ưu việt của hóa đơn điện tử là tình trạng gian lận, mua bán hóa đơn điện tử, một số cá nhân vì lợi ích kinh tế đã thành lập nên các doanh nghiệp nhưng không hoạt động kinh doanh mà thành lập để mua bán hóa đơn, các đối tượng này thành lập nhiều công ty nhưng không đứng tên người đại diện pháp luật mà lấy giấy chứng minh nhân dân của người khác để đứng tên (Có trường hợp là chứng minh nhân dân của người bị mất giấy tờ, cá nhân đã chết, mất tích) và khi làm thủ tục để cấp giấy chứng nhận đăng ký kinh doanh sẽ không trực tiếp làm giấy tờ mà thông qua cá nhân làm dịch vụ để cấp giấy phép. Đồng thời với chính sách thông thoáng trong việc đăng ký thành lập doanh nghiệp, giảm bớt thủ tục hành chính, việc đăng ký thành lập doanh nghiệp được thực hiện theo phương thức điện tử. Do đó, một số cá nhân lợi dụng chính sách thông thoáng này để thành lập doanh nghiệp để mua bán hóa đơn khống với mục đích cuối cùng là chiếm dụng tiền hoàn thuế giá trị gia tăng, hợp thức hóa chi phí, trốn thuế, gây thất thoát cho ngân sách nhà nước.\n* Sự cần thiết, mục đích của việc thực hiện sáng kiến:\nTuy nhiên, cùng với sự phát triển và tính ưu việt của hóa đơn điện tử là tình trạng gian lận, mua bán hóa đơn điện tử, một số cá nhân vì lợi ích kinh tế đã thành lập nên các doanh nghiệp nhưng không hoạt động kinh doanh mà thành lập để mua bán hóa đơn, các đối tượng này thành lập nhiều công ty nhưng không đứng tên người đại diện pháp luật mà lấy giấy chứng minh nhân dân của người khác để đứng tên (Có trường hợp là chứng minh nhân dân của người bị mất giấy tờ, cá nhân đã chết, mất tích) và khi làm thủ tục để cấp giấy chứng nhận đăng ký kinh doanh sẽ không trực tiếp làm giấy tờ mà thông qua cá nhân làm dịch vụ để cấp giấy phép. Đồng thời với chính sách thông thoáng trong việc đăng ký thành lập doanh nghiệp, giảm bớt thủ tục hành chính, việc đăng ký thành lập doanh nghiệp được thực hiện theo phương thức điện tử. Do đó, một số cá nhân lợi dụng chính sách thông thoáng này để thành lập doanh nghiệp để mua bán hóa đơn khống với mục đích cuối cùng là chiếm dụng tiền hoàn thuế giá trị gia tăng, hợp thức hóa chi phí, trốn thuế, gây thất thoát cho ngân sách nhà nước.\nb. Nội dung sáng kiến\nThực hiện nhiệm vụ được giao Tổ quản lý, hỗ trợ doanh nghiệp đã tham mưu, đề xuất Lãnh đạo cơ quan đẩy mạnh công tác phối hợp giữa các bộ phận trong đơn vị, đồng thời phân công 4 công chức chia làm 02 nhóm để thực hiện công tác xác minh địa điểm kinh doanh khi doanh nghiệp đăng ký sử dụng hóa đơn điện tử, để đảm bảo kịp thời phê duyệt cho doanh nghiệp, vì thời gian phê duyệt chỉ có 01 ngày làm việc.\nTheo đó, ngay sau khi tiếp nhận thông tin từ Sở Kế hoạch và Đầu tư chuyển về những doanh nghiệp thành lập mới. Tổ Quản lý, hỗ trợ doanh nghiệp phân công từng công chức quản lý trực tiếp doanh nghiệp thực hiện rà soát đánh giá mức độ rủi ro để theo dõi quản lý về việc hoạt động, phát hành và sử dụng hóa đơn, nhất là đối với những doanh nghiệp có người đại diện pháp luật không phải là người địa phương, đăng ký thường trú ở địa phương khác, có địa chỉ xa so với địa bàn cơ quan thuế quản lý hoặc đã là người đại diện theo pháp luật của doanh nghiệp đã ngừng hoạt động. Khi doanh nghiệp gửi thông báo đăng ký sử dụng hóa đơn điện tử (HĐĐT) thì công chức quản lý doanh nghiệp sẽ liên hệ với người nộp thuế theo số điện thoại đã đăng ký trên hệ thống quản lý thuế TMS, HĐĐT để xác minh thông tin bước đầu, sau đó sẽ tiến hành xác minh thực tế tại địa chỉ đăng ký về tình hình hoạt động kinh doanh, thông tin về trụ sở, tài sản cố định, hàng hóa, lĩnh vực hoạt động, điều kiện kinh doanh,…. Từ đó, cơ quan thuế sẽ có đầy đủ thông tin về doanh nghiệp, nhất là thông tin về người đại diện pháp luật, giấy tờ tùy thân của người đại diện pháp luật dùng để sử dụng cho việc thành lập doanh nghiệp. Nếu qua xác minh doanh nghiệp không đáp ứng đủ điều kiện thì nhóm xác minh báo cáo lãnh đạo tạm thời không chấp nhận phê duyệt sử dụng hóa đơn điện tử cho doanh nghiệp hoặc qua xác minh trụ sở người nộp thuế, tổ công tác không tìm thấy trụ sở người nộp thuế, tham mưu lãnh đạo Thuế cơ sở ban hành Thông báo về việc người nộp thuế không hoạt động tại địa chỉ đã đăng ký, chuyển tin báo vụ việc về thuế sang cơ quan điều tra để xử lý theo quy định, đồng thời ban hành công văn cảnh báo doanh nghiệp có dấu hiệu rủi ro cao về thuế và hóa đơn đến các Cơ quan thuế khác để xử lý theo quy định.\nBên canh đó, đối với các doanh nghiệp đã được chấp nhận cho sử dụng hóa đơn điện tử thì phân công công chức quản lý doanh nghiệp hàng ngày phải vào ứng dụng hóa đơn điện tử để rà soát việc xuất hóa đơn có thuộc diện cảnh báo rủi ro hay không, từ đó đề nghị doanh nghiệp giải trình kịp thời về việc xuất hóa đơn của doanh nghiệp.\n* Tính mới của sáng kiến:\nSáng kiến được áp dụng lần đầu tại đơn vị, nhằm tiếp cận sớm đối tượng rủi ro thay vì chỉ kiểm tra, xử lý khi doanh nghiệp đã có hành vi vi phạm, sáng kiến tập trung ngay từ khâu đăng ký sử dụng hóa đơn điện tử của doanh nghiệp mới thành lập, thay gì hậu kiểm như trước đây chuyển từ “phát hiện và xử lý” sang “ngăn chặn, phòng ngừa”, giảm thiểu khả năng hình thành các đường dây mua bán hóa đơn bất hợp pháp.\nKết hợp dữ liệu từ hệ thống đăng ký thuế, đăng ký kinh doanh, cơ sở dữ liệu quốc gia để phân loại, cảnh báo sớm các doanh nghiệp có dấu hiệu rủi ro trong sử dụng hóa đơn điện tử.\n* Tính thực tiễn của sáng kiến:\nTình trạng thành lập doanh nghiệp “ma” để mua bán hóa đơn vẫn diễn ra phổ biến, gây thất thu ngân sách và ảnh hưởng môi trường kinh doanh. Do đó, sáng kiến đáp ứng đúng nhu cầu quản lý hiện tại.\nCó tinh khả thi cao do đơn vị hiện đã có hạ tầng công nghệ (cổng đăng ký hóa đơn điện tử, cơ sở dữ liệu người nộp thuế, kết nối với cơ quan đăng ký kinh doanh) nên hoàn toàn có thể triển khai đồng bộ việc giám sát ngay khi doanh nghiệp mới thành lập.\nc. Hiệu quả và phạm vi áp dụng của sáng kiến, giải pháp:\n* Hiệu quả về xã hội:\nKể từ khi áp dụng sáng kiến bước đầu đã mang lại những hiệu quả thiết thực. Tạo sự lan tỏa về tính răn đe đối với một số cá nhân có ý định thành lập doanh nghiệp với mục đích mua bán hóa đơn khống, nâng cao hiệu lực và hiệu quả của công tác quản lý thuế, góp phần nâng cao tính minh bạch, kỷ cương trong quản lý thuế, xây dựng niềm tin cho cộng đồng doanh nghiệp và xã hội.\n* Hiệu quả về kinh tế:\nNgăn chặn sớm doanh nghiệp mua bán hóa đơn sẽ giảm thiểu số vụ việc phải điều tra, xử lý phức tạp sau này, đồng thời bảo vệ quyền lợi doanh nghiệp làm ăn chân chính.\nKết quả đã thực hiện xác minh địa điểm kinh doanh của doanh nghiệp mới thành lập có đăng ký sử dụng hóa đơn điện tử từ khi áp dụng sáng kiến là 87 DN; xác minh lần 1 chấp nhận là 62 DN, không chấp nhận 25 DN; xác minh lần 2 chấp nhận là 20 DN; xác minh lần 3 chấp nhận là 03 DN; xác minh lần 4 chấp nhận là 01 DN; xác minh không chấp nhận là 01 DN.\nKết quả giám sát, xử lý cảnh báo hóa đơn rủi ro hàng ngày theo hệ số K đã đề nghị doanh nghiệp giải trình, bổ sung đối với 106 DN.\nQua đó, củng đã ngăn ngừa kịp thời được những cá nhân có sử dụng giấy tờ tùy thân của người khác để thành lập doanh nghiệp nhằm mua bán hóa đơn khống, nếu doanh nghiệp thuộc trường hợp này thì người đại diện pháp luật sẽ không xuất trình được giấy tờ tùy thân, không chứng minh được là người đại diện pháp luật, hay đăng ký chỉ có địa chỉ nhưng không có cơ sở sản xuất rõ rang.\n* Phạm vi triển khai áp dụng:\nSáng kiến được áp dụng trong phạm vi Thuế tỉnh Cà Mau quản lý từ ngày 01/11/2024 đến nay trong công tác quản lý đăng ký sử dụng hóa đơn của doanh nghiệp.\nSáng kiến có khả năng nhân rộng để áp dụng tại các Thuế cơ sở, Phòng Quản lý, hỗ trợ doanh nghiệp số 1, Phòng Quản lý, hỗ trợ doanh nghiệp số 2 thuôc Thuế tỉnh Cà Mau để tăng cường kiểm soát công tác quản lý doanh nghiệp mới thành lập đăng ký sử dụng hóa đơn điện tử.\nHội đồng cơ sở đã xét công nhận sáng kiến:\nQuyết định số 1109/QĐ-CMA ngày 23/10/2025 của Thuế tỉnh Cà Mau về việc công nhận sáng kiến năm 2025.\n6. Thời gian áp dụng: từ ngày 01/11/2024 đến nay.\nGiá Rai, ngày 27 tháng 10 năm 2025\nTRƯỞNG THUẾ CƠ SỞ Tác giả sáng kiến\nCái Vũ Ca\nĐồng tác giả sáng kiến\nLê Tấn Thành Trần Hồng Thoa', '<p>BÁO CÁO MÔ TẢ SÁNG KIẾN</p><p>1. Tên sáng kiến: Tăng cường giám sát, quản lý đối với doanh nghiệp mới thành lập khi thực hiện đăng ký sử dụng hóa đơn điện tử, nhằm ngăn chặn kịp thời hành vi mua bán hóa đơn bất hợp pháp.</p><p>2. Nhóm tác giả:</p><p>3. Lĩnh vực áp dụng:</p><p>Kiểm tra thuế nhằm nâng cao chất lượng công tác quản lý doanh nghiệp mới phát sinh khi đăng ký sử dụng hóa đơn điện tử.</p><p>4. Mô tả sáng kiến</p><p>a. Khái quát đặc điểm, tình hình trước khi có sáng kiến</p><p>* Đặc điểm, tình hình trước khi có sáng kiến:</p><p>Với xu thế chuyển đổi số phát triển mạnh như hiện nay, việc triển khai hóa đơn điện tử thay thế cho hóa đơn giấy đã mang lại nhiều lợi ích thiết thực: Giảm được các rủi ro do mất mát hóa đơn, tăng tính an toàn, bảo mật, tiện lợi cho doanh nghiệp trong kiểm tra truy xuất nguồn gốc hóa đơn, thông tin, độ an toàn, chính xác cao, hóa đơn có mã xác thực của cơ quan thuế. Bên cạnh đó còn nhiều tiện ích khác như: Phát hành đồng thời số lượng lớn hóa đơn, không tốn không gian lưu trữ để bảo quản hóa đơn, giảm chi phí in ấn, vận chuyển, nhân lực, dễ dàng tra cứu thông tin, không sợ thất lạc hóa đơn, ký phát hành hóa đơn với chữ ký số tiện lợi và nhanh chóng, hạn chế tình trạng bị phạt hành chính do tình trạng hỏng hay mất hóa đơn. Ứng dụng công nghệ thông tin trong hóa đơn điện tử là giải pháp quan trọng đối với công tác quản lý thuế trong thời kỳ hiện nay.</p><p>Tuy nhiên, cùng với sự phát triển và tính ưu việt của hóa đơn điện tử là tình trạng gian lận, mua bán hóa đơn điện tử, một số cá nhân vì lợi ích kinh tế đã thành lập nên các doanh nghiệp nhưng không hoạt động kinh doanh mà thành lập để mua bán hóa đơn, các đối tượng này thành lập nhiều công ty nhưng không đứng tên người đại diện pháp luật mà lấy giấy chứng minh nhân dân của người khác để đứng tên (Có trường hợp là chứng minh nhân dân của người bị mất giấy tờ, cá nhân đã chết, mất tích) và khi làm thủ tục để cấp giấy chứng nhận đăng ký kinh doanh sẽ không trực tiếp làm giấy tờ mà thông qua cá nhân làm dịch vụ để cấp giấy phép. Đồng thời với chính sách thông thoáng trong việc đăng ký thành lập doanh nghiệp, giảm bớt thủ tục hành chính, việc đăng ký thành lập doanh nghiệp được thực hiện theo phương thức điện tử. Do đó, một số cá nhân lợi dụng chính sách thông thoáng này để thành lập doanh nghiệp để mua bán hóa đơn khống với mục đích cuối cùng là chiếm dụng tiền hoàn thuế giá trị gia tăng, hợp thức hóa chi phí, trốn thuế, gây thất thoát cho ngân sách nhà nước.</p><p>* Sự cần thiết, mục đích của việc thực hiện sáng kiến:</p><p>Tuy nhiên, cùng với sự phát triển và tính ưu việt của hóa đơn điện tử là tình trạng gian lận, mua bán hóa đơn điện tử, một số cá nhân vì lợi ích kinh tế đã thành lập nên các doanh nghiệp nhưng không hoạt động kinh doanh mà thành lập để mua bán hóa đơn, các đối tượng này thành lập nhiều công ty nhưng không đứng tên người đại diện pháp luật mà lấy giấy chứng minh nhân dân của người khác để đứng tên (Có trường hợp là chứng minh nhân dân của người bị mất giấy tờ, cá nhân đã chết, mất tích) và khi làm thủ tục để cấp giấy chứng nhận đăng ký kinh doanh sẽ không trực tiếp làm giấy tờ mà thông qua cá nhân làm dịch vụ để cấp giấy phép. Đồng thời với chính sách thông thoáng trong việc đăng ký thành lập doanh nghiệp, giảm bớt thủ tục hành chính, việc đăng ký thành lập doanh nghiệp được thực hiện theo phương thức điện tử. Do đó, một số cá nhân lợi dụng chính sách thông thoáng này để thành lập doanh nghiệp để mua bán hóa đơn khống với mục đích cuối cùng là chiếm dụng tiền hoàn thuế giá trị gia tăng, hợp thức hóa chi phí, trốn thuế, gây thất thoát cho ngân sách nhà nước.</p><p>b. Nội dung sáng kiến</p><p>Thực hiện nhiệm vụ được giao Tổ quản lý, hỗ trợ doanh nghiệp đã tham mưu, đề xuất Lãnh đạo cơ quan đẩy mạnh công tác phối hợp giữa các bộ phận trong đơn vị, đồng thời phân công 4 công chức chia làm 02 nhóm để thực hiện công tác xác minh địa điểm kinh doanh khi doanh nghiệp đăng ký sử dụng hóa đơn điện tử, để đảm bảo kịp thời phê duyệt cho doanh nghiệp, vì thời gian phê duyệt chỉ có 01 ngày làm việc.</p><p>Theo đó, ngay sau khi tiếp nhận thông tin từ Sở Kế hoạch và Đầu tư chuyển về những doanh nghiệp thành lập mới. Tổ Quản lý, hỗ trợ doanh nghiệp phân công từng công chức quản lý trực tiếp doanh nghiệp thực hiện rà soát đánh giá mức độ rủi ro để theo dõi quản lý về việc hoạt động, phát hành và sử dụng hóa đơn, nhất là đối với những doanh nghiệp có người đại diện pháp luật không phải là người địa phương, đăng ký thường trú ở địa phương khác, có địa chỉ xa so với địa bàn cơ quan thuế quản lý hoặc đã là người đại diện theo pháp luật của doanh nghiệp đã ngừng hoạt động.  Khi doanh nghiệp gửi thông báo đăng ký sử dụng hóa đơn điện tử (HĐĐT) thì công chức quản lý doanh nghiệp sẽ liên hệ với người nộp thuế theo số điện thoại đã đăng ký trên hệ thống quản lý thuế TMS, HĐĐT để xác minh thông tin bước đầu, sau đó sẽ tiến hành xác minh thực tế tại địa chỉ đăng ký về tình hình hoạt động kinh doanh, thông tin về trụ sở, tài sản cố định, hàng hóa, lĩnh vực hoạt động, điều kiện kinh doanh,…. Từ đó, cơ quan thuế sẽ có đầy đủ thông tin về doanh nghiệp, nhất là thông tin về người đại diện pháp luật, giấy tờ tùy thân của người đại diện pháp luật dùng để sử dụng cho việc thành lập doanh nghiệp. Nếu qua xác minh doanh nghiệp không đáp ứng đủ điều kiện thì nhóm xác minh báo cáo lãnh đạo tạm thời không chấp nhận phê duyệt sử dụng hóa đơn điện tử cho doanh nghiệp hoặc qua xác minh trụ sở người nộp thuế, tổ công tác không tìm thấy trụ sở người nộp thuế, tham mưu lãnh đạo Thuế cơ sở ban hành Thông báo về việc người nộp thuế không hoạt động tại địa chỉ đã đăng ký, chuyển tin báo vụ việc về thuế sang cơ quan điều tra để xử lý theo quy định, đồng thời ban hành công văn cảnh báo doanh nghiệp có dấu hiệu rủi ro cao về thuế và hóa đơn đến các Cơ quan thuế khác để xử lý theo quy định.</p><p>Bên canh đó, đối với các doanh nghiệp đã được chấp nhận cho sử dụng hóa đơn điện tử thì phân công công chức quản lý doanh nghiệp hàng ngày phải vào ứng dụng hóa đơn điện tử để rà soát việc xuất hóa đơn có thuộc diện cảnh báo rủi ro hay không, từ đó đề nghị doanh nghiệp giải trình kịp thời về việc xuất hóa đơn của doanh nghiệp.</p><p>* Tính mới của sáng kiến:</p><p>Sáng kiến được áp dụng lần đầu tại đơn vị, nhằm tiếp cận sớm đối tượng rủi ro thay vì chỉ kiểm tra, xử lý khi doanh nghiệp đã có hành vi vi phạm, sáng kiến tập trung ngay từ khâu đăng ký sử dụng hóa đơn điện tử của doanh nghiệp mới thành lập, thay gì hậu kiểm như trước đây chuyển từ “phát hiện và xử lý” sang “ngăn chặn, phòng ngừa”, giảm thiểu khả năng hình thành các đường dây mua bán hóa đơn bất hợp pháp.</p><p>Kết hợp dữ liệu từ hệ thống đăng ký thuế, đăng ký kinh doanh, cơ sở dữ liệu quốc gia để phân loại, cảnh báo sớm các doanh nghiệp có dấu hiệu rủi ro trong sử dụng hóa đơn điện tử.</p><p>* Tính thực tiễn của sáng kiến:</p><p>Tình trạng thành lập doanh nghiệp “ma” để mua bán hóa đơn vẫn diễn ra phổ biến, gây thất thu ngân sách và ảnh hưởng môi trường kinh doanh. Do đó, sáng kiến đáp ứng đúng nhu cầu quản lý hiện tại.</p><p>Có tinh khả thi cao do đơn vị hiện đã có hạ tầng công nghệ (cổng đăng ký hóa đơn điện tử, cơ sở dữ liệu người nộp thuế, kết nối với cơ quan đăng ký kinh doanh) nên hoàn toàn có thể triển khai đồng bộ việc giám sát ngay khi doanh nghiệp mới thành lập.</p><p>c. Hiệu quả và phạm vi áp dụng của sáng kiến, giải pháp:</p><p>* Hiệu quả về xã hội:</p><p>Kể từ khi áp dụng sáng kiến bước đầu đã mang lại những hiệu quả thiết thực. Tạo sự lan tỏa về tính răn đe đối với một số cá nhân có ý định thành lập doanh nghiệp với mục đích mua bán hóa đơn khống, nâng cao hiệu lực và hiệu quả của công tác quản lý thuế, góp phần nâng cao tính minh bạch, kỷ cương trong quản lý thuế, xây dựng niềm tin cho cộng đồng doanh nghiệp và xã hội.</p><p>* Hiệu quả về kinh tế:</p><p>Ngăn chặn sớm doanh nghiệp mua bán hóa đơn sẽ giảm thiểu số vụ việc phải điều tra, xử lý phức tạp sau này, đồng thời bảo vệ quyền lợi doanh nghiệp làm ăn chân chính.</p><p>Kết quả đã thực hiện xác minh địa điểm kinh doanh của doanh nghiệp mới thành lập có đăng ký sử dụng hóa đơn điện tử từ khi áp dụng sáng kiến là 87 DN; xác minh lần 1 chấp nhận là 62 DN, không chấp nhận 25 DN; xác minh lần 2 chấp nhận là 20 DN; xác minh lần 3 chấp nhận là 03 DN; xác minh lần 4 chấp nhận là 01 DN; xác minh không chấp nhận là 01 DN.</p><p>Kết quả giám sát, xử lý cảnh báo hóa đơn rủi ro hàng ngày theo hệ số K đã đề nghị doanh nghiệp giải trình, bổ sung đối với 106 DN.</p><p>Qua đó, củng đã ngăn ngừa kịp thời được những cá nhân có sử dụng giấy tờ tùy thân của người khác để thành lập doanh nghiệp nhằm mua bán hóa đơn khống, nếu doanh nghiệp thuộc trường hợp này thì người đại diện pháp luật sẽ không xuất trình được giấy tờ tùy thân, không chứng minh được là người đại diện pháp luật, hay đăng ký chỉ có địa chỉ nhưng không có cơ sở sản xuất rõ rang.</p><p>* Phạm vi triển khai áp dụng:</p><p>Sáng kiến được áp dụng trong phạm vi Thuế tỉnh Cà Mau quản lý từ ngày 01/11/2024 đến nay trong công tác quản lý đăng ký sử dụng hóa đơn của doanh nghiệp.</p><p>Sáng kiến có khả năng nhân rộng để áp dụng tại các Thuế cơ sở, Phòng Quản lý, hỗ trợ doanh nghiệp số 1, Phòng Quản lý, hỗ trợ doanh nghiệp số 2 thuôc Thuế tỉnh Cà Mau để tăng cường kiểm soát công tác quản lý doanh nghiệp mới thành lập đăng ký sử dụng hóa đơn điện tử.</p><p>Hội đồng cơ sở đã xét công nhận sáng kiến:</p><p>Quyết định số 1109/QĐ-CMA ngày  23/10/2025 của  Thuế  tỉnh  Cà  Mau về  việc  công nhận  sáng  kiến  năm 2025.</p><p>6. Thời gian áp dụng: từ ngày 01/11/2024 đến nay.</p><p>Giá Rai, ngày 27 tháng 10 năm 2025</p><p>TRƯỞNG THUẾ CƠ SỞ                             Tác giả sáng kiến</p><p>Cái Vũ Ca</p><p>Đồng tác giả sáng kiến</p><p>Lê Tấn Thành	        Trần Hồng Thoa</p>', '91d72f300b95494fa713de4d0328d51eb456ad4abdc4b1f1bad605d0bafcd741', '2026-09-22 22:33:28');
INSERT INTO `qlsk_file_noi_dung` (`id`, `file_id`, `sang_kien_id`, `noi_dung`, `noi_dung_html`, `hash_noi_dung`, `ngay_trich_xuat`) VALUES
(22, 44, 51, 'Mẫu 05/SK(Kèm theo Quyết định số 2890/QĐ-CT ngày 25 tháng 8 năm 2025 của Cục Thuế\nTHUẾ TỈNH CÀ MAU CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM\nTHUẾ CƠ SỞ 2 TỈNH CÀ MAU Độc lập - Tự do - Hạnh phúc\nBÁO CÁO MÔ TẢ SÁNG KIẾN\n1. Tên sáng kiến:\nGiải pháp nâng cao vai trò và trách nhiệm của Thuế cơ sở khi thực hiện chính quyền địa phương 2 cấp.\n2. Họ và tên nhóm tác giả sáng kiến, chức danh, trình độ chuyên môn:\n3. Lĩnh vực áp dụng:\n- Lĩnh vực có thế áp dụng sáng kiến: Hỗ trợ người nộp thuế.\n- Vấn đề mà sáng kiến giải quyết:\nSáng kiến có vai trò rất quan trọng - một trong những mục tiêu cốt lõi của mô hình chính quyền địa phương 2 cấp là tăng cường tính chuyên nghiệp, hiện đại và minh bạch trong quản trị nhà nước, qua đó phục vụ người nộp thuế tốt hơn. Việc tinh gọn bộ máy cho phép đẩy nhanh quá trình ứng dụng công nghệ thông tin, chuyển đổi số toàn diện trong hoạt động điều hành, cung cấp dịch vụ công, từ đó rút ngắn thời gian, giảm chi phí, nâng cao sự hài lòng của người dân và doanh nghiệp.\n4. Mô tả sáng kiến:\na. Khái quát đặc điểm, tình hình trước khi có sáng kiến\na.1. Hiện trạng trước khi áp dụng sáng kiến\nTrong tiến trình đổi mới toàn diện đất nước, cải cách tổ chức bộ máy nhà nước luôn là một trong những nhiệm vụ then chốt được Đảng và Nhà nước ta đặc biệt quan tâm. Việc đổi mới mô hình tổ chức chính quyền địa phương theo hướng tinh gọn, hiệu lực, hiệu quả, chuyên nghiệp, số hóa và gần dân, sát dân là bước đi quan trọng trong chiến lược cải cách thể chế quốc gia. Trong đó, việc triển khai mô hình chính quyền địa phương 2 cấp (cấp tỉnh và cấp xã), thay vì tổ chức đồng thời 3 cấp như trước, đã và đang trở thành giải pháp thiết thực nhằm đáp ứng yêu cầu quản trị xã hội hiện đại, tạo đà cho phát triển kinh tế - xã hội bền vững, bảo đảm quốc phòng - an ninh trong kỷ nguyên số.\nNghị quyết số 60-NQ/TW ngày 12/4/2025 của Ban Chấp hành Trung ương Đảng đã thông qua chủ trương tổ chức chính quyền địa phương 2 cấp, nhấn mạnh mục tiêu tinh gọn bộ máy và nâng cao hiệu quả phục vụ nhân dân. Việc sắp xếp đơn vị hành chính ở địa phương được xác định trên tinh thần đột phá, bám sát thực tiễn, hướng đến mục tiêu mở rộng không gian phát triển mới cho địa phương và cho đất nước. Việc này không phải chỉ để giảm chi phí hành chính mà quan trọng là tạo dư địa phát triển cho từng địa phương, giúp bộ máy hoạt động hiệu lực, hiệu quả, gần dân, sát dân, phục vụ nhân dân. Bên cạnh đó, khi bộ máy tinh gọn sẽ giúp giảm biên chế, giảm chi tiêu, tiết kiệm ngân sách để dành nguồn lực cho nhiều nhiệm vụ quan trọng khác.\nĐối với ngành Thuế nói chung, Thuế cơ sở nói riêng, việc thực hiện thủ tục hành chính thuế theo mô hình chính quyền địa phương 2 cấp theo Nghị định số 118/2025/NĐ-CP là một chủ trương lớn của Chính phủ, thể hiện rõ định hướng cải cách thể chế gắn với cải cách hành chính, tăng tính linh hoạt và hiệu lực của bộ máy phục vụ người dân, doanh nghiệp. Theo đó, phải đảm bảo mọi thủ tục hành chính về thuế được thực hiện thông suốt, không ách tắc, không gián đoạn, không để người dân và doanh nghiệp phải đi lại nhiều lần vì thiếu sự phối hợp giữa các cấp chính quyền trong thời gian đầu khi mới áp dụng chính quyền 2 cấp tại địa phương.\na.2. Sự cần thiết của việc đề xuất sáng kiến\nViệc triển khai mô hình chính quyền địa phương 2 cấp theo chỉ đạo của Trung ương là xu thế tất yếu nhằm tinh gọn bộ máy, nâng cao hiệu quả quản lý nhà nước. Đồng thời, xuất phát từ chức năng, nhiệm vụ và đối tượng quản lý của cơ quan thuế các cấp, ngành Thuế đã thiết kế và xây dựng tổ chức bộ máy mới theo hướng hiện đại, tinh gọn, hoạt động hiệu năng, hiệu lực, hiệu quả; với phương châm “Lấy người nộp thuế là trung tâm phục vụ, tạo thuận lợi tối đa cho người nộp thuế”; và dựa trên ba trụ cột cơ bản: (i) thể chế quản lý thuế đầy đủ, đồng bộ, hiện đại, hội nhập; (ii) nguồn nhân lực chuyên nghiệp, liêm chính, đổi mới; (iii) công nghệ thông tin hiện đại, tích hợp, đáp ứng yêu cầu quản lý thuế và góp phần đưa đất nước bước vào kỷ nguyên mới.\nBám sát chỉ đạo của Lãnh đạo Đảng, Nhà nước là tinh gọn bộ máy không chỉ là giảm đầu mối, số lượng mà còn nâng cao cơ chế vận hành thực thi nhiệm vụ. Việc thực hiện sắp xếp, kiện toàn lại tổ chức bộ máy theo hướng tinh gọn, hiệu lực, hiệu quả theo Nghị quyết số 18-NQ/TW của Bộ Chính trị là chủ trương lớn, mang tính lịch sử. Sau hai giai đoạn triển khai, hệ thống ngành Thuế được tổ chức lại thành 34 thuế tỉnh, thành phố, phù hợp với mô hình chính quyền địa phương 2 cấp. Đây không chỉ là sự thay đổi về cơ cấu tổ chức, mà còn là bước đi nhằm đáp ứng yêu cầu đổi mới, nâng cao hiệu quả hoạt động, đóng góp tích cực vào mục tiêu phát triển kinh tế - xã hội của đất nước. Kết quả này là minh chứng rõ nét cho quyết tâm chính trị và nỗ lực hành động của toàn ngành trong việc thực hiện hoá chủ trương lớn của Đảng và Nhà nước về tinh giản bộ máy, đổi mới quản trị công.\nKhông chỉ đơn thuần là việc sáp nhập, tổ chức lại mà là bước chuyển dịch lớn nhằm nâng cao hiệu lực, hiệu quả hoạt động của hệ thống thuế, tạo điều kiện để mỗi cán bộ phát huy năng lực, từng bước hiện đại hoá phương thức phục vụ người dân và doanh nghiệp. Đây không chỉ là yêu cầu mang tính chiến lược lâu dài mà còn là đòi hỏi cấp bách trong tiến trình cải cách hành chính, cải cách tài chính công và thúc đẩy chuyển đổi số quốc gia. Tuy nhiên, quá trình tổ chức lại bộ máy không tránh khỏi những khó khăn, vướng mắc nhất định. Việc giảm mạnh số lượng đầu mối quản lý, từ đó đặt ra áp lực không nhỏ về tổ chức lại nhân sự, quy trình vận hành, phân bổ khối lượng công việc và quản lý địa bàn rộng lớn hơn. Trong khi đó, nguồn nhân lực không tăng, thậm chí tinh giản nhân sự, ảnh hưởng đến chất lượng và tâm lý làm việc.\nNhận diện đúng thực tiễn và để vận hành hiệu quả theo mô hình tổ chức mới, bảo đảm hoạt động thu thuế không bị gián đoạn, góp phần ổn định kinh tế - xã hội địa phương; chúng tôi đưa ra sáng kiến: “Giải pháp nâng cao vai trò và trách nhiệm của Thuế cơ sở khi thực hiện chính quyền địa phương 2 cấp”.\nb. Nội dung sáng kiến\nb.1. Nội dung\nĐổi mới mô hình tổ chức bộ máy của cơ quan thuế là yêu cầu tất yếu trong quá trình cải cách, hiện đại hóa ngành thuế theo tinh thần chỉ đạo của Đảng, Nhà nước. Trong bối cảnh nền kinh tế số và sự thay đổi nhanh chóng của mô hình kinh doanh, cơ quan thuế cần có sự chuyển đổi mạnh mẽ để đảm bảo thực hiện tốt chức năng, nhiệm vụ của mình.\nVới mục tiêu xây dựng một hệ thống thuế hiện đại, tinh gọn, hiệu lực, hiệu quả, đảm bảo quản lý thuế chặt chẽ, minh bạch, hiện đại theo hướng chuyển đổi số mạnh mẽ trong quản lý, tạo thuận lợi tối đa cho người nộp thuế khi thực hiện mô hình tổ chức chính quyền địa phương 2 cấp. Đây là một nhiệm vụ quan trọng, có ý nghĩa quyết định đến sự thành công, vận hành hiệu quả của hệ thống thuế trong thời gian tới và có tính lịch sử cho sự phát triển của ngành Thuế Việt Nam.\nViệc chuyển đổi này đặt ra nhiều thách thức và yêu cầu mới trong công tác quản lý thuế, nhất là đối với cơ quan quản lý thuế tại cấp cơ sở - là đơn vị trực tiếp triển khai công tác quản lý thuế trên địa bàn. Sự thay đổi này không chỉ là một thách thức về tổ chức, nhân lực mà còn là cơ hội để nâng cao hiệu quả phục vụ người nộp thuế.\nNhận thức rõ tầm quan trọng của vấn đề nêu trên, đồng thời vừa phải bảo đảm công tác quản lý thuế, vừa giải quyết công việc, thủ tục hành chính cho người dân và doanh nghiệp được thông suốt, thuận lợi, không bị gián đoạn trong quá trình chuyển đổi, cũng như kịp thời huy động nguồn thu vào ngân sách nhà nước. Nhóm tác giả đã có sáng kiến đưa ra các giải pháp để nâng cao vai trò và trách nhiệm của Thuế cơ sở khi thực hiện chính quyền địa phương 2 cấp, cụ thể như sau:\n- Một là: Là cầu nối giữa cơ quan thuế và người nộp thuế - đóng vai trò trực tiếp tiếp xúc, hướng dẫn, hỗ trợ doanh nghiệp, hộ kinh doanh, cá nhân kinh doanh và người dân trong thực hiện nghĩa vụ thuế. Là đầu mối tiếp nhận thông tin, phản ánh, kiến nghị từ người nộp thuế để kịp thời báo cáo cấp trên xử lý, tháo gỡ khó khăn, vướng mắc.\n- Hai là: Phối hợp chặt chẽ cùng chính quyền địa phương đảm bảo thủ tục hành chính thống nhất, liên thông, giúp người dân và doanh nghiệp thụ hưởng được chính sách cũng như các thủ tục hành chính về thuế thật nhanh gọn và chính xác.\n- Ba là: Tổ chức triển khai chính sách thuế hiệu quả tại địa phương, cụ thể:\nTham mưu, phối hợp với các Phòng chức năng của Thuế tỉnh, tổ chức triển khai các quy định mới, truyền tải các chủ trương, chính sách thuế mới đến doanh nghiệp, hộ kinh doanh, cá nhân kinh doanh trên địa bàn.\nChủ động rà soát, phân loại đối tượng người nộp thuế, đặc biệt là các doanh nghiệp nhỏ và siêu nhỏ, hộ kinh doanh, cá nhân kinh doanh mới phát sinh.\n- Bốn là: Bám sát dự toán được giao, bám sát địa bàn quản lý, chủ động phân tích, dự báo nguồn thu, từ đó triển khai đồng bộ các biện pháp quản lý thu, chống thất thu và thu hồi nợ đọng thuế… đảm bảo công tác thu ngân sách trên địa bàn phải hoàn thành ở mức cao nhất nhiệm vụ được giao.\n- Năm là: Đẩy mạnh công tác thông tin, tuyên truyền ở tất cả các khâu, các bộ phận, các lĩnh vực thông qua việc đổi mới phương thức, phát triển đa dạng, phong phú các hình thức tuyên truyền, giúp người nộp thuế nhanh chóng tiếp cận, nắm được các chính sách thuế hiện hành, chính sách mới ban hành, thủ tục hành chính thuế để người nộp thuế thực hiện tốt các nghĩa vụ về thuế của mình.\n- Sáu là: Chủ động chuyển đổi số trong công tác quản lý thuế theo Ðề án 06 và các chương trình chuyển đổi số của ngành Thuế. Gia tăng hàm lượng công nghệ thông tin, khai thác dữ liệu hóa đơn điện tử kết hợp dữ liệu khai thuế của người nộp thuế và dữ liệu quản lý nhà nước từ các ngành để số hóa toàn diện công tác quản lý thuế trên các lĩnh vực\n- Bảy là: Thực hiện chức năng quản lý thuế tại cơ sở đảm bảo sự liên tục và hiệu quả, nhiệm vụ không chồng chéo, quá trình thực hiện diễn ra thông suốt, không bị gián đoạn. Dù tổ chức bộ máy có thay đổi, trách nhiệm đảm bảo thu đúng, thu đủ và kịp thời vẫn là nhiệm vụ hàng đầu của Thuế cơ sở.\n- Tám là: Tăng cường kỷ luật, kỷ cương nội ngành, chấn chỉnh, nâng cao tinh thần trách nhiệm đội ngũ công chức trong thực thi công vụ; đặc biệt tăng cường giám sát, kiểm tra việc thực hiện các chỉ tiêu phấn đấu liên quan đến công tác chuyên môn, nghiệp vụ trọng tâm của ngành theo Đề án 420.\n- Chín là: Mạnh dạn tiếp thu và lắng nghe ý kiến của người nộp thuế, đánh giá những thuận lợi, khó khăn; luôn là “điểm tựa vững chắc” cho người nộp thuế vượt qua mọi “trăn trở, vướng mắc” khi triển khai mô hình mới. Từ đó đề xuất các giải pháp phù hợp với đặc thù riêng trên địa bàn quản lý nhưng vẫn đảm bảo giữ được nguyên tắc chung.\n- Mười là: Tham mưu kịp thời cho lãnh đạo cơ quan thuế cấp trên những bất cập trong công tác quản lý thuế tại địa bàn. Phân công phân nhiệm rõ ràng trên cơ sở chức năng, nhiệm vụ theo mô hình mới để giải quyết công việc kịp thời, thông suốt. Đồng thời, mỗi công chức thuế phải nêu cao tinh thần trách nhiệm, chủ động thích ứng với sự thay đổi, thực hiện đúng vai trò, nhiệm vụ được phân công trong bối cảnh tổ chức bộ máy mới.\nb.2. Tính mới của sáng kiến\n- Sáng kiến có vai trò rất quan trọng - một trong những mục tiêu cốt lõi của mô hình chính quyền địa phương 2 cấp là tăng cường tính chuyên nghiệp, hiện đại và minh bạch trong quản trị nhà nước, qua đó phục vụ người nộp thuế tốt hơn. Việc tinh gọn bộ máy cho phép đẩy nhanh quá trình ứng dụng công nghệ thông tin, chuyển đổi số toàn diện trong hoạt động điều hành, cung cấp dịch vụ công, từ đó rút ngắn thời gian, giảm chi phí, nâng cao sự hài lòng của người dân và doanh nghiệp.\n- Với phương châm “lấy người dân, doanh nghiệp làm trung tâm phục vụ”, Thuế cơ sở đã khẳng định vai trò tiên phong trong cải cách hành chính, hiện đại hóa công tác quản lý thuế, đáp ứng yêu cầu của mô hình chính quyền địa phương 2 cấp. Đây là bước chuyển quan trọng, góp phần nâng cao hiệu lực, hiệu quả quản lý thuế, phù hợp với xu thế chuyển đổi số hiện nay.\n- Không còn bộ máy cồng kềnh, trì trệ; không còn quá nhiều “cấp trung gian” làm chậm nhịp điều hành - bộ máy mới đang từng bước hướng tới một nền hành chính điện tử, số hóa toàn diện, minh bạch, hiệu quả và có trách nhiệm giải trình rõ ràng. Người dân và doanh nghiệp giờ đây có thể dễ dàng tiếp cận dịch vụ công qua mạng, phản ánh ý kiến trực tiếp qua các kênh số hóa, tương tác với ngành Thuế được thuận tiện, nhanh chóng và minh bạch hơn bao giờ hết, góp phần đưa đất nước vững vàng bước vào kỷ nguyên phát triển mới - giàu mạnh, thịnh vượng và nhân văn.\n- Tạo được mối quan hệ gắn kết chặt chẽ, mật thiết giữa cơ quan thuế với người nộp thuế; giúp công chức thuế thực hiện nhiệm vụ được dễ dàng, nhanh chóng. Tính tương tác giữa hai bên sẽ được gần gũi, công tác hỗ trợ cũng thiết thực hơn, đúng theo phương châm “Tận tâm lắng nghe - Tận tình hướng dẫn - Tận tụy giải quyết”.\nc. Hiệu quả và phạm vi áp dụng của sáng kiến\nc.1. Hiệu quả\nQua thực tế áp dụng, sáng kiến đã mang lại hiệu quả cao trong công tác quản lý thuế:\n- Quá trình triển khai vận hành cho thấy mô hình mới cơ bản hoạt động thông suốt, ổn định; các chức năng, nhiệm vụ không chồng chéo, trùng lặp, không làm ảnh hưởng đến việc thực hiện thủ tục hành chính thuế của người dân và doanh nghiệp. Tính đến hết tháng 7/2025, tổng thu ngân sách nhà nước trên địa bàn đạt 262.075 triệu đồng, bằng 67,2% dự toán pháp lệnh và tăng 13,5% so với cùng kỳ năm trước. Kết quả này phản ánh sự nỗ lực của Thuế cơ sở trong việc thích ứng nhanh, vận hành hiệu quả theo mô hình tổ chức mới, bảo đảm hoạt động thu thuế không bị gián đoạn, góp phần ổn định kinh tế - xã hội địa phương.\n- Toàn bộ hệ thống ứng dụng công nghệ của Thuế cơ sở, từ phần mềm quản lý thuế tập trung, hóa đơn điện tử, cổng giao dịch thuế điện tử (eTax), ứng dụng eTax Mobile… đều vận hành ổn định trong mô hình tổ chức mới. Người dân và doanh nghiệp đến thực hiện các thủ tục được hướng dẫn, hỗ trợ, bảo đảm tiến độ xử lý hồ sơ không bị ảnh hưởng.\n- Lấy người nộp thuế làm trung tâm phục vụ là phương châm và nguyên tắc cốt lõi của việc đổi mới bộ máy của Thuế cơ sở. Mặc dù có khối lượng công việc lớn liên quan đến nhân sự, hệ thống công nghệ thông tin, chuyển đổi dữ liệu, chốt sổ sách. Tuy nhiên, quá trình triển khai đã nhận được sự đồng lòng, chung sức của toàn thể hệ thống chính trị tại địa phương và công chức trong toàn đơn vị. Điều này đảm bảo việc vận hành theo mô hình tổ chức bộ máy mới được đồng bộ và thông suốt.\n- Việc tổ chức lại bộ máy Thuế cơ sở không chỉ là cải cách về hình thức, mà còn là thước đo năng lực phục vụ của bộ máy hành chính hiện đại, chuyên nghiệp, tác động tích cực đến chất lượng quản lý và thu ngân sách. Dù nền kinh tế vẫn đang đối mặt với nhiều áp lực, bất lợi từ bên ngoài, tuy nhiên Thuế cơ sở vẫn đảm bảo duy trì được số thu tăng theo từng ngày. Theo đó, chỉ tiêu thu ngân sách hàng tháng tại Thuế cơ sở đều đạt và vượt dự toán cấp trên giao.\nc.2. Phạm vi áp dụng của sáng kiến\nSáng kiến hiện đang áp dụng tại Thuế cơ sở; với đối tượng cụ thể là tất cả các công chức trong đơn vị và người nộp thuế trên địa bàn 3 phường thuộc Thuế cơ sở 2 tỉnh Cà Mau.\nKhả năng nhân rộng: Sáng kiến có khả năng nhân rộng Thuế tỉnh.\n5. Hội đồng cơ sở đã xét công nhận sáng kiến: Quyết định số 1109/QĐ-CMA, ngày 23/10/2025 của Thuế tỉnh Cà Mau.\n6. Thời gian áp dụng: Từ ngày 01 tháng 04 năm 2025 đến nay./.\nBạc Liêu, ngày 29 tháng 10 năm 2025\nTHUẾ CƠ SỞ 2 TỈNH CÀ MAU ĐỒNG TÁC GIẢ 1\nPHÓ TRƯỞNG THUẾ\nTrần Thanh Tùng Bùi Đắc Toái\nĐỒNG TÁC GIẢ 2\nNgô Thị Như Quỳnh\nĐỒNG TÁC GIẢ 3\nNguyễn Thị Bạch Yến', '<p>Mẫu 05/SK(Kèm theo Quyết định số 2890/QĐ-CT ngày 25 tháng 8 năm 2025 của Cục Thuế</p><p>THUẾ TỈNH CÀ MAU	CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM</p><p>THUẾ CƠ SỞ 2 TỈNH CÀ MAU	Độc lập - Tự do - Hạnh phúc</p><p>BÁO CÁO MÔ TẢ SÁNG KIẾN</p><p>1. Tên sáng kiến:</p><p>Giải pháp nâng cao vai trò và trách nhiệm của Thuế cơ sở khi thực hiện chính quyền địa phương 2 cấp.</p><p>2. Họ và tên nhóm tác giả sáng kiến, chức danh, trình độ chuyên môn:</p><p>3. Lĩnh vực áp dụng:</p><p>- Lĩnh vực có thế áp dụng sáng kiến: Hỗ trợ người nộp thuế.</p><p>- Vấn đề mà sáng kiến giải quyết:</p><p>Sáng kiến có vai trò rất quan trọng - một trong những mục tiêu cốt lõi của mô hình chính quyền địa phương 2 cấp là tăng cường tính chuyên nghiệp, hiện đại và minh bạch trong quản trị nhà nước, qua đó phục vụ người nộp thuế tốt hơn. Việc tinh gọn bộ máy cho phép đẩy nhanh quá trình ứng dụng công nghệ thông tin, chuyển đổi số toàn diện trong hoạt động điều hành, cung cấp dịch vụ công, từ đó rút ngắn thời gian, giảm chi phí, nâng cao sự hài lòng của người dân và doanh nghiệp.</p><p>4. Mô tả sáng kiến:</p><p>a. Khái quát đặc điểm, tình hình trước khi có sáng kiến</p><p>a.1. Hiện trạng trước khi áp dụng sáng kiến</p><p>Trong tiến trình đổi mới toàn diện đất nước, cải cách tổ chức bộ máy nhà nước luôn là một trong những nhiệm vụ then chốt được Đảng và Nhà nước ta đặc biệt quan tâm. Việc đổi mới mô hình tổ chức chính quyền địa phương theo hướng tinh gọn, hiệu lực, hiệu quả, chuyên nghiệp, số hóa và gần dân, sát dân là bước đi quan trọng trong chiến lược cải cách thể chế quốc gia. Trong đó, việc triển khai mô hình chính quyền địa phương 2 cấp (cấp tỉnh và cấp xã), thay vì tổ chức đồng thời 3 cấp như trước, đã và đang trở thành giải pháp thiết thực nhằm đáp ứng yêu cầu quản trị xã hội hiện đại, tạo đà cho phát triển kinh tế - xã hội bền vững, bảo đảm quốc phòng - an ninh trong kỷ nguyên số.</p><p>Nghị quyết số 60-NQ/TW ngày 12/4/2025 của Ban Chấp hành Trung ương Đảng đã thông qua chủ trương tổ chức chính quyền địa phương 2 cấp, nhấn mạnh mục tiêu tinh gọn bộ máy và nâng cao hiệu quả phục vụ nhân dân. Việc sắp xếp đơn vị hành chính ở địa phương được xác định trên tinh thần đột phá, bám sát thực tiễn, hướng đến mục tiêu mở rộng không gian phát triển mới cho địa phương và cho đất nước. Việc này không phải chỉ để giảm chi phí hành chính mà quan trọng là tạo dư địa phát triển cho từng địa phương, giúp bộ máy hoạt động hiệu lực, hiệu quả, gần dân, sát dân, phục vụ nhân dân. Bên cạnh đó, khi bộ máy tinh gọn sẽ giúp giảm biên chế, giảm chi tiêu, tiết kiệm ngân sách để dành nguồn lực cho nhiều nhiệm vụ quan trọng khác.</p><p>Đối với ngành Thuế nói chung, Thuế cơ sở nói riêng, việc thực hiện thủ tục hành chính thuế theo mô hình chính quyền địa phương 2 cấp theo Nghị định số 118/2025/NĐ-CP là một chủ trương lớn của Chính phủ, thể hiện rõ định hướng cải cách thể chế gắn với cải cách hành chính, tăng tính linh hoạt và hiệu lực của bộ máy phục vụ người dân, doanh nghiệp. Theo đó, phải đảm bảo mọi thủ tục hành chính về thuế được thực hiện thông suốt, không ách tắc, không gián đoạn, không để người dân và doanh nghiệp phải đi lại nhiều lần vì thiếu sự phối hợp giữa các cấp chính quyền trong thời gian đầu khi mới áp dụng chính quyền 2 cấp tại địa phương.</p><p>a.2. Sự cần thiết của việc đề xuất sáng kiến</p><p>Việc triển khai mô hình chính quyền địa phương 2 cấp theo chỉ đạo của Trung ương là xu thế tất yếu nhằm tinh gọn bộ máy, nâng cao hiệu quả quản lý nhà nước. Đồng thời, xuất phát từ chức năng, nhiệm vụ và đối tượng quản lý của cơ quan thuế các cấp, ngành Thuế đã thiết kế và xây dựng tổ chức bộ máy mới theo hướng hiện đại, tinh gọn, hoạt động hiệu năng, hiệu lực, hiệu quả; với phương châm “Lấy người nộp thuế là trung tâm phục vụ, tạo thuận lợi tối đa cho người nộp thuế”; và dựa trên ba trụ cột cơ bản: (i) thể chế quản lý thuế đầy đủ, đồng bộ, hiện đại, hội nhập; (ii) nguồn nhân lực chuyên nghiệp, liêm chính, đổi mới; (iii) công nghệ thông tin hiện đại, tích hợp, đáp ứng yêu cầu quản lý thuế và góp phần đưa đất nước bước vào kỷ nguyên mới.</p><p>Bám sát chỉ đạo của Lãnh đạo Đảng, Nhà nước là tinh gọn bộ máy không chỉ là giảm đầu mối, số lượng mà còn nâng cao cơ chế vận hành thực thi nhiệm vụ. Việc thực hiện sắp xếp, kiện toàn lại tổ chức bộ máy theo hướng tinh gọn, hiệu lực, hiệu quả theo Nghị quyết số 18-NQ/TW của Bộ Chính trị là chủ trương lớn, mang tính lịch sử. Sau hai giai đoạn triển khai, hệ thống ngành Thuế được tổ chức lại thành 34 thuế tỉnh, thành phố, phù hợp với mô hình chính quyền địa phương 2 cấp. Đây không chỉ là sự thay đổi về cơ cấu tổ chức, mà còn là bước đi nhằm đáp ứng yêu cầu đổi mới, nâng cao hiệu quả hoạt động, đóng góp tích cực vào mục tiêu phát triển kinh tế - xã hội của đất nước. Kết quả này là minh chứng rõ nét cho quyết tâm chính trị và nỗ lực hành động của toàn ngành trong việc thực hiện hoá chủ trương lớn của Đảng và Nhà nước về tinh giản bộ máy, đổi mới quản trị công.</p><p>Không chỉ đơn thuần là việc sáp nhập, tổ chức lại mà là bước chuyển dịch lớn nhằm nâng cao hiệu lực, hiệu quả hoạt động của hệ thống thuế, tạo điều kiện để mỗi cán bộ phát huy năng lực, từng bước hiện đại hoá phương thức phục vụ người dân và doanh nghiệp. Đây không chỉ là yêu cầu mang tính chiến lược lâu dài mà còn là đòi hỏi cấp bách trong tiến trình cải cách hành chính, cải cách tài chính công và thúc đẩy chuyển đổi số quốc gia. Tuy nhiên, quá trình tổ chức lại bộ máy không tránh khỏi những khó khăn, vướng mắc nhất định. Việc giảm mạnh số lượng đầu mối quản lý, từ đó đặt ra áp lực không nhỏ về tổ chức lại nhân sự, quy trình vận hành, phân bổ khối lượng công việc và quản lý địa bàn rộng lớn hơn. Trong khi đó, nguồn nhân lực không tăng, thậm chí tinh giản nhân sự, ảnh hưởng đến chất lượng và tâm lý làm việc.</p><p>Nhận diện đúng thực tiễn và để vận hành hiệu quả theo mô hình tổ chức mới, bảo đảm hoạt động thu thuế không bị gián đoạn, góp phần ổn định kinh tế - xã hội địa phương; chúng tôi đưa ra sáng kiến: “Giải pháp nâng cao vai trò và trách nhiệm của Thuế cơ sở khi thực hiện chính quyền địa phương 2 cấp”.</p><p>b. Nội dung sáng kiến</p><p>b.1. Nội dung</p><p>Đổi mới mô hình tổ chức bộ máy của cơ quan thuế là yêu cầu tất yếu trong quá trình cải cách, hiện đại hóa ngành thuế theo tinh thần chỉ đạo của Đảng, Nhà nước. Trong bối cảnh nền kinh tế số và sự thay đổi nhanh chóng của mô hình kinh doanh, cơ quan thuế cần có sự chuyển đổi mạnh mẽ để đảm bảo thực hiện tốt chức năng, nhiệm vụ của mình.</p><p>Với mục tiêu xây dựng một hệ thống thuế hiện đại, tinh gọn, hiệu lực, hiệu quả, đảm bảo quản lý thuế chặt chẽ, minh bạch, hiện đại theo hướng chuyển đổi số mạnh mẽ trong quản lý, tạo thuận lợi tối đa cho người nộp thuế khi thực hiện mô hình tổ chức chính quyền địa phương 2 cấp. Đây là một nhiệm vụ quan trọng, có ý nghĩa quyết định đến sự thành công, vận hành hiệu quả của hệ thống thuế trong thời gian tới và có tính lịch sử cho sự phát triển của ngành Thuế Việt Nam.</p><p>Việc chuyển đổi này đặt ra nhiều thách thức và yêu cầu mới trong công tác quản lý thuế, nhất là đối với cơ quan quản lý thuế tại cấp cơ sở - là đơn vị trực tiếp triển khai công tác quản lý thuế trên địa bàn. Sự thay đổi này không chỉ là một thách thức về tổ chức, nhân lực mà còn là cơ hội để nâng cao hiệu quả phục vụ người nộp thuế.</p><p>Nhận thức rõ tầm quan trọng của vấn đề nêu trên, đồng thời vừa phải bảo đảm công tác quản lý thuế, vừa giải quyết công việc, thủ tục hành chính cho người dân và doanh nghiệp được thông suốt, thuận lợi, không bị gián đoạn trong quá trình chuyển đổi, cũng như kịp thời huy động nguồn thu vào ngân sách nhà nước. Nhóm tác giả đã có sáng kiến đưa ra các giải pháp để nâng cao vai trò và trách nhiệm của Thuế cơ sở khi thực hiện chính quyền địa phương 2 cấp, cụ thể như sau:</p><p>- Một là: Là cầu nối giữa cơ quan thuế và người nộp thuế - đóng vai trò trực tiếp tiếp xúc, hướng dẫn, hỗ trợ doanh nghiệp, hộ kinh doanh, cá nhân kinh doanh và người dân trong thực hiện nghĩa vụ thuế. Là đầu mối tiếp nhận thông tin, phản ánh, kiến nghị từ người nộp thuế để kịp thời báo cáo cấp trên xử lý, tháo gỡ khó khăn, vướng mắc.</p><p>- Hai là: Phối hợp chặt chẽ cùng chính quyền địa phương đảm bảo thủ tục hành chính thống nhất, liên thông, giúp người dân và doanh nghiệp thụ hưởng được chính sách cũng như các thủ tục hành chính về thuế thật nhanh gọn và chính xác.</p><p>- Ba là: Tổ chức triển khai chính sách thuế hiệu quả tại địa phương, cụ thể:</p><p>Tham mưu, phối hợp với các Phòng chức năng của Thuế tỉnh, tổ chức triển khai các quy định mới, truyền tải các chủ trương, chính sách thuế mới đến doanh nghiệp, hộ kinh doanh, cá nhân kinh doanh trên địa bàn.</p><p>Chủ động rà soát, phân loại đối tượng người nộp thuế, đặc biệt là các doanh nghiệp nhỏ và siêu nhỏ, hộ kinh doanh, cá nhân kinh doanh mới phát sinh.</p><p>- Bốn là: Bám sát dự toán được giao, bám sát địa bàn quản lý, chủ động phân tích, dự báo nguồn thu, từ đó triển khai đồng bộ các biện pháp quản lý thu, chống thất thu và thu hồi nợ đọng thuế… đảm bảo công tác thu ngân sách trên địa bàn phải hoàn thành ở mức cao nhất nhiệm vụ được giao.</p><p>- Năm là: Đẩy mạnh công tác thông tin, tuyên truyền ở tất cả các khâu, các bộ phận, các lĩnh vực thông qua việc đổi mới phương thức, phát triển đa dạng, phong phú các hình thức tuyên truyền, giúp người nộp thuế nhanh chóng tiếp cận, nắm được các chính sách thuế hiện hành, chính sách mới ban hành, thủ tục hành chính thuế để người nộp thuế thực hiện tốt các nghĩa vụ về thuế của mình.</p><p>- Sáu là: Chủ động chuyển đổi số trong công tác quản lý thuế theo Ðề án 06 và các chương trình chuyển đổi số của ngành Thuế. Gia tăng hàm lượng công nghệ thông tin, khai thác dữ liệu hóa đơn điện tử kết hợp dữ liệu khai thuế của người nộp thuế và dữ liệu quản lý nhà nước từ các ngành để số hóa toàn diện công tác quản lý thuế trên các lĩnh vực</p><p>- Bảy là: Thực hiện chức năng quản lý thuế tại cơ sở đảm bảo sự liên tục và hiệu quả, nhiệm vụ không chồng chéo, quá trình thực hiện diễn ra thông suốt, không bị gián đoạn. Dù tổ chức bộ máy có thay đổi, trách nhiệm đảm bảo thu đúng, thu đủ và kịp thời vẫn là nhiệm vụ hàng đầu của Thuế cơ sở.</p><p>- Tám là: Tăng cường kỷ luật, kỷ cương nội ngành, chấn chỉnh, nâng cao tinh thần trách nhiệm đội ngũ công chức trong thực thi công vụ; đặc biệt tăng cường giám sát, kiểm tra việc thực hiện các chỉ tiêu phấn đấu liên quan đến công tác chuyên môn, nghiệp vụ trọng tâm của ngành theo Đề án 420.</p><p>- Chín là: Mạnh dạn tiếp thu và lắng nghe ý kiến của người nộp thuế, đánh giá những thuận lợi, khó khăn; luôn là “điểm tựa vững chắc” cho người nộp thuế vượt qua mọi “trăn trở, vướng mắc” khi triển khai mô hình mới. Từ đó đề xuất các giải pháp phù hợp với đặc thù riêng trên địa bàn quản lý nhưng vẫn đảm bảo giữ được nguyên tắc chung.</p><p>- Mười là: Tham mưu kịp thời cho lãnh đạo cơ quan thuế cấp trên những bất cập trong công tác quản lý thuế tại địa bàn. Phân công phân nhiệm rõ ràng trên cơ sở chức năng, nhiệm vụ theo mô hình mới để giải quyết công việc kịp thời, thông suốt. Đồng thời, mỗi công chức thuế phải nêu cao tinh thần trách nhiệm, chủ động thích ứng với sự thay đổi, thực hiện đúng vai trò, nhiệm vụ được phân công trong bối cảnh tổ chức bộ máy mới.</p><p>b.2. Tính mới của sáng kiến</p><p>- Sáng kiến có vai trò rất quan trọng - một trong những mục tiêu cốt lõi của mô hình chính quyền địa phương 2 cấp là tăng cường tính chuyên nghiệp, hiện đại và minh bạch trong quản trị nhà nước, qua đó phục vụ người nộp thuế tốt hơn. Việc tinh gọn bộ máy cho phép đẩy nhanh quá trình ứng dụng công nghệ thông tin, chuyển đổi số toàn diện trong hoạt động điều hành, cung cấp dịch vụ công, từ đó rút ngắn thời gian, giảm chi phí, nâng cao sự hài lòng của người dân và doanh nghiệp.</p><p>- Với phương châm “lấy người dân, doanh nghiệp làm trung tâm phục vụ”,  Thuế cơ sở đã khẳng định vai trò tiên phong trong cải cách hành chính, hiện đại hóa công tác quản lý thuế, đáp ứng yêu cầu của mô hình chính quyền địa phương 2 cấp. Đây là bước chuyển quan trọng, góp phần nâng cao hiệu lực, hiệu quả quản lý thuế, phù hợp với xu thế chuyển đổi số hiện nay.</p><p>- Không còn bộ máy cồng kềnh, trì trệ; không còn quá nhiều “cấp trung gian” làm chậm nhịp điều hành - bộ máy mới đang từng bước hướng tới một nền hành chính điện tử, số hóa toàn diện, minh bạch, hiệu quả và có trách nhiệm giải trình rõ ràng. Người dân và doanh nghiệp giờ đây có thể dễ dàng tiếp cận dịch vụ công qua mạng, phản ánh ý kiến trực tiếp qua các kênh số hóa, tương tác với ngành Thuế được thuận tiện, nhanh chóng và minh bạch hơn bao giờ hết, góp phần đưa đất nước vững vàng bước vào kỷ nguyên phát triển mới - giàu mạnh, thịnh vượng và nhân văn.</p><p>- Tạo được mối quan hệ gắn kết chặt chẽ, mật thiết giữa cơ quan thuế với người nộp thuế; giúp công chức thuế thực hiện nhiệm vụ được dễ dàng, nhanh chóng. Tính tương tác giữa hai bên sẽ được gần gũi, công tác hỗ trợ cũng thiết thực hơn, đúng theo phương châm “Tận tâm lắng nghe - Tận tình hướng dẫn - Tận tụy giải quyết”.</p><p>c. Hiệu quả và phạm vi áp dụng của sáng kiến</p><p>c.1. Hiệu quả</p><p>Qua thực tế áp dụng, sáng kiến đã mang lại hiệu quả cao trong công tác quản lý thuế:</p><p>- Quá trình triển khai vận hành cho thấy mô hình mới cơ bản hoạt động thông suốt, ổn định; các chức năng, nhiệm vụ không chồng chéo, trùng lặp, không làm ảnh hưởng đến việc thực hiện thủ tục hành chính thuế của người dân và doanh nghiệp. Tính đến hết tháng 7/2025, tổng thu ngân sách nhà nước trên địa bàn đạt 262.075 triệu đồng, bằng 67,2% dự toán pháp lệnh và tăng 13,5% so với cùng kỳ năm trước. Kết quả này phản ánh sự nỗ lực của Thuế cơ sở trong việc thích ứng nhanh, vận hành hiệu quả theo mô hình tổ chức mới, bảo đảm hoạt động thu thuế không bị gián đoạn, góp phần ổn định kinh tế - xã hội địa phương.</p><p>- Toàn bộ hệ thống ứng dụng công nghệ của Thuế cơ sở, từ phần mềm quản lý thuế tập trung, hóa đơn điện tử, cổng giao dịch thuế điện tử (eTax), ứng dụng eTax Mobile… đều vận hành ổn định trong mô hình tổ chức mới. Người dân và doanh nghiệp đến thực hiện các thủ tục được hướng dẫn, hỗ trợ, bảo đảm tiến độ xử lý hồ sơ không bị ảnh hưởng.</p><p>- Lấy người nộp thuế làm trung tâm phục vụ là phương châm và nguyên tắc cốt lõi của việc đổi mới bộ máy của Thuế cơ sở. Mặc dù có khối lượng công việc lớn liên quan đến nhân sự, hệ thống công nghệ thông tin, chuyển đổi dữ liệu, chốt sổ sách. Tuy nhiên, quá trình triển khai đã nhận được sự đồng lòng, chung sức của toàn thể hệ thống chính trị tại địa phương và công chức trong toàn đơn vị. Điều này đảm bảo việc vận hành theo mô hình tổ chức bộ máy mới được đồng bộ và thông suốt.</p><p>- Việc tổ chức lại bộ máy Thuế cơ sở không chỉ là cải cách về hình thức, mà còn là thước đo năng lực phục vụ của bộ máy hành chính hiện đại, chuyên nghiệp, tác động tích cực đến chất lượng quản lý và thu ngân sách. Dù nền kinh tế vẫn đang đối mặt với nhiều áp lực, bất lợi từ bên ngoài, tuy nhiên Thuế cơ sở vẫn đảm bảo duy trì được số thu tăng theo từng ngày. Theo đó, chỉ tiêu thu ngân sách hàng tháng tại Thuế cơ sở đều đạt và vượt dự toán cấp trên giao.</p><p>c.2. Phạm vi áp dụng của sáng kiến</p><p>Sáng kiến hiện đang áp dụng tại Thuế cơ sở; với đối tượng cụ thể là tất cả các công chức trong đơn vị và người nộp thuế trên địa bàn 3 phường thuộc Thuế cơ sở 2 tỉnh Cà Mau.</p><p>Khả năng nhân rộng: Sáng kiến có khả năng nhân rộng Thuế tỉnh.</p><p>5. Hội đồng cơ sở đã xét công nhận sáng kiến: Quyết định số 1109/QĐ-CMA, ngày 23/10/2025 của Thuế tỉnh Cà Mau.</p><p>6. Thời gian áp dụng: Từ ngày 01 tháng 04 năm 2025 đến nay./.</p><p>Bạc Liêu, ngày   29   tháng 10 năm 2025</p><p>THUẾ CƠ SỞ 2 TỈNH CÀ MAU	ĐỒNG TÁC GIẢ 1</p><p>PHÓ TRƯỞNG THUẾ</p><p>Trần Thanh Tùng	Bùi Đắc Toái</p><p>ĐỒNG TÁC GIẢ 2</p><p>Ngô Thị Như Quỳnh</p><p>ĐỒNG TÁC GIẢ 3</p><p>Nguyễn Thị Bạch Yến</p>', '4b5969853263336e177df685669640c9f16a363db75112c5b200de6cacb3c2cb', '2026-09-22 22:51:15');

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
(35, 2, 4, 'NOI_BO', 'Phòng TCCB - Thuế tỉnh Cà Mau', 'SK-TCCB-001', 'Kỹ năng xây dựng phương án giao biên chế cho các đơn vị', '', '', '', NULL, 'DA_CHAM', '', NULL, NULL, '2026-09-22 12:39:34', '2026-09-22 12:58:56', 1),
(36, 2, 7, 'NOI_BO', 'Phòng TCCB - Thuế tỉnh Cà Mau', 'SK-TCCB-002', 'Một số giải pháp góp phần nâng cao trách nhiệm công chức thuế trong thực thi công vụ', '', '', '', NULL, 'DA_CHAM', '', NULL, NULL, '2026-09-22 12:40:17', '2026-09-22 12:58:54', 1),
(37, 2, 7, 'NOI_BO', 'Phòng TCCB - Thuế tỉnh Cà Mau', 'SK-TCCB-003', 'Một số giải pháp chủ yếu nhằm làm tốt công tác tư tưởng trước, trong và sau khi sắp xếp tổ chức bộ máy ngành Thuế tỉnh theo Nghị quyết số 18-NQ/TW ngày 25/10/2017 của Ban Chấp hành Trung ương gắn với việc học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh', '', '', '', NULL, 'DA_CHAM', '', NULL, NULL, '2026-09-22 12:43:09', '2026-09-22 12:58:52', 1),
(38, 2, 4, 'NOI_BO', 'Phòng TCCB - Thuế tỉnh Cà Mau', 'SK-TCCB-004', 'Giải pháp nâng cao chất lượng công tác đào tạo, bồi dưỡng công chức ngành Thuế', '', '', '', NULL, 'DA_CHAM', '', NULL, NULL, '2026-09-22 12:49:46', '2026-09-22 12:58:50', 1),
(39, 2, 4, 'NOI_BO', 'TCS7 - Thuế tỉnh Cà Mau', 'SK-TCS7-005', 'Những giải pháp chủ yếu tăng cường kỷ luật lao động và văn hóa công sở tại Thuế cơ sở', '', '', '', NULL, 'DA_CHAM', '', NULL, NULL, '2026-09-22 12:58:18', '2026-09-22 13:17:55', 1),
(40, 2, 3, 'NOI_BO', 'TCS7 - Thuế tỉnh Cà Mau', 'SK-TCS7-006', 'Cải tiến công tác tuyên truyền và hỗ trợ người nộp thuế sau khi sáp nhập cơ quan thuế theo mô hình chính quyền địa phương 2 cấp từ ngày 01/7/2025 Thuế cơ sở', '', '', '', NULL, 'DA_CHAM', '', NULL, NULL, '2026-09-22 13:19:07', '2026-09-22 13:19:07', 1),
(43, 2, 3, 'NOI_BO', 'TCS7 - Thuế tỉnh Cà Mau', 'SK-TCS7-007', 'Một số giải pháp chủ yếu nhằm tuyên truyền, hỗ trợ hạn chế hành vi lừa đảo đối với người nộp thuế tại địa bàn quản lý thuế cơ sở', '', '', '', NULL, 'DA_CHAM', '', NULL, NULL, '2026-09-22 15:32:00', '2026-09-22 15:32:00', 1),
(44, 2, 5, 'NOI_BO', 'TCS7 - Thuế tỉnh Cà Mau', 'SK-TCS7-008', 'Tăng cường giám sát, quản lý đối với doanh nghiệp mới thành lập khi thực hiện đăng ký sử dụng hóa đơn điện tử, nhằm ngăn chặn kịp thời hành vi mua bán hóa đơn bất hợp pháp', '', '', '', NULL, 'DA_CHAM', '', NULL, NULL, '2026-09-22 15:33:28', '2026-09-22 15:33:28', 1),
(51, 2, 3, 'NOI_BO', 'TCS2 - Thuế tỉnh Cà Mau', 'SK-TCS2-009', 'Giải pháp nâng cao vai trò và trách nhiệm của Thuế cơ sở khi thực hiện chính quyền địa phương 2 cấp', '', '', '', NULL, 'DA_CHAM', '', NULL, NULL, '2026-09-22 15:51:15', '2026-09-22 15:51:15', 1);

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT cho bảng `qlsk_file_noi_dung`
--
ALTER TABLE `qlsk_file_noi_dung`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT cho bảng `qlsk_sang_kien_tac_gia`
--
ALTER TABLE `qlsk_sang_kien_tac_gia`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

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
