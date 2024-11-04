import 'dart:ffi';

import 'package:flutter/material.dart';

class ModalSettingAimWidget extends StatefulWidget {
  const ModalSettingAimWidget({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ModalSettingAimWidget();
  }
}

class _ModalSettingAimWidget extends State<ModalSettingAimWidget> {
  final _aimController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _aimController.dispose();
    super.dispose();
  }

  void submit() {
    print(_aimController.text);
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
              onPressed: submit,
              child: const Text(
                'Set',
                style: TextStyle(fontSize: 20),
              ))
        ],
      ),
    );
  }
}
