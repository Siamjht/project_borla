
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_borla/theme/app_color.dart';
import '../../../../gen/custom_assets/assets.gen.dart';
import '../../../../role/components/text/common_text.dart';
import '../../../../theme/custom_container_copy.dart';
import '../user-controller/user_home_controller.dart';

class WasteDetailsWidget extends StatelessWidget {
  WasteDetailsWidget({super.key});

  final controller = Get.find<UserHomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => AnimatedSize(
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
              /// HEADER (Always Visible)
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
                            text: '13 Kg • Large (240 L)',
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

              /// EXPANDED CONTENT (Same Container)
              if (controller.isExpanded.value) ...[
                _expandedContent(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// ---------------- Widgets ----------------

  Widget _iconBox() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.green500,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(child: Assets.icons.wasteBoxIcon.image(height: 20, width: 20)),
    );
  }

  Widget _expandedContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          /// Image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTg5Tsf2V3-vcBygjoaRk9rjaxf80u30zeDxg&s',
              height: 160.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(height: 12),
          /// Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: 12,
            children: [
              Expanded(
                child: _StatItem(
                  icon: Assets.icons.weightIcon.image(height: 20, width: 20, color: AppColors.green500),
                  value: '13 Kg',
                  label: 'Weight',
                ),
              ),
              Expanded(
                child: _StatItem(
                  icon: Assets.icons.wasteBoxIcon.image(height: 20, width: 20, color: AppColors.green500),
                  value: '1',
                  label: 'Bins',
                ),
              ),
              Expanded(
                child: _StatItem(
                  icon: Assets.icons.wasteBoxIcon.image(height: 20, width: 20, color: AppColors.green500),
                  value: '240L',
                  label: 'Size',
                ),
              ),
            ],
          ),
          SizedBox(height: 12),

          /// Warning
          Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade300),
            ),
            child: CommonText(
              text: '⚠️ Check if this fits your tricycle capacity',
              fontWeight: FontWeight.w400,
              fontSize: 10,
              color: AppColors.red200,
            ),
          ),
          SizedBox(height: 12),
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
      height: 80,
      child: Column(
        children: [
          const SizedBox(height: 4),
          icon,
          const SizedBox(height: 12),
          CommonText(
            text: value,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(height: 4),
          CommonText(
            text: label,
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}