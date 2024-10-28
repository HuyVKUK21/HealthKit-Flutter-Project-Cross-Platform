import 'package:fitnessapp/presentation/widgets/appbar/custom_app_bar.dart';
import 'package:fitnessapp/presentation/widgets/health_management/health_management_widget.dart';
import 'package:flutter/material.dart';

class HealthManagementScreen extends StatefulWidget {
  const HealthManagementScreen({super.key});
  @override
  State<HealthManagementScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<HealthManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: HealthManagementWidget(),
          ),
        ],
      ),
    );
  }
}
