
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/api_service.dart';
import '../../models/authModels/login_model.dart';
import '../../models/profileModel/profile_response_model.dart';
import '../../role/components/customSnackbar/custom_snackbar.dart';
import '../../utils/app_urls.dart';

class ProfileController extends GetxController {
  // ── State ──
  final Rx<UserModel> profile = UserModel.fromJson({}).obs;
  final RxBool isLoading = false.obs;
  final RxBool isUpdating = false.obs;

  // ── Form Controllers ──
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final bioController = TextEditingController();
  final genderController = TextEditingController();
  final dateOfBirthController = TextEditingController();

  // ── Image ──
  final RxString imagePath = ''.obs;


  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }

  // ── Populate form fields from profile ──
  void _populateFields(UserModel user) {
    nameController.text = user.name;
    phoneController.text = user.phoneNumber;
    addressController.text = user.address;
    imagePath.value = user.profile;
  }

  // ── Get Profile ──
  Future<void> getProfile() async {
    isLoading.value = true;

    try {
      final response = await ApiService.get(AppUrls.getMyProfile);

      if (response.statusCode == 200) {
        final model = ProfileResponseModel.fromJson(
          Map<String, dynamic>.from(response.body),
        );
        profile.value = model.data;
        _populateFields(model.data);
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isLoading.value = false;
    }
  }

  // ── Update Profile ──
  Future<void> updateProfile({
    required double latitude,
    required double longitude,
  }) async {
    isUpdating.value = true;

    try {
      final Map<String, dynamic> body = {
        'name': nameController.text.trim(),
        'phoneNumber': phoneController.text.trim(),
        'address': addressController.text.trim(),
        // 'bio': bioController.text.trim(),
        // 'gender': genderController.text.trim(),
        // 'dateOfBirth': dateOfBirthController.text.trim(),
        'location[type]': 'Point',
        'location[coordinates][0]': longitude.toString(),
        'location[coordinates][1]': latitude.toString(),
      };

      final bool isLocalImage = imagePath.value.isNotEmpty &&
          !imagePath.value.startsWith('http');
      final response = await ApiService.multipartRequest(
        url: AppUrls.updateProfile,
        method: HttpMethod.patch,
        body: body,
        imagePath: isLocalImage ? imagePath.value : null,
        imageName: 'profile',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = ProfileResponseModel.fromJson(
          Map<String, dynamic>.from(response.body),
        );
        profile.value = model.data;
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