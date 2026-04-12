
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/screens/info-screens/about_us_screen.dart';
import 'package:project_borla/screens/info-screens/user_notification_screen.dart';
import 'package:project_borla/screens/info-screens/policy_screen.dart';
import 'package:project_borla/screens/profile-screens/address_screen.dart';
import 'package:project_borla/screens/profile-screens/ps-inner-widgets/logout_bottom_sheet_copy.dart';
import 'package:project_borla/screens/profile-screens/ps-inner-widgets/settingsListItemsCopy.dart';
import 'package:project_borla/screens/support-chat-screens/start-chat-screen/start_chat_screen.dart';
import '../../controllers/profileController/profile_controller.dart';
import '../../role/commonScreens/profile/change_password_screen.dart';
import '../../role/commonScreens/profile/edit_profile_screen.dart';
import '../../role/commonScreens/profile/innerWidget/language_bottom_sheet.dart';
import '../../role/components/image/shimmer_image_loader.dart';
import '../../role/components/text/common_text.dart';
import '../../theme/gradient_scaffold_copy.dart';
import '../info-screens/terms_and_conditions_screen.dart';


class ProfileScreenUser extends StatefulWidget {
  const ProfileScreenUser({super.key});

  @override
  State<ProfileScreenUser> createState() => _ProfileScreenUserState();
}

class _ProfileScreenUserState extends State<ProfileScreenUser> {

  final _profileCtrl = Get.put(ProfileController());

  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => LanguageSelectionBottomSheet(isUser: true),
    );
  }

  @override
  void initState() {
    super.initState();
    _profileCtrl.getProfile();
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
                  text: 'profile'.tr,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),

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
                      child: ShimmerImageLoader(
                        url: _profileCtrl.profile.value.profilePicture,
                        width: 56,
                        height: 56,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: _profileCtrl.profile.value.name,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                        ),
                        CommonText(
                          text: _profileCtrl.profile.value.email,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.left,
                          maxLines: 2,
                        ),
                      ],
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () => Get.to(() => EditProfileScreen(isUser: true)),
                      child: Icon(Icons.chevron_right, color: Colors.grey[600]),
                    ),
                  ],
                ),
              )),

              const SizedBox(height: 40),

              CommonText(
                text: 'others'.tr,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                textAlign: TextAlign.left,
                maxLines: 1,
              ),

              const SizedBox(height: 16),

              SettingsListItem(
                icon: Icons.lock_outline,
                title: 'change_password'.tr,
                onTap: () => Get.to(() => ChangePasswordScreen(isUser: true)),
              ),

              SettingsListItem(
                icon: Icons.add_location_alt_rounded,
                title: 'address'.tr,
                onTap: () => Get.to(() => AddressScreen()),
              ),

              SettingsListItem(
                icon: Icons.language,
                title: 'change_language'.tr,
                onTap: () => showLanguageBottomSheet(context),
              ),

              SettingsListItemTwo(
                img: 'assets/images/user_chat.png',
                title: 'customer_support'.tr,
                onTap: () => Get.to(() => StartChatScreen()),
              ),

              SettingsListItem(
                icon: Icons.notifications_outlined,
                title: 'notifications'.tr,
                onTap: () => Get.to(() => UserNotificationScreen(isFromProfile: true)),
              ),

              SettingsListItem(
                icon: Icons.info_outline,
                title: 'about_us'.tr,
                onTap: () => Get.to(() => AboutUsScreen()),
              ),

              SettingsListItem(
                icon: Icons.privacy_tip_outlined,
                title: 'privacy_policy'.tr,
                onTap: () => Get.to(() => PolicyScreen()),
              ),

              SettingsListItem(
                icon: Icons.description_outlined,
                title: 'terms_and_conditions'.tr,
                onTap: () => Get.to(() => TermsOfConditions()),
              ),

              SettingsListItem(
                icon: Icons.logout,
                title: 'logout'.tr,
                titleColor: Colors.red,
                iconColor: Colors.red,
                onTap: () => showUserLogoutBottomSheet(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
