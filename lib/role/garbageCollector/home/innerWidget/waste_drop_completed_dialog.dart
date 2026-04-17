
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/models/riderModels/wasteStationModel/waste_station_model.dart';
import 'package:project_borla/role/components/custom_container.dart';
import 'package:project_borla/theme/app_color.dart';

import '../../../../gen/custom_assets/assets.gen.dart';
import '../../../../models/riderModels/bookingModels/rider_booking_model.dart';
import '../../../components/navBar/nav_bar.dart';
import '../../../components/text/common_text.dart';


class WasteDropCompletedDialog extends StatelessWidget {
  RiderBookingModel booking;
  StationModel station;
  WasteDropCompletedDialog({super.key, required this.booking, required this.station});


  @override
  Widget build(BuildContext context) {

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  /// SUCCESS ICON
                  Assets.icons.paymentSuccess.image(height: 72, width: 72),

                  const SizedBox(height: 14),

                  /// TITLE
                  const CommonText(
                    text: "Ride Completed!",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 6),

                  /// SUBTITLE
                  CommonText(
                    text:
                    "Waste successfully disposed at\n${station.name}",
                    fontSize: 12,
                    color: Colors.grey,
                    textAlign: TextAlign.center,
                    lineHeight: 1.5,
                  ),

                  const SizedBox(height: 18),
                  const Divider(),

                  const SizedBox(height: 10),

                  /// TRIP SUMMARY
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: CommonText(
                      text: "Trip Summary",
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 12),

                  summaryRow(
                    Icons.location_on_outlined,
                    "Total Distance",
                    "${booking.estimatedDistance ?? "0"} km",
                  ),

                  const SizedBox(height: 10),

                  summaryRow(
                    Icons.access_time,
                    "Total Duration",
                    "${booking.estimatedTime ?? "0"} min",
                  ),

                  const SizedBox(height: 10),

                  summaryRow(
                    Icons.delete_outline,
                    "Waste Collected",
                    "${booking.wasteSize} kg",
                  ),

                  const SizedBox(height: 12),

                  /// EARNINGS
                  summaryRow(
                    Icons.monetization_on_outlined,
                    "Total Earnings",
                    "GH₵ ${booking.price ?? 0}",
                    isGreen: true,
                  ),

                  const SizedBox(height: 18),

                  /// LOCATION CARD
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xffF3F6F4),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [

                        Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                            color: Color(0xFF23A757),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.factory, color: Colors.white),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CommonText(
                                text: "Disposed At",
                                fontSize: 11,
                                color: AppColors.green500,
                              ),
                              CommonText(
                                text: station.name ?? "",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              CommonText(
                                text: station.address ,
                                fontSize: 12,
                                color: AppColors.gray500,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// BUTTON
                  // CommonButton(
                  //   onTap: () => Get.offAll(() => DriverNavbar()),
                  //   buttonRadius: 12,
                  //   titleText: "View Ride Details",
                  // ),

                  const SizedBox(height: 10),

                  /// SECOND BUTTON
                  OutlinedButton(
                    onPressed: () => Get.offAll(() => DriverNavbar()),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const CommonText(
                      text: "Back to Home",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Assets.images.patternLeft.image(scale: 0.8),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Assets.images.patternRight.image(scale: 0.7),
            ),
          ],
        ),
      ),
    );
  }

  Widget summaryRow(IconData icon, String title, String value,
      {bool isGreen = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomContainer(
          padding: EdgeInsets.all(4),
          borderRadius: 50,
            color: AppColors.green100,
            child: Icon(
                icon, size: 20,
                color: AppColors.green500)
        ),

        const SizedBox(width: 4),

        Expanded(
          child: CommonText(
            textAlign: TextAlign.start,
            text: title,
            fontSize: 13,
            color: Colors.grey,
          ),
        ),

        CommonText(
          text: value,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: isGreen ? const Color(0xFF23A757) : Colors.black,
        )
      ],
    );
  }
}