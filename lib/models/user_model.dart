class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String registeredDate;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.registeredDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      registeredDate: json['registered_date'],
    );
  }
}

class UserProfileResponse {
  final bool success;
  final String message;
  final UserModel user;

  UserProfileResponse({
    required this.success,
    required this.message,
    required this.user,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      success: json['success'],
      message: json['message'],
      user: UserModel.fromJson(json['data']['user']),
    );
  }
}
