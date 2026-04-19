
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:project_borla/theme/app_color.dart';
import '../../controllers/settingsController/settings_controller.dart';
import '../../role/components/text/common_text.dart';
import '../../theme/common_back_button_copy.dart';
import '../../theme/gradient_scaffold_copy.dart';
import 'package:get/get.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  final controller = Get.find<SettingController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getAboutUs();
    });
  }

  @override
  Widget build(BuildContext context) {

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
                        Html(
                          data: controller.aboutUs.value?.content ?? '',
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