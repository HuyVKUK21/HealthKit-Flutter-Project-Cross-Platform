import 'dart:convert';

class AccountEntity {

  final String userId;
  final String fullName;
  final String email;
  final String age;
  final String phone;



  AccountEntity({required this.userId, required this.fullName,required this.email,required this.age,required this.phone, });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'age': age,
      'phone': phone
    };
  }


  factory AccountEntity.fromMap(Map<String, dynamic> map) {
    return AccountEntity(
      userId: map['userId'],
      fullName: map['fullName'],
      email: map['email'],
      age: map['age'],
      phone: map['phone']
    );
  }

  String toJson() => jsonEncode(toMap());


  factory AccountEntity.fromJson(String source) => AccountEntity.fromMap(jsonDecode(source));
}

