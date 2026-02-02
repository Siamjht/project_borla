import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../theme/app_color.dart';

// ListView chooseRideCards() {
//
//   int selectedIndex = -1.obs ;
//
//   return ListView.builder(
//     padding: EdgeInsets.zero,
//     itemCount: 4,
//     itemBuilder: (context, index) {
//       return InkWell(
//         onTap: () {
//           //Obx(()=> selectedIndex = index);
//           // setState(() {
//           //   selectedIndex = index ;
//           // });
//         } ,
//         child: Container(
//           margin: EdgeInsets.only(bottom: 12),
//           height: 80,
//           width: Get.width,
//           decoration: BoxDecoration(
//             border: Border.all(
//                 color: selectedIndex == index? AppColors.orange300 : AppColors.gray200,
//                 width: selectedIndex == index? 2 : 1
//             ),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Image.asset('assets/images/tiles_icon.png'),
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Tri Cycle', style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600
//                   ),),
//                   Row(
//                     children: [
//                       Image.asset('assets/images/clock.png'),
//                       SizedBox(width: 3,),
//                       Text('30-45 m', style: TextStyle(
//                           fontWeight: FontWeight.w400
//                       ),),
//                       SizedBox(width: 10,),
//                       Image.asset('assets/images/walk_2.png', scale: 3.3),
//                       SizedBox(width: 3,),
//                       Text('22 km', style: TextStyle(
//                           fontWeight: FontWeight.w400
//                       ),),
//                       SizedBox(width: 10,),
//                     ],
//                   )
//                 ],
//               ),
//               Spacer(),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(0, 0, 20, 40),
//                 child: Text('GH₵ 50', style: TextStyle(
//                     color: AppColors.orange300,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w500
//                 ),),
//               )
//             ],
//           ),
//         ),
//       );
//     },);
// }