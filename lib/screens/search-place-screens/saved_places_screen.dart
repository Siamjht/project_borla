import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/controllers/user-controllers/booking_controller.dart';

import '../../gen/custom_assets/assets.gen.dart';
import '../../theme/app_color.dart';
import '../../widgets/action_button_widget.dart';
import '../../widgets/search-screen-widgets/saved_place_text_field_widget.dart';

class SavedPlacesScreen extends StatefulWidget {
  const SavedPlacesScreen({super.key});

  @override
  State<SavedPlacesScreen> createState() => _SavedPlacesScreenState();
}

class _SavedPlacesScreenState extends State<SavedPlacesScreen> {

  final _bookingCtrl = Get.find<BookingController>();

  @override
  void initState() {
    super.initState();
    _bookingCtrl.selectedPlaceType.value == 'Home';
    _bookingCtrl.selectPlaceType('home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(

            begin: Alignment.topLeft,
            end: Alignment.bottomRight ,
            colors: [
              Color.fromRGBO(255, 246, 217, 1),
              Color.fromRGBO(255, 255, 255, 1),
            ],
          ),
        ),
          child: SingleChildScrollView(
            child: Column(
                children: [
            
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
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
            
                        SizedBox(width: 74),
            
                        Text('Saved Address', style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500
                        ),)
                      ],
                    ),
                  ),
            
                  SizedBox(height: 20,),
            
                  Image.asset('assets/images/map_2.png', scale: 1.8,),
            
                  SizedBox(height: 40),
            
                  Obx(() => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconLabelAction(
                            icon: Assets.icons.homeIcon.image(height: 26, width: 26, color: _bookingCtrl.selectedPlaceType.value == 'Home' ? AppColors.orange300 : AppColors.gray300,),
                            label: 'Home',
                            selected: _bookingCtrl.selectedPlaceType.value == 'Home',
                            onTap: () => _bookingCtrl.selectPlaceType('home'),
                        ),
                        IconLabelAction(
                            icon: Assets.icons.officeIcon.image(height: 26, width: 26, color: _bookingCtrl.selectedPlaceType.value == 'Office' ? AppColors.orange300 : AppColors.gray300,),
                            label: 'Office',
                            selected: _bookingCtrl.selectedPlaceType.value == 'Office',
                            onTap: () => _bookingCtrl.selectPlaceType('office'),
                        ),
                        IconLabelAction(
                            icon: Assets.icons.shopIcon.image(height: 26, width: 26, color: _bookingCtrl.selectedPlaceType.value == 'Shop' ? AppColors.orange300 : AppColors.gray300,),
                            label: 'Shop',
                            selected: _bookingCtrl.selectedPlaceType.value == 'Shop',
                            onTap: () => _bookingCtrl.selectPlaceType('shop'),
                        ),
                        IconLabelAction(
                            icon: Assets.icons.hotelIcon.image(height: 26, width: 26, color: _bookingCtrl.selectedPlaceType.value == 'Hotel' ? AppColors.orange300 : AppColors.gray300),
                            label: 'Hotel',
                            selected: _bookingCtrl.selectedPlaceType.value == 'Hotel',
                            onTap: () => _bookingCtrl.selectPlaceType('hotel'),
                        ),
            
                      ],
            
                    ),
                  ),),
            
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22,20,22,20),
                    child: SavedPlaceTextFields(),
                  ),
            
                ],
            ),
          ),
      ),
    );

  }
}


