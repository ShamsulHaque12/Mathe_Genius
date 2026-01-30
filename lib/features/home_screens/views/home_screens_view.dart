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
            padding: EdgeInsets.all(18.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Greetings
                Center(
                  child: Text(
                    "Hello!",
                    style: GoogleFonts.outfit(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                Center(
                  child: Text(
                    "Ready to Learn?",
                    style: GoogleFonts.outfit(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                Center(
                  child: Text(
                    "Choose what you'd like to do today.",
                    style: GoogleFonts.outfit(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.85),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 24.h),

                /// Cards Section
                _buildCard(
                  title: "Today’s Progress &",
                  subtitle: "Progress Check",
                  description: "Keep up the great work!",
                  gradientColors: [Color(0xFF4A90E2), Color(0xFF50E3C2)],
                  image: AppImages.chart,
                  onTap: () => Get.to(() => ProgressScreensView()),
                ),
                SizedBox(height: 16.h),

                _buildCard(
                  title: "Math Practice",
                  subtitle: "Learn +-×÷",
                  description: "Practice basic math operations",
                  gradientColors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
                  image: AppImages.calculator,
                  onTap: () => Get.to(() => BasicMathScreen()),
                ),
                SizedBox(height: 16.h),

                _buildCard(
                  title: "Learn Tables",
                  subtitle: "Multiplication",
                  description: "Generate multiplication tables",
                  gradientColors: [Color(0xFF36D1DC), Color(0xFF5B86E5)],
                  image: AppImages.calculator,
                  onTap: () => Get.to(() => LearnTableScreen()),
                ),
                SizedBox(height: 16.h),

                _buildCard(
                  title: "Quiz Mode",
                  subtitle: "Challenge Mode",
                  description: "Test your knowledge",
                  gradientColors: [Color(0xFFF7971E), Color(0xFFFFD200)],
                  image: AppImages.mogoj,
                  onTap: () => Get.to(() => QuizModeScreen()),
                ),
              ],
            ),
          ),
        ),
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
  }) {
    return GestureDetector(
      onTap: onTap,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.97, end: 1.0),
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutBack,
        builder: (context, double scale, child) =>
            Transform.scale(scale: scale, child: child),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 12,
                offset: const Offset(0, 6),
              )
            ],
          ),
          child: Row(
            children: [
              /// Text Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.outfit(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.85),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      subtitle.toUpperCase(),
                      style: GoogleFonts.outfit(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      description,
                      style: GoogleFonts.outfit(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),

              /// Image Icon
              Container(
                height: 75.h,
                width: 75.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: Colors.white24,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(image, fit: BoxFit.contain),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
