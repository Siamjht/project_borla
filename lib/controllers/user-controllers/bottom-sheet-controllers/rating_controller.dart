
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../services/api_service.dart';
import '../../../../utils/app_urls.dart';
import '../../../../screens/home-screens/thank_you_screen.dart';
import '../../../role/components/customSnackbar/custom_snackbar.dart';

class RatingController extends GetxController {
  final RxDouble currentRating = 3.0.obs;
  final TextEditingController feedbackController = TextEditingController();
  final RxBool isLoading = false.obs;

  Future<void> postRating({required String bookingId}) async {
    if (bookingId.isEmpty) {
      CustomSnackbar.error('Booking ID is missing');
      return;
    }

    isLoading.value = true;
    try {
      final response = await ApiService.post(
        AppUrls.postRatings,
        body: {
          "bookingId": bookingId,
          "rating": currentRating.value,
          "feedback": feedbackController.text.trim(),
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        CustomSnackbar.success(response.message);
        Get.offAll(() => const ThankYouScreen());
      } else {
        Get.offAll(() => const ThankYouScreen());
        CustomSnackbar.error(response.message ?? 'Failed to submit review');
      }
    } catch (e) {
      debugPrint('Error posting rating: $e');
      CustomSnackbar.error('Failed to submit review');
    } finally {
      isLoading.value = false;
    }
  }

  // Legacy fields if needed by UI
  final RxBool isStarSelectedOne = false.obs;
  final RxBool isStarSelectedTwo = false.obs;
  final RxBool isStarSelectedThree = false.obs;
  final RxBool isStarSelectedFour = false.obs;
  final RxBool isStarSelectedFive = false.obs;

  late RxMap<String, bool> ratingList = {
    'starOne': false,
    'starTwo': false,
    'starThree': false,
    'starFour': false,
    'starFive': false,
  }.obs;
}
