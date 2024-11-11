import 'package:flutter/material.dart';
import 'package:fitnessapp/presentation/screens/my_medicine/edit_medicine_screen.dart';
import 'package:fitnessapp/presentation/screens/my_medicine/my_medicine_screen.dart';
import 'package:fitnessapp/utils/page_route_builder.dart';

import '../../../data/models/medicine_model.dart';
import '../../../data/repositories/medicine/medicine_repository_impl.dart';
import '../../../domain/usecases/medicine/medicine_usecase.dart';
import '../../widgets/my_medicine/session_medicine_lists.dart';

class ViewMedicineScreen extends StatefulWidget {
  final String idUser;

  ViewMedicineScreen({required this.idUser});

  @override
  _ViewMedicineScreen createState() => _ViewMedicineScreen();
}

class _ViewMedicineScreen extends State<ViewMedicineScreen> {
  bool isExpiredSectionExpanded = true;
  bool isInactiveSectionExpanded = false;
  late List<MedicineModel> _medicineList = [];
  late MedicineUseCase _medicineUseCase;

  @override
  void initState() {
    super.initState();
    _medicineUseCase = MedicineUseCase(MedicineRepositoryImpl());
    _fetchMedicines();
  }

  Future<void> _fetchMedicines() async {
    try {
      List<MedicineModel> medicines = await _medicineUseCase.getMedicineData(widget.idUser);
      setState(() {
        _medicineList = medicines;
      });
    } catch (e) {
      print('Error fetching medicines: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<MedicineModel> activeMedicines = _medicineList.where((medicine) => !medicine.offStatus! && !medicine.isDeleted!).toList();
    List<MedicineModel> inactiveMedicines = _medicineList.where((medicine) => medicine.offStatus! && !medicine.isDeleted!).toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.symmetric(vertical: 30),
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(context, RouteHelper.createFadeRoute(MyMedicineScreen(idUser: widget.idUser,)));
          },
        ),
        title: Container(
          margin: EdgeInsets.only(top: 24),
          child: Text(
            'Hộp thuốc của tôi',
            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            MedicineSection(
              title: 'Còn hạn (${activeMedicines.length})',
              isExpanded: isExpiredSectionExpanded,
              medicines: activeMedicines,
              onEditPressed: ((medicine) => _navigateToEditMedicine(context, medicine)),
              onToggle: () => setState(() => isExpiredSectionExpanded = !isExpiredSectionExpanded),
            ),
            MedicineSection(
              title: 'Đang tắt (${inactiveMedicines.length})',
              isExpanded: isInactiveSectionExpanded,
              medicines: inactiveMedicines,
              onEditPressed: (medicine) => _navigateToEditMedicine(context, medicine),
              onToggle: () => setState(() => isInactiveSectionExpanded = !isInactiveSectionExpanded),
            ),
            Spacer(),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  
                },
                icon: Icon(Icons.add, color: Colors.white, size: 20),
                label: Text('Thêm thuốc', style: TextStyle(color: Colors.white, fontSize: 16)),
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

  Future<void> _navigateToEditMedicine(BuildContext context, MedicineModel medicine) async {
    try {
      MedicineModel fetchedMedicineInfo = await _medicineUseCase.getMedicineById(medicine.id);
      Navigator.pushReplacement(context, RouteHelper.createFadeRoute(EditMedicineScreen(medicineInfo: fetchedMedicineInfo)));
    } catch (e) {
      print('Error fetching medicine info: $e');
    }
  }
}
