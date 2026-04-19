import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/controllers/user-controllers/booking_controller.dart';

import '../../gen/custom_assets/assets.gen.dart';
import '../../helpers/other_helper.dart';
import '../../role/components/searchPlaces/address_search_field.dart';
import '../../theme/app_color.dart';
import '../custom_text_field.dart';
import '../gradient_button.dart';

class AddPlaceTextFields extends StatelessWidget {
  const AddPlaceTextFields({super.key});

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
          hint: 'Enter place title',
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
          hint: 'Enter place name',
          prefix: Image.asset('assets/images/second_pin_2.png' , scale: 3.5,),
        ),

        const SizedBox(height: 14),

        Text('Address', style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14
        ),),

        const SizedBox(height: 6),

        AddressSearchField(
          paddingVertical: 18,
          hintText: 'enter_location_hint'.tr,
          controller:  bookingCtrl.placeAddressController,
          textInputAction: TextInputAction.done,
          fillColor: Colors.white,
          borderColor: const Color(0xFFE5E7EB),
          hintTextColor: AppColors.gray400,
          textColor: AppColors.black500,
          borderRadius: 12,
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Assets.icons.locationPointer.image(height: 18, width: 18, color: AppColors.orange500),
          ),
          onSelected: (suggestion) async {
            final latLang = await OtherHelper.getCoordinatesFromAddress(suggestion.description);
            log("LatLang $latLang");
            if(latLang != null){
              bookingCtrl.savedPlaceLat = latLang.latitude;
              bookingCtrl.savedPlaceLang = latLang.longitude;
            }
          },),

        const SizedBox(height: 48),

        GradientButton(
          text: 'Save Place',
          isLoading: bookingCtrl.isAddLoading,
          onPressed: () async {
            await bookingCtrl.addPlace(
              placeType: bookingCtrl.selectedPlaceType.value,
              placeTitle: bookingCtrl.placeTitleController.text.trim(),
              placeName: bookingCtrl.placeNameController.text.trim(),
              address: bookingCtrl.placeAddressController.text.trim(),
              latitude: bookingCtrl.savedPlaceLat,
              longitude: bookingCtrl.savedPlaceLang,
            );
            Get.back();
          },
        ),

      ],
    );
  }
}
