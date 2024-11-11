import 'package:fitnessapp/data/models/weight_model.dart';
import 'package:fitnessapp/presentation/screens/bloodsugar/bloodsugar_screen.dart';
import 'package:fitnessapp/presentation/screens/bloodsure/bloodsure_screen.dart';
import 'package:fitnessapp/presentation/screens/weight/weight_screen.dart';
import 'package:fitnessapp/presentation/widgets/health_management/activities_card_widget.dart';
import 'package:fitnessapp/presentation/widgets/health_management/button_group_widget.dart';
import 'package:fitnessapp/presentation/widgets/health_management/header_widget.dart';
import 'package:fitnessapp/presentation/widgets/health_management/log_book_button.dart';
import 'package:fitnessapp/utils/page_route_builder.dart';
import 'package:flutter/material.dart';

class HealthManagementWidget extends StatelessWidget {
  const HealthManagementWidget({super.key, required this.weightModel});

  final WeightModel weightModel;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ActivityHeader(),
              SizedBox(height: media.width * 0.02),
              ActivityButtonGroup(),
              SizedBox(height: media.width * 0.02),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ActivityCard(
                        imagePath: 'assets/images/weight_icon.png',
                        title: 'Cân nặng',
                        statusText: 'CHẬM TIẾN TRÌNH',
                        statusColor: Colors.redAccent,
                        lastUpdated: 'HÔM QUA, 8:16',
                        daysRemaining: '37 NGÀY NỮA',
                        mainValue: '${weightModel.currentWeight}',
                        mainUnit: 'kg',
                        secondaryValue: '6.4',
                        secondaryUnit: ' kg cần giảm',
                        onTap: () {
                          Navigator.push(context,
                              RouteHelper.createFadeRoute(WeightScreen()));
                        },
                      ),
                      const SizedBox(height: 16),
                      ActivityCard(
                        imagePath: 'assets/images/blood_pressure_icon.png',
                        title: 'Huyết áp',
                        statusText: 'LÝ TƯỞNG',
                        statusColor: Colors.lightBlueAccent,
                        lastUpdated: '20 THÁNG 9 11:35',
                        daysRemaining: 'TRUNG BÌNH 30 NGÀY',
                        mainValue: '90 / 60',
                        mainUnit: 'mmHg',
                        secondaryValue: '90 / 60',
                        secondaryUnit: ' mmHg',
                        onTap: () {
                          Navigator.push(context,
                              RouteHelper.createFadeRoute(BloodsureScreen()));
                        },
                      ),
                      const SizedBox(height: 16),
                      ActivityCard(
                        imagePath: 'assets/images/cholesterol_icon.png',
                        title: 'Mỡ trong máu',
                        statusText: 'TRONG MỤC TIÊU',
                        statusColor: Colors.green,
                        lastUpdated: 'LDL-C - 17 THÁNG 9, 2024',
                        daysRemaining: 'LẦN XÉT NGHIỆM TIẾP THEO',
                        mainValue: '60',
                        mainUnit: 'mg/dL',
                        secondaryValue: '168',
                        secondaryUnit: ' ngày',
                        onTap: () {
                          Navigator.push(context,
                              RouteHelper.createFadeRoute(BloodSugarScreen()));
                        },
                      ),
                      const SizedBox(height: 16),
                      LogBookButton(),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
