import 'package:fitnessapp/data/models/user_model.dart';

abstract class ForgetPasswordRespository {
  Future<Map<UserModel?, bool>> findUserByEmail(String email);
  Future<void> signOut();
}
