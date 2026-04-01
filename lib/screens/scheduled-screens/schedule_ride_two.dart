import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project_borla/bottom-sheets/finding_rider_sheet.dart';
import 'package:project_borla/screens/scheduled-screens/schedule-ride-screen-with-sheet/schedule_ride_with_bottom_screen.dart';
import 'package:project_borla/theme/app_color.dart';

import '../../controllers/date_time_picker_controller.dart';
import '../../role/components/button/common_button.dart';
import '../../role/components/commonBackButton/common_back_button.dart';
import '../../role/components/text/common_text.dart';
import '../map-screens/user_common_map.dart';


class ScheduleRideTwo extends StatelessWidget {
  const ScheduleRideTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned.fill(child: UserCommonMap()),
            Positioned(
                left: 20,
                top: 60,
                child: CommonBackButton()),
            Align(
                alignment: Alignment.bottomCenter,
                child: TimePickerBottomSheet()
            )
          ],
        )
    );
  }
}

// class ScheduleRideDialog extends StatefulWidget {
//   const ScheduleRideDialog({super.key});
//
//   @override
//   State<ScheduleRideDialog> createState() => _ScheduleRideDialogState();
// }
//
// class _ScheduleRideDialogState extends State<ScheduleRideDialog> {
//   late DateTime selectedDateTime;
//   int tabIndex = 0; // 0: Today, 1: Tomorrow, 2: Select Date
//
//   // For wheel picker (Today/Tomorrow)
//   late FixedExtentScrollController hourController;
//   late FixedExtentScrollController minuteController;
//
//   // For manual 12-hour picker (Select Date)
//   int hour12 = 12;
//   int minute = 0;
//   bool isAM = true;
//
//   final double itemExtent = 60.0;
//   // Increased from 50 to 60 for better touch target
//
//
//   void ShowFindingRiderSheet (BuildContext context) {
//
//     showModalBottomSheet(
//
//       context: context,
//       barrierColor: Colors.transparent,
//       backgroundColor: Colors.transparent,
//       isScrollControlled: true,
//       //showDragHandle: true,
//       useSafeArea: true,
//       builder: (context) => FindingRiderSheet(),
//
//     );
//
//   }
//
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     selectedDateTime = DateTime.now().add(const Duration(hours: 1));
//     _initializeControllers();
//   }
//
//   void _initializeControllers() {
//     hourController = FixedExtentScrollController(
//         initialItem: selectedDateTime.hour);
//     minuteController = FixedExtentScrollController(
//         initialItem: selectedDateTime.minute);
//   }
//
//   void _updateFromTabChange() {
//     DateTime now = DateTime.now();
//
//     DateTime baseDate = tabIndex == 0
//         ? now
//         : tabIndex == 1
//         ? now.add(const Duration(days: 1))
//         : selectedDateTime;
//
//     setState(() {
//       selectedDateTime = DateTime(
//         baseDate.year,
//         baseDate.month,
//         baseDate.day,
//         selectedDateTime.hour,
//         selectedDateTime.minute,
//       );
//
//       if (tabIndex < 2) {
//         hourController.jumpToItem(selectedDateTime.hour);
//         minuteController.jumpToItem(selectedDateTime.minute);
//       } else {
//         // Update 12-hour view
//         hour12 = selectedDateTime.hour == 0 || selectedDateTime.hour == 12
//             ? 12
//             : selectedDateTime.hour % 12;
//         minute = selectedDateTime.minute;
//         isAM = selectedDateTime.hour < 12;
//       }
//     });
//   }
//
//   String _getAmPm() {
//     return selectedDateTime.hour < 12 ? 'AM' : 'PM';
//   }
//
//   void _updateDateTimeFrom12Hour() {
//     int hour24 = isAM
//         ? (hour12 == 12 ? 0 : hour12)
//         : (hour12 == 12 ? 12 : hour12 + 12);
//
//     setState(() {
//       selectedDateTime = selectedDateTime.copyWith(
//         hour: hour24,
//         minute: minute,
//       );
//     });
//   }
//
//   @override
//   void dispose() {
//     hourController.dispose();
//     minuteController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       insetPadding: const EdgeInsets.symmetric(horizontal: 20),
//       contentPadding: EdgeInsets.zero,
//       content: SizedBox(
//         width: double.maxFinite,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Padding(
//               padding: EdgeInsets.all(20),
//               child: Text(
//                 'Schedule a Ride',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ),
//
//             // Tabs: Today | Tomorrow | Select Date
//             Row(
//               children: ['Today', 'Tomorrow', 'Select Date'].asMap().entries.map((entry) {
//                 int idx = entry.key;
//                 String label = entry.value;
//                 bool isSelected = tabIndex == idx;
//
//                 return Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         tabIndex = idx;
//                         _updateFromTabChange();
//                       });
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       decoration: BoxDecoration(
//                         color: isSelected ? Colors.amber : Colors.transparent,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         label,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: isSelected ? Colors.black : Colors.grey[600],
//                           fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//
//             const SizedBox(height: 30),
//
//             // Content based on selected tab
//             if (tabIndex == 2)
//             // Custom Date + 12-hour picker
//               Column(
//                 children: [
//                   CalendarDatePicker(
//                     initialDate: selectedDateTime,
//                     firstDate: DateTime.now(),
//                     lastDate: DateTime.now().add(const Duration(days: 365)),
//                     onDateChanged: (date) {
//                       setState(() {
//                         selectedDateTime = selectedDateTime.copyWith(
//                           year: date.year,
//                           month: date.month,
//                           day: date.day,
//                         );
//                       });
//                     },
//                   ),
//
//                   // 12-hour time picker with arrows
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 40),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // Hour
//                         Column(
//                           children: [
//                             IconButton(
//                               icon: const Icon(Icons.keyboard_arrow_up),
//                               onPressed: () {
//                                 setState(() {
//                                   hour12 = hour12 == 12 ? 1 : hour12 + 1;
//                                   _updateDateTimeFrom12Hour();
//                                 });
//                               },
//                             ),
//                             Text(
//                               hour12.toString().padLeft(2, '0'),
//                               style: const TextStyle(fontSize: 40),
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.keyboard_arrow_down),
//                               onPressed: () {
//                                 setState(() {
//                                   hour12 = hour12 == 1 ? 12 : hour12 - 1;
//                                   _updateDateTimeFrom12Hour();
//                                 });
//                               },
//                             ),
//                           ],
//                         ),
//
//                         const Text(' : ', style: TextStyle(fontSize: 40)),
//
//                         // Minute
//                         Column(
//                           children: [
//                             IconButton(
//                               icon: const Icon(Icons.keyboard_arrow_up),
//                               onPressed: () {
//                                 setState(() {
//                                   minute = (minute + 1) % 60;
//                                   _updateDateTimeFrom12Hour();
//                                 });
//                               },
//                             ),
//                             Text(
//                               minute.toString().padLeft(2, '0'),
//                               style: const TextStyle(fontSize: 40),
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.keyboard_arrow_down),
//                               onPressed: () {
//                                 setState(() {
//                                   minute = minute == 0 ? 59 : minute - 1;
//                                   _updateDateTimeFrom12Hour();
//                                 });
//                               },
//                             ),
//                           ],
//                         ),
//
//                         const SizedBox(width: 30),
//
//                         // AM/PM toggle
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               isAM = !isAM;
//                               _updateDateTimeFrom12Hour();
//                             });
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                             decoration: BoxDecoration(
//                               color: Colors.grey[200],
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             child: Text(
//                               isAM ? 'AM' : 'PM',
//                               style: const TextStyle(fontSize: 28),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               )
//             else
//             // Wheel picker for Today / Tomorrow - FIXED VERSION
//               SizedBox(
//                 height: 240,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Hour Wheel
//                     SizedBox(
//                       width: 100,
//                       child: ListWheelScrollView.useDelegate(
//                         controller: hourController,
//                         itemExtent: itemExtent,
//                         physics: const FixedExtentScrollPhysics(),
//                         magnification: 1.4,
//                         useMagnifier: true,
//                         overAndUnderCenterOpacity: 0.5,
//                         onSelectedItemChanged: (index) {
//                           setState(() {
//                             selectedDateTime = selectedDateTime.copyWith(hour: index % 24);
//                           });
//                         },
//                         childDelegate: ListWheelChildLoopingListDelegate(
//                           children: List.generate(24, (h) {
//                             return Center(
//                               child: Text(
//                                 h.toString().padLeft(2, '0'),
//                                 style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
//                               ),
//                             );
//                           }),
//                         ),
//                       ),
//                     ),
//
//                     // Colon
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 8),
//                       child: Text(
//                         ':',
//                         style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//
//                     // Minute Wheel
//                     SizedBox(
//                       width: 100,
//                       child: ListWheelScrollView.useDelegate(
//                         controller: minuteController,
//                         itemExtent: itemExtent,
//                         physics: const FixedExtentScrollPhysics(),
//                         magnification: 1.4,
//                         useMagnifier: true,
//                         overAndUnderCenterOpacity: 0.5,
//                         onSelectedItemChanged: (index) {
//                           setState(() {
//                             selectedDateTime = selectedDateTime.copyWith(minute: index % 60);
//                           });
//                         },
//                         childDelegate: ListWheelChildLoopingListDelegate(
//                           children: List.generate(60, (m) {
//                             return Center(
//                               child: Text(
//                                 m.toString().padLeft(2, '0'),
//                                 style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
//                               ),
//                             );
//                           }),
//                         ),
//                       ),
//                     ),
//
//                     // AM/PM Indicator
//                     const SizedBox(width: 30),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                       decoration: BoxDecoration(
//                         color: Colors.amber.withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(color: Colors.amber),
//                       ),
//                       child: Text(
//                         _getAmPm(),
//                         style: const TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.amber,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//             const SizedBox(height: 30),
//
//             // Buttons
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       style: OutlinedButton.styleFrom(
//                         side: const BorderSide(color: Colors.orange),
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//                       ),
//                       onPressed: () => Navigator.pop(context),
//                       child: const Text('Cancel', style: TextStyle(color: Colors.orange)),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.amber[700],
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//                       ),
//                       onPressed: () {
//                         // Handle the scheduled time here
//                         print('Scheduled ride for: $selectedDateTime');
//                         // Navigator.pop(context);
//                         // ShowFindingRiderSheet(context);
//                         Get.to(()=>ScheduleRideWithBottomScreen());
//
//                       },
//                       child: const Text(
//                         'Set Schedule',
//                         style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }

/////////////////


// void showTimePickerBottomSheet(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (context) => const TimePickerBottomSheet(),
//   );
// }

class TimePickerBottomSheet extends StatelessWidget {
  TimePickerBottomSheet({super.key});

  final controller = Get.put(DateTimePickerController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Obx(
            () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Header(),
            const SizedBox(height: 16),

            _Tabs(controller),
            const SizedBox(height: 24),

            // Animated body content
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.1), // slightly from bottom
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: _getBodyWidget(controller),
            ),

            const SizedBox(height: 30),
            _Buttons(controller),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _getBodyWidget(DateTimePickerController controller) {
    // Use Key to let AnimatedSwitcher know the widget changed
    if (controller.selectedTab.value == 0 || controller.selectedTab.value == 1) {
      return KeyedSubtree(
        key: ValueKey(controller.selectedTab.value),
        child: _TimeWheels(controller),
      );
    } else {
      return KeyedSubtree(
        key: ValueKey(controller.selectedTab.value),
        child: CustomDateTimePicker(),
      );
    }
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          const CommonText(
            text: 'Schedule a Ride',
            fontSize: 18,
            color: AppColors.textDark,
            fontWeight: FontWeight.w500,
          ),
          Divider(color: AppColors.gray200,)
        ],
      ),
    );
  }
}

