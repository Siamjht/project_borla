
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/models/userModels/bookingModels/user_booking_model.dart';
import '../../theme/app_color.dart';

class RatingSheetPaymentSection extends StatelessWidget {
  final UserBookingModel booking;
  const RatingSheetPaymentSection({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.black50)
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Payment', style: TextStyle(
                  color: AppColors.gray300,
                  fontWeight: FontWeight.w400
              ),),
              const Spacer(),
              Text(
                booking.paymentMethod == 'cash' ? 'Cash on Arrival' : 'MTN MoMo Pay',
                style: const TextStyle(
                    color: AppColors.gray400,
                    fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('Price', style: TextStyle(
                  color: AppColors.gray300,
                  fontWeight: FontWeight.w400
              ),),
              const Spacer(),
              Text('GHC ${booking.price.toStringAsFixed(0)}', style: const TextStyle(
                  color: AppColors.gray400,
                  fontWeight: FontWeight.w500
              ),),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(
                color: AppColors.black50,
                thickness: 1
            ),
          ),

          Row(
            children: [
              const Text('Total Price', style: TextStyle(
                  color: AppColors.gray300,
                  fontWeight: FontWeight.w400
              ),),
              const Spacer(),
              Text('GHC ${booking.price.toStringAsFixed(0)}', style: const TextStyle(
                  color: AppColors.gray400,
                  fontWeight: FontWeight.w500
              ),),
            ],
          ),
        ],
      ),
    );
  }
}
