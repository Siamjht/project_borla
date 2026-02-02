import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:project_borla/screens/waste-screens/waste-controllers/waste_category_controller.dart';
import 'package:project_borla/screens/waste-screens/waste_qty_screen.dart';

import '../../bottom-sheets/user_lang_sheet.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/waste-category-widgets/waste_card_widgets.dart';

class WasteCategoryScreen extends StatefulWidget {
  const WasteCategoryScreen({super.key});

  @override
  State<WasteCategoryScreen> createState() => _WasteCategoryScreenState();
}

class _WasteCategoryScreenState extends State<WasteCategoryScreen> {

  WasteCategoryController wasteController = Get.put(WasteCategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(

          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.fitWidth,
                //alignment: Alignment.topRight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 68, 17, 22),
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                    child: Row(
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration:  BoxDecoration(
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
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),

                        SizedBox(width: 40),

                        Text('Select Waste Category', style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500
                        ),)
                      ],
                    ),
                  ),
                  SizedBox(height: 42),
                  Column(
                    children: [
                      Row(
                        children: [
                          buildCategoryCard(
                            index: 0,
                            image: 'assets/images/organic_2.png',
                            label: 'Organic',
                            scale: 4.3
                          ),
                          SizedBox(width: 18),
                          buildCategoryCard(
                            index: 1,
                            image: 'assets/images/metal_2.png',
                              label: 'Metal',
                              scale: 4.3
                          ),
                        ],
                      ),
                      SizedBox(height: 18),
                      Row(
                        children: [
                          buildCategoryCard(
                            index: 2,
                            image: 'assets/images/plastic_2.png',
                              label: 'Plastic',
                              scale: 7.5
                          ),
                          const SizedBox(width: 18),
                          buildCategoryCard(
                            index: 3,
                            image: 'assets/images/general_2.png',
                              label: 'General',
                              scale: 4.3
                          ),
                        ],
                      ),
                      SizedBox(height: 18),
                      Row(
                        children: [
                          buildCategoryCard(
                            index: 4,
                            image: 'assets/images/paper_2.png',
                              label: 'Paper',
                              scale: 7.5
                          ),
                          SizedBox(width: 18),
                        ],
                      ),
                      SizedBox(height: 60),
                      GradientButton(
                        text: 'Continue',
                        onPressed: () {
                          Get.to(WasteQtyScreen());
                        },
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        )
    );
  }
}
