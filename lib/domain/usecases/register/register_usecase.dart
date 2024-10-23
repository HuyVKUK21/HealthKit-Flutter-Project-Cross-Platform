import 'package:fitnessapp/domain/entities/user_entity.dart';
import 'package:fitnessapp/domain/repositories/register/user_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase {
  final UserRepository _userRepository;

  RegisterUseCase(this._userRepository);

  Future<UserEntity> call(String email, String password) async {
    return await _userRepository.register(email, password);
  }
}