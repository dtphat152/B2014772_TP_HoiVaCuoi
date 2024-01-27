-- database name: "tpstore"

CREATE TABLE product( 
    product_id INT(11) PRIMARY KEY AUTO_INCREMENT, 
    product_name VARCHAR(255), 
    product_price VARCHAR(255),
    product_desc VARCHAR(500),
    product_category VARCHAR(255),
    product_src VARCHAR(255),
) ENGINE=INNODB;

INSERT INTO product (product_name, product_price, product_desc, product_category, product_src)
VALUES("iPhone 15", "1000", "iPhone 15 là mẫu điện thoại cao cấp được Apple cho ra mắt vào tháng 09/2023, máy nhận được nhiều sự chú ý đến từ người dùng khi mang trong mình bộ cấu hình cực khủng, vẻ ngoài thu hút cùng khả năng quay video - chụp ảnh đỉnh cao.", "phone", "phone/iphone-15.jpg"),
("iPhone 15 Plus", "1119","iPhone 15 Plus thu hút mọi ánh nhìn ngay khi ra mắt nhờ có vẻ ngoài cao cấp, trang bị bộ xử lý mạnh mẽ, cụm camera kép đặc trưng cho khả năng chụp ảnh cực nét cùng màn hình chất lượng cao, để bạn tận hưởng trải nghiệm sử dụng tuyệt vời. ","phone", "phone/iphone-15-plus.jpg"),
("iPhone 15 Pro", "1400", "Cuối cùng thì iPhone 15 Pro cũng đã chính thức ra mắt vào tháng 09/2023 sau nhiều đồn đoán trong thời gian qua. Ở lần ra mắt này Apple mang đến một chiếc máy với vẻ ngoài cứng cáp đẹp mắt, một khả năng quay video chuyên nghiệp đi cùng bộ cấu hình cực khủng - hàng đầu phân khúc điện thoại hiện nay.", "phone", "phone/iphone-15-pro.jpg"),
("iPhone 14 Pro Max", "1440","iPhone 14 Pro Max một siêu phẩm trong giới smartphone được nhà Táo tung ra thị trường vào tháng 09/2022. Máy trang bị con chip Apple A16 Bionic vô cùng mạnh mẽ, đi kèm theo đó là thiết kế màn hình mới, hứa hẹn mang lại những trải nghiệm đầy mới mẻ cho người dùng iPhone.","phone", "phone/iphone-14-pro-max.jpg"),
("iPhone 14 Plus", "920","Sau nhiều thế hệ điện thoại của Apple thì cái tên “Plus” cũng đã chính thức trở lại vào năm 2022 và xuất hiện trên chiếc iPhone 14 Plus 128GB, nổi trội với ngoại hình bắt trend cùng màn hình kích thước lớn để đem đến không gian hiển thị tốt hơn cùng cấu hình mạnh mẽ không đổi so với bản tiêu chuẩn.","phone", "phone/iPhone-14-plus.jpg"),
("iPhone 14", "820","iPhone 14 128GB được xem là mẫu smartphone bùng nổ của nhà táo trong năm 2022, ấn tượng với ngoại hình trẻ trung, màn hình chất lượng đi kèm với những cải tiến về hệ điều hành và thuật toán xử lý hình ảnh, giúp máy trở thành cái tên thu hút được đông đảo người dùng quan tâm tại thời điểm ra mắt.","phone", "phone/iPhone-14.jpg"),
("iPhone 13", "720","Trong khi sức hút đến từ bộ 4 phiên bản iPhone 12 vẫn chưa nguội đi, thì hãng điện thoại Apple đã mang đến cho người dùng một siêu phẩm mới iPhone 13 với nhiều cải tiến thú vị sẽ mang lại những trải nghiệm hấp dẫn nhất cho người dùng.","phone", "phone/iphone-13.jpg");


CREATE TABLE user( 
    user_id INT(11) PRIMARY KEY AUTO_INCREMENT, 
    user_name VARCHAR(255), 
    user_email VARCHAR(255),
    user_phone VARCHAR(255),
    user_password VARCHAR(255),
    user_birth VARCHAR(255),
    user_gender VARCHAR(255)
) ENGINE=INNODB;


CREATE TABLE cart (
  user_id INT,
  product_id INT,
  item_qty INT,
  primary key (user_id, product_id)
);


CREATE TABLE billdetails (
  bill_id INT,
  product_id INT,
  item_qty INT,
  primary key (bill_id, product_id)
);

CREATE TABLE billstatus (
  bill_id INT,
  user_id INT,
  bill_phone VARCHAR(255),
  bill_address TEXT,
  bill_when VARCHAR(255),
  bill_method VARCHAR(255),
  bill_discount INT,
  bill_delivery INT,
  bill_total INT,
  bill_paid VARCHAR(255),
  bill_status INT,
  primary key (bill_id)
);