import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project_borla/features/auth/login_screen.dart';
import 'package:project_borla/screens/select_role_screen.dart';
import '../../role/components/button/common_button.dart';
import '../../widgets/onboarding-widgets/onboarding_data.dart';
import '../../widgets/onboarding-widgets/onboarding_image_page_widget.dart';


class OnboardingTwo extends StatelessWidget {
  const OnboardingTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(255, 246, 217, 1),
              Color.fromRGBO(255, 255, 255, 1),
            ],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      VideoOnboardingPage(
                        imagePath: onboardingData2["image"]!,
                        titlePath1: onboardingData2["title"]!.tr,
                        subtitlePath1: onboardingData2["subtitle"]!.tr,
                        isScrollable: false,
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CommonButton(
                              titleText: "sign_in".tr,
                              firstGradient: const Color(0xFFFFD600),
                              secondGradient: const Color(0xFFFF9500),
                              useGradientBackground: true,
                              buttonRadius: 12,
                              onTap: () {
                                Get.to(() => LoginScreen());
                              },
                            ),
                            const SizedBox(height: 15),
                            CommonButton(
                              titleText: "sign_up".tr,
                              firstGradient: const Color(0xFFFFD600),
                              secondGradient: const Color(0xFFFF9500),
                              useGradientBorder: true,
                              useGradientBackground: false,
                              backgroundColor: Colors.white,
                              useGradientText: true,
                              buttonRadius: 16,
                              onTap: () {
                                Get.to(() => SelectRoleScreen());
                              },
                            ),
                          ],
                        ),
                      ),
                      60.verticalSpace,
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
