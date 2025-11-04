import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:mathe_genius/auth/signup_screen/controller/sign_up_controller.dart';

import '../../../core/custom_widgets/custom_button_gradient.dart';
import '../../../core/custom_widgets/custom_text_field.dart';
import '../../../core/custom_widgets/leading_button_appbar.dart';
import '../../otp_screen/views/otp_screen.dart';

class SignUpScreen extends StatelessWidget {
  final SignUpController controller = Get.put(SignUpController());
  SignUpScreen({super.key});

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
              height: 100.h,
              width: double.infinity,
            ),
            CustomTextField(
              titleText: "Enter Your Name*",
              textEditingController: controller.nameController,
              hintText: "Enter your name",
            ),
            SizedBox(height: 15.h),
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
              hintText: "Enter your pass",
            ),
            SizedBox(height: 15.h),
            CustomTextField(
              titleText: "Enter Your Confirm Password*",
              textEditingController: controller.confirmPasswordController,
              hintText: "Enter your confirm pass",
            ),
            SizedBox(height: 15.h),
            CustomButtonGradient(
              text: "Submit",
              onPressed: () {
                Get.to(()=>OtpScreen(
                  email: controller.emailController.text,
                ));
              },
              gradientColors: [Colors.blue, Color.fromARGB(255, 31, 110, 61)],
            ),
          ],
        ),
      ),
    );
  }
}
