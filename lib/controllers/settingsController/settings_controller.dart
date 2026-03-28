

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helpers/prefs_helper.dart';
import '../../../services/api_service.dart';
import '../../models/api_response_model.dart';
import '../../models/contentModel/content_model.dart';
import '../../role/components/customSnackbar/custom_snackbar.dart';
import '../../utils/app_urls.dart';


class SettingController extends GetxController {
  final passwordController = TextEditingController();
  final reasonController = TextEditingController();

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  RxBool isLoading = false.obs;


  // Loading states
  final RxBool isAboutUsLoading = false.obs;
  final RxBool isTermsLoading = false.obs;
  final RxBool isPrivacyLoading = false.obs;

  // Content data
  final Rx<ContentPageModel?> aboutUs = Rx<ContentPageModel?>(null);
  final Rx<ContentPageModel?> termsCondition = Rx<ContentPageModel?>(null);
  final Rx<ContentPageModel?> privacyPolicy = Rx<ContentPageModel?>(null);

  Future<void> getAboutUs() async {
    isAboutUsLoading.value = true;
    try {
      final response = await SettingsService.getAboutUs();
      if (response.statusCode == 200) {
        aboutUs.value = ContentPageModel.fromJson(response.body['data']);
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isAboutUsLoading.value = false;
    }
  }

  Future<void> getTermsCondition() async {
    isTermsLoading.value = true;
    try {
      final response = await SettingsService.getTermsCondition();
      if (response.statusCode == 200) {
        termsCondition.value = ContentPageModel.fromJson(response.body['data']);
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isTermsLoading.value = false;
    }
  }

  Future<void> getPrivacyPolicy() async {
    isPrivacyLoading.value = true;
    try {
      final response = await SettingsService.getPrivacyPolicy();
      if (response.statusCode == 200) {
        privacyPolicy.value = ContentPageModel.fromJson(response.body['data']);
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isPrivacyLoading.value = false;
    }
  }

// ── Delete Account ──
  Future<void> deleteAccount() async {
    isLoading.value = true;

    try {
      final response = await ApiService.delete(
        AppUrls.deleteMyAccount,
        body: {"password": passwordController.text},
      );

      if (response.statusCode == 200) {
        await PrefsHelper.removeAllPrefData();
        // Get.offAllNamed(AppRoutes.signInScreen);
        CustomSnackbar.success(response.message);
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isLoading.value = false;
    }
  }

  // ── Change Password ──
  Future<void> changePassword(context) async {
    isLoading.value = true;
    try {
      final response = await ApiService.patch(
        AppUrls.changePassword,
        body: {
          "oldPassword": oldPasswordController.text,
          "newPassword": newPasswordController.text,
          "confirmPassword": confirmPasswordController.text,
        },
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);
        oldPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
        CustomSnackbar.success(response.message);
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isLoading.value = false;
    }
  }

}


class SettingsService {
  static Future<ApiResponseModel> getAboutUs() async {
    return await ApiService.get(AppUrls.aboutUs);
  }

  static Future<ApiResponseModel> getTermsCondition() async {
    return await ApiService.get(AppUrls.termsCondition);
  }

  static Future<ApiResponseModel> getPrivacyPolicy() async {
    return await ApiService.get(AppUrls.privacyPolicy);
  }
}