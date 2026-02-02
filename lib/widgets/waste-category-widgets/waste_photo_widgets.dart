import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helpers/other_helper.dart';
import '../../theme/app_color.dart';

class WasteContainer extends StatelessWidget {
  const WasteContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: const Radius.circular(12),
        dashPattern: const [10, 5],
        strokeWidth: 2,
        padding: const EdgeInsets.all(8),
        color: AppColors.gray200,
      ),
      child: SizedBox(
        height: 180.h,
        width: double.infinity,
        child: GestureDetector(
          onTap: (){
            OtherHelper.openGallery();
          },
          child: Column(
            children: [
              SizedBox(height: 26,),
              Container(
                height: 72,
                width: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 214, 0, 1),
                      Color.fromRGBO(255,149,0, 1),
                    ],
                  ),
                ),
                child: Image.asset('assets/images/bin_camera.png', scale: 3.4,),
              ),
              SizedBox(height: 10,),
              Text('Capture Waste Photo', style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                  color: Colors.grey.shade600
              ),),
              SizedBox(height: 4,),
              Text('Take a clear photo of the waste', style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.grey.shade400
              ),),

            ],
          ),
        ),
      ),

    );
  }
}


class WastePickPhoto extends StatelessWidget {
  const WastePickPhoto({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 5,
        shrinkWrap: true, // ✅ IMPORTANT
        physics: const NeverScrollableScrollPhysics(), // ✅ IMPORTANT
        padding: const EdgeInsets.only(top: 16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          //mainAxisSpacing: 0.4,
          //childAspectRatio: 0.7
        ),
        itemBuilder: (context, index) {

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset('assets/images/bin_img.png', scale: 3,),
              Positioned(
                right: -8,
                top: -8,
                child: Container(
                  height: 23,
                  width: 23,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Icon(Icons.close, color: Colors.white, size: 16, fontWeight: FontWeight.bold, ),
                ),
              )
            ],
          );

        }
    );
  }
}