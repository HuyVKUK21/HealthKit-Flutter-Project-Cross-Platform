import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserModel {
  final String ?email;
  final String ?uid;
  
  UserModel({required this.email, required this.uid});
  
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(uid: user.uid, email: user.email);
  }
}