import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitnessapp/data/repositories/user/auth_local_data_source_impl.dart';
import 'package:fitnessapp/domain/repositories/user/auth_local_data_source.dart';
import 'package:fitnessapp/firebase_options.dart';
import 'package:fitnessapp/presentation/bloc/signin/signin_bloc.dart';
import 'package:fitnessapp/presentation/bloc/signup/signup_bloc.dart';
import 'package:fitnessapp/presentation/bloc/weight/weight_bloc.dart';
import 'package:fitnessapp/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:fitnessapp/presentation/screens/home/home_screen.dart';
import 'package:fitnessapp/presentation/screens/signin/signin_screen.dart';
import 'package:fitnessapp/routes.dart';
import 'package:fitnessapp/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';


final GetIt getIt = GetIt.instance;

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ? await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBylDdBXP6U5Ba6MqX8dUrZ4Q-N9nR-164",
        appId: "1:539525530321:android:80fdb2100f11d2c57abbf0",
        messagingSenderId: "539525530321",
        projectId: "healthkit-flutter"
    )) : await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  final authLocalDataSource = getIt<AuthLocalDataSource>();
  String? uid = await authLocalDataSource.getUid();
  runApp(MyApp(initialRoute: uid != null ? DashboardScreen.routeName : SigninScreen.routeName));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

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
        BlocProvider<WeightBloc>(
          create: (context) => getIt<WeightBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: routes,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: "Poppins",
        ),
        initialRoute: initialRoute,
      ),
    );
  }
}