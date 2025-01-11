import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerNotifier extends StateNotifier<int> {
  TimerNotifier() : super(0);

  Timer? _timer;

  // Start the stopwatch
  void start() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = state + 1; // Increment elapsed time
    });
  }

  // Stop the stopwatch
  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  // Reset the stopwatch
  void reset() {
    stop();
    state = 0; // Reset time to 0
  }

  @override
  void dispose() {
    stop(); // Ensure timer is stopped when provider is disposed
    super.dispose();
  }
}

final timerProvider = StateNotifierProvider<TimerNotifier, int>((ref) {
  return TimerNotifier();
});
