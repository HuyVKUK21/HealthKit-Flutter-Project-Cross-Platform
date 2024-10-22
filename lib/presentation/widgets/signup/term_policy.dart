import 'package:flutter/material.dart';

class TermsAndPolicy extends StatelessWidget {
  const TermsAndPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(fontSize: 12),
          children: <TextSpan>[
            TextSpan(text: "Bằng cách tạo tài khoản, bạn đồng ý với", style: TextStyle(color: Colors.black)),
            TextSpan(text: " Điều khoản & Điều kiện và Chính sách Bảo mật của HealthKit",
                style: TextStyle(color: Color(0xFF043723),
                    fontWeight: FontWeight.w600,
                    height: 1.5
                ),


            ),
          ],
        ),
      ),
    );

  }
}