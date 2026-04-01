
import 'package:flutter/material.dart';
import '../../components/commonBackButton/common_back_button.dart';
import '../map/driver_common_map.dart';
import 'innerWidget/arrived_bottom_sheet.dart';

class ArrivedScreen extends StatelessWidget {
  const ArrivedScreen({super.key});


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
            child: ArrivedBottomSheet(),
          ),

        ],
      ),
    );
  }
}
