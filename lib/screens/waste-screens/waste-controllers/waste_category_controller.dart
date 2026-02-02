import 'package:get/get.dart';

class WasteCategoryController extends GetxController{

  final RxInt selectedIndex = (-1).obs ;

  void changeIndex (int index) {

    selectedIndex.value = index ;

  }

  final RxMap<String,String> FormValues={

    "Size": "",
    "Qty": "",


  }.obs;

}