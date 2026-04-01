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

class PlaceSuggestionModel {
  final String placeId;
  final String title;
  final String address;

  PlaceSuggestionModel({
    required this.placeId,
    required this.title,
    required this.address,
  });

  factory PlaceSuggestionModel.fromJson(Map<String, dynamic> json) {
    final structured = json['structured_formatting'];
    return PlaceSuggestionModel(
      placeId: json['place_id'] ?? '',
      title: structured?['main_text'] ?? '',
      address: structured?['secondary_text'] ?? '',
    );
  }
}