import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mathe_genius/auth/signup_screen/views/sign_up_screen.dart';
import 'package:mathe_genius/core/custom_widgets/custom_button_gradient.dart';
import 'package:mathe_genius/navigation_screens/views/app_navigation_bar.dart';

import '../auth/login_screen/views/log_in_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 50.h,),
            Text(
              'Welcome to Mathe Genius!',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Lottie.asset('assets/lottie/children.json'),
          ],
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 198, 202, 209),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        height: 200.h,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButtonGradient(
              text: "Home Screen",
              onPressed: () {
                Get.to(()=>AppNavigationBar());
              },
              width: 200.w,
              gradientColors: [
                Colors.blue,
                Color.fromARGB(255, 31, 110, 61),
              ],
            ),
            SizedBox(height: 10.h),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       "Don't have an account? ",
            //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            //     ),
            //     GestureDetector(
            //       onTap: () {
            //         Get.to(() => SignUpScreen());
            //       },
            //       child: const Text(
            //         "Sign Up",
            //         style: TextStyle(
            //           color: Color.fromARGB(255, 223, 8, 26),
            //           fontWeight: FontWeight.bold,
            //           decoration: TextDecoration.underline,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 5.h),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     IconButton(
            //       icon: const Icon(
            //         Icons.facebook,
            //         color: Colors.blue,
            //         size: 50,
            //       ),
            //       onPressed: () {},
            //     ),
            //     IconButton(
            //       icon: const Icon(
            //         Icons.g_mobiledata,
            //         color: Colors.red,
            //         size: 50,
            //       ),
            //       onPressed: () {},
            //     ),
            //     IconButton(
            //       icon: const Icon(Icons.apple, color: Colors.black, size: 50),
            //       onPressed: () {},
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
