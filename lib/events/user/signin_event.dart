abstract class SigninEvent{}

class SigninButtonSubmit extends SigninEvent {
  final String email;
  final String password;

  SigninButtonSubmit({required this.email, required this.password});
}

class GoogleSignInPressed extends SigninEvent {}