import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_borla/bottom-sheets/choose_ride_sheet.dart';

import '../../role/components/commonBackButton/common_back_button.dart';
import '../../role/garbageCollector/map/driver_common_map.dart';

class ChooseRideScreen extends StatefulWidget {
  const ChooseRideScreen({super.key});

  @override
  State<ChooseRideScreen> createState() => _ChooseRideScreenState();
}

class _ChooseRideScreenState extends State<ChooseRideScreen> {

  void ShowChooseRiderSheet (BuildContext context) {

    showModalBottomSheet(

      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      //showDragHandle: true,
      useSafeArea: true,
      builder: (context) => ChooseRideSheet(),

    );

  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Future.microtask(() {
  //     ShowChooseRiderSheet(context);
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
              child:ChooseRideSheet()
            )
          ],
        )
    );
  }
}
