
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/screens/home-screens/user-home-screens/user-controller/user_home_controller.dart';
import 'package:project_borla/screens/track-screen/track_screen.dart';
import 'package:project_borla/theme/app_color.dart';
import '../../../role/components/text/common_text.dart';
import '../../home-screens/user-home-screens/user-innerwidget/common_widgets_copy.dart';
import '../activity-controller/activity_controller_copy.dart';
import '../schedule_detail_screen_copy.dart';


class UserActivityCard extends StatelessWidget {
  bool isDetailScreen;
  String? role;
  UserActivityCard({super.key, this.isDetailScreen = false, this.role = "rider"});

  UserActivityController activityController = Get.put(UserActivityController());
  UserHomeController controller = Get.put(UserHomeController());

  @override
  Widget build(BuildContext context) {
    controller.isBottomSheet.value = true;
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.orange100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          userRow(controller, role: role),
          const SizedBox(height: 10),
          const Divider(color: AppColors.gray200, thickness: 1),
          const SizedBox(height: 10),
          locationSection(),
          const SizedBox(height: 10),
          const Divider(color: AppColors.gray200, thickness: 1),
          const SizedBox(height: 10),
          paymentRow(),
          isDetailScreen? SizedBox.shrink() : const SizedBox(height: 20),
          isDetailScreen? SizedBox.shrink() : _viewDetailsButton(),
        ],
      ),
    );
  }

  // ---------------- BUTTON ----------------
  Widget _viewDetailsButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if(activityController.selectedIndex.value == 1){
            Get.to(() => ScheduleDetailScreen());
          }else if(activityController.selectedIndex.value == 0){
            Get.to(() => UserTrackScreen());
          }
        },
        style: ElevatedButton.styleFrom(
          //backgroundColor: AppColors.primaryColor,
          backgroundColor: Colors.amber,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const CommonText(
          text: 'View Details',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}


// class ActivityCard extends StatelessWidget {
//   const ActivityCard({super.key});
//
//   static const Color primaryGreen = Color(0xFF00A654);
//   static const Color dividerGrey = Color(0xFFE6E6E6);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 8,
//               spreadRadius: 1,
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _userRow(),
//             const SizedBox(height: 16),
//
//             // Underline
//             const Divider(color: dividerGrey, thickness: 1),
//             const SizedBox(height: 16),
//             _locationSection(),
//             const SizedBox(height: 24),
//
//             _paymentRow(),
//             const SizedBox(height: 24),
//
//             _viewDetailsButton(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ---------------- USER ROW ----------------
//   Widget _userRow() {
//     return Row(
//       children: [
//         const CircleAvatar(
//           radius: 28,
//           backgroundImage: NetworkImage('https://shorturl.at/WSMrn'),
//         ),
//         const SizedBox(width: 16),
//         const Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Jenny Wilson',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//               ),
//               SizedBox(height: 4),
//               Text(
//                 'User',
//                 style: TextStyle(fontSize: 14, color: Colors.grey),
//               ),
//             ],
//           ),
//         ),
//         _circleAction(Icons.chat_bubble_outline),
//         const SizedBox(width: 12),
//         _circleAction(Icons.call_outlined),
//       ],
//     );
//   }
//
//   Widget _circleAction(IconData icon) {
//     return Container(
//       width: 40,
//       height: 40,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(color: primaryGreen),
//       ),
//       child: Icon(icon, color: primaryGreen, size: 20),
//     );
//   }
//
//   // ---------------- LOCATION SECTION ----------------
//   Widget _locationSection() {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           children: [
//             const Icon(Icons.radio_button_checked,
//                 color: primaryGreen, size: 18),
//             _verticalDottedLine(),
//             const Icon(Icons.location_on,
//                 color: primaryGreen, size: 20),
//           ],
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 '85 Ave, Street Side Road, Accra, Ghana',
//                 style: TextStyle(fontSize: 15),
//               ),
//               const SizedBox(height: 12),
//               Row(
//                 children: [
//                   Expanded(
//                       child: _horizontalDottedLineN()),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.08),
//                           spreadRadius: 3,
//                           blurRadius: 8,
//                         ),
//                       ],
//                     ),
//                     child: Center(
//                       child: const Text(
//                         '22.6 KM',
//                         style: TextStyle(
//                           color: Color(0xFF00A654),
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 '1901 Thornridge Road, Accra, Ghana',
//                 style: TextStyle(fontSize: 15),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _verticalDottedLine() {
//     return SizedBox(
//       height: 50,
//       child: CustomPaint(painter: DottedLinePainter(primaryGreen, true)),
//     );
//   }
//
//   // ---------------- PAYMENT ----------------
//   Widget _paymentRow() {
//     return Row(
//       children: [
//         Container(
//           width: 40,
//           height: 40,
//           decoration: const BoxDecoration(
//             shape: BoxShape.circle,
//             color: Color(0xFFF5F5F5),
//           ),
//           child: const Icon(Icons.payment_outlined,
//               color: primaryGreen),
//         ),
//         const SizedBox(width: 12),
//         const Text(
//           'MTN MoMo Pay',
//           style: TextStyle(fontSize: 16),
//         ),
//         const Spacer(),
//         const Text(
//           'GH₵ 50',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: primaryGreen,
//           ),
//         ),
//       ],
//     );
//   }
//
//   // ---------------- BUTTON ----------------
//   Widget _viewDetailsButton() {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: () {},
//         style: ElevatedButton.styleFrom(
//           backgroundColor: primaryGreen,
//           elevation: 0,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//         ),
//         child: const Text(
//           'View Details',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//         ),
//       ),
//     );
//   }
//
//   Widget _horizontalDottedLineN() {
//     return Row(
//       children: List.generate(
//         15,
//             (_) => Expanded(
//           child: Container(
//             height: 1,
//             margin: const EdgeInsets.symmetric(horizontal: 2),
//             color: const Color(0xFFE6E6E6),
//           ),
//         ),
//       ),
//     );
//   }
//
// }