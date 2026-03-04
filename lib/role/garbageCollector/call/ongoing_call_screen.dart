
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_color.dart';
import '../../components/text/common_text.dart';
import 'controller/call_controller.dart';

class OngoingCallScreen extends StatefulWidget {
  const OngoingCallScreen({super.key});

  @override
  State<OngoingCallScreen> createState() => _OngoingCallScreenState();
}

class _OngoingCallScreenState extends State<OngoingCallScreen> {

  final CallController controller = Get.put(CallController());

  @override
  void initState() {
    controller.startCallTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 60),

            /// PROFILE IMAGE
            CircleAvatar(
              radius: 80,
              backgroundColor: AppColors.green500,
              child: CircleAvatar(
                radius: 76,
                backgroundImage: const NetworkImage(
                  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// NAME + TIMER
            Column(
              children: [
                const CommonText(
                  text: 'McKenna Thomas',
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 12),

                Obx(
                      () => CommonText(
                    text: controller.formattedTime,
                    fontSize: 18,
                    color: AppColors.gray500,
                  ),
                ),
              ],
            ),

            const Spacer(),

            /// CALL CONTROLS
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Obx(
                    () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// END CALL
                    FloatingActionButton(
                      heroTag: 'end_call',
                      backgroundColor: Colors.red,
                      onPressed: controller.endCall,
                      child: const Icon(
                        Icons.call_end,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(width: 50),

                    /// SPEAKER
                    FloatingActionButton(
                      heroTag: 'speaker',
                      backgroundColor: controller.isSpeakerOn.value
                          ? AppColors.green500
                          : Colors.grey[300],
                      onPressed: controller.toggleSpeaker,
                      child: Icon(
                        controller.isSpeakerOn.value
                            ? Icons.volume_up
                            : Icons.volume_off,
                        size: 32,
                        color: controller.isSpeakerOn.value
                            ? Colors.white
                            : Colors.grey[700],
                      ),
                    ),

                    const SizedBox(width: 50),

                    /// MUTE
                    FloatingActionButton(
                      heroTag: 'mute',
                      backgroundColor: controller.isMuted.value
                          ? Colors.redAccent
                          : Colors.grey[300],
                      onPressed: controller.toggleMute,
                      child: Icon(
                        controller.isMuted.value
                            ? Icons.mic_off
                            : Icons.mic,
                        size: 32,
                        color: controller.isMuted.value
                            ? Colors.white
                            : Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
