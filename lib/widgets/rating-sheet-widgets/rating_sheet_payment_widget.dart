import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../controllers/user-controllers/bottom-sheet-controllers/choose_payment_sheet_controllers.dart';
import '../../theme/app_color.dart';

class RatingSheetPaymentSection extends StatelessWidget {
  RatingSheetPaymentSection({
    super.key,
  });

  final ChoosePaymentSheetControllers ratingPaymentController = Get.put(ChoosePaymentSheetControllers());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 360,
      decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.black50)
      ),
      child: Column(
        children: [
          Row(

            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Payment', style: TextStyle(
                    color: AppColors.gray300,
                    fontWeight: FontWeight.w400
                ),),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(12.0),

                child: Obx(()=> ratingPaymentController.selectedIndex.value == 1
                    ? Text('MTN MoMo Pay', style: TextStyle(
                           color: AppColors.gray400,
                          fontWeight: FontWeight.w500
                ),)
                    : Text('Cash on Arrival', style: TextStyle(
                      color: AppColors.gray400,
                       fontWeight: FontWeight.w500
                         ),),
                ),

                // child: Text('MTN MoMo Pay', style: TextStyle(
                //     color: AppColors.gray400,
                //     fontWeight: FontWeight.w500
                // ),),

              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Price', style: TextStyle(
                    color: AppColors.gray300,
                    fontWeight: FontWeight.w400
                ),),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('GHC 50', style: TextStyle(
                    color: AppColors.gray400,
                    fontWeight: FontWeight.w500
                ),),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
                color: AppColors.black50,
                thickness: 1
            ),
          ),

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Total Price', style: TextStyle(
                    color: AppColors.gray300,
                    fontWeight: FontWeight.w400
                ),),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('GHC 50', style: TextStyle(
                    color: AppColors.gray400,
                    fontWeight: FontWeight.w500
                ),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// child: Obx(()=>Row(
//
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: [
//
//     InkWell(
//       onTap: () {
//
//         starController.isStarSelectedOne.value==true ;
//         //selectedIndex1 = index1 ;
//         // setState(() {
//         //
//         // });
//       },
//       child: Icon(
//         Icons.star,
//         //color: selectedIndex1 == index1? Colors.amber : Colors.grey.shade300 ,
//         color: starController.isStarSelectedOne.value? Colors.amber : Colors.grey.shade300 ,
//         size: 42,
//       ),
//     ),
//     InkWell(
//       onTap: () {
//         starController.isStarSelectedTwo.value! ;
//         // selectedIndex5 = index5 ;
//         // setState(() {
//         //
//         // });
//       },
//       child: Icon(
//         Icons.star,
//         //color: selectedIndex5 == index5? Colors.amber : Colors.grey.shade300 ,
//         color: starController.isStarSelectedTwo.value? Colors.amber : Colors.grey.shade300 ,
//         size: 42,
//       ),
//     ),
//     InkWell(
//       onTap: () {
//         starController.isStarSelectedThree.value! ;
//         // setState(() {
//         //
//         // });
//         // selectedIndex2 = index2 ;
//       },
//       child: Icon(
//         Icons.star,
//         //color: selectedIndex2 == index2? Colors.amber : Colors.grey.shade300 ,
//         color: starController.isStarSelectedThree.value? Colors.amber : Colors.grey.shade300 ,
//
//         size: 42,
//       ),
//     ),
//     InkWell(
//       onTap: () {
//
//         starController.isStarSelectedFour.value! ;
//
//         // selectedIndex3 = index3 ;
//         // setState(() {
//         //
//         // });
//       },
//       child: Icon(
//         Icons.star,
//         //color: selectedIndex3 == index3? Colors.amber : Colors.grey.shade300 ,
//         color: starController.isStarSelectedFour.value? Colors.amber : Colors.grey.shade300 ,
//
//         size: 42,
//       ),
//     ),
//     InkWell(
//       onTap: () {
//
//         starController.isStarSelectedFive.value! ;
//
//         // selectedIndex4 = index4 ;
//         // setState(() {
//         //
//         // });
//       },
//       child: Icon(
//         Icons.star,
//         //color: selectedIndex4 == index4? Colors.amber : Colors.grey.shade300 ,
//         color: starController.isStarSelectedFive.value? Colors.amber : Colors.grey.shade300 ,
//
//         size: 42,
//       ),
//     ),
//
//   ],
//
//
// ),),