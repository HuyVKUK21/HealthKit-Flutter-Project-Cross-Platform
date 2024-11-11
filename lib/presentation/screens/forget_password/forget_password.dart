import 'package:fitnessapp/data/repositories/user/forget_password_impl.dart';
import 'package:fitnessapp/domain/usecases/user/forget_password_usercase.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});
  static String routeName = '/ForgetPasswordScreen';
//test
  @override
  State<StatefulWidget> createState() {
    return _ForgetPassword();
  }
}

class _ForgetPassword extends State<ForgetPassword> {

  final TextEditingController _emailController = TextEditingController();
  final ForgetPasswordUsercase _forgetPasswordUsercase =
  ForgetPasswordUsercase(ForgetPasswordImpl());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> checkGmailUserForgetPassword() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng nhập email của bạn.')),
      );
      return;
    }

    // Kiểm tra email có tồn tại trong hệ thống không
    Map<String?, bool> userInfor =
    await _forgetPasswordUsercase.findUserByEmail(email);
    final firstEntry = userInfor.entries.first;
    bool isValid = firstEntry.value;

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(content: Text('Email không tồn tại trong hệ thống.')),
      );
      return;
    }

    try {
      // Gửi yêu cầu đặt lại mật khẩu qua Firebase Authentication
      await _auth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Email đặt lại mật khẩu đã được gửi. Vui lòng kiểm tra hộp thư.'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã xảy ra lỗi khi gửi email đặt lại mật khẩu: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quên Mật Khẩu',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(

          children: [

            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email hoặc tên người dùng',
                hintStyle: TextStyle(fontSize: 14),
                prefixIcon: Icon(Icons.email, color: Color(0xFF787878)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Color(0xFFBCBCBC), width: 1),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: checkGmailUserForgetPassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF118036),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 10,
                shadowColor: Color(0xFF118036),
              ),
              child: Text(
                "Xác nhận OK",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
