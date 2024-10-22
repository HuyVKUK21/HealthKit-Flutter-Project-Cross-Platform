import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<SignUpForm> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Tên đầy đủ',
            hintStyle: TextStyle(fontSize: 14),
            prefixIcon: Icon(Icons.account_circle, color: Color(0xFF787878)),
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
            hintText: 'Tuổi',
            hintStyle: TextStyle(fontSize: 14),
            prefixIcon: Icon(Icons.calendar_month, color: Color(0xFF787878)),
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
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            hintText: 'Email của bạn',
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
          decoration: InputDecoration(
            hintText: 'Số điện thoại',
            hintStyle: TextStyle(fontSize: 14),
            prefixIcon: Icon(Icons.phone, color: Color(0xFF787878)),
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
        SizedBox(height: 16),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: 'Nhập lại mật khẩu',
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
        SizedBox(height: 40),
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
            "Tạo tài khoản",
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
