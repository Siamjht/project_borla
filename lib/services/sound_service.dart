import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class SoundService {
  SoundService._();

  static final SoundService _instance = SoundService._();
  static SoundService get instance => _instance;

  AudioPlayer? _messageReceivePlayer;
  AudioPlayer? _messageSendPlayer;
  AudioPlayer? _dispatchPlayer;

  /// Play message receive tone (for new incoming messages)
  Future<void> playMessageReceive() async {
    try {
      // Stop and dispose previous player if exists
      await _messageReceivePlayer?.stop();
      await _messageReceivePlayer?.dispose();
      
      // Create new player instance
      _messageReceivePlayer = AudioPlayer();
      await _messageReceivePlayer!.setSource(AssetSource('sounds/messageReceiveTone.mp3'));
      await _messageReceivePlayer!.setVolume(1.0);
      await _messageReceivePlayer!.resume();
      debugPrint('SoundService: Playing message receive tone');
    } catch (e) {
      debugPrint('SoundService: Error playing message receive tone: $e');
    }
  }

  /// Play message send tone (when sending a message)
  Future<void> playMessageSend() async {
    try {
      // Stop and dispose previous player if exists
      await _messageSendPlayer?.stop();
      await _messageSendPlayer?.dispose();
      
      // Create new player instance
      _messageSendPlayer = AudioPlayer();
      await _messageSendPlayer!.setSource(AssetSource('sounds/messageSendTone.mp3'));
      await _messageSendPlayer!.setVolume(1.0);
      await _messageSendPlayer!.resume();
      debugPrint('SoundService: Playing message send tone');
    } catch (e) {
      debugPrint('SoundService: Error playing message send tone: $e');
    }
  }

  /// Play dispatch tone (for new bookings)
  Future<void> playDispatch() async {
    try {
      // Stop and dispose previous player if exists
      await _dispatchPlayer?.stop();
      await _dispatchPlayer?.dispose();
      
      // Create new player instance
      _dispatchPlayer = AudioPlayer();
      await _dispatchPlayer!.setSource(AssetSource('sounds/dispatchTone.mp3'));
      await _dispatchPlayer!.setVolume(1.0);
      await _dispatchPlayer!.resume();
      debugPrint('SoundService: Playing dispatch tone');
    } catch (e) {
      debugPrint('SoundService: Error playing dispatch tone: $e');
    }
  }

  /// Dispose all audio players
  void dispose() {
    _messageReceivePlayer?.dispose();
    _messageSendPlayer?.dispose();
    _dispatchPlayer?.dispose();
    _messageReceivePlayer = null;
    _messageSendPlayer = null;
    _dispatchPlayer = null;
    debugPrint('SoundService: Disposed all audio players');
  }
}
