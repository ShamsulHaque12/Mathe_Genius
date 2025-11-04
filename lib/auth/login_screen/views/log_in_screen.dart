import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:mathe_genius/auth/login_screen/controller/log_in_controller.dart';
import 'package:mathe_genius/core/custom_widgets/custom_button_gradient.dart';
import 'package:mathe_genius/core/custom_widgets/custom_text_field.dart';
import '../../../core/custom_widgets/leading_button_appbar.dart';

class LogInScreen extends StatelessWidget {
  final LogInController controller = Get.put(LogInController());
  LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SafeArea(child: LeadingButtonAppbar()),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Lottie.asset(
              'assets/lottie/login.json',
              height: 200.h,
              width: double.infinity,
            ),
            CustomTextField(
              titleText: "Enter Your Email*",
              textEditingController: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              hintText: "Enter your email",
            ),
            SizedBox(height: 15.h),
            CustomTextField(
              titleText: "Enter Your Password*",
              textEditingController: controller.passwordController,
              keyboardType: TextInputType.phone,
              hintText: "Enter your pass",
            ),
            SizedBox(height: 15.h),
            CustomButtonGradient(
              text: "Log In",
              onPressed: () {},
              gradientColors: [Colors.blue, Color.fromARGB(255, 31, 110, 61)],
            ),
          ],
        ),
      ),
    );
  }
}
