import '../../../home/data/models/user_model.dart';

class LoginResult {
  final UserModel user;
  final String token;

  LoginResult({
    required this.user,
    required this.token,
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) {
    return LoginResult(
      user: UserModel.fromJson(json['user']),
      token: json['token'],
    );
  }
}
