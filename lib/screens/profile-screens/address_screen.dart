import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/bottom-sheets/delete_address_sheet.dart';
import 'package:project_borla/screens/profile-screens/ps-inner-widgets/address_menu.dart';
import 'package:project_borla/screens/search-place-screens/add_place_screen.dart';
import 'package:project_borla/theme/app_color.dart';
import 'package:project_borla/theme/gradient_scaffold_copy.dart';

import '../../widgets/gradient_button.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {

  @override
  Widget build(BuildContext context) {
    return UserGradientScaffold(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 34,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28),
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

                    SizedBox(width: 100),

                    Text('Address', style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500
                    ),)
                  ],
                ),
              ),
              SizedBox(height: 16,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                    return addressCard();
                  },),
                ),
              ),



              Padding(
                padding: const EdgeInsets.all(22.0),
                child: GradientButton(
                  text: 'Add Address',
                  onPressed: () {
                    Get.to(()=>AddPlaceScreen());
                    //Navigator.pop(context);
                    //ShowPaymentSheet(context);

                  },
                ),
              ),

            ],

          ),
        )
    );
  }

  Widget addressCard() {

    ///adding a menuKey (Global Key) to calculate screen position of the dots icon at runtime

    final GlobalKey menuKey = GlobalKey();


    return Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            height: 140,
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade200)
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(

                    children: [

                      Image.asset('assets/images/location_pin_two.png', scale: 0.8,),
                      SizedBox(width: 9,),
                      Text('Home', style: TextStyle(
                        fontSize: 20,
                        color: Colors.amber,
                        fontWeight: FontWeight.w800
                      ),),
                      Spacer(),
                      InkWell(
                        key: menuKey,
                        onTap: (){
                          showAddressMenu(context, menuKey);
                        },
                        child: Image.asset('assets/images/dots_2.png' , scale: 3.5,),
                      )

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22,0,22,0),
                  child: Divider(
                    color: AppColors.gray200,
                    thickness: 1,
                  ),
                ),
                //SizedBox(height: 6,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                  child: Text('85 4th Ave, Street Side Road, NY 10003, Accra, Ghana', style: TextStyle(
                    color: AppColors.gray300,
                    fontSize: 17,
                    fontWeight: FontWeight.w500
                  ),),
                )
              ],
            ),

          );
  }
}
