import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ActivityCard extends StatelessWidget {

  final String imagePath;
  final String title;
  final String statusText;
  final Color statusColor;
  final String lastUpdated;
  final String daysRemaining;
  final String mainValue;
  final String mainUnit;
  final String secondaryValue;
  final String secondaryUnit;

  const ActivityCard({
    required this.imagePath,
    required this.title,
    required this.statusText,
    required this.statusColor,
    required this.lastUpdated,
    required this.daysRemaining,
    required this.mainValue,
    required this.mainUnit,
    required this.secondaryValue,
    required this.secondaryUnit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int daysRemainingWeight;
    daysRemainingWeight = 1;
    final media = MediaQuery.of(context).size;

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey, width: 0.05),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(imagePath, width: media.width * 0.1, height: media.width * 0.1),
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 16),
                    backgroundColor: statusColor,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(width: media.width * 0.03),
                FaIcon(FontAwesomeIcons.chevronRight, size: 12),
              ],
            ),
            Divider(color: Colors.grey, thickness: 0.4),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  lastUpdated,
                  style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                Text(
                  daysRemaining,
                  style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(text: mainValue, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                      TextSpan(text: mainUnit, style: TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(text: secondaryValue, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
                      TextSpan(text: secondaryUnit, style: TextStyle(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
