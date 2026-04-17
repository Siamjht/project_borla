
import 'package:flutter/material.dart';

import '../../../models/riderModels/bookingModels/rider_booking_model.dart';
import '../../components/commonBackButton/common_back_button.dart';
import '../map/driver_common_map.dart';
import 'innerWidget/arrived_bottom_sheet.dart';

class PaymentReceiveScreen extends StatelessWidget {
  RiderBookingModel bookingModel;
  PaymentReceiveScreen({super.key, required this.bookingModel});


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

          /// BottomSheet
          Align(
            alignment: Alignment.bottomCenter,
            child: ArrivedBottomSheet(booking: bookingModel, isPaymentReceive: true,),
          ),

        ],
      ),
    );
  }
}