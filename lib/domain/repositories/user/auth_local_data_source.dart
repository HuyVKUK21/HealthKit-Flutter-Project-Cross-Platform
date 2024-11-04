import 'package:fitnessapp/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';


abstract class AuthLocalDataSource {
  Future<void> saveUid(String uid);
  Future<String?> getUid();
  Future<void> clearUid();
}