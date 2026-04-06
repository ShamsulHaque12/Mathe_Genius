import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mathe_genius/core/custom_widgets/app_images.dart';
import 'package:mathe_genius/features/progress_screens/views/progress_screens_view.dart';
import 'package:mathe_genius/features/quiz_mode/views/quiz_mode_screen.dart';
import '../../basic_math/views/basic_math_screen.dart';
import '../../learn_table/views/learn_table_screen.dart';

class HomeScreensView extends StatelessWidget {
  const HomeScreensView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        top: 25.h,
        left: 18.w,
        right: 18.w,
        bottom: 110.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🏷 GREETINGS SECTION
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, Genius!",
                style: GoogleFonts.outfit(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "Ready to master some math today?",
                style: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          SizedBox(height: 28.h),

          /// 📱 MAIN MENU CARDS
          _buildCard(
            title: "TRACK PROGRESS",
            subtitle: "Performance Center",
            description: "Check your scores and streaks",
            gradientColors: [const Color(0xFF4A90E2), const Color(0xFF50E3C2)],
            image: AppImages.chart,
            onTap: () => Get.to(() => const ProgressScreensView()),
            delay: 100,
          ),
          SizedBox(height: 20.h),

          _buildCard(
            title: "LEARN PRACTICE",
            subtitle: "Basic Operations",
            description: "Master arithmetic fundamentals",
            gradientColors: [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)],
            image: AppImages.calculator,
            onTap: () => Get.to(() => const BasicMathScreen()),
            delay: 200,
          ),
          SizedBox(height: 20.h),

          _buildCard(
            title: "TABLE MASTER",
            subtitle: "Multiplication Table",
            description: "Generate and learn tables fast",
            gradientColors: [const Color(0xFF36D1DC), const Color(0xFF5B86E5)],
            image: AppImages.calculator,
            onTap: () => Get.to(() => LearnTableScreen()),
            delay: 300,
          ),
          SizedBox(height: 20.h),

          _buildCard(
            title: "QUIZ ZONE",
            subtitle: "Daily Challenges",
            description: "Test yourself against time",
            gradientColors: [const Color(0xFFF7971E), const Color(0xFFFFD200)],
            image: AppImages.mogoj,
            onTap: () => Get.to(() => QuizModeScreen()),
            delay: 400,
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String subtitle,
    required String description,
    required List<Color> gradientColors,
    required String image,
    required VoidCallback onTap,
    required int delay,
  }) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500 + delay),
      curve: Curves.easeOutCirc,
      builder: (context, double value, child) {
        return Opacity(
          opacity: value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            gradient: LinearGradient(
              colors: [
                gradientColors[0].withOpacity(0.9),
                gradientColors[1].withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: gradientColors[1].withOpacity(0.2),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              /// 🧊 Glassmorphic Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    backgroundBlendMode: BlendMode.overlay,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(20.w),
                child: Row(
                  children: [
                    /// 📝 Text Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.outfit(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white.withOpacity(0.7),
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            subtitle,
                            style: GoogleFonts.outfit(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.1,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              description,
                              style: GoogleFonts.outfit(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 15.w),

                    /// 🖼 Image Icon
                    Container(
                      height: 85.h,
                      width: 85.w,
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1.5,
                        ),
                      ),
                      child: Image.asset(image, fit: BoxFit.contain),
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
}
