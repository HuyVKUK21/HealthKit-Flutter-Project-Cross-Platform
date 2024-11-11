import 'package:fitnessapp/domain/entities/account_entity.dart';
import 'package:fitnessapp/presentation/bloc/bloodsugar/bloodsugar_bloc.dart';
import 'package:fitnessapp/presentation/events/bloodsugar/bloodsugar_event.dart';
import 'package:fitnessapp/presentation/state/bloodsugar/bloodsugar_state.dart';
import 'package:fitnessapp/presentation/widgets/appbar/custom_app_bar.dart';
import 'package:fitnessapp/utils/global/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BloodSugarScreen extends StatefulWidget {
  static String routeName = "/BloodsugarScreen";

  const BloodSugarScreen({super.key});

  @override
  _BloodSugarScreenState createState() => _BloodSugarScreenState();
}

class _BloodSugarScreenState extends State<BloodSugarScreen> {
  late String userId = "";
  String? _targetScreen;
  AccountEntity? account;

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  Future<void> _getUserId() async {
    final fetchedAccount = await GlobalUtil.getAccount();
    setState(() {
      account = fetchedAccount;
      if (account != null) {
        userId = account!.userId;
      }
    });
    context.read<BloodsugarBloc>().add(LoadBloodsugarData(userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: BlocBuilder<BloodsugarBloc, BloodsugarState>(
        builder: (context, state) {
          if (state is BloodsugarLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BloodsugarLoaded) {
            final bloodSugarData = state.bloodsugarEntity;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Khối Glucose
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Chỉ số đường huyết",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      Text("THG 10 2024",
                                          style: TextStyle(color: Colors.grey)),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          Text("${bloodSugarData.index}",
                                              style: TextStyle(
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                          Text(" mg/DL",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Phần bên trái chứa các chỉ số
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      IndicatorText(
                                          label: "Rất thấp",
                                          color: Colors.blue),
                                      SizedBox(height: 14),
                                      IndicatorText(
                                          label: "Thấp",
                                          color: Colors.lightBlue),
                                      SizedBox(height: 14),
                                      IndicatorText(
                                          label: "Bình thường",
                                          color: Colors.green),
                                      SizedBox(height: 14),
                                      IndicatorText(
                                          label: "Cao", color: Colors.red),
                                    ],
                                  ),
                                  Center(
                                    child: CircularPercentIndicator(
                                      radius: 100.0,
                                      lineWidth: 15.0,
                                      percent: 1.0,
                                      center: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("100%",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold)),
                                          Text("đạt mục tiêu",
                                              style: TextStyle(
                                                  color: Colors.grey)),
                                        ],
                                      ),
                                      progressColor: Colors.green,
                                      backgroundColor: Colors.grey[200]!,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Khối HbA1c
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 24, left: 24, right: 24),
                    child: Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Chỉ số HbA1c",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  Text("THG 10 2024",
                                      style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Text("${bloodSugarData.index}",
                                          style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      Text(" mg/DL",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          SizedBox(height: 10),
                          Text("7.6%",
                              style: TextStyle(
                                  fontSize: 38,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          LinearProgressIndicator(
                            value: 0.76,
                            backgroundColor: Colors.grey[300],
                            color: Colors.red,
                            minHeight: 10,
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Trong mục tiêu",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                              Text("Trên mục tiêu",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bảng Mức đường huyết
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 24, left: 24, right: 24),
                    child: Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Mức đường huyết",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 16),
                          Table(
                            border: TableBorder.symmetric(
                              inside: BorderSide(
                                  width: 1, color: Colors.grey.shade300),
                            ),
                            columnWidths: {
                              0: FractionColumnWidth(0.25),
                              1: FractionColumnWidth(0.25),
                              2: FractionColumnWidth(0.25),
                              3: FractionColumnWidth(0.25),
                            },
                            children: [
                              _buildTableHeader(),
                              _buildTableRow("Cao", "> 130 mg/dL",
                                  "> 180 mg/dL", "> 130 mg/dL", Colors.red),
                              _buildTableRow(
                                  "BT",
                                  "70 - 130 mg/dL",
                                  "70 - 179 mg/dL",
                                  "70 - 130 mg/dL",
                                  Colors.green),
                              _buildTableRow(
                                  "Thấp",
                                  "54 - 69 mg/dL",
                                  "54 - 69 mg/dL",
                                  "54 - 69 mg/dL",
                                  Colors.lightBlue),
                              _buildTableRow("Rất thấp", "< 54 mg/dL",
                                  "< 54 mg/dL", "< 54 mg/dL", Colors.blue),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Nguồn: Hiệp hội Tiểu đường Hoa Kỳ (ADA)",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Phần Sổ theo dõi
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 10.0),
                    child: TrackingButton(),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('Có lỗi xảy ra'));
          }
        },
      ),
    );
  }

  TableRow _buildTableHeader() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.grey.shade100),
      children: [
        _buildHeaderCell("MỨC"),
        _buildHeaderCell("NHỊN ĂN"),
        _buildHeaderCell("SAU ĂN"),
        _buildHeaderCell("TRƯỚC ĂN"),
      ],
    );
  }

  TableRow _buildTableRow(String label, String fasting, String postMeal,
      String preMeal, Color color) {
    return TableRow(
      children: [
        _buildCell(label, color),
        _buildCell(fasting),
        _buildCell(postMeal),
        _buildCell(preMeal),
      ],
    );
  }

  Widget _buildHeaderCell(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildCell(String text, [Color? color]) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color ?? Colors.black,
          ),
        ),
      ),
    );
  }
}

class IndicatorText extends StatelessWidget {
  final String label;
  final Color color;

  const IndicatorText({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 5, backgroundColor: color),
        SizedBox(width: 5),
        Text(label, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}

class TrackingButton extends StatelessWidget {
  const TrackingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(Icons.book, color: Colors.blueAccent, size: 40),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sổ theo dõi",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 2),
                Text("Xem tất cả lần đo của bạn",
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
