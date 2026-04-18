import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/controllers/user-controllers/booking_controller.dart';
import 'package:project_borla/theme/app_color.dart';
import 'package:project_borla/theme/gradient_scaffold_copy.dart';

import '../../gen/custom_assets/assets.gen.dart';
import '../../widgets/action_button_widget.dart';
import '../../widgets/search-screen-widgets/add_place_text_field_widget.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {

  final _bookingCtrl = Get.find<BookingController>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _bookingCtrl.clearPlaceForm();
    },);
  }

  @override
  Widget build(BuildContext context) {
    return UserGradientScaffold(child: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(26, 70, 20, 20),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration:  BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                        color: Colors.black.withAlpha(40),
                      ),
                    ],
                  ),

                  child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 22,
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),

                SizedBox(width: 90),

                Text('Add Place', style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500
                ),)
              ],
            ),
          ),

          SizedBox(height: 20,),

          Image.asset('assets/images/map_2.png', scale: 1.8,),

          SizedBox(height: 20),

          Obx(() => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconLabelAction(
                    icon: Assets.icons.homeIcon.image(height: 26, width: 26, color: _bookingCtrl.selectedPlaceType.value == 'Home' ? AppColors.orange300 : AppColors.gray300,),
                    label: 'Home',
                    selected: _bookingCtrl.selectedPlaceType.value == 'Home',
                    onTap: () {
                      _bookingCtrl.selectedPlaceType.value = 'Home';
                      _bookingCtrl.placeTitleController.text = 'Home';
                    },
                ),
                IconLabelAction(
                    icon: Assets.icons.officeIcon.image(height: 26, width: 26, color: _bookingCtrl.selectedPlaceType.value == 'Office' ? AppColors.orange300 : AppColors.gray300,),
                    label: 'Office',
                    selected: _bookingCtrl.selectedPlaceType.value == 'Office',
                    onTap: () {
                      _bookingCtrl.selectedPlaceType.value = 'Office';
                      _bookingCtrl.placeTitleController.text = 'Office';
                    },
                ),
                IconLabelAction(
                    icon: Assets.icons.shopIcon.image(height: 26, width: 26, color: _bookingCtrl.selectedPlaceType.value == 'Shop' ? AppColors.orange300 : AppColors.gray300,),
                    label: 'Shop',
                    selected: _bookingCtrl.selectedPlaceType.value == 'Shop',
                    onTap: () {
                      _bookingCtrl.selectedPlaceType.value = 'Shop';
                      _bookingCtrl.placeTitleController.text = 'Shop';
                    },
                ),
                IconLabelAction(
                    icon: Assets.icons.hotelIcon.image(height: 26, width: 26, color: _bookingCtrl.selectedPlaceType.value == 'Hotel' ? AppColors.orange300 : AppColors.gray300),
                    label: 'Hotel',
                    selected: _bookingCtrl.selectedPlaceType.value == 'Hotel',
                    onTap: () {
                      _bookingCtrl.selectedPlaceType.value = 'Hotel';
                      _bookingCtrl.placeTitleController.text = 'Hotel';
                    },
                ),

              ],

            ),
          ),),

          Padding(
            padding: const EdgeInsets.fromLTRB(22,20,22,20),
            child: AddPlaceTextFields(),
          ),

        ],
      ),
    ));
  }
}


