import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
              LeadingButtonAppbar(text: "Quiz History"),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Recent $operation Quizzes",
                              style: GoogleFonts.outfit(
                                fontSize: 26.sp,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "Review your last 7 attempts.",
                              style: GoogleFonts.outfit(
                                fontSize: 15.sp,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// 📊 RECENT 7 QUIZ LIST
                      Expanded(
                        child: attempts.isEmpty
                            ? _buildEmptyState()
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: attempts.length,
                                itemBuilder: (context, index) {
                                  // Show in reverse chronological order (latest first)
                                  final reversedIndex = attempts.length - 1 - index;
                                  final data = attempts[reversedIndex];

                                  double progress = 0.0;
                                  if ((data['total'] ?? 0) > 0) {
                                    progress = (data['correct'] / data['total']).toDouble();
                                  }

                                  return _buildAttemptCard(reversedIndex + 1, data, progress);
                                },
                              ),
                      ),
                      SizedBox(height: 10.h),
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

  Widget _buildAttemptCard(int attemptNumber, dynamic data, double progress) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.r),
        color: Colors.white.withOpacity(0.1),
        border: Border.all(
          color: Colors.white.withOpacity(0.15),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Attempt #$attemptNumber",
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w800,
                  fontSize: 18.sp,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: progress >= 0.8 ? Colors.green.withOpacity(0.2) : Colors.orange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  progress >= 0.8 ? "Excellent" : "Keep Practicing",
                  style: GoogleFonts.outfit(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: progress >= 0.8 ? Colors.greenAccent : Colors.orangeAccent,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDetailItem("Score", "${data['correct']} / ${data['total']}"),
              _buildDetailItem("Points", "${data['point']}"),
              _buildDetailItem("Accuracy", "${data['percentage'].toStringAsFixed(1)}%"),
            ],
          ),
          SizedBox(height: 15.h),

          /// Progress bar
          Stack(
            children: [
              Container(
                height: 8.h,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              FractionallySizedBox(
                widthFactor: progress.clamp(0.0, 1.0),
                child: Container(
                  height: 8.h,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFF7971E), Color(0xFFFFD200)],
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 12.sp,
            color: Colors.white54,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history_rounded, size: 60.sp, color: Colors.white24),
          SizedBox(height: 16.h),
          Text(
            "No quiz data found yet",
            style: GoogleFonts.outfit(
              color: Colors.white70,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
