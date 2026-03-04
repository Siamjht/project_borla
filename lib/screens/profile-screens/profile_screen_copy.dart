
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/screens/info-screens/about_us_screen.dart';
import 'package:project_borla/screens/info-screens/notification_screen_copy.dart';
import 'package:project_borla/screens/info-screens/policy_screen.dart';
import 'package:project_borla/screens/profile-screens/address_screen.dart';
import 'package:project_borla/screens/profile-screens/change_password_screen_copy.dart';
import 'package:project_borla/screens/profile-screens/ps-inner-widgets/logout_bottom_sheet_copy.dart';
import 'package:project_borla/screens/profile-screens/ps-inner-widgets/settingsListItemsCopy.dart';
import 'package:project_borla/screens/support-chat-screens/start-chat-screen/start_chat_screen.dart';
import '../../bottom-sheets/user_lang_sheet.dart';
import '../../role/components/text/common_text.dart';
import '../../theme/gradient_scaffold_copy.dart';
import '../info-screens/terms_and_conditions_screen.dart';
import 'edit_profile_screen_copy.dart';


class ProfileScreenCopy extends StatelessWidget {
  const ProfileScreenCopy({super.key});

  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows full height if needed
      backgroundColor: Colors.transparent,
      builder: (context) => const UserLanguageSelectionBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return UserGradientScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CommonText(
                  text: 'Profile', fontSize: 18, fontWeight: FontWeight.w600,),
              ),
              SizedBox(height: 20,),
              // Profile Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE6E6E6)),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(
                        'https://shorturl.at/WSMrn',
                      ),
                    ),
                    const SizedBox(width: 16),

                    const CommonText(
                      text: 'Borla Ghana',
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
              ),

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
                  Get.to(()=> UserChangePasswordScreen());
                },
              ),

              SettingsListItem(
                icon: Icons.add_location_alt_rounded,
                title: 'Address',
                onTap: () {
                  Get.to(()=> AddressScreen());
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
                img: 'assets/images/user_chat.png' ,
                title: 'Customer Support',
                onTap: () {
                  Get.to(()=> StartChatScreen());
                },
              ),

              SettingsListItem(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                onTap: () {
                  Get.to(()=> NotificationsScreenCopy(isFromProfile: true,));
                },
              ),
              SettingsListItem(
                onTap: () {
                  Get.to(()=> AboutUsScreen());
                },
                icon: Icons.info_outline,
                title: 'About Us',
              ),
              SettingsListItem(
                onTap: () {
                  Get.to(()=> PolicyScreen());
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
                  showUserLogoutBottomSheet(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
