import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/controllers/date_time_picker_controller.dart';
import 'package:project_borla/role/components/custom_container.dart';
import 'package:project_borla/screens/choose-payment-screens/choose_payment_screen.dart';
import 'package:project_borla/screens/scheduled-screens/schedule_ride_two.dart';
import 'package:project_borla/theme/app_color.dart';
import 'package:project_borla/theme/common_button_copy.dart';
import '../gen/custom_assets/assets.gen.dart';
import '../models/choose_ride_card_method.dart';
import '../widgets/choose_ride_card_widget.dart';

class ChooseRideSheet extends StatefulWidget {
  const ChooseRideSheet({super.key});
  @override
  State<ChooseRideSheet> createState() => _ChooseRideSheetState();
}
class _ChooseRideSheetState extends State<ChooseRideSheet> {

  // final RxInt selectedIndex = (-1).obs ;
  final controller = Get.find<DateTimePickerController>();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          //color: Color.fromRGBO(255, 237, 176, 1),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
              Text('Choose a ride', style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500
              ),),
              Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ),
              SizedBox(height: 16,),
              Expanded(
                flex: 10,
                child: chooseRideCards(),
              ),
              Obx(() => controller.isSetScheduled.value
                  ? CommonButton(
                onTap: () {
                  Get.to(()=> ChoosePaymentScreen());
                },
                firstGradient: AppColors.orange300,
                secondGradient: AppColors.orange500,
                titleText: 'Schedule Now',
                buttonRadius: 12,
              ) :  Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: CommonButton(
                        onTap: () {
                          Get.to(()=> ChoosePaymentScreen());
                        },
                        firstGradient: AppColors.orange300,
                        secondGradient: AppColors.orange500,
                        titleText: 'Book Now',
                        buttonRadius: 12,
                      ),
                    ),
                    SizedBox(width: 12,),
                    InkWell(
                      onTap: () {
                        Get.to(()=> ScheduleRideTwo());
                      },
                      child: CustomContainer(
                        padding: EdgeInsets.all(12),
                        borderRadius: 8,
                        borderColor: AppColors.orange300,
                        child: Assets.icons.scheduleCalenderIcon.image(
                            height: 24,
                            width: 24
                        ),
                      ),
                    ),
                  ],
                ),
              ),),
              Obx(() => SizedBox(height: controller.isSetScheduled.value? 40 : 0,),)
            ],
          ),
        )
    );
  }



  // ListView chooseRideCards() {
  //   return ListView.builder(
  //     padding: EdgeInsets.zero,
  //     itemCount: 7,
  //     itemBuilder: (context, index) {
  //       return Obx(()=>InkWell(
  //         onTap: () {
  //
  //           selectedIndex.value = index ;
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
  //                 color: selectedIndex.value == index? AppColors.orange300 : AppColors.gray200,
  //                 width: selectedIndex.value == index? 2 : 2
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
  //       ));
  //
  //     },);
  // }


}
