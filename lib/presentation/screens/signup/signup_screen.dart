import 'package:fitnessapp/presentation/common_widgets/round_gradient_button.dart';
import 'package:fitnessapp/presentation/common_widgets/round_textfield.dart';
import 'package:fitnessapp/presentation/widgets/login/term_policy.dart';
import 'package:fitnessapp/presentation/widgets/signup/logo_header_signup.dart';
import 'package:fitnessapp/presentation/widgets/signup/signup_form.dart';
import 'package:fitnessapp/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../profile/complete_profile_screen.dart';

class SignupScreen extends StatelessWidget {
  static String routeName = "/SignUpScreen";

  const SignupScreen({super.key});

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
                  LogoHeaderSignUp(),
                  SizedBox(height: 40),
                  SignUpForm(),
                  SizedBox(height: 40),
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