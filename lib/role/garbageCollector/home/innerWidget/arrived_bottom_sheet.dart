import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/components/custom_container.dart';

import '../../../../theme/app_color.dart';
import '../../../components/button/common_button.dart';
import '../../../components/dotted_line.dart';
import '../../../components/text/common_text.dart';
import '../controller/driver_home_controller.dart';
import '../navigate_destination_screen.dart';
import 'arrive_at_pickup_dialog.dart';
import 'common_widgets.dart';

class ArrivedBottomSheet extends StatelessWidget {
  const ArrivedBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final DriverHomeController controller = Get.find();

    return DraggableScrollableSheet(
      initialChildSize: 0.50,
      minChildSize: 0.45,
      maxChildSize: 0.75,
      builder: (_, scrollController) {
        return Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                SingleChildScrollView(
                  controller: scrollController,
                  // child: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //
                  //     const SizedBox(height: 20),
                  //
                  //     /// Title
                  //     const Center(
                  //       child: CommonText(
                  //         text: "Arrived At Customer Location",
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
                  //     paymentRow(),
                  //
                  //     const SizedBox(height: 20),
                  //
                  //     bottomSheetActionButtons(context),
                  //   ],
                  // ),
                ),
                Positioned(
                  top: -40,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.center,
                    child: CustomContainer(
                      height: 60,
                        width: 60,
                        borderRadius: 100,
                        color: AppColors.green500,
                        child: Icon(Icons.location_pin, color: AppColors.white, size: 35,),
                    ),
                  ),
                ),
              ],
            ),
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
          VerticalDottedLine(height: 20, dotCount: 3,),
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
            const CommonText(
              textAlign: TextAlign.start,
              text: '85 Ave, Side Road, Accra, Ghana',
              fontSize: 14,
            ),
            const SizedBox(height: 16),
            HorizontalDottedLine(dotCount: 20,),
            const SizedBox(height: 12),
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


Widget bottomSheetActionButtons(BuildContext context) {
  return CommonButton(
    onTap: (){
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => const ArriveAtPickupDialog(),
      );
    },
    // onTap: controller.acceptJob,
    buttonRadius: 12,
    titleText: "Arrived",
  );
}