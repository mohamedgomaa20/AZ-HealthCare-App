import 'login_result.dart';

class LoginAndRegisterResponse {
  final int statusCode;
  final bool isSuccess;
  final List<dynamic> errors;
  final LoginResult? result;

  LoginAndRegisterResponse({
    required this.statusCode,
    required this.isSuccess,
    required this.errors,
    required this.result,
  });

  factory LoginAndRegisterResponse.fromJson(Map<String, dynamic> json) {
    return LoginAndRegisterResponse(
      statusCode: json['statusCode'],
      isSuccess: json['isSuccess'],
      errors: json['errors'] ?? [],
      result: json['result'] != null ? LoginResult.fromJson(json['result']) : null,
    );
  }
}
