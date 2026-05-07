import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/components/text/common_text.dart';
import 'package:project_borla/utils/app_dropdown.dart';

import '../../controllers/date_time_picker_controller.dart';
import '../../controllers/user-controllers/booking_controller.dart';
import '../../gen/custom_assets/assets.gen.dart';
import '../../role/components/customSnackbar/custom_snackbar.dart';
import '../../role/components/custom_container.dart';
import '../../theme/app_color.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/waste-category-widgets/waste_header_widgets.dart';
import '../../widgets/waste-category-widgets/waste_photo_widgets.dart';
import '../choose-payment-screens/choose_payment_screen.dart';
import '../scheduled-screens/schedule_ride_two.dart';

class WasteQtyScreen extends StatefulWidget {
  const WasteQtyScreen({super.key});

  @override
  State<WasteQtyScreen> createState() => _WasteQtyScreenState();
}

class _WasteQtyScreenState extends State<WasteQtyScreen> {
  final bookingCtrl = Get.find<BookingController>();
  final dateTimeCtrl = Get.find<DateTimePickerController>();

  // Bin size map: display label → api value
  final List<Map<String, String>> binSizes = [
    {'label': 'bin_small'.tr, 'value': 'small (50L)'},
    {'label': 'bin_medium'.tr, 'value': 'medium (120L)'},
    {'label': 'bin_large'.tr, 'value': 'large (240L)'},
    {'label': 'bin_extra_large'.tr, 'value': 'extra large (360L)'},
  ];

  final List<int> binQuantities = [0, 1, 2, 3, 4, 5];

  void _onContinue() {
    final binSize = bookingCtrl.selectedBinSize.value;
    final binQty = bookingCtrl.selectedBinQuantity.value;
    final wasteSize = bookingCtrl.wasteSizeController.text.trim();

    if (binSize.isEmpty) {
      CustomSnackbar.error('bin_size_required'.tr);
      return;
    }
    if (binQty == -1) {
      CustomSnackbar.error('bin_qty_required'.tr);
      return;
    }
    if (wasteSize.isEmpty) {
      CustomSnackbar.error('waste_size_required'.tr);
      return;
    }
    if (int.tryParse(wasteSize) == null) {
      CustomSnackbar.error('waste_size_invalid'.tr);
      return;
    }
    Get.to(() => ChoosePaymentScreen());
    // Get.to(() => FindingDriverScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ── Background ────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.fitWidth,
            ),
          ),

          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 68, 22, 22),
              child: Column(
                children: [
                  WasteScreenHeader(),
                  SizedBox(height: 34),
                  WasteScreenSubHeader(),
                  SizedBox(height: 20),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WasteContainer(),
                      WastePickPhoto(),

                      // ── Bin Size ───────────────────────────
                      Text(
                        'bin_size'.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Obx(
                        () => AppDropDownStyle(
                          DropdownButton<String>(
                            value: bookingCtrl.selectedBinSize.value.isEmpty
                                ? null
                                : bookingCtrl.selectedBinSize.value,
                            hint: Text('select_bin_size'.tr),
                            isExpanded: true,
                            underline: Container(),
                            items: binSizes
                                .map(
                                  (bin) => DropdownMenuItem(
                                    value: bin['value'],
                                    child: Text(bin['label']!),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              bookingCtrl.selectedBinSize.value = value ?? '';
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      // ── Bin Quantity ───────────────────────
                      Text(
                        'bin_quantity'.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Obx(
                        () => AppDropDownStyle(
                          DropdownButton<int>(
                            value: bookingCtrl.selectedBinQuantity.value == -1
                                ? null
                                : bookingCtrl.selectedBinQuantity.value,
                            hint: Text('select_bin_quantity'.tr),
                            isExpanded: true,
                            underline: Container(),
                            items: binQuantities
                                .map(
                                  (qty) => DropdownMenuItem(
                                    value: qty,
                                    child: Text(
                                      qty == 5 ? 'more_than_5'.tr : qty.toString(),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              bookingCtrl.selectedBinQuantity.value =
                                  value ?? 0;
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      // ── Waste Size ─────────────────────────
                      Text(
                        'waste_size_kg'.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 10),

                      CustomTextField(
                        controller: bookingCtrl.wasteSizeController,
                        hint: 'enter_waste_size_hint'.tr,
                        keyboardType: TextInputType.number,
                        prefix: Image.asset(
                          'assets/images/second_pin_2.png',
                          scale: 3.5,
                        ),
                      ),

                      SizedBox(height: 20),

                      // ── Continue Button ────────────────────
                      Obx(
                        () => bookingCtrl.isScheduled.value
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CommonText(
                                  text: "waste_scheduled_success".tr,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  padding: EdgeInsets.only(bottom: 10),
                                ),
                                8.horizontalSpace,
                                InkWell(
                                  onTap: () {
                                    bookingCtrl.resetSchedule();
                                  },
                                  child: CommonText(
                                    fontSize: 18,
                                    text: "cancel".tr,
                                    underline: true,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.orange500,
                                    padding: EdgeInsets.only(bottom: 10),
                                  ),
                                )
                              ],
                            )
                            : SizedBox(height: 20),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GradientButton(
                              text: 'continue'.tr,
                              isLoading: bookingCtrl.isCreateBookingLoading,
                              onPressed: _onContinue,
                            ),
                          ),

                          SizedBox(width: 12),
                          InkWell(
                            onTap: () {
                              Get.to(() => ScheduleRideTwo());
                            },
                            child: CustomContainer(
                              padding: EdgeInsets.all(12),
                              borderRadius: 8,
                              borderColor: AppColors.orange300,
                              child: Assets.icons.scheduleCalenderIcon.image(
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
