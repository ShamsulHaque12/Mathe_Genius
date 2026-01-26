import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class QuizResultDialog extends StatelessWidget {
  final int score;
  final int correct;
  final int wrong;
  final VoidCallback? onPlayAgain;
  final VoidCallback? onBack;

  const QuizResultDialog({
    super.key,
    required this.score,
    required this.correct,
    required this.wrong,
    this.onPlayAgain,
    this.onBack,
  });

  TextStyle _textStyle({
    double? size,
    FontWeight? weight,
    Color? color,
  }) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
      decoration: TextDecoration.none, // 🔥 underline removed
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        padding: EdgeInsets.all(24.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          gradient: const LinearGradient(
            colors: [Color(0xff1D2671), Color(0xffC33764)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.emoji_events, color: Colors.amber, size: 80.sp),

            SizedBox(height: 8.h),

            Center(
              child: Text(
                "Challenge Completed!",
                textAlign: TextAlign.center,
                style: _textStyle(
                  size: 22.sp,
                  weight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            SizedBox(height: 20.h),

            _infoRow("Your Score", score),
            SizedBox(height: 12.h),
            _infoRow("Correct Answers", correct),
            SizedBox(height: 12.h),
            _infoRow("Wrong Answers", wrong),

            SizedBox(height: 28.h),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onBack ?? () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      "Back",
                      style: _textStyle(
                        size: 14.sp,
                        weight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onPlayAgain,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      "Play Again",
                      style: _textStyle(
                        size: 14.sp,
                        weight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String title, int value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: _textStyle(
            size: 16.sp,
            weight: FontWeight.w600,
            color: Colors.white70,
          ),
        ),
        Text(
          value.toString(),
          style: _textStyle(
            size: 18.sp,
            weight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
