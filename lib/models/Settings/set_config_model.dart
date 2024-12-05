class SetConfigModel {
  final String locale;
  final int currency;

  SetConfigModel({
    required this.locale,
    required this.currency,
  });

  Map<String, dynamic> toJson() {
    return {
      'locale': locale,
      'currency': currency,
    };
  }
}

class SetConfigResponseModel {
  final bool success;
  final SetConfigResponseDataModel data;
  final String message;

  SetConfigResponseModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory SetConfigResponseModel.fromJson(Map<String, dynamic> json) =>
      SetConfigResponseModel(
        success: json["success"],
        data: SetConfigResponseDataModel.fromJson(json["data"]),
        message: json["message"],
      );
}

class SetConfigResponseDataModel {
  final String locale;
  final String currency;
  final int userId;
  final int id;

  SetConfigResponseDataModel({
    required this.locale,
    required this.currency,
    required this.userId,
    required this.id,
  });

  factory SetConfigResponseDataModel.fromJson(Map<String, dynamic> json) =>
      SetConfigResponseDataModel(
        locale: json["locale"],
        currency: json["currency"].toString(),
        userId: json["user_id"],
        id: json["id"],
      );
}
