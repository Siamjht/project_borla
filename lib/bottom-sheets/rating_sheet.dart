import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/controllers/user-controllers/bottom-sheet-controllers/rating_sheet_controller.dart';
import 'package:project_borla/screens/home-screens/thank_you_screen.dart';
import 'package:project_borla/theme/app_color.dart';
import '../widgets/gradient_button.dart';
import '../widgets/rating-sheet-widgets/rating_sheet_payment_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingSheet extends StatefulWidget {
  const RatingSheet({super.key});
  @override
  State<RatingSheet> createState() => _RatingSheetState();
}
class _RatingSheetState extends State<RatingSheet> {
  RatingSheetController starController = Get.put(RatingSheetController());
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 520,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 50,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.gray200,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Text('How was the rider?', style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500
            ),),
            Padding(
              padding: const EdgeInsets.fromLTRB(22,0,22,0),
              child: Divider(
                color: AppColors.gray200,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22,6,22,6),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.orange150,),
                  color: AppColors.orange20,
                ),
                width: 320,
                height: 80,
                child: RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 5.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),

                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Obx(()=>InkWell(
                //       onTap: () {
                //         starController.isStarSelectedOne.toggle();
                //         starController.ratingList['starOne'] = starController.isStarSelectedOne.value ;
                //       },
                //       child: Icon(
                //         Icons.star,
                //         color: starController.isStarSelectedOne.value? Colors.amber : Colors.grey.shade300 ,
                //         size: 42,
                //       ),
                //     ),),
                //     Obx(()=>InkWell(
                //       onTap: () {
                //         starController.isStarSelectedTwo.toggle();
                //         starController.ratingList['starTwo'] = starController.isStarSelectedTwo.value ;
                //       },
                //       child: Icon(
                //         Icons.star,
                //         color: starController.isStarSelectedTwo.value? Colors.amber : Colors.grey.shade300 ,
                //         size: 42,
                //       ),
                //     ),),
                //     Obx(()=>InkWell(
                //       onTap: () {
                //         starController.isStarSelectedThree.toggle();
                //         starController.ratingList['starThree'] = starController.isStarSelectedThree.value ;
                //       },
                //       child: Icon(
                //         Icons.star,
                //         color: starController.isStarSelectedThree.value? Colors.amber : Colors.grey.shade300 ,
                //         size: 42,
                //       ),
                //     ),),
                //     Obx(()=>InkWell(
                //       onTap: () {
                //         starController.isStarSelectedFour.toggle() ;
                //         starController.ratingList['starFour'] = starController.isStarSelectedFour.value ;
                //       },
                //       child: Icon(
                //         Icons.star,
                //         color: starController.isStarSelectedFour.value? Colors.amber : Colors.grey.shade300 ,
                //         size: 42,
                //       ),
                //     ),),
                //     Obx(()=>InkWell(
                //       onTap: () {
                //         starController.isStarSelectedFive.toggle() ;
                //         starController.ratingList['starFive'] = starController.isStarSelectedFive.value ;
                //       },
                //       child: Icon(
                //         Icons.star,
                //         color: starController.isStarSelectedFive.value? Colors.amber : Colors.grey.shade300 ,
                //         size: 42,
                //       ),
                //     ),),
                //   ],
                // ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Great 5 star! Can't get any better than that!", style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.gray300
              ),),
            ),
            SizedBox(height: 20,),
            RatingSheetPaymentSection(),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: GradientButton(
                text: 'Submit Now',
                onPressed: () {
                  final trueCount = starController.ratingList.values.where((v) => v == true ).length;
                  print(trueCount);
                  //print(rating);
                  Get.to(()=> ThankYouScreen());
                },
              ),
            ),
          ],
        )
    );
  }
}


