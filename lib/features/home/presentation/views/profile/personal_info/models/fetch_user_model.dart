class UserModel {
  final String? id;
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

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.role,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.address,
    required this.dateOfBirth,
    required this.gender,
    required this.age,
    required this.weightKg,
    required this.height,
    required this.healthGoals,
    required this.createdDate,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      userName: json['userName'],
      email: json['email'],
      role: json['role'],
      name: json['name'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      age: json['age'],
      weightKg: json['weightKg'],
      height: json['height'],
      healthGoals: json['healthGoals'],
      createdDate: json['createdDate'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userName": userName,
      "email": email,
      "role": role,
      "name": name,
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "address": address,
      "dateOfBirth": dateOfBirth,
      "gender": gender,
      "age": age,
      "weightKg": weightKg,
      "height": height,
      "healthGoals": healthGoals,
      "createdDate": createdDate,
      "updatedAt": updatedAt,
    };
  }
}
