import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project_borla/theme/app_color.dart';
import '../../role/components/commonBackButton/common_back_button.dart';
import '../../role/garbageCollector/map/common_map.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.dialog(
        barrierDismissible: false,
        AlertDialog(

          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: AppColors.white,
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            width: Get.width,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 24,),

                      Image.asset('assets/images/wave_tick_amber.png', scale: 0.2, height: 85, width: 85,),

                      SizedBox(height: 24,),

                      Text('Payment Success', style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                      ), ),

                      SizedBox(height: 20,),

                      Text("Your money has been successfully", style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w400
                      ), ),

                      //SizedBox(height: 30,),

                      Text("sent to Sergio Ramasis", style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w400
                      ), ),



                      SizedBox(height: 24,),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                        child: GradientButton(
                          text: 'Please Feedback',
                          onPressed: () {
                            Get.to(()=> RiderReviewScreen());
                          },
                        ),
                      ),



                    ],
                  ),
                ),

                Positioned(
                  top: 2,
                    left: 4,
                    child:
                        Image.asset('assets/images/amber_left_2.png',scale: 4,),
                        // SizedBox(width: 140,),
                        // Image.asset('assets/images/amber_right.png',scale: 5,),
                ),

                Positioned(
                  top: 1,
                  right: 4,
                  child:
                  //Image.asset('assets/images/amber_left.png',scale: 3,),
                  // SizedBox(width: 140,),
                  Image.asset('assets/images/amber_right_2.png',scale: 4,),
                ),

              ],
            ),
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
            Positioned.fill(child: CommonMap()),
            Positioned(
                left: 20,
                top: 60,
                child: CommonBackButton()),
          ],
        )
    );
  }
}
