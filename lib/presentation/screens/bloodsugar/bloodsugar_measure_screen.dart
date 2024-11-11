import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BloodSugarMeasureScreen extends StatefulWidget {
  @override
  _BloodSugarMeasureScreenState createState() => _BloodSugarMeasureScreenState();
}

class _BloodSugarMeasureScreenState extends State<BloodSugarMeasureScreen> {
  double bloodSugarValue = 95.4;
  bool isMgDl = true;
  int selectedMealState = 0;
  String mealDescription = "8 giờ hoặc hơn kể từ sau bữa ăn gần nhất";

  String getCurrentDateTime() {
    final now = DateTime.now();
    final formatter = DateFormat(" d 'tháng' M HH:mm");
    return "Hôm nay,"+ formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F5F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          // Tiêu đề và ngày giờ
          Text(
            "Đường huyết",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  getCurrentDateTime(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 60),
          // Giá trị đo đường huyết
          Text(
            bloodSugarValue.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          // Chọn đơn vị
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isMgDl = true;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isMgDl ? Colors.grey[300] : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "mg/dL",
                    style: TextStyle(
                      fontSize: 16,
                      color: isMgDl ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),

            ],
          ),
          SizedBox(height: 30),
          // Thanh trượt để chọn giá trị
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: Colors.pink, // Màu thanh trượt khi đang hoạt động
              inactiveTrackColor: Colors.grey[300], // Màu thanh trượt khi không hoạt động
              thumbColor: Colors.pinkAccent, // Màu chấm trượt
              overlayColor: Colors.pink.withOpacity(0.2), // Màu phủ khi chấm trượt được nhấn
              valueIndicatorColor: Colors.pinkAccent, // Màu của chỉ báo giá trị
              valueIndicatorTextStyle: TextStyle(color: Colors.white), // Màu chữ trong chỉ báo giá trị
              trackHeight: 8, // Độ cao của thanh trượt
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15), // Kích thước thumb
              trackShape: RoundedRectSliderTrackShape(), // Hình dạng của thanh trượt
              overlayShape: RoundSliderOverlayShape(overlayRadius: 30), // Kích thước của overlay
            ),
            child: Slider(
              value: bloodSugarValue,
              min: 0.0,
              max: 899.5,
              divisions: 8995, // Chia thành 8995 đoạn để mỗi bước là 0.1
              label: bloodSugarValue.toStringAsFixed(1), // Hiển thị giá trị của slider
              onChanged: (value) {
                setState(() {
                  bloodSugarValue = value;
                });
              },
            ),
          ),
          Text(
            "Đường huyết đơn vị mg/dL (36~899)",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 85),
          // Các nút trạng thái bữa ăn
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMealButton("Nhịn ăn", 0, "8 giờ hoặc hơn kể từ sau bữa ăn gần nhất", Colors.pink),
              SizedBox(width: 10),
              _buildMealButton("Sau ăn", 1, "2 giờ sau khi ăn", Colors.purple.shade100),
              SizedBox(width: 10),
              _buildMealButton("Trước ăn", 2, "Bất cứ khi nào", Colors.grey),
            ],
          ),
          SizedBox(height: 8),
          // Mô tả trạng thái bữa ăn
          Text(
            mealDescription,
            style: TextStyle(
              fontSize: 14,
              color: selectedMealState == 0
                  ? Colors.pink
                  : selectedMealState == 1
                  ? Colors.purple.shade200
                  : Colors.grey,
            ),
          ),
          Spacer(),
          // Nút "Tiếp tục"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Tiếp tục",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  // Hàm xây dựng nút trạng thái bữa ăn với màu và mô tả tùy chỉnh
  Widget _buildMealButton(String text, int index, String description, Color color) {
    bool isSelected = selectedMealState == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMealState = index;
          mealDescription = description;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
