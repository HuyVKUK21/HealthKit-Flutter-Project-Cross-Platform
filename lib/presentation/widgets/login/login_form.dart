import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Email hoặc tên người dùng',
            hintStyle: TextStyle(fontSize: 14),
            prefixIcon: Icon(Icons.email, color: Color(0xFF787878)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color(0xFFBCBCBC),
                width: 1,
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: 'Mật khẩu',
            hintStyle: TextStyle(fontSize: 14),
            prefixIcon: Icon(Icons.lock, color: Color(0xFF787878)),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              child: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: Color(0xFF787878),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color(0xFFBCBCBC),
                width: 1,
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: Text("Quên mật khẩu?",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),),
          ),
        ),
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
            shadowColor: Color(0xFF118036)
          ),
          child: Text(
            "Đăng nhập",
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
