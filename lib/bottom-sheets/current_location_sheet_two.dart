import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project_borla/bottom-sheets/confirm_address_home_sheet.dart';
import 'package:project_borla/bottom-sheets/confirm_address_hotel_sheet.dart';

import '../widgets/custom_text_field.dart';

class CurrentLocationSheetTwo extends StatefulWidget {
  const CurrentLocationSheetTwo({super.key});

  @override
  State<CurrentLocationSheetTwo> createState() => _CurrentLocationSheetTwoState();
}

class _CurrentLocationSheetTwoState extends State<CurrentLocationSheetTwo> {


  void ShowConfirmAddressHomeSheet (BuildContext context) {

    showModalBottomSheet(

      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      //showDragHandle: true,
      useSafeArea: true,
      builder: (context) => ConfirmAddressHomeSheet(),

    );

  }

  void ShowConfirmAddressHotelSheet (BuildContext context) {

    showModalBottomSheet(

      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      //showDragHandle: true,
      useSafeArea: true,
      builder: (context) => ConfirmAddressHotelSheet(),

    );

  }


  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),

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

            const SizedBox(height: 16),


            Text('Current location...', style: TextStyle(

                fontSize: 22,

                fontWeight: FontWeight.w500

            ),),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.fromLTRB(22,0,22,0),
              child: Divider(
                color: Colors.grey.shade400,
                thickness: 1,
              ),
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.fromLTRB(22,0,22,0),
              child: CustomTextField(
                hint: '2nd Crescent Link, Ghana',
                prefix: Image.asset('assets/images/fourth_pin.png'),
                suffix: Image.asset('assets/images/cross.png'),

              ),
            ),

            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Row(

                children: [

                  Image.asset('assets/images/saved_icon_2.png', scale: 0.8,),

                  SizedBox(width: 8,),

                  Text('Saved Places', style: TextStyle(

                    fontSize: 18,
                    fontWeight: FontWeight.w500,


                  ),),
                  Spacer(),

                  Image.asset('assets/images/add_button.png'),

                ],


              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ShowConfirmAddressHomeSheet(context);
                        },
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                            color: Colors.amber,
                            width: 1,
                          ),
                          elevation: 0,
                          backgroundColor: Colors.white,


                        ),
                        child: Row(

                          children: [

                            Image.asset('assets/images/map_home.png', scale: 0.8),
                            SizedBox(width: 4),
                            Text('Home', style: TextStyle(

                              color: Colors.grey.shade500,
                              fontSize: 16

                            ))


                          ],

                        ),

                    ),
                  ),

                  SizedBox(height: 10,),

                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.amber,
                          width: 1,
                        ),
                        elevation: 0,
                        backgroundColor: Colors.white,


                      ),
                      child: Row(

                        children: [

                          Image.asset('assets/images/map_office.png', scale: 0.8),
                          SizedBox(width: 4),
                          Text('Office', style: TextStyle(

                              color: Colors.grey.shade500,
                              fontSize: 16

                          ))


                        ],

                      ),

                    ),
                  ),

                  SizedBox(height: 10,),


                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.amber,
                          width: 1,
                        ),
                        elevation: 0,
                        backgroundColor: Colors.white,


                      ),
                      child: Row(

                        children: [

                          Image.asset('assets/images/map_shop.png', scale: 0.8),
                          SizedBox(width: 4),
                          Text('Shop', style: TextStyle(

                              color: Colors.grey.shade500,
                              fontSize: 16

                          ))


                        ],

                      ),

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ShowConfirmAddressHotelSheet(context);
                      },
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.amber,
                          width: 1,
                        ),
                        elevation: 0,
                        backgroundColor: Colors.white,


                      ),
                      child: Row(

                        children: [

                          Image.asset('assets/images/map_hotel.png', scale: 0.8),
                          SizedBox(width: 4),
                          Text('Hotel', style: TextStyle(

                              color: Colors.grey.shade500,
                              fontSize: 16

                          ))


                        ],

                      ),

                    ),
                  ),



                ],


              ),
            )



          ],
        )


    );
  }
}
