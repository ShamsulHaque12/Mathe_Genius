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
            children: [
              // APPBAR
              LeadingButtonAppbar(text: "Basic Math"),

              SizedBox(height: 20.h),
              Text(
                "Choose Your Operation",
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 30.h),

              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: mathItems.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 18.h,
                    crossAxisSpacing: 18.w,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final item = mathItems[index];

                    return TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0.85, end: 1),
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.elasticOut,
                      builder: (context, double scale, child) {
                        return Transform.scale(scale: scale, child: child);
                      },
                      child: GestureDetector(
                        onTap: () {
                          String op = item['symbol'];
                          if (op == '×') op = '*';
                          if (op == '÷') op = '/';

                          if (Get.isRegistered<QuestionAnsController>()) {
                            Get.delete<QuestionAnsController>(force: true);
                          }

                          Get.to(() => QuizQuestionAns(operation: op));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            gradient: LinearGradient(
                              colors: List<Color>.from(item['colors']),
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                                color: Colors.black26,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              item['symbol'],
                              style: GoogleFonts.outfit(
                                fontSize: 55.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
