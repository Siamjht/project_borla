
import 'package:flutter/material.dart';


import '../../../../role/components/commonBackButton/common_back_button.dart';
import '../../../../theme/common_back_button_copy.dart';
import '../../../map-screens/common_map_copy.dart';
import 'customer_info_bottom_sheet_copy.dart';

class CustomerInfoScreen extends StatelessWidget {
  const CustomerInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Google Map
          Positioned.fill(child: UserCommonMap()),

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