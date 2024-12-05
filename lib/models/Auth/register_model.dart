class RegisterModel {
  final String email;
  final String name;
  final String password;
  final String passwordConfirmation;

  RegisterModel({
    required this.email,
    required this.name,
    required this.password,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
  }
}
