import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessapp/data/models/meansure_foot_step.dart';
import 'package:fitnessapp/data/repositories/foot_step/foot_step_repository_impl.dart';
import 'package:fitnessapp/domain/usecases/foot_step/foot_step_usecase.dart';
import 'package:fitnessapp/presentation/screens/foot_step/day_foot_step.dart';
import 'package:fitnessapp/presentation/screens/foot_step/modal_setting_aim.dart';
import 'package:fitnessapp/presentation/screens/foot_step/week_foot_step.dart';
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
  String _km = "0";
  String _calories = "0";
  String _time = "0";
  String screen = "day";

  late FootStepUsecase _footStepUsecase;
  late FootStepModel _footStepData;
  late StepOfDay _stepOfToday = StepOfDay(date: '00/00/2000', step: 0);
  late List<StepOfDay> _stepOfCurrentWeek = [];

  @override
  void initState() {
    super.initState();

    _footStepData = FootStepModel(
      userId: 'user_id_123',
      aim: 500,
      stepOfDay: [],
    );

    _checkActivityRecognitionPermission();
    _footStepUsecase = FootStepUsecase(FootStepRepositoryImpl());
    fetchFootStepByUserId();
    fetchStepOfCurrentWeek();
  }

  void switchScreen(String screenName) {
    setState(() {
      screen = screenName;
    });
  }

  Future<void> fetchStepOfCurrentWeek() async {
    List<StepOfDay> stepCurrentWeek = await _footStepUsecase
        .getStepInTheWeekByUser(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      _stepOfCurrentWeek = stepCurrentWeek;
    });
  }

  Future<void> fetchFootStepByUserId() async {
    try {
      FootStepModel? model = await _footStepUsecase
          .getFootStepByIdUser(FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        _footStepData = model!;
        Result result = _footStepData.findStepOfToday();
        _stepOfToday = result.stepOfDay;
        _km = ((_stepOfToday.step * 0.75) / 1000).toStringAsFixed(2);
        _calories = (65 * ((_stepOfToday.step * 0.75) / 1000) * 0.57)
            .toStringAsFixed(2);
        _time =
            ((((_stepOfToday.step * 0.75) / 1000) / 5) * 60).toStringAsFixed(1);
        if (!result.exists) {
          StepOfDay newStepOfDay = result.stepOfDay;

          _footStepData = FootStepModel(
            userId: _footStepData.userId,
            aim: _footStepData.aim,
            stepOfDay: [..._footStepData.stepOfDay, newStepOfDay],
          );
          List<Map<String, dynamic>> stepOfDayMaps = _footStepData.stepOfDay
              .map((step) => {
                    'date': step.date,
                    'step': step.step,
                  })
              .toList();

          _footStepUsecase.updateFootStepByIdUser(
            FirebaseAuth.instance.currentUser!.uid,
            stepOfDayMaps,
          );
        }
      });
    } catch (e) {
      print('Error fetching foot step');
    }
  }

  Future<void> updateAim(int aim) async {
    _footStepUsecase.updateAimByIdUser(
        FirebaseAuth.instance.currentUser!.uid, aim);
    setState(() {
      _footStepData = _footStepData.copyWith(newAim: aim);
    });
    Navigator.pop(context);
  }

  Future<void> updateWhenStopWalk() async {
    StepOfDay _stepUpdate =
        await _footStepUsecase.updateStepOfDayWhenStopByIdUser(
            FirebaseAuth.instance.currentUser!.uid, _stepOfToday);
    setState(() {
      _stepOfToday = StepOfDay(date: _stepUpdate.date, step: _stepUpdate.step);
    });
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
    updateWhenStopWalk();
  }

  void onStepCount(StepCount event) {
    if (!_isTracking) return;
    setState(() {
      _steps = event.steps.toString();
      int step = _stepOfToday.getStep() + int.parse(_steps);
      _stepOfToday = _stepOfToday.copyWith(step: step);
      _km = ((_stepOfToday.step * 0.75) / 1000).toStringAsFixed(2);
      _calories =
          (65 * ((_stepOfToday.step * 0.75) / 1000) * 0.57).toStringAsFixed(2);
      _time =
          ((((_stepOfToday.step * 0.75) / 1000) / 5) * 60).toStringAsFixed(1);
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
        context: context,
        builder: (ctx) => ModalSettingAimWidget(
              updateAim: updateAim,
            ));
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
                  child: ToggleButtons(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'NGÀY',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'TUẦN',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                    isSelected: [screen == 'day', screen == 'week'],
                    onPressed: (int index) {
                      setState(() {
                        screen = index == 0 ? 'day' : 'week';
                      });
                    },
                    borderRadius: BorderRadius.circular(20),
                    selectedColor: Colors.white,
                    fillColor: Colors.blueAccent,
                    borderColor: Colors.blueAccent,
                    splashColor: Colors.blue.withOpacity(0.3),
                    highlightColor: Colors.blue.withOpacity(0.2),
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            screen == 'day'
                ? DayFootStep(
                    stopListening: stopListening,
                    startListening: startListening,
                    isTracking: _isTracking,
                    km: _km,
                    calories: _calories,
                    time: _time,
                    footStepData: _footStepData,
                    steps: _steps,
                    stepOfToday: _stepOfToday)
                : WeekFootStep(
                    stepOfWeek: _stepOfCurrentWeek,
                  )
          ],
        ),
      ),
    );
  }
}
