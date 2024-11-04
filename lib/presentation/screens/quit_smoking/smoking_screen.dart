import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class QuitSmokingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        backgroundColor: Color(0xFFF3F4F6),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Hút thuốc",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(
                  context); // Navigate back to the previous or home page
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.add, color: Colors.black),
              onPressed: () {
                // Action for the + button
              },
            ),
          ],
          bottom: TabBar(
            indicator: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(text: "NGÀY"),
              Tab(text: "TUẦN"),
              Tab(text: "THÁNG"),
              Tab(text: "NĂM"),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                // Report statistics
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "TỔNG HÀNG THÁNG",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        Text(
                          "0 báo cáo",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            _buildLegend("con thèm", Colors.grey),
                            SizedBox(width: 10),
                            _buildLegend("đã hút", Colors.red),
                          ],
                        ),
                      ],
                    ),
                    DropdownButton<String>(
                      value: "Tất cả",
                      items: ["Tất cả", "Lọc khác"]
                          .map((value) =>
                          DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          ))
                          .toList(),
                      onChanged: (value) {},
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Chart
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AspectRatio(
                      aspectRatio: 1.5, // Adjust aspect ratio as needed
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          barGroups: [
                            BarChartGroupData(x: 0, barsSpace: 4, barRods: [
                              BarChartRodData(
                                  toY: 50, color: Colors.grey, width: 16)
                            ]),
                            BarChartGroupData(x: 1, barsSpace: 4, barRods: [
                              BarChartRodData(
                                  toY: 70, color: Colors.grey, width: 16)
                            ]),
                            BarChartGroupData(x: 2, barsSpace: 4, barRods: [
                              BarChartRodData(
                                  toY: 20, color: Colors.grey, width: 16)
                            ]),
                            BarChartGroupData(x: 3, barsSpace: 4, barRods: [
                              BarChartRodData(
                                  toY: 90, color: Colors.grey, width: 16)
                            ]),
                            BarChartGroupData(x: 4, barsSpace: 4, barRods: [
                              BarChartRodData(
                                  toY: 100, color: Colors.green, width: 16)
                            ]),
                          ],
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: true),
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
                                      return Text('Thg6', style: style);
                                    case 1:
                                      return Text('Thg7', style: style);
                                    case 2:
                                      return Text('Thg8', style: style);
                                    case 3:
                                      return Text('Thg9', style: style);
                                    case 4:
                                      return Text('Thg10', style: style);
                                    case 5:
                                      return Text('Tháng này',
                                          style:
                                          style.copyWith(color: Colors.pink));
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
                ),
                SizedBox(height: 20),
                // Overall progress
                Text(
                  "Tiến độ chung",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildProgressCard(
                        icon: Icons.calendar_today,
                        label: "Số ngày bỏ thuốc",
                        value: "13"),
                    _buildProgressCard(
                        icon: Icons.smoke_free,
                        label: "Điếu đã từ chối",
                        value: "300"),
                    _buildProgressCard(
                        icon: Icons.monetization_on,
                        label: "VND đã tiết kiệm",
                        value: "180n"),
                  ],
                ),
                SizedBox(height: 20),
                // Ngày bỏ thuốc
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Ngày bỏ thuốc",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Hành động khi nhấn nút Chỉnh sửa
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text("Chỉnh sửa"),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.emoji_events, color: Colors.blue),
                            SizedBox(width: 8),
                            Text(
                              "0 đã hút",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "kể từ 22 thg 10, 2024",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Chúc mừng! 6 tháng đầu tiên là khó khăn nhất.",
                                style:
                                TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ),
                            Image.asset(
                              'assets/icons/doctor.png', // Đường dẫn ảnh bác sĩ
                              height: 60,
                              width: 60,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Thành tựu
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Thành tựu",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Hành động khi nhấn nút Xem tất cả
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text("Xem tất cả"),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        // Danh sách các thành tựu
                        Column(
                          children: [
                            _buildAchievement(
                              icon: Icons.cake,
                              title: "Trong vòng 48 giờ",
                              description:
                              "Vị giác và khứu giác của bạn bắt đầu cải thiện",
                              isCompleted: true,
                            ),
                            SizedBox(height: 8),
                            _buildAchievement(
                              icon: Icons
                                  .cake, // Dùng biểu tượng phổi cho thành tựu
                              title: "2-12 tuần",
                              description:
                              "Tuần hoàn của bạn được cải thiện và chức năng phổi của bạn tăng lên",
                              isCompleted: true,
                            ),
                            SizedBox(height: 8),
                            _buildAchievement(
                              icon: Icons
                                  .cake, // Dùng biểu tượng phổi cho thành tựu
                              title: "1-9 tháng",
                              description: "Giảm ho và khó thở",
                              isCompleted: false,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLegend(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(width: 4),
        Text(label, style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildProgressCard(
      {required IconData icon, required String label, required String value}) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 40, color: Colors.teal),
              SizedBox(height: 8),
              Text(value,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(label, style: TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAchievement({required IconData icon,
    required String title,
    required String description,
    required bool isCompleted}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 40,
          color: isCompleted ? Colors.green : Colors.grey,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        isCompleted
            ? Icon(Icons.check_circle, color: Colors.green)
            : Icon(Icons.radio_button_unchecked, color: Colors.grey),
      ],
    );
  }

  void main() {
    runApp(MaterialApp(
      home: QuitSmokingPage(),
    ));
  }
}
