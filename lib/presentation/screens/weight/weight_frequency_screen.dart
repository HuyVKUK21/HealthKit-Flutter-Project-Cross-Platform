import 'package:fitnessapp/presentation/bloc/weight/weight_bloc.dart';
import 'package:fitnessapp/presentation/events/weight/weight_event.dart';
import 'package:fitnessapp/presentation/screens/weight/weight_screen.dart';
import 'package:fitnessapp/presentation/state/weight/weight_state.dart';
import 'package:fitnessapp/utils/page_route_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeightFrequencyScreen extends StatefulWidget {
  static String routeName = "/WeightFrequencyScreen";
  @override
  _FrequencyScreenState createState() => _FrequencyScreenState();
}

class _FrequencyScreenState extends State<WeightFrequencyScreen> {
  int weightsPerWeek = 3;
  String selectedTimeUnit = 'tuần';
  late double weightGoal;
  String paceGoal = "";
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    weightGoal = args['weightGoal'] as double;
    paceGoal = args['paceGoal'] as String;
    return BlocListener<WeightBloc, WeightState>(
        listener: (context, state) {
      if (state is WeightUpdated) {
        Navigator.pushReplacementNamed(
          context,
          WeightScreen.routeName,
        );
      }
    },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 40),
                Image.asset(
                  'assets/images/doctor_image.png',
                  height: 150,
                  width: 150,
                ),
                const SizedBox(height: 20),
                Text(
                  'Cân nặng',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Bạn thường đo cân nặng bao lâu một lần?',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                _buildFrequencySelector(),
                Text(
                  'lần mỗi',
                  style: TextStyle(color: Colors.grey),
                ),
                _buildTimeUnitSelector(),
                Text(
                  'Tối thiểu theo tình hình sức khoẻ của bạn',
                  style: TextStyle(color: Colors.grey),
                ),
                Spacer(),
                _buildNavigationButtons(),
              ],
            ),
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

  Widget _buildFrequencySelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.remove_circle_outline),
          onPressed: () {
            if (weightsPerWeek > 1) {
              setState(() => weightsPerWeek--);
            }
          },
        ),
        const SizedBox(width: 20),
        Text(
          weightsPerWeek.toString(),
          style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 20),
        IconButton(
          icon: Icon(Icons.add_circle_outline),
          onPressed: () {
            if (weightsPerWeek < 7) {
              setState(() => weightsPerWeek++);
            }
          },
        ),
      ],
    );
  }

  Widget _buildTimeUnitSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTimeUnitButton('tuần'),
        _buildTimeUnitButton('tháng'),
      ],
    );
  }

  Widget _buildTimeUnitButton(String text) {
    final bool isSelected = selectedTimeUnit == text;
    return GestureDetector(
      onTap: () => setState(() => selectedTimeUnit = text),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
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
              context.read<WeightBloc>().add(SaveWeightGoalData(weightGoal, paceGoal, weightsPerWeek, selectedTimeUnit));
            },
            child: Text('Lưu', style: TextStyle(color: Colors.white),),
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