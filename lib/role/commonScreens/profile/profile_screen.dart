
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/controllers/profileController/profile_controller.dart';
import 'package:project_borla/features/auth/login_screen.dart';
import 'package:project_borla/role/commonScreens/notification/notification_screen.dart';
import 'package:project_borla/role/commonScreens/privacyPolicy/privacy_policy_screen.dart';
import 'package:project_borla/role/commonScreens/profile/change_password_screen.dart';
import 'package:project_borla/role/commonScreens/profile/edit_profile_screen.dart';
import 'package:project_borla/role/commonScreens/termsOfConditions/terms_of_conditions.dart';
import 'package:project_borla/role/components/image/shimmer_image_loader.dart';
import 'package:project_borla/role/components/text/common_text.dart';
import 'package:project_borla/theme/app_color.dart';

import '../../../gen/custom_assets/assets.gen.dart';
import '../../../screens/support-chat-screens/start-chat-screen/start_chat_screen.dart';
import '../../components/gradient_scafold.dart';
import '../aboutUs/about_us.dart';
import 'innerWidget/language_bottom_sheet.dart';
import 'innerWidget/logout_bottom_sheet.dart';
import 'innerWidget/settingsListItems.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final _profileCtrl = Get.put(ProfileController());

  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows full height if needed
      backgroundColor: Colors.transparent,
      builder: (context) => const LanguageSelectionBottomSheet(),
    );
  }

  @override
  void initState() {
    super.initState();
    _profileCtrl.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: SafeArea(
        child: Column(
          children: [
            CommonText(
              text: 'Profile',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
            SizedBox(height: 20,),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Header
                    Obx(() => Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE6E6E6)),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(32),
                            child: ShimmerImageLoader(url: _profileCtrl.profile.value.profilePicture, width: 56, height: 56),
                          ),
                          const SizedBox(width: 16),

                          CommonText(
                            text: _profileCtrl.profile.value.name,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.left,
                            maxLines: 1,
                          ),

                          const Spacer(),
                          InkWell(
                              onTap: () {
                                Get.to(()=> EditProfileScreen());
                              },
                              child: Icon(Icons.chevron_right, color: Colors.grey[600])),
                        ],
                      ),
                    ),),

                    const SizedBox(height: 40),

                    const CommonText(
                      text: 'Others',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      textAlign: TextAlign.left,
                      maxLines: 1,
                    ),

                    const SizedBox(height: 16),

                    // Settings items
                    SettingsListItem(
                      icon: Icons.lock_outline,
                      title: 'Change Password',
                      onTap: () {
                        Get.to(()=> ChangePasswordScreen());
                      },
                    ),
                    SettingsListItem(
                      icon: Icons.language,
                      title: 'Change Language',
                      onTap: () {
                        showLanguageBottomSheet(context);
                      },
                    ),
                    SettingsListItemTwo(
                      //icon: Icons.headphones,
                      img: Assets.icons.customerSupportIcon.image(height: 26, width: 26, color: AppColors.green500,),
                      title: 'Customer Support',
                      onTap: () {
                        Get.to(()=> StartChatScreen());
                      },
                    ),
                    SettingsListItem(
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      onTap: () {
                        Get.to(()=> NotificationsScreen());
                      },
                    ),
                    SettingsListItem(
                      onTap: () {
                        Get.to(()=> AboutUs());
                      },
                      icon: Icons.info_outline,
                      title: 'About Us',
                    ),
                    SettingsListItem(
                      onTap: () {
                        Get.to(()=> PrivacyPolicyScreen());
                      },
                      icon: Icons.privacy_tip_outlined,
                      title: 'Privacy policy',
                    ),
                    SettingsListItem(
                      onTap: () {
                        Get.to(()=> TermsOfConditions());
                      },
                      icon: Icons.description_outlined,
                      title: 'Terms & Conditions',
                    ),
                    SettingsListItem(
                      icon: Icons.logout,
                      title: 'Logout',
                      titleColor: Colors.red,
                      iconColor: Colors.red,
                      onTap: () {
                        showLogoutBottomSheet(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsListItemTwo extends StatelessWidget {
  //final IconData icon;
  final Image img;
  final String title;
  //final Color? iconColor;
  final Color? titleColor;
  final VoidCallback? onTap; // already declared

  const SettingsListItemTwo({
    super.key,
    required this.img,
    required this.title,
    //this.iconColor = Colors.amber, // Green accent
    this.titleColor = AppColors.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: onTap, // handle tap
        borderRadius: BorderRadius.circular(10), // ripple respects corners
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE6E6E6)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              //Icon(icon, color: iconColor, size: 26),
              img,
              const SizedBox(width: 16),
              CommonText(
                text: title,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: titleColor!,
                textAlign: TextAlign.left,
                maxLines: 1,
              ),
              const Spacer(),
              Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
            ],
          ),
        ),
      ),
    );
  }
}