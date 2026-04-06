import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mathe_genius/core/custom_widgets/leading_button_appbar.dart';
import 'package:mathe_genius/features/daily_challenge_screens/screens/daily_challenge_mode.dart';
import 'package:mathe_genius/features/levels_quiz_screen/screens/levels_quiz_screen.dart';
import 'package:mathe_genius/features/quiz_mode/controller/quiz_mode_controller.dart';
import 'package:mathe_genius/features/timer_quiz_screen/screen/timed_quiz_screen.dart';

class QuizModeScreen extends StatelessWidget {
  QuizModeScreen({super.key});

  final QuizModeController controller = Get.put(QuizModeController());

  @override
  Widget build(BuildContext context) {
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // APPBAR
                LeadingButtonAppbar(text: "Quiz Center"),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Challenge Yourself",
                        style: GoogleFonts.outfit(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Test your skills and unlock new levels.",
                        style: GoogleFonts.outfit(
                          fontSize: 15.sp,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                Obx(
                  () => Column(
                    children: [
                      // ======= Daily Challenge =======
                      _QuizModeCard(
                        title: 'Daily Challenge',
                        subtitle: 'Test your daily math skills',
                        icon: Icons.calendar_today_rounded,
                        cardColor: Colors.orangeAccent,
                        onTap: () => Get.to(() => DailyChallengeMode()),
                        delay: 100,
                      ),
                      SizedBox(height: 16.h),

                      // ======= Speed Round =======
                      _QuizModeCard(
                        title: 'Speed Round',
                        subtitle: 'Beat the clock to win',
                        icon: Icons.timer_rounded,
                        cardColor: Colors.redAccent,
                        isLocked: !controller.speedUnlocked.value,
                        onTap: () => Get.to(() => TimedQuizScreen()),
                        delay: 200,
                      ),
                      SizedBox(height: 16.h),

                      // ======= Levels Quiz =======
                      _QuizModeCard(
                        title: 'Levels Quiz',
                        subtitle: 'Climb the math ladder',
                        icon: Icons.bar_chart_rounded,
                        cardColor: Colors.blueAccent,
                        isLocked: !controller.levelsUnlocked.value,
                        onTap: () => Get.to(() => LevelsQuizScreen()),
                        delay: 300,
                      ),
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
/// QUIZ MODE CARD WIDGET (Refined)
/// ===============================
class _QuizModeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color cardColor;
  final bool isLocked;
  final VoidCallback? onTap;
  final int delay;

  const _QuizModeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.cardColor,
    this.isLocked = false,
    this.onTap,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500 + delay),
      curve: Curves.easeOutCirc,
      builder: (context, double value, child) {
        return Opacity(
          opacity: value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: isLocked ? null : onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            color: isLocked ? Colors.black26 : cardColor.withOpacity(0.15),
            border: Border.all(
              color: isLocked ? Colors.white12 : cardColor.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24.r),
            child: Stack(
              children: [
                /// 🧊 Content
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Row(
                    children: [
                      /// 🖼 ICON BOX
                      Container(
                        height: 60.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          color: isLocked ? Colors.white10 : cardColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Icon(
                          icon,
                          size: 30.sp,
                          color: isLocked ? Colors.white24 : Colors.white,
                        ),
                      ),

                      SizedBox(width: 16.w),

                      /// 📝 TEXT INFO
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              style: GoogleFonts.outfit(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: isLocked ? Colors.white38 : Colors.white,
                                height: 1.1,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              isLocked ? "Locked - Score 50+" : subtitle,
                              style: GoogleFonts.outfit(
                                fontSize: 13.sp,
                                color: isLocked ? Colors.white24 : Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// 🔒 LOCK/ARROW
                      Icon(
                        isLocked ? Icons.lock_outline_rounded : Icons.chevron_right_rounded,
                        color: isLocked ? Colors.white24 : Colors.white70,
                        size: 24.sp,
                      ),
                    ],
                  ),
                ),

                /// Locked overlay for visual contrast
                if (isLocked)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black12,
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
