import 'package:fitnessapp/presentation/bloc/bloodsure/bloodsure_bloc.dart';
import 'package:fitnessapp/presentation/events/bloodsure/bloodsure_event.dart';
import 'package:fitnessapp/presentation/screens/bloodsure/bloodsure_screen.dart';
import 'package:fitnessapp/presentation/state/bloodsure/bloodsure_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BloodSureMeasureScreen extends StatefulWidget {
  @override
  _BloodSureMeasureScreenState createState() => _BloodSureMeasureScreenState();
}

class _BloodSureMeasureScreenState extends State<BloodSureMeasureScreen> {
  TextEditingController _systolicController = TextEditingController();
  TextEditingController _diastolicController = TextEditingController();
  TextEditingController _heartRateController = TextEditingController();

  FocusNode _systolicFocus = FocusNode();
  FocusNode _diastolicFocus = FocusNode();
  FocusNode _heartRateFocus = FocusNode();

  String _infoText = "";

  @override
  void initState() {
    super.initState();
    _systolicFocus.addListener(() {
      if (_systolicFocus.hasFocus) {
        setState(() {
          _infoText = "Tâm thu: Huyết áp tâm thu tính bằng mmHg (30~300)";
        });
      } else {
        setState(() {
          _infoText = "";
        });
      }
    });

    _diastolicFocus.addListener(() {
      if (_diastolicFocus.hasFocus) {
        setState(() {
          _infoText = "Tâm trương: Huyết áp tâm trương tính bằng mmHg (20~250)";
        });
      } else {
        setState(() {
          _infoText = ""; // Reset infoText khi không còn focus
        });
      }
    });

    _heartRateFocus.addListener(() {
      if (_heartRateFocus.hasFocus) {
        setState(() {
          _infoText = "Nhịp tim: Nhịp tim tính bằng nhịp/phút (40~300)";
        });
      } else {
        setState(() {
          _infoText = ""; // Reset infoText khi không còn focus
        });
      }
    });
  }

  @override
  void dispose() {
    _systolicController.dispose();
    _diastolicController.dispose();
    _heartRateController.dispose();
    _systolicFocus.dispose();
    _diastolicFocus.dispose();
    _heartRateFocus.dispose();
    super.dispose();
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
  }) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: focusNode.hasFocus ? Colors.white : Colors.grey[100], // Nền trắng khi focus, nền giao diện khi không
        borderRadius: BorderRadius.circular(12),
        border: focusNode.hasFocus
            ? Border.all(color: Colors.red, width: 2) // Viền đỏ khi focus
            : null, // Không có viền khi không được chọn
      ),
      child: Center(
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          maxLength: 3,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            counterText: "", // Ẩn bộ đếm ký tự
            hintText: "---",
            hintStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.grey[400],
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BloodsureBloc, BloodsureState>(
      listener: (context, state) {
        if (state is BloodsureUpdated) {
          Navigator.pushReplacementNamed(
            context,
            BloodsureScreen.routeName,
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.close, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bloodtype, color: Colors.red, size: 30),
                  SizedBox(width: 10),
                  Text(
                    "Nhập số đo huyết áp",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Ô nhập Tâm thu
                  Column(
                    children: [
                      _buildInputField(
                        controller: _systolicController,
                        focusNode: _systolicFocus,
                        label: "Tâm thu",
                      ),
                      Text(
                        "Tâm thu",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),

                  // Ô nhập Tâm trương
                  Column(
                    children: [
                      _buildInputField(
                        controller: _diastolicController,
                        focusNode: _diastolicFocus,
                        label: "Tâm trương",
                      ),
                      Text(
                        "Tâm trương",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),

                  // Ô nhập Nhịp tim
                  Column(
                    children: [
                      _buildInputField(
                        controller: _heartRateController,
                        focusNode: _heartRateFocus,
                        label: "Nhịp tim",
                      ),
                      Text(
                        "Nhịp tim",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Hiển thị thông tin bổ sung
              Text(
                _infoText,
                style: TextStyle(color: Colors.grey[600], fontSize: 10),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  // Thêm chức năng khi bấm vào
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.help_outline, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      "Đo huyết áp như thế nào là chính xác?",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () {
                  context.read<BloodsureBloc>().add(SaveBloodsureData(systolic: int.tryParse(_systolicController.text) ?? 0, diastolic:  int.tryParse(_diastolicController.text) ?? 0, heartRate:  int.tryParse(_heartRateController.text) ?? 0));
                },
                child: Text(
                  "Hoàn tất",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
