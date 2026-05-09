import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/components/gradient_scafold.dart';
import 'package:project_borla/role/garbageCollector/call/controller/call_controller.dart';

import '../../components/text/common_text.dart';
import 'ongoing_call_screen.dart';
import 'widget/shake_widget.dart';

class IncomingCallScreen extends StatefulWidget {
  IncomingCallScreen({super.key});

  @override
  State<IncomingCallScreen> createState() => _IncomingCallScreenState();
}

class _IncomingCallScreenState extends State<IncomingCallScreen> {
  CallController controller = Get.find<CallController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.startCallingDots();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 0),

            /// ---------------- CALLER INFO ----------------
            Column(
              children: [

                Obx(() => ShakeWidget(
                    isActive: controller.isRinging.value,
                    child: CommonText(
                      text: 'incoming_call'.tr,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                Obx(() => CommonText(
                    text: '.' * controller.callingDots.value,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 20),

                /// Profile Picture
                CircleAvatar(
                  radius: 90,
                  backgroundColor: Colors.green,
                  child: CircleAvatar(
                    radius: 86,
                    backgroundImage: const NetworkImage(
                      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                /// Caller Name
                const CommonText(
                  text: 'McKenna Thomas',
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                /// Phone Number
                const CommonText(
                  text: 'Mobile +1 (555) 123-4567',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),

            /// ---------------- ACTION BUTTONS ----------------
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Decline Button
                  FloatingActionButton.large(
                    heroTag: 'decline',
                    backgroundColor: Colors.red,
                    onPressed: () {
                      controller.isRinging.value = false;
                      controller.stopCallingDots();
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.call_end,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 80),

                  /// Accept Button
                  FloatingActionButton.large(
                    heroTag: 'accept',
                    backgroundColor: Colors.green,
                    onPressed: () {
                      controller.isRinging.value = false;
                      controller.stopCallingDots();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OngoingCallScreen(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.call,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
