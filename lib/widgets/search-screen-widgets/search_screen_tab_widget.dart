import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/search-place-screens/saved_places_screen.dart';

class SearchScreenTabButtons extends StatelessWidget {
  const SearchScreenTabButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        ElevatedButton(
          onPressed: (){
            Get.back();
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.grey.shade500,
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            side: const BorderSide(
              color: Colors.black12,
              width: 1,
            ),

          ),

          child: Row(
            children: [
              Image.asset('assets/images/tab_icon_one_2.png', scale: 3.4,),
              SizedBox(width: 6,),
              Text('select_from_map'.tr, style: TextStyle(

                  fontSize: 15

              ),)
            ],
          ),
        ),

        SizedBox(width: 12),

        ElevatedButton(
          onPressed: (){
            Get.to(()=> SavedPlacesScreen());
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.grey.shade500,
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            side: const BorderSide(
              color: Colors.black12,
              width: 1,
            ),

          ),
          child: Row(
            children: [
              Image.asset('assets/images/saved_icon_2.png', scale: 4.8,),
              SizedBox(width: 6,),
              Text('saved_places'.tr, style: TextStyle(

                  fontSize: 15

              ),)
            ],
          ),
        ),
      ],
    );
  }
}