import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project_borla/models/userModels/bookingModels/user_booking_model.dart';

import '../../screens/choose-ride-screens/choose_ride_screen.dart';
import '../../screens/rider-arrived-screens/rider_arrived_screen.dart';

class RejectRiderSheetButtons extends StatelessWidget {
  UserBookingModel booking;
  RejectRiderSheetButtons({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Row(

      mainAxisAlignment: MainAxisAlignment.spaceAround,

      children: [

        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(255, 214, 0, 1),
                Color.fromRGBO(255,149,0, 1),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(2), // border thickness
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(100, 50),
              backgroundColor: Colors.white, // white button
              shadowColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14), // inner radius
              ),
            ),
            onPressed: () {
              Get.to(()=> RiderArrivedScreen(booking: booking,));
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(40, 14,40, 14),

              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    Color.fromRGBO(255, 214, 0, 1),
                    Color.fromRGBO(255,149,0, 1),
                  ],
                ).createShader(bounds),
                child: Text(
                  'Back',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 17
                  ),
                ),
              ),
            ),
          ),
        ),

        ElevatedButton(
          onPressed: () {
            Get.to(()=>ChooseRideScreen());
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero, // important
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            minimumSize: const Size(100, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(255, 214, 0, 1),
                  Color.fromRGBO(255,149,0, 1),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(23, 16, 23, 16),
              child: const Text(
                'Find Another One',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17
                  //fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        )

      ],

    );
  }
}