import 'package:flutter/material.dart';
import 'package:project_borla/models/userModels/bookingModels/user_booking_model.dart';
import 'package:project_borla/screens/booking-accepted-screen/relatedWidgets/booking_accepted_sheet.dart';
import 'package:project_borla/screens/map-screens/user_common_map.dart';

import '../../role/components/commonBackButton/common_back_button.dart';


class BookingAcceptedScreen extends StatelessWidget {
  final UserBookingModel booking;

  const BookingAcceptedScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned.fill(child: UserCommonMap(booking: booking)),
            Positioned(
                left: 20,
                top: 60,
                child: CommonBackButton()),
            Align(
                alignment: Alignment.bottomCenter,
                child: BookingAcceptedSheet(booking: booking))
          ],
        )
    );
  }
}
