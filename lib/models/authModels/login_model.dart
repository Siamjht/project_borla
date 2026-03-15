
class LoginResponseModel {
  bool success;
  String message;
  LoginData data;

  LoginResponseModel({
    this.success = false,
    this.message = '',
    LoginData? data,
  }) : data = data ?? LoginData();

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: LoginData.fromJson(json['data'] ?? {}),
    );
  }
}

class LoginData {
  User user;
  String accessToken;
  String refreshToken;

  LoginData({
    User? user,
    this.accessToken = '',
    this.refreshToken = '',
  }) : user = user ?? User();

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      user: User.fromJson(json['user'] ?? {}),
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  }
}

class User {
  String id;
  String name;
  String email;
  String password;
  String status;
  String onlineStatus;
  String role;
  String profilePicture;
  String phoneNumber;
  String dateOfBirth;
  List<String> ghanaCardId;
  String? customerId;
  bool riderVerified;
  String zoneId;
  String? expireAt;
  bool isDeleted;
  Location location;
  String locationName;
  String createdAt;
  String updatedAt;
  Verification verification;

  User({
    this.id = '',
    this.name = '',
    this.email = '',
    this.password = '',
    this.status = '',
    this.onlineStatus = '',
    this.role = '',
    this.profilePicture = '',
    this.phoneNumber = '',
    this.dateOfBirth = '',
    this.ghanaCardId = const [],
    this.customerId,
    this.riderVerified = false,
    this.zoneId = '',
    this.expireAt,
    this.isDeleted = false,
    Location? location,
    this.locationName = '',
    this.createdAt = '',
    this.updatedAt = '',
    Verification? verification,
  })  : location = location ?? Location(),
        verification = verification ?? Verification();

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      status: json['status'] ?? '',
      onlineStatus: json['onlineStatus'] ?? '',
      role: json['role'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      ghanaCardId: (json['ghanaCardId'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          [],
      customerId: json['customerId'],
      riderVerified: json['riderVerified'] ?? false,
      zoneId: json['zoneId'] ?? '',
      expireAt: json['expireAt'],
      isDeleted: json['isDeleted'] ?? false,
      location: Location.fromJson(json['location'] ?? {}),
      locationName: json['locationName'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      verification: Verification.fromJson(json['verification'] ?? {}),
    );
  }
}

class Location {
  String type;
  List<double> coordinates;

  Location({
    this.type = '',
    this.coordinates = const [],
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'] ?? '',
      coordinates: (json['coordinates'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList() ??
          [],
    );
  }
}

class Verification {
  bool status;

  Verification({
    this.status = false,
  });

  factory Verification.fromJson(Map<String, dynamic> json) {
    return Verification(
      status: json['status'] ?? false,
    );
  }
}