import 'package:flutter/material.dart';
import 'package:project_borla/bottom-sheets/finding_rider_sheet.dart';


import 'package:project_borla/role/garbageCollector/map/driver_common_map.dart';
import 'package:get/get.dart';

import '../../bottom-sheets/confirm_address_sheet.dart';
import '../../role/components/commonBackButton/common_back_button.dart';
import '../../role/garbageCollector/home/controller/driver_home_controller.dart';

class FindingDriverScreen extends StatefulWidget {
  const FindingDriverScreen({super.key});

  @override
  State<FindingDriverScreen> createState() => _FindingDriverScreenState();
}

class _FindingDriverScreenState extends State<FindingDriverScreen> {

  // final DriverHomeController controller =
  // Get.put(DriverHomeController());

  void ShowFindingRiderSheet (BuildContext context) {

    showModalBottomSheet(

      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      //showDragHandle: true,
      useSafeArea: true,
      builder: (context) => FindingRiderSheet(),

    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned.fill(child: DriverCommonMap()),

            Positioned(
                left: 20,
                top: 60,
                child: CommonBackButton()),

            Align(
                alignment: Alignment.bottomCenter,
                child:FindingRiderSheet()
            )

          ],
        )
    );
  }
}