class _Tabs extends StatelessWidget {
  final DateTimePickerController controller;
  const _Tabs(this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: ['Today', 'Tomorrow', 'Select Date']
            .asMap()
            .entries
            .map((e) => Expanded(
          child: GestureDetector(
            onTap: () => controller.selectedTab.value = e.key,
            child: Obx(() {
              final isSelected =
                  controller.selectedTab.value == e.key; // ✅ USED HERE
              return Container(
                padding:
                const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.orange300
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: CommonText(
                  text: e.value,
                  textAlign: TextAlign.center,
                  color:
                  isSelected ? Colors.white : Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              );
            }),
          ),
        ))
            .toList(),
      ),
    );
  }
}

class _TimeWheels extends StatelessWidget {
  final DateTimePickerController controller;
  const _TimeWheels(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// HOURS
        _Wheel(
          items: List.generate(
            12,
                (i) => (i + 1).toString().padLeft(2, '0'),
          ),
          selectedIndex: controller.hourIndex,
          controller: controller.hourController,
        ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CommonText(
            text: ':',
            fontSize: 48,
            color: AppColors.orange300,
            fontWeight: FontWeight.w600,
          ),
        ),

        /// MINUTES
        _Wheel(
          items: List.generate(
            60,
                (i) => i.toString().padLeft(2, '0'),
          ),
          selectedIndex: controller.minuteIndex,
          controller: controller.minuteController,
        ),

        const SizedBox(width: 24),

        /// AM / PM
        _Wheel(
          items: const ['AM', 'PM'],
          selectedIndex: controller.periodIndex,
          controller: controller.periodController,
        ),
      ],
    );
  }
}


