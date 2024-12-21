import 'dart:async';

import 'package:fitnessapp/domain/usecases/medicine/medicine_usecase.dart';
import 'package:fitnessapp/presentation/screens/my_medicine/view_medicine_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/models/medicine_model.dart';
import '../../../data/repositories/medicine/medicine_repository_impl.dart';
import '../../../utils/page_route_builder.dart';
import '../../dialogs/my_medicine/medicine_dialog.dart';
import '../../widgets/appbar/custom_app_bar.dart';
import '../../widgets/my_medicine/medicine_card.dart';

class MyMedicineScreen extends StatefulWidget {
  static String routeName = "/MyMedicineScreen";

  final String idUser;

  MyMedicineScreen({required this.idUser});

  @override
  State<MyMedicineScreen> createState() => _MyMedicineScreenState();
}

class _MyMedicineScreenState extends State<MyMedicineScreen> {
  final DateTime today = DateTime.now();
  final List<String> weekdays = ["CN", "TH 2", "TH 3", "TH 4", "TH 5", "TH 6", "TH 7"];
  final ScrollController _scrollController = ScrollController();
  late List<MedicineModel> _medicineList = [];
  late MedicineUseCase _medicineUseCase;
  late MedicineModel medicineInfo;

  // Khởi tạo
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToCurrentDay());
    _medicineUseCase = MedicineUseCase(MedicineRepositoryImpl());
    _fetchMedicines();
    _scheduleMidnightReset();
  }

  // Duyệt danh sách dữ liệu thuốc
  Future<void> _fetchMedicines() async {
    try {
      List<MedicineModel> medicines = await _medicineUseCase.getMedicineData(widget.idUser);
      setState(() {
        _medicineList = medicines.where((medicine) => !medicine.offStatus! && !(medicine.isDeleted ?? false)).toList();
      });
    } catch (e) {
      print('Error fetching medicines: $e');
    }
  }

  // reset lượt uống sau 12h đêm
  void _scheduleMidnightReset() {
    DateTime now = DateTime.now();
    DateTime nextMidnight = DateTime(now.year, now.month, now.day + 1);

    Duration timeUntilMidnight = nextMidnight.difference(now);

    Timer(timeUntilMidnight, () async {
      await _medicineUseCase.resetAllUsageStatuses();
      _scheduleMidnightReset();
    });
  }

  // Ngày hiện tại (tính toán + animation)
  void _scrollToCurrentDay() {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = 58.0;
    double position = (today.weekday - 1) * itemWidth + (itemWidth / 2) - (screenWidth / 2);

    _scrollController.animateTo(
      position.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                      child: Row(
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
                      )
                    ),
                    SizedBox(height: 24.0),
                    SizedBox(
                      height: 90.0,
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: 30,
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
                                    color: isToday ? Colors.green : Colors.black,
                                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                                    fontSize: 12
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
              SizedBox(height: 12.0),
              Expanded(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  itemCount: _medicineList.length + 1,
                  itemBuilder: (context, index) {
                    if (index == _medicineList.length) {
                      // Last item for the button
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        child: Center(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                RouteHelper.createFadeRoute(ViewMedicineScreen(idUser: widget.idUser,)),
                              );
                            },
                            icon: Icon(Icons.edit, color: Colors.white),
                            label: Text(
                              "Chỉnh sửa hộp thuốc",
                              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      );
                    }

                    // Display medicine card
                    MedicineModel medicine = _medicineList.elementAt(index);
                    return Column(
                      children: [
                        MedicineCard(
                          medicineName: medicine.medicineName,
                          dosageTime: medicine.dosageTime,
                          remainingDoses: medicine.remainingDoses,
                          offStatus: medicine.offStatus,
                          usageStatus: medicine.usageStatus,
                          iconRight: "check",
                          onEditPressed: () async {
                            try {
                              MedicineModel fetchedMedicineInfo = await _medicineUseCase.getMedicineById(medicine.id);
                              setState(() {
                                medicineInfo = fetchedMedicineInfo;
                              });
                              showMedicineDialog(
                                  context,
                                  medicineInfo.medicineName,
                                  medicineInfo.usageStatus,
                                  medicineInfo.dosageTime,
                                  () async {
                                    await _medicineUseCase.updateUsageStatusMedicine(medicine.id, medicine.usageStatus);
                                    Navigator.pushReplacement(
                                        context,
                                        RouteHelper.createFadeRoute(MyMedicineScreen(idUser: widget.idUser,))
                                    );
                                  });
                            } catch (e) {
                              print('Error fetching medicine info: $e');
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
