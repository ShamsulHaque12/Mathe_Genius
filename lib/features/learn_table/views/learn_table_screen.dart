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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff6D83F2), Color(0xff9A63F7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    LeadingButtonAppbar(),
                    SizedBox(width: 10.w),
                    Text(
                      "Learn Table",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                /// APPBAR TITLE
                Center(
                  child: Text(
                    "Generate Table",
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Center(
                  child: Text(
                    "Create your multiplication magic!",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                /// FIRST NUMBER
                Text(
                  "First Number : ",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    _numberButton(
                      icon: "-",
                      onTap: () {
                        int value = int.parse(controller.numberController.text);
                        if (value > 0) {
                          controller.numberController.text = (value - 1).toString();
                        }
                      },
                    ),
                    SizedBox(width: 10.w),
                    CustomTextField(
                      width: 200.w,
                      textEditingController: controller.numberController,
                      hintText: "Number",
                      keyboardType: TextInputType.number,
                      textColor: Colors.white,
                      fillColor: Colors.white24,
                    ),
                    SizedBox(width: 10.w),
                    _numberButton(
                      icon: "+",
                      onTap: () {
                        int value = int.parse(controller.numberController.text);
                        controller.numberController.text = (value + 1).toString();
                      },
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                /// MULTIPLICATION NUMBER
                Text(
                  "Multiplication Number : ",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    _numberButton(
                      icon: "-",
                      onTap: () {
                        int value = int.parse(controller.multiplicationController.text);
                        if (value > 0) {
                          controller.multiplicationController.text = (value - 1).toString();
                        }
                      },
                    ),
                    SizedBox(width: 10.w),
                    CustomTextField(
                      width: 200.w,
                      textEditingController: controller.multiplicationController,
                      hintText: "Number",
                      keyboardType: TextInputType.number,
                      textColor: Colors.white,
                      fillColor: Colors.white24,
                    ),
                    SizedBox(width: 10.w),
                    _numberButton(
                      icon: "+",
                      onTap: () {
                        int value = int.parse(controller.multiplicationController.text);
                        controller.multiplicationController.text = (value + 1).toString();
                      },
                    ),
                  ],
                ),

                SizedBox(height: 30.h),

                /// GENERATE BUTTON
                CustomButtonGradient(
                  text: "Generate Table 🤩",
                  onPressed: () {
                    controller.generatedTable();
                    Get.to(() => GenaretScreen());
                  },
                  backgroundColor: Colors.amber,
                  borderRadius: 12.r,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// reusable +/- button
  Widget _numberButton({required String icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.h,
        width: 50.w,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xfff7971e), Color(0xfffdc830)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Text(
            icon,
            style: TextStyle(fontSize: 30.sp, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
