import 'package:fitnessapp/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';


abstract class UserRepository {
  Future<UserEntity> register(
      String email,
      String password, {
        required String fullName,
        required String age,
        required String phone,
      });
  Future<UserEntity> signIn(String email, String password);
  Future<UserEntity> signInWithGoogle();
}