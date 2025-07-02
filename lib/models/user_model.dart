class UserModel {
  final int id;
  final String fullName;
  final String nationalId;
  final String phone;
  final String? profileImage;

  UserModel({
    required this.id,
    required this.fullName,
    required this.nationalId,
    required this.phone,
    this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullName: json['fullName'],
      nationalId: json['nationalId'],
      phone: json['phone'],
      profileImage: json['profileImage'],
    );
  }
}
