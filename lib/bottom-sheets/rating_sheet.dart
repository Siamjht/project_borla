import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/controllers/user-controllers/bottom-sheet-controllers/rating_controller.dart';
import 'package:project_borla/models/userModels/bookingModels/user_booking_model.dart';
import 'package:project_borla/theme/app_color.dart';
import '../widgets/gradient_button.dart';
import '../widgets/rating-sheet-widgets/rating_sheet_payment_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingSheet extends StatefulWidget {
  final UserBookingModel booking;
  const RatingSheet({super.key, required this.booking});
  @override
  State<RatingSheet> createState() => _RatingSheetState();
}
class _RatingSheetState extends State<RatingSheet> {
  final RatingController starController = Get.find<RatingController>();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600, // increased height for all fields
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
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
              const Text('How was the rider?', style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500
              ),),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
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
                  width: double.infinity,
                  height: 80,
                  child: RatingBar.builder(
                    initialRating: starController.currentRating.value,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      starController.currentRating.value = rating;
                    },
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Great 5 star! Can't get any better than that!", style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray300
                ),),
              ),
              const SizedBox(height: 10,),

              RatingSheetPaymentSection(booking: widget.booking),

              const SizedBox(height: 20,),
              
              // Feedback Text Field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: TextField(
                  controller: starController.feedbackController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Tell us about your experience...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.gray200),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.primaryColor),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20,),
              
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: GradientButton(
                  isLoading: starController.isLoading,
                  text: 'Submit Now',
                  onPressed: () {
                    starController.postRating(bookingId: widget.booking.id);
                  },
                ),
              ),
            ],
          ),
        )
    );
  }
}
