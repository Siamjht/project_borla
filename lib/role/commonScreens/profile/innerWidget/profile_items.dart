import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../../../gen/custom_assets/assets.gen.dart';
import '../../../../theme/app_color.dart';
import '../../../components/commonTextField/common_text_field.dart';
import '../../../components/commonTextField/phone_text_field.dart';
import '../../../components/text/common_text.dart';

Widget profileItems(BuildContext context, controller) {
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
      driverPhoneTextFormField(), // assuming this widget handles its own hint/label

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
        onTap: () => controller.pickDate(context),
        child: AbsorbPointer(
          child: CommonTextField(
            controller: controller.dobController,
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
      CommonTextField(
        hintText: 'enter_location_hint'.tr,
        controller: controller.locationController,
      ),

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
                  onTap: () => controller.pickImage(isProfile: false),
                  child: controller.ghanaCardImage.value != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      controller.ghanaCardImage.value!,
                      fit: BoxFit.cover,
                    ),
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

