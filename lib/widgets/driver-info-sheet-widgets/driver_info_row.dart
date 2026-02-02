import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../gen/custom_assets/assets.gen.dart';

Row driverSheetInfo() {

  Widget RiderCircleActionMod(Image icon) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.amber),
      ),
      child: Center(child: icon),
    );
  }



  return Row(

    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

    children: [

      Column(
        children: [
          RiderCircleActionMod(
              Assets.icons.starIcon.image(height: 30, width: 30)
          ),
          SizedBox(height: 8,),
          Text('Rating', style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
              fontWeight: FontWeight.w400
          ),),

          Text('4.8',  style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 20,
              fontWeight: FontWeight.w500
          ),),
        ],
      ),

      Column(
        children: [
          RiderCircleActionMod(
              Assets.icons.scotterIcon.image(height: 30, width: 30)
          ),
          SizedBox(height: 8,),
          Text('Rides', style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
              fontWeight: FontWeight.w400
          ),),
          Text('9,200',  style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 20,
              fontWeight: FontWeight.w500
          ),),
        ],
      ),

      Column(
        children: [
          RiderCircleActionMod(
              Assets.icons.clockIcon.image(height: 30, width: 30)
          ),
          SizedBox(height: 8,),
          Text('Member', style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
              fontWeight: FontWeight.w400
          ),),
          Text('3 years',  style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 20,
              fontWeight: FontWeight.w500
          ),),
        ],
      ),

    ],

  );
}