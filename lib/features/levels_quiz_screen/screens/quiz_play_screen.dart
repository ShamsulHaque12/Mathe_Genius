import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathe_genius/core/custom_widgets/leading_button_appbar.dart';
import '../controller/levels_quiz_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizPlayScreen extends StatelessWidget {
  QuizPlayScreen({super.key});

  final controller = Get.find<LevelsQuizController>();
  final answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String level = Get.arguments;

    return Scaffold(
      body: Obx(() {
        final quiz = controller.quizzes[controller.currentIndex.value];

        return Container(
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
                /// APPBAR
                Row(
                  children: [
                    LeadingButtonAppbar(),
                    SizedBox(width: 5.w),
                    Container(
                      height: 60.h,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        level.toUpperCase(),
                        style: GoogleFonts.poppins(
                          fontSize: 24.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                /// QUESTION CARD
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xfff7971e), Color(0xfffdc830)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10.r,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Question ${controller.currentIndex.value + 1}/15",
                        style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        quiz.question,
                        style: GoogleFonts.poppins(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),

                /// QUIZ INPUT
                if (level == "easy")
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        TextField(
                          controller: answerController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                            hintText: "Enter your answer",
                            hintStyle: TextStyle(color: Colors.white70),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 20.h),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                            minimumSize: Size(double.infinity, 50.h),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r)),
                          ),
                          onPressed: () {
                            controller.submitAnswer(
                              int.tryParse(answerController.text) ?? 0,
                              level,
                            );
                            answerController.clear();
                          },
                          child: Text(
                            "Submit",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),

                if (level != "easy")
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: quiz.options!.map((opt) {
                        return Container(
                          height: 60.h,
                          width: (MediaQuery.of(context).size.width / 2) - 20,
                          margin: EdgeInsets.only(bottom: 15),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurpleAccent,
                              minimumSize: Size(double.infinity, 50.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.r)),
                            ),
                            onPressed: () => controller.submitAnswer(opt, level),
                            child: Text(
                              opt.toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 18.sp, fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                const Spacer(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
