import 'package:fitnessapp/presentation/bloc/bloodsugar/bloodsugar_bloc.dart';
import 'package:fitnessapp/presentation/events/bloodsugar/bloodsugar_event.dart';
import 'package:fitnessapp/presentation/screens/bloodsugar/bloodsugar_screen.dart';
import 'package:fitnessapp/presentation/state/bloodsugar/bloodsugar_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BloodSugarMeasureScreen extends StatefulWidget {
  static String routeName = "/BloodSugarMeasureScreen";
  @override
  _BloodSugarMeasureScreenState createState() => _BloodSugarMeasureScreenState();
}

class _BloodSugarMeasureScreenState extends State<BloodSugarMeasureScreen> {
  double bloodSugarValue = 95.4;
  bool isMgDl = true;
  int selectedMealState = 0;
  String mealDescription = "8 giờ hoặc hơn kể từ sau bữa ăn gần nhất";

  String getCurrentDateTime() {
    final now = DateTime.now();
    final formatter = DateFormat(" d 'tháng' M HH:mm");
    return "Hôm nay," + formatter.format(now);
  }

  // Function to get the text representation of the meal state
  String getMealStateText() {
    switch (selectedMealState) {
      case 0:
        return "Nhịn ăn";
      case 1:
        return "Sau ăn";
      case 2:
        return "Trước ăn";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BloodsugarBloc, BloodsugarState>(
      listener: (context, state) {
        if (state is BloodsugarUpdated) {
          Navigator.pushReplacementNamed(
            context,
            BloodSugarScreen.routeName,
          );
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFFF4F5F9),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.close, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Text(
              "Đường huyết",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                  SizedBox(width: 8),
                  Text(
                    getCurrentDateTime(),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 60),
            Text(
              bloodSugarValue.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMgDl = true;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isMgDl ? Colors.grey[300] : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "mg/dL",
                      style: TextStyle(
                        fontSize: 16,
                        color: isMgDl ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 30),
            SliderTheme(
              data: SliderThemeData(
                activeTrackColor: Colors.pink,
                inactiveTrackColor: Colors.grey[300],
                thumbColor: Colors.pinkAccent,
                overlayColor: Colors.pink.withOpacity(0.2),
                valueIndicatorColor: Colors.pinkAccent,
                valueIndicatorTextStyle: TextStyle(color: Colors.white),
                trackHeight: 8,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15),
                trackShape: RoundedRectSliderTrackShape(),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 30),
              ),
              child: Slider(
                value: bloodSugarValue,
                min: 0.0,
                max: 899.5,
                divisions: 8995,
                label: bloodSugarValue.toStringAsFixed(1),
                onChanged: (value) {
                  setState(() {
                    bloodSugarValue = value;
                  });
                },
              ),
            ),
            Text(
              "Đường huyết đơn vị mg/dL (36~899)",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 85),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMealButton("Nhịn ăn", 0, "8 giờ hoặc hơn kể từ sau bữa ăn gần nhất", Colors.pink),
                SizedBox(width: 10),
                _buildMealButton("Sau ăn", 1, "2 giờ sau khi ăn", Colors.purple.shade100),
                SizedBox(width: 10),
                _buildMealButton("Trước ăn", 2, "Bất cứ khi nào", Colors.grey),
              ],
            ),
            SizedBox(height: 8),
            Text(
              mealDescription,
              style: TextStyle(
                fontSize: 14,
                color: selectedMealState == 0
                    ? Colors.pink
                    : selectedMealState == 1
                    ? Colors.purple.shade200
                    : Colors.grey,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  context.read<BloodsugarBloc>().add(
                    SaveBloodsugarData(
                      index: bloodSugarValue,
                      status: getMealStateText(), // Using the meal state text
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Tiếp tục",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMealButton(String text, int index, String description, Color color) {
    bool isSelected = selectedMealState == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMealState = index;
          mealDescription = description;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
