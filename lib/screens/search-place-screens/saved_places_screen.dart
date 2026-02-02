import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_borla/screens/search-place-screens/search-address-controllers/location_search_controller.dart';

import '../../gen/custom_assets/assets.gen.dart';
import '../../theme/app_color.dart';
import '../../widgets/action_button_widget.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/search-screen-widgets/saved_place_text_field_widget.dart';

class SavedPlacesScreen extends StatefulWidget {
  const SavedPlacesScreen({super.key});

  @override
  State<SavedPlacesScreen> createState() => _SavedPlacesScreenState();
}

class _SavedPlacesScreenState extends State<SavedPlacesScreen> {

  SavedPlaceController savedPlaceController = Get.put(SavedPlaceController());

  bool isHome = false;
  bool isOffice = false;
  bool isShop = false;
  bool isHotel = false;

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
                          icon: Assets.icons.homeIcon.image(height: 26, width: 26, color: savedPlaceController.selectedPlace.value == 'Home' ? AppColors.orange300 : AppColors.gray300,),
                          label: 'Home',
                          selected: savedPlaceController.selectedPlace.value == 'Home' ? true : false,
                          onTap: (){
                            savedPlaceController.titleController.text = 'Home';
                            savedPlaceController.selectedPlace.value = 'Home';
                          }
                      ),
                      IconLabelAction(
                          icon: Assets.icons.officeIcon.image(height: 26, width: 26, color: savedPlaceController.selectedPlace.value == 'Office' ? AppColors.orange300 : AppColors.gray300,),
                          label: 'Office',
                          selected: savedPlaceController.selectedPlace.value == 'Office' ? true : false,
                          onTap: (){
                            savedPlaceController.titleController.text = 'Office';
                            savedPlaceController.selectedPlace.value = 'Office';
                          }
                      ),
                      IconLabelAction(
                          icon: Assets.icons.shopIcon.image(height: 26, width: 26, color: savedPlaceController.selectedPlace.value == 'Shop' ? AppColors.orange300 : AppColors.gray300,),
                          label: 'Shop',
                          selected: savedPlaceController.selectedPlace.value == 'Shop' ? true : false,
                          onTap: (){
                            savedPlaceController.titleController.text = 'Shop';
                            savedPlaceController.selectedPlace.value = 'Shop';
                          }
                      ),
                      IconLabelAction(
                          icon: Assets.icons.hotelIcon.image(height: 26, width: 26, color: savedPlaceController.selectedPlace.value == 'Hotel' ? AppColors.orange300 : AppColors.gray300),
                          label: 'Hotel',
                          selected: savedPlaceController.selectedPlace.value == 'Hotel' ? true : false,
                          onTap: (){
                            savedPlaceController.titleController.text = 'Hotel';
                            savedPlaceController.selectedPlace.value = 'Hotel';
                          }
                      ),

                    ],



                  ),
                ),),

                Padding(
                  padding: const EdgeInsets.fromLTRB(22,20,22,20),
                  child: SavedPlaceTextFields(savedPlaceController: savedPlaceController),
                ),

              ],
          ),
      ),
    );

  }
}


