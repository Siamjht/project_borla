
class LoginModel {
  final bool success;
  final String message;
  final LoginData data;

  LoginModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: LoginData.fromJson(
        Map<String, dynamic>.from(json['data'] ?? {}),
      ),
    );
  }
}

// ─────────────────────────────────────────

class LoginData {
  final UserModel user;
  final String accessToken;
  final String refreshToken;

  LoginData({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      user: UserModel.fromJson(json['user']),
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  }
}

// ─────────────────────────────────────────

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final String role;
  final String profile;
  final String? gender;
  final String? dateOfBirth;
  final String? bio;
  final String status;
  final String loginWith;
  final LocationModel location;
  final VerificationModel verification;
  final DeviceModel device;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.role,
    required this.profile,
    this.gender,
    this.dateOfBirth,
    this.bio,
    required this.status,
    required this.loginWith,
    required this.location,
    required this.verification,
    required this.device,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
      role: json['role'] ?? '',
      profile: json['profile'] ?? '',
      gender: json['gender'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      bio: json['bio'] ?? '',
      status: json['status'] ?? '',
      loginWith: json['loginWth'] ?? '',
      location: LocationModel.fromJson(json['location'] ?? {}),
      verification: VerificationModel.fromJson(json['verification'] ?? {}),
      device: DeviceModel.fromJson(json['device'] ?? {}),
    );
  }
}

// ─────────────────────────────────────────

class LocationModel {
  final String type;
  final List<double> coordinates;

  LocationModel({
    required this.type,
    required this.coordinates,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      type: json['type'] ?? 'Point',
      coordinates: List<double>.from(
        (json['coordinates'] ?? []).map((e) => (e as num).toDouble()),
      ),
    );
  }
}

// ─────────────────────────────────────────

class VerificationModel {
  final int otp;
  final String expiresAt;
  final bool status;

  VerificationModel({
    required this.otp,
    required this.expiresAt,
    required this.status,
  });

  factory VerificationModel.fromJson(Map<String, dynamic> json) {
    return VerificationModel(
      // ✅ Handle both int and String
      otp: int.tryParse(json['otp'].toString()) ?? 0,
      expiresAt: json['expiresAt'] ?? '',
      status: json['status'] ?? false,
    );
  }
}

// ─────────────────────────────────────────

class DeviceModel {
  final String ip;
  final String device;
  final String lastLogin;

  DeviceModel({
    required this.ip,
    required this.device,
    required this.lastLogin,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      ip: json['ip'] ?? '',
      device: json['device'] ?? '',
      lastLogin: json['lastLogin'] ?? '',
    );
  }
}