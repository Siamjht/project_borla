
class SavedPlaceModel {
  final String id;
  final String userId;
  final String placeType;
  final String placeTitle;
  final String placeName;
  final String address;
  final double latitude;
  final double longitude;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;

  SavedPlaceModel({
    required this.id,
    required this.userId,
    required this.placeType,
    required this.placeTitle,
    required this.placeName,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SavedPlaceModel.fromJson(Map<String, dynamic> json) {
    final coordinates = json['location']?['coordinates'] ?? [0.0, 0.0];
    return SavedPlaceModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      placeType: json['placeType'] ?? '',
      placeTitle: json['placeTitle'] ?? '',
      placeName: json['placeName'] ?? '',
      address: json['address'] ?? '',
      latitude: coordinates[1]?.toDouble() ?? 0.0,   // index 1 = lat
      longitude: coordinates[0]?.toDouble() ?? 0.0,  // index 0 = lng
      isDeleted: json['isDeleted'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}