import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project_borla/theme/app_color.dart';
import '../../role/components/commonBackButton/common_back_button.dart';
import '../../role/garbageCollector/map/driver_common_map.dart';
import '../../widgets/gradient_button.dart';
import '../rider-review-screen/rider_review_screen.dart';

class PaymentSuccessScreeen extends StatefulWidget {
  const PaymentSuccessScreeen({super.key});

  @override
  State<PaymentSuccessScreeen> createState() => _PaymentSuccessScreeenState();
}

class _PaymentSuccessScreeenState extends State<PaymentSuccessScreeen> {


  @override
  void initState() {
    super.initState();


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
          ],
        )
    );
  }
}
