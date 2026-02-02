import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/screens/search-place-screens/search-address-controllers/location_search_controller.dart';
import 'package:project_borla/theme/app_color.dart';
import 'package:project_borla/theme/gradient_scaffold_copy.dart';

import '../../gen/custom_assets/assets.gen.dart';
import '../../widgets/action_button_widget.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/search-screen-widgets/add_place_text_field_widget.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {


  AddPlaceController addPlaceController = Get.put(AddPlaceController());

  @override
  Widget build(BuildContext context) {
    return UserGradientScaffold(child: Column(
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

        SizedBox(height: 40),

        Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconLabelAction(
                  icon: Assets.icons.homeIcon.image(height: 26, width: 26, color: addPlaceController.selectedPlace.value == 'Home' ? AppColors.orange300 : AppColors.gray300,),
                  label: 'Home',
                  selected: addPlaceController.selectedPlace.value == 'Home' ? true : false,
                  onTap: (){
                    addPlaceController.titleController.text = 'Home';
                    addPlaceController.selectedPlace.value = 'Home';
                  }
              ),
              IconLabelAction(
                  icon: Assets.icons.officeIcon.image(height: 26, width: 26, color: addPlaceController.selectedPlace.value == 'Office' ? AppColors.orange300 : AppColors.gray300,),
                  label: 'Office',
                  selected: addPlaceController.selectedPlace.value == 'Office' ? true : false,
                  onTap: (){
                    addPlaceController.titleController.text = 'Office';
                    addPlaceController.selectedPlace.value = 'Office';
                  }
              ),
              IconLabelAction(
                  icon: Assets.icons.shopIcon.image(height: 26, width: 26, color: addPlaceController.selectedPlace.value == 'Shop' ? AppColors.orange300 : AppColors.gray300,),
                  label: 'Shop',
                  selected: addPlaceController.selectedPlace.value == 'Shop' ? true : false,
                  onTap: (){
                    addPlaceController.titleController.text = 'Shop';
                    addPlaceController.selectedPlace.value = 'Shop';
                  }
              ),
              IconLabelAction(
                  icon: Assets.icons.hotelIcon.image(height: 26, width: 26, color: addPlaceController.selectedPlace.value == 'Hotel' ? AppColors.orange300 : AppColors.gray300),
                  label: 'Hotel',
                  selected: addPlaceController.selectedPlace.value == 'Hotel' ? true : false,
                  onTap: (){
                    addPlaceController.titleController.text = 'Hotel';
                    addPlaceController.selectedPlace.value = 'Hotel';
                  }
              ),

            ],

          ),
        ),),

        Padding(
          padding: const EdgeInsets.fromLTRB(22,20,22,20),
          child: AddPlaceTextFields(addPlaceController: addPlaceController),
        ),

      ],
    ));
  }
}


