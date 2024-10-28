import 'package:fitnessapp/presentation/widgets/appbar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  static String routeName = "/HomeScreen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            // Row for welcome message and temperature
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Xin chào, Huy!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      'Chào mừng bạn đến với HealthKit',
                      style: TextStyle(
                        fontSize: 16,
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
                      '28°C', // Fake temperature for now
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
                prefixIcon: Icon(Icons.search),
                hintText: "Tìm kiếm hoạt động....",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Expanded section that can scroll
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
                    icon: Icons.favorite,
                    color: Colors.red,
                    title: "Nhịp tim",
                    subtitle: "78 bpm • Hôm nay",
                    points: "56",
                  ),
                  HealthMetricCard(
                    icon: Icons.monitor_weight,
                    color: Colors.blue,
                    title: "Weight",
                    subtitle: "68 kg • Hôm qua",
                    points: "114",
                  ),
                  HealthMetricCard(
                    icon: Icons.local_fire_department,
                    color: Colors.orange,
                    title: "Calories Burned",
                    subtitle: "300 kcal • Hôm nay",
                    points: "167",
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
    );
  }
}

class HealthMetricCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String points;

  HealthMetricCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color),
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
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                points,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
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
              color: Colors.green,
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
