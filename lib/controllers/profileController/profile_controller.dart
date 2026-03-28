
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/helpers/other_helper.dart';
import '../../../services/api_service.dart';
import '../../models/authModels/login_model.dart';
import '../../role/components/customSnackbar/custom_snackbar.dart';
import '../../utils/app_urls.dart';

class ProfileController extends GetxController {
  // ── State ──
  // final Rx<UserModel> profile = UserModel.fromJson({}).obs;
  final RxBool isLoading = false.obs;
  final RxBool isUpdating = false.obs;

  // ── Form Controllers ──
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final bioController = TextEditingController();
  final genderController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  TextEditingController isoDateController = TextEditingController();

  // ── Image ──
  final RxString imagePath = ''.obs;
  final RxString ghanaICard = ''.obs;
  final Rx<User> profile = User.fromJson({}).obs;


  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }

//  ── Populate form fields from profile ──
  void _populateFields(User user) {
    nameController.text = user.name;
    phoneController.text = user.phoneNumber;
    addressController.text = user.locationName;
    if(user.dateOfBirth.isNotEmpty){
      dateOfBirthController.text = OtherHelper.formatDate(isoDate: user.dateOfBirth);
      isoDateController.text = user.dateOfBirth;
    }
    imagePath.value = user.profilePicture;
    if(user.ghanaCardId.isNotEmpty){
      ghanaICard.value = user.ghanaCardId.first;
    }
  }

  // ── Get Profile ──
  Future<void> getProfile() async {
    isLoading.value = true;

    try {
      final response = await ApiService.get(AppUrls.getMyProfile);

      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.body['data'] ?? {});
        final model = User.fromJson(data);
        profile.value = model;
        log("Profile name: ${profile.value.name}");
        _populateFields(model);
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isLoading.value = false;
    }
  }

  // ── Update Profile ──
  Future<void> updateProfile({
     double latitude = 23.05896,
     double longitude = 90.23889,
    bool isUser = false,
  }) async {
    isUpdating.value = true;

    try {
      final Map<String, dynamic> body = isUser? {
        'name': nameController.text.trim(),
        'phoneNumber': phoneController.text.trim(),
        'locationName': addressController.text.trim(),
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
      }: {
        'name': nameController.text.trim(),
        'phoneNumber': phoneController.text.trim(),
        'locationName': addressController.text.trim(),
        'dateOfBirth': isoDateController.text.trim(),
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
      };

      // final bool isLocalImage = imagePath.value.isNotEmpty &&
      //     !imagePath.value.startsWith('http');
      final response = await ApiService.multipartRequestWithMultipleImages(
        url: AppUrls.updateProfile,
        method: HttpMethod.patch,
        body: body,

        imageList:  isUser?
        [{
          'imagePath': imagePath.value,
          'imageName': 'profilePicture',
        }] : [{
          'imagePath': imagePath.value,
          'imageName': 'profilePicture',
        },
          {
            'imagePath': ghanaICard.value,
            'imageName': 'ghanaCardId',
          },
        ],
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = User.fromJson(
          Map<String, dynamic>.from(response.body['data']),
        );
        profile.value = model;
        _populateFields(model);
        Get.back();
        await Future.delayed(const Duration(milliseconds: 300));
        CustomSnackbar.success(response.message);
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isUpdating.value = false;
    }
  }
}