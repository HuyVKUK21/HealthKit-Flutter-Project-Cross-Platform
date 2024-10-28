import 'package:flutter/material.dart';

class ActivityHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.account_circle_sharp, color: Colors.grey),
        SizedBox(width: 20),
        Text(
          "Sức khỏe của tôi",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
