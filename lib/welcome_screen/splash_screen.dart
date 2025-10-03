import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mathe_genius/welcome_screen/welcome_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure the navigation runs after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        Get.offAll(() => const WelcomeScreen());
      });
    });

    return Scaffold(
      body: Center(child: Lottie.asset('assets/lottie/littlegirl.json')),
    );
  }
}
