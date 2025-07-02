class UserModel {
  final String fullName;
  final String nationalId;
  final String phone;
  final String address;
  final String role;
  final String password;

  UserModel({
    required this.fullName,
    required this.nationalId,
    required this.phone,
    required this.address,
    required this.role,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'nationalId': nationalId,
      'phone': phone,
      'address': address,
      'role': role,
      'password': password,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'],
      nationalId: json['nationalId'],
      phone: json['phone'],
      address: json['address'],
      role: json['role'],
      password: json['password'],
    );
  }
}
