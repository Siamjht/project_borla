import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreenHeaderSection extends StatelessWidget {
  const SearchScreenHeaderSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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

        SizedBox(width: 66),

        Text('search_address'.tr, style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500
        ),)
      ],
    );
  }
}