import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../features/auth/login_screen.dart';

class AlreadyHaveAccountSection extends StatelessWidget {
  const AlreadyHaveAccountSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(

      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Text("Already have an account?", style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),),
        //SizedBox(width: 2,),
        TextButton(
          onPressed: (){
            Get.to(()=>LoginScreen());
          },
          child: ShaderMask(
            shaderCallback: (bounds) =>
                const LinearGradient(
                  colors: [
                    Color.fromRGBO(255, 214, 0, 1),
                    Color.fromRGBO(255, 149, 0, 1),
                  ],
                ).createShader(bounds),
            child: const Text(
              'Sign In',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),)
      ],
    );
  }
}