import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_borla/theme/ripple.dart';

class SearchLocationSheet extends StatefulWidget {

  const SearchLocationSheet( {super.key});

  @override
  State<SearchLocationSheet> createState() => _SearchLocationSheetState();
}

class _SearchLocationSheetState extends State<SearchLocationSheet> {

  @override
  Widget build(BuildContext context) {
    return Container(
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

          // 👇 Custom handle INSIDE
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(height: 16),


          Text('Searching your location...', style: TextStyle(

          fontSize: 22,

          fontWeight: FontWeight.w500

          ),),

          const SizedBox(height: 16),

          RippleAnimation()

        ],
      ),
    ),
    );
  }
}
