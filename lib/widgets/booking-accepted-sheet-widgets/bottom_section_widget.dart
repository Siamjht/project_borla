
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../features/fragments/dotted_line_copy.dart';
import '../../role/components/text/common_text.dart';
import '../../theme/app_color.dart';

Widget bottomSheetLocationSection({
  required String pickupAddress,
  required DateTime? requestedAt,
}) {
  final formattedTime = requestedAt != null
      ? DateFormat('hh:mm a').format(requestedAt)
      : '--:--';

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          Icon(Icons.radio_button_checked,
              color: Colors.amber, size: 18),
          SizedBox(height: 6),
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
              children: [
                const CommonText(
                  text: 'Pickup Location',
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
                CommonText(
                  text: formattedTime,
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            const SizedBox(height: 4),
            CommonText(
              textAlign: TextAlign.start,
              text: pickupAddress,
              fontSize: 14,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget bottomSheetLocationSectionMod() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          Icon(Icons.radio_button_checked,
              color: Colors.amber, size: 18),
          SizedBox(height: 6),
          VerticalDottedLine(),
          SizedBox(height: 6),
          Icon(Icons.location_on,
              color:  Colors.amber, size: 20),
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
                  text: '02:30 PM',
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
                  text: '03:10 PM',
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

Widget summarySection({
  double? price,
  double? estimatedDistance,
  String? estimatedTime,
}) {
  final priceText = price != null && price > 0
      ? 'GH₵ ${price.toStringAsFixed(0)}'
      : 'GH₵ 0';

  final distanceText = estimatedDistance != null && estimatedDistance > 0
      ? '${estimatedDistance.toStringAsFixed(1)} KM'
      : '0 KM';

  // Parse estimatedTime if it's in format like "40:00 M" or similar
  String timeDisplay = '--';
  if (estimatedTime != null && estimatedTime.isNotEmpty) {
    // Try to extract minutes from string like "40:00 M"
    final parts = estimatedTime.split(':');
    if (parts.length >= 2) {
      timeDisplay = '${parts[0]} min';
    } else {
      timeDisplay = estimatedTime;
    }
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Total Price
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CommonText(
              text: 'Total Price',
              fontSize: 13,
              color: Colors.grey,
            ),
            const SizedBox(height: 4),
            CommonText(
              text: priceText,
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
          children: [
            const CommonText(
              text: 'Total Distance',
              fontSize: 13,
              color: Colors.grey,
            ),
            const SizedBox(height: 4),
            CommonText(
              text: distanceText,
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
          children: [
            const CommonText(
              text: 'Avg. Time',
              fontSize: 13,
              color: Colors.grey,
            ),
            const SizedBox(height: 4),
            CommonText(
              text: timeDisplay,
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