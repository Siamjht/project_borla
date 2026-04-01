import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/controllers/user-controllers/booking_controller.dart';

import '../custom_text_field.dart';
import '../gradient_button.dart';

class SavedPlaceTextFields extends StatelessWidget {
  const SavedPlaceTextFields({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingCtrl = Get.find<BookingController>();

    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        const SizedBox(height: 6),

        Text('Place Title', style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14
        ),),

        const SizedBox(height: 6),

        CustomTextField(
          controller: bookingCtrl.placeTitleController,
          hint: 'Hotel',
          prefix: Image.asset('assets/images/second_pin_2.png', scale: 3.5,),
        ),

        const SizedBox(height: 14),

        Text('Place Name', style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14
        ),),

        const SizedBox(height: 6),

        CustomTextField(
          controller: bookingCtrl.placeNameController,
          hint: 'Chittagong, Ghana',
          prefix: Image.asset('assets/images/second_pin_2.png' , scale: 3.5,),
        ),

        const SizedBox(height: 14),

        Text('Address', style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14
        ),),

        const SizedBox(height: 6),

        CustomTextField(
          controller: bookingCtrl.placeAddressController,
          hint: 'Studio 08 Jake Stream',
          prefix: Image.asset('assets/images/third_pin.png'),
          suffix: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              padding: const EdgeInsets.all(2),
              margin: EdgeInsets.fromLTRB(2, 2, 14, 2),
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(6)
              ),
              child: Image.asset('assets/images/target_2.png', scale: 5.3, color: Colors.white,) ,
            ),
          ),
        ),

        const SizedBox(height: 48),

        GradientButton(
          text: 'Save',
          isLoading: bookingCtrl.isUpdateLoading,
          onPressed: () async {
            await bookingCtrl.saveOrUpdatePlace();
            Get.back();
          },
        ),

      ],
    );
  }
}
