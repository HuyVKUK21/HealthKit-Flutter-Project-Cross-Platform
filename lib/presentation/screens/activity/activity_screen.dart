import 'package:fitnessapp/presentation/widgets/activity/infomation_activities.dart';
import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});
  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {

  @override
  Widget build(BuildContext context) {
    return WhatTrainRow();
  }


}
