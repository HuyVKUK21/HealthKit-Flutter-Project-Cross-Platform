import 'package:fitnessapp/data/models/cigarette_model.dart';
import 'package:fitnessapp/presentation/screens/home/home_screen.dart';
import 'package:fitnessapp/presentation/screens/quit_smoking/smoking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/repositories/cigarette/cigarette_repository_impl.dart';
import '../../../domain/usecases/cigarette/cigarette_usecase.dart';
import '../../../utils/page_route_builder.dart';
import '../dashboard/dashboard_screen.dart';

class ProfileSmokingScreen extends StatefulWidget {
  final String idUser;

  ProfileSmokingScreen({required this.idUser});

  @override
  _ProfileSmokingScreenState createState() => _ProfileSmokingScreenState();
}

class _ProfileSmokingScreenState extends State<ProfileSmokingScreen> {
  DateTime? _selectedDate;
  String? _day;
  String? _month;
  String? _year;

  // Controllers for input fields
  final TextEditingController _dailyConsumptionController = TextEditingController();
  final TextEditingController _cigarettesPerPackController = TextEditingController();
  final TextEditingController _pricePerPackController = TextEditingController();

  late CigaretteUseCase _cigaretteUseCase;

  // Khởi tạo
  @override
  void initState()  {
    super.initState();
    _cigaretteUseCase = CigaretteUseCase(CigaretteRepositoryImpl());
  }

  void _showDatePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 300,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Đặt ngày",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      _selectedDate = newDate;
                      _day = _selectedDate!.day.toString();
                      _month = _selectedDate!.month.toString();
                      _year = _selectedDate!.year.toString();
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Hoàn tất',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
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
                        context, RouteHelper.createFadeRoute(DashboardScreen()));
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
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Center(
                child: Text(
                  "Hồ sơ",
                  style: TextStyle(
                    color: Colors.green.shade500,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Text(
                  "Hoàn tất hồ sơ hút thuốc của bạn",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green.shade500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 60),
              Text(
                "Khi nào bạn muốn bỏ thuốc?",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () => _showDatePicker(context),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.calendar_today, color: Color(0xFF6F6F6F)),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          _selectedDate != null
                              ? "${_selectedDate!.day} tháng ${_selectedDate!.month} năm ${_selectedDate!.year}"
                              : "Chọn ngày bỏ thuốc của bạn",
                          style: TextStyle(color: Color(0xFFCBCBCB), fontSize: 16),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _buildInputField(
                icon: Icons.smoking_rooms,
                hintText: "Nhập mức tiêu thụ hàng ngày",
                labelText: "Bạn hút bao nhiêu điếu mỗi ngày?",
                controller: _dailyConsumptionController,
              ),
              _buildInputField(
                icon: Icons.local_offer, // Icon gói thuốc
                hintText: "Nhập số (ví dụ: 20)",
                labelText: "Số điếu trong một gói",
                controller: _cigarettesPerPackController,
              ),
              _buildInputField(
                icon: Icons.flag, // Icon cờ Việt Nam
                hintText: "Nhập giá",
                labelText: "Giá một gói thuốc",
                controller: _pricePerPackController,
                currencyIcon: Icons.flag,
              ),
              Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_pricePerPackController.text.isEmpty ||
                            _cigarettesPerPackController.text.isEmpty ||
                            _dailyConsumptionController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Vui lòng điền đầy đủ thông tin'),
                            ),
                          );
                          return;
                        }

                        CigaretteModel cigarette = CigaretteModel(
                          smokingStatusToday: false,
                          completedStatus: false,
                          price: int.parse(_pricePerPackController.text),
                          cigaretteInPack: int.parse(_cigarettesPerPackController.text),
                          remainingCigarette: int.parse(_cigarettesPerPackController.text),
                          endDate: '$_day thg $_month, $_year',
                          startDate: '${DateTime.now().day} thg ${DateTime.now().month}, ${DateTime.now().year}',
                          smokeDaily: int.parse(_dailyConsumptionController.text),
                          amountAvoidedReport: 0,
                          amountSmokedReport: 0,
                          amountQuitSmoking: 0,
                          amountDayQuit: 0,
                          idUser: widget.idUser,
                        );

                        try {
                          await _cigaretteUseCase.insertCigarette(cigarette);
                          Navigator.pushReplacement(
                            context,
                            RouteHelper.createFadeRoute(QuitSmokingPage(idUser: widget.idUser,))
                          );
                        } catch (e) {}
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade500,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text(
                        'Tiếp theo',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required String hintText,
    required String labelText,
    required TextEditingController controller,
    IconData? currencyIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: hintText,
                hintStyle: TextStyle(color: Color(0xFFCBCBCB)),
                prefixIcon: currencyIcon != null
                    ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(currencyIcon, color: Colors.red),
                    ),
                    Text(
                      "VND",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                )
                    : Icon(icon, color: Color(0xFF6F6F6F)),
                prefixIconConstraints: BoxConstraints(minWidth: 50, minHeight: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
