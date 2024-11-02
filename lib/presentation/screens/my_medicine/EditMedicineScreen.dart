import 'package:fitnessapp/presentation/screens/my_medicine/MyMedicineScreen.dart';
import 'package:fitnessapp/utils/page_route_builder.dart';
import 'package:flutter/material.dart';

import '../../widgets/my_medicine/medicine_card.dart';
import '../../widgets/my_medicine/session_header.dart';

class EditMedicineScreen extends StatefulWidget {
  @override
  _EditMedicineScreenState createState() => _EditMedicineScreenState();
}

class _EditMedicineScreenState extends State<EditMedicineScreen> {
  bool isExpiredSectionExpanded = true;
  bool isInactiveSectionExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(context, RouteHelper.createFadeRoute(MyMedicineScreen()));
          },
        ),
        title: Text(
          'Hộp thuốc của tôi',
          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            SectionHeader(
              title: 'Còn hạn (1)',
              isExpanded: isExpiredSectionExpanded,
              onToggle: () {
                setState(() {
                  isExpiredSectionExpanded = !isExpiredSectionExpanded;
                });
              },
            ),
            if (isExpiredSectionExpanded) // Only show content if expanded
              MedicineCard(
                medicineName: 'A.t ibuprofen',
                dosageTime: '8:00',
                remainingDoses: '28 lần dùng còn lại',
                offStatus: false,
                iconRight: "edit",
                usageStatus: true,
              ),
            // Collapsible Section for "Đang tắt"
            SectionHeader(
              title: 'Đang tắt (2)',
              isExpanded: isInactiveSectionExpanded,
              onToggle: () {
                setState(() {
                  isInactiveSectionExpanded = !isInactiveSectionExpanded;
                });
              },
            ),
            if (isInactiveSectionExpanded) // Only show content if expanded
              Column(
                children: [
                  MedicineCard(
                    medicineName: 'A.t ibuprofen',
                    dosageTime: '8:00',
                    remainingDoses: '28 lần dùng còn lại',
                    offStatus: true,
                    iconRight: "edit",
                  ),
                  MedicineCard(
                    medicineName: 'A.t ibuprofen',
                    dosageTime: '8:00',
                    remainingDoses: '28 lần dùng còn lại',
                    offStatus: true,
                    iconRight: "edit",
                  ),
                ],
              ),
            Spacer(),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Handle "Thêm thuốc" button press
                },
                icon: Icon(Icons.add, color: Colors.white),
                label: Text('Thêm thuốc', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
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