

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helpers/prefs_helper.dart';
import '../../../services/api_service.dart';
import '../../role/components/customSnackbar/custom_snackbar.dart';
import '../../utils/app_urls.dart';


class SettingController extends GetxController {
  final passwordController = TextEditingController();
  final reasonController = TextEditingController();

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  RxBool isLoading = false.obs;

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