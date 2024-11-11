import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessapp/data/models/user_model.dart';
import 'package:fitnessapp/domain/repositories/user/forget_password_respository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: ForgetPasswordRespository)
class ForgetPasswordImpl extends ForgetPasswordRespository {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationIdLast = '';
  @override
  Future<void> signOut() async {
    try {
      // Firebase sign-out
      await FirebaseAuth.instance.signOut();

      // Clear UID from local storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_account');

      print("User signed out successfully");
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  @override
  Future<Map<String?, bool>> findUserByEmail(String email) async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    try {
      QuerySnapshot querySnapshot =
          await usersCollection.where('email', isEqualTo: email).limit(1).get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs[0];
        final data = doc.data() as Map<String, dynamic>;
        await sendOtp('+84' + data['phone'].substring(1));

        return {verificationIdLast: true};
      } else {
        print("No user found with the specified email");
        return {null: false};
      }
    } catch (e) {
      print("Error finding user by email: $e");
      return {null: false};
    }
  }

  Future<void> sendOtp(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Nếu xác minh thành công tự động, bạn có thể đăng nhập ngay.
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Error: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        // Mã OTP đã được gửi, lưu verificationId để xác thực sau này.
        verificationIdLast = verificationId;
        print('OTP sent');
        // Bạn có thể hiển thị hộp thoại nhập mã OTP cho người dùng.
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('Timeout');
      },
    );
  }
}
