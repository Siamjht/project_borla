import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/settingsController/settings_controller.dart';
import '../../role/components/text/common_text.dart';
import '../../theme/app_color.dart';
import '../../theme/common_back_button_copy.dart';
import '../../theme/gradient_scaffold_copy.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getPrivacyPolicy();
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
                    text: 'privacy_policy'.tr,
                    color: AppColors.textDark,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(width: 50),
                ],
              ),
              SizedBox(height: 20),
              Obx(() {
                if (controller.isPrivacyLoading.value) {
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
                          text: 'privacy_policy'.tr,
                          color: AppColors.textDark,
                        ),
                        SizedBox(height: 20),
                        CommonText(
                          textAlign: TextAlign.start,
                          text: controller.privacyPolicy.value?.content ?? '',
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
