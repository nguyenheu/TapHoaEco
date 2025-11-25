# Tạp Hoá Eco – iOS SwiftUI Application

Tạp Hoá Eco là ứng dụng mua sắm tạp hoá trực tuyến được xây dựng bằng SwiftUI theo kiến trúc MVVM, mô phỏng các tính năng thực tế của một ứng dụng thương mại điện tử: xem sản phẩm, thêm vào giỏ hàng, thanh toán, quản lý tài khoản, đánh giá và theo dõi đơn hàng.

Dự án được phát triển nhằm rèn luyện khả năng xây dựng ứng dụng iOS hoàn chỉnh, có khả năng mở rộng và triển khai thực tế.

---

## 🚀 Tính năng chính

### 🏠 Home

* Xem danh sách sản phẩm
* Xem chi tiết sản phẩm
* Banner & Section gợi ý

### 🔍 Explore

* Duyệt các danh mục sản phẩm
* Xem sản phẩm theo từng danh mục

### ❤️ Favourite

* Lưu và xoá sản phẩm yêu thích

### 🧺 Cart

* Xem giỏ hàng
* Chọn địa chỉ giao hàng
* Chọn phương thức thanh toán
* Áp dụng mã giảm giá
* Thanh toán & xác nhận đơn hàng

### 👤 Tài khoản người dùng

* Xem & chỉnh sửa thông tin cá nhân
* Quản lý địa chỉ giao hàng
* Quản lý phương thức thanh toán
* Xem lịch sử đơn hàng
* Xem chi tiết đơn hàng
* Đánh giá sản phẩm
* Đổi mật khẩu

### 🔐 Authentication

* Onboarding cho lần mở đầu tiên
* Đăng ký / Đăng nhập
* OTP
* Quên mật khẩu & đặt lại mật khẩu

---

## 🏗 Kiến trúc dự án

Ứng dụng sử dụng kiến trúc MVVM giúp:

* Code rõ ràng, tách biệt UI – logic
* Dễ mở rộng & bảo trì
* Tối ưu hóa việc quản lý trạng thái với `ObservableObject`, `@StateObject`, `@Binding`

Bao gồm:

* View Layer (SwiftUI)
* ViewModel Layer
* Model Layer
* Service Layer (Network / Local Storage)
* Navigation bằng `NavigationStack`
* Reusable UI Components (MainTabView, TabButton, Cards, Input Fields…)

---

## 🛠 Công nghệ sử dụng

* Swift 5.9+
* SwiftUI
* MVVM
* Combine
* Local JSON Data
* Xcode 15+

---

## ▶️ Hướng dẫn chạy ứng dụng

1. Clone project:

   ```
   git clone https://github.com/nguyenheu/TapHoaEco.git
   ```
2. Mở bằng Xcode 15+

---

## 🎯 Mục tiêu của dự án

Dự án được xây dựng nhằm:

* Nâng cao khả năng thiết kế app theo kiến trúc MVVM chuẩn
* Tạo sản phẩm mô phỏng ứng dụng thương mại điện tử hoàn chỉnh
* Trình bày kỹ năng UI/UX với SwiftUI
* Tổ chức module & navigation như ứng dụng thực tế
