import 'package:fitnessapp/presentation/bloc/weight/weight_bloc.dart';
import 'package:fitnessapp/presentation/events/weight/weight_event.dart';
import 'package:fitnessapp/presentation/screens/weight/weight_screen.dart';
import 'package:fitnessapp/utils/global/user.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeightMeasureScreen extends StatefulWidget {
  static String routeName = "/HeightMeasureScreen";
  @override
  _HeightMeasureScreenState createState() => _HeightMeasureScreenState();
}

class _HeightMeasureScreenState extends State<HeightMeasureScreen> {
  double height = 91.0;
  String currentDate = '';

  final List<String> months = [
    'Tháng 1',
    'Tháng 2',
    'Tháng 3',
    'Tháng 4',
    'Tháng 5',
    'Tháng 6',
    'Tháng 7',
    'Tháng 8',
    'Tháng 9',
    'Tháng 10',
    'Tháng 11',
    'Tháng 12',
  ];

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    currentDate = '${now.day} ${months[now.month - 1]}, ${now.year}';
  }


  @override
  Widget build(BuildContext context) {
    final weight = ModalRoute.of(context)!.settings.arguments as double;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Text(
              'Chiều cao',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_today_outlined, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'Hôm nay, $currentDate',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove_circle, color: Colors.red, size: 30),
                  onPressed: () {
                    setState(() {
                      if (height > 0) height -= 0.1;
                    });
                  },
                ),
                Text(
                  height.toStringAsFixed(1),
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle, color: Colors.green, size: 30),
                  onPressed: () {
                    setState(() {
                      height += 0.1;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ToggleButtons(
              borderColor: Colors.transparent,
              selectedColor: Colors.pink,
              fillColor: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              isSelected: [true],
              onPressed: (int index) {},
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('cm', style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
              ],
            ),
            SizedBox(height: 30),
            Slider(
              value: height,
              min: 40,
              max: 210,
              divisions: 110,
              activeColor: Colors.green,
              inactiveColor: Colors.grey[300],
              label: height.toStringAsFixed(1),
              onChanged: (double value) {
                setState(() {
                  height = value;
                });
              },
            ),
            Spacer(),
            TextButton.icon(
              onPressed: () {
                // Open help screen
              },
              icon: Icon(Icons.chat_bubble_outline, color: Colors.black54),
              label: Text(
                'Đo chiều cao như thế nào?',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                context.read<WeightBloc>().add(SaveWeightHeightData(weight, height));
                Navigator.pushNamed(
                  context,
                  WeightScreen.routeName
                );
              },
              child: Text(
                'Tiếp tục',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
