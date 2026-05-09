import 'package:flutter/material.dart';
import 'package:project_borla/bottom-sheets/confirm_address_sheet.dart';
import 'package:project_borla/features/fragments/bottom_nav_bar.dart';

import '../../bottom-sheets/current_location_sheet.dart';
import '../../bottom-sheets/current_location_sheet_two.dart';
import '../../bottom-sheets/search_location_sheet.dart';

class MapScreenTwo extends StatefulWidget {
  const MapScreenTwo({super.key});

  @override
  State<MapScreenTwo> createState() => _MapScreenTwoState();
}

class _MapScreenTwoState extends State<MapScreenTwo> {

  //double _bottomSheetHeight = 0;
//  late ScrollController controller ;

  int tabIndex = 0;

  onItemTapped(int index) {

    setState(() {

      tabIndex = index;

    });

  }

  void ShowSearchLocationSheet (BuildContext context) {

    showModalBottomSheet(

      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      //showDragHandle: true,
      useSafeArea: true,
      builder: (context) => SearchLocationSheet(),

    );


  }

  void ShowCurrentLocationSheet (BuildContext context) {

    //ScrollController controller ;

    showModalBottomSheet(


      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      //showDragHandle: true,
      useSafeArea: true,
      builder: (context) => CurrentLocationSheet(),

    );

  }

  void ShowCurrentLocationSheetTwo (BuildContext context) {

    showModalBottomSheet(

      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      //showDragHandle: true,
      useSafeArea: true,
      builder: (context) => CurrentLocationSheetTwo(),

    );

  }

  void ShowConfirmAddressSheet (BuildContext context) {

    showModalBottomSheet(

      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      //showDragHandle: true,
      useSafeArea: true,
      builder: (context) => ConfirmAddressSheet(),

    );

  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowCurrentLocationSheet(context);
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: bttmNavBar(tabIndex, onItemTapped, context),

      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   leading: Container(
      //     decoration: BoxDecoration(
      //
      //     ),
      //   ),
      // ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){},
      //   child: Container(
      //     child: Icon(Icons.add, color: Colors.amber,),
      //   ),
      // ),

      body: Stack(

        children: [

          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(child : TextButton(
              onPressed: (){
                ShowCurrentLocationSheet(context);
                //ShowPrototypeSheet(context);
              },
              child: Text('Map') ,

            )),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Row(

                    children: [

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            ShowCurrentLocationSheetTwo(context);
                          },
                          child: CircleAvatar(
                            radius: 18,
                            backgroundImage: const AssetImage('assets/images/apple.png'),
                            backgroundColor: Colors.grey.shade200,
                          ),
                        ),
                      ),

                      Spacer(),

                      InkWell(
                        onTap: () {
                          ShowConfirmAddressSheet(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2),

                          //color: Colors.white54,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white54,
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: const Offset(0, 4), // x, y
                              ),
                            ],


                          ),
                          child: ClipOval(

                            child: Icon(Icons.search, size: 36,color: Colors.grey,),

                          ),
                        ),
                      )


                    ],

                  ),
                ),
                SizedBox(height: 300,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: InkWell(
                        onTap: () {
                          ShowSearchLocationSheet(context);
                        },
                        child: Card(
                          //color: Colors.amber,
                          child: Container(
                            height: 50,
                            width: 50,

                           //color: Colors.amber,
                            decoration: BoxDecoration(
                              //border: Border.all(color: Colors.amber),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.amber
                            ),
                            child: Image.asset('assets/images/target.png')
                          ),
                        ),
                      ),
                    )
                  ],
                )
            
            
              ],
            ),
          )





        ],




      ),




    );
  }
}
