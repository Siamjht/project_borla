import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WasteScreenHeader extends StatelessWidget {
  const WasteScreenHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration:  BoxDecoration(
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
              onPressed: () {
                Get.back();
              },
            ),
          ),

          SizedBox(width: 70),

          Text('waste_quantity'.tr, style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500
          ),)
        ],
      ),
    );
  }
}



class WasteScreenSubHeader extends StatelessWidget {
  const WasteScreenSubHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('waste_image'.tr, style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700
        )),
        Spacer(),
        Text('helps_estimate_size'.tr, style: TextStyle(

          letterSpacing: 0.0001,
          color: Colors.grey.shade500,
          fontWeight: FontWeight.w500,

        ),),

      ],
    );
  }
}