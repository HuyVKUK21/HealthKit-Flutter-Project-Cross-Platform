abstract class RegisterEvent{}

class ButtonSubmitPressed extends RegisterEvent {
  final String email;
  final String password;
  final String fullName;
  final String age;
  final String phone;

  ButtonSubmitPressed({
    required this.fullName,
    required this.age,
    required this.phone,
    required this.email,
    required this.password,
  });
}
