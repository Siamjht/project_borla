import 'package:flutter/material.dart';
import 'package:project_borla/models/userModels/bookingModels/user_booking_model.dart';
import 'package:project_borla/screens/reject-rider-screens/reject_rider_sheet.dart';

import '../../role/components/commonBackButton/common_back_button.dart';
import '../../role/garbageCollector/map/driver_common_map.dart';

class RejectRiderScreen extends StatefulWidget {
  UserBookingModel booking;
  RejectRiderScreen({super.key, required this.booking});

  @override
  State<RejectRiderScreen> createState() => _RejectRiderScreenState();
}

class _RejectRiderScreenState extends State<RejectRiderScreen> {

  void ShowRejectRiderSheet (BuildContext context) {

    showModalBottomSheet(

      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      //showDragHandle: true,
      useSafeArea: true,
      builder: (context) => RejectRiderSheet(booking: widget.booking,),

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
                child:RejectRiderSheet(booking: widget.booking,)
            )
          ],
        )
    );
  }
}
