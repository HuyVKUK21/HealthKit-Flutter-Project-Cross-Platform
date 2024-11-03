import 'package:flutter/material.dart';

class GreetWithTemperature extends StatelessWidget {
  final String greetingMessage;
  final String welcomeMessage;
  final double temperature;

  const GreetWithTemperature({
    Key? key,
    required this.greetingMessage,
    required this.welcomeMessage,
    required this.temperature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              greetingMessage,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            Text(
              welcomeMessage,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Icon(Icons.wb_sunny, color: Colors.orange),
            SizedBox(width: 5),
            Text(
              '${temperature.toStringAsFixed(0)}°C',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
