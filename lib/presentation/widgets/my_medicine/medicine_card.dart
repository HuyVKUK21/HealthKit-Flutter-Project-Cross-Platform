import 'package:flutter/material.dart';

class MedicineCard extends StatelessWidget {
  final String medicineName;
  final String dosageTime;
  final int remainingDoses;
  final bool? offStatus;
  final bool? usageStatus;
  final String iconRight;
  final VoidCallback? onEditPressed;

  const MedicineCard({
    Key? key,
    required this.medicineName,
    required this.dosageTime,
    required this.remainingDoses,
    this.offStatus,
    this.usageStatus,
    required this.iconRight,
    this.onEditPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onEditPressed,
      child: Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: offStatus == false ? (usageStatus == true ? Colors.green : Colors.red) : Colors.grey, width: 1.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: CircleAvatar(
                backgroundColor: Colors.grey[200],
                radius: 24,
                child: Image.asset(
                  'assets/images/medicine_icon.png',
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medicineName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2.0),
                  Text(offStatus == false ?
                  (usageStatus == true ? "Đã uống vào lúc $dosageTime" : "Bỏ qua vào $dosageTime") :
                  "Chưa có nhắc nhở nào được đặt", style: TextStyle(fontSize: 14, color: Colors.grey)),
                  SizedBox(height: 2.0),
                  Text("$remainingDoses lần dùng còn lại", style: TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              child: iconRight == "check" ?
              (usageStatus == true ?
              Icon(Icons.check_circle, color: Colors.green,) :
              Icon(Icons.cancel, color: Colors.red,)) :
              Icon(Icons.chevron_right, color: Colors.grey,),
            ),

          ],
        ),

      ),
    );
  }
}
