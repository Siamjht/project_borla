import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:project_borla/controllers/user-controllers/auth_controller.dart';
import 'package:project_borla/features/auth/login_screen.dart';
import 'package:project_borla/features/auth/otp_screen_two.dart';
import 'package:project_borla/language/language_service.dart';

import '../../gen/custom_assets/assets.gen.dart';
import '../../role/components/commonTextField/phone_text_field.dart';
import '../../theme/auth_header.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/register-screen-widgets/registration_section_widget.dart';
import '../../widgets/social_login_button.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  UserAuthController registerScreenController = Get.put(UserAuthController());

  bool agree = false ;

  @override
  void initState() {
    super.initState();
    registerScreenController.registerPhoneController = PhoneController(
      initialValue: const PhoneNumber(
        isoCode: IsoCode.GH,
        nsn: '',
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      registerScreenController.registerPhoneController.value = const PhoneNumber(
        isoCode: IsoCode.GH,
        nsn: '',
      );
    });

  }

  @override
  void dispose() {
    registerScreenController.registerPhoneController.dispose();
    //_passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(

            alignment: AlignmentDirectional.bottomStart,

            children: [

              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 214, 0, 1),
                      Color.fromRGBO(255,149,0, 1),
                    ],
                  ),
                ),
                child: AuthHeader(
                  title: 'create_your_new_account'.tr,
                  subtitle: 'register_now_and_explore'.tr,
                ),
              ),

              Positioned(
                  top: 0,
                  right: -60,
                  child: Assets.images.backgroundShadow.image(height: 300, width: 400)),

              Positioned(
                top: LanguageService.setLang == 'en' ? 230 : 210,
                  left: 0,
                  right: 0,
                  child: RegistrationSection(registerScreenController: registerScreenController)
              )

            ]
        )
    );
  }
}


