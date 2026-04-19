
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:project_borla/role/components/commonBackButton/common_back_button.dart';
import 'package:project_borla/role/components/text/common_text.dart';
import 'package:project_borla/theme/app_color.dart';

import '../../../controllers/settingsController/settings_controller.dart';
import '../../components/gradient_scafold.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {

  final controller = Get.find<SettingController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getPrivacyPolicy();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonBackButton(),
                CommonText(text: 'privacy_policy'.tr, color: AppColors.textDark, fontSize: 18, fontWeight: FontWeight.w600,),
                SizedBox(width: 50,)
              ],
            ),
            SizedBox(
              height: 20,
            ),
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
                      Html(data: controller.privacyPolicy.value?.content ?? ''),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      )),
    );
  }
}