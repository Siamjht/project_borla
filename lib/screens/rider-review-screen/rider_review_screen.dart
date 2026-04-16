
import 'package:flutter/material.dart';
import 'package:project_borla/bottom-sheets/rating_sheet.dart';
import 'package:project_borla/screens/map-screens/user_common_map.dart';

import '../../role/components/commonBackButton/common_back_button.dart';
import '../../role/garbageCollector/map/driver_common_map.dart';

class RiderReviewScreen extends StatelessWidget {
  const RiderReviewScreen({super.key});

  void ShowRiderReviewSheet (BuildContext context) {

    showModalBottomSheet(

      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      //showDragHandle: true,
      useSafeArea: true,
      builder: (context) => RatingSheet(),

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
                child:RatingSheet()
            )
          ],
        )
    );
  }
}