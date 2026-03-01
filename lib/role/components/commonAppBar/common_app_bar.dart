
import 'package:flutter/material.dart';

import '../../../theme/common_back_button_copy.dart';
import '../commonBackButton/common_back_button.dart';
import '../text/common_text.dart';

Widget commonAppBar({appbarTitle}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonBackButton(),
        CommonText(
          text: appbarTitle,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        SizedBox(width: 50,)
      ],
    ),
  );
}