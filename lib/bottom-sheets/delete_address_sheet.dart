import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project_borla/screens/scheduled-screens/schedule-ride-screen-with-sheet/schedule_ride_with_bottom_screen.dart';

import '../widgets/delete-sheet-widgets/delete_sheet_button_widget.dart';
import '../widgets/gradient_button.dart';

class DeleteAddressSheet extends StatefulWidget {
  const DeleteAddressSheet({super.key});

  @override
  State<DeleteAddressSheet> createState() => _DeleteAddressSheetState();
}

class _DeleteAddressSheetState extends State<DeleteAddressSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 440,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),

        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 8),

            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            const SizedBox(height: 16),


            Text('Delete Address', style: TextStyle(

                fontSize: 22,

                color: Colors.deepOrange,

                fontWeight: FontWeight.w500

            ),),

            //const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.fromLTRB(22,0,22,0),
              child: Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ),
            ),

            const SizedBox(height: 16),

            Text('Sure you want to delete this address?', style: TextStyle(

              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade400


            ),),

            const SizedBox(height: 18),

            Padding(
              padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22,6,22,6),
                      child: Row(

                        children: [

                          Image.asset('assets/images/location_pin_two.png', scale: 0.8,),

                          SizedBox(width: 8,),

                          Text('Office', style: TextStyle(

                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.amber


                          ),),

                          Spacer(),

                        ],


                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(22,0,22,0),
                      child: Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text('85 4th Ave, Street Side Road, NY 10003,', style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text('Accra, Ghana', style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey
                      ),),
                    ),

                    SizedBox(height: 16,)


                  ],
                ),
              ),
            ),

            SizedBox(height: 30,),

            DeleteSheetButtons(),

          ],
        )


    );
  }
}

// class DeleteSheetButtons extends StatelessWidget {
//   const DeleteSheetButtons({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//
//       children: [
//
//         Padding(
//           padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                 colors: [
//                   Color.fromRGBO(255, 214, 0, 1),
//                   Color.fromRGBO(255,149,0, 1),
//                 ],
//               ),
//               borderRadius: BorderRadius.circular(16),
//             ),
//             padding: const EdgeInsets.all(2), // border thickness
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(100, 50),
//                 backgroundColor: Colors.white, // white button
//                 shadowColor: Colors.transparent,
//                 elevation: 0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(14), // inner radius
//                 ),
//               ),
//               onPressed: () {
//                 //Get.to(()=> OnboardingTwo());
//               },
//               child: Padding(
//                 padding: EdgeInsets.fromLTRB(40, 14, 40, 14),
//
//                 child: ShaderMask(
//                   shaderCallback: (bounds) => LinearGradient(
//                     colors: [
//                       Color.fromRGBO(255, 214, 0, 1),
//                       Color.fromRGBO(255,149,0, 1),
//                     ],
//                   ).createShader(bounds),
//                   child: Text(
//                     'Cancel',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//
//
//         Padding(
//           padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
//           child: ElevatedButton(
//             onPressed: () {
//               Get.to(()=> ScheduleRideWithBottomScreen());
//             },
//             style: ElevatedButton.styleFrom(
//               padding: EdgeInsets.zero, // important
//               backgroundColor: Colors.transparent,
//               shadowColor: Colors.transparent,
//               minimumSize: const Size(100, 50),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: Ink(
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [
//                     Color.fromRGBO(255, 214, 0, 1),
//                     Color.fromRGBO(255,149,0, 1),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Container(
//                 alignment: Alignment.center,
//                 padding: const EdgeInsets.fromLTRB(50, 16, 50, 16),
//                 child: const Text(
//                   'Yes, Delete',
//                   style: TextStyle(
//                     color: Colors.white,
//                     //fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         )
//
//
//       ],
//
//     );
//   }
// }
