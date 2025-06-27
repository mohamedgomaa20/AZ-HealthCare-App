class UserModel {
  final String id;
  final String userName;
  final String email;
  final String role;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      userName: json['userName'],
      email: json['email'],
      role: json['role'],
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
