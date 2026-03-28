import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/language/language_service.dart';

import '../../gen/custom_assets/assets.gen.dart';
import '../../theme/auth_header.dart';
import '../../widgets/register-screen-widgets/registration_section_widget.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

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
                  child: RegistrationSection()
              )

            ]
        )
    );
  }
}


