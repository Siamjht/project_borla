import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../role/garbageCollector/call/outgoing_call_screen.dart';
import '../../screens/chat-screen/chat_screen_copy.dart';
import '../../theme/user_outgoing_call_screen.dart';

class DriverInfoSheetButtons extends StatelessWidget {
  const DriverInfoSheetButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [

        Expanded(
          child: SizedBox(
            height: 48,
            width: double.infinity, // takes full available width
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromRGBO(255, 214, 0, 1),
                    Color.fromRGBO(255, 149, 0, 1),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(2), // gradient border thickness
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => UserOutgoingCallScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: EdgeInsets.zero, // important for exact height
                ),
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 214, 0, 1),
                      Color.fromRGBO(255, 149, 0, 1),
                    ],
                  ).createShader(bounds),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/user_call.png',
                        color: Colors.white,
                        height: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Call',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 20,),
        Expanded(
          child: SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => UserChattingScreen());
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                elevation: 0,
                fixedSize: const Size.fromHeight(48), // 🔥 force height
                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 🔥 remove extra tap padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 214, 0, 1),
                      Color.fromRGBO(255, 149, 0, 1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SizedBox.expand( // 🔥 forces Ink to fill button
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/user_msg.png',
                        color: Colors.white,
                        height: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Chat',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}