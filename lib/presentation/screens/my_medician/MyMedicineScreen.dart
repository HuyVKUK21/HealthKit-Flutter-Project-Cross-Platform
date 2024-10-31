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
    double position = (today.weekday - 1) * 58.0; // Điều chỉnh chiều rộng mỗi ô và khoảng cách giữa các ô
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
              onPressed: () {
                // Xử lý khi nhấn menu
              },
            ),
            IconButton(
              icon: Icon(Icons.star),
              onPressed: () {
                // Xử lý khi nhấn điểm
              },
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
                      String formattedDate = DateFormat('dd/MM').format(date);

                      bool isToday = date.day == today.day && date.month == today.month && date.year == today.year;

                      return Container(
                        width: 50.0,
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          color: isToday ? Colors.grey[300] : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '$dayOfWeek\n\n$formattedDate',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: isToday ? FontWeight.w500 : FontWeight.normal
                            ),
                          ),
                        ),
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
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Loại thuốc đăng ký',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Tên thuốc: Paracetamol',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Liều lượng: 1 viên mỗi ngày',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Thời gian: Sáng',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16.0),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Xử lý khi nhấn nút chỉnh sửa
                        },
                        icon: Icon(Icons.edit),
                        label: Text('Chỉnh sửa hộp thuốc'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
