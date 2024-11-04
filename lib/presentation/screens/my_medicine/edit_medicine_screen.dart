import 'package:fitnessapp/presentation/screens/my_medicine/view_medicine_screen.dart';
import 'package:fitnessapp/utils/page_route_builder.dart';
import 'package:flutter/material.dart';

import '../../../data/models/medicine_model.dart';
import '../../widgets/my_medicine/edit_medicine_item.dart';

class EditMedicineScreen extends StatelessWidget {
  late final MedicineModel medicineInfo;

  EditMedicineScreen({required this.medicineInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: SizedBox.shrink(),
        actions: [
          IconButton(
            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
            icon: Icon(Icons.close, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacement(context, RouteHelper.createFadeRoute(ViewMedicineScreen()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Text(
              "Tùy chỉnh loại thuốc",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Chi tiết",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey.shade400, width: 1.0),
              ),
              child: Column(
                children: [
                  EditMedicineItem(icon: Icons.medication, title: "Tên", value: "${medicineInfo.medicineName}"),
                  Divider(),
                  EditMedicineItem(icon: Icons.line_weight, title: "Hàm lượng", value: "-"),
                  Divider(),
                  EditMedicineItem(icon: Icons.category, title: "Dạng", value: "Khác"),
                  Divider(),
                  EditMedicineItem(icon: Icons.local_hospital, title: "Điều trị", value: "-"),
                  Divider(),
                  EditMedicineItem(icon: Icons.inventory, title: "Trong hộp", value: "còn ${medicineInfo.remainingDoses}"),
                ],
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Nhắc nhở",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey.shade400, width: 1.0),
              ),
              child: Column(
                children: [
                  EditMedicineItem(icon: Icons.calendar_today, title: "Tần suất", value: "${medicineInfo.frequencyUse} lần/ngày"),
                  Divider(),
                  EditMedicineItem(icon: Icons.schedule, title: "Đặt lịch", value: "${medicineInfo.dosageTime} • Uống 1 viên"),
                ],
              ),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.0),
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: Colors.grey.shade300, width: 1.0),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.pause_circle_filled, size: 24, color: Colors.black),
                    SizedBox(width: 8),
                    Text('Ngưng thuốc', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
