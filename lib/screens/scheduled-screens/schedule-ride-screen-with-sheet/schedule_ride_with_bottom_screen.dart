import 'package:flutter/material.dart';
import 'package:project_borla/screens/scheduled-screens/schedule-ride-screen-with-sheet/schedule_ride_sheet.dart';

import '../../../role/components/commonBackButton/common_back_button.dart';
import '../../../role/garbageCollector/map/driver_common_map.dart';

class ScheduleRideWithBottomScreen extends StatefulWidget {
  const ScheduleRideWithBottomScreen({super.key});

  @override
  State<ScheduleRideWithBottomScreen> createState() => _ScheduleRideWithBottomScreenState();
}

class _ScheduleRideWithBottomScreenState extends State<ScheduleRideWithBottomScreen> {


  void ShowScheduleRideSheet (BuildContext context) {

    showModalBottomSheet(

      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      //showDragHandle: true,
      useSafeArea: true,
      builder: (context) => ScheduleRideSheet(),

    );

  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Future.microtask(() {
  //     ShowScheduleRideSheet(context);
  //   },);
  //
  // }




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
                child: ScheduleRideSheet()
            )
          ],
        )
    );
  }
}
