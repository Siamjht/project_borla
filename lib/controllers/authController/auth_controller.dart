

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/prefs_helper.dart';
import '../../models/authModels/create_user_model.dart';
import '../../models/authModels/login_model.dart';
import '../../role/components/customSnackbar/custom_snackbar.dart';
import '../../services/api_service.dart';
import '../../services/socket_service.dart';
import '../../utils/app_urls.dart';



class AuthController extends GetxController {

  // static String otpTokenKey = 'otpToken';
  // ── Form & Controllers ──
  final formKey = GlobalKey<FormState>();


  // ── Observable States ──
  final RxBool isLoading = false.obs;
  final RxBool isOtpSending = false.obs;
  final RxBool keepLoggedIn = false.obs;
  String email = "";

  // @override
  // void onClose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.onClose();
  // }

  // ── Login Method ──
  Future<bool> login({required String email, required String password}) async {

    isLoading.value = true;

    try {
      final response = await ApiService.post(
        AppUrls.signIn,
        body: {
          "email": email.trim(),
          "password": password.trim(),
        },
      );
      if (response.statusCode == 200) {
        final loginModel = LoginModel.fromJson(Map<String, dynamic>.from(response.body));

        PrefsHelper.token = loginModel.data.accessToken;
        PrefsHelper.userId = loginModel.data.user.id;
        log("Token: ===>>${PrefsHelper.token}");
        log("keepLoggedIn: ===>>${keepLoggedIn.value}");

        if(keepLoggedIn.value){
          await PrefsHelper.setString(
            "token",
            loginModel.data.accessToken,
          );

          await PrefsHelper.setString(
            "refreshToken",
            loginModel.data.refreshToken,
          );
          await PrefsHelper.setString(
            "userId",
            loginModel.data.user.id,
          );
        }
        SocketServices.connectToSocket();
        CustomSnackbar.success(loginModel.message);
        return true;
      } else {
        CustomSnackbar.error(response.message);
        return false;
      }
    } finally {
      isLoading.value = false;
    }
  }

  // ---- Create user method -------
  Future<bool> createUser({
    required String name,
    required String email,
    required String phoneNumber,
    required String address,
    required String password,
    required double latitude,
    required double longitude,
    String? imagePath,
  }) async {
    isLoading.value = true;

    try {

      this.email = email;
      final Map<String, dynamic> body = {
        'data': jsonEncode({
          'name': name,
          'email': email,
          'phoneNumber': phoneNumber,
          'address': address,
          'password': password,
          'location': {
            'type': 'Point',
            'coordinates': [longitude, latitude],
          },
        }),
      };

      final response = await ApiService.multipartRequest(
        url: AppUrls.createUser,
        method: HttpMethod.post,
        body: body,
        imagePath: imagePath,
        imageName: 'profile',
      );

      if (response.statusCode == 200) {
        final model = CreateUserResponseModel.fromJson(
          Map<String, dynamic>.from(response.body),
        );

        PrefsHelper.token = model.data.otpToken;
        CustomSnackbar.success(model.message);
        return true;
      } else {
        CustomSnackbar.error(response.message);
        return false;
      }
    } catch (e) {
      CustomSnackbar.error(e.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Verify Otp

  Future<bool> verifyEmailOTP(String otp) async {
    isLoading.value = true;

    try {
      final response = await ApiService.post(
        AppUrls.verifyOtp,
        headers: {
          'token': PrefsHelper.token,
        },
        body: {"otp": otp},
      );

      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.body['data'] ?? {});

        PrefsHelper.token = data['token'] ?? '';

        // ── Save token ──
        await PrefsHelper.setString(
          PrefsHelper.token,
          data['token'] ?? '',
        );

        CustomSnackbar.success(response.message);
        return true;
      } else {
        CustomSnackbar.error(response.message);
        return false;
      }
    } finally {
      isLoading.value = false;
    }
  }

  /// Forgot Password

  Future<bool> forgotPassword(String email) async {
    isLoading.value = true;

    try {
      this.email = email;

      final response = await ApiService.patch(
        AppUrls.forgotPassword,
        body: {"email": email},
      );

      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.body['data'] ?? {});

        PrefsHelper.token = data['token'] ?? '';

        CustomSnackbar.success(response.message);
        return true;

      } else {
        CustomSnackbar.error(response.message);
        return false;
      }
    } finally {
      isLoading.value = false;
    }
  }

  /// Reset password

  Future<bool> resetPassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    isLoading.value = true;

    try {
      final response = await ApiService.patch(
        AppUrls.resetPassword,
        headers: {
          'token': PrefsHelper.token,
        },
        body: {
          "newPassword": newPassword,
          "confirmPassword": confirmPassword,
        },
      );

      if (response.statusCode == 200) {
        CustomSnackbar.success(response.message);
        return true;
      } else {
        CustomSnackbar.error(response.message);
        return false;
      }
    } finally {
      isLoading.value = false;
    }
  }

  /// Resend OTP

  Future<bool> resendOtp(String email) async {
    isOtpSending.value = true;

    try {
      final response = await ApiService.post(
        AppUrls.resendOtp,
        body: {"email": email},
      );

      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.body['data'] ?? {});

        PrefsHelper.token = data['token'] ?? '';
        // ── Update OTP token ──
        // await PrefsHelper.setString(
        //   PrefsHelper.tempToken,
        //   data['token'] ?? '',
        // );

        CustomSnackbar.success(response.message);
        return true;

      } else {
        CustomSnackbar.error(response.message);
        return false;
      }
    } finally {
      isOtpSending.value = false;
    }
  }

}
