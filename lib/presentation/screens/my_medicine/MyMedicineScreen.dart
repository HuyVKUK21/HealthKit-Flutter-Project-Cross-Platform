import 'package:fitnessapp/presentation/screens/my_medicine/EditMedicineScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/models/MedicineModel.dart';
import '../../../utils/page_route_builder.dart';
import '../../widgets/appbar/custom_app_bar.dart';
import '../../widgets/my_medicine/medicine_card.dart';

class MyMedicineScreen extends StatefulWidget {
  static String routeName = "/MyMedicineScreen";

  @override
  State<MyMedicineScreen> createState() => _MyMedicineScreenState();
}

class _MyMedicineScreenState extends State<MyMedicineScreen> {
  final DateTime today = DateTime.now();
  final List<String> weekdays = ["CN", "TH 2", "TH 3", "TH 4", "TH 5", "TH 6", "TH 7"];
  final ScrollController _scrollController = ScrollController();

  List<Medicine> yourListOfMedicineData() {
    return [
      Medicine(
          medicineName: "A.t Ibuprofen",
          dosageTime: "8:00",
          remainingDoses: "29",
          usageStatus: true,
      ),
      Medicine(
        medicineName: "Paracetamol",
        dosageTime: "12:00",
        remainingDoses: "15",
      ),
      Medicine(
        medicineName: "A.t Ibuprofen",
        dosageTime: "8:00",
        remainingDoses: "29",
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToCurrentDay());
  }

  void _scrollToCurrentDay() {
    double screenWidth = MediaQuery.of(context).size.width;
    double position = (today.weekday - 1) * 58.0 - (screenWidth / 2) + 29.0; // Center the current day
    _scrollController.animateTo(
      position,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Thuốc của tôi',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  height: 80.0,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: 14,
                    itemBuilder: (context, index) {
                      DateTime date = today.add(Duration(days: index - today.weekday + 1));
                      String dayOfWeek = weekdays[date.weekday % 7];
                      String formattedDate = DateFormat('dd').format(date);

                      bool isToday = date.day == today.day && date.month == today.month && date.year == today.year;

                      return Column(
                        children: [
                          Center(
                            child: Text(
                              isToday ? "\t\t\t\t\t${formattedDate}\nHôm nay" : formattedDate + "\n",
                              style: TextStyle(
                                color: isToday ? Colors.red : Colors.black,
                                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            width: 50.0,
                            margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
                            decoration: BoxDecoration(
                              color: isToday ? Colors.grey[300] : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                dayOfWeek,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: isToday ? FontWeight.w500 : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
              children: [
                ...yourListOfMedicineData().map((medicine) {
                  return MedicineCard(
                      medicineName: medicine.medicineName,
                      dosageTime: medicine.dosageTime,
                      remainingDoses: medicine.remainingDoses,
                      offStatus: false,
                      usageStatus: medicine.usageStatus,
                      iconRight: "check",
                      onEditPressed: () {
                        _showMedicineDialog(context, medicine.medicineName, medicine.dosageTime);
                      },
                  );
                }).toList(),
                SizedBox(height: 16.0), // Spacing after the list
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          RouteHelper.createFadeRoute(EditMedicineScreen())
                      );
                    },
                    icon: Icon(Icons.edit, color: Colors.white),
                    label: Text(
                      "Chỉnh sửa hộp thuốc",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _showMedicineDialog(BuildContext context, String medicineName, String dosageTime) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                radius: 36,
                child: Icon(Icons.more_horiz, size: 36, color: Colors.black),
              ),
              SizedBox(height: 16.0),
              Text(
                medicineName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                "Đã bỏ qua 1 lần dùng lúc $dosageTime",
                style: TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: BorderSide(color: Colors.black, width: 1.0)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                ),
                child: Icon(Icons.check),
              ),
              SizedBox(height: 24.0),
              Text(
                "Đổi thành đã uống",
                style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    },
  );
}
