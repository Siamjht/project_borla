
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/app_color.dart';
import '../../../components/button/common_button.dart';
import '../../../components/dotted_line.dart';
import '../../../components/text/common_text.dart';
import '../controller/driver_home_controller.dart';
import '../navigate_destination_screen.dart';
import 'common_widgets.dart';

class CustomerInfoBottomSheet extends StatelessWidget {
  const CustomerInfoBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final DriverHomeController controller = Get.find();

    controller.isBottomSheet.value = true;
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.45,
      maxChildSize: 0.75,
      builder: (_, scrollController) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            // child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     /// Drag Handle
            //     Center(
            //       child: Container(
            //         width: 48,
            //         height: 5,
            //         decoration: BoxDecoration(
            //           color: AppColors.black50,
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //       ),
            //     ),
            //
            //     const SizedBox(height: 16),
            //
            //     /// Title
            //     const Center(
            //       child: CommonText(
            //         text: "Customer Information",
            //         fontSize: 18,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //
            //     const SizedBox(height: 12),
            //     const Divider(color: AppColors.black50, thickness: 1),
            //
            //     userRow(controller),
            //
            //     const Divider(color: AppColors.black50, thickness: 1),
            //     const SizedBox(height: 6),
            //
            //     bottomSheetLocationSection(),
            //
            //     const Divider(color: AppColors.black50, thickness: 1),
            //     const SizedBox(height: 10),
            //
            //     summarySection(),
            //
            //     const SizedBox(height: 20),
            //
            //     bottomSheetActionButtons(context),
            //   ],
            // ),
          ),
        );
      },
    );
  }
}

Widget bottomSheetLocationSection() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          Icon(Icons.radio_button_checked,
              color: AppColors.primaryColor, size: 18),
          SizedBox(height: 6),
          VerticalDottedLine(),
          SizedBox(height: 6),
          Icon(Icons.location_on,
              color: AppColors.primaryColor, size: 20),
        ],
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Location + Time Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                CommonText(
                  text: 'Current Location',
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
                CommonText(
                  text: '02.30 PM',
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            const SizedBox(height: 4),
            const CommonText(
              textAlign: TextAlign.start,
              text: '85 Ave, Side Road, Accra, Ghana',
              fontSize: 14,
            ),
            const SizedBox(height: 8),
            const Divider(color: AppColors.black50, thickness: 1),
            const SizedBox(height: 4),
            // Pickup Point + Time Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                CommonText(
                  text: 'Pickup Point',
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
                CommonText(
                  text: '03.10 PM',
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            const SizedBox(height: 4),
            const CommonText(
              textAlign: TextAlign.start,
              text: '1901 Thornridge Road, Accra, Ghana',
              fontSize: 14,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget summarySection() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Total Price
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            CommonText(
              text: 'Total Price',
              fontSize: 13,
              color: Colors.grey,
            ),
            SizedBox(height: 4),
            CommonText(
              text: 'GH₵ 50',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ],
        ),

        // Vertical divider
        Container(
          height: 40,
          width: 1,
          color: Colors.grey,
        ),

        // Total Distance
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            CommonText(
              text: 'Total Distance',
              fontSize: 13,
              color: Colors.grey,
            ),
            SizedBox(height: 4),
            CommonText(
              text: '22.6 KM',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ],
        ),

        // Vertical divider
        Container(
          height: 40,
          width: 1,
          color: Colors.grey,
        ),

        // Avg. Time
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            CommonText(
              text: 'Avg. Time',
              fontSize: 13,
              color: Colors.grey,
            ),
            SizedBox(height: 4),
            CommonText(
              text: '40:00 M',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget bottomSheetActionButtons(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: CommonButton(
          // onTap: controller.declineJob, // ✅ controller handles logic
          buttonRadius: 12,
          titleText: "Cancel Ride",
          titleColor: AppColors.green500,
          borderColor: AppColors.green500,
        ),
      ),
      SizedBox(width: 20,),
      Expanded(
        child: CommonButton(
          onTap: (){
            Get.to(() => NavigateDestinationScreen());
          },
          // onTap: controller.acceptJob,
          buttonRadius: 12,
          titleText: "Start Ride",
        ),
      ),
    ],
  );
}