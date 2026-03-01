// import 'package:flutter/material.dart';
//
// class CommonBackButton extends StatelessWidget {
//   final VoidCallback? onPressed;
//   final Color? color;
//
//   const CommonBackButton({super.key, this.onPressed, this.color});
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(100),
//       onTap: onPressed ?? () => Navigator.pop(context),
//       child: Container(
//         height: kToolbarHeight * 0.8, // 80% of AppBar height
//         width: kToolbarHeight * 0.8,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(100),
//         ),
//         alignment: Alignment.center,
//         child: Icon(
//           Icons.arrow_back_ios_new_rounded,
//           color: color ?? Colors.black,
//           size: 20,
//         ),
//       ),
//     );
//   }
// }