import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/features/auth/forget_pass_screen.dart';
import 'package:project_borla/language/language_service.dart';
import '../../controllers/authController/auth_controller.dart';
import '../../screens/select_role_screen.dart';
import '../../theme/app_color.dart';

class CheckboxSection extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CheckboxSection({
    super.key,
    required this.value,
    required this.onChanged,
  });

  // ✅ helper
  bool get isRider => AuthController.selectedRole.value == 'Rider';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GradientCheckbox(
          value: value,
          onChanged: onChanged,
          isRider: isRider, // ✅
        ),

        const SizedBox(width: 10),
        Text('keep_me_logged_in'.tr),

        const Spacer(),

        TextButton(
          onPressed: () => Get.to(() => ForgetPassScreen()),
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: isRider
                  ? [AppColors.green500, AppColors.green500] // ✅ rider
                  : [
                const Color.fromRGBO(255, 214, 0, 1),
                const Color.fromRGBO(255, 149, 0, 1),
              ],
            ).createShader(bounds),
            child: Text(
              'forgot_password_question'.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: LanguageService.setLang == 'en' ? 14 : 12,
                fontWeight: FontWeight.w400,
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
  final bool isRider; // ✅ new

  const GradientCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = 16,
    this.isRider = false, // ✅ new
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          gradient: value
              ? LinearGradient(
            colors: isRider
                ? [AppColors.green500, AppColors.green500] // ✅ rider
                : [
              const Color.fromRGBO(255, 214, 0, 1),
              const Color.fromRGBO(255, 149, 0, 1),
            ],
          )
              : null,
          border: Border.all(
            color: value ? Colors.transparent : Colors.grey,
            width: 2,
          ),
        ),
        child: value
            ? const Icon(Icons.check, size: 12, color: Colors.white)
            : null,
      ),
    );
  }
}

class DontHaveAccountSection extends StatelessWidget {
  const DontHaveAccountSection({super.key});

  bool get isRider => AuthController.selectedRole.value == 'Rider'; // ✅

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'dont_have_account'.tr,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        TextButton(
          onPressed: () => Get.to(() => SelectRoleScreen()),
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: isRider
                  ? [AppColors.green500, AppColors.green500] // ✅ rider
                  : [
                const Color.fromRGBO(255, 214, 0, 1),
                const Color.fromRGBO(255, 149, 0, 1),
              ],
            ).createShader(bounds),
            child: Text(
              'sign_up'.tr,
              style: const TextStyle(
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