
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/components/button/common_button.dart';
import 'package:project_borla/role/components/custom_container.dart';
import 'package:project_borla/role/components/text/common_text.dart';
import 'package:project_borla/role/garbageCollector/home/arrived_screen.dart';
import 'package:project_borla/theme/app_color.dart';

import '../../../gen/custom_assets/assets.gen.dart';
import '../../components/commonBackButton/common_back_button.dart';
import '../map/driver_common_map.dart';
import 'innerWidget/arrived_bottom_sheet.dart';

class NavigateDestinationScreen extends StatelessWidget {
  const NavigateDestinationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Google Map
          Positioned.fill(child: DriverCommonMap()),

          Positioned(
            top: 60,
            left: 20,
            child: CommonBackButton(),
          ),


          Positioned(
            bottom: 120,
            left: 30,
            right: 30,
            child: CustomContainer(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                borderRadius: 8,
                child: Row(
              children: [
                CustomContainer(
                  padding: EdgeInsets.all(8),
                  borderRadius: 100,
                  color: AppColors.green50,
                    child: Center(child: Assets.icons.locationPointer.image(height: 20, width: 20))),
                SizedBox(width: 12,),
                Expanded(
                    child: CommonText(
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w400,
                        text: "85 4th Ave, Street Side Road, NY 10003, Accra, Ghana"
                    )
                )
              ],
            )),
          ),

          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: CommonButton(
              onTap: () {
                Get.to(()=> ArrivedScreen());
              },
              titleText: "Navigate to Destination",
              buttonRadius: 12,
            ),
          )
        ],
      ),
    );
  }
}
