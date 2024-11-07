import 'package:fitnessapp/data/models/user_model.dart';
import 'package:fitnessapp/domain/repositories/user/forget_password_respository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordUsercase {
  late ForgetPasswordRespository _forgetPasswordRespository;
  ForgetPasswordUsercase(this._forgetPasswordRespository);

  Future<Map<UserModel?, bool>> findUserByEmail(String email) {
    return _forgetPasswordRespository.findUserByEmail(email);
  }

  Future<void> signOut() {
    return _forgetPasswordRespository.signOut();
  }
}