class _Wheel extends StatelessWidget {
  final List<String> items;
  final RxInt selectedIndex;
  final FixedExtentScrollController controller;

  const _Wheel({
    required this.items,
    required this.selectedIndex,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Obx(() {
            final current = selectedIndex.value;

            return ListWheelScrollView.useDelegate(
              controller: controller,
              itemExtent: 50,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (i) => selectedIndex.value = i,
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: items.length,
                builder: (_, i) => Center(
                  child: CommonText(
                    text: items[i],
                    fontSize: i == current ? 40 : 24,
                    fontWeight:
                    i == current ? FontWeight.w500 : FontWeight.normal,
                    color: i == current ? AppColors.orange300 : Colors.grey,
                  ),
                ),
              ),
            );
          }),
          Container(
            height: 50,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColors.orange300,),
                bottom: BorderSide(color: AppColors.orange300,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _Buttons extends StatelessWidget {
  final DateTimePickerController controller;
  const _Buttons(this.controller);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: CommonButton(
              onTap:() => Get.back(),
              buttonRadius: 12,
              borderColor: AppColors.orange300,
              firstGradient: Colors.transparent,
              secondGradient: Colors.transparent,
              titleText: 'Cancel',
              titleColor: AppColors.orange300,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: CommonButton(
              onTap:() {
                final time = controller.selectedTime;
                debugPrint('Selected: $time');
                controller.isSetScheduled.value = true;
                Get.to(()=>ScheduleRideWithBottomScreen());
              },
              buttonRadius: 12,
              firstGradient: AppColors.orange300,
              secondGradient: AppColors.orange500,
              titleText: 'Set Schedule',
            ),
          ),
        ],
      ),
    );
  }
}


