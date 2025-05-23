import 'package:fitnessapp/data/repositories/cigarette/cigarette_repository_impl.dart';
import 'package:fitnessapp/domain/usecases/cigarette/cigarette_usecase.dart';
import 'package:fitnessapp/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:fitnessapp/presentation/widgets/quit_smoking/smoking_plan.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../data/models/cigarette_model.dart';
import '../../widgets/quit_smoking/filter_tabbar.dart';
import '../../widgets/quit_smoking/general_progress.dart';
import '../home/home_screen.dart';

class QuitSmokingPage extends StatefulWidget {
  final String idUser;

  QuitSmokingPage({required this.idUser});

  @override
  _QuitSmokingPageState createState() => _QuitSmokingPageState();
}

class _QuitSmokingPageState extends State<QuitSmokingPage> {
  String _selectedFilter = "Tất cả";
  int _amountReport = 0;
  late CigaretteUseCase _cigaretteUseCase;
  late CigaretteModel cigaretteInfo = CigaretteModel(
      smokingStatusToday: false,
      price: 0,
      cigaretteInPack: 0,
      remainingCigarette: 0,
      startDate: '',
      endDate: '',
      smokeDaily: 0,
      amountQuitSmoking: 0,
      amountDayQuit: 0,
      idUser: widget.idUser
  );

  // Khởi tạo
  @override
  void initState()  {
    super.initState();
    _cigaretteUseCase = CigaretteUseCase(CigaretteRepositoryImpl());
    _fetchCigaretteInfo();
  }

  Future<void> _fetchCigaretteInfo() async {
    try {
      CigaretteModel cigarette = await _cigaretteUseCase.getCigaretteByUserId(widget.idUser);
      setState(() {
        cigaretteInfo = cigarette;
        _amountReport = cigaretteInfo.amountAvoidedReport! + cigaretteInfo.amountSmokedReport!;
      });
    } catch (e) {
      print('Error fetching cigarette data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              "Hút thuốc",
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardScreen()),
                      (route) => false,
                );
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.add, color: Colors.black),
                onPressed: () {

                },
              ),
            ]
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilterTabBar(),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "TỔNG HÀNG THÁNG",
                          style: TextStyle(fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "$_amountReport báo cáo",
                          style: TextStyle(fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Column(
                          children: [
                            if(_selectedFilter == 'Tất cả')
                              Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text("Cơn thèm", style: TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                                ],
                              ),
                            SizedBox(height: 4,),
                            if(_selectedFilter == 'Tất cả')
                              Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text("đã hút      ", style: TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                                ],
                              ),
                            if(_selectedFilter == 'Cơn thèm')
                              Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text("Cơn thèm", style: TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                                ],
                              ),
                            if(_selectedFilter == 'Đã hút')
                              Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text("đã hút      ", style: TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                                ],
                              ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(
                            30),
                      ),
                      child: DropdownButton<String>(
                        value: _selectedFilter,
                        underline: SizedBox.shrink(),
                        items: ["Tất cả", "Cơn thèm", "Đã hút"]
                            .map((value) =>
                            DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedFilter = value!;
                            if(_selectedFilter == 'Tất cả') {
                              _amountReport = cigaretteInfo.amountAvoidedReport! + cigaretteInfo.amountSmokedReport!;
                            }
                            if(_selectedFilter == 'Cơn thèm') {
                              _amountReport = cigaretteInfo.amountAvoidedReport!;
                            }
                            if(_selectedFilter == 'Đã hút') {
                              _amountReport = cigaretteInfo.amountSmokedReport!;
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Chart
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      width: 1,
                      color: Colors.grey.shade400
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              value: cigaretteInfo.amountAvoidedReport!.toDouble(),
                              color: Colors.grey,
                              title: 'Tránh hút',
                              titleStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            PieChartSectionData(
                              value: cigaretteInfo.amountSmokedReport!.toDouble(),
                              color: Colors.red,
                              title: 'Đã hút',
                              titleStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                          sectionsSpace: 2,
                          centerSpaceRadius: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GeneralProgress(
                  daysQuit: cigaretteInfo.amountAvoidedReport!,
                  cigarettesAvoided: cigaretteInfo.amountQuitSmoking,
                  moneySaved: (cigaretteInfo.amountQuitSmoking *
                      (cigaretteInfo.price / cigaretteInfo.cigaretteInPack))
                      .toStringAsFixed(2),
                ),
                SizedBox(height: 20),
                SmokingPlan(
                  dailyCigarettes: cigaretteInfo.smokeDaily,
                  startDate: cigaretteInfo.startDate,
                  endDate: cigaretteInfo.endDate,
                  onConfirm: (String newDate) async {
                    await _cigaretteUseCase.updateEndDate(cigaretteInfo.id!, newDate);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}