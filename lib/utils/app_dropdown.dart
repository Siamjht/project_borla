import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

DecoratedBox AppDropDownStyle(child) {
  return DecoratedBox(

      decoration: BoxDecoration(

        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1),
        borderRadius: BorderRadius.circular(12),

      ),

      child:  SizedBox(
        height: 58,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14,6,14,0),
          child: child,
        ),
      ),

      // child: Padding(
      //
      //     padding: EdgeInsets.only(left: 30, right: 30),
      //     child: child
      //
      // )

  );

}