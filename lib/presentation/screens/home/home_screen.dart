import 'package:fitnessapp/presentation/screens/foot_step/main_foot_step.dart';
import 'package:fitnessapp/presentation/widgets/appbar/custom_app_bar.dart';
import 'package:fitnessapp/presentation/widgets/home/activity_reminder_card.dart';
import 'package:fitnessapp/presentation/widgets/home/goal_card.dart';
import 'package:fitnessapp/presentation/widgets/home/greet_with_temperature.dart';
import 'package:fitnessapp/presentation/widgets/home/health_metric_card.dart';
import 'package:flutter/material.dart';

import '../../../utils/page_route_builder.dart';
import '../my_medicine/my_medicine_screen.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/HomeScreen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              GreetWithTemperature(greetingMessage: "Xin chào, Huy!", welcomeMessage: "Chào mừng bạn đến với HealthKit", temperature: 21),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, size: 14),
                  hintText: "Tìm kiếm hoạt động....",
                  hintStyle: TextStyle(fontSize: 14),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      "Hoạt động sức khỏe",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    HealthMetricCard(
                      icon: 'assets/images/foot_step_icon.png',
                      color: Colors.green,
                      title: "Bước đi",
                      subtitle: "180 bước • Hôm nay",
                      points: "56",
                      measure: false,
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          RouteHelper.createFadeRoute(MainFootStepScreen()),
                        );
                      },
                    ),
                    HealthMetricCard(
                      icon: 'assets/images/heart-rate-icon.png',
                      color: Colors.red,
                      title: "Nhịp tim",
                      subtitle: "78 bpm • Hôm nay",
                      points: "56",
                      measure: true,
                      onTap: (){},
                    ),
                    HealthMetricCard(
                      icon: 'assets/images/home-weight.png',
                      color: Colors.blue,
                      title: "Cân nặng",
                      subtitle: "68 kg • Hôm qua",
                      points: "114",
                      measure: true,
                      onTap: (){},
                    ),
                    HealthMetricCard(
                      icon: 'assets/images/calories-icon.png',
                      color: Colors.orange,
                      title: "Lượng Calo",
                      subtitle: "300 kcal • Hôm nay",
                      points: "168",
                      measure: true,
                      onTap: (){},
                    ),
                    HealthMetricCard(
                      icon: 'assets/images/medicine_icon.png',
                      color: Colors.grey,
                      title: "Thuốc của tôi",
                      subtitle: "Hôm nay",
                      points: "0",
                      measure: false,
                      onTap: () => {
                        Navigator.pushReplacement(
                          context,
                          RouteHelper.createFadeRoute(MyMedicineScreen()),
                        )
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Mục tiêu sức khỏe",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    GoalCard(
                      title: "Bước đi hôm nay",
                      progress: 3500,
                      goal: 10000,
                      unit: "bước",
                    ),
                    GoalCard(
                      title: "Calo tiêu thụ",
                      progress: 400,
                      goal: 2000,
                      unit: "kcal",
                    ),
                    GoalCard(
                      title: "Thời gian tập luyện",
                      progress: 30,
                      goal: 60,
                      unit: "phút",
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Nhắc nhở hoạt động",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    ActivityReminderCard(
                      message: "Đã đến giờ đi bộ 5 phút!",
                      icon: Icons.directions_walk,
                      backgroundColor: Colors.greenAccent,
                    ),
                    ActivityReminderCard(
                      message: "Uống một ly nước nào!",
                      icon: Icons.local_drink,
                      backgroundColor: Colors.blueAccent,
                    ),
                    ActivityReminderCard(
                      message: "Thực hiện vài bài tập giãn cơ nhẹ!",
                      icon: Icons.fitness_center,
                      backgroundColor: Colors.orangeAccent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
