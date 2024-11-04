import 'package:fitnessapp/events/user/signin_event.dart';
import 'package:fitnessapp/events/user/user_event.dart';
import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/presentation/bloc/signin/signin_bloc.dart';
import 'package:fitnessapp/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:fitnessapp/presentation/state/user/signin_state.dart';
import 'package:fitnessapp/presentation/state/user/user_state.dart';
import 'package:fitnessapp/presentation/widgets/common/term_policy.dart';
import 'package:fitnessapp/presentation/widgets/signin/logo_header_signin.dart';
import 'package:fitnessapp/presentation/widgets/signin/signin_form.dart';
import 'package:fitnessapp/presentation/widgets/signin/social_signin_button.dart';
import 'package:fitnessapp/utils/page_route_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninScreen extends StatelessWidget {
  static String routeName = "/SigninScreen";

  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signInBloc = context.read<SignInBloc>();

    return MultiBlocListener(
        listeners: [
          BlocListener<SignInBloc, SigninState>(
            listener: (context, state) {
              if (state is AuthLoading) {
              } else if (state is AuthAuthenticated) {
                Navigator.pushReplacement(
                  context,
                  RouteHelper.createFadeRoute(DashboardScreen()),
                );
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Đăng nhập không thành công. Lỗi: ${state.message}')),
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
                  LogoHeader(),
                  SizedBox(height: 40),
                  BlocBuilder<SignInBloc, SigninState>(
                    builder: (context, state) {
                      if (state is RegisterLoading) {
                        return CircularProgressIndicator();
                      } else {
                        return Column(
                          children: [
                            SigninForm(signInBloc: signInBloc),
                            SizedBox(height: 20),
                            SocialLoginButtons(
                              onGoogleSignIn: () {
                                signInBloc.add(SignInWithGoogleEvent());
                              },
                            ),
                          ],
                        );
                      }
                    },
                  ),
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
