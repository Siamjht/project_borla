
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/models/riderModels/bookingModels/rider_booking_model.dart';
import 'package:project_borla/models/riderModels/wasteStationModel/waste_station_model.dart';
import 'package:project_borla/role/garbageCollector/home/innerWidget/waste_drop_completed_dialog.dart';

import '../../../../gen/custom_assets/assets.gen.dart';
import '../../../components/button/common_button.dart';
import '../../../components/text/common_text.dart';
import '../../activity/controller/activity_controller.dart';

class ArriveAtStationDialog extends StatelessWidget {
  final StationModel station;
  final RiderBookingModel booking;
  const ArriveAtStationDialog({super.key, required this.station, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Envelope Icon with Notification Badge
            Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    children: [
                      Assets.icons.arriveLocationIcon.image(height: 72, width: 72),

                      const SizedBox(height: 16),
                      // Title
                      const CommonText(
                        text: 'Arrive at Station',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      // Description
                      const CommonText(
                        text: "You've arrived!, The station is ready to receive your waste",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        lineHeight: 1.5,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Obx(() => CommonButton(
                        isLoading: ActivityController.instance.isBookingCompletedLoading.value,
                        onTap: () async {
                          if(booking.status != "completed"){
                            await ActivityController.instance.bookingCompleted(bookingId: booking.id);
                          }
                          if (context.mounted) {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (_) => WasteDropCompletedDialog(booking: booking, station: station),
                            );
                          }
                        },
                        buttonRadius: 12,
                        titleText: "Drop Off Waste",
                      )),
                    ],
                  ),
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    child: Assets.images.patternLeft.image(scale: 0.8)
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: Assets.images.patternRight.image(scale: 0.7)
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}