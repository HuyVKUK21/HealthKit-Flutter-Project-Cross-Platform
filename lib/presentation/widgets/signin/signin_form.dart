import 'package:fitnessapp/presentation/bloc/signin/signin_bloc.dart';
import 'package:fitnessapp/presentation/events/user/signin_event.dart';
import 'package:fitnessapp/presentation/screens/forget_password/forget_password.dart';
import 'package:fitnessapp/utils/page_route_builder.dart';
import 'package:flutter/material.dart';

class SigninForm extends StatefulWidget {
  final SignInBloc signInBloc;
  const SigninForm({super.key, required this.signInBloc});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<SigninForm> {
  bool obscureText = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
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
              child: Icon(obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Color(0xFF787878)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Color(0xFFBCBCBC), width: 1),
            ),
          ),
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                RouteHelper.createFadeRoute(ForgetPassword()),
              );
            },
            child: Text("Quên mật khẩu?",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w400)),
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            widget.signInBloc.add(
                SignInEvent(_emailController.text, _passwordController.text));
          },
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
    );
  }
}
