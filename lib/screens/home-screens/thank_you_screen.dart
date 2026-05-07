import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/bottom-sheets/choose_ride_sheet.dart';
import 'package:project_borla/bottom-sheets/current_location_sheet.dart';
import 'package:project_borla/bottom-sheets/search_location_sheet.dart';
import 'package:project_borla/screens/home-screens/user_nav_bar.dart';

import '../../bottom-sheets/payment_sheet.dart';
import '../../bottom-sheets/rating_sheet.dart';
import '../../widgets/gradient_button.dart';

class ThankYouScreen extends StatefulWidget {
  const ThankYouScreen({super.key});

  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {

  void ShowSearchLocationSheet (BuildContext context) {

    showModalBottomSheet(

        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        //showDragHandle: true,
        useSafeArea: true,
        builder: (context) => SearchLocationSheet(),

    );

  }

  void ShowCurrentLocationSheet (BuildContext context) {

    showModalBottomSheet(

      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      //showDragHandle: true,
      useSafeArea: true,
      builder: (context) => CurrentLocationSheet(),

    );

  }

  // void ShowRatingSheet (BuildContext context) {
  //
  //   showModalBottomSheet(
  //
  //     context: context,
  //     backgroundColor: Colors.transparent,
  //     isScrollControlled: true,
  //     //showDragHandle: true,
  //     useSafeArea: true,
  //     builder: (context) => RatingSheet(),
  //
  //   );
  //
  // }

  void ShowChooseRideSheet (BuildContext context) {

    showModalBottomSheet(

      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      //showDragHandle: true,
      useSafeArea: true,
      builder: (context) => ChooseRideSheet(),

    );

  }

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

  final navbarController = Get.find<UserNavBarController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: const LinearGradient(

            begin: Alignment.topLeft,
            end: Alignment.bottomRight ,
            colors: [
              Color.fromRGBO(255, 246, 217, 1),
              Color.fromRGBO(255, 255, 255, 1),
            ],
          ),
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Padding(
              padding:  const EdgeInsets.fromLTRB(20, 240, 20, 20),
              
              child: Image.asset('assets/images/thanks_2.png', scale: 2,),

            ),

           Text('thank_you_review'.tr, style: TextStyle(             fontSize: 24,
             fontWeight: FontWeight.w600,
             color: Colors.grey.shade700
           ),),

            SizedBox(height: 16,),

            Text("review_subtitle".tr, style: TextStyle(                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade500
            ),),
           Padding(
              padding:  EdgeInsets.fromLTRB(20,140,20,0),
              child: GradientButton(
                text: 'back_to_home'.tr,
                onPressed: () {
                  navbarController.tabIndex.value =0 ;
                  Get.offAll(UserNavBar());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

