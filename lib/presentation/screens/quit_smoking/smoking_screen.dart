import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../home/home_screen.dart';

class QuitSmokingPage extends StatefulWidget {
  @override
  _QuitSmokingPageState createState() => _QuitSmokingPageState();
}

class _QuitSmokingPageState extends State<QuitSmokingPage> {
  String _selectedFilter = "Tất cả"; // State to hold the selected filter value

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              "Hút thuốc",
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                      (route) => false,
                );
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.add, color: Colors.black),
                onPressed: () {

                },
              ),
            ]
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PreferredSize(
                  preferredSize: Size.fromHeight(60.0),
                  child: DefaultTabController(
                    length: 4,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade300, width: 1),
                      ),
                      child: TabBar(
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        indicator: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent, // Lo
                        tabs: [
                          Tab(text: "NGÀY"),
                          Tab(text: "TUẦN"),
                          Tab(text: "THÁNG"),
                          Tab(text: "NĂM"),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "TỔNG HÀNG THÁNG",
                          style: TextStyle(fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "0 báo cáo",
                          style: TextStyle(fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text("Cơn thèm", style: TextStyle(
                                    fontSize: 14, color: Colors.grey)),
                              ],
                            ),
                            SizedBox(height: 4,),
                            Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text("đã hút      ", style: TextStyle(
                                    fontSize: 14, color: Colors.grey)),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(
                            30),
                      ),
                      child: DropdownButton<String>(
                        value: _selectedFilter,
                        underline: SizedBox.shrink(),
                        items: ["Tất cả", "Cơn thèm", "Đã hút"]
                            .map((value) =>
                            DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedFilter = value!;
                          });
                        },
                      ),
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
                      aspectRatio: 1.5,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          barGroups: [
                            BarChartGroupData(x: 0, barsSpace: 4, barRods: [
                              BarChartRodData(
                                  toY: 0, color: Colors.grey, width: 16)
                            ]),
                            BarChartGroupData(x: 1, barsSpace: 4, barRods: [
                              BarChartRodData(
                                  toY: 0, color: Colors.grey, width: 16)
                            ]),
                            BarChartGroupData(x: 2, barsSpace: 4, barRods: [
                              BarChartRodData(
                                  toY: 0, color: Colors.grey, width: 16)
                            ]),
                            BarChartGroupData(x: 3, barsSpace: 4, barRods: [
                              BarChartRodData(
                                  toY: 0, color: Colors.grey, width: 16)
                            ]),
                            BarChartGroupData(x: 4, barsSpace: 4, barRods: [
                              BarChartRodData(
                                  toY: 1, color: Colors.green, width: 16)
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
                                          style: style.copyWith(
                                              color: Colors.pink));
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tiến độ chung",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () {

                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.grey.shade700,
                                  side: BorderSide(
                                      color: Colors.grey, width: 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text("Đặt lại", style: TextStyle(
                                    fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/calendar.png',
                                      width: 80,
                                      height: 80,
                                    ),
                                    SizedBox(height: 16),
                                    Text("13", style: TextStyle(fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                    SizedBox(height: 16),
                                    Text("Số ngày bỏ thuốc", style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                      textAlign: TextAlign.center,),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/no_smoking.png',
                                      width: 80,
                                      height: 80,
                                    ),
                                    SizedBox(height: 16),
                                    Text("300", style: TextStyle(fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                    SizedBox(height: 16),
                                    Text("Điếu đã từ chối", style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                      textAlign: TextAlign.center,),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/coin.png',
                                      width: 80,
                                      height: 80,
                                    ),
                                    SizedBox(height: 16),
                                    Text("180n", style: TextStyle(fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                    SizedBox(height: 16),
                                    Text("VND đã tiết kiệm", style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                      textAlign: TextAlign.center,),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(
                        20), // Set the border radius
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Kế hoạch thuốc lá",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {

                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.grey.shade700,
                                side: BorderSide(color: Colors.grey, width: 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text("Chỉnh sửa", style: TextStyle(
                                  fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Text(
                                "CỘT MỐC + MỤC TIÊU",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.flag, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  "1 điếu/ngày",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "trước 10 thg 11, 2024",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.health_and_safety, size: 20,
                                    color: Colors.blue.shade900),
                                SizedBox(width: 8),
                                Text(
                                  "0 điếu/ngày",
                                  style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "trước 11 thg 11, 2024",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
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
}