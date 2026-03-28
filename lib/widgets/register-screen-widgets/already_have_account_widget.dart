import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        Text("already_have_account".tr, style: const TextStyle(
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
            child: Text(
              "log_in".tr,
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