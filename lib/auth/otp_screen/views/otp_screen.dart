import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathe_genius/auth/login_screen/views/log_in_screen.dart';
import 'package:mathe_genius/core/custom_widgets/custom_button_gradient.dart';
import 'package:pinput/pinput.dart';
import '../controller/otp_screen_controller.dart';
import '../../../core/custom_widgets/leading_button_appbar.dart';

class OtpScreen extends StatelessWidget {
  final OtpScreenController controller = Get.put(OtpScreenController());
  final String email;
  OtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SafeArea(child: LeadingButtonAppbar()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Title text
            Text(
              "Verify your\n${email.toString()}\naddress!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 10.h),

            Text(
              "Enter your OTP Code Here",
              style: TextStyle(fontSize: 15.sp),
            ),

            SizedBox(height: 20.h),

            /// OTP Input
            Pinput(
              length: 5,
              onChanged: (value) => controller.otpCode.value = value,
            ),

            SizedBox(height: 20.h),

            /// Timer
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.timer),
                SizedBox(width: 10),
                Text(controller.timerText),
              ],
            )),

            SizedBox(height: 10.h),

            /// Resend Text & Button
            Obx(() => controller.canResend
                ? Column(
              children: [
                Text("Didn’t receive the code?",style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),),
                TextButton(
                  onPressed: controller.resendOtp,
                  child: Text("Resend",style: TextStyle(
                    color: Colors.red,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),),
                ),
              ],
            )
                : Text(
              "Resend code in...",
              style: TextStyle(color: Colors.grey, fontSize: 15.sp),
            )),

            SizedBox(height: 30.h),

            CustomButtonGradient(text: "Submit", onPressed: (){
              Get.to(()=>LogInScreen());
            },
              gradientColors: [Colors.blue, Color.fromARGB(255, 31, 110, 61)],
            )
          ],
        ),
      ),
    );
  }
}
