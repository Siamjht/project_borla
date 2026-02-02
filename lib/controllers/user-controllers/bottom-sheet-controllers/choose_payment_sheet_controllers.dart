import 'package:get/get.dart';

class ChoosePaymentSheetControllers extends GetxController{

  final RxBool isMomo = false.obs ;
  final RxBool isCash = false.obs ;

  final RxInt selectedIndex = (-1).obs ;

  final RxBool isPaymentPicked = false.obs ;


}