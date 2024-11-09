import 'package:flutter/material.dart';

class WeekFootStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Danh sách số bước tương ứng với mỗi ngày
    final steps = [2058, 1496, 1895, 0, 0, 0, 0];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'TỔNG HÀNG TUẦN',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              '5,449 bước',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Text(
              '4 - 10 thg 11',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200], // Thay cho `primary`
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {},
              child: Text('Trung bình 1,816'),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(7, (index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 16,
                      height: steps[index] /
                          1000 *
                          50, // Điều chỉnh chiều cao dựa vào số bước
                      decoration: BoxDecoration(
                        color: steps[index] > 0
                            ? Colors.blue.withOpacity(0.5)
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'][index],
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      steps[index] == 0 ? '-' : '${steps[index]}',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
