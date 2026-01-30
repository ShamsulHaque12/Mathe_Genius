import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

import '../../../core/custom_widgets/leading_button_appbar.dart';

class WeeklyDetailScreen extends StatelessWidget {
  final String operation;
  const WeeklyDetailScreen({super.key, required this.operation});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('quiz_scores');
    final opData = box.get(operation) ?? {};

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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LeadingButtonAppbar(
                  text: "Weekly Detail ($operation)",
                ),
                SizedBox(height: 12.h),
                Text(
                  "Weekly Breakdown",
                  style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12.h),
          
                /// List of 7 days vertically
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      final dayData = opData['day${index + 1}'] ??
                          {"correct": 0, "total": 0, "point": 0, "percentage": 0.0};
          
                      double progress = 0.0;
                      if ((dayData['total'] ?? 0) > 0) {
                        progress = (dayData['correct'] / dayData['total']).toDouble();
                      }
          
                      return Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          gradient: LinearGradient(
                            colors: [Colors.purple.shade400, Colors.purple.shade200],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Day ${index + 1}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              "Correct: ${dayData['correct']} / ${dayData['total']}",
                              style: TextStyle(color: Colors.white, fontSize: 14.sp),
                            ),
                            Text(
                              "Points: ${dayData['point']}",
                              style: TextStyle(color: Colors.white, fontSize: 14.sp),
                            ),
                            Text(
                              "Percentage: ${dayData['percentage'].toStringAsFixed(2)}%",
                              style: TextStyle(color: Colors.white, fontSize: 14.sp),
                            ),
                            SizedBox(height: 6.h),
                            /// Progress bar
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: LinearProgressIndicator(
                                value: progress, // 0.0 - 1.0
                                minHeight: 12.h,
                                backgroundColor: Colors.white24,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.greenAccent.shade400),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
