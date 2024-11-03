import 'package:flutter/material.dart';

class GoalCard extends StatelessWidget {
  final String title;
  final int progress;
  final int goal;
  final String unit;

  const GoalCard({
    super.key,
    required this.title,
    required this.progress,
    required this.goal,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    double progressPercent = progress / goal;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            LinearProgressIndicator(value: progressPercent, backgroundColor: Colors.grey[300], color: Colors.red),
            SizedBox(height: 10),
            Text("$progress / $goal $unit", style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}
