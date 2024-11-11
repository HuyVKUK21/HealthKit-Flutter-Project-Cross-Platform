import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessapp/data/repositories/foot_step/foot_step_repository_impl.dart';
import 'package:fitnessapp/domain/usecases/foot_step/foot_step_usecase.dart';
import 'package:fitnessapp/service_locator.dart';
import 'package:flutter/material.dart';

class ModalSettingAimWidget extends StatefulWidget {
  const ModalSettingAimWidget({super.key, required this.updateAim});

  final void Function(int) updateAim;

  @override
  State<StatefulWidget> createState() {
    return _ModalSettingAimWidget();
  }
}

class _ModalSettingAimWidget extends State<ModalSettingAimWidget> {
  final _aimController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _aimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _aimController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              label: Text('Mục tiêu:'),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                widget.updateAim(int.parse(_aimController.text));
              },
              child: const Text(
                'Set',
                style: TextStyle(fontSize: 20),
              ))
        ],
      ),
    );
  }
}
