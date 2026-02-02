
import 'package:flutter/material.dart';

import '../../features/fragments/dotted_line_copy.dart';
import '../../role/components/text/common_text.dart';
import '../../theme/app_color.dart';

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