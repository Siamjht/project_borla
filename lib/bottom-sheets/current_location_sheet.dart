import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/controllers/user-controllers/bottom-sheet-controllers/current_location_sheet_controllers.dart';
import 'package:project_borla/role/components/custom_container.dart';
import 'package:project_borla/screens/search-place-screens/add_place_screen.dart';
import 'package:project_borla/screens/search-place-screens/saved_places_screen.dart';
import 'package:project_borla/theme/app_color.dart';

import '../widgets/custom_text_field.dart';

class CurrentLocationSheet extends StatefulWidget {
  //final ScrollController scrollController;

  const CurrentLocationSheet({super.key, });
  //const CurrentLocationSheet({super.key, required this.scrollController});

  @override
  State<CurrentLocationSheet> createState() => _CurrentLocationSheetState();
}

class _CurrentLocationSheetState extends State<CurrentLocationSheet> {


  //TextEditingController locationController = TextEditingController();

  //late final ScrollController scrollController;

  CurrentLocationSheetControllers currentLocationController = Get.put(CurrentLocationSheetControllers());


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),

      child: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            const SizedBox(height: 8),


            Text('Current location...', style: TextStyle(

                fontSize: 22,

                fontWeight: FontWeight.w500

            ),),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.fromLTRB(22,0,22,0),
              child: Divider(
                color: AppColors.gray200,
                thickness: 1,
              ),
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.fromLTRB(22,0,22,0),
              child: CustomTextField(
                controller: currentLocationController.locationController,
                hint: '2nd Crescent Link, Ghana',
                prefix: Image.asset('assets/images/fourth_pin.png'),
                suffix: InkWell(
                    onTap: (){
                      currentLocationController.locationController.clear();
                    },
                    child: Image.asset('assets/images/cross.png'
                    )
                ),

              ),
            ),

            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Row(

                children: [


                  InkWell(
                      onTap: (){
                        Get.to(()=>SavedPlacesScreen());
                        },
                      child: Row(
                        children: [
                          Image.asset('assets/images/saved_icon_2.png', scale: 3.5,),

                          SizedBox(width: 8,),

                          Text('Saved Places', style: TextStyle(

                            fontSize: 18,
                            fontWeight: FontWeight.w500,


                          ),),

                        ],
                      )
                  ),

                  // SizedBox(width: 8,),
                  //
                  // Text('Saved Places', style: TextStyle(
                  //
                  //   fontSize: 18,
                  //   fontWeight: FontWeight.w500,
                  //
                  //
                  // ),),

                  Spacer(),

                  InkWell(
                    onTap: () {
                      Get.to(()=> AddPlaceScreen());
                    },
                    child: CustomContainer(
                      borderRadius: 4,
                      color: AppColors.orange300,
                        child: Icon(Icons.add, color: AppColors.white,)),
                  )

                ],


              ),
            )



          ],
        ),
      )


    );
  }
}
