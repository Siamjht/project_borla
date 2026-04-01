import 'package:flutter/material.dart';
import 'package:project_borla/screens/ride-schedule-screens/ride_schedule_sheet.dart';

import '../../role/components/commonBackButton/common_back_button.dart';
import '../../role/garbageCollector/map/driver_common_map.dart';

class RideScheduleScreen extends StatelessWidget {
  const RideScheduleScreen({super.key});

  void ShowRideScheduleSheet (BuildContext context) {

    showModalBottomSheet(

      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      //showDragHandle: true,
      useSafeArea: true,
      builder: (context) => RideScheduleSheet(),

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
              child: RideScheduleSheet(),
            )

          ],
        )
    );
  }
}
