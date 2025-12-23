import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathe_genius/core/custom_widgets/custom_button_gradient.dart';
import 'package:mathe_genius/core/custom_widgets/custom_text_field.dart';
import 'package:mathe_genius/features/learn_table/controller/learn_table_controller.dart';

import '../../../core/custom_widgets/leading_button_appbar.dart';
import 'genaret_screen.dart';

class LearnTableScreen extends StatelessWidget {
  final LearnTableController controller = Get.put(LearnTableController());
  LearnTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(600),
        child: SafeArea(child: LeadingButtonAppbar(text: "Learn Table")),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Generate Table",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Center(
              child: Text(
                "Create your multiplication magic!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Text(
                  "First Number : ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  "1 - 20 Numbers",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Container(
                  height: 50.h,
                  width: 50.w,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: Text(
                      "-",
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                CustomTextField(
                  width: 200.w,
                  textEditingController: controller.numberController,
                  hintText: "Number",
                ),
                SizedBox(width: 10.w),
                Container(
                  height: 50.h,
                  width: 50.w,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: Text(
                      "+",
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Image.asset(
              "assets/images/tom.jpg",
              height: 150.h,
              width: double.infinity,
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Text(
                  "Multiplication Number : ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  "1 - 20 Numbers",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Container(
                  height: 50.h,
                  width: 50.w,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: Text(
                      "-",
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                CustomTextField(
                  width: 200.w,
                  textEditingController: controller.numberController,
                  hintText: "Number",
                ),
                SizedBox(width: 10.w),
                Container(
                  height: 50.h,
                  width: 50.w,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: Text(
                      "+",
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            CustomButtonGradient(
              text: "Submit",
              onPressed: () {
                Get.to(()=>GenaretScreen());
              },
              backgroundColor: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
