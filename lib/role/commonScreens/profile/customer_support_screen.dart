
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
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
                  SizedBox(height: 60,),
                  Row(
                    children: [
                      CommonBackButton(),
                      SizedBox(width: 54,),
                      CommonText(
                        text: 'Customer Support',
                        fontSize: 19 ,
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  ),
                  SizedBox(height: Get.height * 0.15,),
                  SvgPicture.asset(
                    'assets/images/user_support.svg',
                    height: 180,
                    colorFilter: const ColorFilter.mode(
                      AppColors.green500, // your color
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(height: 46,),
                  CommonText(
                    text: 'How can we help you?',
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Color.fromRGBO(72, 72, 72, 1),
                  ),
                  SizedBox(height: 14,),
                  CommonText(
                    text: 'Get instant 24/7 support from our assistant,\n  or connect with one of our expert agents.',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color.fromRGBO(137, 137, 137, 1),
                  ),
                  Spacer(),
                  CommonButton(
                    titleText: 'Start a chat',
                    firstGradient: AppColors.green500,
                    secondGradient: AppColors.green500,
                    buttonRadius: 12,
                    buttonHeight: 48,
                    onTap: (){
                      // Get.to(()=> ChattingScreen(bookingId: bookingId));
                    },
                  )
                ],
              ),
            )
        )


    );
  }
}
