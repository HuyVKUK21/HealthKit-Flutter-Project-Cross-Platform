import 'package:fitnessapp/events/user/user_event.dart';
import 'package:fitnessapp/presentation/bloc/signin/signin_bloc.dart';
import 'package:fitnessapp/presentation/state/user/user_state.dart';
import 'package:fitnessapp/presentation/widgets/login/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool obscureText = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Đang đăng nhập')));
        } else if (state is RegisterSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Đăng nhập thành công')));
        } else if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Đăng nhập không thành công. Lỗi ${state.error}')));
        }
      },
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
                child: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: Color(0xFF787878)),
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
              onPressed: () {},
              child: Text("Quên mật khẩu?", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<SignInBloc>().add(
                  ButtonSubmitPressed(email: _emailController.text, password: _passwordController.text)
              );
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
            child: Text("Đăng nhập", style: TextStyle(fontSize: 14, color: Colors.white)),
          ),

          SizedBox(height: 40),
          SocialLoginButtons(
            onGoogleSignIn: () {
              context.read<SignInBloc>().add(GoogleSignInPressed());
            },
          ),
        ],
      ),
    );
  }
}
