import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project_borla/screens/booking-accepted-screen/booking_accepted_screen.dart';
import 'package:project_borla/theme/app_color.dart';
import 'package:project_borla/theme/common_button_copy.dart';
import '../../gen/custom_assets/assets.gen.dart';
import '../../role/components/commonBackButton/common_back_button.dart';
import '../../role/garbageCollector/map/driver_common_map.dart';
import '../../widgets/booking-requested-screen-widgets/booking_requested_button_widgets.dart';
import '../home-screens/user_nav_bar.dart';

class BookingRequestedScreen extends StatefulWidget {
  const BookingRequestedScreen({super.key});

  @override
  State<BookingRequestedScreen> createState() => _BookingRequestedScreenState();
}

class _BookingRequestedScreenState extends State<BookingRequestedScreen> {

  final navbarController = Get.put(UserNavBarController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.dialog(
        AlertDialog(

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: EdgeInsets.zero,
          backgroundColor: AppColors.white,
          content: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 30,),

                    Image.asset('assets/images/orange_tick_2.png', scale: 6.5,),

                    SizedBox(height: 24,),

                    Text('Booking Requested!', style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600
                    ), ),

                    SizedBox(height: 20,),

                    Text("We've received your request for your", style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500
                    ), ),

                    Text("Borla to be picked up. We'll let...", style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500
                    ), ),

                    SizedBox(height: 36,),

                    ViewRidesButton(navbarController: navbarController),

                    SizedBox( height: 15),

                    CommonButton(
                      titleText: "Back To Home",
                      titleColor: AppColors.orange500,
                      buttonRadius: 12,
                      borderColor: AppColors.orange500,
                      firstGradient: AppColors.transparent,
                      secondGradient: AppColors.transparent,
                      onTap: () {
                        navbarController.tabIndex.value = 0;
                        Get.to(()=>UserNavBar());
                        // Get.to(()=> BookingAcceptedScreen());
                      },
                    ),
                    // BackHomeButton(),

                    SizedBox( height: 20),
                  ],
                ),
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  child: Assets.images.leftPatterHighDense.image(color: AppColors.orange300, height: 100, width: 100)),
              Positioned(
                  top: 0,
                  right: 0,
                  child: Assets.images.rightPatternHighDense.image(color: AppColors.orange300,height: 100, width: 100))
            ],
          ),
        ),
      );
    });
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


