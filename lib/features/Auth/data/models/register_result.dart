class ResultModel {
  final String? id;
  final String? userName;
  final String? email;
  final String? role;

  ResultModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.role,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      id: json['id'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'userName': userName, 'email': email, 'role': role};
  }
}
