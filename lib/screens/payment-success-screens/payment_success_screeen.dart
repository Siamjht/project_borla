import 'package:flutter/material.dart';
import 'package:project_borla/screens/map-screens/user_common_map.dart';
import '../../models/userModels/bookingModels/user_booking_model.dart';
import '../../role/components/commonBackButton/common_back_button.dart';
import '../rider-arrived-screens/rider_arrived_sheet.dart';


class PaymentSuccessScreen extends StatelessWidget {
  UserBookingModel booking;
  PaymentSuccessScreen({super.key,  required this.booking});

  void ShowRiderArrivedSheet (BuildContext context) {

    showModalBottomSheet(

      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      //showDragHandle: true,
      useSafeArea: true,
      builder: (context) => RiderArrivedSheet(booking: booking,),

    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned.fill(child: UserCommonMap(booking: booking,)),
            Positioned(
                left: 20,
                top: 60,
                child: CommonBackButton()),
            Align(
                alignment: Alignment.bottomCenter,
                child: RiderArrivedSheet(booking: booking,)
            )
          ],
        )
    );
  }
}
