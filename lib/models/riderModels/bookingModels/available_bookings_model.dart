
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AvailableBookingModel {
  final String id;
  final String userId;
  final String riderId;
  final String wasteCategory;
  final List<String> wasteImages;
  final String binSize;
  final int binQuantity;
  final int wasteSize;
  final double pickupLatitude;
  final double pickupLongitude;
  final String pickupAddress;
  final String vehicleType;
  final String paymentMethod;
  final String status;
  final double price;
  final String createdAt;
  final String updatedAt;
  final bool isScheduled;
  final String scheduledFor;
  final String scheduledDate;
  final BookingUserModel user;

  AvailableBookingModel({
    this.id = '',
    this.userId = '',
    this.riderId = '',
    this.wasteCategory = '',
    this.wasteImages = const [],
    this.binSize = '',
    this.binQuantity = 0,
    this.wasteSize = 0,
    this.pickupLatitude = 0.0,
    this.pickupLongitude = 0.0,
    this.pickupAddress = '',
    this.vehicleType = '',
    this.paymentMethod = '',
    this.status = '',
    this.price = 0.0,
    this.createdAt = '',
    this.updatedAt = '',
    this.isScheduled = false,
    this.scheduledFor = '',
    this.scheduledDate = '',
    BookingUserModel? user,
  }) : user = user ?? BookingUserModel();

  factory AvailableBookingModel.fromJson(Map<String, dynamic> json) {
    final coordinates = json['pickupLocation']?['coordinates'] ?? [0.0, 0.0];
    final createdAt = json['createdAt'];
    final updatedAt = json['updatedAt'];
    final scheduledFor = json['scheduledFor'];

    return AvailableBookingModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      riderId: json['riderId'] ?? '',
      wasteCategory: json['wasteCategory'] ?? '',
      wasteImages: List<String>.from(json['wasteImages'] ?? []),
      binSize: json['binSize'] ?? '',
      binQuantity: json['binQuantity'] ?? 0,
      wasteSize: json['wasteSize'] ?? 0,
      pickupLatitude: (coordinates[1] as num).toDouble(),
      pickupLongitude: (coordinates[0] as num).toDouble(),
      pickupAddress: json['pickupAddress'] ?? '',
      vehicleType: json['vehicleType'] ?? '',
      paymentMethod: json['paymentMethod'] ?? '',
      status: json['status'] ?? '',
      price: json['price'] != null ? (json['price'] as num).toDouble() : 0.0,
      createdAt: createdAt is Map ? createdAt['\$date'] ?? '' : createdAt ?? '',
      updatedAt: updatedAt is Map ? updatedAt['\$date'] ?? '' : updatedAt ?? '',
      isScheduled: json['isScheduled'] ?? false,
      scheduledFor: scheduledFor is Map
          ? scheduledFor['\$date'] ?? ''
          : scheduledFor ?? '',
      scheduledDate: json['scheduledDate'] ?? '',
      user: json['user'] != null
          ? BookingUserModel.fromJson(json['user'])
          : null,
    );
  }

  LatLng get pickupLatLng => LatLng(pickupLatitude, pickupLongitude);
}

class BookingUserModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String profilePicture;

  BookingUserModel({
    this.id = '',
    this.name = 'Unknown User',
    this.email = '',
    this.phoneNumber = '',
    this.profilePicture = '',
  });

  factory BookingUserModel.fromJson(Map<String, dynamic> json) {
    return BookingUserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
    );
  }
}