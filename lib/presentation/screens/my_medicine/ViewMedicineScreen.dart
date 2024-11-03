import 'package:fitnessapp/presentation/screens/my_medicine/MyMedicineScreen.dart';
import 'package:fitnessapp/utils/page_route_builder.dart';
import 'package:flutter/material.dart';

import '../../../data/models/MedicineModel.dart';
import '../../widgets/my_medicine/medicine_card.dart';
import '../../widgets/my_medicine/session_header.dart';

class ViewMedicineScreen extends StatefulWidget {
  @override
  _ViewMedicineScreen createState() => _ViewMedicineScreen();
}

class _ViewMedicineScreen extends State<ViewMedicineScreen> {
  bool isExpiredSectionExpanded = true;
  bool isInactiveSectionExpanded = true;

  // demo
  List<Medicine> yourListOfMedicineData() {
    return [
      Medicine(
        medicineName: "A.t Ibuprofen 1",
        dosageTime: "8:00",
        remainingDoses: "30",
        drugForm: "Viên",
        frequencyUse: 1,
        offStatus: false,
        usageStatus: true,
      ),
      Medicine(
        medicineName: "A.t Ibuprofen 2",
        dosageTime: "8:00",
        remainingDoses: "29",
        drugForm: "Viên",
        frequencyUse: 1,
        offStatus: false,
        usageStatus: false,
      ),
      Medicine(
        medicineName: "A.t Ibuprofen 3",
        dosageTime: "8:00",
        remainingDoses: "29",
        drugForm: "Viên",
        frequencyUse: 1,
        offStatus: true,
        usageStatus: false,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {

    int countOffStatusFalse = yourListOfMedicineData().where((medicine) => medicine.offStatus == false).length;
    int countOffStatusTrue = yourListOfMedicineData().where((medicine) => medicine.offStatus == true).length;

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
              title: 'Còn hạn ($countOffStatusFalse))',
              isExpanded: isExpiredSectionExpanded,
              onToggle: () {
                setState(() {
                  isExpiredSectionExpanded = !isExpiredSectionExpanded;
                });
              },
            ),
            if (isExpiredSectionExpanded)
              ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    ...yourListOfMedicineData()
                        .where((medicine) => medicine.offStatus == false)
                        .map((medicine) {
                      return  MedicineCard(
                        medicineName: medicine.medicineName,
                        dosageTime: medicine.dosageTime,
                        remainingDoses: medicine.remainingDoses,
                        offStatus: medicine.offStatus,
                        usageStatus: medicine.usageStatus,
                        iconRight: "edit",
                        onEditPressed: () {},
                      );
                    }),
                  ]
              ),
            SectionHeader(
              title: 'Đang tắt ($countOffStatusTrue)',
              isExpanded: isInactiveSectionExpanded,
              onToggle: () {
                setState(() {
                  isInactiveSectionExpanded = !isInactiveSectionExpanded;
                });
              },
            ),
            if (isInactiveSectionExpanded) // Only show content if expanded
              ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    ...yourListOfMedicineData()
                        .where((medicine) => medicine.offStatus == true)
                        .map((medicine) {
                      return  MedicineCard(
                        medicineName: medicine.medicineName,
                        dosageTime: medicine.dosageTime,
                        remainingDoses: medicine.remainingDoses,
                        offStatus: medicine.offStatus,
                        usageStatus: medicine.usageStatus,
                        iconRight: "edit",
                        onEditPressed: () {},
                      );
                    }),
                  ]
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