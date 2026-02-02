import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RatingSheetController extends GetxController {

  final RxBool isStarSelectedOne = false.obs ;
  final RxBool isStarSelectedTwo = false.obs ;
  final RxBool isStarSelectedThree = false.obs ;
  final RxBool isStarSelectedFour = false.obs ;
  final RxBool isStarSelectedFive = false.obs ;

  late RxMap<String, bool> ratingList = {

    'starOne' : false,
    'starTwo' : false,
    'starThree' : false,
    'starFour' : false,
    'starFive' : false,


  }.obs ;


}