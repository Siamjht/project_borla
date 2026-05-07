import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/screens/search-place-screens/search-address-controllers/location_search_controller.dart';

import '../../gen/custom_assets/assets.gen.dart';
import '../../theme/app_color.dart';
import '../../widgets/action_button_widget.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/search-screen-widgets/edit_place_text_field_widget.dart';

class EditPlace extends StatefulWidget {
  const EditPlace({super.key});

  @override
  State<EditPlace> createState() => _EditPlaceState();
}

class _EditPlaceState extends State<EditPlace> {


  EditPlaceController editPlaceController = Get.find<EditPlaceController>();

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

                  Text('edit_place'.tr, style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500
                  ),)
                ],
              ),
            ),

            SizedBox(height: 20,),

            Image.asset('assets/images/map_2.png' , scale: 1.8),

            SizedBox(height: 40),

            Obx(() => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconLabelAction(
                      icon: Assets.icons.homeIcon.image(height: 26, width: 26, color: editPlaceController.selectedPlace.value == 'Home' ? AppColors.orange300 : AppColors.gray300,),
                      label: 'home'.tr,
                      selected: editPlaceController.selectedPlace.value == 'Home' ? true : false,
                      onTap: (){
                        editPlaceController.titleController.text = 'Home';
                        editPlaceController.selectedPlace.value = 'Home';
                      }
                  ),
                  IconLabelAction(
                      icon: Assets.icons.officeIcon.image(height: 26, width: 26, color: editPlaceController.selectedPlace.value == 'Office' ? AppColors.orange300 : AppColors.gray300,),
                      label: 'office'.tr,
                      selected: editPlaceController.selectedPlace.value == 'Office' ? true : false,
                      onTap: (){
                        editPlaceController.titleController.text = 'Office';
                        editPlaceController.selectedPlace.value = 'Office';
                      }
                  ),
                  IconLabelAction(
                      icon: Assets.icons.shopIcon.image(height: 26, width: 26, color: editPlaceController.selectedPlace.value == 'Shop' ? AppColors.orange300 : AppColors.gray300,),
                      label: 'shop'.tr,
                      selected: editPlaceController.selectedPlace.value == 'Shop' ? true : false,
                      onTap: (){
                        editPlaceController.titleController.text = 'Shop';
                        editPlaceController.selectedPlace.value = 'Shop';
                      }
                  ),
                  IconLabelAction(
                      icon: Assets.icons.hotelIcon.image(height: 26, width: 26, color: editPlaceController.selectedPlace.value == 'Hotel' ? AppColors.orange300 : AppColors.gray300),
                      label: 'hotel'.tr,
                      selected: editPlaceController.selectedPlace.value == 'Hotel' ? true : false,
                      onTap: (){
                        editPlaceController.titleController.text = 'Hotel';
                        editPlaceController.selectedPlace.value = 'Hotel';
                      }
                  ),
                ],

              ),
            ),),

            Padding(
              padding: const EdgeInsets.fromLTRB(22,20,22,20),
              child: EditPlaceTextFields(editPlaceController: editPlaceController),
            ),

          ],
        ),
      ),
    );
  }
}


