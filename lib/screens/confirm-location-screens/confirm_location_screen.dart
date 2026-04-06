import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../bottom-sheets/confirm_address_sheet.dart';
import '../../controllers/mapController/user_map_controller.dart';
import '../map-screens/user_common_map.dart';

class ConfirmLocationScreen extends StatefulWidget {
  const ConfirmLocationScreen({super.key});

  @override
  State<ConfirmLocationScreen> createState() => _ConfirmLocationScreenState();
}

class _ConfirmLocationScreenState extends State<ConfirmLocationScreen> {

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) UserMapController.instance.onConfirmLocationPopped();
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(child: UserCommonMap()),
            Positioned(
              top: 60,
              left: 20,
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
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
                  onPressed: () => Get.back(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ConfirmAddressSheet(),
            )
          ],
        ),
      ),
    );
  }
}
