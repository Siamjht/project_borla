// import 'package:flutter/material.dart';
//
// void showAddressMenu(BuildContext context) async {
//   final RenderBox overlay =
//   Overlay.of(context).context.findRenderObject() as RenderBox;
//
//   await showMenu(
//     context: context,
//     position: RelativeRect.fromRect(
//       const Offset(300, 120) & const Size(40, 40), // adjust position
//       Offset.zero & overlay.size,
//     ),
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(12),
//       side: BorderSide(color: Colors.orange.shade300),
//     ),
//     items: [
//       PopupMenuItem(
//         value: 'edit',
//         child: Row(
//           children: const [
//             Icon(Icons.edit, color: Colors.orange),
//             SizedBox(width: 10),
//             Text("Edit"),
//           ],
//         ),
//       ),
//       PopupMenuItem(
//         value: 'delete',
//         child: Row(
//           children: const [
//             Icon(Icons.delete_outline, color: Colors.orange),
//             SizedBox(width: 10),
//             Text("Okay"),
//           ],
//         ),
//       ),
//     ],
//   ).then((value) {
//     if (value == 'edit') {
//       // handle edit
//     } else if (value == 'delete') {
//       // handle okay
//     }
//   });
// }

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project_borla/screens/search-place-screens/edit_place.dart';

import '../../../bottom-sheets/delete_address_sheet.dart';

void ShowDeleteAddressSheet (BuildContext context) {

  showModalBottomSheet(

    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    //showDragHandle: true,
    useSafeArea: true,
    builder: (context) => DeleteAddressSheet(),

  );

}

void showAddressMenu(BuildContext context, GlobalKey key) {
  final RenderBox button =
  key.currentContext!.findRenderObject() as RenderBox;

  final RenderBox overlay =
  Overlay.of(context).context.findRenderObject() as RenderBox;

  final Offset position = button.localToGlobal(
    Offset.zero,
    ancestor: overlay,
  );

  showMenu(
    color: Colors.white,
    context: context,
    position: RelativeRect.fromRect(
      Rect.fromLTWH(
        position.dx,
        position.dy + button.size.height,
        button.size.width,
        button.size.height,
      ),
      Offset.zero & overlay.size,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(color: Colors.amber),
    ),
    items: [
      PopupMenuItem(
        value: 'edit',
        child: InkWell(
          onTap: (){
            Get.to(()=>EditPlace());
          },
          child: Row(
            children: [
              Icon(Icons.edit, color: Colors.amber),
              SizedBox(width: 10),
              Text('Edit', style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade700
              ),),
            ],
          ),
        ),
      ),
      PopupMenuItem(
        value: 'okay',
        child: InkWell(
          onTap: (){
            ShowDeleteAddressSheet(context);
          },
          child: Row(
            children:  [
              Icon(Icons.delete, color: Colors.amber),
              SizedBox(width: 10),
              Text('Okay', style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade700
              ),),
            ],
          ),
        ),
      ),
    ],
  );
}

