import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
        "label": "Addition",
        "colors": [const Color(0xFF42E695), const Color(0xFF3BB2B8)],
      },
      {
        "symbol": "-",
        "label": "Subtraction",
        "colors": [const Color(0xFFF02FC2), const Color(0xFF6094EA)],
      },
      {
        "symbol": "×",
        "label": "Multiplication",
        "colors": [const Color(0xFF65799B), const Color(0xFF5E2563)],
      },
      {
        "symbol": "÷",
        "label": "Division",
        "colors": [const Color(0xFFF7971E), const Color(0xFFFFD200)],
      },
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
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
          child: Column(
            children: [
              // 🏷 FIXED APPBAR
              LeadingButtonAppbar(text: "Progress"),

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Performance Stats",
                        style: GoogleFonts.outfit(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Track your journey and mastery.",
                        style: GoogleFonts.outfit(
                          fontSize: 15.sp,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 25.h),

                      /// Cards per operation
                      ...operations.map((op) {
                        final opData = box.get(op['symbol']) ?? {};
                        final List attempts = opData['attempts'] ?? [];

                        int totalCorrect = 0;
                        int totalQuestions = 0;
                        int totalPoints = 0;

                        for (var attempt in attempts) {
                          totalCorrect += (attempt['correct'] as num?)?.toInt() ?? 0;
                          totalQuestions += (attempt['total'] as num?)?.toInt() ?? 0;
                          totalPoints += (attempt['point'] as num?)?.toInt() ?? 0;
                        }

                        double totalPercentage = totalQuestions > 0
                            ? (totalCorrect / totalQuestions) * 100
                            : 0.0;
                        double percent = totalPercentage / 100;

                        return _buildProgressCard(op, totalCorrect, totalQuestions, totalPoints, totalPercentage, percent);
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressCard(Map<String, dynamic> op, int totalCorrect, int totalQuestions, int totalPoints, double totalPercentage, double percent) {
    return GestureDetector(
      onTap: () {
        Get.to(() => WeeklyDetailScreen(operation: op['symbol']));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28.r),
          color: Colors.white.withOpacity(0.12),
          border: Border.all(
            color: Colors.white.withOpacity(0.15),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28.r),
          child: Stack(
            children: [
              /// Color accent line at the bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 4.h,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: List<Color>.from(op['colors']),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                color: (op['colors'] as List<Color>).first.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                op['symbol'],
                                style: GoogleFonts.outfit(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              op['label'],
                              style: GoogleFonts.outfit(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const Icon(Icons.chevron_right_rounded, color: Colors.white70),
                      ],
                    ),
                    SizedBox(height: 18.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatItem("Correct", "$totalCorrect / $totalQuestions"),
                        _buildStatItem("Points", "$totalPoints"),
                        _buildStatItem("Accuracy", "${totalPercentage.toStringAsFixed(1)}%"),
                      ],
                    ),
                    SizedBox(height: 18.h),

                    /// 📊 PROGRESS BAR
                    Stack(
                      children: [
                        Container(
                          height: 10.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: percent.clamp(0.0, 1.0),
                          child: Container(
                            height: 10.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: List<Color>.from(op['colors']),
                              ),
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: [
                                BoxShadow(
                                  color: (op['colors'] as List<Color>).first.withOpacity(0.5),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 12.sp,
            color: Colors.white54,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 15.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
