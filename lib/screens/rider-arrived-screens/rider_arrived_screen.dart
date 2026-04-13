import 'package:flutter/material.dart';
import 'package:project_borla/screens/map-screens/user_common_map.dart';
import 'package:project_borla/screens/rider-arrived-screens/rider_arrived_sheet.dart';
import '../../role/components/commonBackButton/common_back_button.dart';


class RiderArrivedScreen extends StatelessWidget {
  const RiderArrivedScreen({super.key});

  void ShowRiderArrivedSheet (BuildContext context) {

    showModalBottomSheet(

      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      //showDragHandle: true,
      useSafeArea: true,
      builder: (context) => RiderArrivedSheet(),

    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned.fill(child: UserCommonMap()),
            Positioned(
                left: 20,
                top: 60,
                child: CommonBackButton()),
            Align(
                alignment: Alignment.bottomCenter,
                child: RiderArrivedSheet()
            )
          ],
        )
    );
  }
}
