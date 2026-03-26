
import 'dart:async';
import 'dart:ui';

class DeBouncer {
  final Duration delay;
  Timer? _timer;

  DeBouncer({this.delay = const Duration(milliseconds: 500)});

  void call(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void dispose() {
    _timer?.cancel();
  }
}