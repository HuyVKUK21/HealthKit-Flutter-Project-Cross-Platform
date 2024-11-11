import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitnessapp/data/repositories/user/auth_local_data_source_impl.dart';
import 'package:fitnessapp/domain/entities/account_entity.dart';
import 'package:fitnessapp/domain/repositories/user/auth_local_data_source.dart';
import 'package:fitnessapp/firebase_options.dart';
import 'package:fitnessapp/presentation/bloc/bloodsure/bloodsure_bloc.dart';
import 'package:fitnessapp/presentation/bloc/signin/signin_bloc.dart';
import 'package:fitnessapp/presentation/bloc/signup/signup_bloc.dart';
import 'package:fitnessapp/presentation/bloc/weight/weight_bloc.dart';
import 'package:fitnessapp/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:fitnessapp/presentation/screens/home/home_screen.dart';
import 'package:fitnessapp/presentation/screens/signin/signin_screen.dart';
import 'package:fitnessapp/routes.dart';
import 'package:fitnessapp/service_locator.dart';
import 'package:fitnessapp/utils/initialize_firebase.dart';
import 'package:fitnessapp/utils/route_initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';


final GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitializeFirebase.initialize();
  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  final initialRoute = await RouteInitializer.getInitialRoute();
  runApp(MyApp(initialRoute: initialRoute));
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
        BlocProvider<BloodsureBloc>(
          create: (context) => getIt<BloodsureBloc>(),
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