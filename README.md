Ứng dụng Chăm Sóc Sức Khỏe
Ứng dụng chăm sóc sức khỏe được phát triển bằng Flutter, giúp người dùng theo dõi và cải thiện sức khỏe hàng ngày. Ứng dụng hỗ trợ các tính năng theo dõi hoạt động thể chất, lập lịch nhắc nhở uống nước, giấc ngủ, và kiểm tra chỉ số BMI.

Tính năng chính
Theo dõi bước chân: Đếm số bước chân hàng ngày của người dùng, tính toán lượng calo đã tiêu thụ.
Nhắc nhở uống nước: Lập kế hoạch và nhắc nhở người dùng uống nước đủ trong ngày.
Giấc ngủ: Theo dõi thời gian ngủ và chất lượng giấc ngủ của người dùng.
Kiểm tra chỉ số BMI: Cho phép người dùng nhập chiều cao và cân nặng để kiểm tra chỉ số BMI.
Biểu đồ sức khỏe: Biểu diễn trực quan thông tin sức khỏe qua các biểu đồ.
Hỗ trợ đa nền tảng: Chạy mượt mà trên cả Android và iOS.
Công nghệ sử dụng
Flutter: Framework chính để xây dựng giao diện người dùng.
Provider: Quản lý trạng thái ứng dụng.
SQLite: Lưu trữ dữ liệu của người dùng cục bộ.
Firebase: Lưu trữ dữ liệu từ xa và xác thực người dùng.
Google Fit / Apple Health Kit: Đồng bộ hóa dữ liệu sức khỏe (chỉ khả dụng trên thiết bị được hỗ trợ).
Cài đặt
Clone dự án về máy của bạn:

bash
Copy code
git clone https://github.com/username/health_app.git
cd health_app
Cài đặt các gói phụ thuộc:

bash
Copy code
flutter pub get
Thiết lập Firebase (nếu sử dụng tính năng đồng bộ dữ liệu):

Tạo một dự án Firebase và tải google-services.json hoặc GoogleService-Info.plist cho ứng dụng của bạn.
Đặt các file này vào thư mục android/app và ios/Runner.
Chạy ứng dụng:

bash
Copy code
flutter run
Sử dụng
Đăng ký tài khoản: Đăng ký hoặc đăng nhập bằng tài khoản Google/Facebook (Firebase).
Theo dõi bước chân: Kết nối với Google Fit hoặc Apple Health Kit để đồng bộ hóa dữ liệu.
Lập kế hoạch nhắc nhở: Đặt mục tiêu uống nước hàng ngày, thời gian ngủ.
Xem biểu đồ: Xem các biểu đồ thể hiện sức khỏe của bạn theo thời gian.
Cấu trúc dự án
lib/: Thư mục chính chứa mã nguồn Flutter.

models/: Định nghĩa các model dữ liệu.
providers/: Quản lý trạng thái của ứng dụng.
screens/: Chứa các màn hình giao diện chính.
widgets/: Các thành phần giao diện tùy chỉnh.
assets/: Chứa hình ảnh và các tài nguyên khác.

Đóng góp
Chúng tôi luôn chào đón các đóng góp từ cộng đồng. Nếu bạn có ý tưởng hoặc tìm thấy lỗi, vui lòng tạo một issue hoặc gửi yêu cầu pull request.

Giấy phép
Ứng dụng này được phân phối theo giấy phép MIT. Vui lòng xem file LICENSE để biết thêm chi tiết.
