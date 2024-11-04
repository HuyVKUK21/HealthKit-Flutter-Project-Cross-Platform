
import 'package:flutter/material.dart';

void showStatusMedicineDialog(BuildContext context, String medicineName, Function onConfirm) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: Text(
          'Ngưng thuốc $medicineName',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        content: Text(
          'Thuốc này sẽ chuyển sang trạng thái dừng',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.grey.shade300, width: 1)
                  ),
                ),
                child: Text('Hủy bỏ', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onConfirm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.red, width: 1)
                  ),
                ),
                child: Text('Ngưng thuốc', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          )
        ],
      );
    },
  );
}

void showMedicineDialog(BuildContext context, String medicineName, bool? usageStatus, String dosageTime, Function func) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 3,
        shadowColor: Colors.grey,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                radius: 36,
                child: Icon(Icons.more_horiz, size: 36, color: Colors.black),
              ),
              SizedBox(height: 16.0),
              Text(
                medicineName,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                usageStatus == true ?
                "Đã dùng 1 lần \nlúc ${dosageTime}" :
                "Đã bỏ qua 1 lần dùng\nlúc ${dosageTime}",
                style: TextStyle(fontSize: 24, color: usageStatus == true ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  func();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: BorderSide(color: Colors.black, width: 1.0)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                ),
                child: Icon(usageStatus == true ? Icons.data_usage_sharp : Icons.check),
              ),
              SizedBox(height: 24.0),
              Text(
                usageStatus == true ?
                "Đổi thành đã bỏ qua" :
                "Đổi thành đã uống",
                style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    },
  );
}
