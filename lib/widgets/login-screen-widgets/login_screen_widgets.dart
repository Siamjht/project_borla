import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/features/auth/forget_pass_screen.dart';

import '../../screens/select_role_screen.dart';

class CheckboxSection extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CheckboxSection({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GradientCheckbox(
          value: value,
          onChanged: onChanged,
        ),

        const SizedBox(width: 10),
        const Text("Keep me logged in"),

        const Spacer(),

        TextButton(
          onPressed: () {
            Get.to(() => ForgetPassScreen());
          },
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [
                Color.fromRGBO(255, 214, 0, 1),
                Color.fromRGBO(255, 149, 0, 1),
              ],
            ).createShader(bounds),
            child: const Text(
              'Forgot Password?',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GradientCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double size;

  const GradientCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = 16,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      // child: Obx(()=>Container(
      //   width: size,
      //   height: size,
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(4),
      //     gradient: value
      //         ? const LinearGradient(
      //       colors: [
      //         Color.fromRGBO(255, 214, 0, 1),
      //         Color.fromRGBO(255, 149, 0, 1),
      //       ],
      //     )
      //         : null,
      //     border: Border.all(
      //       color: value ? Colors.transparent : Colors.grey,
      //       width: 2,
      //     ),
      //   ),
      //   child: value
      //       ? const Icon(
      //     Icons.check,
      //     size: 12,
      //     color: Colors.white,
      //   )
      //       : null,
      // ),)
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          gradient: value
              ? const LinearGradient(
            colors: [
              Color.fromRGBO(255, 214, 0, 1),
              Color.fromRGBO(255, 149, 0, 1),
            ],
          )
              : null,
          border: Border.all(
            color: value ? Colors.transparent : Colors.grey,
            width: 2,
          ),
        ),
        child: value
            ? const Icon(
          Icons.check,
          size: 12,
          color: Colors.white,
        )
            : null,
      ),
    );
  }
}

class DontHaveAccountSection extends StatelessWidget {
  const DontHaveAccountSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(

      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Text("Don't have an account?", style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),),
        //SizedBox(width: 2,),
        TextButton(
          onPressed: (){
            Get.to(()=> SelectRoleScreen());
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
              'Sign Up',
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