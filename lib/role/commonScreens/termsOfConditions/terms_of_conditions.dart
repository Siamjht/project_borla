
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:project_borla/role/components/commonBackButton/common_back_button.dart';
import 'package:project_borla/role/components/text/common_text.dart';
import 'package:project_borla/theme/app_color.dart';

import '../../components/gradient_scafold.dart';

class TermsOfConditions extends StatelessWidget {
  const TermsOfConditions({super.key});

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
                CommonText(text: "terms_and_conditions".tr, color: AppColors.textDark, fontSize: 18, fontWeight: FontWeight.w600,),
                SizedBox(width: 50,)
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CommonText(text: "terms_and_conditions".tr, color: AppColors.textDark,),
            SizedBox(height: 20,),
            CommonText(
              textAlign: TextAlign.start,
              text: "Lorem ipsum dolor sit amet consectetur. Ultrices id feugiat venenatis habitant mattis viverra elementum purus volutpat. Lacus eu molestie pulvinar rhoncus integer proin elementum. Pretium sit fringilla massa tristique aenean commodo leo. Aliquet viverra amet sit porta elementum et pellentesque posuere. Ullamcorper viverra tortor lobortis viverra auctor egestas. Nulla condimentum ac metus quam turpis gravida ut velit. Porta justo lacus consequat sed platea. Ut dui massa quam elit faucibus consectetur sapien aenean auctor. Felis ipsum amet justo in. Netus amet in egestas sed auctor lorem. ",
              color: AppColors.gray400,)
          ],
        ),
      )),
    );
  }
}
