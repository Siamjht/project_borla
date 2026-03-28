
import 'package:flutter/material.dart';
import 'package:project_borla/theme/app_color.dart';
import '../../controllers/settingsController/settings_controller.dart';
import '../../role/components/text/common_text.dart';
import '../../theme/common_back_button_copy.dart';
import '../../theme/gradient_scaffold_copy.dart';
import 'package:get/get.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getAboutUs();
    });

    return UserGradientScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonBackButton(),
                  CommonText(
                    text: 'about_us'.tr,
                    color: AppColors.textDark,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(width: 50),
                ],
              ),
              SizedBox(height: 20),
              Obx(() {
                if (controller.isAboutUsLoading.value) {
                  return Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: 'about_us'.tr,
                          color: AppColors.textDark,
                        ),
                        SizedBox(height: 20),
                        CommonText(
                          textAlign: TextAlign.start,
                          text: controller.aboutUs.value?.content ?? '',
                          color: AppColors.gray400,
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}