## Giới thiệu
Đây là ứng dụng bán hoa tươi sử dụng Flutter framework và ngôn ngữ Dart cho giao diện và chức năng, cùng với Angular cho trang Admin trên nền web. Database sử dụng là MongoDB và API được viết bằng Node.js với Swagger UI để quản lý API.

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
- Cập nhật đường dẫn file Certificated trong app.js theo địa chỉ của thiết bị của bạn.
- Thay đổi địa chỉ IPv4 trong file http.service.dart để phù hợp với cấu hình mạng của bạn.  

## Hình ảnh minh họa

### 1. SignUp/SignIn
![SignUp/SignIn](https://firebasestorage.googleapis.com/v0/b/shopdt-5c0d7.appspot.com/o/images_4_git%2Fsignup-in.png?alt=media&token=889dd899-b019-4190-ac5a-0c9ac06d9dc8)

### 2. ForgotPassword
![ForgotPassword](https://firebasestorage.googleapis.com/v0/b/shopdt-5c0d7.appspot.com/o/images_4_git%2FForgotPass.png?alt=media&token=f98bc9ab-bcef-4083-9104-202b91aa8a2b)

### 3. Product & Cart
![Product & Cart](https://firebasestorage.googleapis.com/v0/b/shopdt-5c0d7.appspot.com/o/images_4_git%2Fproduct-cart.png?alt=media&token=3a5d9f0f-dffe-45ab-8f6f-c76a4f111258)

### 4. Payment
![Payment](https://firebasestorage.googleapis.com/v0/b/shopdt-5c0d7.appspot.com/o/images_4_git%2Fpayment.png?alt=media&token=7cb729c0-48e8-48cf-a42c-2679e1b4b425)

### 5. Setting
![Setting](https://firebasestorage.googleapis.com/v0/b/shopdt-5c0d7.appspot.com/o/images_4_git%2FSetting.png?alt=media&token=7274fb48-7582-415e-9205-be7b8f9a9c80)

### 6. MainPage & Profile
![MainPage](https://firebasestorage.googleapis.com/v0/b/shopdt-5c0d7.appspot.com/o/images_4_git%2Fmainpage_profile_history.png?alt=media&token=55a5ec4c-bb95-4742-90d6-50e230940ff9)

### 7. AdminPage
![AdminPage-1](https://firebasestorage.googleapis.com/v0/b/shopdt-5c0d7.appspot.com/o/images_4_git%2Fadmin-1.png?alt=media&token=3bbbfff0-b768-4730-8f3f-e1b7abac871e)
![AdminPage-2](https://firebasestorage.googleapis.com/v0/b/shopdt-5c0d7.appspot.com/o/images_4_git%2Fadmin-2.png?alt=media&token=5814ae80-c258-4cce-a779-9194c49ffb0b)
![AdminPage-3](https://firebasestorage.googleapis.com/v0/b/shopdt-5c0d7.appspot.com/o/images_4_git%2Fadmin-3.png?alt=media&token=22046e3c-8174-4936-b1fb-0ad95c6ff947)
![AdminPage-4](https://firebasestorage.googleapis.com/v0/b/shopdt-5c0d7.appspot.com/o/images_4_git%2Fadmin-4.png?alt=media&token=24340079-5fa3-47e9-b6d2-09a7e384f2d7)
### 8. Link
\![Figma](https://www.figma.com/design/7oUB4cNUNTOeKkrmdON7Nu/4-Man-Flower?node-id=0-1)
\![Video Youtube show app](https://www.youtube.com/watch?v=pr1SE9kJ89o)
## Lưu ý
Đảm bảo rằng mọi phần mềm cần thiết đã được cài đặt trên máy tính của bạn, bao gồm Flutter, Angular CLI, Node.js, và MongoDB.

## Liên hệ
Để biết thêm thông tin, xin vui lòng liên hệ tôi hoặc mở một issue trên trang GitHub của dự án.
