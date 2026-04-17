
import 'dart:developer';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
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

  // ── State ──────────────────────────────────────────────
  final RxBool isTopUpLoading = false.obs;
  final RxBool isWithdrawLoading = false.obs;
  final Rx<TopUpModel?> topUpData = Rx<TopUpModel?>(null);

// ── Top Up ─────────────────────────────────────────────
  Future<void> topUp({required double amount}) async {
    isTopUpLoading.value = true;
    try {
      final response = await ApiService.post(
        AppUrls.postTopUp,
        body: {'amount': amount},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        topUpData.value = TopUpModel.fromJson(response.body['data']);
        CustomSnackbar.success(response.message);

        // ✅ open checkout URL in browser
        final url = Uri.parse(topUpData.value!.checkoutUrl);
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        } else {
          CustomSnackbar.error('Could not open checkout page');
        }
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isTopUpLoading.value = false;
    }
  }

// ── Withdraw ───────────────────────────────────────────
  Future<void> withdraw({
    required String channel,
    required double amount,
  }) async {
    isWithdrawLoading.value = true;
    try {
      final response = await ApiService.post(
        AppUrls.postWithdraw,
        body: {
          'channel': channel,
          'amount': amount,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        CustomSnackbar.success(response.message);
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isWithdrawLoading.value = false;
    }
  }
}

class TopUpModel {
  final String checkoutUrl;

  TopUpModel({this.checkoutUrl = ''});

  factory TopUpModel.fromJson(Map<String, dynamic> json) {
    return TopUpModel(
      checkoutUrl: json['checkoutUrl'] ?? '',
    );
  }
}
