import 'package:flutter/material.dart';
import 'package:project_borla/role/garbageCollector/map/driver_common_map.dart';
import 'package:get/get.dart';

import '../../bottom-sheets/confirm_address_sheet.dart';

class ConfirmLocationScreen extends StatefulWidget {
  const ConfirmLocationScreen({super.key});

  @override
  State<ConfirmLocationScreen> createState() => _ConfirmLocationScreenState();
}

class _ConfirmLocationScreenState extends State<ConfirmLocationScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: DriverCommonMap()),
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
