import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CurrentLocationSheetControllers extends GetxController{

  final RxString currentLocationName = ''.obs ;
  final RxString updatedCurrentLocationName = ''.obs ;

  TextEditingController locationController = TextEditingController();


}