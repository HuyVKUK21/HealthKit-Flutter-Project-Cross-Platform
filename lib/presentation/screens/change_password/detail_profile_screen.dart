import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DetailProfileScreen extends StatefulWidget {
  static String routeName = '/DetailProfileScreen';
  const DetailProfileScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _DetailProfileScreen();
  }
}

class _DetailProfileScreen extends State<DetailProfileScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final user = _auth.currentUser;

    if (user != null) {
      _emailController.text = user.email ?? '';

      final userData = await _firestore
          .collection('users')
          .where('userId', isEqualTo: user.uid)
          .limit(1)
          .get();
      if (userData.docs.isNotEmpty) {
        final data =
            userData.docs.first.data(); // Lấy dữ liệu từ tài liệu đầu tiên
        setState(() {
          _fullnameController.text = data['fullName'] ?? '';
          _phoneController.text = data['phone'] ?? '';
          _ageController.text = data['age']?.toString() ?? '';
        });
      }
    }
  }

  Future<void> _updateUserInfo() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userData = await _firestore
          .collection('users')
          .where('userId', isEqualTo: user.uid)
          .limit(1)
          .get();

      if (userData.docs.isNotEmpty) {
        final data = userData.docs.first.data();

        if (_fullnameController.text.isEmpty ||
            _phoneController.text.isEmpty ||
            _ageController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Vui lòng điền đầy đủ thông tin.')),
          );
          return;
        }

        if (_fullnameController.text == data['fullname'] &&
            _phoneController.text == data['phone'] &&
            int.tryParse(_ageController.text) == data['age']) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Không có thay đổi nào để cập nhật.')),
          );
          return;
        }

        final docRef = userData.docs.first.reference;
        await docRef.update({
          'fullName': _fullnameController.text,
          'phone': _phoneController.text,
          'age': _ageController.text.toString() ?? '0',
        });

        setState(() {
          _fullnameController.text = _fullnameController.text;
          _phoneController.text = _phoneController.text;
          _ageController.text = _ageController.text;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Thông tin người dùng đã được cập nhật!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hồ sơ',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chỉnh sửa thông tin của bạn',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),

            // Fullname field
            _buildTextField(
              controller: _fullnameController,
              label: 'Họ và tên',
              icon: Icons.person,
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: 12),

            // Phone field
            _buildTextField(
              controller: _phoneController,
              label: 'Số điện thoại',
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 12),

            // Age field
            _buildTextField(
              controller: _ageController,
              label: 'Tuổi',
              icon: Icons.calendar_today,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12),

            // Email field (disabled)
            _buildTextField(
              controller: _emailController,
              label: 'Email',
              icon: Icons.email,
              enabled: false,
            ),
            SizedBox(height: 20),

            // Update button with full width
            Container(
              width: double.infinity, // This ensures full width
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: _updateUserInfo,
                child: Text(
                  'Xác nhận',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool enabled = true,
  }) {
    return TextField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: 16),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.green),
        labelText: label,
        labelStyle: TextStyle(color: Colors.green),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.green, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.green, width: 1),
        ),
      ),
    );
  }
}
