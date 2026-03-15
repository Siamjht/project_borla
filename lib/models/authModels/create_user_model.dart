
import 'login_model.dart';

class CreateUserResponseModel {
  final bool success;
  final String message;
  final CreateUserData data;

  CreateUserResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CreateUserResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateUserResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: CreateUserData.fromJson(
        Map<String, dynamic>.from(json['data'] ?? {}),
      ),
    );
  }
}

// ─────────────────────────────────────────

class CreateUserData {
  final UserModel user;
  final String otpToken;

  CreateUserData({
    required this.user,
    required this.otpToken,
  });

  factory CreateUserData.fromJson(Map<String, dynamic> json) {
    return CreateUserData(
      user: UserModel.fromJson(
        Map<String, dynamic>.from(json['user'] ?? {}),
      ),
      otpToken: json['otpToken']?['token'] ?? '',
    );
  }
}