class UserModel {
  final bool? success;
  final UserDataModel? data;
  final String message;

  UserModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        success: json["success"],
        data: UserDataModel.fromJson(json["data"]),
        message: json["message"] ?? '',
      );
}

class UserDataModel {
  final String? token;
  final String name;

  UserDataModel({
    required this.token,
    required this.name,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        token: json["token"],
        name: json["name"] ?? '',
      );
}
