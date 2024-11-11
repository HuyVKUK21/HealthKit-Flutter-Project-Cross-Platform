import 'package:fitnessapp/domain/entities/account_entity.dart';

class AccountModel {

  final String userId;
  final String? fullName;
  final String? email;
  final String? age;
  final String? phone;



  AccountModel({required this.userId, this.fullName ,this.email, this.age, this.phone});

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      userId: json['userId'],
      fullName: json['fullName'],
      email: json['email'],
      age: json['age'],
      phone: json['phone'],
    );
  }

  AccountEntity toEntity() {
    return AccountEntity(
      userId: userId,
      fullName: fullName,
      email: email,
      age: age,
      phone: phone
    );
  }

}
