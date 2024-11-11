import 'package:fitnessapp/presentation/screens/activity_tracker/activity_tracker_screen.dart';
import 'package:fitnessapp/presentation/screens/change_password/detail_profile_screen.dart';
import 'package:fitnessapp/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:fitnessapp/presentation/screens/finish_workout/finish_workout_screen.dart';
import 'package:fitnessapp/presentation/screens/foot_step/main_foot_step.dart';
import 'package:fitnessapp/presentation/screens/forget_password/forget_password.dart';
import 'package:fitnessapp/presentation/screens/home/home_screen.dart';
import 'package:fitnessapp/presentation/screens/my_medicine/view_medicine_screen.dart';
import 'package:fitnessapp/presentation/screens/my_medicine/my_medicine_screen.dart';
import 'package:fitnessapp/presentation/screens/notification/notification_screen.dart';
import 'package:fitnessapp/presentation/screens/on_boarding/on_boarding_screen.dart';
import 'package:fitnessapp/presentation/screens/on_boarding/start_screen.dart';
import 'package:fitnessapp/presentation/screens/signin/signin_screen.dart';
import 'package:fitnessapp/presentation/screens/signup/signup_screen.dart';
import 'package:fitnessapp/presentation/screens/weight/height_measure_screen.dart';
import 'package:fitnessapp/presentation/screens/weight/weight_measure_screen.dart';
import 'package:fitnessapp/presentation/screens/weight/weight_screen.dart';
import 'package:fitnessapp/presentation/screens/welcome/welcome_screen.dart';
import 'package:fitnessapp/presentation/screens/workout_schedule_view/workout_schedule_view.dart';
import 'package:fitnessapp/presentation/screens/your_goal/your_goal_screen.dart';
import 'package:flutter/cupertino.dart';

final Map<String, WidgetBuilder> routes = {
  OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
  SigninScreen.routeName: (context) => const SigninScreen(),
  StartScreen.routeName: (context) => const StartScreen(),
  SignupScreen.routeName: (context) => const SignupScreen(),
  YourGoalScreen.routeName: (context) => const YourGoalScreen(),
  WelcomeScreen.routeName: (context) => const WelcomeScreen(),
  DashboardScreen.routeName: (context) => const DashboardScreen(),
  FinishWorkoutScreen.routeName: (context) => const FinishWorkoutScreen(),
  NotificationScreen.routeName: (context) => const NotificationScreen(),
  ActivityTrackerScreen.routeName: (context) => const ActivityTrackerScreen(),
  WorkoutScheduleView.routeName: (context) => const WorkoutScheduleView(),
  HomeScreen.routeName: (context) => HomeScreen(),
  MyMedicineScreen.routeName: (context) => ViewMedicineScreen(),
  MainFootStepScreen.routeName: (context) => MainFootStepScreen(),
  WeightMeasureScreen.routeName: (context) => WeightMeasureScreen(),
  HeightMeasureScreen.routeName: (context) => HeightMeasureScreen(),
  WeightScreen.routeName: (context) => WeightScreen(),
  ForgetPassword.routeName: (context) => ForgetPassword(),
  DetailProfileScreen.routeName: (context) => DetailProfileScreen(),
};
