import 'package:fitnessapp/utils/app_colors.dart';
import 'package:fitnessapp/view/activity/widgets/upcoming_workout_row.dart';
import 'package:fitnessapp/view/activity/widgets/what_train_row.dart';
import 'package:fitnessapp/view/activity_tracker/widgets/latest_activity_row.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {


  List latestArrActive = [
    {
      "image": "assets/images/pic_4.png",
      "title": "Uống nước",
      "time": "Cập nhật 1 phút trước"
    },
    {
      "image": "assets/images/pic_5.png",
      "title": "Ăn nhẹ",
      "time": "Cập nhật 3 giờ trước"
    },
  ];
  List whatArr = [
    {
      "image": "assets/images/what_1.png",
      "title": "Fullbody Workout",
      "exercises": "11 Exercises",
      "time": "32mins"
    },
    {
      "image": "assets/images/what_2.png",
      "title": "Lowebody Workout",
      "exercises": "12 Exercises",
      "time": "40mins"
    },
    {
      "image": "assets/images/what_3.png",
      "title": "AB Workout",
      "exercises": "14 Exercises",
      "time": "20mins"
    }
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 60, bottom: 50),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.account_circle_sharp, color: Colors.grey),
                          SizedBox(width: 20,),
                          Text(
                            "Sức khỏe của tôi",
                            style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: media.width * 0.02,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(onPressed: (){},
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.only(top: 4, bottom: 4, left: 16,right: 16),
                                  backgroundColor: Colors.pink,
                                  foregroundColor: Colors.white
                              ),
                              child: Text('Sức khỏe', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700), )),
                          SizedBox(width: 8,),
                          ElevatedButton(onPressed: (){},
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.only(top: 4, bottom: 4, left: 16,right: 16),
                                  backgroundColor: Colors.grey,
                                  foregroundColor: Colors.white
                              ),
                              child: Text('Sống khỏe', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700), )),
                          SizedBox(width: 8,),
                          ElevatedButton(onPressed: (){},
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.only(top: 4, bottom: 4, left: 16,right: 16),
                                  backgroundColor: Colors.grey,
                                  foregroundColor: Colors.white
                              ),
                              child: Text('Chăm sóc', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700), )),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 140,
                  left: 0,
                  right: 0,
                  bottom: 0, // Để nó chiếm toàn bộ không gian còn lại
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                  
                        Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.grey, width: 0.05),
                  
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset('assets/images/weight_icon.png',
                                      width: media.width * 0.1,
                                      height: media.width * 0.1,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Cân nặng',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Spacer(),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: Size.zero,
                                          padding: EdgeInsets.only(top: 3, bottom: 3, left: 16,right: 16),
                                          backgroundColor: Colors.redAccent,
                                          foregroundColor: Colors.white
                                      ),
                                      child: Text('CHẬM TIẾN TRÌNH', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700), ),
                  
                                    ),
                  
                                    SizedBox(width: media.width * 0.03,),
                                    FaIcon(FontAwesomeIcons.chevronRight, size: 12,)
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 0.4,
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'HÔM QUA, 8:16',
                                      style: TextStyle(fontSize: 10 ,color: Colors.grey, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '37 NGÀY NỮA',
                                      style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                        text: TextSpan(
                                            style: TextStyle(color: Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(text: '87.1',
                                                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)
                                              ),
                                              TextSpan(text: 'kg',
                                                  style: TextStyle(fontSize: 10, color: Colors.grey)
                                              )
                                            ]
                                        )),
                  
                                    RichText(
                                        text: TextSpan(
                                            style: TextStyle(color: Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(text: '6.4',
                                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)
                                              ),
                                              TextSpan(text: ' kg cần giảm',
                                                  style: TextStyle(fontSize: 14, color: Colors.grey)
                                              )
                                            ]
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: media.width * 0.02,
                        ),
                        Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.grey, width: 0.05),
                  
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                  
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset('assets/images/blood_pressure_icon.png',
                                      width: media.width * 0.1,
                                      height: media.width * 0.1,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Huyết áp',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Spacer(),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: Size.zero,
                                          padding: EdgeInsets.only(top: 3, bottom: 3, left: 16,right: 16),
                                          backgroundColor: Colors.lightBlueAccent,
                                          foregroundColor: Colors.white
                                      ),
                                      child: Text('LÝ TƯỞNG', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700), ),
                                    ),
                                    SizedBox(width: media.width * 0.03,),
                                    FaIcon(FontAwesomeIcons.chevronRight, size: 12,)
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 0.4,
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '20 THÁNG 9 11:35',
                                      style: TextStyle(fontSize: 10 ,color: Colors.grey, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'TRUNG BÌNH 30 NGÀY',
                                      style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                        text: TextSpan(
                                            style: TextStyle(color: Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(text: '90 / 60',
                                                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)
                                              ),
                                              TextSpan(text: ' mmHg',
                                                  style: TextStyle(fontSize: 10, color: Colors.grey)
                                              )
                                            ]
                                        )),
                  
                                    RichText(
                                        text: TextSpan(
                                            style: TextStyle(color: Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(text: '90 / 60',
                                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)
                                              ),
                                              TextSpan(text: ' mmHg',
                                                  style: TextStyle(fontSize: 14, color: Colors.grey)
                                              )
                                            ]
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: media.width * 0.02,
                        ),
                        Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.grey, width: 0.05),
                          ),
                  
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                  
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset('assets/images/cholesterol_icon.png',
                                      width: media.width * 0.1,
                                      height: media.width * 0.1,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Mỡ trong máu',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Spacer(),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: Size.zero,
                                          padding: EdgeInsets.only(top: 3, bottom: 3, left: 16,right: 16),
                                          backgroundColor: Colors.green,
                                          foregroundColor: Colors.white
                                      ),
                                      child: Text('TRONG MỤC TIÊU', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700), ),
                                    ),
                                    SizedBox(width: media.width * 0.03,),
                                    FaIcon(FontAwesomeIcons.chevronRight, size: 12,)
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 0.4,
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'LDL-C - 17 THÁNG 9, 2024',
                                      style: TextStyle(fontSize: 10 ,color: Colors.grey, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'LẦN XÉT NGHIỆM TIẾP THEO',
                                      style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                        text: TextSpan(
                                            style: TextStyle(color: Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(text: '60',
                                                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)
                                              ),
                                              TextSpan(text: 'mg/dL',
                                                  style: TextStyle(fontSize: 10, color: Colors.grey)
                                              )
                                            ]
                                        )),
                  
                                    RichText(
                                        text: TextSpan(
                                            style: TextStyle(color: Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(text: '168',
                                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)
                                              ),
                                              TextSpan(text: ' ngày',
                                                  style: TextStyle(fontSize: 14, color: Colors.grey)
                                              )
                                            ]
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: media.width * 0.05,
                        ),
                  
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Số theo dõi",
                              style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Xem thêm",
                                style: TextStyle(
                                    color: AppColors.grayColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                        ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: latestArrActive.length,
                            itemBuilder: (context, index) {
                              var wObj = latestArrActive[index] as Map? ?? {};
                              return LatestActivityRow(wObj: wObj);
                            }),
                        SizedBox(
                          height: media.width * 0.1,
                        ),
                      ],
                    ),
                  ),
                ),
            ]
          ),

          )
    );
  }

  LineTouchData get lineTouchData1 => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
    ),
  );

  List<LineChartBarData> get lineBarsData1 => [
    lineChartBarData1_1,
    lineChartBarData1_2,
  ];

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
    isCurved: true,
    color: AppColors.whiteColor,
    barWidth: 4,
    isStrokeCapRound: true,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    spots: const [
      FlSpot(1, 35),
      FlSpot(2, 70),
      FlSpot(3, 40),
      FlSpot(4, 80),
      FlSpot(5, 25),
      FlSpot(6, 70),
      FlSpot(7, 35),
    ],
  );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
    isCurved: true,
    color: AppColors.whiteColor.withOpacity(0.5),
    barWidth: 2,
    isStrokeCapRound: true,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(
      show: false,
    ),
    spots: const [
      FlSpot(1, 80),
      FlSpot(2, 50),
      FlSpot(3, 90),
      FlSpot(4, 40),
      FlSpot(5, 80),
      FlSpot(6, 35),
      FlSpot(7, 60),
    ],
  );

  SideTitles get rightTitles => SideTitles(
    getTitlesWidget: rightTitleWidgets,
    showTitles: true,
    interval: 20,
    reservedSize: 40,
  );

  Widget rightTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0%';
        break;
      case 20:
        text = '20%';
        break;
      case 40:
        text = '40%';
        break;
      case 60:
        text = '60%';
        break;
      case 80:
        text = '80%';
        break;
      case 100:
        text = '100%';
        break;
      default:
        return Container();
    }

    return Text(text,
        style: TextStyle(
          color: AppColors.whiteColor,
          fontSize: 12,
        ),
        textAlign: TextAlign.center);
  }

  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: 32,
    interval: 1,
    getTitlesWidget: bottomTitleWidgets,
  );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(
      color: AppColors.whiteColor,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Text('Sun', style: style);
        break;
      case 2:
        text = Text('Mon', style: style);
        break;
      case 3:
        text = Text('Tue', style: style);
        break;
      case 4:
        text = Text('Wed', style: style);
        break;
      case 5:
        text = Text('Thu', style: style);
        break;
      case 6:
        text = Text('Fri', style: style);
        break;
      case 7:
        text = Text('Sat', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }
}
