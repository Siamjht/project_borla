import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_borla/controllers/profileController/profile_controller.dart';
import 'package:project_borla/helpers/other_helper.dart';
import 'package:project_borla/role/components/image/shimmer_image_loader.dart';
import '../../../../gen/custom_assets/assets.gen.dart';
import '../../../../theme/app_color.dart';
import '../../../components/commonTextField/common_text_field.dart';
import '../../../components/searchPlaces/address_search_field.dart';
import '../../../components/text/common_text.dart';

Widget profileItems(BuildContext context, ProfileController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Align(
        alignment: Alignment.centerLeft,
        child: CommonText(
          text: 'name_label'.tr,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: 8.h),
      CommonTextField(
        hintText: 'enter_name_hint'.tr,
        controller: controller.nameController,
      ),
      SizedBox(height: 20.h),

      /// ----------------- Phone Field -----------------
      Align(
        alignment: Alignment.centerLeft,
        child: CommonText(
          text: 'phone_number_label'.tr,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      SizedBox(height: 8.h),
      // driverPhoneTextFormField(phoneController: controller.phoneNumController), // assuming this widget handles its own hint/label
      CommonTextField(
        hintText: 'enter_phone_number'.tr,
        controller: controller.phoneController,
      ),

      SizedBox(height: 20.h),

      /// ---------------- DATE OF BIRTH ----------------
      Align(
        alignment: Alignment.centerLeft,
        child: CommonText(
          text: 'date_of_birth_label'.tr,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: 8.h),
      GestureDetector(
        onTap: () async {
          controller.isoDateController.text = await OtherHelper.openDatePicker(controller.dateOfBirthController);
          log("ISo Date: ${controller.isoDateController}");
        },
        child: AbsorbPointer(
          child: CommonTextField(
            controller: controller.dateOfBirthController,
            hintText: 'date_of_birth_hint'.tr,
            suffixIcon: SizedBox(
              height: 20,
              width: 20,
              child: Center(
                child: Assets.icons.dobCalenderIcon.image(
                  height: 20,
                  width: 20,
                ),
              ),
            ),
          ),
        ),
      ),

      SizedBox(height: 20.h),

      /// ---------------- LOCATION ----------------
      Align(
        alignment: Alignment.centerLeft,
        child: CommonText(
          text: 'location_label'.tr,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: 8.h),

      AddressSearchField(
        hintText: 'enter_location_hint'.tr,
        controller: controller.addressController,
        textInputAction: TextInputAction.done,
        fillColor: Colors.white,
        borderColor: const Color(0xFFE5E7EB),
        hintTextColor: AppColors.gray400,
        textColor: AppColors.black500,
        borderRadius: 16,
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Assets.icons.location.image(height: 20, width: 20),
        ),
        onSelected: (suggestion) async {
          final latLang = await OtherHelper.getCoordinatesFromAddress(suggestion.description);
          log("LatLang $latLang");
          if(latLang != null){
            // _ctrl.latitude = latLang.latitude;
            // _ctrl.longitude = latLang.longitude;
          }
        },),

      SizedBox(height: 20.h),

      /// ---------------- GHANA CARD ----------------
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: 'ghana_card_id_label'.tr,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 8.h),
          DottedBorder(
            options: RoundedRectDottedBorderOptions(
              radius: const Radius.circular(12),
              dashPattern: const [10, 5],
              strokeWidth: 2,
              padding: const EdgeInsets.all(8),
              color: AppColors.gray200,
            ),
            child: Obx(() {
              return SizedBox(
                height: 130.h,
                width: double.infinity,
                child: GestureDetector(
                  onTap: () async {
                    controller.ghanaICard.value = (await OtherHelper.openGallery())!;
                  },
                  child: controller.ghanaICard.value.isNotEmpty
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ShimmerImageLoader(url: controller.ghanaICard.value, width: double.infinity, height: 130.h),
                  )
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload_outlined,
                        size: 32,
                        color: AppColors.gray300,
                      ),
                      SizedBox(height: 8.h),
                      CommonText(
                        text: 'upload_button'.tr,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.gray300,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    ],
  );
}

