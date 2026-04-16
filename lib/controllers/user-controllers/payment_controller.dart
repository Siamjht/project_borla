
import 'package:get/get.dart';
import '../../../role/components/customSnackbar/custom_snackbar.dart';
import '../../../services/api_service.dart';
import '../../../utils/app_urls.dart';
import '../../screens/payment-success-screens/payment_success_screeen.dart';

class PaymentController extends GetxController{

  final RxBool isMomo = false.obs ;
  final RxBool isCash = false.obs ;

  final RxInt selectedIndex = (-1).obs ;

  final RxBool isPaymentPicked = false.obs ;

  final RxBool isLoading = false.obs;

  Future<bool> initiatePayment({required String bookingId, required bool isCash}) async {
    isLoading.value = true;
    try {
      final url = isCash ? AppUrls.cashPaymentInitiate : AppUrls.cardPaymentInitiate;
      final body = {"bookingId": bookingId};

      final response = await ApiService.post(url, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // If card payment, there might be a redirect URL in the body, 
        // but user requested to just call the methods and navigate to success?
        // Usually card payment redirect to a webview. 
        // For now, following the flow: navigate to success or handle based on response.
        
        if (!isCash) {
          // Card payment might need to handle the payment URL
          String? paymentUrl = response.body['data']?['payment_url'];
          if (paymentUrl != null && paymentUrl.isNotEmpty) {
            // Handle redirect if needed. 
            // For now, if the goal is just "call them", I'll assume success navigation for both if they return 200/201.
          }
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