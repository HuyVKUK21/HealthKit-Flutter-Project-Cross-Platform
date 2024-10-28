import 'package:flutter/material.dart';

class ActivityButtonGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildButton('Sức khỏe', Colors.pink),
        _buildButton('Sống khỏe', Colors.grey),
        _buildButton('Chăm sóc', Colors.grey),
      ],
    );
  }

  Widget _buildButton(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          minimumSize: Size.zero,
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        ),
        child: Text(text, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
      ),
    );
  }
}
