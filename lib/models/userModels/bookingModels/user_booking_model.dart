enum BookingStatus {
  pending,
  accepted,
  arrivedPickup,
  paymentCollected,
  headingToStation,
  inProgress,
  arrivedDropOff,
  awaitingPayment,
  completed,
  cancelled,
}

BookingStatus bookingStatusFromString(String status) {
  switch (status) {
    case "accepted":
      return BookingStatus.accepted;
    case "arrived_pickup":
      return BookingStatus.arrivedPickup;
    case "payment_collected":
      return BookingStatus.paymentCollected;
    case "heading_to_station":
      return BookingStatus.headingToStation;
    case "in_progress":
      return BookingStatus.inProgress;
    case "arrived_dropoff":
      return BookingStatus.arrivedDropOff;
    case "awaiting_payment":
      return BookingStatus.awaitingPayment;
    case "completed":
      return BookingStatus.completed;
    case "cancelled":
      return BookingStatus.cancelled;
    default:
      return BookingStatus.pending;
  }
}

class UserBookingModel {
  final String id;
  final String userId;
  final String riderId;
  final BookingStatus status;

  final String wasteCategory;
  final List<String> wasteImages;

  final String binSize;
  final int binQuantity;
  final int wasteSize;

  final LocationModel pickupLocation;
  final String pickupAddress;

  final LocationModel dropoffLocation;
  final String dropoffAddress;

  final String vehicleType;

  final double estimatedDistance;
  final String estimatedTime;

  // Added
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

  final UserModel user;
  final RiderModel rider;

  final DateTime requestedAt;
  final DateTime acceptedAt;
  final DateTime completedAt;
  final DateTime cancelledAt;

  // Added
  final String arrivedAtPickup;
  final String arrivedAtDropoff;
  final String paymentCollectedAt;
  final String headingToStationAt;

  final String stationId;

  final String createdAt;
  final String updatedAt;

  UserBookingModel({
    required this.id,
    required this.userId,
    required this.riderId,
    required this.status,
    required this.wasteCategory,
    required this.wasteImages,
    required this.binSize,
    required this.binQuantity,
    required this.wasteSize,
    required this.pickupLocation,
    required this.pickupAddress,
    required this.dropoffLocation,
    required this.dropoffAddress,
    required this.vehicleType,
    required this.estimatedDistance,
    required this.estimatedTime,
    required this.paymentMethod,
    required this.price,
    required this.isPaid,
    required this.paidAt,
    required this.isPaidByCustomer,
    required this.isPaidByCustomerAt,
    required this.isRefunded,
    required this.refundedAt,
    required this.isScheduled,
    required this.scheduledFor,
    required this.scheduledDate,
    required this.user,
    required this.rider,
    required this.requestedAt,
    required this.acceptedAt,
    required this.completedAt,
    required this.cancelledAt,
    required this.arrivedAtPickup,
    required this.arrivedAtDropoff,
    required this.paymentCollectedAt,
    required this.headingToStationAt,
    required this.stationId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserBookingModel.fromJson(Map<String, dynamic> json) {
    return UserBookingModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      riderId: json['riderId'] ?? '',

      status: bookingStatusFromString(json['status'] ?? ''),

      wasteCategory: json['wasteCategory'] ?? '',
      wasteImages: List<String>.from(json['wasteImages'] ?? []),

      binSize: json['binSize'] ?? '',
      binQuantity: json['binQuantity'] ?? 0,
      wasteSize: json['wasteSize'] ?? 0,

      pickupLocation: LocationModel.fromJson(json['pickupLocation'] ?? {}),
      pickupAddress: json['pickupAddress'] ?? '',

      dropoffLocation: LocationModel.fromJson(json['dropoffLocation'] ?? {}),
      dropoffAddress: json['dropoffAddress'] ?? '',

      vehicleType: json['vehicleType'] ?? '',

      estimatedDistance: (json['estimatedDistance'] ?? 0).toDouble(),
      estimatedTime: json['estimatedTime'] ?? '',

      paymentMethod: json['paymentMethod'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      isPaid: json['isPaid'] ?? false,
      paidAt: json['paidAt'] ?? '',

      isPaidByCustomer: json['isPaidByCustomer'] ?? false,
      isPaidByCustomerAt: json['isPaidByCustomerAt'] ?? '',

      isRefunded: json['isRefunded'] ?? false,
      refundedAt: json['refundedAt'] ?? '',

      isScheduled: json['isScheduled'] ?? false,
      scheduledFor: json['scheduledFor'] ?? '',
      scheduledDate: json['scheduledDate'] ?? '',

      user: UserModel.fromJson(json['user'] ?? {}),
      rider: RiderModel.fromJson(json['rider'] ?? {}),

      requestedAt: DateTime.tryParse(json['requestedAt'] ?? '') ?? DateTime(0),
      acceptedAt: DateTime.tryParse(json['acceptedAt'] ?? '') ?? DateTime(0),
      completedAt: DateTime.tryParse(json['completedAt'] ?? '') ?? DateTime(0),
      cancelledAt: DateTime.tryParse(json['cancelledAt'] ?? '') ?? DateTime(0),

      arrivedAtPickup: json['arrivedAtPickup'] ?? '',
      arrivedAtDropoff: json['arrivedAtDropoff'] ?? '',
      paymentCollectedAt: json['paymentCollectedAt'] ?? '',
      headingToStationAt: json['headingToStationAt'] ?? '',

      stationId: json['stationId'] ?? '',

      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class LocationModel {
  final String type;
  final List<double> coordinates;

  LocationModel({
    required this.type,
    required this.coordinates,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      type: json['type'] ?? '',
      coordinates: json['coordinates'] != null
          ? List<double>.from(
          json['coordinates'].map((e) => (e ?? 0).toDouble()))
          : [],
    );
  }
}

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String profilePicture;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
    );
  }
}

class RiderModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String profilePicture;

  final LocationModel location;
  final String locationName;

  final double averageRating;
  final int totalRatings;
  final int completedBookings;

  RiderModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.location,
    required this.locationName,
    required this.averageRating,
    required this.totalRatings,
    required this.completedBookings,
  });

  factory RiderModel.fromJson(Map<String, dynamic> json) {
    return RiderModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      profilePicture: json['profilePicture'] ?? '',

      location: LocationModel.fromJson(json['location'] ?? {}),
      locationName: json['locationName'] ?? '',

      averageRating: (json['averageRating'] ?? 0).toDouble(),
      totalRatings: json['totalRatings'] ?? 0,
      completedBookings: json['completedBookings'] ?? 0,
    );
  }
}


