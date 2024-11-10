import 'package:fitnessapp/data/models/meansure_foot_step.dart';
import 'package:fitnessapp/presentation/screens/foot_step/day_foot_step.dart';
import 'package:flutter/material.dart';

class WeekFootStep extends StatelessWidget {
  const WeekFootStep({super.key, required this.stepOfWeek});
  final List<StepOfDay> stepOfWeek;
  @override
  Widget build(BuildContext context) {
    final steps = [];
    int max = 0;
    int total = 0;
    for (StepOfDay st in stepOfWeek) {
      if (max < st.step) {
        max = st.step;
      }
      total += st.step;
      steps.add(st.step);
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'TỔNG HÀNG TUẦN',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              '$total bước',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Text(
              '${stepOfWeek.first.date.substring(0, 2).contains('/') ? stepOfWeek.first.date.substring(0, 1) : stepOfWeek.first.date.substring(0, 2)} - ${stepOfWeek.last.date.substring(0, 2).contains('/') ? stepOfWeek.last.date.substring(0, 1) : stepOfWeek.last.date.substring(0, 2)}  thg 11',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200], // Thay cho `primary`
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {},
              child: Text('Trung bình 1,816'),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(7, (index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 16,
                      height: steps[index] != 0
                          ? steps[index] * 18 / 10
                          : max * 18 / 10,
                      // Điều chỉnh chiều cao dựa vào số bước
                      decoration: BoxDecoration(
                        color: steps[index] > 0
                            ? Colors.blue.withOpacity(0.5)
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'][index],
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      steps[index] == 0 ? '-' : '${steps[index]}',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                );
              }),
            ),
            SizedBox(
              height: 70.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(
                  icon: Icons.directions_walk,
                  value: '$total',
                  unit: 'bước',
                ),
                InfoCard(
                  icon: Icons.local_fire_department,
                  value:
                      (65 * ((total * 0.75) / 1000) * 0.57).toStringAsFixed(2),
                  unit: 'kcal',
                ),
                InfoCard(
                  icon: Icons.arrow_forward,
                  value: ((total * 0.75) / 1000).toStringAsFixed(2),
                  unit: 'km',
                ),
                InfoCard(
                  icon: Icons.access_time,
                  value:
                      ((((total * 0.75) / 1000) / 5) * 60).toStringAsFixed(1),
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
