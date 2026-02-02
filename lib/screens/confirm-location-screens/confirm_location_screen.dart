import 'package:flutter/material.dart';
import 'package:project_borla/role/components/commonBackButton/common_back_button.dart';


import 'package:project_borla/role/garbageCollector/map/common_map.dart';
import 'package:get/get.dart';

import '../../bottom-sheets/confirm_address_sheet.dart';
import '../../role/garbageCollector/home/controller/driver_home_controller.dart';

class ConfirmLocationScreen extends StatefulWidget {
  const ConfirmLocationScreen({super.key});

  @override
  State<ConfirmLocationScreen> createState() => _ConfirmLocationScreenState();
}

class _ConfirmLocationScreenState extends State<ConfirmLocationScreen> {
  //
  // final DriverHomeController controller =
  // Get.put(DriverHomeController());

  // void ShowConfirmAddressSheet (BuildContext context) {
  //
  //   showModalBottomSheet(
  //
  //     context: context,
  //     barrierColor: Colors.transparent,
  //     backgroundColor: Colors.transparent,
  //     isScrollControlled: true,
  //     //showDragHandle: true,
  //     useSafeArea: true,
  //     builder: (context) => ConfirmAddressSheet(),
  //
  //   );
  //
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Future.microtask(() {
  //     ShowConfirmAddressSheet(context);
  //   },);
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: CommonMap()),
          Positioned(
            top: 60,
              left: 20,
              child: Container(
                width: 38,
                height: 38,
                decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                      color: Colors.black.withAlpha(40),
                    ),
                  ],
                ),

                child: IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 22,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: ConfirmAddressSheet()
          )
        ],
      )
    );
  }
}
