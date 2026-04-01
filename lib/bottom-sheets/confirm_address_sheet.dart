import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project_borla/controllers/user-controllers/booking_controller.dart';

import '../screens/waste-screens/waste_category_screen.dart';
import '../widgets/gradient_button.dart';

class ConfirmAddressSheet extends StatefulWidget {
  const ConfirmAddressSheet({super.key});

  @override
  State<ConfirmAddressSheet> createState() => _ConfirmAddressSheetState();
}

class _ConfirmAddressSheetState extends State<ConfirmAddressSheet> {

  final _bookingCtrl = Get.find<BookingController>();


  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),

        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 12),

            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            const SizedBox(height: 16),


            Text('Confirm Address...', style: TextStyle(

                fontSize: 22,

                fontWeight: FontWeight.w500

            ),),

            //const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.fromLTRB(22,0,22,0),
              child: Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ),
            ),

            //const SizedBox(height: 16),


            Padding(
              padding: const EdgeInsets.fromLTRB(22,6,22,6),
              child: Row(

                children: [

                  Image.asset('assets/images/location_pin_two.png', scale: 0.8,),

                  SizedBox(width: 14,),

                  Text('Location', style: TextStyle(

                    fontSize: 18,
                    fontWeight: FontWeight.w500,


                  ),),
                  //Spacer(),

                  //Image.asset('assets/images/add_button.png'),


                ],


              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(_bookingCtrl.currentLocationController.text, style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),),
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GradientButton(
                text: 'Confirm Location',
                onPressed: () {
                  //Get.to(OtpScreen());
                  Get.to(()=> WasteCategoryScreen());
                },
              ),
            ),

          ],
        )

    );
  }
}
