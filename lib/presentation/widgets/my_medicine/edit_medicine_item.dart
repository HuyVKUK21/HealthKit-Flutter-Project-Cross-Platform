import 'package:flutter/material.dart';

class EditMedicineItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const EditMedicineItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 28),
      title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: TextStyle(fontSize: 16, color: Colors.grey)),
          SizedBox(width: 8),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
      onTap: () {},
    );
  }
}
