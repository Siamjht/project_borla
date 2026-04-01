class CreateBookingModel {
  final String id;
  final String userId;
  final String status;
  final String wasteCategory;
  final List<String> wasteImages;
  final String binSize;
  final int binQuantity;
  final int wasteSize;
  final String pickupAddress;
  final String vehicleType;
  final String paymentMethod;
  final bool isScheduled;
  final String? scheduledFor;
  final String? scheduledDate;
  final String? price;
  final String? dropoffAddress;

  CreateBookingModel({
    required this.id,
    required this.userId,
    required this.status,
    required this.wasteCategory,
    required this.wasteImages,
    required this.binSize,
    required this.binQuantity,
    required this.wasteSize,
    required this.pickupAddress,
    required this.vehicleType,
    required this.paymentMethod,
    required this.isScheduled,
    this.scheduledFor,
    this.scheduledDate,
    this.price,
    this.dropoffAddress,
  });

  factory CreateBookingModel.fromJson(Map<String, dynamic> json) {
    return CreateBookingModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      status: json['status'] ?? '',
      wasteCategory: json['wasteCategory'] ?? '',
      wasteImages: List<String>.from(json['wasteImages'] ?? []),
      binSize: json['binSize'] ?? '',
      binQuantity: json['binQuantity'] ?? 0,
      wasteSize: json['wasteSize'] ?? 0,
      pickupAddress: json['pickupAddress'] ?? '',
      vehicleType: json['vehicleType'] ?? '',
      paymentMethod: json['paymentMethod'] ?? '',
      isScheduled: json['isScheduled'] ?? false,
      scheduledFor: json['scheduledFor'],
      scheduledDate: json['scheduledDate'],
      price: json['price']?.toString(),
      dropoffAddress: json['dropoffAddress'],
    );
  }
}