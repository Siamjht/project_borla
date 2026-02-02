import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project_borla/controllers/user-controllers/bottom-sheet-controllers/choose_payment_sheet_controllers.dart';
import 'package:project_borla/screens/driver-information-screens/driver_information_screen.dart';
import 'package:project_borla/screens/payment-success-screens/payment_success_screeen.dart';
import '../../role/components/text/common_text.dart';
import '../../role/garbageCollector/activity/controller/activity_controller.dart';
import '../../role/garbageCollector/call/outgoing_call_screen.dart';
import '../../role/garbageCollector/home/innerWidget/customer_info_bottom_sheet.dart';
import '../../theme/app_color.dart';
import '../../widgets/booking-accepted-sheet-widgets/user_section_widget.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/rider-arrived-sheet-widget/user_payment_row_widget.dart';
import '../chat-screen/chat_screen_copy.dart';
import '../choose-payment-screens/choose_payment_screen.dart';

class RiderArrivedSheet extends StatefulWidget {
  const RiderArrivedSheet({super.key});

  @override
  State<RiderArrivedSheet> createState() => _RiderArrivedSheetState();
}

class _RiderArrivedSheetState extends State<RiderArrivedSheet> {

  ChoosePaymentSheetControllers paymentController = Get.put(ChoosePaymentSheetControllers());

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,

      children: [

        Container(
            height: 500,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),

            child: Column(

              children: [

                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                const SizedBox(height: 46),

                Text('Rider Have Arrived', style: TextStyle(

                    fontSize: 22,

                    fontWeight: FontWeight.w500

                ),),

                Padding(
                  padding: const EdgeInsets.fromLTRB(22,0,22,0),
                  child: Divider(
                    color: Colors.grey.shade300,
                    thickness: 1,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20,8,20,8,),
                  child: userRowModClick(),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(22,0,22,0),
                  child: Divider(
                    color: Colors.grey.shade300,
                    thickness: 1,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: summarySection(),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(22,0,22,0),
                  child: Divider(
                    color: Colors.grey.shade300,
                    thickness: 1,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: userPaymentRow(),
                ),

                Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: GradientButton(
                    text: 'Pay Now',
                    onPressed: () {
                      Get.to(()=> PaymentSuccessScreeen());
                    },
                  ),
                ),
              ],
            )

        ),
        Positioned(
            height: 90,
            width: 90,
            top: -50,
            right: 160,
            child: Image.asset('assets/images/user_large_pin_2.png', scale: 6.4,)
        ),
      ],
    );
  }

}


