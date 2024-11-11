import 'package:fitnessapp/data/models/medicine_model.dart';
import 'package:flutter/material.dart';

import '../../../data/repositories/medicine/medicine_repository_impl.dart';
import '../../../domain/usecases/medicine/medicine_usecase.dart';
import '../../../utils/page_route_builder.dart';
import 'my_medicine_screen.dart';

class AddMedicineScreen extends StatefulWidget {
  final String idUser;

  AddMedicineScreen({required this.idUser});

  @override
  _AddMedicineScreenState createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final _formKey = GlobalKey<FormState>();

  String medicineName = '';
  String dosage = '';
  String form = '';
  String treatment = '';
  int remainingDoses = 0;
  String frequency = '';
  String schedule = '';

  late MedicineUseCase _medicineUseCase;

  // Khởi tạo
  @override
  void initState() {
    super.initState();
    _medicineUseCase = MedicineUseCase(MedicineRepositoryImpl());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tùy chỉnh thuốc"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Thông tin thuốc",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildListItem("Tên", (value) => medicineName = value),
              _buildListItem("Liều lượng", (value) => dosage = value),
              _buildListItem("Dạng", (value) => form = value),
              _buildListItem("Điều trị", (value) => treatment = value),
              _buildListItem("Trong hộp", (value) {
                remainingDoses = int.tryParse(value) ?? remainingDoses;
              }, isNumeric: true),
              SizedBox(height: 20),
              Text(
                "Nhắc nhở",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildListItem("Tần suất (ngày)", (value) => frequency = value),
              _buildListItem("Đặt lịch", (value) => schedule = value),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      MedicineModel medicine = MedicineModel(
                          medicineName: medicineName,
                          dosageTime: schedule,
                          remainingDoses: remainingDoses,
                          drugForm: form,
                          frequencyUse: int.parse(frequency),
                          idUser: widget.idUser,
                          offStatus: false,
                          usageStatus: false,
                      );
                      try {
                        _medicineUseCase.insertMedicine(medicine);
                        Navigator.push(
                          context,
                          RouteHelper.createFadeRoute(MyMedicineScreen(idUser: widget.idUser,)),
                        );
                      } catch (e) {}

                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(
                          color: Colors.grey.shade300, width: 1.0),
                    ),
                  ),
                  child: Text("Lưu"),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(String label, Function(String) onChanged, {bool isNumeric = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Icon(_getIcon(label), color: Colors.grey, size: 30,),
          SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
              decoration: InputDecoration(
                hintText: label,
                border: InputBorder.none,
                isDense: true,
              ),
              onChanged: onChanged,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '$label không được bỏ trống';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon(String label) {
    switch (label) {
      case "Tên":
        return Icons.medical_services_outlined;
      case "Liều lượng":
        return Icons.opacity;
      case "Dạng":
        return Icons.tablet;
      case "Điều trị":
        return Icons.healing;
      case "Trong hộp":
        return Icons.inventory;
      case "Tần suất (ngày)":
        return Icons.schedule;
      case "Đặt lịch":
        return Icons.alarm;
      default:
        return Icons.info_outline;
    }
  }
}
