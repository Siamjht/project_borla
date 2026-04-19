import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/components/custom_container.dart';
import 'package:project_borla/role/garbageCollector/home/innerWidget/payment_receive_dialog.dart';

import '../../../../gen/custom_assets/assets.gen.dart';
import '../../../../models/riderModels/bookingModels/rider_booking_model.dart';
import '../../../../theme/app_color.dart';
import '../../../components/button/common_button.dart';
import '../../../components/text/common_text.dart';
import '../../activity/controller/activity_controller.dart';
import '../../activity/innerWidget/common_widgets.dart';
import 'arrive_at_pickup_dialog.dart';


class ArrivedBottomSheet extends StatefulWidget {
  RiderBookingModel booking;
  bool isPaymentReceive;
  ArrivedBottomSheet({super.key, required this.booking, this.isPaymentReceive = false});

  @override
  State<ArrivedBottomSheet> createState() => _ArrivedBottomSheetState();
}

class _ArrivedBottomSheetState extends State<ArrivedBottomSheet> {
  final ActivityController activityCtrl = ActivityController.instance;
  late Worker _bookingWorker;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final booking = activityCtrl.selectedBooking.value;
      if (booking != null && booking.isPaidByCustomer) {
        _showPaymentReceiveDialog(booking);
      }
    });

    // ✅ Listen for socket-driven updates (e.g., getSingleBooking)
    // _bookingWorker = ever(activityCtrl.selectedBooking, (booking) {
    //   if (booking != null && booking.isPaidByCustomer) {
    //     _showPaymentReceiveDialog(booking);
    //   }
    // });
  }

  void _showPaymentReceiveDialog(RiderBookingModel booking) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PaymentReceiveDialog(booking: booking),
    );
    // if (booking.isPaid) {
    //   showDialog(
    //     context: context,
    //     barrierDismissible: true,
    //     builder: (_) => PaymentReceiveDialog(booking: booking),
    //   );
    // }
  }

  @override
  void dispose() {
    // _bookingWorker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.40,
      minChildSize: 0.35,
      maxChildSize: 0.75,
      builder: (_, scrollController) {
        return Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Obx(() {
              final booking = activityCtrl.selectedBooking.value ?? widget.booking;
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const Center(
                          child: CommonText(
                            text: 'Arrived At Customer Location',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Divider(color: AppColors.black50, thickness: 1),
                        userRow(booking),
                        const Divider(color: AppColors.black50, thickness: 1),
                        const SizedBox(height: 6),
                        _locationSection(booking),
                        const Divider(color: AppColors.black50, thickness: 1),
                        const SizedBox(height: 10),
                        _paymentRow(booking),
                        const SizedBox(height: 20),
                        _actionButtons(context, booking),
                      ],
                    ),
                  ),
                  // ── Floating location pin ─────────────────
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
                        child: const Icon(
                          Icons.location_pin,
                          color: AppColors.white,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        );
      },
    );
  }

  Widget _locationSection(RiderBookingModel? booking) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.radio_button_checked,
            color: AppColors.primaryColor, size: 18),
        const SizedBox(width: 12),
        Expanded(
          child: CommonText(
            textAlign: TextAlign.start,
            text: booking?.pickupAddress ?? '—', // ✅ real data
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _paymentRow(RiderBookingModel? booking) {
    return Row(
      children: [
        CustomContainer(
          padding: const EdgeInsets.all(10),
          borderRadius: 100,
          color: AppColors.gray100,
          child: Center(
            child: Assets.icons.creditCardIcon.image(height: 20, width: 20),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CommonText(
              text: 'Payment',
              fontSize: 12,
              color: AppColors.gray300,
            ),
            CommonText(
              text: booking?.paymentMethod == 'cash'
                  ? 'Cash'
                  : 'Hubtel Pay', // ✅ real data
              fontSize: 16,
            ),
          ],
        ),
        const Spacer(),
        CommonText(
          text: booking?.price != null
              ? 'GH₵ ${booking!.price.toStringAsFixed(0)}'
              : 'TBD', // ✅ real data
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ),
      ],
    );
  }

  Widget _actionButtons(BuildContext context, RiderBookingModel booking) {
    return Obx(() => CommonButton(
      isLoading: activityCtrl.isArriveLoading.value,
      onTap: activityCtrl.isArriveLoading.value
          ? () {}
          : () {
        ActivityController.instance.arriveAtPickup(context, bookingId: booking.id);
        if (!widget.isPaymentReceive) {
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (_) => ArriveAtPickupDialog(booking: booking)
          );
        }
      },
      buttonRadius: 12,
      titleText: 'Arrived',
    ));
  }
}