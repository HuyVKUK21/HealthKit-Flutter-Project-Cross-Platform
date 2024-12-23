import 'package:flutter/material.dart';

class SmokingPlan extends StatefulWidget {
  final String startDate;
  final String endDate;
  final int dailyCigarettes;
  final Function? onConfirm;

  SmokingPlan({
    required this.startDate,
    required this.endDate,
    required this.dailyCigarettes,
    this.onConfirm,
  });

  @override
  _SmokingPlanState createState() => _SmokingPlanState();
}

class _SmokingPlanState extends State<SmokingPlan> {
  String newDate = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Kế hoạch thuốc lá",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    TextEditingController dateController = TextEditingController();
                    showSmokingDialogWithDatePicker(
                      context,
                          (selectedDate) {
                        setState(() {
                          newDate = selectedDate;
                        });
                        if (widget.onConfirm != null) {
                          widget.onConfirm!(selectedDate);  // Gọi onConfirm nếu có
                        }
                      },
                      dateController,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey.shade700,
                    side: BorderSide(color: Colors.grey, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Chỉnh sửa",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                "CỘT MỐC + MỤC TIÊU",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.flag, size: 20),
                      SizedBox(width: 8),
                      Text(
                        "${widget.dailyCigarettes} điếu/ngày",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "trước ${widget.startDate}",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                // Second milestone: Quit completely by end date
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.health_and_safety, size: 20, color: Colors.blue.shade900),
                    SizedBox(width: 8),
                    Text(
                      "0 điếu/ngày",
                      style: TextStyle(
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "trước ${newDate.isNotEmpty ? newDate : widget.endDate}",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

void showSmokingDialogWithDatePicker(BuildContext context, Function(String) onConfirm, TextEditingController dateController) {
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
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                radius: 36,
                child: Icon(Icons.calendar_today, size: 36, color: Colors.black),
              ),
              SizedBox(height: 16.0),
              Center(
                child: Text(
                  "Cập nhật kế hoạch hút thuốc",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 24.0),
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                  labelText: "Chọn ngày hoàn thành kế hoạch",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  suffixIcon: Icon(Icons.date_range),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    dateController.text = "${pickedDate.day} thg ${pickedDate.month}, ${pickedDate.year}";
                  }
                },
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  onConfirm(dateController.text); // Truyền ngày đã chọn về onConfirm
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                ),
                child: Text("Xác nhận", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      );
    },
  );
}
