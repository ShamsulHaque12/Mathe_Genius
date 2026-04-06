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
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    LeadingButtonAppbar(),
                    SizedBox(width: 10.w),
                    Text(
                      "Generate Table",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                /// 🔊 ACTION BUTTONS
                GetBuilder<LearnTableController>(
                  builder: (c) {
                    return Row(
                      children: [
                        // Play/Pause button
                        _actionBtn(
                          icon: c.isSpeaking.value
                              ? Icons.pause
                              : Icons.play_arrow,
                          text: c.isSpeaking.value ? "Pause" : "Play",
                          isActive: c.isSpeaking.value,
                          onTap: () {
                            if (c.isSpeaking.value) {
                              c.stopVoice();
                            } else {
                              c.playVoice();
                            }
                          },
                        ),
                        SizedBox(width: 10.w),

                        // Save button
                        _actionBtn(
                          icon: Icons.favorite,
                          text: c.isSaved.value ? "Saved" : "Save",
                          isActive: c.isSaved.value,
                          activeColor: Colors.green,
                          onTap: c.isSaved.value
                              ? () {} // disabled
                              : () {
                                  c.saveTable();
                                },
                        ),
                      ],
                    );
                  },
                ),

                SizedBox(height: 10.h),
                Divider(thickness: 1.w, color: Colors.white70),
                SizedBox(height: 6.h),

                Center(
                  child: Text(
                    "Generated Table Results",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),

                /// 📋 TABLE RESULT (Separated Containers)
                GetBuilder<LearnTableController>(
                  builder: (c) {
                    return Column(
                      children: c.tableList.map((e) {
                        return Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                            bottom: 10.h,
                          ), // Proti line er por gap
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.white.withOpacity(
                              0.15,
                            ), // Shlow white glass effect
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                            ), // Subtle border
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                e,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
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
    Color activeColor = Colors.blueAccent,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: isActive ? activeColor : Colors.white.withOpacity(0.2),
          border: Border.all(color: Colors.white),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: Colors.white),
            SizedBox(width: 4.w),
            Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
