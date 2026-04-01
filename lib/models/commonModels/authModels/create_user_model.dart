
import 'login_model.dart';

class CreateUserResponseModel {
  bool success;
  String message;
  CreateUserData data;

  CreateUserResponseModel({
    this.success = false,
    this.message = '',
    CreateUserData? data,
  }) : data = data ?? CreateUserData();

  factory CreateUserResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateUserResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: CreateUserData.fromJson(json['data'] ?? {}),
    );
  }
}

class CreateUserData {
  String email;
  String name;
  String verificationToken;
  String message;

  CreateUserData({
    this.email = '',
    this.name = '',
    this.verificationToken = '',
    this.message = '',
  });

  factory CreateUserData.fromJson(Map<String, dynamic> json) {
    return CreateUserData(
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      verificationToken: json['verificationToken'] ?? '',
      message: json['message'] ?? '',
    );
  }
}
