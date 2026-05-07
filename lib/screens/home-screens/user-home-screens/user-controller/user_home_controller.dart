import 'package:get/get.dart';
import 'package:project_borla/helpers/other_helper.dart';
import 'package:project_borla/theme/app_color.dart';
import 'package:flutter/material.dart';


class UserHomeController extends GetxController
    with GetTickerProviderStateMixin {
  static UserHomeController get instance => Get.find<UserHomeController>();

  final RxBool isOnline = false.obs;
  final RxBool isScheduleRequest = true.obs;

  ////////////////////////////////////
  final isExpanded = false.obs;

  void toggle() {
    isExpanded.toggle();
  }

  ////////////////////////////////////
  late AnimationController _animationController;
  late Animation<double> animation;

  RxInt durationInSeconds = 30.obs;
  RxInt remainingSeconds = 30.obs;

  var jobRequests = <JobRequestModel>[].obs;
  RxBool isBottomSheet = false.obs;

  @override
  void onInit() {
    super.onInit();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animation = AlwaysStoppedAnimation(1.0);
    jobRequests.addAll(
      List.generate(3, (index) => JobRequestModel(id: index)),
    );
  }


  ///////////////////////////////////////////////
  // final RxBool showSearchSheet = true.obs;
  // TextEditingController currentLocationController = TextEditingController();
  //
  // Future<void> fetchCurrentLocation() async {
  //   final address = await OtherHelper.getCurrentLocationAddress();
  //   if(address.isNotEmpty){
  //     currentLocationController.text = address;
  //     showSearchSheet.value = false;
  //   }
  // }

  @override
  void onClose() {
    _animationController.dispose();
    super.onClose();
  }
}


class JobRequestModel {
  final int id;
  JobRequestModel({required this.id});
}
