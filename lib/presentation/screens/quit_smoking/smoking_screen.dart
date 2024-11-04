import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../home/home_screen.dart';

import 'ProgressCard.dart';

class QuitSmokingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F4F6),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "Bỏ thuốc lá",
          style: TextStyle(
            color: Colors.white, // Đặt màu chữ là màu đỏ
            fontSize: 20, // Kích thước chữ
            fontWeight: FontWeight.bold, // Độ dày chữ (tùy chọn)
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false,
              );
            }),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            _buildTitle("Thống kê bỏ thuốc"),
            SizedBox(height: 20),
            TimeRangeTabs(),
            SizedBox(height: 20),
            SmokingChart(),
            SizedBox(height: 30),
            _buildTitle("Tiến độ chung"),
            SizedBox(height: 10),
            ProgressOverview(),
            SizedBox(height: 30),
            _buildTitle("Thành tựu"),
            SizedBox(height: 10),
            AchievementsList(),
            SizedBox(height: 30),
            _buildTitle("Sổ theo dõi"),
            SizedBox(height: 10),
            TrackingLogList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Colors.teal[800],
      ),
    );
  }
}

class TimeRangeTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TimeRangeTab(label: "Ngày"),
        TimeRangeTab(label: "Tuần"),
        TimeRangeTab(label: "Tháng"),
        TimeRangeTab(label: "Năm"),
      ],
    );
  }
}

class TimeRangeTab extends StatelessWidget {
  final String label;
  const TimeRangeTab({required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      onPressed: () {},
      child: Text(
        label,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class SmokingChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barGroups: [
                BarChartGroupData(x: 0, barsSpace: 4, barRods: [
                  BarChartRodData(toY: 3, color: Colors.teal, width: 16)
                ]),
                BarChartGroupData(x: 1, barsSpace: 4, barRods: [
                  BarChartRodData(toY: 5, color: Colors.teal, width: 16)
                ]),
                BarChartGroupData(x: 2, barsSpace: 4, barRods: [
                  BarChartRodData(toY: 2, color: Colors.teal, width: 16)
                ]),
                BarChartGroupData(x: 3, barsSpace: 4, barRods: [
                  BarChartRodData(toY: 8, color: Colors.teal, width: 16)
                ]),
                BarChartGroupData(x: 4, barsSpace: 4, barRods: [
                  BarChartRodData(toY: 6, color: Colors.teal, width: 16)
                ]),
              ],
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, _) {
                      const style = TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      );
                      switch (value.toInt()) {
                        case 0:
                          return Text('T2', style: style);
                        case 1:
                          return Text('T3', style: style);
                        case 2:
                          return Text('T4', style: style);
                        case 3:
                          return Text('T5', style: style);
                        case 4:
                          return Text('T6', style: style);
                        default:
                          return Text('');
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProgressOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ProgressCard(
          label: "Số ngày bỏ thuốc",
          value: "20",
          iconPath: 'assets/icons/calendar.png', // Đường dẫn tới ảnh icon
        ),
        ProgressCard(
          label: "Điếu đã bỏ",
          value: "150",
          iconPath: 'assets/icons/smoking.png', // Đường dẫn tới ảnh icon
        ),
        ProgressCard(
          label: "Tiết kiệm",
          value: "50,000đ",
          iconPath: 'assets/icons/money.png', // Đường dẫn tới ảnh icon
        ),
      ],
    );
  }
}

class ProgressCard extends StatelessWidget {
  final String label;
  final String value;
  const ProgressCard(
      {required this.label, required this.value, required String iconPath});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800],
                ),
              ),
              SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AchievementsList extends StatelessWidget {
  final List<String> achievements = [
    "Bỏ thuốc 1 ngày - Cải thiện sức khỏe",
    "Bỏ thuốc 7 ngày - Cảm giác phổi sạch hơn",
    "Bỏ thuốc 1 tháng - Cải thiện tuần hoàn máu",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: achievements
          .map((achievement) => Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          leading: Icon(Icons.star, color: Colors.amber),
          title: Text(
            achievement,
            style: TextStyle(fontSize: 16, color: Colors.teal[800]),
          ),
        ),
      ))
          .toList(),
    );
  }
}

class TrackingLogList extends StatelessWidget {
  final List<Map<String, String>> logs = [
    {"date": "01/11", "cigarettes": "5", "savings": "50,000đ"},
    {"date": "02/11", "cigarettes": "3", "savings": "30,000đ"},
    {"date": "03/11", "cigarettes": "4", "savings": "40,000đ"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: logs.map((log) {
        return Card(
          elevation: 2,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: ListTile(
            leading: Icon(Icons.calendar_today, color: Colors.teal),
            title: Text(
              "Ngày: ${log['date']}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Điếu thuốc bỏ: ${log['cigarettes']} - Tiết kiệm: ${log['savings']}",
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
        );
      }).toList(),
    );
  }
}

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.teal,
      colorScheme:
      ColorScheme.fromSwatch().copyWith(secondary: Colors.tealAccent),
    ),
    home: QuitSmokingPage(),
  ));
}
