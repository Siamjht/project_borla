import 'package:flutter/material.dart';
import '../../widgets/track-screen-widgets/track_screen_user_row_widget.dart';

class TrackScreenSheet extends StatefulWidget {
  const TrackScreenSheet({super.key});

  @override
  State<TrackScreenSheet> createState() => _TrackScreenSheetState();
}

class _TrackScreenSheetState extends State<TrackScreenSheet> {
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
            height: 300,
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

                const SizedBox(height: 26),

                Text('Heading to destination...', style: TextStyle(

                    fontSize: 22,

                    fontWeight: FontWeight.w500

                ),),

                SizedBox(height: 10,),

                Text('Will arrive at the destination in 32 mins...', style: TextStyle(

                    fontSize: 17,

                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade500

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
                  child: userRowMod(),
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }

}


