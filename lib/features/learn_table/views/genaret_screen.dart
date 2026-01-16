import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:mathe_genius/core/custom_widgets/leading_button_appbar.dart';
import 'package:mathe_genius/features/learn_table/controller/learn_table_controller.dart';

class GenaretScreen extends StatelessWidget {
  GenaretScreen({super.key});
  final LearnTableController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(600),
        child: SafeArea(child: LeadingButtonAppbar()),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔊 ACTION BUTTONS
            GetBuilder<LearnTableController>(
              builder: (c) {
                return Row(
                  children: [
                    _actionBtn(
                      icon: Icons.play_arrow,
                      text: "Play",
                      isActive: c.activeButton == 1,
                      onTap: () {
                        c.setActiveButton(1);
                        c.playVoice();
                      },
                    ),
                    SizedBox(width: 10.w),
                    _actionBtn(
                      icon: Icons.man,
                      text: "Man",
                      isActive: c.activeButton == 2,
                      onTap: () {
                        c.isMale = true;
                        c.setActiveButton(2);
                      },
                    ),
                    SizedBox(width: 10.w),
                    _actionBtn(
                      icon: Icons.woman,
                      text: "Woman",
                      isActive: c.activeButton == 3,
                      onTap: () {
                        c.isMale = false;
                        c.setActiveButton(3);
                      },
                    ),
                    SizedBox(width: 10.w),
                    _actionBtn(
                      icon: Icons.favorite,
                      text: "Save",
                      isActive: c.activeButton == 4,
                      onTap: () {
                        c.saveTable();
                        c.setActiveButton(4);
                      },
                    ),
                  ],
                );
              },
            ),

            SizedBox(height: 10.h),
            Divider(thickness: 1.w),
            SizedBox(height: 6.h),

            Center(
              child: Text(
                "Generated Table Results",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.green,
                ),
              ),
            ),
            SizedBox(height: 12.h),

            /// 📋 TABLE RESULT
            GetBuilder<LearnTableController>(
              builder: (c) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.blueGrey.shade100,
                  ),
                  child: Column(
                    children: c.tableList.map((e) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: Text(
                          e,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// reusable button
  Widget _actionBtn({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: isActive ? Colors.blueAccent : Colors.transparent,
          border: Border.all(color: Colors.black),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: isActive ? Colors.white : Colors.black),
            SizedBox(width: 4.w),
            Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                color: isActive ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
