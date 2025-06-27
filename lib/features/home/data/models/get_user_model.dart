import 'package:az_health_care/features/home/data/models/user_model.dart';

class UserResponse {
  final int statusCode;
  final bool isSuccess;
  final List<dynamic> errors;
  final UserModel? result;

  UserResponse({
    required this.statusCode,
    required this.isSuccess,
    required this.errors,
    required this.result,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      statusCode: json['statusCode'],
      isSuccess: json['isSuccess'],
      errors: json['errors'],
      result:
          json['result'] != null ? UserModel.fromJson(json['result']) : null,
    );
  }
}
