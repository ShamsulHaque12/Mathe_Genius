import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mathe_genius/core/custom_widgets/custom_button_gradient.dart';
import 'package:mathe_genius/navigation_screens/views/app_navigation_bar.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff6D83F2),
              Color(0xff9A63F7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 50.h,),
              Text(
                'Welcome to Mathe Genius!',
                style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              Lottie.asset('assets/lottie/children.json'),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xff6D83F2),
              Color(0xff9A63F7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
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
          ],
        ),
      ),
    );
  }
}
