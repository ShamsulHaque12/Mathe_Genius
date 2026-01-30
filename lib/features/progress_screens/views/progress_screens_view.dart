import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:get/get.dart';
import 'package:mathe_genius/features/progress_screens/views/weekly_detail_screen.dart';

import '../../../core/custom_widgets/leading_button_appbar.dart';

class ProgressScreensView extends StatelessWidget {
  const ProgressScreensView({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('quiz_scores');

    final List<Map<String, dynamic>> operations = [
      {
        "symbol": "+",
        "colors": [Color(0xFF4CAF50), Color(0xFF81C784)],
      },
      {
        "symbol": "-",
        "colors": [Color(0xFFE53935), Color(0xFFFF7043)],
      },
      {
        "symbol": "×",
        "colors": [Color(0xFF3949AB), Color(0xFF5C6BC0)],
      },
      {
        "symbol": "÷",
        "colors": [Color(0xFFFB8C00), Color(0xFFFFCA28)],
      },
    ];

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
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LeadingButtonAppbar(text: "Progress"),
                Text(
                  "Your Quiz Progress",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 12.h),
          
                /// Cards per operation
                ...operations.map((op) {
                  final opData = box.get(op['symbol']) ?? {};
          
                  // total for week
                  int totalCorrect = 0;
                  int totalQuestions = 0;
                  int totalPoints = 0;
          
                  for (int day = 1; day <= 7; day++) {
                    final dayData =
                        opData['day$day'] ??
                        {"correct": 0, "total": 0, "point": 0, "percentage": 0.0};
          
                    totalCorrect += (dayData['correct'] as num?)?.toInt() ?? 0;
                    totalQuestions += (dayData['total'] as num?)?.toInt() ?? 0;
                    totalPoints += (dayData['point'] as num?)?.toInt() ?? 0;
                  }
          
                  double totalPercentage = totalQuestions > 0
                      ? (totalCorrect / totalQuestions) * 100
                      : 0.0;
                  double percent = totalPercentage / 100;
          
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => WeeklyDetailScreen(operation: op['symbol']));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 12.h),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        gradient: LinearGradient(
                          colors: List<Color>.from(op['colors']),
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Operation: ${op['symbol']}",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "Correct: $totalCorrect / $totalQuestions",
                            style: TextStyle(fontSize: 16.sp, color: Colors.white),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "Points: $totalPoints",
                            style: TextStyle(fontSize: 16.sp, color: Colors.white),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "Percentage: ${totalPercentage.toStringAsFixed(2)}%",
                            style: TextStyle(fontSize: 16.sp, color: Colors.white),
                          ),
                          SizedBox(height: 12.h),
          
                          /// Mini progress bar with two colors
                          Row(
                            children: [
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Stack(
                                  children: [
                                    /// background remaining
                                    Container(
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white24,
                                        borderRadius: BorderRadius.circular(10.r),
                                      ),
                                    ),
          
                                    /// completed portion
                                    FractionallySizedBox(
                                      widthFactor: percent,
                                      child: Container(
                                        height: 20.h,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                            255,
                                            180,
                                            39,
                                            157,
                                          ),
                                          borderRadius: BorderRadius.circular(10.r),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
