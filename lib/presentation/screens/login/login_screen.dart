import 'package:fitnessapp/presentation/widgets/login/login_form.dart';
import 'package:fitnessapp/presentation/widgets/login/logo_header_login.dart';
import 'package:fitnessapp/presentation/widgets/login/social_login_button.dart';
import 'package:fitnessapp/presentation/widgets/login/term_policy.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatelessWidget {
  static String routeName = "/LoginScreen";

  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  LogoHeader(),
                  SizedBox(height: 40),
                  LoginForm(),
                  SizedBox(height: 20),
                  SocialLoginButtons(),
                  SizedBox(height: 20),
                  TermsAndPolicy(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}