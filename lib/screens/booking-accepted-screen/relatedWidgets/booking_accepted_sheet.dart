import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../models/userModels/bookingModels/user_booking_model.dart';
import '../../../widgets/booking-accepted-sheet-widgets/user_section_widget.dart';
import '../../../widgets/booking-accepted-sheet-widgets/bottom_section_widget.dart';
import '../../scheduled-screens/cancel_ride_screen.dart';

class BookingAcceptedSheet extends StatefulWidget {
  final UserBookingModel booking;

  const BookingAcceptedSheet({super.key, required this.booking});

  @override
  State<BookingAcceptedSheet> createState() => _BookingAcceptedSheetState();
}

class _BookingAcceptedSheetState extends State<BookingAcceptedSheet> {
  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '--:--';
    return DateFormat('hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final booking = widget.booking;

    log("Booking Rider: ${booking?.rider}");

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 480,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Status badge
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            booking?.status.name.toUpperCase() ?? 'ACCEPTED',
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Title
                  Text(
                    booking != null
                        ? 'Your Borla is on the way!'
                        : 'Your Borla has been accepted',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 10, 22, 10),
                    child: Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                  ),

                  // Driver Section
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 8, 22, 10),
                    child: booking != null && booking.rider != null
                        ? userSectionWidget(rider: booking.rider)
                        :  userRowModClick(),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
                    child: Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                  ),

                  // Pickup & Dropoff Locations
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 8, 22, 10),
                    child: booking != null
                        ? bottomSheetLocationSection(
                            pickupAddress: booking.pickupAddress,
                            requestedAt: booking.requestedAt,
                          )
                        :  bottomSheetLocationSectionMod(),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
                    child: Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                  ),

                  // Summary Section
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 8, 22, 10),
                    child: booking != null
                        ? summarySection(
                            price: booking.price,
                            estimatedDistance: booking.estimatedDistance,
                            estimatedTime: booking.estimatedTime,
                          )
                        :  summarySection(),
                  ),

                  const SizedBox(height: 10),

                  // Cancel Ride Button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 50),
                        backgroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        Get.to(() => CancelRideScreen(booking: booking));
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(120, 14, 120, 14),
                        child: Text(
                          'Cancel Ride',
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: -40,
          right: 166,
          child: Image.asset(
            'assets/images/orange_tick_2.png',
            scale: 6.5,
          ),
        ),
      ],
    );
  }
}
