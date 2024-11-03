import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitnessapp/firebase_options.dart';
import 'package:fitnessapp/presentation/bloc/signin/signin_bloc.dart';
import 'package:fitnessapp/presentation/bloc/signup/signup_bloc.dart';
import 'package:fitnessapp/presentation/screens/signin/signin_screen.dart';
import 'package:fitnessapp/routes.dart';
import 'package:fitnessapp/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        BlocProvider<SignupBloc>(
          create: (context) => getIt<SignupBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: routes,
        theme: ThemeData(
          // primaryColor: AppColors.primaryColor1,
          useMaterial3: true,
          fontFamily: "Poppins",
        ),
        home: SigninScreen(),
      ),
    );
  }
}