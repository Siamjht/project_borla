
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/components/custom_container.dart';
import 'package:project_borla/role/components/image/shimmer_image_loader.dart';
import 'package:project_borla/role/garbageCollector/home/controller/driver_home_controller.dart';
import 'package:project_borla/theme/app_color.dart';

import '../../../../gen/custom_assets/assets.gen.dart';
import '../../../../models/riderModels/bookingModels/available_bookings_model.dart';
import '../../../components/text/common_text.dart';

class WasteDetailsWidget extends StatelessWidget {
  final AvailableBookingModel job;
  WasteDetailsWidget({super.key, required this.job});

  final controller = Get.find<DriverHomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: CustomContainer(
        borderColor: AppColors.green500,
        color: AppColors.green20,
        borderWidth: 0.5,
        borderRadius: 12,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  _iconBox(),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CommonText(
                          text: 'Waste Details',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textDark,
                        ),
                        const SizedBox(height: 4),
                        CommonText(
                          // ✅ real data
                          text: '${job.wasteSize} Kg • ${job.binSize}',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: controller.toggle,
                    borderRadius: BorderRadius.circular(16),
                    child: Icon(
                      controller.isExpanded.value
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.green,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),
            if (controller.isExpanded.value) _expandedContent(),
          ],
        ),
      ),
    ));
  }

  Widget _iconBox() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.green500,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
          child: Assets.icons.wasteBoxIcon.image(height: 20, width: 20, color: AppColors.white)),
    );
  }

  Widget _expandedContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [

          // ✅ show first waste image if available
          if (job.wasteImages.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: ShimmerImageLoader(
                  url: job.wasteImages.first,
                  width: double.infinity,
                  height: 160),
            ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: _StatItem(
                  icon: Assets.icons.weightIcon.image(
                      height: 20, width: 20, color: AppColors.green500),
                  value: '${job.wasteSize} Kg',  // ✅ real data
                  label: 'Weight',
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: _StatItem(
                  icon: Assets.icons.wasteBoxIcon.image(
                      height: 20, width: 20, color: AppColors.green500),
                  value: '${job.binQuantity}',   // ✅ real data
                  label: 'Bins',
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: _StatItem(
                  icon: Assets.icons.wasteBoxIcon.image(
                      height: 20, width: 20, color: AppColors.green500),
                  value: job.binSize,             // ✅ real data
                  label: 'Size',
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            width: Get.width,
            padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade300),
            ),
            child: const CommonText(
              text: '⚠️ Check if this fits your tricycle capacity',
              fontWeight: FontWeight.w400,
              fontSize: 10,
              color: AppColors.red200,
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}


class _StatItem extends StatelessWidget {
  final Image icon;
  final String value;
  final String label;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      borderColor: AppColors.green500,
      borderRadius: 10,
      borderWidth: 0.5,
      color: AppColors.white,
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: OverflowBox(
        alignment: Alignment.center,
        minHeight: 0,
        maxHeight: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            6.verticalSpace,
            FittedBox(
              fit: BoxFit.scaleDown,
              child: CommonText(
                text: value,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                maxLines: 1,
              ),
            ),
            2.verticalSpace,
            FittedBox(
              fit: BoxFit.scaleDown,
              child: CommonText(
                text: label,
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

