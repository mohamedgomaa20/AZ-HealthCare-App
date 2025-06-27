class RegisterResult {
  final String id;
  final String userName;
  final String email;
  final String role;

  RegisterResult({
    required this.id,
    required this.userName,
    required this.email,
    required this.role,
  });

  factory RegisterResult.fromJson(Map<String, dynamic> json) {
    return RegisterResult(
      id: json['id'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'role': role,
    };
  }
}
