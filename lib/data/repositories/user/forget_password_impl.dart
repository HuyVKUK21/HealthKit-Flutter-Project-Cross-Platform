import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessapp/data/models/user_model.dart';
import 'package:fitnessapp/domain/repositories/user/forget_password_respository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
@LazySingleton(as :ForgetPasswordRespository)
class ForgetPasswordImpl extends ForgetPasswordRespository {
  @override
  Future<void> signOut() async {
    try {
      // Firebase sign-out
      await FirebaseAuth.instance.signOut();

      // Clear UID from local storage
       SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_uid');

      print("User signed out successfully");
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  @override
  Future<Map<UserModel?, bool>> findUserByEmail(String email) async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    try {
      QuerySnapshot querySnapshot =
          await usersCollection.where('email', isEqualTo: email).limit(1).get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs[0];
        final data = doc.data() as Map<String, dynamic>;
        final random = Random();

        String otp = List.generate(6, (_) => random.nextInt(10)).join();
        await usersCollection.doc(doc.id).update({'otp': otp});
        UserModel user = UserModel(
          uid: data['uid'] ?? '',
          email: data['email'] ?? '',
        );

        return {user: true};
      } else {
        print("No user found with the specified email");
        return {null: false};
      }
    } catch (e) {
      print("Error finding user by email: $e");
      return {null: false};
    }
  }
}