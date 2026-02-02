import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:project_borla/controllers/user-controllers/cancel_ride_controller.dart';
import 'package:project_borla/theme/gradient_scaffold_copy.dart';

import 'package:get/get.dart';
import '../../models/radio_enums.dart';
import '../../widgets/gradient_button.dart';
import '../reject-rider-screens/reject_rider_screen.dart';



class CancelRideScreen extends StatelessWidget {
  CancelRideScreen({super.key});


  CancelRideController cancelController = Get.put(CancelRideController());

  // Rx enum (replaces setState)
  //final Rx<Frequency> selectedValue = Frequency.opn1.obs;

  final Map<Frequency, String> reasons = {
    Frequency.opn1: 'Change in plans',
    Frequency.opn2: 'Waiting for long time',
    Frequency.opn3: 'Unable to contact driver',
    Frequency.opn4: 'Driver denied to go to destination',
    Frequency.opn5: 'Driver denied to come to pickup',
    Frequency.opn6: 'Wrong address shown',
    Frequency.opn7: 'The price is not reasonable',
    Frequency.opn8: 'Emergency situation',
    Frequency.opn9: 'Book mistake',
    Frequency.opn10: 'Poor weather conditions',
    Frequency.opn11: 'Other',
  };

  @override
  Widget build(BuildContext context) {
    return UserGradientScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Header ─────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(26, 70, 20, 20),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                        color: Colors.black.withAlpha(40),
                      ),
                    ],
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 22,
                    icon: const Icon(Icons.arrow_back),
                    onPressed: Get.back,
                  ),
                ),
                const SizedBox(width: 80),
                const Text(
                  'Cancel Ride',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.fromLTRB(26, 0, 0, 0),
            child: Text(
              'Please select the reason for cancellation:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ),

          const SizedBox(height: 28),

          // ─── Radio List ─────────────────────────────────────────
          Column(
            children: reasons.entries.map((entry) {
              return Obx(() => RadioListTile<Frequency>(
                visualDensity:
                const VisualDensity(horizontal: -4, vertical: -3),
                value: entry.key,
                groupValue: cancelController.selectedValue.value,
                onChanged: (val) => cancelController.selectedValue.value = val!,
                fillColor: WidgetStateProperty.resolveWith(
                      (states) => Colors.amber,
                ),
                title: Text(
                  entry.value,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ));
            }).toList(),
          ),

          const SizedBox(height: 48),

          // ─── Confirm Button ─────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: GradientButton(
              text: 'Confirm',
              onPressed: () {
                // Selected enum available here
                print(cancelController.selectedValue.value);

                Get.to(() => RejectRiderScreen());
              },
            ),
          ),
        ],
      ),
    );
  }
}

