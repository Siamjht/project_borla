
import 'available_bookings_model.dart';

class RiderBookingModel {
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
  final String dropoffAddress;

  final String vehicleType;

  final double estimatedDistance;
  final String estimatedTime;

  final String paymentMethod;
  final double price;

  final bool isPaid;
  final String paidAt;

  final bool isPaidByCustomer;
  final String isPaidByCustomerAt;

  final bool isRefunded;
  final String refundedAt;

  final bool isScheduled;
  final String scheduledFor;
  final String scheduledDate;

  final String requestedAt;
  final String acceptedAt;
  final String completedAt;
  final String cancelledAt;

  final String arrivedAtPickup;
  final String arrivedAtDropoff;
  final String paymentCollectedAt;
  final String headingToStationAt;

  final String stationId;

  final String createdAt;
  final String updatedAt;

  final BookingUserModel user;
  final RiderDetailModel rider;

  RiderBookingModel({
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
    this.dropoffAddress = '',
    this.vehicleType = '',
    this.estimatedDistance = 0.0,
    this.estimatedTime = '',
    this.paymentMethod = '',
    this.price = 0.0,
    this.isPaid = false,
    this.paidAt = '',
    this.isPaidByCustomer = false,
    this.isPaidByCustomerAt = '',
    this.isRefunded = false,
    this.refundedAt = '',
    this.isScheduled = false,
    this.scheduledFor = '',
    this.scheduledDate = '',
    this.requestedAt = '',
    this.acceptedAt = '',
    this.completedAt = '',
    this.cancelledAt = '',
    this.arrivedAtPickup = '',
    this.arrivedAtDropoff = '',
    this.paymentCollectedAt = '',
    this.headingToStationAt = '',
    this.stationId = '',
    this.createdAt = '',
    this.updatedAt = '',
    BookingUserModel? user,
    RiderDetailModel? rider,
  })  : user = user ?? BookingUserModel(),
        rider = rider ?? RiderDetailModel();

  factory RiderBookingModel.fromJson(Map<String, dynamic> json) {
    final coordinates = json['pickupLocation']?['coordinates'] ?? [0.0, 0.0];

    return RiderBookingModel(
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
      dropoffAddress: json['dropoffAddress'] ?? '',
      vehicleType: json['vehicleType'] ?? '',
      estimatedDistance: (json['estimatedDistance'] as num? ?? 0).toDouble(),
      estimatedTime: json['estimatedTime'] ?? '',
      paymentMethod: json['paymentMethod'] ?? '',
      price: (json['price'] as num? ?? 0).toDouble(),
      isPaid: json['isPaid'] ?? false,
      paidAt: json['paidAt'] ?? '',
      isPaidByCustomer: json['isPaidByCustomer'] ?? false,
      isPaidByCustomerAt: json['isPaidByCustomerAt'] ?? '',
      isRefunded: json['isRefunded'] ?? false,
      refundedAt: json['refundedAt'] ?? '',
      isScheduled: json['isScheduled'] ?? false,
      scheduledFor: json['scheduledFor'] ?? '',
      scheduledDate: json['scheduledDate'] ?? '',
      requestedAt: json['requestedAt'] ?? '',
      acceptedAt: json['acceptedAt'] ?? '',
      completedAt: json['completedAt'] ?? '',
      cancelledAt: json['cancelledAt'] ?? '',
      arrivedAtPickup: json['arrivedAtPickup'] ?? '',
      arrivedAtDropoff: json['arrivedAtDropoff'] ?? '',
      paymentCollectedAt: json['paymentCollectedAt'] ?? '',
      headingToStationAt: json['headingToStationAt'] ?? '',
      stationId: json['stationId'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      user: json['user'] != null
          ? BookingUserModel.fromJson(json['user'])
          : null,
      rider: json['rider'] != null
          ? RiderDetailModel.fromJson(json['rider'])
          : null,
    );
  }
}

// ── Rider Detail Model ─────────────────────────────────────────
class RiderDetailModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String profilePicture;

  final double riderLatitude;
  final double riderLongitude;

  final String locationName;

  final double averageRating;
  final int totalRatings;
  final int completedBookings;

  RiderDetailModel({
    this.id = '',
    this.name = '',
    this.email = '',
    this.phoneNumber = '',
    this.profilePicture = '',
    this.riderLatitude = 0.0,
    this.riderLongitude = 0.0,
    this.locationName = '',
    this.averageRating = 0.0,
    this.totalRatings = 0,
    this.completedBookings = 0,
  });

  factory RiderDetailModel.fromJson(Map<String, dynamic> json) {
    final coordinates =
        json['location']?['coordinates'] ?? [0.0, 0.0];

    return RiderDetailModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      riderLatitude: (coordinates[1] as num).toDouble(),
      riderLongitude: (coordinates[0] as num).toDouble(),
      locationName: json['locationName'] ?? '',
      averageRating: (json['averageRating'] ?? 0).toDouble(),
      totalRatings: json['totalRatings'] ?? 0,
      completedBookings: json['completedBookings'] ?? 0,
    );
  }
}