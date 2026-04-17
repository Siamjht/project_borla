import 'package:get/get.dart';
import 'package:project_borla/screens/home-screens/user_nav_bar.dart';
import '../../models/radio_enums.dart';
import '../../role/components/customSnackbar/custom_snackbar.dart';
import '../../services/api_service.dart';
import '../../utils/app_urls.dart';

class CancelRideController extends GetxController{

  final RxInt cancelOption = (-1).obs ;
  final Rx<Frequency> selectedValue = Frequency.opn1.obs;

  final RxBool isCancelLoading = false.obs;
  Future<void> cancelRide({required String bookingId, String reason = "i dont like it"}) async {
    isCancelLoading.value = true;
    try {
      final response = await ApiService.patch(
        AppUrls.declineBooking(id: bookingId),
        body: {"reason": reason},
      );

      if (response.statusCode == 200) {
        CustomSnackbar.success(response.message);
        Future.delayed(Duration(milliseconds: 300), () => Get.offAll(UserNavBar()) );
      } else {
        CustomSnackbar.error(response.message);
      }
    } finally {
      isCancelLoading.value = false;
    }
  }

}