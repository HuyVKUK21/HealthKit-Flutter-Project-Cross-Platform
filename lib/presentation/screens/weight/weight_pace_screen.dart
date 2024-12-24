import 'package:fitnessapp/presentation/screens/weight/weight_frequency_screen.dart';
import 'package:flutter/material.dart';

class WeightPaceScreen extends StatefulWidget {
  static String routeName = "/WeightPaceScreen";
  @override
  _PaceScreenState createState() => _PaceScreenState();
}

class _PaceScreenState extends State<WeightPaceScreen> {
  String selectedPace = 'Dễ';
  late double weightGoal;
  @override
  Widget build(BuildContext context) {
    weightGoal = ModalRoute.of(context)!.settings.arguments as double;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 40),
              Text(
                'Nhịp độ của bạn',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'Bạn muốn tăng cân bao nhiêu mỗi tuần?',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              _buildPaceOption('Dễ', '+0.25 kg / tuần'),
              _buildPaceOption('Vừa', '+0.50 kg / tuần'),
              _buildPaceOption('Khó', '+0.75 kg / tuần'),
              _buildPaceOption('Tối đa', '+1.00 kg / tuần'),
              Spacer(),
              _buildNavigationButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Text(
            'Đóng',
            style: TextStyle(color: Colors.grey),
          ),
        ),

      ],
    );
  }

  Widget _buildPaceOption(String title, String subtitle) {
    return GestureDetector(
      onTap: () => setState(() => selectedPace = title),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selectedPace == title ? Colors.blue.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Spacer(),
            Text(subtitle, style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          margin: EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(25),
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                WeightFrequencyScreen.routeName,
                arguments: {
                  'weightGoal': weightGoal,
                  'paceGoal': selectedPace,
                },
              );
            },
            child: Text('Chọn kế hoạch', style: TextStyle(color: Colors.white),),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),
      ],
    );
  }
}