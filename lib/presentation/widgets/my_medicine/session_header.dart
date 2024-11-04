import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final bool isExpanded;
  final VoidCallback onToggle;

  const SectionHeader({
    Key? key,
    required this.title,
    required this.isExpanded,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle, // Toggle section on tap
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[800]),
            ),
            Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }
}
