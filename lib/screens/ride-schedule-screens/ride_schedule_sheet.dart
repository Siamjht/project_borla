import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project_borla/screens/home-screens/user_nav_bar.dart';
import 'package:project_borla/screens/payment-success-screens/payment_success_screeen.dart';

import '../../widgets/gradient_button.dart';
import '../rider-searching-screen/rider_searching_screen.dart';

class RideScheduleSheet extends StatefulWidget {
  const RideScheduleSheet({super.key});

  @override
  State<RideScheduleSheet> createState() => _RideScheduleSheetState();
}

class _RideScheduleSheetState extends State<RideScheduleSheet> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,

      children: [

        Container(
            height: 400,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),

            child: Column(

              children: [

                const SizedBox(height: 14),

                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                const SizedBox(height: 56),


                Text('Ride Scheduled!', style: TextStyle(

                    fontSize: 26,

                    fontWeight: FontWeight.w600

                ),),




                Padding(
                  padding: const EdgeInsets.fromLTRB(22,8,22,0),
                  child: Divider(
                    color: Colors.grey.shade300,
                    thickness: 1,
                  ),
                ),

                const SizedBox(height: 22),



                SizedBox(height: 8,),

                Text('Monday, Dec 23 - 16:00 PM', style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 23,
                    fontWeight: FontWeight.w500
                )),

                SizedBox(height: 22,),

                Text('You can see scheduled rides in the activity menu', style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                )),



                SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: GradientButton(
                    text: 'Got It',
                    onPressed: () {
                      // Get.to(()=> PaymentSuccessScreeen());
                      Get.offAll(()=> UserNavBar());
                    },
                  ),
                ),

              ],
            )


        ),
        Positioned(
            height: 90,
            width: 90,
            top: -50,
            right: 160,
            child: Image.asset('assets/images/calender_icon_2.png', scale: 6.2,)
        ),
      ],
    );
  }
}
