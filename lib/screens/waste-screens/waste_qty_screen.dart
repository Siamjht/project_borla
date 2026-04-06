import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:project_borla/role/components/text/common_text.dart';
import 'package:project_borla/screens/finding-driver-screens/finding_driver_screen.dart';
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
  final dateTimeCtrl = Get.put(DateTimePickerController());

  // Bin size map: display label → api value
  final List<Map<String, String>> binSizes = [
    {'label': 'Small (50L)', 'value': 'small (50L)'},
    {'label': 'Medium (120L)', 'value': 'medium (120L)'},
    {'label': 'Large (240L)', 'value': 'large (240L)'},
    {'label': 'Extra Large (360L)', 'value': 'extra large (360L)'},
  ];

  final List<int> binQuantities = [0, 1, 2, 3, 4, 5];

  void _onContinue() {
    final binSize = bookingCtrl.selectedBinSize.value;
    final binQty = bookingCtrl.selectedBinQuantity.value;
    final wasteSize = bookingCtrl.wasteSizeController.text.trim();

    if (binSize.isEmpty) {
      CustomSnackbar.error('Please select a bin size');
      return;
    }
    if (binQty == -1) {
      CustomSnackbar.error('Please select a bin quantity');
      return;
    }
    if (wasteSize.isEmpty) {
      CustomSnackbar.error('Please enter waste size');
      return;
    }
    if (int.tryParse(wasteSize) == null) {
      CustomSnackbar.error('Waste size must be a valid number');
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
                        'Bin Size',
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
                            hint: const Text('Select Bin Size'),
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
                        'Bin Quantity',
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
                            hint: const Text('Select Bin Quantity'),
                            isExpanded: true,
                            underline: Container(),
                            items: binQuantities
                                .map(
                                  (qty) => DropdownMenuItem(
                                    value: qty,
                                    child: Text(
                                      qty == 5 ? 'More than 5' : qty.toString(),
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
                        'Waste Size (KG)',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 10),

                      CustomTextField(
                        controller: bookingCtrl.wasteSizeController,
                        hint: 'Enter waste size in kg',
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
                                  text: "Waste Has Been Scheduled",
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
                                    text: "Cancel",
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
                              text: 'Continue',
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
