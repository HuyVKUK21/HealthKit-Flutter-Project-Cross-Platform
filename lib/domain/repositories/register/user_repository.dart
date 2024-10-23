import 'package:fitnessapp/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';


abstract class UserRepository {
  Future<UserEntity> register(String email, String password);
}