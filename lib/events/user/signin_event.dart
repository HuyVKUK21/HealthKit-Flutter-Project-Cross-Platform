import 'package:equatable/equatable.dart';

abstract class SigninEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInEvent extends SigninEvent {
  final String email;
  final String password;

  SignInEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class SignUpEvent extends SigninEvent {
  final String email;
  final String password;
  final String fullName;
  final String age;
  final String phone;

  SignUpEvent(this.email, this.password, this.fullName, this.age, this.phone);

  @override
  List<Object?> get props => [email, password, fullName, age, phone];
}

class SignInWithGoogleEvent extends SigninEvent {}
