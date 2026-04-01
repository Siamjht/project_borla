import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:project_borla/screens/waste-screens/waste-controllers/waste_category_controller.dart';
import 'package:project_borla/screens/waste-screens/waste_qty_screen.dart';
import '../../controllers/user-controllers/booking_controller.dart';
import '../../role/components/customSnackbar/custom_snackbar.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/waste-category-widgets/waste_card_widgets.dart';

class WasteCategoryScreen extends StatefulWidget {
  const WasteCategoryScreen({super.key});

  @override
  State<WasteCategoryScreen> createState() => _WasteCategoryScreenState();
}

class _WasteCategoryScreenState extends State<WasteCategoryScreen> {
  final WasteCategoryController wasteController = Get.put(WasteCategoryController());
  final BookingController bookingController = Get.find<BookingController>();

  final List<Map<String, dynamic>> categories = [
    {'index': 0, 'image': 'assets/images/organic_2.png', 'label': 'Organic', 'scale': 4.3},
    {'index': 1, 'image': 'assets/images/metal_2.png', 'label': 'Metal', 'scale': 4.3},
    {'index': 2, 'image': 'assets/images/plastic_2.png', 'label': 'Plastic', 'scale': 4.3},
    {'index': 3, 'image': 'assets/images/general_2.png', 'label': 'General', 'scale': 4.3},
    {'index': 4, 'image': 'assets/images/paper_2.png', 'label': 'Paper', 'scale': 7.5},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ── Background ──────────────────────────────────────
          Positioned(
            top: 0, left: 0, right: 0,
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.fitWidth,
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 68, 17, 22),
            child: Column(
              children: [

                // ── Header ──────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                  child: Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                              color: Colors.black.withAlpha(40),
                            ),
                          ],
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 22,
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Get.back(),
                        ),
                      ),
                      SizedBox(width: 40),
                      Text(
                        'Select Waste Category',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 42),

                // ── Category Grid ────────────────────────────────
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 18,
                      childAspectRatio: 1,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, i) {
                      final cat = categories[i];
                      return buildCategoryCard(
                        index: cat['index'],
                        image: cat['image'],
                        label: cat['label'],
                        scale: cat['scale'],
                      );
                    },
                  ),
                ),

                SizedBox(height: 20),

                // ── Continue Button ──────────────────────────────
                Obx(() {
                  final selected = wasteController.selectedIndex.value;
                  return GradientButton(
                    text: 'Continue',
                    onPressed: selected == -1
                        ? () => CustomSnackbar.error('Please select a waste category')
                        : () {
                      // Store selected category in booking controller
                      bookingController.selectedWasteCategory.value = categories[selected]['label'].toString().toLowerCase();
                      Get.to(() => WasteQtyScreen());
                    },
                  );
                }),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
