
import 'package:flutter/material.dart';

class CommonBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? color;

  const CommonBackButton({super.key, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onPressed ?? () => Navigator.pop(context),
      child: Container(
        height: kToolbarHeight * 0.7, // 80% of AppBar height
        width: kToolbarHeight * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 1,
              spreadRadius: 0.2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.arrow_back,
          color: color ?? Colors.black,
          size: 20,
        ),
      ),
    );
  }
}

