import 'package:fitnessapp/presentation/screens/weight/weight_screen.dart';
import 'package:fitnessapp/utils/page_route_builder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Thêm thư viện intl

class HeightMeasureScreen extends StatefulWidget {
  @override
  _WeightScreenState createState() => _WeightScreenState();
}

class _WeightScreenState extends State<HeightMeasureScreen> {
  double weight = 91.0;
  String currentDate = '';

  // Danh sách tháng bằng tiếng Việt
  final List<String> months = [
    'Tháng 1',
    'Tháng 2',
    'Tháng 3',
    'Tháng 4',
    'Tháng 5',
    'Tháng 6',
    'Tháng 7',
    'Tháng 8',
    'Tháng 9',
    'Tháng 10',
    'Tháng 11',
    'Tháng 12',
  ];

  @override
  void initState() {
    super.initState();
    // Lấy ngày hiện tại và định dạng
    DateTime now = DateTime.now();
    currentDate = '${now.day} ${months[now.month - 1]}, ${now.year}'; // Sử dụng danh sách tháng
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Text(
              'Chiều cao',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_today_outlined, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'Hôm nay, $currentDate', // Sử dụng ngày hiện tại đã định dạng
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove_circle, color: Colors.red, size: 30),
                  onPressed: () {
                    setState(() {
                      if (weight > 0) weight -= 0.1;
                    });
                  },
                ),
                Text(
                  weight.toStringAsFixed(1),
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle, color: Colors.green, size: 30),
                  onPressed: () {
                    setState(() {
                      weight += 0.1;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            // Chỉ giữ lại ToggleButton cho kg mà không có bóng và không có vùng lem thừa
            ToggleButtons(
              borderColor: Colors.transparent,
              selectedColor: Colors.pink,
              fillColor: Colors.transparent, // Xóa hiệu ứng bóng
              borderRadius: BorderRadius.circular(8),
              isSelected: [true], // Chỉ một nút được chọn
              onPressed: (int index) {
                // Logic không cần thiết ở đây vì chỉ có một nút
              },
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('cm', style: TextStyle(fontSize: 16,color: Colors.black)),
                ),
              ],
            ),
            SizedBox(height: 30),
            Slider(
              value: weight,
              min: 40,
              max: 210,
              divisions: 110,
              activeColor: Colors.green,
              inactiveColor: Colors.grey[300],
              label: weight.toStringAsFixed(1),
              onChanged: (double value) {
                setState(() {
                  weight = value;
                });
              },
            ),
            Spacer(),
            TextButton.icon(
              onPressed: () {
                // Open help screen
              },
              icon: Icon(Icons.chat_bubble_outline, color: Colors.black54),
              label: Text(
                'Đo chiều cao như thế nào?',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  RouteHelper.createFadeRoute(WeightScreen()),
                );
              },
              child: Text(
                'Tiếp tục',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
