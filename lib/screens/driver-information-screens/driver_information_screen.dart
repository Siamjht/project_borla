import 'package:flutter/material.dart';
import 'package:project_borla/screens/driver-information-screens/driver_information_sheet.dart';

import '../../bottom-sheets/choose_ride_sheet.dart';
import '../../role/components/commonBackButton/common_back_button.dart';
import '../../role/garbageCollector/map/driver_common_map.dart';

class DriverInformationScreen extends StatelessWidget {
  const DriverInformationScreen({super.key});

  void ShowDriverInfoSheet (BuildContext context) {

    showModalBottomSheet(

      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      //showDragHandle: true,
      useSafeArea: true,
      builder: (context) => DriverInformationSheet(),

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
                child:DriverInformationSheet()
            )
          ],
        )
    );
  }
}
