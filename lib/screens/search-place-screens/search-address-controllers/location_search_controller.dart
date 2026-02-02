import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LocationSearchController extends GetxController{

  //TextEditingController addressController = TextEditingController();

  final RxBool isClear = false.obs ;

  void clearAll () {

    isClear.value = true;

  }

}

class SavedPlaceController extends GetxController {

  RxString selectedPlace = "".obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController placeNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();


}

class LocationSearchTwoController extends GetxController{

  TextEditingController addressController = TextEditingController();

  LocationSearchController clearController = Get.put(LocationSearchController());


}

class EditPlaceController extends GetxController{


  RxString selectedPlace = "".obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController placeNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

}

class AddPlaceController extends GetxController{

  RxString selectedPlace = "".obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController placeNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();


}