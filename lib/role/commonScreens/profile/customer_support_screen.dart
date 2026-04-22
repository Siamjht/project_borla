
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/commonScreens/chat/support_chat_screen.dart';
import 'package:project_borla/role/components/gradient_scafold.dart';

import '../../../theme/app_color.dart';
import '../../components/button/common_button.dart';
import '../../components/commonBackButton/common_back_button.dart';
import '../../components/text/common_text.dart';

class CustomerSupportScreen extends StatelessWidget {
  const CustomerSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientScaffold(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [

              const SizedBox(height: 60),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonBackButton(),
                  CommonText(
                    text: 'customer_support'.tr,
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 50),
                ],
              ),

              SizedBox(height: Get.height * 0.15),

              SvgPicture.asset(
                'assets/images/user_support.svg',
                height: 180,
                colorFilter: const ColorFilter.mode(
                  AppColors.green500,
                  BlendMode.srcIn,
                ),
              ),

              const SizedBox(height: 46),

              CommonText(
                text: 'how_can_we_help'.tr,
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: const Color.fromRGBO(72, 72, 72, 1),
              ),

              const SizedBox(height: 14),

              CommonText(
                text: 'support_description'.tr,
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: const Color.fromRGBO(137, 137, 137, 1),
              ),

              const Spacer(),

              CommonButton(
                titleText: 'start_chat'.tr,
                firstGradient: AppColors.green500,
                secondGradient: AppColors.green500,
                buttonRadius: 12,
                buttonHeight: 48,
                onTap: () {
                  Get.to(()=> RiderSupportChatScreen());
                },
              ),
              const SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}
