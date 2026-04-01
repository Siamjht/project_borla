import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/garbageCollector/home/controller/driver_home_controller.dart';
import 'package:project_borla/theme/app_color.dart';
import '../../../../gen/custom_assets/assets.gen.dart';
import '../../../../models/riderModels/bookingModels/available_bookings_model.dart';
import '../../../components/custom_container.dart';
import '../../../components/text/common_text.dart';
import 'common_widgets.dart';
import 'waste_details_widget.dart';

class JobRequestCard extends StatelessWidget {
  final AvailableBookingModel job;
  JobRequestCard({super.key, required this.job});

  final DriverHomeController _driverHomeController =
  Get.find<DriverHomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // if (_driverHomeController.jobRequests.isEmpty) return const SizedBox.shrink();
      _driverHomeController.isBottomSheet.value = true;

      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.green100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(13),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * .65,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ── Title ──────────────────────────────────
                Center(
                  child: CommonText(
                    text: "job.scheduledFor" == null
                        ? 'Scheduled garbage pickup'
                        : 'Garbage Pickup Request',
                    fontSize: 18,
                  ),
                ),

                const Divider(color: AppColors.black50, thickness: 1),

                userRow(_driverHomeController, job,),

                const SizedBox(height: 4),

                // ── Scheduled Pickup ────────────────────────
                if ("job.scheduledFor" == null) ...[
                  _scheduledPickup(job),
                  const SizedBox(height: 12),
                ],

                WasteDetailsWidget(job: job),

                const Divider(color: AppColors.black50, thickness: 1),
                const SizedBox(height: 4),

                locationSection(job),

                const Divider(color: AppColors.black50, thickness: 1),
                const SizedBox(height: 10),

                paymentRow(job),

                const SizedBox(height: 20),

                actionButtons(context, job),
              ],
            ),
          ),
        ),
      );
    });
  }

  // ── Scheduled Pickup ────────────────────────────────────────
  Widget _scheduledPickup(AvailableBookingModel job) {
    return CustomContainer(
      borderColor: AppColors.green500,
      color: AppColors.green20,
      borderWidth: 0.2,
      borderRadius: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.green500,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Assets.icons.calenderIcon.image(height: 20, width: 20),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonText(
                    textAlign: TextAlign.start,
                    text: 'Scheduled Pickup',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textDark,
                  ),
                  const SizedBox(height: 4),
                  CommonText(
                    text: "job.scheduledDate" ?? '',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            CustomContainer(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              borderColor: AppColors.green500,
              borderWidth: 0.5,
              borderRadius: 40,
              child: Row(
                children: [
                  const Icon(Icons.access_time_rounded,
                      color: AppColors.green500, size: 18),
                  CommonText(
                    text: _formatTime("job.scheduledFor" ?? ''),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textDark,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(String isoDate) {
    try {
      final dt = DateTime.parse(isoDate).toLocal();
      final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
      final minute = dt.minute.toString().padLeft(2, '0');
      final period = dt.hour >= 12 ? 'PM' : 'AM';
      return '$hour:$minute $period';
    } catch (_) {
      return '';
    }
  }
}



