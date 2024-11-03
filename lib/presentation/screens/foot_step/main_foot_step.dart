import 'package:fitnessapp/presentation/widgets/appbar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class MainFootStepScreen extends StatefulWidget {
  const MainFootStepScreen({super.key});
  static String routeName = '/MainFootStepScreen';
  @override
  State<StatefulWidget> createState() {
    return _MainFootStepScreen();
  }
}

class _MainFootStepScreen extends State<MainFootStepScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Text('Main Foot step screen'),
    );
  }
}
