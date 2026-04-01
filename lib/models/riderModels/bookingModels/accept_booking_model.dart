
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'available_bookings_model.dart';

class AcceptedBookingModel {
  final String id;
  final String userId;
  final String riderId;
  final String status;
  final String wasteCategory;
  final List<String> wasteImages;
  final String binSize;
  final int binQuantity;
  final int wasteSize;
  final double pickupLatitude;
  final double pickupLongitude;
  final String pickupAddress;
  final String? dropoffAddress;
  final String vehicleType;
  final double? estimatedDistance;
  final String? estimatedTime;
  final String paymentMethod;
  final double? price;
  final bool isPaid;
  final bool isScheduled;
  final String? scheduledFor;
  final String? scheduledDate;
  final String requestedAt;
  final String? acceptedAt;
  final BookingUserModel? user;
  final BookingUserModel? rider;

  AcceptedBookingModel({
    this.id = '',
    this.userId = '',
    this.riderId = '',
    this.status = '',
    this.wasteCategory = '',
    this.wasteImages = const [],
    this.binSize = '',
    this.binQuantity = 0,
    this.wasteSize = 0,
    this.pickupLatitude = 0.0,
    this.pickupLongitude = 0.0,
    this.pickupAddress = '',
    this.dropoffAddress,
    this.vehicleType = '',
    this.estimatedDistance,
    this.estimatedTime,
    this.paymentMethod = '',
    this.price,
    this.isPaid = false,
    this.isScheduled = false,
    this.scheduledFor,
    this.scheduledDate,
    this.requestedAt = '',
    this.acceptedAt,
    this.user,
    this.rider,
  });

  factory AcceptedBookingModel.fromJson(Map<String, dynamic> json) {
    final coordinates = json['pickupLocation']?['coordinates'] ?? [0.0, 0.0];
    return AcceptedBookingModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      riderId: json['riderId'] ?? '',
      status: json['status'] ?? '',
      wasteCategory: json['wasteCategory'] ?? '',
      wasteImages: List<String>.from(json['wasteImages'] ?? []),
      binSize: json['binSize'] ?? '',
      binQuantity: json['binQuantity'] ?? 0,
      wasteSize: json['wasteSize'] ?? 0,
      pickupLatitude: (coordinates[1] as num).toDouble(),
      pickupLongitude: (coordinates[0] as num).toDouble(),
      pickupAddress: json['pickupAddress'] ?? '',
      dropoffAddress: json['dropoffAddress'],
      vehicleType: json['vehicleType'] ?? '',
      estimatedDistance: json['estimatedDistance'] != null
          ? (json['estimatedDistance'] as num).toDouble()
          : null,
      estimatedTime: json['estimatedTime'],
      paymentMethod: json['paymentMethod'] ?? '',
      price: json['price'] != null
          ? (json['price'] as num).toDouble()
          : null,
      isPaid: json['isPaid'] ?? false,
      isScheduled: json['isScheduled'] ?? false,
      scheduledFor: json['scheduledFor'],
      scheduledDate: json['scheduledDate'],
      requestedAt: json['requestedAt'] ?? '',
      acceptedAt: json['acceptedAt'],
      user: json['user'] != null
          ? BookingUserModel.fromJson(json['user'])
          : null,
      rider: json['rider'] != null
          ? BookingUserModel.fromJson(json['rider'])
          : null,
    );
  }

  LatLng get pickupLatLng => LatLng(pickupLatitude, pickupLongitude);
}