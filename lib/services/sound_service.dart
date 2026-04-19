import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class SoundService {
  SoundService._();

  static final SoundService _instance = SoundService._();
  static SoundService get instance => _instance;

  final AudioPlayer _messageReceivePlayer = AudioPlayer();
  final AudioPlayer _messageSendPlayer = AudioPlayer();
  final AudioPlayer _dispatchPlayer = AudioPlayer();

  bool _isInitialized = false;

  Future<void> _initialize() async {
    if (_isInitialized) return;
    try {
      await _messageReceivePlayer.setSource(AssetSource('sounds/messageReceiveTone.mp3'));
      await _messageSendPlayer.setSource(AssetSource('sounds/messageSendTone.mp3'));
      await _dispatchPlayer.setSource(AssetSource('sounds/dispatchTone.mp3'));
      _isInitialized = true;
    } catch (e) {
      debugPrint('SoundService: Error initializing: $e');
    }
  }

  /// Play message receive tone (for new incoming messages)
  Future<void> playMessageReceive() async {
    try {
      await _initialize();
      await _messageReceivePlayer.stop();
      await _messageReceivePlayer.resume();
      debugPrint('SoundService: Playing message receive tone');
    } catch (e) {
      debugPrint('SoundService: Error playing message receive tone: $e');
    }
  }

  /// Play message send tone (when sending a message)
  Future<void> playMessageSend() async {
    try {
      await _initialize();
      await _messageSendPlayer.stop();
      await _messageSendPlayer.resume();
      debugPrint('SoundService: Playing message send tone');
    } catch (e) {
      debugPrint('SoundService: Error playing message send tone: $e');
    }
  }

  /// Play dispatch tone (for new bookings)
  Future<void> playDispatch() async {
    try {
      await _initialize();
      await _dispatchPlayer.stop();
      await _dispatchPlayer.resume();
      debugPrint('SoundService: Playing dispatch tone');
    } catch (e) {
      debugPrint('SoundService: Error playing dispatch tone: $e');
    }
  }

  /// Dispose all audio players
  void dispose() {
    _messageReceivePlayer.dispose();
    _messageSendPlayer.dispose();
    _dispatchPlayer.dispose();
    debugPrint('SoundService: Disposed all audio players');
  }
}
