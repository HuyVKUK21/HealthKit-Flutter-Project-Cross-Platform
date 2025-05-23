import 'package:fitnessapp/presentation/screens/my_medicine/view_medicine_screen.dart';
import 'package:fitnessapp/utils/page_route_builder.dart';
import 'package:flutter/material.dart';

import '../../../data/models/medicine_model.dart';
import '../../../data/repositories/medicine/medicine_repository_impl.dart';
import '../../../domain/usecases/medicine/medicine_usecase.dart';
import '../../widgets/my_medicine/edit_medicine_item.dart';
import '../../dialogs//my_medicine/medicine_dialog.dart';

class EditMedicineScreen extends StatefulWidget {
  final MedicineModel medicineInfo;

  EditMedicineScreen({required this.medicineInfo});

  @override
  _EditMedicineScreenState createState() => _EditMedicineScreenState();
}

class _EditMedicineScreenState extends State<EditMedicineScreen> {
  late MedicineUseCase _medicineUseCase;

  @override
  void initState() {
    super.initState();
    _medicineUseCase = MedicineUseCase(MedicineRepositoryImpl());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context, RouteHelper.createFadeRoute(ViewMedicineScreen(idUser: widget.medicineInfo.idUser,)));
                  }
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/app_logo.png',
                    width: 34,
                    height: 34,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'HealthKit',
                    style: TextStyle(
                      color: Color(0xFF043723),
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    "Chỉnh sửa thuốc",
                    style: TextStyle(
                      color: Colors.green.shade500,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.medication,
                    color: Colors.green.shade500,
                    size: 28,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Chi tiết",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  // borderRadius: BorderRadius.circular(8.0),
                  // border: Border.all(color: Colors.grey.shade400, width: 1.0),
                ),
                child: Column(
                  children: [
                    _buildEditMedicineItem(
                      icon: Icons.medication,
                      title: "Tên",
                      value: "${widget.medicineInfo.medicineName}",
                    ),
                    _buildDivider(),
                    _buildEditMedicineItem(
                      icon: Icons.line_weight,
                      title: "Hàm lượng",
                      value: "-",
                    ),
                    _buildDivider(),
                    _buildEditMedicineItem(
                      icon: Icons.category,
                      title: "Dạng",
                      value: "Khác",
                    ),
                    _buildDivider(),
                    _buildEditMedicineItem(
                      icon: Icons.local_hospital,
                      title: "Điều trị",
                      value: "-",
                    ),
                    _buildDivider(),
                    _buildEditMedicineItem(
                      icon: Icons.inventory,
                      title: "Trong hộp",
                      value: "còn ${widget.medicineInfo.remainingDoses}",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Nhắc nhở",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(

                ),
                child: Column(
                    children: [
                    _buildDivider(),
                    _buildEditMedicineItem(
                  icon: Icons.calendar_today,
                  title: "Tần suất",
                  value: "${widget.medicineInfo.frequencyUse} lần/ngày",),
                      _buildDivider(),
                      _buildEditMedicineItem(
                        icon: Icons.schedule,
                        title: "Đặt lịch",
                        value: "${widget.medicineInfo.dosageTime} • Uống 1 viên",),

                  ],
                ),
              ),
              SizedBox(height: 50),
              if(widget.medicineInfo.offStatus == true)
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      try {
                        _medicineUseCase.deleteMedicine(widget.medicineInfo.id);
                        Navigator.pushReplacement(context,
                            RouteHelper.createFadeRoute(ViewMedicineScreen(idUser: widget.medicineInfo.idUser,)));
                      } catch (e) {
                        print('Error fetching medicine info: $e');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red.shade500,
                      minimumSize: Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(
                            color: Colors.grey.shade300, width: 1.0),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.delete_outline, size: 28,
                            color: Colors.white),
                        SizedBox(width: 8),
                        Text('Xóa', style: TextStyle(fontSize: 22)),
                      ],
                    ),
                  ),
                ),
              if(widget.medicineInfo.offStatus == true)
                SizedBox(height: 20),
              if(widget.medicineInfo.offStatus == true)
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        _medicineUseCase.updateOffStatusMedicine(
                            widget.medicineInfo.id,
                            widget.medicineInfo.offStatus);
                        Navigator.pushReplacement(context,
                            RouteHelper.createFadeRoute(ViewMedicineScreen(idUser: widget.medicineInfo.idUser,)));
                      } catch (e) {
                        print('Error fetching medicine info: $e');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      minimumSize: Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(
                            color: Colors.grey.shade300, width: 1.0),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Kích hoạt thuốc này',
                            style: TextStyle(fontSize: 22)),
                      ],
                    ),
                  ),
                ),
              if(widget.medicineInfo.offStatus == false)
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      showStatusMedicineDialog(
                        context,
                        widget.medicineInfo.medicineName, () async {
                        try {
                          await _medicineUseCase.updateOffStatusMedicine(
                              widget.medicineInfo.id,
                              widget.medicineInfo.offStatus);
                          Navigator.pushReplacement(
                            context,
                            RouteHelper.createFadeRoute(ViewMedicineScreen(idUser: widget.medicineInfo.idUser,)),
                          );
                        } catch (e) {
                          print('Error updating medicine status: $e');
                        }
                      },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green.shade500,
                      minimumSize: Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                            color: Colors.green.shade500, width: 1.0),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.pause, size: 28, color: Colors.white),
                        SizedBox(width: 8),
                        Text('Ngưng thuốc', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildDivider() {
  return SizedBox(
    height: 16,
    //
  );
}

Widget _buildEditMedicineItem(
    {required IconData icon, required String title, required String value}) {
  return Container(
    // Padding bên trong
    decoration: BoxDecoration(
      color: Colors.white, // Background color
      border: Border.all(color: Colors.grey, width: 1), // Grey border
      borderRadius: BorderRadius.circular(8), // Rounded corners
    ),
    child: EditMedicineItem(icon: icon, title: title, value: value),
  );
}