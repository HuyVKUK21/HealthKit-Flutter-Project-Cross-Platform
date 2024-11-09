import 'package:fitnessapp/data/models/meansure_foot_step.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DayFootStep extends StatefulWidget {
  const DayFootStep(
      {super.key,
      required this.stopListening,
      required this.startListening,
      required this.isTracking,
      required this.km,
      required this.calories,
      required this.time,
      required this.footStepData,
      required this.steps,
      required this.stepOfToday});
  final void Function() stopListening;
  final void Function() startListening;
  final bool isTracking;
  final String km;
  final String calories;
  final String time;
  final FootStepModel footStepData;
  final String steps;
  final StepOfDay stepOfToday;
  @override
  State<StatefulWidget> createState() {
    return _DayFootStep();
  }
}

class _DayFootStep extends State<DayFootStep> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        ElevatedButton(
          onPressed:
              widget.isTracking ? widget.stopListening : widget.startListening,
          child: Text(
            widget.isTracking ? 'Stop' : 'Start',
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(height: 40),
        SizedBox(
          height: 40,
        ),
        CircularPercentIndicator(
          radius: 170.0,
          lineWidth: 15.0,
          percent: widget.footStepData.aim > 0
              ? (widget.stepOfToday.step / widget.footStepData.aim)
                  .clamp(0.0, 1.0)
              : 0.0,
          animation: true,
          center: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(
                  FontAwesomeIcons.personWalking,
                  size: 30.0,
                  color: Colors.black,
                ),
                Text(
                  widget.steps,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
                Text(
                  'Mục tiêu: ${widget.stepOfToday.step} / ${widget.footStepData.aim} bước',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                )
              ])
            ],
          ),
          progressColor: Colors.green,
        ),
        SizedBox(
          height: 70.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InfoCard(
              icon: Icons.directions_walk,
              value: '${widget.stepOfToday.step}',
              unit: 'bước',
            ),
            InfoCard(
              icon: Icons.local_fire_department,
              value: widget.calories,
              unit: 'kcal',
            ),
            InfoCard(
              icon: Icons.arrow_forward,
              value: widget.km,
              unit: 'km',
            ),
            InfoCard(
              icon: Icons.access_time,
              value: widget.time,
              unit: 'phút',
            ),
          ],
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String unit;

  InfoCard({required this.icon, required this.value, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
        border: Border.all(color: Colors.blue.shade100, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.black),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            unit,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
