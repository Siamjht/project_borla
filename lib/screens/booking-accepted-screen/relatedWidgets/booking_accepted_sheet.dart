import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../widgets/booking-accepted-sheet-widgets/bottom_section_widget.dart';
import '../../../widgets/booking-accepted-sheet-widgets/user_section_widget.dart';
import '../../scheduled-screens/cancel_ride_screen.dart';

class BookingAcceptedSheet extends StatefulWidget {
  const BookingAcceptedSheet({super.key});

  @override
  State<BookingAcceptedSheet> createState() => _BookingAcceptedSheetState();
}

class _BookingAcceptedSheetState extends State<BookingAcceptedSheet> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [

        Container(

          decoration: BoxDecoration(

            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),

          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 580,
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                const SizedBox(height: 36),
                Text('Your Borla has been accepted', style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500
                ),),

                Padding(
                  padding: const EdgeInsets.fromLTRB(22,10,22,10),
                  child: Divider(
                    color: Colors.grey.shade300,
                    thickness: 1,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(22,8,22,10),
                  child: userRowModClick(),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(22,0,22,0),
                  child: Divider(
                    color: Colors.grey.shade300,
                    thickness: 1,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(22,8,22,10),
                  child: bottomSheetLocationSectionMod(),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(22,0,22,0),
                  child: Divider(
                    color: Colors.grey.shade300,
                    thickness: 1,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(22,8,22,10),
                  child: summarySection(),
                ),

                SizedBox(height: 20,),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(2), // border thickness
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 50),
                      backgroundColor: Colors.white, // white button
                      shadowColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14), // inner radius
                      ),
                    ),
                    onPressed: () {
                      Get.to(()=>CancelRideScreen());
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(120, 14, 120, 14),

                      child: Text(
                        'Cancel Ride',
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.w600,
                            fontSize: 18
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -40,
            right: 166,
            child: Image.asset('assets/images/orange_tick_2.png', scale: 6.5,)
        ),
      ],
    );
  }
}
