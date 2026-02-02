import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ProfileControllerCopy extends GetxController {
  final ImagePicker _picker = ImagePicker();

  //change password controller

  final TextEditingController passController = TextEditingController();

  /// Text Controllers
  final nameController = TextEditingController(text: 'Cleopas Owusu');
  final phoneController = TextEditingController();
  final dobController = TextEditingController(text: '31 / 01 / 1995');
  final locationController = TextEditingController(text: 'Accra, Ghana');

  /// Images
  final Rx<File?> profileImage = Rx<File?>(null);
  final Rx<File?> ghanaCardImage = Rx<File?>(null);

  /// Pick image
  Future<void> pickImage({required bool isProfile}) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      if (isProfile) {
        profileImage.value = file;
      } else {
        ghanaCardImage.value = file;
      }
    }
  }

  /// Pick date
  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1995),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      dobController.text =
      '${picked.day.toString().padLeft(2, '0')} / '
          '${picked.month.toString().padLeft(2, '0')} / '
          '${picked.year}';
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    dobController.dispose();
    locationController.dispose();
    super.onClose();
  }
}