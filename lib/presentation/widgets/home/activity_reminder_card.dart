import 'package:flutter/material.dart';

class ActivityReminderCard extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color backgroundColor;

  const ActivityReminderCard({
    super.key,
    required this.message,
    required this.icon,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(message, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
