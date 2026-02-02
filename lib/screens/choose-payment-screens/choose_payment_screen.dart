import 'package:flutter/material.dart';
import 'package:project_borla/bottom-sheets/payment_sheet.dart';
import 'package:project_borla/role/components/commonBackButton/common_back_button.dart';

import '../../role/garbageCollector/map/common_map.dart';

class ChoosePaymentScreen extends StatefulWidget {
  const ChoosePaymentScreen({super.key});

  @override
  State<ChoosePaymentScreen> createState() => _ChoosePaymentScreenState();
}

class _ChoosePaymentScreenState extends State<ChoosePaymentScreen> {

  void ShowPaymentSheet (BuildContext context) {

    showModalBottomSheet(

      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      //showDragHandle: true,
      useSafeArea: true,
      builder: (context) => PaymentSheet(),

    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned.fill(child: CommonMap()),

            Positioned(
              left: 20,
                top: 60,
                child: CommonBackButton()),

            Align(
              alignment: Alignment.bottomCenter,
              child: PaymentSheet(),
            )
          ],
        )
    );
  }
}
