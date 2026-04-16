
import 'dart:developer';

import 'package:get/get.dart';
import '../../../../models/riderModels/earnings_model.dart';
import '../../../../services/api_service.dart';
import '../../../../utils/app_urls.dart';
import '../../../components/customSnackbar/custom_snackbar.dart';

class EarningsController extends GetxController {
  /// 0 = Today, 1 = Weekly, 2 = Monthly
  final selectedTab = 2.obs;

  final isLoading = false.obs;
  final earningsData = EarningsModel().obs;

  @override
  void onInit() {
    super.onInit();
    getEarnings();
  }

  void changeTab(int index) {
    selectedTab.value = index;
    getEarnings();
  }

  Future<void> getEarnings() async {
    isLoading.value = true;
    
    String filter = 'monthly';
    if (selectedTab.value == 0) {
      filter = 'today';
    } else if (selectedTab.value == 1) {
      filter = 'weekly';
    }

    try {
      final response = await ApiService.get(
        AppUrls.getMyEarnings(filter: filter),
      );

      if (response.statusCode == 200) {
        earningsData.value = EarningsModel.fromJson(response.body['data'] ?? {});
      } else {
        CustomSnackbar.error(response.message);
      }
    } catch (e) {
      log("Something went wrong $e");
      CustomSnackbar.error("Something went wrong $e");
    } finally {
      isLoading.value = false;
    }
  }
}
