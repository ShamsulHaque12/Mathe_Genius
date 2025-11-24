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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(child: LeadingButtonAppbar(text: "Basic Math")),
      ),
      body: Column(
        children: [
          SizedBox(height: 20.h),
          Text(
            "Choose Your Operation",
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 28.sp,
              fontWeight: FontWeight.w700,
              color: Colors.blueAccent,
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
                  duration: Duration(milliseconds: 400),
                  curve: Curves.elasticOut,
                  builder: (context, double scale, child) {
                    return Transform.scale(scale: scale, child: child);
                  },
                  child: GestureDetector(
                    onTap: () {
                      // Map symbol to operation code for controller
                      String op = item['symbol'];
                      if (op == '×') op = '*';
                      if (op == '÷') op = '/';

                      // Delete old controller safely
                      if (Get.isRegistered<QuestionAnsController>()) {
                        Get.delete<QuestionAnsController>(force: true);
                      }

                      // Navigate to quiz screen
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
                            blurRadius: 10,
                            offset: const Offset(0, 5),
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
    );
  }
}
