import 'dart:async';

class Countdown {
  late DateTime targetDateTime;
  late Duration remainingTime;
  late StreamController<Duration> _controller;
  late Stream<Duration> countdownStream;

  Countdown(this.targetDateTime) {
    remainingTime = targetDateTime.difference(DateTime.now());
    _controller = StreamController<Duration>();
    countdownStream = _controller.stream;

    _startCountdown();
  }

  void _startCountdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingTime = targetDateTime.difference(DateTime.now());
      _controller.add(remainingTime);

      if (remainingTime.inSeconds <= 0) {
        timer.cancel();
      }
    });
  }

  void dispose() {
    _controller.close();
  }
}
