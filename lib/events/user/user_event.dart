abstract class RegisterEvent{}

class ButtonSubmitPressed extends RegisterEvent {
  final String email;
  final String password;

  ButtonSubmitPressed({required this.email, required this.password});
}