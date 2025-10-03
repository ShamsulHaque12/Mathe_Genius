import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mathe_genius/auth/sign_up_screen.dart';
import 'package:mathe_genius/core/custom_widgets/custom_button_gradient.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Mathe Genius!',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Lottie.asset('assets/lottie/children.json'),
          ],
        ),
      ),
      bottomSheet: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 198, 202, 209),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        height: 150.h,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButtonGradient(
              text: "Log In",
              onPressed: () {},
              width: 200.w,
              gradientColors: [
                Colors.blue,
                const Color.fromARGB(255, 31, 110, 61),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => SignUpScreen());
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Color.fromARGB(255, 223, 8, 26),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.facebook,
                    color: Colors.blue,
                    size: 50,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.g_mobiledata,
                    color: Colors.red,
                    size: 50,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.apple, color: Colors.black, size: 50),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
