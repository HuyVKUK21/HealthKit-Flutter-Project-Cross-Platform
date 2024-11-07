import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});
  static String routeName = '/ForgetPasswordScreen';
  
  @override
  State<StatefulWidget> createState() {
    return _ForgetPassword();
  }
}

class _ForgetPassword extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();
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
            SizedBox(height: 8),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF118036),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 10,
                shadowColor: Color(0xFF118036),
              ),
              child: Text("Đăng nhập",
                  style: TextStyle(fontSize: 14, color: Colors.white)),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
