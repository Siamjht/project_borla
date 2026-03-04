
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phone_form_field/phone_form_field.dart';

Widget userPhoneTextFormField({required PhoneController controller,}) {
  return PhoneFormField(

    //validator: validator,
    controller: controller,
    // initialValue: PhoneNumber.parse('+233'),
    // initialCountryCode: 'GH',
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.transparent,
      hintText: 'enter_phone_number'.tr,
      hintStyle: TextStyle(color: Colors.grey[500]),
      contentPadding: EdgeInsets.symmetric(
          vertical: 14, horizontal: 16.w),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: Color(0xFF4CAF50),
            width: 2),
      ),
    ),
    countryButtonStyle: const CountryButtonStyle(
      showFlag: true,
      showDialCode: true,
      showIsoCode: false,
      flagSize: 20,
    ),
  );
}


Widget driverPhoneTextFormField() {
  return PhoneFormField(

    //controller: controller,
    initialValue: PhoneNumber.parse('+233'),
    //initialCountryCode: 'GH',
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.transparent,
      hintText: 'enter_phone_number'.tr,
      hintStyle: TextStyle(color: Colors.grey[500]),
      contentPadding: EdgeInsets.symmetric(
          vertical: 16.h, horizontal: 16.w),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: Color(0xFF4CAF50),
            width: 2),
      ),
    ),
    countryButtonStyle: const CountryButtonStyle(
      showFlag: true,
      showDialCode: true,
      showIsoCode: false,
      flagSize: 20,
    ),
  );
}