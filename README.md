## Giới thiệu
Đây là ứng dụng bán hoa tươi sử dụng Flutter và Dart cho giao diện và chức năng, cùng với Angola cho trang Admin trên nền web. Database sử dụng là MongoDB và API được viết bằng Node.js với Swagger UI để quản lý API.

## Tính năng

- **Ứng dụng bán hàng:**
  - Trang chủ
  - Chi tiết sản phẩm
  - Danh mục sản phẩm
  - Sản phẩm theo danh mục
  - Giỏ hàng offline (sử dụng SQLite để lưu trữ)  
  - Quản lý hồ sơ người dùng
  - Sản phẩm yêu thích
  - Lịch sử đơn hàng
  - Xác nhận đơn hàng qua mail
  - Quên mật khẩu (OTP qua mail)

- **Trang Admin:**
  - CRUD cho sản phẩm
  - CRUD cho danh mục
  - CRUD cho người dùng
  - CRUD cho đơn hàng

## Cài đặt

### 1. Clone project
git clone https://github.com/NhaDuX/NhaDuX-Flower-Store-Flutter-NodeJS-MongoAtlas.git



### 2. Cài đặt và khởi chạy API
cd API
npm install
node ./swagger.js



### 3. Cài đặt và khởi chạy Admin
cd Admin
ng serve --o



### 4. Cài đặt và khởi chạy ứng dụng Flutter
cd App
flutter run



### 5. Cấu hình
- Cập nhật đường dẫn file Certificated trong `app.js` theo địa chỉ của thiết bị của bạn.
- Thay đổi địa chỉ IPv4 trong file `http.service.dart` để phù hợp với cấu hình mạng của bạn.

## Lưu ý
Đảm bảo rằng mọi phần mềm cần thiết đã được cài đặt trên máy tính của bạn, bao gồm Flutter, Angular CLI, Node.js, và MongoDB.


## Liên hệ
Để biết thêm thông tin, xin vui lòng liên hệ tôi hoặc mở một issue trên trang GitHub của dự án.

---
