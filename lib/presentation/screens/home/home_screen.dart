import 'package:fitnessapp/presentation/bloc/weight/weight_bloc.dart';
import 'package:fitnessapp/presentation/events/weight/weight_event.dart';
import 'package:fitnessapp/presentation/screens/bloodsugar/bloodsugar_screen.dart';
import 'package:fitnessapp/presentation/screens/bloodsure/bloodsure_screen.dart';
import 'package:fitnessapp/presentation/screens/foot_step/main_foot_step.dart';
import 'package:fitnessapp/presentation/screens/weight/weight_measure_screen.dart';
import 'package:fitnessapp/presentation/screens/weight/weight_screen.dart';
import 'package:fitnessapp/presentation/state/weight/weight_state.dart';
import 'package:fitnessapp/presentation/widgets/appbar/custom_app_bar.dart';
import 'package:fitnessapp/presentation/widgets/home/activity_reminder_card.dart';
import 'package:fitnessapp/presentation/widgets/home/goal_card.dart';
import 'package:fitnessapp/presentation/widgets/home/greet_with_temperature.dart';
import 'package:fitnessapp/presentation/widgets/home/health_metric_card.dart';
import 'package:fitnessapp/utils/global/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/page_route_builder.dart';
import '../my_medicine/my_medicine_screen.dart';
import '../quit_smoking/smoking_screen.dart';
//hello

class HomeScreen extends StatefulWidget {
  static String routeName = "/HomeScreen";

  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String userId = "";
  String? _targetScreen;

  @override
  void initState() {
    super.initState();
    _getUserId();

  }

  Future<void> _getUserId() async {
    userId = (await GlobalUtil.getUserId())!;

  }

  @override
  Widget build(BuildContext context) {
    context.read<WeightBloc>().add(LoadWeightData(userId));
    return BlocListener<WeightBloc, WeightState>(
      listener: (context, state) {
        if (state is WeightLoaded) {
          _targetScreen = WeightScreen.routeName;
        } else if (state is WeightError) {
          _targetScreen = WeightMeasureScreen.routeName;
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                GreetWithTemperature(
                  greetingMessage: "Xin chào, Huy!",
                  welcomeMessage: "Chào mừng bạn đến với HealthKit",
                  temperature: 21,
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, size: 14),
                    hintText: "Tìm kiếm hoạt động....",
                    hintStyle: TextStyle(fontSize: 14),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      Text(
                        "Hoạt động sức khỏe",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      HealthMetricCard(
                        icon: 'assets/images/foot_step_icon.png',
                        color: Colors.green,
                        title: "Bước đi",
                        subtitle: "180 bước • Hôm nay",
                        points: "56",
                        measure: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            RouteHelper.createFadeRoute(MainFootStepScreen()),
                          );
                        },
                      ),
                      HealthMetricCard(
                        icon: 'assets/images/heart-rate-icon.png',
                        color: Colors.red,
                        title: "Nhịp tim",
                        subtitle: "78 bpm • Hôm nay",
                        points: "56",
                        measure: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            RouteHelper.createFadeRoute(BloodsureScreen()),
                          );
                        },
                      ),
                      HealthMetricCard(
                        icon: 'assets/images/home-weight.png',
                        color: Colors.blue,
                        title: "Cân nặng",
                        subtitle: "68 kg • Hôm qua",
                        points: "114",
                        measure: true,
                        onTap: () {
                          print("dạng" + _targetScreen.toString());
                          if (_targetScreen != null) {
                            Navigator.pushNamed(context, _targetScreen!);
                          }
                        },
                      ),
                      HealthMetricCard(
                        icon: 'assets/images/blood_sugar_icon.png',
                        color: Colors.orange,
                        title: "Đường huyết",
                        subtitle: "98.4 mg/DL • Hôm nay",
                        points: "168",
                        measure: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            RouteHelper.createFadeRoute(BloodSugarScreen()),
                          );
                        },
                      ),
                      HealthMetricCard(
                        icon: 'assets/images/medicine_icon.png',
                        color: Colors.grey,
                        title: "Thuốc của tôi",
                        subtitle: "Hôm nay",
                        points: "0",
                        measure: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            RouteHelper.createFadeRoute(MyMedicineScreen()),
                          );
                        },
                      ),
                      HealthMetricCard(
                        icon: 'assets/icons/no-smoking.png',
                        color: Colors.grey,
                        title: "Bỏ thuốc lá",
                        subtitle: "Hôm nay",
                        points: "0",
                        measure: false,
                        onTap: () => {
                          Navigator.pushReplacement(
                            context,
                            RouteHelper.createFadeRoute(QuitSmokingPage()),
                          )
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Mục tiêu sức khỏe",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      GoalCard(
                        title: "Bước đi hôm nay",
                        progress: 3500,
                        goal: 10000,
                        unit: "bước",
                      ),
                      GoalCard(
                        title: "Calo tiêu thụ",
                        progress: 400,
                        goal: 2000,
                        unit: "kcal",
                      ),
                      GoalCard(
                        title: "Thời gian tập luyện",
                        progress: 30,
                        goal: 60,
                        unit: "phút",
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Tin tức và Mẹo sức khỏe",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      ActivityReminderCard(
                        title: "Tập thể dục đều đặn",
                        imageUrl: "https://images.pexels.com/photos/4050293/pexels-photo-4050293.jpeg",
                        description: "Thể dục mỗi ngày giúp tăng cường sức khỏe và duy trì cân nặng lý tưởng.",
                      ),
                      SizedBox(height: 10),
                      ActivityReminderCard(
                        title: "Uống nước đủ mỗi ngày",
                        imageUrl: "https://images.pexels.com/photos/5934516/pexels-photo-5934516.jpeg",
                        description: "Uống ít nhất 8 ly nước mỗi ngày để cơ thể luôn giữ được độ ẩm và sức sống.",
                      ),
                      SizedBox(height: 10),
                      ActivityReminderCard(
                        title: "Thời gian ngủ đủ giấc",
                        imageUrl: "https://images.pexels.com/photos/3754490/pexels-photo-3754490.jpeg",
                        description: "Ngủ ít nhất 7-8 tiếng mỗi đêm để cơ thể được nghỉ ngơi và phục hồi.",
                      ),
                      SizedBox(height: 10),
                      ActivityReminderCard(
                        title: "Bổ sung dinh dưỡng lành mạnh",
                        imageUrl: "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg",
                        description: "Ăn uống đủ chất, bao gồm các loại rau quả và thực phẩm có lợi cho sức khỏe.",
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

