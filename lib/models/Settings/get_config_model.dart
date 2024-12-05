class GetConfigModel {
  final bool success;
  final GetConfigDataModel data;
  final String message;

  GetConfigModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory GetConfigModel.fromJson(Map<String, dynamic> json) => GetConfigModel(
        success: json["success"],
        data: GetConfigDataModel.fromJson(json["data"]),
        message: json["message"],
      );
}

class GetConfigDataModel {
  final int id;
  final int userId;
  final String locale;
  final int currency;

  GetConfigDataModel({
    required this.id,
    required this.userId,
    required this.locale,
    required this.currency,
  });

  factory GetConfigDataModel.fromJson(Map<String, dynamic> json) =>
      GetConfigDataModel(
        id: json["id"],
        userId: json["user_id"],
        locale: json["locale"],
        currency: json["currency"],
      );
}
