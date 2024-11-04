import 'package:fitnessapp/domain/entities/weight_entity.dart';
import 'package:fitnessapp/presentation/bloc/weight/weight_bloc.dart';
import 'package:fitnessapp/presentation/events/weight/weight_event.dart';
import 'package:fitnessapp/presentation/state/weight/weight_state.dart';
import 'package:fitnessapp/presentation/widgets/appbar/custom_app_bar.dart';
import 'package:fitnessapp/utils/global/user.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class WeightScreen extends StatefulWidget {
  static String routeName = "/WeightScreen";

  const WeightScreen({super.key});

  @override
  _WeightScreenState createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  late String userId = "";
  String? _targetScreen;

  @override
  void initState() {
    super.initState();
    _getUserId();

  }

  Future<void> _getUserId() async {
    userId = (await GlobalUtil.getUserId())!;
    context.read<WeightBloc>().add(LoadWeightData(userId));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: BlocBuilder<WeightBloc, WeightState>(
        builder: (context, state) {
          if (state is WeightLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is WeightLoaded) {
            final weightData = state.weightEntity;
            final currentWeight = weightData.currentWeight;
            final bmi = weightData.bmi;
            final bmiStatus = weightData.currentWeight;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWeightStats(weightData),
                    _buildWeightChart(weightData),
                    _buildControlPanel(),
                    _buildBmiSection(bmi!),
                    _buildWeightHistory(),
                    _buildRecommendations(),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text('Có lỗi xảy ra'));
          }
        },
      ),
    );
  }


  Widget _buildWeightStats(WeightEntity weightData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "TRUNG BÌNH NGÀY",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  Text(
                    "${weightData.currentWeight}", // Use currentWeight from weightData
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      "kg",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.circle, color: Colors.amber, size: 8),
                  SizedBox(width: 4),
                  Text(
                    "BMI: ${weightData.bmi}", // Display the BMI
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Center(
            child: Container(
              width: 150,
              height: 36,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<String>(
                value: 'Hiển thị theo Tuần',
                items: <String>[
                  'Hiển thị theo Tuần'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 8, color: Colors.grey),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {},
                underline: Container(),
                icon: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                ),
                isExpanded: true,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWeightChart(WeightEntity weightData) {
    int todayIndex = DateTime.now().weekday;

    List<FlSpot> spots = [];


    for (int i = 1; i <= 7; i++) {
      double weight = weightData.currentWeight; // Hàm này cần được định nghĩa để lấy trọng số cho ngày i
      spots.add(FlSpot(i.toDouble(), weight));
    }
    return Container(
      height: 200,
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 12),
        ],
      ),
      child: LineChart(
        LineChartData(
          minX: 1,
          maxX: 7,
          minY: 0,
          maxY: 200,
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: Colors.green.shade400,
              barWidth: 3,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, bar, index) {
                  bool showDot = todayIndex == (index + 1);
                  return FlDotCirclePainter(
                    radius: showDot ? 6 : 0,
                    color: showDot ? Colors.green : Colors.transparent,
                    strokeWidth: 3,
                    strokeColor: Colors.green.shade400,
                  );
                },
              ),
              belowBarData: BarAreaData(show: false),
            ),
          ],
          titlesData: FlTitlesData(
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, _) {
                  const days = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
                  bool isToday = (value.toInt() == todayIndex);
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      days[value.toInt() - 1],
                      style: TextStyle(
                        color: isToday
                            ? Colors.green.shade700
                            : Colors.grey.shade600.withOpacity(0.5),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
          gridData: FlGridData(show: false),
        ),
      ),
    );
  }

  Widget _buildControlPanel() {
    return Container(
      padding: EdgeInsets.all(22),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 24),
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
              Text(
                "Kiểm soát cân nặng",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  "Tạo mới",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              FaIcon(FontAwesomeIcons.award, color: Colors.blue, size: 24),
              SizedBox(width: 8),
              Text(
                "--.-- kg",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 4),
              Text(
                "trước ---- --, ----",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 18,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 16),
          // Phần mô tả và hình ảnh
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  "Tạo kế hoạch để đạt mục tiêu cân nặng lý tưởng.",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
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
    );
  }

  Widget _buildBmiSection(double bmi) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Chỉ số khối cơ thể (BMI)",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 2),
              Text(
                "3 THG 11, 2024", // Date can be dynamic if needed
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 40,
                radiusFactor: 0.8,
                ranges: <GaugeRange>[
                  GaugeRange(startValue: 0, endValue: 18.5, color: Colors.blue),
                  GaugeRange(startValue: 18.5, endValue: 24.9, color: Colors.green),
                  GaugeRange(startValue: 24.9, endValue: 29.9, color: Colors.orange),
                  GaugeRange(startValue: 29.9, endValue: 40, color: Colors.red),
                ],
                pointers: <GaugePointer>[
                  NeedlePointer(value: bmi), // Use dynamic BMI value
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    widget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          bmi.toStringAsFixed(1), // Display BMI value dynamically
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          _getBmiStatus(bmi), // Display BMI status
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.amber,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    angle: 90,
                    positionFactor: 0.5,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }


  String _getBmiStatus(double bmi) {
    if (bmi < 18.5) {
      return "Thiếu cân";
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return "Bình thường";
    } else if (bmi >= 25 && bmi < 29.9) {
      return "Thừa cân";
    } else {
      return "Béo phì";
    }
  }

  Widget _buildWeightHistory() {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Lịch sử cân nặng",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Ngày", style: TextStyle(color: Colors.grey)),
              Text("Cân nặng", style: TextStyle(color: Colors.grey)),
            ],
          ),
          Divider(),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("11/2024"),
                    Text("50 kg"),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendations() {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gợi ý",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 12),
          Text(
              "• Duy trì cân nặng hiện tại bằng cách tăng cường tập thể dục và ăn uống hợp lý."),
          Text("• Giảm cân từ từ để đạt mục tiêu BMI trong vùng lý tưởng."),
        ],
      ),
    );
  }
}


