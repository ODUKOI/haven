class RegisterData {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  RegisterData({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });
}

class LoginData {
  final String email;
  final String password;

  LoginData({
    required this.email,
    required this.password,
  });
}

class AuthResponse {
  final String token;
  final User user;

  AuthResponse({
    required this.token,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        token: json['token'],
        user: User.fromJson(json['user']),
      );
}

class User {
  final int id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
      );
}
