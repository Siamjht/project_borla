
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/bottom-sheets/rating_sheet.dart';
import 'package:project_borla/models/userModels/bookingModels/user_booking_model.dart';
import 'package:project_borla/screens/map-screens/user_common_map.dart';
import '../../role/components/commonBackButton/common_back_button.dart';

class RiderReviewScreen extends StatelessWidget {
  final UserBookingModel booking;
  const RiderReviewScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned.fill(child: UserCommonMap(booking: booking)),

            const Positioned(
                left: 20,
                top: 60,
                child: CommonBackButton()),
            Align(
                alignment: Alignment.bottomCenter,
                child: RatingSheet(booking: booking)
            )
          ],
        )
    );
  }
}
