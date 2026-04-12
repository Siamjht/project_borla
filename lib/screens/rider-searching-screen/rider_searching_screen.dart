import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project_borla/controllers/user-controllers/booking_controller.dart';
import 'package:project_borla/screens/booking-requested-screen/booking_requested_screen.dart';
import 'package:project_borla/screens/map-screens/user_common_map.dart';
import 'package:project_borla/theme/app_color.dart';

import '../../gen/custom_assets/assets.gen.dart';
import '../../role/components/commonBackButton/common_back_button.dart';
import '../../role/garbageCollector/map/driver_common_map.dart';

class RiderSearchingScreen extends StatefulWidget {
  const RiderSearchingScreen({super.key});

  @override
  State<RiderSearchingScreen> createState() => _RiderSearchingScreenState();
}

class _RiderSearchingScreenState extends State<RiderSearchingScreen> {

  final _bookingCtrl = Get.find<BookingController>();


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.dialog(
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: AppColors.white,
          contentPadding: EdgeInsets.zero,
          content: Stack(
            children: [
              SizedBox(
                height: 160,
                width: 282.w,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 30,),
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: CircularProgressIndicator(
                          strokeWidth: 6,
                          color: AppColors.orange300,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text('Processing...', style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                      ),)
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  child: Assets.images.patternLeft.image(color: AppColors.orange300)),
              Positioned(
                  top: 0,
                  right: 0,
                  child: Assets.images.patternRight.image(color: AppColors.orange300))
            ],
          )
        ),
      );
    });
    Future.microtask(() async {
      final isSuccess = await _bookingCtrl.createBooking();
      if(isSuccess){
        Get.to(() => const BookingRequestedScreen());
      }
    },);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned.fill(child: UserCommonMap()),
            Positioned(
                left: 20,
                top: 60,
                child: CommonBackButton()),
          ],
        )
    );
  }
}
