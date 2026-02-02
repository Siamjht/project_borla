import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:project_borla/helpers/other_helper.dart';
import 'package:project_borla/screens/finding-driver-screens/finding_driver_screen.dart';
import 'package:project_borla/screens/waste-screens/waste-controllers/waste_category_controller.dart';
import 'package:project_borla/utils/app_dropdown.dart';

import '../../role/components/text/common_text.dart';
import '../../theme/app_color.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/waste-category-widgets/waste_header_widgets.dart';
import '../../widgets/waste-category-widgets/waste_photo_widgets.dart';

class WasteQtyScreen extends StatefulWidget {
  const WasteQtyScreen({super.key});

  @override
  State<WasteQtyScreen> createState() => _WasteQtyScreenState();
}

class _WasteQtyScreenState extends State<WasteQtyScreen> {

  WasteCategoryController amountController = Get.put(WasteCategoryController());

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

            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 68, 22, 22),
                child: Column(
                  children: [

                    WasteScreenHeader(),

                    SizedBox(height: 34),

                    WasteScreenSubHeader(),

                    SizedBox(height: 20),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          WasteContainer(),

                          WastePickPhoto(),

                          Text('Bin Size', style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            color: Colors.grey.shade600
                          ),),

                          const SizedBox(height: 10),

                          Obx(() => AppDropDownStyle(
                            DropdownButton<String>(
                              value: (["1", "2", "3", "4"].contains(amountController.FormValues["Size"]))
                                  ? amountController.FormValues["Size"]
                                  : null,
                              hint: const Text("Select Bin Size"),
                              items: const [
                                DropdownMenuItem(value: "1", child: Text("Small (50 L)")),
                                DropdownMenuItem(value: "2", child: Text("Medium (120 L)")),
                                DropdownMenuItem(value: "3", child: Text("Large (240 L)")),
                                DropdownMenuItem(value: "4", child: Text("Extra Large (360 L)")),
                              ],
                              onChanged: (value) {
                                amountController.FormValues["Size"] = value ?? "";
                              },
                              underline: Container(),
                              isExpanded: true,
                            ),
                          )),

                          const SizedBox(height: 14),

                          Text('Bin Quantity', style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.grey.shade600
                          ),),

                          const SizedBox(height: 10),

                          Obx(() => AppDropDownStyle(
                            DropdownButton<String>(
                              value: (["1", "2", "3", "4", "5", "6"].contains(amountController.FormValues["Qty"]))
                                  ? amountController.FormValues["Qty"]
                                  : null,
                              hint: const Text("Select Bin Quantity"),
                              items: const [
                                DropdownMenuItem(value: "1", child: Text("0")),
                                DropdownMenuItem(value: "2", child: Text("1")),
                                DropdownMenuItem(value: "3", child: Text("2")),
                                DropdownMenuItem(value: "4", child: Text("3")),
                                DropdownMenuItem(value: "5", child: Text("4")),
                                DropdownMenuItem(value: "6", child: Text("More than 5")),
                              ],
                              onChanged: (value) {
                                amountController.FormValues["Qty"] = value ?? "";
                              },
                              underline: Container(),
                              isExpanded: true,
                            ),
                          )),

                          const SizedBox(height: 14),
                          Text('Waste Size', style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.grey.shade600
                          ),),

                          const SizedBox(height: 10),

                          CustomTextField(
                            hint: 'Waste Size',
                            prefix: Image.asset('assets/images/second_pin_2.png', scale: 3.5),
                          ),

                          SizedBox(height: 40),

                          GradientButton(
                            text: 'Continue',
                            onPressed: () {
                              print(amountController.FormValues["Size"]) ;
                              print(amountController.FormValues["Qty"]) ;
                              //prints values of dropdown options, not the texts on dropdowns
                              Get.to(()=>FindingDriverScreen());
                            },
                          ),

                          SizedBox(height: 40),

                        ]

                    ),

                  ],
                ),
              ),
            ),

          ],
        )

    );
  }
}
