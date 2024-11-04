import 'package:fitnessapp/presentation/screens/my_medicine/edit_medicine_screen.dart';
import 'package:fitnessapp/presentation/screens/my_medicine/my_medicine_screen.dart';
import 'package:fitnessapp/utils/page_route_builder.dart';
import 'package:flutter/material.dart';

import '../../../data/models/medicine_model.dart';
import '../../../data/repositories/medicine/medicine_repository_impl.dart';
import '../../../domain/usecases/medicine/medicine_usecase.dart';
import '../../widgets/my_medicine/medicine_card.dart';
import '../../widgets/my_medicine/session_header.dart';

class ViewMedicineScreen extends StatefulWidget {
  @override
  _ViewMedicineScreen createState() => _ViewMedicineScreen();
}

class _ViewMedicineScreen extends State<ViewMedicineScreen> {
  bool isExpiredSectionExpanded = true;
  bool isInactiveSectionExpanded = false;
  late List<MedicineModel> _medicineList = [];
  late MedicineUseCase _medicineUseCase;
  late MedicineModel medicineInfo;

  @override
  void initState() {
    super.initState();
    _medicineUseCase = MedicineUseCase(MedicineRepositoryImpl());
    _fetchMedicines();
  }

  Future<void> _fetchMedicines() async {
    try {
      List<MedicineModel> medicines = await  _medicineUseCase.getMedicineData("nvCeupX3wCTu30uoXbDh");
      setState(() {
        _medicineList = medicines;
      });
    } catch (e) {
      print('Error fetching medicines: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    int countOffStatusFalse = _medicineList.where((medicine) => medicine.offStatus == false).length;
    int countOffStatusTrue = _medicineList.where((medicine) => medicine.offStatus == true).length;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.symmetric(vertical: 30),
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(context, RouteHelper.createFadeRoute(MyMedicineScreen()));
          },
        ),
        title: Container(
          margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
          child: Text(
            'Hộp thuốc của tôi',
            style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
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
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
                itemCount: _medicineList.where((medicine) => medicine.offStatus == false).length,
                itemBuilder: (context, index) {
                  // Display medicine card
                  MedicineModel medicine = _medicineList.where((medicine) => medicine.offStatus == false).elementAt(index);
                  return MedicineCard(
                    medicineName: medicine.medicineName,
                    dosageTime: medicine.dosageTime,
                    remainingDoses: medicine.remainingDoses,
                    offStatus: medicine.offStatus,
                    usageStatus: medicine.usageStatus,
                    iconRight: "edit",
                    onEditPressed: () async {
                      try {
                        MedicineModel fetchedMedicineInfo = await _medicineUseCase.getMedicineById(medicine.id);
                        setState(() {
                          medicineInfo = fetchedMedicineInfo;
                        });
                        Navigator.pushReplacement(context, RouteHelper.createFadeRoute(EditMedicineScreen(medicineInfo: medicineInfo,)));
                      } catch (e) {
                        print('Error fetching medicine info: $e');
                      }
                    },
                  );
                },
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
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                itemCount: _medicineList.where((medicine) => medicine.offStatus == true).length,
                itemBuilder: (context, index) {
                  // Display medicine card
                  MedicineModel medicine = _medicineList.where((medicine) => medicine.offStatus == true).elementAt(index);
                  return MedicineCard(
                    medicineName: medicine.medicineName,
                    dosageTime: medicine.dosageTime,
                    remainingDoses: medicine.remainingDoses,
                    offStatus: medicine.offStatus,
                    usageStatus: medicine.usageStatus,
                    iconRight: "edit",
                    onEditPressed: () {
                      Navigator.pushReplacement(context, RouteHelper.createFadeRoute(EditMedicineScreen(medicineInfo: medicineInfo,)));
                    },
                  );
                },
              ),
            Spacer(),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {},
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