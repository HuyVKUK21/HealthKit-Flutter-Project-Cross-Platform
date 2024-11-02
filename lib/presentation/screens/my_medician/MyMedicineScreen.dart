import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyMedicineScreen extends StatefulWidget {
  static String routeName = "/MyMedicineScreen";

  @override
  State<MyMedicineScreen> createState() => _MyMedicineScreenState();
}

class _MyMedicineScreenState extends State<MyMedicineScreen> {
  final DateTime today = DateTime.now();
  final List<String> weekdays = ["CN", "TH 2", "TH 3", "TH 4", "TH 5", "TH 6", "TH 7"];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToCurrentDay());
  }

  void _scrollToCurrentDay() {
    double screenWidth = MediaQuery.of(context).size.width;
    double position = (today.weekday - 1) * 58.0 - (screenWidth / 2) + 29.0; // Adjust to center the current day
    _scrollController.animateTo(
      position,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            Text("2,100", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Row(
              children: [
                IconButton(icon: Icon(Icons.alarm), onPressed: () {}),
                IconButton(icon: Icon(Icons.chat), onPressed: () {}),
                IconButton(icon: Icon(Icons.add), onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Thuốc của tôi',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  height: 80.0,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: 14,
                    itemBuilder: (context, index) {
                      DateTime date = today.add(Duration(days: index - today.weekday + 1));
                      String dayOfWeek = weekdays[date.weekday % 7];
                      String formattedDate = DateFormat('dd').format(date);

                      bool isToday = date.day == today.day && date.month == today.month && date.year == today.year;

                      return Column(
                        children: [
                          Text(
                            isToday ? "Hôm nay, ${formattedDate}" : formattedDate,
                            style: TextStyle(
                              color: isToday ? Colors.red : Colors.black,
                              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          Container(
                            width: 50.0,
                            margin: EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              color: isToday ? Colors.grey[300] : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                dayOfWeek,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: isToday ? FontWeight.w500 : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MedicineCard(
                    medicineName: "A.t Ibuprofen",
                    dosageTime: "8:00",
                    remainingDoses: "29",
                    onEditPressed: () {
                      // Handle edit button press
                    },
                  ),
                  SizedBox(height: 16.0),
                  Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                      ),
                      onPressed: () {},
                      icon: Icon(Icons.edit),
                      label: Text("Chỉnh sửa hộp thuốc"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MedicineCard extends StatelessWidget {
  final String medicineName;
  final String dosageTime;
  final String remainingDoses;
  final VoidCallback onEditPressed;

  const MedicineCard({
    Key? key,
    required this.medicineName,
    required this.dosageTime,
    required this.remainingDoses,
    required this.onEditPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.green),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 24,
            child: Icon(Icons.medication, color: Colors.black),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medicineName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.0),
                Text("Đã uống vào lúc $dosageTime", style: TextStyle(fontSize: 14)),
                Text("$remainingDoses lần dùng còn lại", style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
          Icon(Icons.check_circle, color: Colors.green, size: 28),
        ],
      ),
    );
  }
}
