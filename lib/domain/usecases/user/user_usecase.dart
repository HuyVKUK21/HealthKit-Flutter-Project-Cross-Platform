import 'package:fitnessapp/domain/entities/user_entity.dart';
import 'package:fitnessapp/domain/repositories/user/user_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserUseCase {
  final UserRepository _userRepository;
  UserUseCase(this._userRepository);

  Future<UserEntity> callSignUp(String email, String password, String fullName,
  String age, String phone) async {
    return await _userRepository.register(email, password, fullName: fullName, age: age, phone: phone);
  }

  Future<UserEntity> callSignIn(String email, String password) async {
    return await _userRepository.signIn(email, password);
  }

  Future<UserEntity> callsignInWithGoogle() async {
    return await _userRepository.signInWithGoogle();
  }
}