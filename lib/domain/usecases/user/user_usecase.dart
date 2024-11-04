import 'package:fitnessapp/domain/entities/user_entity.dart';
import 'package:fitnessapp/domain/repositories/user/auth_local_data_source.dart';
import 'package:fitnessapp/domain/repositories/user/user_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserUseCase {
  final UserRepository _userRepository;
  final AuthLocalDataSource _authLocalDataSource;
  UserUseCase(this._userRepository, this._authLocalDataSource);

  Future<UserEntity> callSignUp(String email, String password, String fullName,
  String age, String phone) async {
    return await _userRepository.register(email, password, fullName: fullName, age: age, phone: phone);
  }

  Future<UserEntity> callSignIn(String email, String password) async {
    final userEntity = await _userRepository.signIn(email, password);
    await _authLocalDataSource.saveUid(userEntity.uid);
    return userEntity;
  }

  Future<UserEntity> callsignInWithGoogle() async {
    final userEntity = await _userRepository.signInWithGoogle();
    await _authLocalDataSource.saveUid(userEntity.uid);
    return userEntity;
  }
}