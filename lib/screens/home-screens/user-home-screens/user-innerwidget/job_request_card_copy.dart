import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:project_borla/screens/home-screens/user-home-screens/user-innerwidget/waste_details_widget_copy.dart';
import 'package:project_borla/theme/app_color.dart';
import '../../../../gen/custom_assets/assets.gen.dart';
import '../../../../role/components/text/common_text.dart';
import '../../../../theme/custom_container_copy.dart';
import '../user-controller/user_home_controller.dart';

import 'common_widgets_copy.dart';


class JobRequestCard extends StatelessWidget {
  JobRequestCard({super.key});

  final UserHomeController controller =
  Get.find<UserHomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.green100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * .65,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          // padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Center(child: CommonText(text: controller.isScheduleRequest.value? "Scheduled garbage pickup" : "Ride Request", fontSize: 18,)),),
              const Divider(color: AppColors.black50, thickness: 1),
              userRow(controller),
              const SizedBox(height: 4),
              Obx(() => controller.isScheduleRequest.value?
              _scheduledPickup() : SizedBox.shrink()),
              const SizedBox(height: 12),
              WasteDetailsWidget(),
              const Divider(color: AppColors.black50, thickness: 1),
              const SizedBox(height: 4),
              locationSection(),
              const Divider(color: AppColors.black50, thickness: 1),
              const SizedBox(height: 10),
              paymentRow(),
              const SizedBox(height: 20),
              actionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  CustomContainer _scheduledPickup() {
    return CustomContainer(
      borderColor: AppColors.green500,
      color: AppColors.green20,
      borderWidth: 0.2,
      borderRadius: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.green500,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: Assets.icons.calenderIcon.image(height: 20, width: 20)),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonText(
                    textAlign: TextAlign.start,
                    text: 'Scheduled Pickup',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textDark,
                  ),
                  const SizedBox(height: 4),
                  CommonText(
                    text: 'Dec 26, 2025',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            CustomContainer(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                borderColor: AppColors.green500,
                borderWidth: 0.5,
                borderRadius: 40,
                child: Row(
                  children: [
                    Icon(Icons.access_time_rounded, color: AppColors.green500, size: 18,),
                    CommonText(text: "10:30 AM", fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.textDark,)
                  ],
                ))
          ],
        ),
      ),
    );
  }
}