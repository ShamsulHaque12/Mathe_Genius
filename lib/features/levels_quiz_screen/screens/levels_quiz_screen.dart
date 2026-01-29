import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathe_genius/core/custom_widgets/leading_button_appbar.dart';
import 'package:mathe_genius/features/levels_quiz_screen/controller/levels_quiz_controller.dart';

class LevelsQuizScreen extends StatelessWidget {
  LevelsQuizScreen({super.key});

  final LevelsQuizController controller = Get.put(LevelsQuizController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              LeadingButtonAppbar(text: "Levels Quiz"),

              SizedBox(height: 24.h),

              /// ---------------- EASY (Always Open) ----------------
              _levelCard(
                title: "Easy",
                subtitle: "Simple Math",
                icon: Icons.sentiment_satisfied_alt,
                gradient: const [Color(0xff43cea2), Color(0xff185a9d)],
                onTap: () => controller.startQuiz("easy"),
              ),

              SizedBox(height: 16.h),

              /// ---------------- NORMAL ----------------
              Obx(
                () => _levelCard(
                  title: "Normal",
                  subtitle: controller.normalUnlocked.value
                      ? "Mixed Operations"
                      : "Locked 🔒 (Score 55)",
                  icon: Icons.flash_on,
                  gradient: controller.normalUnlocked.value
                      ? const [Color(0xfff7971e), Color(0xfffdc830)]
                      : [Colors.grey.shade600, Colors.grey.shade800],
                  onTap: controller.normalUnlocked.value
                      ? () => controller.startQuiz("normal")
                      : () => controller.showLockedDialog(
                          "Easy level এ 55 point করলে Normal unlock হবে",
                        ),
                ),
              ),

              SizedBox(height: 16.h),

              /// HARD
              Obx(
                () => _levelCard(
                  title: "Hard",
                  subtitle: controller.hardUnlocked.value
                      ? "Brain Challenge"
                      : "Locked 🔒 (Score 65)",
                  icon: Icons.whatshot,
                  gradient: controller.hardUnlocked.value
                      ? const [Color(0xffcb2d3e), Color(0xffef473a)]
                      : [Colors.grey.shade600, Colors.grey.shade800],
                  onTap: controller.hardUnlocked.value
                      ? () => controller.startQuiz("hard")
                      : () => controller.showLockedDialog(
                          "Normal level এ 65 point করলে Hard unlock হবে",
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------- LEVEL CARD WIDGET ----------
  Widget _levelCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        height: 100.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22.r),
          boxShadow: [
            BoxShadow(
              color: gradient.last.withOpacity(0.4),
              blurRadius: 10.r,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              /// ICON
              Container(
                height: 56.h,
                width: 56.w,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 30.sp),
              ),

              SizedBox(width: 18.w),

              /// TEXT
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              /// ARROW
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
