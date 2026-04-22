
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/helpers/other_helper.dart';
import 'package:project_borla/theme/app_color.dart';
import '../../role/components/image/common_image.dart';
import '../../role/components/text/common_text.dart';
import '../../theme/common_back_button_copy.dart';
import '../../theme/custom_container_copy.dart';
import '../../theme/gradient_scaffold_copy.dart';
import 'activity-controller/user_activity_controller.dart';
import 'activity-widgets/user_job_activity_card.dart';

class UserScheduleDetailScreen extends StatelessWidget {
  const UserScheduleDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<UserActivityController>();
    final booking = ctrl.selectedBooking.value;

    if (booking == null) {
      return UserGradientScaffold(
        child: SafeArea(
          child: Center(
            child: CommonText(text: 'No booking selected', fontSize: 16),
          ),
        ),
      );
    }

    return UserGradientScaffold(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonBackButton(),
                  CommonText(text: "Ride Details", color: AppColors.textDark, fontSize: 18,),
                  SizedBox(width: 50,)
                ],),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 20),
              child: Column(
                children: [
                  CustomContainer(
                    width: Get.width,
                    height: 100,
                    borderRadius: 8,
                    borderColor: AppColors.orange100 ,
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonText(text: "Ride scheduled!",  fontSize: 20,),
                              CommonText(
                                text: '${booking.scheduledDate ?? ''} - ${OtherHelper.getTimeFromIso(booking.scheduledFor ?? "")}',
                                color: AppColors.gray300,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                            left: 0,
                            top: 0,
                            child: CommonImage(imageSrc: "assets/images/amber_left_2.png", imageType: ImageType.png, size: 70, imageColor: AppColors.orange300,)),
                        Positioned(
                            right: 0,
                            top: 0,
                            child: CommonImage(imageSrc: "assets/images/amber_right_2.png", imageType: ImageType.png, size: 80, imageColor: AppColors.orange300)),
                      ],
                    ),
                  ),
                  SizedBox(height: 16,),
                  UserActivityCard(booking: booking, isDetailScreen: true, isScheduled: true,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}