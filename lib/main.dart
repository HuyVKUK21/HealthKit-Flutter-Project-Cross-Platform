
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitnessapp/presentation/bloc/register/register_bloc.dart';
import 'package:fitnessapp/presentation/bloc/signin/signin_bloc.dart';
import 'package:fitnessapp/presentation/screens/login/login_screen.dart';
import 'package:fitnessapp/presentation/screens/signup/signup_screen.dart';
import 'package:fitnessapp/routes.dart';
import 'package:fitnessapp/service_locator.dart';
import 'package:fitnessapp/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ? await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBylDdBXP6U5Ba6MqX8dUrZ4Q-N9nR-164",
        appId: "1:539525530321:android:80fdb2100f11d2c57abbf0",
        messagingSenderId: "539525530321",
        projectId: "healthkit-flutter"
    )) : await Firebase.initializeApp();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignInBloc>(
          create: (context) => getIt<SignInBloc>(),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => getIt<RegisterBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: routes,
        theme: ThemeData(
          primaryColor: AppColors.primaryColor1,
          useMaterial3: true,
          fontFamily: "Poppins",
        ),
        home: const LoginScreen(),
      ),
    );
  }
}