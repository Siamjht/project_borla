
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WasteStationModel {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final double distanceKm;

  WasteStationModel({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.distanceKm,
  });

  LatLng get latLng => LatLng(latitude, longitude);
}

class StationModel {
  final String id;
  final String zoneId;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;
  final StationZoneModel zone;

  StationModel({
    this.id = '',
    this.zoneId = '',
    this.name = '',
    this.address = '',
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.isDeleted = false,
    this.createdAt = '',
    this.updatedAt = '',
    StationZoneModel? zone,
  }) : zone = zone ?? StationZoneModel();

  factory StationModel.fromJson(Map<String, dynamic> json) {
    final coordinates = json['location']?['coordinates'] ?? [0.0, 0.0];
    return StationModel(
      id: json['id'] ?? '',
      zoneId: json['zoneId'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      latitude: (coordinates[1] as num).toDouble(),   // index 1 = lat
      longitude: (coordinates[0] as num).toDouble(),  // index 0 = lng
      isDeleted: json['isDeleted'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      zone: json['zone'] != null
          ? StationZoneModel.fromJson(json['zone'])
          : null,
    );
  }

  LatLng get latLng => LatLng(latitude, longitude);
}

class StationZoneModel {
  final String id;
  final String name;

  StationZoneModel({
    this.id = '',
    this.name = '',
  });

  factory StationZoneModel.fromJson(Map<String, dynamic> json) {
    return StationZoneModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}