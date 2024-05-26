-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th5 26, 2024 lúc 10:26 AM
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
-- Cơ sở dữ liệu: `tieccuoitp`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `billdetails`
--

CREATE TABLE `billdetails` (
  `bill_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `item_qty` int(11) DEFAULT NULL,
  `item_notes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `billdetails`
--

INSERT INTO `billdetails` (`bill_id`, `product_id`, `item_qty`, `item_notes`) VALUES
(2, 1, 7, NULL),
(3, 1, 100, 'test bill details 1st'),
(4, 1, 1, ''),
(5, 1, 10, NULL),
(6, 1, 20, NULL),
(7, 1, 20, ''),
(8, 1, 10, 'Ghi chú 1 '),
(11, 1, 10, NULL),
(12, 1, 19, ''),
(13, 1, 19, ''),
(1, 3, 1, NULL),
(7, 3, 25, ''),
(1, 4, 1, NULL),
(2, 4, 3, NULL),
(7, 4, 25, ''),
(8, 4, 10, 'Ghi chú 2'),
(12, 4, 19, ''),
(13, 4, 19, ''),
(2, 5, 2, NULL),
(3, 5, 100, NULL),
(6, 5, 19, NULL),
(7, 5, 25, ''),
(8, 5, 10, 'Ghi chú 3'),
(12, 5, 19, ''),
(13, 5, 19, ''),
(4, 9, 1, NULL),
(6, 9, 19, NULL),
(7, 9, 30, ''),
(8, 9, 10, 'Ghi chú 4 '),
(10, 9, 20, 'ít chua'),
(12, 9, 19, ''),
(13, 9, 19, ''),
(4, 11, 1, NULL),
(7, 11, 30, ''),
(2, 12, 1, NULL),
(6, 12, 19, NULL),
(7, 12, 30, ''),
(8, 12, 10, 'Ghi chú 5'),
(12, 12, 19, ''),
(13, 12, 19, ''),
(1, 13, 22, NULL),
(3, 13, 100, NULL),
(4, 13, 1, NULL),
(4, 14, 1, NULL),
(7, 14, 30, ''),
(9, 15, 1, ''),
(12, 15, 1, ''),
(13, 15, 1, ''),
(11, 18, 1, ''),
(2, 19, 1, NULL),
(11, 20, 5, ''),
(10, 21, 10, ''),
(3, 22, 15, NULL),
(7, 24, 1, ''),
(1, 25, 0, NULL),
(3, 25, 4, NULL),
(4, 25, 1, NULL),
(10, 26, 1, ''),
(10, 29, 1, ''),
(11, 32, 1, ''),
(10, 37, 20, 'Nhiều bơ ít tỏi'),
(9, 38, 25, ''),
(11, 44, 10, ''),
(9, 45, 25, ''),
(10, 45, 20, 'medium'),
(9, 46, 25, ''),
(9, 49, 25, ''),
(10, 49, 20, ''),
(11, 49, 10, ''),
(9, 50, 25, ''),
(10, 52, 20, ''),
(11, 66, 10, ''),
(11, 69, 10, ''),
(9, 75, 1, ''),
(12, 75, 1, ''),
(13, 75, 1, ''),
(10, 78, 1, ''),
(11, 82, 1, ''),
(9, 83, 13, ''),
(12, 83, 10, ''),
(13, 83, 10, ''),
(10, 90, 1, ''),
(12, 91, 1, ''),
(13, 91, 1, ''),
(9, 93, 1, ''),
(11, 94, 1, ''),
(12, 98, 1, ''),
(13, 98, 1, ''),
(10, 100, 1, ''),
(9, 101, 1, 'Hoa lụa cho xe màu xanh dương nhé'),
(12, 103, 1, ''),
(13, 103, 1, ''),
(11, 106, 1, ''),
(12, 108, 19, ''),
(13, 111, 19, ''),
(10, 112, 20, ''),
(11, 113, 10, ''),
(13, 116, 19, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `billstatus`
--

CREATE TABLE `billstatus` (
  `bill_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date_id` int(11) DEFAULT NULL,
  `voucher_id` int(11) DEFAULT NULL,
  `bill_phone` varchar(255) DEFAULT NULL,
  `bill_address` text DEFAULT NULL,
  `bill_when` varchar(255) DEFAULT NULL,
  `bill_discount` int(11) DEFAULT NULL,
  `bill_deposits` int(16) DEFAULT NULL,
  `bill_total` int(20) DEFAULT NULL,
  `bill_notes` varchar(255) DEFAULT NULL,
  `bill_status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `billstatus`
--

INSERT INTO `billstatus` (`bill_id`, `user_id`, `date_id`, `voucher_id`, `bill_phone`, `bill_address`, `bill_when`, `bill_discount`, `bill_deposits`, `bill_total`, `bill_notes`, `bill_status`) VALUES
(2, 0, 0, NULL, '0913654254', '1257 - Nguyen Van Linh - Hung Loi - Ninh Kieu - Can Tho', '01/01/2024 - 08:34', NULL, NULL, 5223000, 'false', 4),
(3, 0, 0, NULL, '0913654254', 'Can Tho - Viet Nam', '23/02/2024 - 14:20', NULL, NULL, 142900000, '', 4),
(4, 0, 0, NULL, '0913654254', '1257 - Nguyen Van Linh - Hung Loi - Ninh Kieu - Can Tho', '14/03/2024 - 20:45', NULL, NULL, 595100000, '', 0),
(5, 0, 0, NULL, '0913654254', '1257 - Nguyen Van Linh - Hung Loi - Ninh Kieu - Can Tho', '14/03/2024 - 20:48', NULL, NULL, 1390000, 'true', 4),
(6, 1, 9, NULL, '0912345678', 'An Khánh - Ninh Kiều - Cần Thơ', '31/03/2024 - 09:48', NULL, 2594100, 25941000, 'Chuẩn bị trước 3 ngày!', 4),
(7, 1, 10, NULL, '0913654254', '04 đường số 9 - KDC Bình Nhựt 2 - An Khánh - Ninh Kiều - Cần Thơ', '22/04/2024 - 15:46', NULL, 5591400, 101925000, NULL, 0),
(8, 1, 11, 1, '0913654254', '04 đường số 9 - KDC Bình Nhựt 2 - An Khánh - Ninh Kiều - Cần Thơ', '24/04/2024 - 21:25', 1000000, 1648000, 16480000, 'Ghi chú bill', 4),
(9, 2, 12, NULL, '0954826468', '123 đường Nguyễn Văn Cừ - An Bình - Ninh Kiều - Cần Thơ', '25/04/2024 - 22:46', 0, 7285000, 72850000, '', 4),
(10, 5, 14, NULL, '0936278462', 'Làng Hoa - Long Hòa - Bình Thủy - Cần Thơ', '29/04/2024 - 21:49', 0, 8386000, 83860000, NULL, 4),
(11, 4, 15, NULL, '09736184781', '629 Nguyễn Văn Linh - Hưng Lợi - Ninh Kiều - Cần Thơ', '30/04/2024 - 21:44', 0, 8878000, 88780000, NULL, 4),
(12, 2, 13, NULL, '0954826468', '123 đường Nguyễn Văn Cừ - An Bình - Ninh Kiều - Cần Thơ', '02/05/2024 - 18:16', 0, 8161200, 81612000, NULL, -1),
(13, 2, 17, 2, '0954826468', '123 đường Nguyễn Văn Cừ - An Bình - Ninh Kiều - Cần Thơ', '02/05/2024 - 20:48', 1000000, 8061200, 92822000, NULL, 3);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cart`
--

CREATE TABLE `cart` (
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `item_qty` int(11) DEFAULT NULL,
  `item_notes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `cart`
--

INSERT INTO `cart` (`user_id`, `product_id`, `item_qty`, `item_notes`) VALUES
(1, 58, 28, ''),
(1, 64, 28, ''),
(1, 67, 28, ''),
(1, 68, 28, ''),
(1, 72, 28, '');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `combo`
--

CREATE TABLE `combo` (
  `combo_id` int(11) NOT NULL,
  `combo_name` varchar(50) NOT NULL,
  `combo_price` int(11) NOT NULL,
  `combo_desc` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `combo`
--

INSERT INTO `combo` (`combo_id`, `combo_name`, `combo_price`, `combo_desc`) VALUES
(1, 'Hương Vị Biển Cả và Núi Rừng', 1748000, 'Sự kết hợp hài hòa giữa hai mảng ẩm thực biển và núi, đem lại trải nghiệm độc đáo và đa chiều cho khách mời.'),
(2, 'Hương Vị Quý Phái', 1948000, 'Tạo ra một ấn tượng cao về sự đa dạng và hấp dẫn của các món ăn được cung cấp trong buổi tiệc cưới.'),
(3, 'Hương Vị Đẳng Cấp', 2028000, ' Sự hòa quyện giữa hương vị truyền thống và hiện đại, đồng thời thể hiện sự sang trọng và lịch lãm trong buổi tiệc cưới.'),
(4, 'Gia Vị Hoàng Gia', 2219000, ' Mang lại cảm giác của sự xa hoa và quý phái, đồng thời tạo ra ấn tượng mạnh mẽ về sự trang trọng và đẳng cấp trong buổi tiệc cưới.');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `combodetails`
--

CREATE TABLE `combodetails` (
  `combo_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `combodetails`
--

INSERT INTO `combodetails` (`combo_id`, `product_id`) VALUES
(1, 1),
(1, 4),
(1, 5),
(1, 9),
(1, 12),
(2, 3),
(2, 5),
(2, 9),
(2, 11),
(2, 12),
(3, 39),
(3, 46),
(3, 47),
(3, 49),
(3, 54),
(4, 58),
(4, 64),
(4, 67),
(4, 68),
(4, 72);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `date`
--

CREATE TABLE `date` (
  `date_id` int(11) NOT NULL,
  `date_date` varchar(20) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `date`
--

INSERT INTO `date` (`date_id`, `date_date`, `user_id`) VALUES
(16, '05-19-2024', 1),
(18, '05-19-2024', 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `datebill`
--

CREATE TABLE `datebill` (
  `date_id` int(11) NOT NULL,
  `date_date` varchar(20) DEFAULT NULL,
  `bill_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `datebill`
--

INSERT INTO `datebill` (`date_id`, `date_date`, `bill_id`) VALUES
(9, '04-30-2024', 6),
(10, '05-11-2024', 7),
(11, '04-12-2024', 8),
(12, '04-29-2024', 9),
(14, '05-01-2024', 10),
(15, '04-30-2024', 11),
(13, '04-27-2024', 12),
(17, '05-19-2024', 13);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `datedetails`
--

CREATE TABLE `datedetails` (
  `dd_id` int(16) NOT NULL,
  `date_id` int(16) NOT NULL,
  `dd_name` int(16) NOT NULL,
  `dd_time` varchar(25) NOT NULL,
  `dd_guest` int(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `datedetails`
--

INSERT INTO `datedetails` (`dd_id`, `date_id`, `dd_name`, `dd_time`, `dd_guest`) VALUES
(29, 9, 1, '10:10', 200),
(30, 10, 1, '10:10', 150),
(31, 10, 2, '12:00', 100),
(34, 0, 1, '16:30', 100),
(35, 11, 1, '16:30', 100),
(36, 12, 1, '10:00', 150),
(37, 12, 2, '12:00', 100),
(38, 13, 1, '10:00', 100),
(46, 14, 1, '08:30', 140),
(48, 14, 2, '18:30', 60),
(49, 0, 1, '19:00', 100),
(50, 0, 1, '18:30', 130),
(51, 15, 1, '18:30', 100),
(52, 0, 1, '10:30', 100),
(53, 16, 1, '10:30', 100),
(54, 16, 2, '12:00', 90),
(55, 16, 3, '17:30', 90),
(56, 13, 2, '11:30', 90),
(57, 17, 1, '10:00', 100),
(58, 17, 2, '11:30', 90);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `post`
--

CREATE TABLE `post` (
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `caption` varchar(255) NOT NULL,
  `hide` int(2) NOT NULL,
  `info` varchar(255) DEFAULT NULL,
  `image` text DEFAULT NULL,
  `post_when` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `post`
--

INSERT INTO `post` (`post_id`, `user_id`, `caption`, `hide`, `info`, `image`, `post_when`) VALUES
(21, 1, 'Tiệc cưới tổ chức rất chu đáo', 0, '#11/5/2024 tại 04 đường số 9 - KDC Bình Nhựt 2 - An Khánh - Ninh Kiều - Cần Thơ', 'http://localhost:8081/uploads/image-1713887013448.jpg', '22:43 - 23/04/2024'),
(22, 1, 'Cửa hàng này oke phếch!', 0, '#30/4/2024 tại An Khánh - Ninh Kiều - Cần Thơ', '', '11:56 - 24/04/2024'),
(23, 2, 'Cửa hàng tốt ', 0, '#29/4/2024 tại 123 đường Nguyễn Văn Cừ - An Bình - Ninh Kiều - Cần Thơ', '', '09:34 - 26/04/2024'),
(24, 4, 'Rất cám ơn cửa hàng đã vô cùng chu đáo - một kỉ niêm tốt đẹp khó quên!', 0, '#30/4/2024 tại 629 Nguyễn Văn Linh - Hưng Lợi - Ninh Kiều - Cần Thơ', 'http://localhost:8081/uploads/image-1714521342103.jpg', '06:55 - 01/05/2024');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product`
--

CREATE TABLE `product` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `product_price` varchar(255) DEFAULT NULL,
  `product_desc` text DEFAULT NULL,
  `product_category` varchar(255) DEFAULT NULL,
  `product_src` varchar(255) DEFAULT NULL,
  `product_mota` varchar(50) NOT NULL,
  `product_style` varchar(20) DEFAULT NULL,
  `product_buy` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `product`
--

INSERT INTO `product` (`product_id`, `product_name`, `product_price`, `product_desc`, `product_category`, `product_src`, `product_mota`, `product_style`, `product_buy`) VALUES
(1, 'Chả Giò Hải Sản Trái Cây', '139000', 'Với hương vị thơm ngon, chả giò hải sản không chỉ là một món khai vị, mà còn là sự kết hợp tinh tế giữa vị ngọt tự nhiên của hải sản và sự đa dạng của các loại rau củ tươi ngon. Mỗi miếng chả giò là một hành trình khám phá hương vị, từ sự tươi ngon của tôm, mực cho đến vị đậm đà của cá, tất cả được gói gọn trong từng miếng vỏ giòn tan.', 'Khai Vị', 'http://localhost:8081/uploads/image-1714678487157.jpg', '', '', 11),
(3, 'Khai Vị Tứ Quý', '139000', 'Tứ Quý không chỉ đơn thuần là một món khai vị, mà là sự kết hợp tài tình giữa các loại nguyên liệu cao cấp: hải sản tươi ngon, thịt bò mềm mại, thảo mộc thơm ngon và các loại rau củ tươi mới. Mỗi miếng Tứ Quý là một tác phẩm nghệ thuật, kết hợp giữa vị ngọt dịu, cay nồng, chua chua, và một chút cay của gia vị, tạo nên một trải nghiệm ẩm thực độc đáo và đầy sức quyến rũ.', 'Khai Vị', 'http://localhost:8081/uploads/image-1714663506535.jpg', '', '', 2),
(4, 'Soup Bào Ngư Vi Cá', '390000', 'Mỗi ngụm soup bào ngư vi cá là một trải nghiệm hoàn hảo cho vị giác, từ hương thơm quyến rũ, hương vị độc đáo của bào ngư cho đến đậm đà, ngọt ngào của nước dùng cá. Món soup này không chỉ làm hài lòng vị giác mà còn là nguồn dưỡng chất quý giá, là sự kết hợp hoàn hảo giữa hương vị truyền thống và sự sáng tạo trong ẩm thực.', 'Món Chính', 'http://localhost:8081/uploads/image-1714663773821.jpg', 'á', '', 0),
(5, 'Lẩu Tứ Xuyên', '590000', 'Lẩu Tứ Xuyên không chỉ đơn thuần là một món ăn, mà là một hành trình khám phá văn hóa ẩm thực sâu sắc. Từ nồng độ gia vị tinh tế đến sự hòa quyện của thịt bò, hải sản, rau củ và các loại nấm, mỗi miếng nguyên liệu khi đưa vào nồi lẩu mang đến một vị giác mới lạ và thú vị.', 'Món Chính', 'http://localhost:8081/uploads/image-1714663784399.jpg', 'á', '', 6),
(9, 'Tôm Càng Sốt Chanh Dây', '490000', 'Mỗi con tôm được chọn lựa cẩn thận, tươi ngon và nguyên chất, khiến món ăn trở nên đặc biệt từ cả về hình thức lẫn hương vị. Sự tươi ngon, ngọt ngào của tôm càng hoà quyện với hương thơm đặc trưng, ngọt dịu, chua chua của chanh dây, tạo nên một sự kết hợp tinh tế giữa hai vị ngon đối lập.', 'Món Chính', 'http://localhost:8081/uploads/image-1714663798693.jpg', 'âu', '', 2),
(11, 'Bò Úc Sốt Rượu Vang', '590000', 'Với thịt bò Úc chất lượng tốt, mềm mại và đặc biệt, kết hợp với hỗn hợp sốt rượu vang được nấu chín đậm đà từ những loại gia vị thượng hạng, món ăn mang lại cảm giác hài hòa, bổ dưỡng và thơm ngon.\n\n', 'Món Chính', 'http://localhost:8081/uploads/image-1714663806876.jpg', 'âu', '', 0),
(12, 'Bánh Tuyết', '139000', 'Bánh tuyết không chỉ thu hút bởi hình dáng trắng tinh khôi, mà còn bởi vị ngọt dịu và sự giòn tan mềm mại khi chạm đến đầu lưỡi. Lớp vỏ mỏng manh, bên trong là nhân bánh béo ngậy, tạo nên sự cân bằng hoàn hảo của vị ngọt và hương vị độc đáo.', 'Tráng Miệng', 'http://localhost:8081/uploads/image-1714663966765.jpg', 'á', '', 1),
(13, 'Chè Hạt Sen Long Nhãn', '139000', 'Với lớp nước ngọt thanh mát, chè hạt sen long nhãn không chỉ mang đậm đà hương vị tự nhiên của sen và long nhãn mà còn là sự kết hợp tinh tế với độ ngọt vừa phải, không gắt cùng với hạt sen dai dai và long nhãn thấm đẫm nước siêu thơm, tạo nên một hòa quyện hương vị tinh tế đầy hấp dẫn.', 'Tráng Miệng', 'http://localhost:8081/uploads/image-1714663981400.jpg', 'á', '', 2),
(14, 'Lẩu Rêu Cua Bắp Bò', '590000', 'Món ăn này không chỉ làm say đắm vị giác bởi hương vị độc đáo mà còn bởi cách biến tấu tinh tế từ các thành phần đơn giản nhất. Rêu cua biển, giàu chất dinh dưỡng và hương vị đặc trưng, hòa quyện với sự thơm ngon của bắp bò, tạo nên một nồi lẩu sôi bùng đầy sức hút.', 'Món Chính', 'http://localhost:8081/uploads/image-1714663817329.jpg', 'á', '', 0),
(15, 'Mẫu 01', '5900000', 'Màu xanh dương mang đến sự bình yên, tĩnh lặng và sự thanh thoát. Trong trang trí gia đình, tone màu này thường được sử dụng để tạo ra không gian thoải mái, gần gũi với thiên nhiên. Bức tranh màu xanh dương không chỉ làm dịu đi ánh nắng mặt trời mà còn tạo ra cảm giác mát mẻ, sảng khoái ngay cả trong những ngày hè nóng bức.', 'Gia Tiên', 'http://localhost:8081/uploads/image-1714664664878.jpg', '', '', 3),
(16, 'Mẫu 02', '5900000', 'Màu trắng tinh khiết tạo cảm giác thoải mái, mở rộng không gian và tạo điểm nhấn cho sự thanh lịch, trong khi ánh vàng ấm áp mang lại sự ấm cúng, quyến rũ cho không gian. Sự kết hợp này không chỉ làm tôn lên vẻ đẹp tự nhiên của các đồ trang trí mà còn làm nổi bật sự sang trọng và đẳng cấp của không gian sống.', 'Gia Tiên', 'http://localhost:8081/uploads/image-1714664672291.jpg', '', '', 0),
(17, 'Mẫu 03', '5900000', 'Tone màu trắng đỏ không chỉ là sự kết hợp màu sắc tinh tế mà còn là biểu tượng của sự hòa quyện giữa sự thanh lịch và sức sống, tạo nên một không gian sống đầy phong cách và ấm cúng.', 'Gia Tiên', 'http://localhost:8081/uploads/image-1714664679955.jpg', '', '', 0),
(18, 'Mẫu 04', '5900000', 'Sự kết hợp này không chỉ làm tăng vẻ đẹp của không gian, mà còn tạo cảm giác thoải mái, êm dịu, khiến bạn cảm nhận được sự yên bình và sự ấm áp của không gian sống. Tone màu trắng hồng mang đến không gian gia đình sự tươi mới, trong lành và đậm chất gia đình, tạo cảm giác bình yên và hạnh phúc cho mọi người.', 'Gia Tiên', 'http://localhost:8081/uploads/image-1714664703835.jpg', '', '', 1),
(19, 'Rạp Trắng ', '600000', 'Màu trắng, với sự tinh tế trong từng chi tiết, tạo nên vẻ đẹp tinh khôi và quý phái. Đèn lấp lánh trên những bức rèm trắng mịn, những bàn ghế được bài trí cẩn thận với hoa và trang trí tinh xảo, tất cả hòa quyện tạo nên không gian tràn ngập sự lãng mạn và lịch lãm. Rạp chè màu trắng không chỉ là nơi chứng kiến những khoảnh khắc đáng nhớ của đôi uyên ương mà còn là điểm nhấn hoàn hảo cho một ngày trọng đại tràn ngập hạnh phúc.', 'Rạp Che', 'http://localhost:8081/uploads/image-1714664148382.jpg', 'trắng', '', 0),
(20, 'Rạp Hồng', '600000', 'Với sắc hồng ngọt ngào lan tỏa khắp không gian, từ trần nhà cho đến các chi tiết nhỏ như bàn ghế, hoa văn và đèn trang trí, rạp chè màu hồng mang đến cảm giác ấm áp và lãng mạn đặc biệt. Bạn sẽ cảm nhận được không khí ngọt ngào và lãng mạn ngay từ khi bước chân vào không gian này, tạo nên những khoảnh khắc đáng nhớ cho ngày cưới của mình.', 'Rạp Che', 'http://localhost:8081/uploads/image-1714664155503.jpg', 'hồng', '', 1),
(21, 'Rạp Tím', '600000', 'Với sắc tím quý phái, rạp chè trở thành nơi kết nối tinh tế giữa lễ cưới truyền thống và không gian hiện đại. Ánh đèn mềm mại, trang trí lộng lẫy và không gian thoải mái, rạp chè màu tím là nơi để tình yêu bừng sáng và những khoảnh khắc ngọt ngào được dành riêng cho đôi uyên ương.', 'Rạp Che', 'http://localhost:8081/uploads/image-1714664163155.jpg', 'tím', '', 1),
(22, 'Rạp Kem', '600000', 'Với sắc màu trung tính nhẹ nhàng, không gian này mang đến cảm giác ấm áp và sang trọng. Những bức rèm mỏng manh và những chiếc đèn lấp lánh như ngôi sao làm nền cho không gian trở nên lãng mạn hơn bao giờ hết. Bàn tiệc trang trí với những bộ bàn ghế màu kem sang trọng và đèn trang trí lung linh, tạo nên bức tranh hoàn hảo cho ngày trọng đại của đôi uyên ương.', 'Rạp Che', 'http://localhost:8081/uploads/image-1714664170173.jpg', 'kem', '', 0),
(23, 'Đỏ Đông Á', '16900000', '\nSảnh tiệc đám cưới này, với sức chứa linh hoạt từ 200 đến 300 khách, là một không gian kỳ diệu nơi mà sắc trắng và đỏ hòa quyện tạo nên một bức tranh đầy lãng mạn và trang trọng. Sự kết hợp của tone màu trắng tinh khiết và đỏ quyến rũ tạo nên sự hài hòa và sang trọng, từ những bức rèm mỏng manh đến bàn tiệc được trang trí cẩn thận', 'Sảnh Tiệc', 'http://localhost:8081/uploads/image-1714664294501.png', '', '', 0),
(24, 'Vàng Đông Á', '16900000', '\nSảnh tiệc đám cưới với sức chứa lên đến 200-300 khách mang đậm nét đẹp sang trọng và lịch lãm, nơi ánh sáng vàng kem từ ánh đèn lung linh lan tỏa khắp không gian, tạo nên bức tranh rực rỡ và ấm áp. Tông màu chủ đạo là vàng kem, từ những chiếc rèm mỏng nhẹ nhàng, những bộ bàn ghế trang trí cầu kỳ cho đến những chiếc đèn treo lấp lánh, tất cả hòa quyện tạo nên không gian trang nhã và quý phái.', 'Sảnh Tiệc', 'http://localhost:8081/uploads/image-1714664285865.png', '', '', 0),
(25, 'Đỏ Châu Âu', '16900000', '\nSảnh tiệc đám cưới này là một biểu tượng của sự thanh lịch và tinh tế, sức chứa từ 200 đến 300 khách một cách thoải mái. Sắc tím và trắng làm chủ đạo, tạo nên không gian sang trọng và quý phái. Đèn trang trí dịu dàng giúp tạo điểm nhấn cho không gian rộng lớn và mang đến ánh sáng ấm áp, khiến mọi khách mời cảm thấy dễ chịu và thoải mái. Những bức rèm mỏng manh, lưới ren tinh tế được sử dụng để tô điểm thêm cho không gian, tạo ra cảm giác mộng mơ và lãng mạn.', 'Sảnh Tiệc', 'http://localhost:8081/uploads/image-1714664275897.png', '', '', 0),
(26, 'Trắng Châu Âu', '16900000', '\nSảnh tiệc đám cưới rộng lớn, có khả năng chứa từ 200 đến 300 khách tại đây là một không gian tuyệt vời được thiết kế với tone màu chủ đạo là xanh lá và trắng, tạo nên một bức tranh tươi mới và tinh tế. Ánh sáng dịu dàng từ những bộ đèn treo trần tạo nên không gian ấm cúng, nhấn nhá cho các chi tiết trang trí đặc biệt. Các bức rèm mỏng manh màu trắng nhe nhàng tung bay, tạo ra sự êm dịu và lãng mạn cho không gian tổ chức tiệc.', 'Sảnh Tiệc', 'http://localhost:8081/uploads/image-1714664266686.png', '', '', 1),
(29, 'Gói Kết Hoa Tiêu Chuẩn', '7800000', 'Mâm quả đám cưới đặc biệt này kết hợp giữa sự ngọt ngào của sô cô la, hương vị đặc trưng của trà rượu, sự tươi mới của trái cây và vẻ đẹp tinh tế của hoa. Bàn quả được bài trí với những đĩa sô cô la hấp dẫn, từ những viên sô cô la trắng tinh khôi đến những miếng sô cô la đen đậm đà, tạo nên sự hòa quyện giữa hương vị và thị giác.', 'Mâm Quả', 'http://localhost:8081/uploads/image-1714664747796.jpg', '', '', 1),
(30, 'Rồng Phụng Tiêu Chuẩn', '8000000', 'Mâm quả đám cưới được sắp xếp theo dáng long phụng, tinh tế và đặc sắc, là sự kết hợp hài hòa giữa bánh ngọt, trái cây tươi và hoa đủ sắc màu. Tạo hình dáng của long phụng, mâm quả này mang trong mình sự tượng trưng về hạnh phúc và thịnh vượng.', 'Mâm Quả', 'http://localhost:8081/uploads/image-1714664756143.jpg', '', '', 0),
(31, 'Lexus', '3900000', 'Bên ngoài, chiếc xe được trang trí đầy ấn tượng với hàng loạt hoa hồng đủ màu, từ đỏ rực rỡ đến trắng tinh khôi, tạo nên một sắc màu rực rỡ và huyền bí trên nền màu trắng tinh khiết của xe. Những bông hoa được bài trí tỉ mỉ từ đầu xe đến phần đuôi, tạo nên một hình ảnh lãng mạn và quý phái.', 'Xe Hoa', 'http://localhost:8081/uploads/image-1714664816975.jpg', '', '', 0),
(32, 'Vinfast ', '2200000', 'Chiếc xe hoa đám cưới màu hồng là biểu tượng của tình yêu ngọt ngào và sự lãng mạn không lẫn vào đâu được. Làm nền cho sự kiện đặc biệt của đôi uyên ương, chiếc xe được trang trí với hàng ngàn bông hoa hồng đủ màu sắc, tạo nên một không gian tuyệt vời, lãng mạn và phong cách.', 'Xe Hoa', 'http://localhost:8081/uploads/image-1714664823497.jpg', '', '', 1),
(36, 'Súp hành tây kiểu Pháp', '139000', 'Sự kết hợp tinh tế giữa hành tây ngọt và béo, cùng với vị ngọt tự nhiên của cà rốt và nước dùng hảo hạng, tạo nên một hương vị đậm đà và phức tạp mà không quá ngấy.', 'Khai Vị', 'http://localhost:8081/uploads/image-1714663522760.jpg', 'âu', NULL, 0),
(37, 'Bánh Mì Bơ Tỏi', '139000', 'Bánh Mì Bơ Tỏi là sự kết hợp tinh tế giữa bánh mì mềm mịn, bơ thơm béo và tỏi thượng hạng. Bánh mì được cắt lát mỏng và nướng giòn giòn, sau đó được thoa lớp bơ thơm ngon và phủ đều với những lát tỏi thái mỏng.', 'Khai Vị', 'http://localhost:8081/uploads/image-1714663542434.jpg', 'âu', NULL, 1),
(38, 'Salad Cá Ngừ', '139000', 'Cá ngừ tươi được cắt thành từng lát mỏng và thường được chiên hoặc nướng để tạo ra lớp vỏ giòn ngon. Sau đó, các lát cá ngừ được trộn chung với các loại rau xanh như rau diếp, cà chua, cà rốt, cần tây, và các loại rau khác để tạo nên sự tươi mát và giàu dinh dưỡng.', 'Khai Vị', 'http://localhost:8081/uploads/image-1714663556595.jpg', 'âu', NULL, 0),
(39, 'Soup Bí Đỏ', '139000', 'Súp bí đỏ được chế biến từ bí đỏ tươi, một loại củ quả giàu vitamin và chất chống oxy hóa. Bí đỏ được hấp chín và xay nhuyễn, sau đó kết hợp với sữa dừa để tạo nên sự mềm mại và cân đối về hương vị.', 'Khai Vị', 'http://localhost:8081/uploads/image-1714663570413.jpg', 'âu', NULL, 0),
(40, 'Salad Cá Hồi', '139000', 'Cá hồi tươi được cắt thành từng lát mỏng và được trang trí trên lớp rau xanh tươi mát như rau cải, rau cỏ và cà rốt. Một số loại hoa quả như dâu, cam và nho cũng có thể được thêm vào để tăng thêm hương vị và màu sắc cho món salad.', 'Khai Vị', 'http://localhost:8081/uploads/image-1714663580805.jpg', 'âu', NULL, 0),
(41, 'Salad Hải Sản', '139000', 'Salad hải sản không chỉ là một lựa chọn lý tưởng cho những người muốn duy trì chế độ ăn uống lành mạnh mà còn là một món ăn hấp dẫn cho bữa tiệc hoặc dịp họp mặt gia đình. Sự tươi ngon, ngọt lịm của hải sản kết hợp với vị chua dịu của sốt salad tạo nên một trải nghiệm ẩm thực đặc biệt, làm hài lòng cả những thực khách khó tính nhất.', 'Khai Vị', 'http://localhost:8081/uploads/image-1714663594578.jpg', 'âu', NULL, 1),
(42, 'Bruschetta Ý', '139000', 'Bruschetta là một món khai vị phổ biến trong ẩm thực Ý, được làm từ lát bánh mì nướng giòn, thường được phết đều với dầu oliu và gào bơ tỏi, sau đó được chế biến với các loại nguyên liệu tươi ngon như cà chua, hành tây, hành tỏi, rau mùi, dầu oliu và muối.', 'Khai Vị', 'http://localhost:8081/uploads/image-1714663605354.jpg', 'âu', NULL, 0),
(43, 'Salad Ức Gà', '139000', 'Với một nền salad tươi mát từ các loại rau xanh như rau cải, rau diếp, cà rốt, cùng với một phần nhỏ các loại rau quả như cà chua, dưa leo, táo, và hành tây, món salad này không chỉ hấp dẫn về màu sắc mà còn giàu chất xơ và vitamin.', 'Khai Vị', 'http://localhost:8081/uploads/image-1714663618839.jpg', 'âu', NULL, 0),
(44, 'Mỳ Ý Sốt Bò Bằm', '490000', 'Sự kết hợp giữa mỳ Ý và sốt bò bằm tạo nên một hương vị độc đáo và thơm ngon. Sốt bò bằm được chế biến từ thịt bò băm nhỏ, hòa quện với các loại rau củ và gia vị tạo nên một hỗn hợp đầy đủ dinh dưỡng và hấp dẫn.', 'Món Chính', 'http://localhost:8081/uploads/image-1714663829404.jpg', 'âu', NULL, 1),
(45, 'Bít Tết Sốt Vang Đỏ', '590000', 'Bít tết được chế biến từ những miếng thịt bò mềm mại, được nướng chín vừa phải để giữ được độ mềm và hương vị tự nhiên của thịt. Sau khi nướng, thịt bò thường được cắt thành từng lát mỏng và sắp xếp trên đĩa.', 'Món Chính', 'http://localhost:8081/uploads/image-1714664924155.jpg', 'âu', NULL, 2),
(46, 'Cá hồi sốt bơ tỏi', '590000', 'Cá Hồi, với thịt thơm ngon và giàu axit béo Omega-3, được chế biến mềm mịn và thấm đẫm hương vị sốt bơ tỏi đặc trưng. Sốt bơ tỏi được làm từ sự kết hợp hài hòa của bơ tươi, tỏi thơm và gia vị đặc biệt, tạo nên hương vị đậm đà và đầy hấp dẫn.', 'Món Chính', 'http://localhost:8081/uploads/image-1714663840831.jpg', 'âu', NULL, 1),
(47, 'Gà tây nướng', '620000', 'Gà tây được chọn lựa kỹ lưỡng, được tẩm ướp với các loại gia vị tự nhiên và thảo mộc tươi thơm. Sau đó, gà được nướng trên lửa than hoặc lò nhiệt độ cao đến khi chín vàng, giữ cho thịt mềm và đậm đà hương vị.', 'Món Chính', 'http://localhost:8081/uploads/image-1714663863837.jpg', 'âu', NULL, 0),
(48, 'Ức Vịt Sốt Cam', '560000', 'Thịt vịt được nấu chín mềm và thấm đẫm hương vị của sốt cam, tạo nên một món ăn hấp dẫn và đầy hứng thú. Hương vị chua chua, ngọt ngọt từ cam kết hợp cùng với thịt vịt thơm ngon tạo ra một trải nghiệm ẩm thực đặc biệt và độc đáo.', 'Món Chính', 'http://localhost:8081/uploads/image-1714663875135.jpg', 'âu', NULL, 0),
(49, ' Chân Giò Hầm Kiểu Đức', '550000', 'Hương vị đặc trưng của món chân giò hầm kiểu Đức thường có sự kết hợp hoàn hảo giữa vị đậm của thịt chân giò, vị ngọt tự nhiên từ rau củ, và hương thơm đặc trưng của các loại gia vị như hành, tỏi, tiêu và lá gia vị.\n\n', 'Món Chính', 'http://localhost:8081/uploads/image-1714663889368.jpg', 'âu', NULL, 3),
(50, 'Kem Xoài Sữa Chua', '129000', 'Kem được làm từ nguyên liệu tự nhiên như trái xoài chín và sữa chua tươi, kết hợp với đường và một chút sữa đặc để tạo ra một hỗn hợp mềm mịn và béo ngậy. Hương vị chua dịu của sữa chua kết hợp cùng vị ngọt của xoài tạo nên một sự cân bằng hài hòa và thú vị.', 'Tráng Miệng', 'http://localhost:8081/uploads/image-1714663990029.jpg', 'âu', NULL, 1),
(51, 'Mini Black Forest', '129000', 'Mỗi chiếc Mini Black Forest được trang trí bằng kem tươi và viên cherry đỏ tươi, tạo nên một hình ảnh đẹp mắt và hấp dẫn. Với hương vị đặc trưng của sô cô la, kem, và cherry, mỗi miếng Mini Black Forest là một trải nghiệm ngon miệng không thể cưỡng lại.', 'Tráng Miệng', 'http://localhost:8081/uploads/image-1714664001025.jpg', 'âu', NULL, 0),
(52, 'Tart Hoa Quả', '129000', 'Tart Hoa Quả là một loại bánh ngọt với lớp vỏ nền giòn tan và nhân kem tươi béo mềm, được trang trí với các loại hoa quả tươi màu sắc như dâu, nho, dừa, kiwi, và nhiều loại trái cây khác nhau. Mỗi miếng tart là một tác phẩm nghệ thuật, với sự kết hợp hài hòa giữa vị ngọt của kem và trái cây, vị chua dịu của nước cốt hoa quả, và vị bùi của lớp vỏ bánh.', 'Tráng Miệng', 'http://localhost:8081/uploads/image-1714664010190.jpg', 'âu', NULL, 1),
(53, 'Bánh Táo Nướng', '129000', 'Bánh Táo Nướng được làm từ những quả táo tươi, thơm ngon, được cắt lát và thưởng thức cùng với lớp vỏ bánh giòn tan ở ngoài và nhân bánh mềm mịn bên trong. Mùi thơm của táo, hòa quyện cùng hương vị của gia vị như đường, bơ, và các loại gia vị như quế, vani tạo nên hương vị đặc trưng cho món bánh này.', 'Tráng Miệng', 'http://localhost:8081/uploads/image-1714664018955.jpg', 'âu', NULL, 0),
(54, 'Bánh Flan', '129000', 'Bánh flan thường được làm từ các nguyên liệu đơn giản như trứng, đường, sữa và vani. Mọi nguyên liệu được kết hợp với nhau và nướng trong nồi nước sôi hoặc lò để tạo ra một lớp kem sữa mịn màng phủ lên lớp nước caramen ngọt ngào dưới đáy.', 'Tráng Miệng', 'http://localhost:8081/uploads/image-1714664040318.jpg', 'âu', NULL, 0),
(55, 'Bánh Crepe', '129000', 'Bánh Crepe không chỉ ngon miệng mà còn rất đa dạng và linh hoạt trong cách chế biến, là sự lựa chọn hoàn hảo cho bất kỳ dịp tiệc cưới nào, từ bữa tiệc lớn đến buổi tiệc nhỏ, hoặc thậm chí là một phần của thực đơn brunch sau buổi lễ cưới.', 'Tráng Miệng', 'http://localhost:8081/uploads/image-1714664029756.jpg', 'âu', NULL, 0),
(56, 'Bánh Su Kem', '129000', 'Bánh Su Kem là một món tráng miệng truyền thống phổ biến trong các buổi tiệc cưới và hỏi hợp, đặc biệt là ở Việt Nam. Đây là một loại bánh ngọt có lớp vỏ ngoài mềm mịn và lớp nhân kem bên trong, tạo nên hương vị béo ngậy và thơm ngon.\n\n', 'Tráng Miệng', 'http://localhost:8081/uploads/image-1714664054002.jpg', 'âu', NULL, 0),
(57, 'Bánh Phô Mai Sữa Chua Nướng', '129000', 'Với lớp vỏ bánh mềm mịn và mềm mại, bánh Phô Mai Sữa Chua Nướng mang đến một trải nghiệm thưởng thức đầy hấp dẫn cho thực khách. Phần nhân phô mai và sữa chua bên trong được làm từ những nguyên liệu tươi ngon, tạo nên lớp nhân kem mịn màng, độc đáo và đậm đà hương vị.', 'Tráng Miệng', 'http://localhost:8081/uploads/image-1714664066325.jpg', 'âu', NULL, 0),
(58, 'Gỏi Tiến Vua Tôm Thịt', '450000', 'Những con tôm tươi ngon được chọn lọc kỹ càng và chế biến thành từng miếng nhỏ, tạo nên hương vị đậm đà và bổ dưỡng. Thịt thăn bò hoặc thịt gà được thái thành những sợi mỏng, thấm đều gia vị, tạo nên lớp nhân thơm ngon và giàu protein.', 'Khai Vị', 'http://localhost:8081/uploads/image-1714663637155.jpg', 'á', NULL, 0),
(59, 'Càng Cua Bách Hoa', '149000', 'Món này được chế biến từ càng cua tươi, được tẩm ướp trong các gia vị đặc trưng và nướng chín tỉnh trên lửa than hồng. Hương thơm tự nhiên của càng cua kết hợp với vị ngọt của gia vị và nướng chín đều tạo nên một hương vị độc đáo và hấp dẫn.', 'Khai Vị', 'http://localhost:8081/uploads/image-1714663668079.jpg', 'á', NULL, 1),
(60, 'Chả Mực Hạ Long', '145000', 'Chả mực được chế biến từ những con mực tươi ngon, được xay nhuyễn và kết hợp cùng các gia vị tự nhiên như hành, tỏi, tiêu và một chút bột mỳ để tạo độ đặc của chả. Sau đó, hỗn hợp được nướng hoặc chiên cho đến khi chả mực trở nên vàng óng, thơm phức.', 'Khai Vị', 'http://localhost:8081/uploads/image-1714663714512.jpg', 'á', NULL, 0),
(61, 'Thịt Nguội Bát Bửu', '140000', 'Thịt nguội bát bửu là sự kết hợp giữa các món châu u và các món nguội Việt Nam như giò lụa, chả quế. Đây có thể là món khai vị dễ thực hiện nhất. Tuy nhiên công đoạn khó thực hiện nhất có lẽ là khả năng trình bày món sao cho đẹp nhất.', 'Khai Vị', 'http://localhost:8081/uploads/image-1714663724274.jpg', 'á', NULL, 0),
(62, 'Sò Huyết Tứ Xuyên', '150000', 'Món này chế biến từ sò huyết, một loại hải sản giàu protein và dưỡng chất, có vị ngọt tự nhiên và thịt giòn ngọt. Sò huyết được tẩm ướp trong các gia vị đặc trưng của vùng Tứ Xuyên như tỏi, ớt, gừng, và các loại gia vị khác, sau đó được chiên hoặc nướng cho đến khi thịt sò huyết chín vàng và thơm phức.', 'Khai Vị', 'http://localhost:8081/uploads/image-1714663735153.jpg', 'á', NULL, 0),
(63, 'Sườn Kinh Đô ', '150000', 'Món sườn kinh đô được cho là tương đối nặng bụng. Tuy nhiên, vị chua ngọt hài hòa của món ăn này lại tạo nên sự kích thích vị giác rất mạnh cho thực khách. Sườn được nướng chín vàng, mềm và ngấm nước sốt. Vị chua ngọt khó cưỡng và nước sốt đậm đà kích thích vị giác của người dùng.', 'Khai Vị', 'http://localhost:8081/uploads/image-1714663749829.jpg', 'á', NULL, 0),
(64, 'Bò Xào Thiên Lý', '530000', 'Thịt bò được xào đều với các gia vị tự nhiên và thơm ngon, tạo nên lớp thịt thơm phức và mềm mại. Thiên lý, một loại rau cải giàu chất dinh dưỡng, được thêm vào để tạo thêm hương vị và sự đa dạng cho món ăn.', 'Món Chính', 'http://localhost:8081/uploads/image-1714663899499.jpg', 'á', NULL, 0),
(65, 'Lẩu Gà Lá É', '560000', 'Khi nước dùng sôi lên, hương thơm của gà, lá é và gia vị lan tỏa khắp không gian, tạo nên một không khí ấm áp và thân thiện. Thực khách sẽ cùng nhau thưởng thức từng miếng gà thơm ngon, đậm đà, cùng với các loại rau củ tươi ngon và các loại nước chấm đặc trưng.', 'Món Chính', 'http://localhost:8081/uploads/image-1714663911983.jpg', 'á', NULL, 0),
(66, 'Mực Chiên Nước Mắm', '570000', 'Mực được chiên giòn ở nhiệt độ cao, tạo ra lớp vỏ giòn tan và màu vàng óng ả hấp dẫn. Khi chiên chín vàng đều, mực sẽ được rắc nước mắm chua ngọt lên trên, tạo nên hương vị đặc trưng và hấp dẫn của món ăn.', 'Món Chính', 'http://localhost:8081/uploads/image-1714663926402.jpg', 'á', NULL, 1),
(67, 'Lẩu Chua Hải Sản', '570000', 'Với Lẩu Hải Sản, bạn sẽ được thưởng thức hải sản đa dạng như tôm, cua, mực, cá và nhiều loại hải sản khác, được nấu trong nước dùng đậm đà từ xương hầm và các gia vị tự nhiên. Hải sản được nêm nếm vừa miệng, tươi ngon và bổ dưỡng.', 'Món Chính', 'http://localhost:8081/uploads/image-1714663936003.jpg', 'á', NULL, 0),
(68, 'Gà Nướng Xôi Bắp', '540000', 'Khi thưởng thức, thực khách sẽ cảm nhận được sự hòa quyện của vị ngọt của xôi bắp và vị đậm đà của thịt gà nướng, tạo nên một trải nghiệm ẩm thực đặc biệt và đầy hấp dẫn. Món \"Gà Nướng Xôi Bắp\" không chỉ là sự kết hợp hoàn hảo giữa hai nguyên liệu chính, mà còn là biểu tượng của sự hạnh phúc và sum vầy trong bữa tiệc cưới.', 'Món Chính', 'http://localhost:8081/uploads/image-1714663943717.jpg', 'á', NULL, 0),
(69, 'Chè Khoai Dẻo Ngũ Sắc', '129000', 'Với màu sắc đa dạng từ các loại khoai dẻo như khoai lang, khoai môn, khoai tím, và khoai lăng, món Chè Khoai Dẻo Ngũ Sắc không chỉ đẹp mắt mà còn mang lại cảm giác thú vị cho người thưởng thức. Mỗi miếng khoai dẻo được tẩm bởi nước cốt dừa thơm ngậy, tạo nên một hương vị độc đáo và khó quên.', 'Tráng Miệng', 'http://localhost:8081/uploads/image-1714664078690.jpg', 'á', NULL, 1),
(70, 'Chè Xoài Nếp Cẩm', '129000', 'Món chè này kết hợp giữa vị ngọt tự nhiên của xoài chín và lớp nếp cẩm thơm béo, tạo nên một hương vị đặc biệt và hấp dẫn. Xoài được thái nhỏ và phủ lên lớp nếp cẩm màu tím đặc trưng, tạo nên một màu sắc bắt mắt và hấp dẫn cho món ăn.', 'Tráng Miệng', 'http://localhost:8081/uploads/image-1714664088166.jpg', 'á', NULL, 0),
(71, 'Chè Hạt Sen Khoai Lang Tím', '129000', 'Với sự kết hợp tinh tế giữa hạt sen mềm mịn, khoai lang tím thơm ngọt, và các loại đậu phộng, dừa tươi, món Chè Hạt Sen Khoai Lang Tím không chỉ làm say đắm thực khách bởi vị ngon lạ miệng mà còn mang lại lợi ích sức khỏe.', 'Tráng Miệng', 'http://localhost:8081/uploads/image-1714664104960.jpg', 'á', NULL, 0),
(72, 'Rau Câu Dâu Đỏ', '129000', 'Sự hòa quện giữa màu sắc rực rỡ của dâu đỏ và độ trong suốt của lớp rau câu tạo nên một hiệu ứng thị giác đẹp mắt, khiến món ăn trở nên hấp dẫn hơn. Mỗi miếng rau câu dẻo mềm kết hợp cùng vị ngọt tự nhiên của dâu đỏ làm cho món ăn trở thành một trải nghiệm thú vị và đáng nhớ cho thực khách.', 'Tráng Miệng', 'http://localhost:8081/uploads/image-1714664114487.jpg', 'á', NULL, 0),
(73, 'Sữa Chua Dẻo', '129000', 'Sự kết hợp giữa sự dẻo dai của sữa chua và hương vị tự nhiên của trái cây tạo nên một trải nghiệm thưởng thức ngon miệng và dễ chịu. Món Sữa Chua Dẻo không chỉ là một lựa chọn lý tưởng cho bữa tiệc cưới, mà còn là một món tráng miệng hoàn hảo cho các dịp lễ hội, buổi họp mặt hay tiệc nhẹ.', 'Tráng Miệng', 'http://localhost:8081/uploads/image-1714664125207.jpg', 'á', NULL, 0),
(74, 'Kem Sữa Dừa', '129000', 'Món Kem Sữa Dừa thường được phục vụ trong những ly hoặc cốc mát lạnh, trang trí bằng những lát dừa tươi hoặc hạt dừa giòn tan. Với vị ngọt dịu, hương thơm đặc trưng của sữa dừa, và độ béo của kem tươi, món kem này là lựa chọn hoàn hảo để kết thúc bữa tiệc hoặc làm một món tráng miệng ngon lành sau bữa ăn.', 'Tráng Miệng', 'http://localhost:8081/uploads/image-1714664135088.jpg', 'á', NULL, 0),
(75, 'Cổng Hoa Xanh Dương Trắng', '1200000', 'Màu sắc độc đáo: Sự kết hợp giữa màu xanh dương dịu mát và màu trắng tinh khôi mang đến vẻ đẹp nhẹ nhàng, thanh lịch, tạo điểm nhấn ấn tượng cho cổng hoa cưới của bạn.\nThiết kế tinh tế: Cổng hoa được thiết kế tỉ mỉ với từng chi tiết hoa lá, tạo nên tổng thể hài hòa và sang trọng.\nChất liệu cao cấp: Sử dụng hoa tươi nhập khẩu cùng phụ kiện chất lượng cao, đảm bảo độ bền đẹp cho cổng hoa trong suốt thời gian diễn ra lễ cưới.\nBiểu tượng ý nghĩa: Màu xanh dương tượng trưng cho sự chung thủy, hòa hợp, mang đến lời chúc cho một cuộc hôn nhân viên mãn, hạnh phúc. Màu trắng đại diện cho sự tinh khiết, trong sáng, thể hiện tình yêu vĩnh cửu của cô dâu chú rể.\nĐội ngũ chuyên nghiệp: TP Hỏi và Cưới sở hữu đội ngũ thợ cắm hoa giàu kinh nghiệm, cam kết mang đến cho bạn cổng hoa cưới đẹp nhất, đáp ứng mọi yêu cầu của khách hàng.', 'Cổng Hoa', 'http://localhost:8081/uploads/image-1714664369661.png', 'trắng xanh', NULL, 3),
(76, 'Cổng Hoa Hồng Đỏ Trắng', '1200000', 'Sự kết hợp hài hòa giữa sắc đỏ rực rỡ của hoa hồng nhung và trắng tinh khôi của hoa hồng tuyết tạo nên một tổng thể ấn tượng, thu hút mọi ánh nhìn.\nNhững bông hoa được sắp xếp khéo léo, tạo thành những đường cong mềm mại, uyển chuyển, mang đến vẻ đẹp lãng mạn và tinh tế cho cổng hoa.\nCổng hoa được tô điểm thêm bằng những phụ kiện trang trí sang trọng như nơ, ruy băng, pha lê,... càng làm nổi bật vẻ đẹp lộng lẫy và đẳng cấp.', 'Cổng Hoa', 'http://localhost:8081/uploads/image-1714664379147.png', 'trắng đỏ', NULL, 0),
(77, 'Cổng Gốc Cây Đỏ Kem', '1200000', 'Đẹp độc đáo, ấn tượng: Cổng Gốc Cây Đỏ Kem mang đến một phong cách trang trí cổng cưới mới lạ, khác biệt so với những mẫu cổng cưới truyền thống.\nSang trọng, tinh tế: Gam màu đỏ kem nhẹ nhàng, ấm áp cùng chất liệu gỗ tự nhiên cao cấp tạo nên vẻ đẹp sang trọng, tinh tế cho ngày trọng đại của bạn.\nBền đẹp, chịu được mọi điều kiện thời tiết: Cổng Gốc Cây Đỏ Kem được làm từ chất liệu gỗ tự nhiên cao cấp, có độ bền cao, chịu được mọi điều kiện thời tiết.\nDễ dàng trang trí: Bạn có thể dễ dàng trang trí Cổng Gốc Cây Đỏ Kem với hoa tươi hoặc hoa lụa tùy theo sở thích và phong cách của mình.\nGiá cả hợp lý: TP Hỏi và Cưới cam kết mang đến cho bạn sản phẩm chất lượng cao với giá cả hợp lý nhất.', 'Cổng Hoa', 'http://localhost:8081/uploads/image-1714664387568.png', 'Đỏ Kem', NULL, 0),
(78, 'Cổng Gỗ Nhẹ Hồng Kem', '1200000', 'Thiết kế tinh tế: Cổng được làm từ gỗ cao cấp, với các đường nét hoa văn tinh tế, mang đến vẻ đẹp sang trọng và đẳng cấp.\nMàu sắc ngọt ngào: Màu hồng kem nhẹ nhàng, kết hợp với màu trắng tinh khôi, tạo nên sự hài hòa và lãng mạn cho không gian cưới.\nDễ dàng di chuyển và lắp đặt: Cổng có cấu trúc nhẹ nhàng, dễ dàng di chuyển và lắp đặt, giúp tiết kiệm thời gian và công sức cho bạn.\nPhù hợp với nhiều phong cách: Cổng Gỗ Nhẹ Hồng Kem phù hợp với nhiều phong cách trang trí đám cưới khác nhau, từ cổ điển đến hiện đại.', 'Cổng Hoa', 'http://localhost:8081/uploads/image-1714664397248.png', 'hồng kem', NULL, 1),
(79, 'Cổng Gỗ Xanh Hồng Trắng', '1200000', 'Cổng gỗ với những đường nét hoa văn tinh tế, được chạm khắc thủ công tỉ mỉ, tạo nên sự sang trọng và đẳng cấp.\nGam màu xanh lá nhẹ nhàng tượng trưng cho sự sinh sôi, nảy nở, mang đến sức sống cho không gian lễ cưới.\nMàu hồng phấn ngọt ngào thể hiện tình yêu lãng mạn, đằm thắm của cặp đôi.\nMàu trắng tinh khôi tượng trưng cho sự thuần khiết, trong sáng và khởi đầu mới cho cuộc sống hôn nhân.', 'Cổng Hoa', 'http://localhost:8081/uploads/image-1714664405377.png', 'xanh hồng trắng', NULL, 0),
(80, 'Cổng Gỗ Xanh Cốm', '1200000', 'Thiết kế cổng đơn giản nhưng tinh tế, với những đường nét hoa văn tinh xảo được chạm khắc tỉ mỉ, tạo điểm nhấn ấn tượng cho không gian tiệc cưới. Cổng Gỗ Xanh Cốm phù hợp với nhiều phong cách trang trí khác nhau, từ hiện đại đến cổ điển, mang đến sự hài hòa và tinh tế cho ngày vui của bạn.', 'Cổng Hoa', 'http://localhost:8081/uploads/image-1714664413067.png', 'xanh', NULL, 0),
(81, 'Cổng Hoa Alu Kem', '1200000', 'Cổng Hoa Alu Kem là sự lựa chọn hoàn hảo cho những cặp đôi mong muốn có một đám cưới sang trọng và đẳng cấp. Chất liệu Alu Kem cao cấp với độ bền cao, khả năng chống gỉ sét và chịu lực tốt, giúp cổng hoa luôn giữ được vẻ đẹp nguyên vẹn theo thời gian.', 'Cổng Hoa', 'http://localhost:8081/uploads/image-1714664420923.png', 'kem', NULL, 0),
(82, 'Cổng Hoa Hồng Trắng', '1200000', 'Cổng Hoa Hồng Trắng được thiết kế với những bông hoa hồng trắng tinh khôi, tượng trưng cho tình yêu trong sáng, thuần khiết và vĩnh cửu. Hoa hồng trắng còn là biểu tượng của sự may mắn, hạnh phúc và an lành, mang đến lời chúc tốt đẹp cho cuộc sống hôn nhân của đôi uyên ương.', 'Cổng Hoa', 'http://localhost:8081/uploads/image-1714664429052.png', 'hồng trắng', NULL, 1),
(83, 'Rạp Trắng Xanh ', '600000', 'Thiết kế hiện đại, sang trọng: Rạp được thiết kế với khung sắt chắc chắn, phủ bạt trắng tinh khôi cùng điểm nhấn là những dải voan xanh nhẹ nhàng, tạo nên vẻ ngoài thanh lịch và tinh tế.\nMàu sắc hài hòa, ý nghĩa: Sự kết hợp giữa màu trắng tinh khôi tượng trưng cho sự thuần khiết, vĩnh cửu và màu xanh hy vọng, tượng trưng cho sức sống và sự khởi đầu mới, mang đến lời chúc cho một hôn nhân viên mãn, hạnh phúc.\nKích thước đa dạng, đáp ứng mọi nhu cầu: TP Hỏi và Cưới cung cấp đa dạng kích thước rạp che trắng xanh phù hợp với mọi không gian và số lượng khách mời.\nChất liệu cao cấp, an toàn: Bạt rạp được làm từ chất liệu cao cấp, chống thấm nước, chống nắng tốt, đảm bảo độ bền đẹp và an toàn cho người sử dụng.\nGiá cả cạnh tranh, dịch vụ chuyên nghiệp: TP Hỏi và Cưới cam kết mang đến cho khách hàng sản phẩm chất lượng với giá', 'Rạp Che', 'http://localhost:8081/uploads/image-1714664177287.png', 'trắng xanh', NULL, 3),
(84, 'Rạp Trắng Hồng', '600000', 'Rạp Trắng Hồng không chỉ là một không gian cưới đẹp mắt mà còn mang ý nghĩa về sự may mắn, hạnh phúc và viên mãn trong tình yêu. Màu trắng tượng trưng cho sự tinh khiết, trong sáng, còn màu hồng tượng trưng cho tình yêu lãng mạn và ngọt ngào. Sự kết hợp hài hòa của hai màu sắc này sẽ mang đến cho bạn một đám cưới thật đặc biệt và đáng nhớ.', 'Rạp Che', 'http://localhost:8081/uploads/image-1714664185046.png', 'trắng hồng', NULL, 0),
(85, 'Rạp Vàng Kem', '600000', 'Thiết kế sang trọng, đẳng cấp: Tông màu vàng kem tinh tế, kết hợp hài hòa với các chi tiết trang trí cầu kỳ, tạo nên một không gian cưới vô cùng ấn tượng.\nChất liệu cao cấp: Khung rạp được làm từ chất liệu cao cấp, đảm bảo độ bền đẹp và an toàn trong suốt thời gian sử dụng.\nThi công chuyên nghiệp: Đội ngũ thi công giàu kinh nghiệm, đảm bảo rạp cưới được dựng đúng tiến độ, đảm bảo tính thẩm mỹ cao nhất.\nGiá cả hợp lý: Tiệc cưới TP Hồ Chí Minh và Cưới luôn cam kết mang đến cho khách hàng mức giá cạnh tranh cùng nhiều ưu đãi hấp dẫn.', 'Rạp Che', 'http://localhost:8081/uploads/image-1714664203714.png', 'vàng kem', NULL, 0),
(86, 'Rạp Đỏ Trắng', '600000', 'Rạp Đỏ Trắng được thiết kế với khung rạp màu đỏ nổi bật, kết hợp cùng phông rạp màu trắng tinh khôi, tạo nên tổng thể hài hòa và thu hút mọi ánh nhìn. Màu đỏ tượng trưng cho sự may mắn, hạnh phúc, trong khi màu trắng thể hiện sự tinh khiết, thanh tao. Sự kết hợp này không chỉ mang đến vẻ đẹp sang trọng, lộng lẫy mà còn gửi gắm lời chúc cho cuộc sống hôn nhân viên mãn, hạnh phúc của đôi uyên ương.', 'Rạp Che', 'http://localhost:8081/uploads/image-1714664211711.png', 'đỏ trắng', NULL, 0),
(87, 'Mẫu 05', '3300000', 'Với kinh nghiệm dày dặn và đội ngũ nhân viên chuyên nghiệp, chúng tôi cam kết mang đến cho bạn dịch vụ trang trí gia tiên hoàn hảo nhất, đáp ứng mọi yêu cầu và sở thích của quý khách.\nMón hàng Tráng Trí Gia Tiên của chúng tôi bao gồm:\nBàn thờ gia tiên: Được thiết kế sang trọng, tinh tế, phù hợp với mọi không gian nhà ở.\nBộ bình, lư, hạc: Chất liệu cao cấp, mạ vàng hoặc chạm khắc tinh xảo, mang đến vẻ đẹp sang trọng và đẳng cấp cho gian thờ.\nĐồ thờ cúng: Đầy đủ các vật dụng cần thiết cho việc thờ cúng gia tiên như mâm bồng, chân nến, đèn cầy, lư hương,...\nHoa tươi: Được tuyển chọn kỹ lưỡng, đảm bảo độ tươi mới và ý nghĩa, góp phần tạo nên không gian thờ cúng thanh tịnh và ấm cúng.\nNgoài ra, chúng tôi còn cung cấp dịch vụ trang trí cổng hoa, backdrop, sân khấu,... theo yêu cầu của quý khách.', 'Gia Tiên', 'http://localhost:8081/uploads/image-1714664713355.png', 'vàng', NULL, 0),
(88, 'Mẫu 06', '3300000', 'Với kinh nghiệm dày dặn và đội ngũ nhân viên chuyên nghiệp, chúng tôi cam kết mang đến cho bạn dịch vụ trang trí gia tiên hoàn hảo nhất, đáp ứng mọi yêu cầu và sở thích của quý khách.\nMón hàng Tráng Trí Gia Tiên của chúng tôi bao gồm:\nBàn thờ gia tiên: Được thiết kế sang trọng, tinh tế, phù hợp với mọi không gian nhà ở.\nBộ bình, lư, hạc: Chất liệu cao cấp, mạ vàng hoặc chạm khắc tinh xảo, mang đến vẻ đẹp sang trọng và đẳng cấp cho gian thờ.\nĐồ thờ cúng: Đầy đủ các vật dụng cần thiết cho việc thờ cúng gia tiên như mâm bồng, chân nến, đèn cầy, lư hương,...\nHoa tươi: Được tuyển chọn kỹ lưỡng, đảm bảo độ tươi mới và ý nghĩa, góp phần tạo nên không gian thờ cúng thanh tịnh và ấm cúng.\nNgoài ra, chúng tôi còn cung cấp dịch vụ trang trí cổng hoa, backdrop, sân khấu,... theo yêu cầu của quý khách.', 'Gia Tiên', 'http://localhost:8081/uploads/image-1714664720721.png', '', NULL, 0),
(89, 'Mẫu 07', '3900000', 'Với kinh nghiệm dày dặn và đội ngũ nhân viên chuyên nghiệp, chúng tôi cam kết mang đến cho bạn dịch vụ trang trí gia tiên hoàn hảo nhất, đáp ứng mọi yêu cầu và sở thích của quý khách.\nMón hàng Tráng Trí Gia Tiên của chúng tôi bao gồm:\nBàn thờ gia tiên: Được thiết kế sang trọng, tinh tế, phù hợp với mọi không gian nhà ở.\nBộ bình, lư, hạc: Chất liệu cao cấp, mạ vàng hoặc chạm khắc tinh xảo, mang đến vẻ đẹp sang trọng và đẳng cấp cho gian thờ.\nĐồ thờ cúng: Đầy đủ các vật dụng cần thiết cho việc thờ cúng gia tiên như mâm bồng, chân nến, đèn cầy, lư hương,...\nHoa tươi: Được tuyển chọn kỹ lưỡng, đảm bảo độ tươi mới và ý nghĩa, góp phần tạo nên không gian thờ cúng thanh tịnh và ấm cúng.\nNgoài ra, chúng tôi còn cung cấp dịch vụ trang trí cổng hoa, backdrop, sân khấu,... theo yêu cầu của quý khách.', 'Gia Tiên', 'http://localhost:8081/uploads/image-1714664728058.png', '', NULL, 0),
(90, 'Mẫu 08', '4300000', 'Với kinh nghiệm dày dặn và đội ngũ nhân viên chuyên nghiệp, chúng tôi cam kết mang đến cho bạn dịch vụ trang trí gia tiên hoàn hảo nhất, đáp ứng mọi yêu cầu và sở thích của quý khách.\nMón hàng Tráng Trí Gia Tiên của chúng tôi bao gồm:\nBàn thờ gia tiên: Được thiết kế sang trọng, tinh tế, phù hợp với mọi không gian nhà ở.\nBộ bình, lư, hạc: Chất liệu cao cấp, mạ vàng hoặc chạm khắc tinh xảo, mang đến vẻ đẹp sang trọng và đẳng cấp cho gian thờ.\nĐồ thờ cúng: Đầy đủ các vật dụng cần thiết cho việc thờ cúng gia tiên như mâm bồng, chân nến, đèn cầy, lư hương,...\nHoa tươi: Được tuyển chọn kỹ lưỡng, đảm bảo độ tươi mới và ý nghĩa, góp phần tạo nên không gian thờ cúng thanh tịnh và ấm cúng.\nNgoài ra, chúng tôi còn cung cấp dịch vụ trang trí cổng hoa, backdrop, sân khấu,... theo yêu cầu của quý khách.', 'Gia Tiên', 'http://localhost:8081/uploads/image-1714664737157.png', '', NULL, 1),
(91, 'Gói 5 Quả Kết Tháp Rồng Phụng', '9900000', 'Đa dạng: Mâm quả cưới hỏi TP Hỏi và Cưới được thiết kế theo phong tục từng vùng miền, với đầy đủ lễ vật truyền thống và hiện đại, đáp ứng mọi nhu cầu của khách hàng.\nChất lượng: Chúng tôi sử dụng nguyên liệu tươi ngon, tuyển chọn kỹ lưỡng, đảm bảo vệ sinh an toàn thực phẩm. Trái cây chín mọng, bánh kẹo thơm ngon, xôi gấc dẻo mịn,... tất cả đều được bày trí đẹp mắt, sang trọng.\nÝ nghĩa: Từng mâm quả đều được sắp xếp với ý nghĩa tốt đẹp, mang lời chúc phúc cho hạnh phúc viên mãn của đôi uyên ương.\nGiá cả hợp lý: TP Hỏi và Cưới luôn mang đến mức giá cạnh tranh cùng nhiều ưu đãi hấp dẫn, giúp quý khách tiết kiệm chi phí cho ngày trọng đại.', 'Mâm Quả', 'http://localhost:8081/uploads/image-1714664763514.png', '', NULL, 2),
(92, 'Gói 9 Quả Kết Tháp Hoa Tươi', '12400000', 'Đa dạng: Mâm quả cưới hỏi TP Hỏi và Cưới được thiết kế theo phong tục từng vùng miền, với đầy đủ lễ vật truyền thống và hiện đại, đáp ứng mọi nhu cầu của khách hàng.\nChất lượng: Chúng tôi sử dụng nguyên liệu tươi ngon, tuyển chọn kỹ lưỡng, đảm bảo vệ sinh an toàn thực phẩm. Trái cây chín mọng, bánh kẹo thơm ngon, xôi gấc dẻo mịn,... tất cả đều được bày trí đẹp mắt, sang trọng.\nÝ nghĩa: Từng mâm quả đều được sắp xếp với ý nghĩa tốt đẹp, mang lời chúc phúc cho hạnh phúc viên mãn của đôi uyên ương.\nGiá cả hợp lý: TP Hỏi và Cưới luôn mang đến mức giá cạnh tranh cùng nhiều ưu đãi hấp dẫn, giúp quý khách tiết kiệm chi phí cho ngày trọng đại.', 'Mâm Quả', 'http://localhost:8081/uploads/image-1714664775459.png', '', NULL, 0),
(93, 'Gói 6 Quả Nâng Cao', '5200000', 'Đa dạng: Mâm quả cưới hỏi TP Hỏi và Cưới được thiết kế theo phong tục từng vùng miền, với đầy đủ lễ vật truyền thống và hiện đại, đáp ứng mọi nhu cầu của khách hàng.\nChất lượng: Chúng tôi sử dụng nguyên liệu tươi ngon, tuyển chọn kỹ lưỡng, đảm bảo vệ sinh an toàn thực phẩm. Trái cây chín mọng, bánh kẹo thơm ngon, xôi gấc dẻo mịn,... tất cả đều được bày trí đẹp mắt, sang trọng.\nÝ nghĩa: Từng mâm quả đều được sắp xếp với ý nghĩa tốt đẹp, mang lời chúc phúc cho hạnh phúc viên mãn của đôi uyên ương.\nGiá cả hợp lý: TP Hỏi và Cưới luôn mang đến mức giá cạnh tranh cùng nhiều ưu đãi hấp dẫn, giúp quý khách tiết kiệm chi phí cho ngày trọng đại.', 'Mâm Quả', 'http://localhost:8081/uploads/image-1714664783287.png', '', NULL, 1),
(94, 'Gói 4 Quả Cơ Bản', '3900000', 'Đa dạng: Mâm quả cưới hỏi TP Hỏi và Cưới được thiết kế theo phong tục từng vùng miền, với đầy đủ lễ vật truyền thống và hiện đại, đáp ứng mọi nhu cầu của khách hàng.\nChất lượng: Chúng tôi sử dụng nguyên liệu tươi ngon, tuyển chọn kỹ lưỡng, đảm bảo vệ sinh an toàn thực phẩm. Trái cây chín mọng, bánh kẹo thơm ngon, xôi gấc dẻo mịn,... tất cả đều được bày trí đẹp mắt, sang trọng.\nÝ nghĩa: Từng mâm quả đều được sắp xếp với ý nghĩa tốt đẹp, mang lời chúc phúc cho hạnh phúc viên mãn của đôi uyên ương.\nGiá cả hợp lý: TP Hỏi và Cưới luôn mang đến mức giá cạnh tranh cùng nhiều ưu đãi hấp dẫn, giúp quý khách tiết kiệm chi phí cho ngày trọng đại.', 'Mâm Quả', 'http://localhost:8081/uploads/image-1714664789951.png', '', NULL, 1),
(95, 'Gói 6 Quả Cơ Bản', '4800000', 'Đa dạng: Mâm quả cưới hỏi TP Hỏi và Cưới được thiết kế theo phong tục từng vùng miền, với đầy đủ lễ vật truyền thống và hiện đại, đáp ứng mọi nhu cầu của khách hàng.\nChất lượng: Chúng tôi sử dụng nguyên liệu tươi ngon, tuyển chọn kỹ lưỡng, đảm bảo vệ sinh an toàn thực phẩm. Trái cây chín mọng, bánh kẹo thơm ngon, xôi gấc dẻo mịn,... tất cả đều được bày trí đẹp mắt, sang trọng.\nÝ nghĩa: Từng mâm quả đều được sắp xếp với ý nghĩa tốt đẹp, mang lời chúc phúc cho hạnh phúc viên mãn của đôi uyên ương.\nGiá cả hợp lý: TP Hỏi và Cưới luôn mang đến mức giá cạnh tranh cùng nhiều ưu đãi hấp dẫn, giúp quý khách tiết kiệm chi phí cho ngày trọng đại.', 'Mâm Quả', 'http://localhost:8081/uploads/image-1714664796409.png', '', NULL, 0),
(96, 'Gói 6 Quả Rồng Phụng', '11400000', 'Đa dạng: Mâm quả cưới hỏi TP Hỏi và Cưới được thiết kế theo phong tục từng vùng miền, với đầy đủ lễ vật truyền thống và hiện đại, đáp ứng mọi nhu cầu của khách hàng.\nChất lượng: Chúng tôi sử dụng nguyên liệu tươi ngon, tuyển chọn kỹ lưỡng, đảm bảo vệ sinh an toàn thực phẩm. Trái cây chín mọng, bánh kẹo thơm ngon, xôi gấc dẻo mịn,... tất cả đều được bày trí đẹp mắt, sang trọng.\nÝ nghĩa: Từng mâm quả đều được sắp xếp với ý nghĩa tốt đẹp, mang lời chúc phúc cho hạnh phúc viên mãn của đôi uyên ương.\nGiá cả hợp lý: TP Hỏi và Cưới luôn mang đến mức giá cạnh tranh cùng nhiều ưu đãi hấp dẫn, giúp quý khách tiết kiệm chi phí cho ngày trọng đại.', 'Mâm Quả', 'http://localhost:8081/uploads/image-1714664806203.png', '', NULL, 0),
(97, 'BMW 320I', '3000000', 'Giá thuê theo lộ trình rước dâu trong ngày. Đã bao gồm hoa lụa trang trí.', 'Xe Hoa', 'http://localhost:8081/uploads/image-1714664830336.png', '', NULL, 0),
(98, 'Con Bọ Cổ Điển', '2800000', 'Giá thuê theo lộ trình rước dâu trong ngày. Đã bao gồm hoa lụa trang trí.', 'Xe Hoa', 'http://localhost:8081/uploads/image-1714664842596.png', '', NULL, 2),
(99, 'Mui Trần Butane', '4500000', 'Giá thuê theo lộ trình rước dâu trong ngày. Đã bao gồm hoa lụa trang trí.', 'Xe Hoa', 'http://localhost:8081/uploads/image-1714664850334.png', '', NULL, 0),
(100, 'Volkswagen Mui Trần', '3700000', 'Giá thuê theo lộ trình rước dâu trong ngày. Đã bao gồm hoa lụa trang trí.', 'Xe Hoa', 'http://localhost:8081/uploads/image-1714664857319.png', '', NULL, 1),
(101, 'Mercedes C200', '2800000', 'Giá thuê theo lộ trình rước dâu trong ngày. Đã bao gồm hoa lụa trang trí.', 'Xe Hoa', 'http://localhost:8081/uploads/image-1714664866955.png', '', NULL, 1),
(102, 'Hoa Lụa Trang Trí', '500000', 'Thuê hoa lụa trang trí xe hoa', 'Xe Hoa', 'http://localhost:8081/uploads/image-1714664873572.png', '', NULL, 0),
(103, 'Xanh Đông Á', '16900000', 'Sảnh tiệc đám cưới này, với sức chứa linh hoạt từ 200 đến 300 khách, là một không gian kỳ diệu nơi mà sắc trắng và đỏ hòa quyện tạo nên một bức tranh đầy lãng mạn và trang trọng. Sự kết hợp của tone màu trắng tinh khiết và đỏ quyến rũ tạo nên sự hài hòa và sang trọng, từ những bức rèm mỏng manh đến bàn tiệc được trang trí cẩn thận.', 'Sảnh Tiệc', 'http://localhost:8081/uploads/image-1714664256359.png', '', NULL, 2),
(104, 'Trắng Đông Á', '16900000', 'Sảnh tiệc đám cưới này, với sức chứa linh hoạt từ 200 đến 300 khách, là một không gian kỳ diệu nơi mà sắc trắng và đỏ hòa quyện tạo nên một bức tranh đầy lãng mạn và trang trọng. Sự kết hợp của tone màu trắng tinh khiết và đỏ quyến rũ tạo nên sự hài hòa và sang trọng, từ những bức rèm mỏng manh đến bàn tiệc được trang trí cẩn thận.', 'Sảnh Tiệc', 'http://localhost:8081/uploads/image-1714664245495.png', '', NULL, 0),
(105, 'Vàng Châu Âu', '16900000', 'Sảnh tiệc đám cưới này, với sức chứa linh hoạt từ 200 đến 300 khách, là một không gian kỳ diệu nơi mà sắc trắng và đỏ hòa quyện tạo nên một bức tranh đầy lãng mạn và trang trọng. Sự kết hợp của tone màu trắng tinh khiết và đỏ quyến rũ tạo nên sự hài hòa và sang trọng, từ những bức rèm mỏng manh đến bàn tiệc được trang trí cẩn thận', 'Sảnh Tiệc', 'http://localhost:8081/uploads/image-1714664236285.png', '', NULL, 0),
(106, 'Hồng Châu Âu', '16900000', 'Sảnh tiệc đám cưới này, với sức chứa linh hoạt từ 200 đến 300 khách, là một không gian kỳ diệu nơi mà sắc trắng và đỏ hòa quyện tạo nên một bức tranh đầy lãng mạn và trang trọng. Sự kết hợp của tone màu trắng tinh khiết và đỏ quyến rũ tạo nên sự hài hòa và sang trọng, từ những bức rèm mỏng manh đến bàn tiệc được trang trí cẩn thận', 'Sảnh Tiệc', 'http://localhost:8081/uploads/image-1714664227350.png', '', NULL, 1),
(107, 'Mẫu 01', '300000', 'Bao gồm 1 bàn, 10 ghế, lụa bao ghế và lụa trải bàn. ', 'Bàn Ghế', 'http://localhost:8081/uploads/image-1714664459845.jpg', 'xanh ', NULL, 0),
(108, 'Mẫu 02', '300000', 'Bao gồm 1 bàn, 10 ghế, lụa bao ghế và lụa trải bàn. ', 'Bàn Ghế', 'http://localhost:8081/uploads/image-1714664466959.jpg', 'xanh', NULL, 1),
(109, 'Mẫu 03', '300000', 'Bao gồm 1 bàn, 10 ghế, lụa bao ghế và lụa trải bàn. ', 'Bàn Ghế', 'http://localhost:8081/uploads/image-1714664476619.jpg', 'trắng', NULL, 0),
(110, 'Mẫu 04', '300000', 'Bao gồm 1 bàn, 10 ghế, lụa bao ghế và lụa trải bàn. ', 'Bàn Ghế', 'http://localhost:8081/uploads/image-1714664485122.jpg', 'đỏ', NULL, 0),
(111, 'Mẫu 05', '300000', 'Bao gồm 1 bàn, 10 ghế, lụa bao ghế và lụa trải bàn. ', 'Bàn Ghế', 'http://localhost:8081/uploads/image-1714664496594.jpg', 'xanh', NULL, 1),
(112, 'Mẫu 06', '300000', 'Bao gồm 1 bàn, 10 ghế, lụa bao ghế và lụa trải bàn. ', 'Bàn Ghế', 'http://localhost:8081/uploads/image-1714664503719.jpg', 'tím', NULL, 1),
(113, 'Mẫu 07', '300000', 'Bao gồm 1 bàn, 10 ghế, lụa bao ghế và lụa trải bàn. ', 'Bàn Ghế', 'http://localhost:8081/uploads/image-1714664510758.jpg', 'hồng', NULL, 1),
(114, 'Mẫu 08', '300000', 'Bao gồm 1 bàn, 10 ghế, lụa bao ghế và lụa trải bàn. ', 'Bàn Ghế', 'http://localhost:8081/uploads/image-1714664519648.jpg', 'đỏ', NULL, 0),
(116, 'Lẩu Cá Tầm Măng Chua', '590000', 'Chuẩn bị cá: Rửa sạch cá, băm thành từng miếng vừa ăn và ướp gia vị với nước mắm, đường, tỏi, hành và ớt. Để cá ướp trong khoảng 15-30 phút để gia vị thấm đều.\nChuẩn bị măng chua: Nếu sử dụng măng chua tươi, hãy rửa sạch và thái nhỏ. Nếu sử dụng măng chua đã được chuẩn bị sẵn, bạn có thể sử dụng luôn.\nChuẩn bị nước dùng: Đun sôi nước dùng từ xương hầm hoặc nước dùng cá, sau đó thêm gia vị như nước mắm, đường, tỏi, hành theo khẩu vị.\nNấu lẩu: Đặt măng chua vào nồi lẩu, sau đó thêm cá và rau sống vào. Đun sôi lẩu cho đến khi cá chín và măng chua mềm. Nêm thêm gia vị nếu cần.\nMâm cơm lẩu: Dọn lẩu ra đĩa, rắc thêm hành lá và ớt băm lên trên mặt để tạo thêm hương vị và màu sắc.\nThưởng thức: Thưởng thức lẩu cá tầm măng chua nóng hổi cùng với cơm trắng và các loại nước chấm yêu thích.', 'Món Chính', 'http://localhost:8081/uploads/image-1714672109799.jpg', '', 'Món Tùy Chọn', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `reset`
--

CREATE TABLE `reset` (
  `rs_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `resetToken` varchar(100) NOT NULL,
  `OTP` varchar(10) NOT NULL,
  `timeLimit` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `staff`
--

CREATE TABLE `staff` (
  `staff_id` int(11) NOT NULL,
  `staff_name` varchar(25) NOT NULL,
  `staff_email` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `staff`
--

INSERT INTO `staff` (`staff_id`, `staff_name`, `staff_email`) VALUES
(3, 'Nguyễn Văn An', 'an.nguyen@example.com'),
(4, 'Trần Nguyên Bảo', 'bao.tran@example.com'),
(5, 'Lê Văn Cường', 'cuong.le@example.com'),
(6, 'Phạm Thị Dung', 'dung.pham@example.com'),
(7, 'Hoàng Văn Duy', 'duy.hoang@example.com'),
(8, 'Huỳnh Thị Hà', 'ha.huynh@example.com'),
(9, 'Phạm Văn Hải', 'hai.phan@example.com'),
(10, 'Vũ Thị Hồng', 'hong.vu@example.com'),
(11, 'Đặng Văn Hùng ', 'hung.dang@example.com'),
(12, 'Bùi Thị Hương', 'huong.bui@example.com'),
(13, 'Đỗ Văn Khải', 'khai.do@example.com'),
(14, 'Hồ Thị Lan ', 'lan.ho@example.com'),
(15, 'Ngô Văn Linh', 'linh.ngo@example.com'),
(16, 'Dương Thị Loan', 'loan.duong@example.com'),
(17, 'Lý Văn Long', 'long.ly@example.com'),
(18, 'Trần Thị Mai', 'mai.tran@example.com'),
(19, 'Nguyên Văn Minh', 'minh.nguyen@example.com'),
(20, 'Trần Thị Ngọc', 'ngoc.tran@example.com'),
(21, 'Phạm Văn Phú', 'phu.pham@example.com'),
(22, 'Hoàng Thị Phương', 'phuong.hoang@example.com'),
(23, 'Lê Văn Quân', 'quan.le@example.com'),
(28, 'Bùi Thị Thủy', 'thuy.bui@example.com'),
(30, 'Hồ Thị Trang', 'trang.ho@example.com'),
(31, 'Ngô Văn Tuấn', 'tuan.ngo@example.com'),
(32, 'Dương Thị Tuyết', 'tuyet.duong@example.com'),
(33, 'Lý Văn Tâm', 'tam.ly@example.com'),
(34, 'Trần Thị Uyên ', 'uyen.tran@example.com'),
(36, 'Trần Thị Vân', 'van.tran@example.com');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `staff_schedule`
--

CREATE TABLE `staff_schedule` (
  `ss_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `ss_date` varchar(15) NOT NULL,
  `ss_time` varchar(11) NOT NULL,
  `bill_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `staff_schedule`
--

INSERT INTO `staff_schedule` (`ss_id`, `staff_id`, `ss_date`, `ss_time`, `bill_id`) VALUES
(1, 3, '04-30-2024', '10:10', 6),
(3, 5, '04-30-2024', '10:10', 6),
(4, 8, '04-30-2024', '10:10', 6),
(5, 4, '04-30-2024', '10:10', 6),
(6, 10, '04-30-2024', '10:10', 6),
(19, 8, '04-29-2024', '10:00', 9),
(20, 8, '04-29-2024', '12:00', 9),
(21, 10, '04-29-2024', '10:00', 9),
(22, 10, '04-29-2024', '12:00', 9),
(23, 9, '04-29-2024', '10:00', 9),
(24, 9, '04-29-2024', '12:00', 9),
(25, 7, '04-29-2024', '10:00', 9),
(26, 7, '04-29-2024', '12:00', 9),
(27, 14, '04-29-2024', '10:00', 9),
(28, 14, '04-29-2024', '12:00', 9),
(29, 17, '04-29-2024', '10:00', 9),
(30, 17, '04-29-2024', '12:00', 9),
(31, 20, '04-29-2024', '10:00', 9),
(32, 20, '04-29-2024', '12:00', 9),
(35, 3, '05-11-2024', '10:10', 7),
(36, 3, '05-11-2024', '12:00', 7),
(37, 4, '05-11-2024', '10:10', 7),
(38, 4, '05-11-2024', '12:00', 7),
(39, 5, '05-11-2024', '10:10', 7),
(40, 5, '05-11-2024', '12:00', 7),
(41, 6, '05-11-2024', '10:10', 7),
(42, 6, '05-11-2024', '12:00', 7),
(43, 7, '05-11-2024', '10:10', 7),
(44, 7, '05-11-2024', '12:00', 7),
(45, 8, '05-11-2024', '10:10', 7),
(46, 8, '05-11-2024', '12:00', 7),
(47, 9, '05-11-2024', '10:10', 7),
(48, 9, '05-11-2024', '12:00', 7);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `user_email` varchar(255) DEFAULT NULL,
  `user_phone` varchar(255) DEFAULT NULL,
  `user_password` varchar(255) DEFAULT NULL,
  `user_address` varchar(255) DEFAULT NULL,
  `user_status` varchar(10) NOT NULL,
  `user_avt` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `user`
--

INSERT INTO `user` (`user_id`, `user_name`, `user_email`, `user_phone`, `user_password`, `user_address`, `user_status`, `user_avt`) VALUES
(0, 'Nguyễn Văn A', 'vana@gmail.com', '0123456789', '123456789@', '1257 - Nguyen Van Linh - Hung Loi - Ninh Kieu - Can Tho', 'active', 'http://localhost:8081/uploads/image-1713705036580.jpg'),
(1, 'Đặng Tấn Phát', 'dangphat2002@gmail.com', '0913654254', '123456789@', 'số 14 - Nguyễn Văn Linh - An Khánh - Ninh Kiều - Cần Thơ - Việt Nam', 'active', 'http://localhost:8081/uploads/image-1713864635485.jpg'),
(2, 'Phan Thị Ngọc Hiền', 'ngochienphan@gmail.com', '0954826468', '123456789@', '123 đường Nguyễn Văn Cừ - An Bình - Ninh Kiều - Cần Thơ', 'active', 'http://localhost:8081/uploads/image-1713707507670.png'),
(3, 'Trương Văn Lâm', 'truonglam@gmail.com', '0983926836', '123456789@', '843 Cách Mạng Tháng Tám - Cái Khế - Ninh Kiều - Cần Thơ', 'active', 'http://localhost:8081/uploads/image-1714143565706.jpg'),
(4, 'Võ Thị Mỹ Linh', 'mylinh03@gmail.com', '09736184781', '123456789@', '629 Nguyễn Văn Linh - Hưng Lợi - Ninh Kiều - Cần Thơ', 'active', 'http://localhost:8081/uploads/image-1713707608568.png'),
(5, 'Dương Quốc Thái', 'quocthai1307@gmail.com', '0936278462', '123456789@', 'Làng Hoa - Long Hòa - Bình Thủy - Cần Thơ', 'active', 'http://localhost:8081/uploads/image-1714143521198.jpg'),
(6, 'Lương Phong Ninh', 'ninhpl@gmail.com', '0937264237', '123456789@', 'Bà Bộ - Long Tuyền - Bình Thủy - Cần Thơ', 'active', 'http://localhost:8081/uploads/image-1714143537112.jpg'),
(7, 'Lê Chí Khanh', 'ckhanhle@gmail.com', '0962781638', '123456789@', '132/32 đường 3/2-Hưng - Ninh Kiều - Cần Thơ', 'active', 'http://localhost:8081/uploads/image-1713705036580.jpg'),
(8, 'Phạm Lộc Nguyên', 'nguyenpham@gmail.com', '0927361836', '123456789@', '132/32 đường 3/2 - Hưng Lợi - Ninh Kiều - Cần Thơ', 'active', 'http://localhost:8081/uploads/image-1713705036580.jpg'),
(9, 'Lê Hoàng Thân', 'philo133ct@gmail.com', '0946291449', '123456789@', '162 Võ Văn Kiệt - Long Hòa - Bình Thủy - Cần Thơ', 'active', 'http://localhost:8081/uploads/image-1713705036580.jpg');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `vnpay`
--

CREATE TABLE `vnpay` (
  `vn_id` int(11) NOT NULL,
  `Amount` varchar(50) NOT NULL,
  `BankCode` varchar(50) NOT NULL,
  `BankTranNo` varchar(50) NOT NULL,
  `CardType` varchar(50) NOT NULL,
  `OrderInfo` varchar(50) NOT NULL,
  `PayDate` varchar(50) NOT NULL,
  `ResponseCode` varchar(50) NOT NULL,
  `TmnCode` varchar(50) NOT NULL,
  `TransactionNo` varchar(50) NOT NULL,
  `TransactionStatus` varchar(50) NOT NULL,
  `TxnRef` varchar(50) NOT NULL,
  `SecureHash` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `vnpay`
--

INSERT INTO `vnpay` (`vn_id`, `Amount`, `BankCode`, `BankTranNo`, `CardType`, `OrderInfo`, `PayDate`, `ResponseCode`, `TmnCode`, `TransactionNo`, `TransactionStatus`, `TxnRef`, `SecureHash`) VALUES
(4, '259410000', 'NCB', 'VNP14382360', 'ATM', 'TP Hỏi Cưới - Thanh Toán Cọc cho hóa đơn #6', '20240417145523', '00', 'NRZP8P0T', '14382360', '00', 'TPno6in17145334', '1631f290c3a708921e09e5f5d7fccb48d1e9cb169743b91fb4ad71d1388410ec518daefece3ef107640f0f3275dcc4db885407a2f43791d299560f76fd6fea71'),
(5, '2334690000', 'NCB', 'VNP14382398', 'ATM', 'TP Hỏi Cưới - Thanh Toán Kết Sổ cho hóa đơn #6', '20240417150828', '00', 'NRZP8P0T', '14382398', '00', 'TPno6in17150802', '58184e68ce5fa37e9a0e3f5f4a408280e6da12ad95172bc82ccb7bfa27c41199e3706241f9862a9fbe9115c65c0cf7e594f434cd999eac94e47208f341443172'),
(6, '243800000', 'NCB', 'VNP14384170', 'ATM', 'TP Hỏi Cưới - Thanh Toán Cọc cho hóa đơn #7', '20240419100748', '00', 'NRZP8P0T', '14384170', '00', 'TPno7in19100722', '47565c2ba85a0e69f2638d5a7c4763d622c4e3c878064f467929237191b5cd5a388cf9235d9526b3d40e3c7cf2ee12ca70dcaafad5f0e7fd3dc7159c106371c0'),
(7, '728500000', 'NCB', 'VNP14393133', 'ATM', 'TP Hỏi Cưới - Thanh Toán Cọc cho hóa đơn #9', '20240425225334', '00', 'NRZP8P0T', '14393133', '00', 'TPno9in25225238', '6e2a2ceb833fe3312e9352f60bc6efd428570f90d1be871b4bcb9acf62bda83c7cf1212fc433b6666019176f6644e63726a8b4b812fdbfb5939aac63a1648f57'),
(8, '164800000', 'NCB', 'VNP14394257', 'ATM', 'TP Hỏi Cưới - Thanh Toán Cọc cho hóa đơn #8', '20240426194233', '00', 'NRZP8P0T', '14394257', '00', 'TPno8in26194206', '3aec9f125335e396dcb98768c3340d134a7e5a9e48d7c645cd3127d8db3317e448350d5b0585e8e9ceb67a5227ae6089515fc73455eb3321bb9b666d37539b13'),
(9, '164800000', 'NCB', 'VNP14394257', 'ATM', 'TP Hỏi Cưới - Thanh Toán Cọc cho hóa đơn #8', '20240426194233', '00', 'NRZP8P0T', '14394257', '00', 'TPno8in26194206', '3aec9f125335e396dcb98768c3340d134a7e5a9e48d7c645cd3127d8db3317e448350d5b0585e8e9ceb67a5227ae6089515fc73455eb3321bb9b666d37539b13'),
(10, '7547400000', 'NCB', 'VNP14396517', 'ATM', 'TP Hỏi Cưới - Thanh Toán Kết Sổ cho hóa đơn #10', '20240430204143', '00', 'NRZP8P0T', '14396517', '00', 'TPno10in30204117', 'ee40870f1cd3b929107a878619334ad594a3cce567caf39e023229c72288239d98c0cccfb96a57c19da558953927bf53c79776dec430ae25f2fabaa33b43dea6');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `voucher`
--

CREATE TABLE `voucher` (
  `vc_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `vc_value` int(11) NOT NULL,
  `vc_status` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `voucher`
--

INSERT INTO `voucher` (`vc_id`, `user_id`, `vc_value`, `vc_status`) VALUES
(1, 1, 1000000, 1),
(2, 2, 1000000, 0),
(3, 5, 1000000, 1),
(4, 5, 1000000, 1);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `billdetails`
--
ALTER TABLE `billdetails`
  ADD PRIMARY KEY (`product_id`,`bill_id`);

--
-- Chỉ mục cho bảng `billstatus`
--
ALTER TABLE `billstatus`
  ADD PRIMARY KEY (`bill_id`);

--
-- Chỉ mục cho bảng `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`user_id`,`product_id`);

--
-- Chỉ mục cho bảng `combo`
--
ALTER TABLE `combo`
  ADD PRIMARY KEY (`combo_id`);

--
-- Chỉ mục cho bảng `combodetails`
--
ALTER TABLE `combodetails`
  ADD PRIMARY KEY (`combo_id`,`product_id`);

--
-- Chỉ mục cho bảng `date`
--
ALTER TABLE `date`
  ADD PRIMARY KEY (`date_id`);

--
-- Chỉ mục cho bảng `datedetails`
--
ALTER TABLE `datedetails`
  ADD PRIMARY KEY (`dd_id`);

--
-- Chỉ mục cho bảng `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`post_id`);

--
-- Chỉ mục cho bảng `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`);

--
-- Chỉ mục cho bảng `reset`
--
ALTER TABLE `reset`
  ADD PRIMARY KEY (`rs_id`);

--
-- Chỉ mục cho bảng `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staff_id`);

--
-- Chỉ mục cho bảng `staff_schedule`
--
ALTER TABLE `staff_schedule`
  ADD PRIMARY KEY (`ss_id`);

--
-- Chỉ mục cho bảng `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- Chỉ mục cho bảng `vnpay`
--
ALTER TABLE `vnpay`
  ADD PRIMARY KEY (`vn_id`);

--
-- Chỉ mục cho bảng `voucher`
--
ALTER TABLE `voucher`
  ADD PRIMARY KEY (`vc_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `date`
--
ALTER TABLE `date`
  MODIFY `date_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT cho bảng `datedetails`
--
ALTER TABLE `datedetails`
  MODIFY `dd_id` int(16) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT cho bảng `post`
--
ALTER TABLE `post`
  MODIFY `post_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT cho bảng `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;

--
-- AUTO_INCREMENT cho bảng `reset`
--
ALTER TABLE `reset`
  MODIFY `rs_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `staff`
--
ALTER TABLE `staff`
  MODIFY `staff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT cho bảng `staff_schedule`
--
ALTER TABLE `staff_schedule`
  MODIFY `ss_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT cho bảng `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `vnpay`
--
ALTER TABLE `vnpay`
  MODIFY `vn_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `voucher`
--
ALTER TABLE `voucher`
  MODIFY `vc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
