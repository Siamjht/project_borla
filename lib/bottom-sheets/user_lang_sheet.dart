
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_borla/theme/app_color.dart';
import 'package:project_borla/theme/common_button_copy.dart';

import '../language/language_service.dart';
import '../role/components/custom_container.dart';
import '../role/components/text/common_text.dart';
import '../utils/app_texts.dart';


class UserLanguageSelectionBottomSheet extends StatefulWidget {
  const UserLanguageSelectionBottomSheet({super.key});

  @override
  State<UserLanguageSelectionBottomSheet> createState() =>
      _UserLanguageSelectionBottomSheetState();
}

class _UserLanguageSelectionBottomSheetState
    extends State<UserLanguageSelectionBottomSheet> {
  String selectedLanguage = 'English';

  final List<Map<String, String>> languages = [
    {'name': 'English', 'greeting': 'Hello'},
    {'name': 'Ghana', 'greeting': 'Akwaaba'},
  ];

  void changeToEnglish() {
    Get.updateLocale(const Locale('en', 'US'));
  }

  void changeToGhana() {
    Get.updateLocale(const Locale('ak', 'GH'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              CustomContainer(
                  height: 3,
                  width: 40,
                  color: AppColors.gray200,
                  child: SizedBox()),
              // Title
              SizedBox(height: 12.h),
              CommonText(
                text: AppTexts.chooseLanguage,
                fontSize: 24,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),

              // Subtitle
              CommonText(
                text: AppTexts.languageRestartNote,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.gray300,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),

              // Language Options
              Wrap(
                spacing: 32.w,
                runSpacing: 32.h,
                alignment: WrapAlignment.center,
                children: languages.map((lang) {
                  return LanguageOption(
                    name: lang['name']!,
                    greeting: lang['greeting']!,
                    isSelected: selectedLanguage == lang['name'],
                    onTap: () {
                      setState(() {
                        selectedLanguage = lang['name']!;
                      });
                      if(selectedLanguage == 'English'){
                        changeToEnglish();
                      }else{
                        changeToGhana();
                      }
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 40.h),

              // Save Button
              CommonButton(
                onTap: () async {
                  // 🔹 1. Change app language + save to storage
                  if (selectedLanguage == 'English') {
                    await LanguageService.changeLocale(
                      const Locale('en', 'US'),
                    );
                  } else {
                    await LanguageService.changeLocale(
                      const Locale('ak', 'GH'),
                    );
                  }

                  // 🔹 2. Close bottom sheet
                  Navigator.pop(context);

                  // 🔹 3. Feedback to user
                  Get.snackbar(
                    'Success',
                    'Language changed to $selectedLanguage',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                firstGradient: AppColors.orange300,
                secondGradient: AppColors.orange500,
                buttonRadius: 12,
                borderWidth: Get.width,
                titleText: "Save",
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// Reusable widget for a single language option
class LanguageOption extends StatelessWidget {
  final String name;
  final String greeting;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageOption({
    super.key,
    required this.name,
    required this.greeting,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? AppColors.orange100
                      :  Colors.transparent,
                  border: Border.all(
                    color: !isSelected ? AppColors.green100 : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: CommonText(
                    text: greeting,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? AppColors.orange300 : Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              CommonText(
                text: name,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ],
          ),
          if (isSelected)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(6.w),
                decoration: const BoxDecoration(
                  color: AppColors.orange300,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }
}