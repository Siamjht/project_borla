import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../screens/scheduled-screens/schedule-ride-screen-with-sheet/schedule_ride_with_bottom_screen.dart';

class DeleteSheetButtons extends StatelessWidget {
  const DeleteSheetButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(

      mainAxisAlignment: MainAxisAlignment.spaceAround,

      children: [

        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
          child: Container(
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
                //Get.to(()=> OnboardingTwo());
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(40, 14, 40, 14),

                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 214, 0, 1),
                      Color.fromRGBO(255,149,0, 1),
                    ],
                  ).createShader(bounds),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),


        Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
          child: ElevatedButton(
            onPressed: () {
              //Get.to(()=> ScheduleRideWithBottomScreen());
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
                padding: const EdgeInsets.fromLTRB(50, 16, 50, 16),
                child: const Text(
                  'Yes, Delete',
                  style: TextStyle(
                    color: Colors.white,
                    //fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        )
      ],

    );
  }
}

// Padding(
//   padding: const EdgeInsets.fromLTRB(22,6,22,6),
//   child: Row(
//
//     children: [
//
//       Image.asset('assets/images/location_pin_two.png', scale: 0.8,),
//
//       SizedBox(width: 8,),
//
//       Text('Location', style: TextStyle(
//
//         fontSize: 18,
//         fontWeight: FontWeight.w500,
//       ),),
//       Spacer(),
//
//       //Image.asset('assets/images/add_button.png'),
//     ],
//   ),
// ),
//
// Text('1901 Thornridge Cir. Shiloh, Hawaii 81063 ', style: TextStyle(
//     fontSize: 15,
//     fontWeight: FontWeight.w600,
//     color: Colors.grey
// ),),
// Padding(
//   padding: const EdgeInsets.all(22.0),
//   child: GradientButton(
//     text: 'Confirm Location',
//     onPressed: () {
//       //Get.to(OtpScreen());
//       //Get.to(()=>WasteCategoryScreen());
//     },
//   ),
// ),