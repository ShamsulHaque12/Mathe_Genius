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
    final List attempts = opData['attempts'] ?? [];

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
                  text: "Recent Quizzes ($operation)",
                ),
                SizedBox(height: 12.h),
                Text(
                  "Last 7 Attempts",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12.h),

                /// ===============================
                /// 📊 RECENT 7 QUIZ LIST
                /// ===============================
                Expanded(
                  child: attempts.isEmpty
                      ? Center(
                          child: Text(
                            "No quiz data found",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16.sp,
                            ),
                          ),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: attempts.length,
                          itemBuilder: (context, index) {
                            final data = attempts[index];

                            double progress = 0.0;
                            if ((data['total'] ?? 0) > 0) {
                              progress =
                                  (data['correct'] / data['total']).toDouble();
                            }

                            return Container(
                              margin: EdgeInsets.only(bottom: 12.h),
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.purple.shade400,
                                    Colors.purple.shade200
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// Attempt number
                                  Text(
                                    "Attempt ${index + 1}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 6.h),

                                  Text(
                                    "Correct: ${data['correct']} / ${data['total']}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp),
                                  ),
                                  Text(
                                    "Points: ${data['point']}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp),
                                  ),
                                  Text(
                                    "Accuracy: ${data['percentage'].toStringAsFixed(2)}%",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp),
                                  ),

                                  SizedBox(height: 8.h),

                                  /// Progress bar
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(10.r),
                                    child: LinearProgressIndicator(
                                      value: progress,
                                      minHeight: 12.h,
                                      backgroundColor: Colors.white24,
                                      valueColor:
                                          AlwaysStoppedAnimation<Color>(
                                        Colors.greenAccent.shade400,
                                      ),
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
