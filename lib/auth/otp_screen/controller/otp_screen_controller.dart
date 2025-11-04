import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';

class OtpScreenController extends GetxController {
  var email = "".obs;
  var otpCode = ''.obs;
  final int _initial = 60;
  final counter = 60.obs;
  bool get canResend => counter.value == 0;
  Timer? _timer;

  Future<void> resendOtp()async {
    log("Otp send");
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    counter.value = _initial;
    _timer?.cancel();
    _timer = Timer.periodic( Duration(seconds: 1), (_) {
      if (counter.value > 0) {
        counter.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  String get timerText {
    final minutes = (counter.value ~/ 60).toString().padLeft(2, '0');
    final seconds = (counter.value % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
