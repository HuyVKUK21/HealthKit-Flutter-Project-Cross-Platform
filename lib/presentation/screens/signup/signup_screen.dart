import 'package:fitnessapp/presentation/bloc/signup/signup_bloc.dart';
import 'package:fitnessapp/presentation/state/user/user_state.dart';
import 'package:fitnessapp/presentation/widgets/common/term_policy.dart';
import 'package:fitnessapp/presentation/widgets/signup/logo_header_signup.dart';
import 'package:fitnessapp/presentation/widgets/signup/signup_form.dart';
import 'package:fitnessapp/utils/page_route_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SignupScreen extends StatelessWidget {
  static String routeName = "/SignUpScreen";

  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpBloc = context.read<SignupBloc>();

    return MultiBlocListener(
        listeners: [
          BlocListener<SignupBloc, RegisterState>(
            listener: (context, state) {
             if (state is RegisterSuccess) {
               ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(
                     content: Text(
                         'Đăng ký thành công. Vui lòng đăng nhập để sử dụng tài khoản')),
               );
                Navigator.pushReplacement(
                  context,
                  RouteHelper.createFadeRoute(SignupScreen()),
                );
              } else if (state is RegisterFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          'Đăng ký không thành công. Lỗi ${state.error}')),
                );
              }
            },
          ),

        ],
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    LogoHeaderSignUp(),
                    SizedBox(height: 40),
                    BlocBuilder<SignupBloc, RegisterState>(
                      builder: (context, state) {
                        if (state is RegisterLoading) {
                          return CircularProgressIndicator();
                        } else {
                          return Column(
                            children: [
                              SignUpForm(signUpBloc: signUpBloc),
                            ],
                          );
                        }
                      },
                    ),

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