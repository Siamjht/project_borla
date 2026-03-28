import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project_borla/role/components/text/common_text.dart';
import 'package:project_borla/screens/search-place-screens/saved_places_screen.dart';
import 'package:project_borla/screens/search-place-screens/search-address-controllers/location_search_controller.dart';
import 'package:project_borla/theme/app_color.dart';

import '../../gen/custom_assets/assets.gen.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/search-screen-widgets/search_screen_header_widget.dart';
import '../../widgets/search-screen-widgets/search_screen_tab_widget.dart';
import '../confirm-location-screens/confirm_location_screen.dart';
import '../profile-screens/profile_screen_user.dart';

class LocationSearchScreenTwo extends StatefulWidget {
  const LocationSearchScreenTwo({super.key});

  @override
  State<LocationSearchScreenTwo> createState() => _LocationSearchScreenTwoState();
}

class _LocationSearchScreenTwoState extends State<LocationSearchScreenTwo> {

  LocationSearchTwoController locationSearchTwoController = Get.put(LocationSearchTwoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(

          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.fitWidth,
                //alignment: Alignment.topRight,
              ),
            ),

            Padding(
              //padding: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.fromLTRB(22, 72, 22, 22),
              child: Column(
                children: [

                  SearchScreenHeaderSection(),

                  SizedBox(height: 36),

                  CustomTextField(
                    controller: locationSearchTwoController.addressController,
                    hint: '2nd Crescent Link, Ghana',
                    prefix: Image.asset('assets/images/fourth_pin.png'),
                    suffix: InkWell(
                        onTap: (){
                          locationSearchTwoController.addressController.clear();
                        },
                        child: Image.asset('assets/images/cross.png')
                    ),

                  ),

                  SizedBox(height: 14),

                  SearchScreenTabButtons(),

                  SizedBox(height: 22),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Recent Places', style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54
                      ),),

                      SizedBox(width: 26),

                      InkWell(
                        onTap: (){
                          locationSearchTwoController.clearController.clearAll();
                        },
                        child: Text('Clear All', style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Colors.amber,
                        ),),
                      ),

                    ],
                  ),

                  SizedBox(height: 22),

                  Expanded(

                    child: Obx(
                          ()=> locationSearchTwoController.clearController.isClear.value?
                          SizedBox()
                        : ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Get.to(()=>ConfirmLocationScreen());
                          },
                          child: Padding(
                            //padding: const EdgeInsets.only(bottom: 12.0),
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 12,
                              children: [
                                Icon(Icons.access_time, color: AppColors.gray400,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CommonText(text: 'Office', color: AppColors.gray500, fontSize: 14, fontWeight: FontWeight.w500,),
                                      SizedBox(height: 8,),
                                      CommonText(text: '2910 Parker Rd. AllenTown, New Mexico 31134', color: AppColors.gray500, fontSize: 12, fontWeight: FontWeight.w400,)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },) ,),
                  ),

                ],
              ),
            )

          ],
        )
    );
  }
}



