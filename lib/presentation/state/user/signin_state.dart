import 'package:equatable/equatable.dart';
import 'package:fitnessapp/domain/entities/user_entity.dart';


abstract class SigninState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends SigninState {}

class AuthLoading extends SigninState {}

class AuthAuthenticated extends SigninState {
  final UserEntity user;

  AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthError extends SigninState {
  final String message;

  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
