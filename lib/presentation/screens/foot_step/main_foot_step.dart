import 'dart:async';
import 'package:fitnessapp/presentation/screens/foot_step/modal_setting_aim.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pedometer/pedometer.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';

class MainFootStepScreen extends StatefulWidget {
  const MainFootStepScreen({super.key});
  static String routeName = '/MainFootStepScreen';
  @override
  State<StatefulWidget> createState() {
    return _MainFootStepScreen();
  }
}

class _MainFootStepScreen extends State<MainFootStepScreen> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';
  bool _isTracking = false;

  @override
  void initState() {
    super.initState();
    _checkActivityRecognitionPermission();
  }

  void startListening() {
    if (_isTracking) return;
    setState(() => _isTracking = true);

    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

  void stopListening() {
    setState(() {
      _isTracking = false;
      _steps = '?';
    });
  }

  void onStepCount(StepCount event) {
    if (!_isTracking) return;
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  Future<bool> _checkActivityRecognitionPermission() async {
    bool granted = await Permission.activityRecognition.isGranted;
    if (!granted) {
      granted = await Permission.activityRecognition.request() ==
          PermissionStatus.granted;
    }
    return granted;
  }

  Future<void> initPlatformState() async {
    bool granted = await _checkActivityRecognitionPermission();
    if (!granted) {
      // tell user, the app will not work
    }

    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    (await _pedestrianStatusStream.listen(onPedestrianStatusChanged))
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  void _openSettingAimOverlay() {
    showModalBottomSheet(
        context: context, builder: (ctx) => const ModalSettingAimWidget());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bước chân',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _openSettingAimOverlay,
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Center(
              child: FittedBox(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: const Color(0xFFD4DFEE),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              side: BorderSide.none),
                          child: Text(
                            'NGÀY',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD4DFEE),
                            side: BorderSide.none),
                        child: Text(
                          'TUẦN',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD4DFEE),
                              side: BorderSide.none),
                          child: Text(
                            'THÁNG',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD4DFEE),
                              side: BorderSide.none),
                          child: Text(
                            'NĂM',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isTracking ? stopListening : startListening,
              child: Text(
                _isTracking ? 'Stop' : 'Start',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              height: 40,
            ),
            CircularPercentIndicator(
              radius: 170.0,
              lineWidth: 15.0,
              percent: 0.7,
              animation: true,
              center: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.personWalking,
                          size: 30.0,
                          color: Colors.black,
                        ),
                        Text(
                          _steps,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 35),
                        ),
                        const Text(
                          'Mục tiêu: 30/500 bước',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        )
                      ])
                ],
              ),
              progressColor: Colors.green,
            ),
            SizedBox(
              height: 70.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(
                  icon: Icons.directions_walk,
                  value: '1,721',
                  unit: 'bước',
                ),
                InfoCard(
                  icon: Icons.local_fire_department,
                  value: '42.8',
                  unit: 'kcal',
                ),
                InfoCard(
                  icon: Icons.arrow_forward,
                  value: '1.36',
                  unit: 'km',
                ),
                InfoCard(
                  icon: Icons.access_time,
                  value: '16',
                  unit: 'phút',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String unit;

  InfoCard({required this.icon, required this.value, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
        border: Border.all(color: Colors.blue.shade100, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.black),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            unit,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
