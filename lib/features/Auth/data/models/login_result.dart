import 'package:az_health_care/features/Auth/data/models/register_result.dart';


class LoginResult {
  final ResultModel user;
  final String token;

  LoginResult({required this.user, required this.token});

  factory LoginResult.fromJson(Map<String, dynamic> json) {
    return LoginResult(
      user: ResultModel.fromJson(json['user']),
      token: json['token'],
    );
  }
}
