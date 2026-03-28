
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../helpers/prefs_helper.dart';
import '../../models/authModels/create_user_model.dart';
import '../../models/authModels/login_model.dart';
import '../../role/components/customSnackbar/custom_snackbar.dart';
import '../../role/components/navBar/nav_bar.dart';
import '../../screens/home-screens/user_nav_bar.dart';
import '../../services/api_service.dart';
import '../../services/socket_service.dart';
import '../../utils/app_urls.dart';



class AuthController extends GetxController {

  static AuthController get instance => Get.put(AuthController());

  // static String otpTokenKey = 'otpToken';
  // ── Form & Controllers ──
  final formKey = GlobalKey<FormState>();


  // ── Observable States ──
  final RxBool isLoading = false.obs;
  final RxBool isOtpSending = false.obs;
  final RxBool keepLoggedIn = false.obs;

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneNumController = PhoneController();
  final addressController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  final roleController = TextEditingController();
  final dobController = TextEditingController();
  final otpController = TextEditingController();

  TextEditingController isoDateController = TextEditingController();
  // ── Image ──
  final RxString imagePath = ''.obs;
  final RxString ghanaICard = ''.obs;
  final Rx<User> profile = User.fromJson({}).obs;

  RxString selectedRole = "".obs;


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
        final loginModel = LoginResponseModel.fromJson(Map<String, dynamic>.from(response.body));

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
          await PrefsHelper.setString(
            "myRole",
              loginModel.data.user.role
          );
        }
        if(loginModel.data.user.role == "user"){
          Get.to(()=>UserNavBar());
        }else{
          Get.to(()=>DriverNavbar());
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
  Future<bool> createUser() async {
    isLoading.value = true;

    try {


      final Map<String, dynamic> body = {
          'email': emailController.text,
          'name': nameController.text,
          'phoneNumber': phoneNumController.value.international.toString(),
          'password': passController.text,
          'confirmPassword': confirmPassController.text,
          'locationName': addressController.text,
          'role': selectedRole.value.toLowerCase(),
      };

      final response = await ApiService.post(AppUrls.createUser, body: body,);

      if (response.statusCode == 200) {
        CreateUserResponseModel model =
        CreateUserResponseModel.fromJson(Map<String, dynamic>.from(response.body));

        PrefsHelper.myEmail = model.data.email;
        PrefsHelper.token = model.data.verificationToken;
        log("response: ${PrefsHelper.token}, ${PrefsHelper.myEmail}");
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

  // ------- Create Driver method ------
  Future<bool> createDriver() async {
    isLoading.value = true;

    try {


      final Map<String, dynamic> body = {
          'email': emailController.text,
          'name': nameController.text,
          'phoneNumber': phoneNumController.value.international.toString(),
          'password': passController.text,
          'confirmPassword': confirmPassController.text,
          'dateOfBirth': isoDateController.text,
          'locationName': addressController.text,
          'role': selectedRole.value.toLowerCase(),
        };

      final response = await ApiService.multipartRequest(
        url: AppUrls.createUser,
        method: HttpMethod.post,
        body: body,
        imagePath: ghanaICard.value,
        imageName: 'ghanaCardId',
      );

      if (response.statusCode == 200) {
        CreateUserResponseModel model =
        CreateUserResponseModel.fromJson(Map<String, dynamic>.from(response.body));

        PrefsHelper.myEmail = model.data.email;
        PrefsHelper.token = model.data.verificationToken;
        log("response: ${PrefsHelper.token}, ${PrefsHelper.myEmail}");
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
  Future<bool> verifyEmailOTP(String otp,) async {
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
      PrefsHelper.myEmail = email;

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
