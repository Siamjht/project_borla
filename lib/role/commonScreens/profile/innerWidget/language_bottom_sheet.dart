
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/components/custom_container.dart';
import 'package:project_borla/theme/app_color.dart';

import '../../../../language/language_service.dart';
import '../../../../utils/app_texts.dart';
import '../../../components/text/common_text.dart';


class LanguageSelectionBottomSheet extends StatefulWidget {
  final bool isUser;
  const LanguageSelectionBottomSheet({super.key, this.isUser = false});

  @override
  State<LanguageSelectionBottomSheet> createState() => _LanguageSelectionBottomSheetState();
}

class _LanguageSelectionBottomSheetState extends State<LanguageSelectionBottomSheet> {
  String selectedLanguage = 'English'; // fallback / initial value

  final List<Map<String, String>> languages = [
    {'name': 'English', 'greeting': 'Hello', 'lang': 'en', 'country': 'US'},
    {'name': 'Ghana', 'greeting': 'Akwaaba', 'lang': 'ak', 'country': 'GH'},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCurrentLanguage();
    });
  }

  Future<void> _loadCurrentLanguage() async {
    final currentLocale = await LanguageService.getLocale();

    String name = 'English'; // default fallback

    if (currentLocale.languageCode == 'ak') {
      name = 'Ghana';
    } else if (currentLocale.languageCode == 'en') {
      name = 'English';
    }

    if (mounted) {
      setState(() {
        selectedLanguage = name;
      });
    }
  }

  Future<void> _changeLanguage(String langName) async {
    final selected = languages.firstWhere(
          (lang) => lang['name'] == langName,
      orElse: () => languages.first,
    );

    final locale = Locale(
      selected['lang']!,
      selected['country'],
    );

    await LanguageService.changeLocale(locale);

    if (mounted) {
      setState(() {
        selectedLanguage = langName;
      });
    }
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
              // Drag handle
              CustomContainer(
                height: 3,
                width: 40,
                color: AppColors.gray200,
                child: SizedBox(),
              ),

              SizedBox(height: 12.h),

              // Title
              CommonText(
                text: AppStrings.chooseLanguage,
                fontSize: 24,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 8.h),

              // Subtitle
              CommonText(
                text: AppStrings.languageRestartNote,
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
                  final langName = lang['name']!;
                  final isSelected = selectedLanguage == langName;

                  return LanguageOption(
                    isUser: widget.isUser,
                    name: langName,
                    greeting: lang['greeting']!,
                    isSelected: isSelected,
                    onTap: () {
                      _changeLanguage(langName);
                    },
                  );
                }).toList(),
              ),

              SizedBox(height: 40.h),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: () {
                    // All changes are already saved in _changeLanguage()
                    // Just close + give feedback
                    Navigator.pop(context);

                    Get.snackbar(
                      "success".tr,
                      '${'Language changed to'.tr} $selectedLanguage',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.isUser? AppColors.orange300 : AppColors.green500,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child:CommonText(
                    text: 'save'.tr,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
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
  final bool isUser;
  final VoidCallback onTap;

  const LanguageOption({
    super.key,
    required this.name,
    required this.greeting,
    required this.isSelected,
    required this.isUser,
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
                      ? isUser? AppColors.orange50 : AppColors.green50
                      :  Colors.transparent,
                  border: Border.all(
                    color: !isSelected ? isUser? AppColors.orange50 : AppColors.green50 : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: CommonText(
                    text: greeting,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? isUser? AppColors.orange300 : const Color(0xFF4CAF50) : Colors.black87,
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
                decoration: BoxDecoration(
                  color: isUser? AppColors.orange300 : Color(0xFF4CAF50),
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
