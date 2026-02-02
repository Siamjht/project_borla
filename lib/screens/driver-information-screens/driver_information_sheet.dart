import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project_borla/role/garbageCollector/call/outgoing_call_screen.dart';
import 'package:project_borla/screens/chat-screen/chat_screen_copy.dart';
import 'package:project_borla/screens/ride-schedule-screens/ride_schedule_screen.dart';
import 'package:project_borla/theme/app_color.dart';

import '../../gen/custom_assets/assets.gen.dart';
import '../../widgets/driver-info-sheet-widgets/driver_info_row.dart';
import '../../widgets/driver-info-sheet-widgets/driver_info_sheet_buttons.dart';

class DriverInformationSheet extends StatefulWidget {
  const DriverInformationSheet({super.key});

  @override
  State<DriverInformationSheet> createState() => _DriverInformationSheetState();
}

class _DriverInformationSheetState extends State<DriverInformationSheet> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,

      children: [

        Container(
            height: 520,
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

                const SizedBox(height: 26),

                Text('Rider Information', style: TextStyle(

                    fontSize: 22,

                    fontWeight: FontWeight.w500

                ),),

                Padding(
                  padding: const EdgeInsets.fromLTRB(22,8,22,0),
                  child: Divider(
                    color: AppColors.gray200,
                    thickness: 1,
                  ),
                ),

                const SizedBox(height: 22),

                Container(
                padding: const EdgeInsets.all(3), // border thickness
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.amber,
                    width: 3,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/emptyProfile.png'),
                ),
              ),

                SizedBox(height: 8,),

                Text('McKenna Thomas', style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 21,
                  fontWeight: FontWeight.w600
              )),

                SizedBox(height: 22,),

                driverSheetInfo(),

                SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DriverInfoSheetButtons(),
                ),

              ],
            )
        ),
      ],
    );
  }
}




