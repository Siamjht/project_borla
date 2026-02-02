import 'package:get/get.dart';

import '../../models/radio_enums.dart';

class CancelRideController extends GetxController{

  final RxInt cancelOption = (-1).obs ;
  final Rx<Frequency> selectedValue = Frequency.opn1.obs;

}