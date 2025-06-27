import 'login_result.dart';

class LoginResponse {
  final int statusCode;
  final bool isSuccess;
  final List<dynamic> errors;
  final LoginResult? result;

  LoginResponse({
    required this.statusCode,
    required this.isSuccess,
    required this.errors,
    required this.result,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      statusCode: json['statusCode'],
      isSuccess: json['isSuccess'],
      errors: json['errors'] ?? [],
      result: json['result'] != null ? LoginResult.fromJson(json['result']) : null,
    );
  }
}
