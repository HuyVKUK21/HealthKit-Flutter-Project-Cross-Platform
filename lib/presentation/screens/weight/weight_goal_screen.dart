import 'package:fitnessapp/presentation/screens/weight/weight_pace_screen.dart';
import 'package:flutter/material.dart';

class WeightGoalScreen extends StatefulWidget {
  @override
  _WeightGoalScreenState createState() => _WeightGoalScreenState();
}

class _WeightGoalScreenState extends State<WeightGoalScreen> {
  String selectedUnit = 'kg';
  double weightInKg = 0;
  TextEditingController weightController = TextEditingController();

  @override
  void dispose() {
    weightController.dispose();
    super.dispose();
  }

  void _onUnitChanged(String newUnit) {
    double weight = double.tryParse(weightController.text) ?? 0;

    if (selectedUnit == 'kg') {
      weightInKg = weight;
    } else if (selectedUnit == 'lbs') {
      weightInKg = weight / 2.20462;
    } else if (selectedUnit == 'st') {
      weightInKg = weight / 0.157473;
    }

    setState(() {
      selectedUnit = newUnit;

      if (newUnit == 'kg') {
        weightController.text = weightInKg.toStringAsFixed(1);
      } else if (newUnit == 'lbs') {
        weightController.text = (weightInKg * 2.20462).toStringAsFixed(1);
      } else if (newUnit == 'st') {
        weightController.text = (weightInKg * 0.157473).toStringAsFixed(1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 40),
              Text(
                'Cân nặng mục tiêu',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                'Chọn cân nặng mục tiêu phù hợp với bạn',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 60),
              Image.asset(
                'assets/images/doctor_image.png',
                height: 150,
                width: 150,
              ),
              const SizedBox(height: 40),
              _buildWeightSelector(),
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

  Widget _buildWeightSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 100,
          child: TextField(
            controller: weightController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '0',
            ),
          ),
        ),
        const SizedBox(width: 20),
        SegmentedButton(
          segments: [
            ButtonSegment(value: 'kg', label: Text('kg')),
            ButtonSegment(value: 'lbs', label: Text('lbs')),
            ButtonSegment(value: 'st', label: Text('st')),
          ],
          selected: {selectedUnit},
          onSelectionChanged: (Set<String> value) {
            _onUnitChanged(value.first);
          },
        ),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    return ElevatedButton(
      onPressed: () {
        double? weight = double.tryParse(weightController.text);
        if (weight != null && weight > 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => WeightPaceScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Vui lòng nhập cân nặng hợp lệ')),
          );
        }
      },
      child: Text('Lưu', style: TextStyle(color: Colors.white),),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
