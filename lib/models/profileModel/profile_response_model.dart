

import '../authModels/login_model.dart';

class ProfileResponseModel {
  final bool success;
  final String message;
  final UserModel data;

  ProfileResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: UserModel.fromJson(
        Map<String, dynamic>.from(json['data'] ?? {}),
      ),
    );
  }
}