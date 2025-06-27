import 'register_result.dart';

class RegisterResponse {
  final int statusCode;
  final bool isSuccess;
  final List<dynamic> errors;
  final RegisterResult? result;

  RegisterResponse({
    required this.statusCode,
    required this.isSuccess,
    required this.errors,
    required this.result,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      statusCode: json['statusCode'] ?? 0,
      isSuccess: json['isSuccess'] ?? false,
      errors: json['errors'] ?? [],
      result: json['result'] != null
          ? RegisterResult.fromJson(json['result'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'isSuccess': isSuccess,
      'errors': errors,
      'result': result?.toJson(),
    };
  }
}
