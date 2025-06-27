import 'package:az_health_care/features/home/data/models/user_model.dart';

class AllUsersResponse {
  final int statusCode;
  final bool isSuccess;
  final List<dynamic> errors;
  final List<UserModel> result;

  AllUsersResponse({
    required this.statusCode,
    required this.isSuccess,
    required this.errors,
    required this.result,
  });

  factory AllUsersResponse.fromJson(Map<String, dynamic> json) {
    return AllUsersResponse(
      statusCode: json['statusCode'],
      isSuccess: json['isSuccess'],
      errors: json['errors'] ?? [],
      result: (json['result'] as List)
          .map((item) => UserModel.fromJson(item))
          .toList(),
    );
  }
}