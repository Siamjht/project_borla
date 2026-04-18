
import 'dart:developer';

import 'package:get/get.dart';
import 'package:project_borla/role/commonScreens/hubtelPayment/humbtel_webview_screen.dart';
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
  final Rx<TopUpModel> topUpData = TopUpModel().obs;

// ── Top Up ─────────────────────────────────────────────
  Future<bool> topUp({required double amount}) async {
    isTopUpLoading.value = true;
    try {
      final response = await ApiService.post(
        AppUrls.postTopUp,
        body: {'amount': amount},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        topUpData.value = TopUpModel.fromJson(response.body['data']);
        CustomSnackbar.success(response.message);

        Get.to(()=> HumbtelWebViewScreen(url: topUpData.value.checkoutUrl));

        // ✅ open checkout URL in browser
        // final url = Uri.parse(topUpData.value.checkoutUrl);
        // if (await canLaunchUrl(url)) {
        //   await launchUrl(url, mode: LaunchMode.externalApplication);
        // } else {
        //   CustomSnackbar.error('Could not open checkout page');
        // }
        return true;
      } else {
        CustomSnackbar.error(response.message);
        return false;
      }
    } finally {
      isTopUpLoading.value = false;
    }
  }

// ── Withdraw ───────────────────────────────────────────
  final Rx<WithdrawModel> withdrawData = WithdrawModel().obs;
  Future<bool> withdraw({
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
        withdrawData.value = WithdrawModel.fromJson(response.body['data']);
        CustomSnackbar.success(
          withdrawData.value.data.description,
        );
        return true;
      } else {
        return false;
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

class WithdrawModel {
  final String responseCode;
  final WithdrawDataModel data;

  WithdrawModel({
    this.responseCode = '',
    WithdrawDataModel? data,
  }) : data = data ?? WithdrawDataModel();

  factory WithdrawModel.fromJson(Map<String, dynamic> json) {
    return WithdrawModel(
      responseCode: json['ResponseCode'] ?? '',
      data: json['Data'] != null
          ? WithdrawDataModel.fromJson(json['Data'])
          : null,
    );
  }
}

class WithdrawDataModel {
  final double amountDebited;
  final String transactionId;
  final String clientReference;
  final String description;
  final String externalTransactionId;
  final double amount;
  final double charges;
  final String? recipientName;

  WithdrawDataModel({
    this.amountDebited = 0,
    this.transactionId = '',
    this.clientReference = '',
    this.description = '',
    this.externalTransactionId = '',
    this.amount = 0,
    this.charges = 0,
    this.recipientName,
  });

  factory WithdrawDataModel.fromJson(Map<String, dynamic> json) {
    return WithdrawDataModel(
      amountDebited: (json['AmountDebited'] as num?)?.toDouble() ?? 0,
      transactionId: json['TransactionId'] ?? '',
      clientReference: json['ClientReference'] ?? '',
      description: json['Description'] ?? '',
      externalTransactionId: json['ExternalTransactionId'] ?? '',
      amount: (json['Amount'] as num?)?.toDouble() ?? 0,
      charges: (json['Charges'] as num?)?.toDouble() ?? 0,
      recipientName: json['RecipientName'],
    );
  }
}
