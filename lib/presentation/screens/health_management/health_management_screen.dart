import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessapp/data/models/weight_model.dart';
import 'package:fitnessapp/presentation/widgets/appbar/custom_app_bar.dart';
import 'package:fitnessapp/presentation/widgets/health_management/health_management_widget.dart';
import 'package:flutter/material.dart';

class HealthManagementScreen extends StatefulWidget {
  const HealthManagementScreen({super.key});
  @override
  State<HealthManagementScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<HealthManagementScreen> {
  WeightModel weightModel = WeightModel(userId: '0', currentWeight: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeightUser();
  }
  @override
void didChangeDependencies() {
  super.didChangeDependencies();
  getWeightUser(); 
}

  Future<void> getWeightUser() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('weights')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final userData = snapshot.docs.first.data();
        setState(() {
          weightModel = WeightModel.fromJson(userData);
        });
        print("User found: $userData");
      } else {}
    } catch (e) {
      print("Error finding user: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: HealthManagementWidget(
              weightModel: weightModel,
            ),
          ),
        ],
      ),
    );
  }
}
