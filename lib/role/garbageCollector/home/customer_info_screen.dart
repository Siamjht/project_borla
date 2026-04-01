
import 'package:flutter/material.dart';
import 'package:project_borla/role/components/commonBackButton/common_back_button.dart';
import 'package:project_borla/role/garbageCollector/home/innerWidget/customer_info_bottom_sheet.dart';
import 'package:project_borla/role/garbageCollector/map/driver_common_map.dart';

class CustomerInfoScreen extends StatelessWidget {
  const CustomerInfoScreen({super.key});

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
          const Align(
            alignment: Alignment.bottomCenter,
            child: CustomerInfoBottomSheet(),
          ),
        ],
      ),
    );
  }
}
