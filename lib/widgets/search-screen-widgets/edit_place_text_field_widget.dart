import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/search-place-screens/search-address-controllers/location_search_controller.dart';
import '../custom_text_field.dart';
import '../gradient_button.dart';

class EditPlaceTextFields extends StatelessWidget {
  const EditPlaceTextFields({
    super.key,
    required this.editPlaceController,
  });

  final EditPlaceController editPlaceController;

  @override
  Widget build(BuildContext context) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        const SizedBox(height: 6),

        Text('place_title'.tr, style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14
        ),),

        const SizedBox(height: 6),

        CustomTextField(
          controller: editPlaceController.titleController,
          hint: 'hotel'.tr,
          prefix: Image.asset('assets/images/second_pin_2.png', scale: 3.5,),
        ),

        const SizedBox(height: 14),

        Text('place_name'.tr, style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14
        ),),

        const SizedBox(height: 6),

        CustomTextField(
          hint: 'enter_place_name_hint'.tr,
          prefix: Image.asset('assets/images/second_pin_2.png' , scale: 3.5,),
        ),

        const SizedBox(height: 14),

        Text('address'.tr, style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14
        ),),

        const SizedBox(height: 6),

        CustomTextField(
          hint: 'enter_location_hint'.tr,
          prefix: Image.asset('assets/images/third_pin.png'),
          suffix: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              padding: const EdgeInsets.all(2),
              //margin: EdgeInsets.all(2),
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
          text: 'save_place'.tr,
          onPressed: () {
            Navigator.pop(context);
            //Get.to(OtpScreen());
          },
        ),

      ],
    );
  }
}