import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/components/gradient_scafold.dart';

import '../../../theme/app_color.dart';
import '../../components/text/common_text.dart';
import 'controller/call_controller.dart';

class OutgoingCallScreen extends StatefulWidget {
  const OutgoingCallScreen({super.key});

  @override
  State<OutgoingCallScreen> createState() => _OutgoingCallScreenState();
}

class _OutgoingCallScreenState extends State<OutgoingCallScreen> {
  final CallController controller = Get.find<CallController>();

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
            const SizedBox(height: 80),

            /// CALL INFO
            Column(
              children: [
                /// CALLING TEXT WITH DOT ANIMATION
                Obx(
                      () => CommonText(
                    text: '${'calling'.tr}${'.' * controller.callingDots.value}',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 20),

                /// PROFILE IMAGE
                CircleAvatar(
                  radius: 90,
                  backgroundColor: AppColors.green500,
                  child: CircleAvatar(
                    radius: 86,
                    backgroundImage: const NetworkImage(
                      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80',
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                /// NAME
                const CommonText(
                  text: 'McKenna Thomas',
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),

                const SizedBox(height: 8),

                const CommonText(
                  text: 'Mobile +1 (555) 123-4567',
                  fontSize: 18,
                  color: AppColors.gray500,
                ),
              ],
            ),

            /// CONTROLS
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Obx(
                    () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// SPEAKER
                    FloatingActionButton(
                      heroTag: 'speaker_outgoing',
                      backgroundColor: controller.isSpeakerOn.value
                          ? AppColors.green500
                          : Colors.grey[600],
                      onPressed: controller.toggleSpeaker,
                      child: Icon(
                        controller.isSpeakerOn.value
                            ? Icons.volume_up
                            : Icons.volume_off,
                        size: 36,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(width: 80),

                    /// END CALL
                    FloatingActionButton.large(
                      heroTag: 'decline_outgoing',
                      backgroundColor: Colors.red,
                      onPressed: controller.endCall,
                      child: const Icon(
                        Icons.call_end,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(width: 80),

                    /// MUTE
                    FloatingActionButton(
                      heroTag: 'mute_outgoing',
                      backgroundColor: controller.isMuted.value
                          ? Colors.redAccent
                          : Colors.grey[600],
                      onPressed: controller.toggleMute,
                      child: Icon(
                        controller.isMuted.value
                            ? Icons.mic_off
                            : Icons.mic,
                        size: 36,
                        color: Colors.white,
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

