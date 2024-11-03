import 'package:flutter/material.dart';

class HealthMetricCard extends StatelessWidget {
  final String icon;
  final Color color;
  final String title;
  final String subtitle;
  final String points;
  final bool measure;
  final VoidCallback? onTap;

  HealthMetricCard({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.points,
    required this.measure,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Color(0xFFBCBCBC), width: 0.6),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Image.asset(
                    icon,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF118036),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 4,
                      shadowColor: Color(0xFF118036),
                    ),
                    child: Text(
                      measure ? "Đo ngay" : "Xem",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
