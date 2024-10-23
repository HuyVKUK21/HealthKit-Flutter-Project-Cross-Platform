import 'package:fitnessapp/events/register/register_event.dart';
import 'package:fitnessapp/presentation/bloc/register/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitnessapp/presentation/bloc/register/register_bloc.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<SignUpForm> {
  bool obscureText = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Đang thực hiện đăng ký tài khoản'))
            );
          }
          else if (state is RegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Đăng ký thành công'))
            );
          }
          else if (state is RegisterFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(
                    'Đăng ký không thành công. Lỗi ${state.error}'))
            );
          }
        },

      child: Column(
      children: [
        TextField(
          controller: _emailController,
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
            context.read<RegisterBloc>().add(
              RegisterButtonPressed(email: _emailController.text, password: _passwordController.text)
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
    )
    );

  }
}
