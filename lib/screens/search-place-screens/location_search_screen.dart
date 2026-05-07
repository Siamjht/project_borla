import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_text_field.dart';

class LocationSearchScreen extends StatefulWidget {
  const LocationSearchScreen({super.key});

  @override
  State<LocationSearchScreen> createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
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

                Padding(
                  //padding: const EdgeInsets.fromLTRB(26, 70, 20, 20),
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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

                      SizedBox(width: 66),

                      Text('search_address'.tr, style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500
                      ),)
                    ],
                  ),
                ),

                SizedBox(height: 36),

                CustomTextField(
                  hint: '2nd Crescent Link, Ghana',
                  prefix: Image.asset('assets/images/fourth_pin.png'),
                  suffix: Image.asset('assets/images/cross.png'),

                ),

                SizedBox(height: 14),

                Row(
                  children: [

                    Container(
                      width: 160,
                      child: ElevatedButton(
                        onPressed: (){
                          //Get.to(()=>CurrentLocation)
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
                            Image.asset('assets/images/tab_icon_one_2.png', scale: 3,),
                            SizedBox(width: 6,),
                            Text('select_from_map'.tr, style: TextStyle(

                                fontSize: 15

                            ),)
                          ],
                        ),
                      ),
                    ),

                    SizedBox(width: 12),

                    Container(
                      width: 140,
                      child: ElevatedButton(
                        onPressed: (){},
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
                            Image.asset('assets/images/saved_icon_2.png', scale: 3,),
                            SizedBox(width: 6,),
                            Text('saved_places'.tr, style: TextStyle(

                                fontSize: 15

                            ),)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 22),

                Row(
                  children: [
                    Text('results_for'.tr, style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54
                    ),),
                    Text(' "2nd Crescent Link"', style: TextStyle(
                      color: Colors.amber,
                        fontSize: 19,
                        fontWeight: FontWeight.w600
                    ),),

                    SizedBox(width: 26),

                    Text('zero_found'.tr, style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        color: Colors.amber,
                    ),),

                  ],
                ),

                SizedBox(height: 26),

                Image.asset('assets/images/not_found_2.png'),

              ],
            ),
          )

        ],
      )
    );
  }
}
