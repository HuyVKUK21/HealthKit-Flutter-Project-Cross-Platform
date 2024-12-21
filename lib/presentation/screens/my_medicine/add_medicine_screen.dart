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
  String form = 'Viên';
  String treatment = '';
  int remainingDoses = 1;
  String frequency = '1 lần';
  String schedule = '8:00 AM';

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
                    context,
                    RouteHelper.createFadeRoute(
                      MyMedicineScreen(idUser: widget.idUser),
                    ),
                  );
                },
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
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Thông tin thuốc",
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
              _buildListItem("Tên", (value) => medicineName = value),
              _buildListItem("Liều lượng", (value) => dosage = value),
              _buildDropdown(
                "Dạng",
                ["Viên", "Gói"],
                    (value) => setState(() => form = value!),
                form,
              ),
              _buildListItem("Điều trị", (value) => treatment = value),
              _buildDropdown(
                "Trong hộp",
                List.generate(30, (index) => (index + 1).toString()),
                    (value) => setState(() => remainingDoses = int.parse(value!)),
                remainingDoses.toString(),
              ),
              SizedBox(height: 20),
              Text(
                "Nhắc nhở",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildDropdown(
                "Tần suất",
                ["1 lần", "2 lần", "3 lần", "4 lần", "5 lần"],
                    (value) => setState(() => frequency = value!),
                frequency,
              ),
              _buildDropdown(
                "Đặt lịch",
                [
                  "12:00 AM", "1:00 AM", "2:00 AM", "3:00 AM", "4:00 AM", "5:00 AM",
                  "6:00 AM", "7:00 AM", "8:00 AM", "9:00 AM", "10:00 AM", "11:00 AM",
                  "12:00 PM", "1:00 PM", "2:00 PM", "3:00 PM", "4:00 PM", "5:00 PM",
                  "6:00 PM", "7:00 PM", "8:00 PM", "9:00 PM", "10:00 PM", "11:00 PM"
                ],
                    (value) => setState(() => schedule = value!),
                schedule,
              ),
              SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      MedicineModel medicine = MedicineModel(
                        medicineName: medicineName,
                        dosageTime: schedule,
                        remainingDoses: remainingDoses,
                        drugForm: form,
                        frequencyUse: int.parse(RegExp(r'\d+').firstMatch(frequency)!.group(0)!),
                        idUser: widget.idUser,
                        offStatus: false,
                        usageStatus: false,
                      );
                      try {
                        _medicineUseCase.insertMedicine(medicine);
                        Navigator.push(
                          context,
                          RouteHelper.createFadeRoute(MyMedicineScreen(idUser: widget.idUser)),
                        );
                      } catch (e) {
                        // Handle errors
                      }
                    }
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
                      Icon(Icons.save, size: 24, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Lưu",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
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
          Icon(_getIcon(label), color: Colors.grey, size: 30),
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

  Widget _buildDropdown(String label, List<String> options, void Function(String?)? onChanged, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Icon(_getIcon(label), color: Colors.grey, size: 30),
          SizedBox(width: 10),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: value,
              items: options.map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),
              onChanged: onChanged,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
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
      case "Tần suất":
        return Icons.schedule;
      case "Đặt lịch":
        return Icons.alarm;
      default:
        return Icons.info_outline;
    }
  }
}
