import 'package:fitnessapp/domain/entities/account_entity.dart';
import 'package:fitnessapp/domain/entities/bloodsure_entity.dart';
import 'package:fitnessapp/presentation/bloc/bloodsure/bloodsure_bloc.dart';
import 'package:fitnessapp/presentation/events/bloodsure/bloodsure_event.dart';
import 'package:fitnessapp/presentation/screens/bloodsugar/bloodsugar_screen.dart';
import 'package:fitnessapp/presentation/state/bloodsure/bloodsure_state.dart';
import 'package:fitnessapp/presentation/widgets/appbar/custom_app_bar.dart';
import 'package:fitnessapp/utils/global/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BloodsureScreen extends StatefulWidget {
  static String routeName = "/BloodsureScreen";

  const BloodsureScreen({super.key});

  @override
  _BloodsureScreenState createState() => _BloodsureScreenState();
}


class _BloodsureScreenState extends State<BloodsureScreen> {

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
    context.read<BloodsureBloc>().add(LoadBloodsureData(userId));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: BlocBuilder<BloodsureBloc, BloodsureState>(
        builder: (context, state) {
            if(state is BloodsureLoading) {
              return Center(child: CircularProgressIndicator());
            }
            else if (state is BloodsureLoaded){

              final bloodData = state.bloodsureEntity;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Chỉ số huyết áp",
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
                                            Text("${bloodData.systolic} / ${bloodData.diastolic} ",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black)),
                                            FaIcon(
                                              FontAwesomeIcons.heart,
                                              color: Colors.red,
                                              size: 16.0,
                                            ),
                                            Text(" ${bloodData.heartRate}",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 20),
                                        IndicatorText(
                                            label: "Rất thấp", color: Colors.blue),
                                        SizedBox(height: 14),
                                        IndicatorText(
                                            label: "Thấp", color: Colors.lightBlue),
                                        SizedBox(height: 14),
                                        IndicatorText(
                                            label: "Bình thường", color: Colors.green),
                                        SizedBox(height: 14),
                                        IndicatorText(
                                            label: "Hơi cao", color: Colors.yellow),
                                        SizedBox(height: 14),
                                        IndicatorText(
                                            label: "Cao", color: Colors.deepOrangeAccent),
                                        SizedBox(height: 14),
                                        IndicatorText(
                                            label: "Rất cao", color: Colors.deepOrange),
                                        SizedBox(height: 14),
                                        IndicatorText(
                                            label: "Cực kỳ cao", color: Colors.red),
                                      ],
                                    ),
                                    Center(
                                      child: CircularPercentIndicator(
                                        radius: 100.0,
                                        lineWidth: 15.0,
                                        percent: 1.0,
                                        center: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("100%",
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold)),
                                            Text("đạt mục tiêu",
                                                style: TextStyle(color: Colors.grey)),
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
                    BloodPressureLevelsTable(), // New table widget
                    Padding(
                      padding: const EdgeInsets.only(top: 0, bottom: 24, left: 24, right: 24),
                      child: Container(
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 12,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Những thông số huyết áp này của tôi nghĩa là gì?",
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        "Tìm hiểu ngay",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 8),
                                Image.asset(
                                  'assets/images/doctor_image.png',
                                  height: 100,
                                  width: 100,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            else {
              return Center(child: Text('Có lỗi xảy ra'));
            }


        },
      ),
    );
  }
}

// Widget for the blood pressure levels table
class BloodPressureLevelsTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 24, left: 24, right: 24),
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mức tăng huyết áp",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Table(
              children: [
                _buildTableRow("Huyết áp thấp", "< 90", "< 60", Colors.blue),
                _buildTableRow("Tối ưu", "90 - 119", "60 - 79", Colors.lightBlue),
                _buildTableRow("Bình thường", "120 - 129", "80 - 84", Colors.green),
                _buildTableRow("Tiền cao huyết áp", "130 - 139", "85 - 89", Colors.yellow),
                _buildTableRow("Giai đoạn 1", "140 - 159", "90 - 99", Colors.orange),
                _buildTableRow("Giai đoạn 2", "160 - 179", "100 - 109", Colors.redAccent),
                _buildTableRow("Giai đoạn 3", "≥ 180", "≥ 110", Colors.red),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "Nguồn: Hiệp hội Tim mạch Châu Âu",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, String systolic, String diastolic, Color color) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0), // Increased padding for height
          child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ),
        _buildTableCell(systolic, color),
        _buildTableCell(diastolic, color),
      ],
    );
  }

  Widget _buildTableCell(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0), // Adds space between cells
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 8), // Increased padding for height
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
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

