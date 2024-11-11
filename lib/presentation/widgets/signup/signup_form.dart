
import 'package:fitnessapp/presentation/bloc/signup/signup_bloc.dart';
import 'package:fitnessapp/presentation/events/user/user_event.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  final SignupBloc signUpBloc;
  const SignUpForm({super.key, required this.signUpBloc});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<SignUpForm> {
  bool obscureText = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
    children: [
      TextField(
        controller: _emailController,
        decoration: InputDecoration(
          hintText: 'Email người dùng',
          hintStyle: TextStyle(fontSize: 14),
          prefixIcon: Icon(Icons.mail, color: Color(0xFF787878)),
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
        controller: _ageController,
        decoration: InputDecoration(
          hintText: 'Tuổi',
          hintStyle: TextStyle(fontSize: 14),
          prefixIcon: Icon(Icons.calendar_month_rounded, color: Color(0xFF787878)),
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
        controller: _fullNameController,
        decoration: InputDecoration(
          hintText: 'Tên người dùng',
          hintStyle: TextStyle(fontSize: 14),
          prefixIcon: Icon(Icons.account_circle_sharp, color: Color(0xFF787878)),
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
        controller: _phoneController,
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
        controller: _passwordController,
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
        onPressed: () {
         widget.signUpBloc.add(
           ButtonSubmitPressed(
             fullName: _fullNameController.text,
                age: _ageController.text,
                phone: _phoneController.text,
                email: _emailController.text,
                password: _passwordController.text,
           )
         );
        },
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