// Your existing TimePickerController (unchanged)
class CustomDateTimePicker extends StatelessWidget {
  const CustomDateTimePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTimePickerController timeController = Get.find<DateTimePickerController>();

    final Rx<DateTime> selectedDate = DateTime.now().obs;
    final Rx<DateTime> displayedMonth = DateTime.now().obs;

    void showYearPicker() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const CommonText(text: 'Select Year', fontSize: 18, fontWeight: FontWeight.w600),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: ListWheelScrollView.useDelegate(
              itemExtent: 50,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) {
                final newYear = DateTime.now().year - 10 + index;
                displayedMonth.value = DateTime(newYear, displayedMonth.value.month);
              },
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: 21,
                builder: (context, index) {
                  final year = DateTime.now().year - 10 + index;
                  final isSelected = year == displayedMonth.value.year;
                  return Center(
                    child: CommonText(
                      text: '$year',
                      fontSize: 24,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.black,
                    ),
                  );
                },
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const CommonText(text: 'OK', fontSize: 16),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // ====================== CUSTOM CALENDAR ======================
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.black50)
          ),
          child: Obx(() {
            final year = displayedMonth.value.year;
            final month = displayedMonth.value.month;

            final firstDayOfMonth = DateTime(year, month, 1);
            final lastDayOfMonth = DateTime(year, month + 1, 0);
            final daysInMonth = lastDayOfMonth.day;
            final startingWeekday = firstDayOfMonth.weekday;
            final leadingEmptyDays = startingWeekday - 1;

            selectedDate.value; // reactive

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ------------------ HEADER ------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left, size: 30),
                      onPressed: () {
                        displayedMonth.value = DateTime(year, month - 1);
                      },
                    ),
                    GestureDetector(
                      onTap: showYearPicker,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CommonText(
                            text: '${_monthName(month)} $year',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.keyboard_arrow_down, size: 24),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right, size: 30),
                      onPressed: () {
                        displayedMonth.value = DateTime(year, month + 1);
                      },
                    ),
                  ],
                ),

                // ------------------ WEEKDAY LABELS ------------------
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 7,
                  childAspectRatio: 2,
                  padding: EdgeInsets.zero,
                  children: ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN']
                      .map((day) => Center(
                    child: CommonText(
                      text: day,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.gray400,
                    ),
                  ))
                      .toList(),
                ),

                // ------------------ DAYS GRID ------------------
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1.5,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: leadingEmptyDays + daysInMonth,
                  itemBuilder: (context, index) {
                    if (index < leadingEmptyDays) return const SizedBox.shrink();

                    final day = index - leadingEmptyDays + 1;
                    final date = DateTime(year, month, day);

                    final isSelected = selectedDate.value.year == date.year &&
                        selectedDate.value.month == date.month &&
                        selectedDate.value.day == date.day;

                    final isToday = date.year == DateTime.now().year &&
                        date.month == DateTime.now().month &&
                        date.day == DateTime.now().day;

                    final isPast = date.isBefore(DateTime.now().subtract(const Duration(days: 1)));

                    return GestureDetector(
                      onTap: isPast ? null : () => selectedDate.value = date,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected ? AppColors.orange300 : Colors.transparent,
                        ),
                        child: Center(
                          child: CommonText(
                            text: '$day',
                            fontSize: 16,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected
                                ? Colors.white
                                : (isToday ? Colors.orange : (isPast ? Colors.grey.shade400 : Colors.black)),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }),
        ),

        const SizedBox(height: 20),

        // ====================== TIME PICKER ======================
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.black50)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _TimeColumn(
                currentIndex: timeController.hourIndex,
                maxIndex: 11,
                onChanged: (newIndex) {
                  timeController.hourIndex.value = newIndex;
                  timeController.hourController.jumpToItem(newIndex);
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: CommonText(text: ':', fontSize: 56, color: Colors.grey),
              ),
              _TimeColumn(
                currentIndex: timeController.minuteIndex,
                maxIndex: 59,
                onChanged: (newIndex) {
                  timeController.minuteIndex.value = newIndex;
                  timeController.minuteController.jumpToItem(newIndex);
                },
              ),
              const SizedBox(width: 26),
              Obx(() {
                return Row(
                  children: [
                    InkWell(
                      onTap: () {
                        timeController.periodIndex.value =
                        timeController.periodIndex.value == 0 ? 1 : 0;
                        timeController.periodController.jumpToItem(
                            timeController.periodIndex.value);
                      },
                      child: _ArrowButton(icon: Icons.arrow_back_ios, iconSize: 18),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: CommonText(
                        text: timeController.periodIndex.value == 0 ? 'AM' : 'PM',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        timeController.periodIndex.value =
                        timeController.periodIndex.value == 0 ? 1 : 0;
                        timeController.periodController.jumpToItem(
                            timeController.periodIndex.value);
                      },
                      child: _ArrowButton(icon: Icons.arrow_forward_ios, iconSize: 18),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  String _monthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
}


class _TimeColumn extends StatelessWidget {
  final RxInt currentIndex;
  final int maxIndex;
  final Function(int) onChanged;

  const _TimeColumn({
    required this.currentIndex,
    required this.maxIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ArrowButton(
          icon: Icons.keyboard_arrow_up,
          onTap: () {
            final newIndex = (currentIndex.value + 1) % (maxIndex + 1);
            onChanged(newIndex);
          },
        ),
        Obx(() => CommonText(
          text: (currentIndex.value + (maxIndex == 11 ? 1 : 0))
              .toString()
              .padLeft(2, '0'),
          fontSize: 20,
          fontWeight: FontWeight.w500,
        )),
        _ArrowButton(
          icon: Icons.keyboard_arrow_down,
          onTap: () {
            final newIndex =
            currentIndex.value == 0 ? maxIndex : currentIndex.value - 1;
            onChanged(newIndex);
          },
        ),
      ],
    );
  }
}

class _ArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final double iconSize;

  const _ArrowButton({required this.icon, this.onTap, this.iconSize = 28});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[200],
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.grey[600],
            size: iconSize,
          ),
        ),
      ),
    );
  }
}