
import 'package:fitnessapp/domain/entities/user_entity.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final UserEntity user;
  RegisterSuccess({required this.user});
}

class RegisterFailure extends RegisterState {
  final String error;

  RegisterFailure({required this.error});
}
