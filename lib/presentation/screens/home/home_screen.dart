import 'package:fitnessapp/presentation/widgets/appbar/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../utils/page_route_builder.dart';
import '../my_medicine/MyMedicineScreen.dart';

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Xin chào, Huy!',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        'Chào mừng bạn đến với HealthKit',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.wb_sunny, color: Colors.orange),
                      SizedBox(width: 5),
                      Text(
                        '28°C',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Search bar (Fixed section)
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
                    // Health Metrics Section
                    Text(
                      "Hoạt động sức khỏe",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    HealthMetricCard(
                      icon: 'assets/images/heart-rate-icon.png',
                      color: Colors.red,
                      title: "Nhịp tim",
                      subtitle: "78 bpm • Hôm nay",
                      points: "56",
                      measure: true,
                    ),
                    HealthMetricCard(
                      icon: 'assets/images/home-weight.png',
                      color: Colors.blue,
                      title: "Cân nặng",
                      subtitle: "68 kg • Hôm qua",
                      points: "114",
                      measure: true,
                    ),
                    HealthMetricCard(
                      icon: 'assets/images/calories-icon.png',
                      color: Colors.orange,
                      title: "Lượng Calo",
                      subtitle: "300 kcal • Hôm nay",
                      points: "168",
                      measure: true,
                    ),
                    HealthMetricCard(
                      icon: 'assets/images/calories-icon.png',
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
                    // Health Goals Section
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
                      progress: 3500, // current progress
                      goal: 10000, // total goal
                      unit: "bước",
                    ),
                    GoalCard(
                      title: "Calo tiêu thụ",
                      progress: 400, // current progress
                      goal: 2000, // total goal
                      unit: "kcal",
                    ),
                    GoalCard(
                      title: "Thời gian tập luyện",
                      progress: 30, // current progress in minutes
                      goal: 60, // total goal in minutes
                      unit: "phút",
                    ),
                    SizedBox(height: 20),
                    // Activity Reminders Section
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

class HealthMetricCard extends StatelessWidget {
  final String icon;
  final Color color;
  final String title;
  final String subtitle;
  final String points;
  final bool measure;
  final VoidCallback? onTap;

  HealthMetricCard({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.points,
    required this.measure,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Color(0xFFBCBCBC), width: 0.6),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Image.asset(
                      icon,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: ElevatedButton(
                        onPressed: () {
                          if (onTap != null) {
                            onTap!();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF118036),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                          shadowColor: Color(0xFF118036),
                        ),
                        child: Text(
                          measure == true ? "Đo ngay" : "Xem",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10), // Khoảng cách dưới cùng của Card
          ],
        )
    );
  }

}

class GoalCard extends StatelessWidget {
  final String title;
  final int progress;
  final int goal;
  final String unit;

  GoalCard({
    required this.title,
    required this.progress,
    required this.goal,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    double progressPercent = progress / goal;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: progressPercent,
              backgroundColor: Colors.grey[300],
              color: Colors.red,
            ),
            SizedBox(height: 10),
            Text(
              "$progress / $goal $unit",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityReminderCard extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color backgroundColor;

  ActivityReminderCard({
    required this.message,
    required this.icon,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
