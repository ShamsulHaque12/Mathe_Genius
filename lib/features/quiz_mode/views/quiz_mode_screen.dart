import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathe_genius/core/custom_widgets/leading_button_appbar.dart';
import 'package:mathe_genius/features/daily_challenge_screens/screems/daily_challenge_mode.dart';
import 'package:mathe_genius/features/levels_quiz_screen/screens/levels_quiz_screen.dart';
import 'package:mathe_genius/features/quiz_mode/controller/quiz_mode_controller.dart';
import 'package:mathe_genius/features/timer_quiz_screen/screen/timed_quiz_screen.dart';

class QuizModeScreen extends StatelessWidget {
  QuizModeScreen({super.key});

  final QuizModeController controller = Get.put(QuizModeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient background
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
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // APPBAR
                LeadingButtonAppbar(text: "Quiz Mode"),

                SizedBox(height: 20.h),

                Obx(
                  () => Column(
                    children: [
                      // ======= Daily Challenge =======
                      _QuizModeCard(
                        title: 'Daily\nChallenge',
                        icon: Icons.calendar_today,
                        color: Colors.orange,
                        onTap: () => Get.to(() => DailyChallengeMode()),
                      ),
                      SizedBox(height: 16.h),

                      // ======= Speed Round =======
                      _QuizModeCard(
                        title: 'Speed\nRound',
                        icon: Icons.timer,
                        color: Colors.redAccent,
                        isLocked: !controller.speedUnlocked.value,
                        onTap: () => Get.to(() => TimedQuizScreen()),
                      ),
                      SizedBox(height: 16.h),

                      // ======= Levels Quiz =======
                      _QuizModeCard(
                        title: 'Levels\nQuiz',
                        icon: Icons.bar_chart,
                        color: Colors.blue,
                        isLocked: !controller.levelsUnlocked.value,
                        onTap: () => Get.to(() => LevelsQuizScreen()),
                      ),
                      SizedBox(height: 16.h),
                    ],
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


/// ===============================
/// QUIZ MODE CARD WIDGET
/// ===============================
class _QuizModeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final bool isLocked;
  final VoidCallback? onTap;

  const _QuizModeCard({
    required this.title,
    required this.icon,
    required this.color,
    this.isLocked = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
       height: 100.h,
      width: double.infinity,
      child: Stack(
        children: [
          // ======= MAIN CARD =======
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24.r),
              onTap: isLocked ? null : onTap,
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  gradient: LinearGradient(
                    colors: [
                      color.withOpacity(0.95),
                      color.withOpacity(0.75),
                      color.withOpacity(0.55),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(18.r),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ICON with glow effect
                      Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.3),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Icon(icon, size: 32.sp, color: Colors.white),
                      ),
                      SizedBox(width: 16.w),
                      // TITLE & SUBTITLE
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.2,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              isLocked ? "Locked" : "Play Now",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ======= LOCK OVERLAY =======
          if (isLocked)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                color: Colors.black.withOpacity(0.45),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.lock_outline,
                        size: 34.sp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Score 50+ to Unlock",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
