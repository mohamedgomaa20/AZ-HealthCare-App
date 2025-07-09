class UserData {
  final String id;
  final String? userName;
  final String? email;
  final String? role;
  final String? name;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;

  final String? address;
  final String? dateOfBirth;
  final String? gender;
  final int? age;
  final double? weightKg;
  final int? height;
  final String? healthGoals;
  final String? createdDate;
  final String? updatedAt;

  UserData({
    this.userName,
    this.email,
    this.role,
    this.name,
    this.address,
    this.dateOfBirth,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.gender,
    this.age,
    this.weightKg,
    this.height,
    this.healthGoals,
    required this.id,
    this.createdDate,
    this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? '',
      userName: json['userName'],
      email: json['email'],
      role: json['role'],
      name: json['name'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      address: json['address'] ?? "",
      dateOfBirth: json['dateOfBirth'],
      phoneNumber: json['phoneNumber'] ?? "",
      gender: json['gender'] ?? "",
      age: json['age'],
      weightKg: json['weightKg']?.toDouble(),
      height: json['height'],
      healthGoals: json['healthGoals'],
      createdDate: json['createdDate'],
      updatedAt: json['updatedAt'],
    );
  }
}