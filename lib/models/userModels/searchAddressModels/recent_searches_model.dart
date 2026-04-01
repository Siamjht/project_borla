class RecentSearchModel {
  final String title;
  final String address;
  final double latitude;
  final double longitude;

  RecentSearchModel({
    required this.title,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory RecentSearchModel.fromJson(Map<String, dynamic> json) {
    return RecentSearchModel(
      title: json['title'] ?? '',
      address: json['address'] ?? '',
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'address': address,
    'latitude': latitude,
    'longitude': longitude,
  };
}

