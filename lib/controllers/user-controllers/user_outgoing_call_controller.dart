import 'dart:async';

import 'package:get/get.dart';

class UserOutgoingCallController extends GetxController{
  /// Call duration (connected state)
  final RxInt seconds = 0.obs;
  final RxBool isRinging = true.obs;


  /// UI states
  final RxBool isSpeakerOn = false.obs;
  final RxBool isMuted = false.obs;

  /// Calling dots (0 → 3)
  final RxInt callingDots = 0.obs;

  Timer? _callTimer;
  Timer? _dotTimer;

  /// Call state
  final RxBool isCallConnected = false.obs;


  /// ----------------------------
  /// CALLING DOT ANIMATION
  /// ----------------------------
  void startCallingDots() {
    _dotTimer = Timer.periodic(
      const Duration(milliseconds: 500),
          (_) {
        callingDots.value = (callingDots.value + 1) % 4;
      },
    );
  }

  void stopCallingDots() {
    _dotTimer?.cancel();
    callingDots.value = 0;
  }

  /// ----------------------------
  /// CALL TIMER (CONNECTED)
  /// ----------------------------
  void startCallTimer() {
    isCallConnected.value = true;
    stopCallingDots();

    _callTimer = Timer.periodic(
      const Duration(seconds: 1),
          (_) => seconds.value++,
    );
  }

  String get formattedTime {
    final mins = (seconds.value ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds.value % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }

  /// ----------------------------
  /// CONTROLS
  /// ----------------------------
  void toggleSpeaker() => isSpeakerOn.toggle();
  void toggleMute() => isMuted.toggle();

  /// ----------------------------
  /// END CALL
  /// ----------------------------
  void endCall() {
    _callTimer?.cancel();
    _dotTimer?.cancel();
    Get.back();
  }

  @override
  void onClose() {
    _callTimer?.cancel();
    _dotTimer?.cancel();
    super.onClose();
  }
}