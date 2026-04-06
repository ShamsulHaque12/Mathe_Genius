// basic_math_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mathe_genius/features/basic_math/views/quiz_question_ans.dart';

import '../../../core/custom_widgets/leading_button_appbar.dart';
import '../controller/question_ans_controller.dart';

class BasicMathScreen extends StatelessWidget {
  const BasicMathScreen({super.key});

  final List<Map<String, dynamic>> mathItems = const [
    {
      "symbol": "+",
      "label": "Addition",
      "colors": [Color(0xFF42E695), Color(0xFF3BB2B8)],
    },
    {
      "symbol": "-",
      "label": "Subtraction",
      "colors": [Color(0xFFF02FC2), Color(0xFF6094EA)],
    },
    {
      "symbol": "×",
      "label": "Multiplication",
      "colors": [Color(0xFF65799B), Color(0xFF5E2563)],
    },
    {
      "symbol": "÷",
      "label": "Division",
      "colors": [Color(0xFFF7971E), Color(0xFFFFD200)],
    },
  ];

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // APPBAR
              LeadingButtonAppbar(text: "Practice Math"),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Operation",
                      style: GoogleFonts.outfit(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Pick a math operator to start your journey.",
                      style: GoogleFonts.outfit(
                        fontSize: 15.sp,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  itemCount: mathItems.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20.h,
                    crossAxisSpacing: 20.w,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    final item = mathItems[index];

                    return _buildMathTile(item, index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMathTile(Map<String, dynamic> item, int index) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500 + (index * 100)),
      curve: Curves.easeOutBack,
      builder: (context, double value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Opacity(
            opacity: value.clamp(0.0, 1.0),
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          String op = item['symbol'];

          if (Get.isRegistered<QuestionAnsController>()) {
            Get.delete<QuestionAnsController>(force: true);
          }

          Get.to(() => QuizQuestionAns(operation: op));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.r),
            gradient: LinearGradient(
              colors: List<Color>.from(item['colors']),
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: (item['colors'] as List<Color>).last.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              /// Glass overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32.r),
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),

              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item['symbol'],
                      style: GoogleFonts.outfit(
                        fontSize: 60.sp,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      item['label'],
                      style: GoogleFonts.outfit(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.9),
                      ),
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
