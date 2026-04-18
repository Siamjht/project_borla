
import 'package:get/get.dart';
import '../../../role/components/customSnackbar/custom_snackbar.dart';
import '../../../services/api_service.dart';
import '../../../utils/app_urls.dart';
import '../../role/commonScreens/hubtelPayment/humbtel_webview_screen.dart';


class PaymentController extends GetxController{

  final RxBool isMomo = false.obs ;
  final RxBool isCash = false.obs ;

  final RxInt selectedIndex = (-1).obs ;

  final RxBool isPaymentPicked = false.obs ;

  final RxBool isLoading = false.obs;
  RxBool isHubtelPaySuccess = false.obs;

  Future<bool> initiatePayment({required String bookingId, required bool isCash}) async {
    isLoading.value = true;
    try {
      final url = isCash ? AppUrls.cashPaymentInitiate : AppUrls.cardPaymentInitiate;
      final body = {"bookingId": bookingId};

      final response = await ApiService.post(url, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (!isCash) {
          // Card payment might need to handle the payment URL
          String paymentUrl = response.body['data'];
          Get.to(()=> HumbtelWebViewScreen(url: paymentUrl,));
        }

        CustomSnackbar.success(response.message);
        return true;
      } else {
        CustomSnackbar.error(response.message);
        return false;
      }
    } catch (e) {
      CustomSnackbar.error("Something went wrong $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}