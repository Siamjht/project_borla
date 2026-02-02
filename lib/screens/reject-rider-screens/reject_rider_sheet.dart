import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project_borla/screens/choose-ride-screens/choose_ride_screen.dart';
import 'package:project_borla/screens/home-screens/user_nav_bar.dart';
import 'package:project_borla/screens/rider-arrived-screens/rider_arrived_screen.dart';
import 'package:project_borla/theme/app_color.dart';

import '../../widgets/gradient_button.dart';
import '../../widgets/reject-rider-sheet-widget/reject_rider_sheet_buttons.dart';

class RejectRiderSheet extends StatefulWidget {
  const RejectRiderSheet({super.key});

  @override
  State<RejectRiderSheet> createState() => _RejectRiderSheetState();
}

class _RejectRiderSheetState extends State<RejectRiderSheet> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,

      children: [

        Container(
            height: 340,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),

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

                const SizedBox(height: 46),


                Text('Your Borla has been rejected', style: TextStyle(

                    fontSize: 22,

                    fontWeight: FontWeight.w500

                ),),

                Padding(
                  padding: const EdgeInsets.fromLTRB(22,0,22,0),
                  child: Divider(
                    color: Colors.grey.shade300,
                    thickness: 1,
                  ),
                ),

                Text("We're sorry, your booking request was", style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.gray300
                ),),

                Text("rejected by the driver. This may be due to a",style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.gray300
                ),),

                Text("change in plans.", style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.gray300
                ),),

                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: RejectRiderSheetButtons(),
                ),

              ],
            )

        ),
        Positioned(
          height: 90,
            width: 90,
            top: -50,
            right: 160,
            child: Image.asset('assets/images/user_cross_2.png', scale: 6.3,)
        ),
      ],
    );
  }
}


