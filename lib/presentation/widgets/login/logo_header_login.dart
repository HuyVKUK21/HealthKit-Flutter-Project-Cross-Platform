import 'package:flutter/material.dart';

class LogoHeader extends StatelessWidget {
  const LogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Thêm logo ở đây nếu có
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset('assets/images/app_logo.png',
                  width: 34,
                  height: 34,),
                SizedBox(width: 10,),
                Text(
                  "HealthKit",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF043723),
                  ),
                ),

              ],
            ),
            Text(
              "Đăng ký",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF043723),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          "Chào mừng trở lại!",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: Color(0xFF118036),
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Rất vui khi thấy bạn trở lại, đăng nhập và tiếp tục tiến trình luyện tập của mình",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w400
          ),
        ),
      ],
    );
  }
}