import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mathe_genius/core/custom_widgets/leading_button_appbar.dart';
import 'package:mathe_genius/features/daily_challenge_screens/controller/daily_challenge_controller.dart';
import 'package:mathe_genius/features/quiz_mode/controller/quiz_mode_controller.dart';
import 'package:mathe_genius/features/timer_quiz_screen/widgets/quiz_result_dialog.dart';

class DailyChallengeMode extends StatelessWidget {
  DailyChallengeMode({super.key});

  final DailyChallengeController controller = Get.put(DailyChallengeController());
  final Random _random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff6D83F2), Color(0xff9A63F7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Obx(() {
            if (controller.questions.isEmpty) return const SizedBox();
            var q = controller.questions[controller.currentIndex.value];
            int correct = (q['answer'] as num).toInt();

            // Generate options
            List<int> options = [correct];
            while (options.length < 4) {
              int randomOption = correct + _random.nextInt(10) + 1;
              if (!options.contains(randomOption)) options.add(randomOption);
            }
            options.shuffle();

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Column(
                children: [
                  /// 🏷 APPBAR & PROGRESS
                  Column(
                    children: [
                      LeadingButtonAppbar(text: "Daily Quiz"),
                      SizedBox(height: 10.h),

                      // Refined Progress Bar
                      Container(
                        height: 8.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: (controller.currentIndex.value + 1) /
                              controller.questions.length,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFFD200), Color(0xFFF7971E)],
                              ),
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.orange.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Question ${controller.currentIndex.value + 1} of ${controller.questions.length}',
                        style: GoogleFonts.outfit(
                          color: Colors.white70,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(height: 30.h),

                          /// 🧊 QUESTION CARD
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 40.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32.r),
                              color: Colors.white.withOpacity(0.1),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "What is the result of?",
                                  style: GoogleFonts.outfit(
                                    fontSize: 16.sp,
                                    color: Colors.white60,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                Text(
                                  '${q['a']} ${q['type']} ${q['b']}',
                                  style: GoogleFonts.outfit(
                                    fontSize: 48.sp,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 40.h),

                          /// 🔘 ANSWER GRID
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            mainAxisSpacing: 16.h,
                            crossAxisSpacing: 16.w,
                            childAspectRatio: 1.2,
                            children: options.map((option) {
                              bool isSelected =
                                  controller.selectedAnswer.value == option;
                              bool isCorrect = option == correct;
                              bool showResult =
                                  controller.selectedAnswer.value != null;

                              Color tileColor = Colors.white.withOpacity(0.12);
                              Color textColor = Colors.white;
                              BorderSide border = BorderSide(
                                color: Colors.white.withOpacity(0.15),
                                width: 1.5,
                              );

                              if (showResult) {
                                if (isCorrect) {
                                  tileColor = Colors.green.withOpacity(0.2);
                                  textColor = Colors.greenAccent;
                                  border = const BorderSide(
                                      color: Colors.greenAccent, width: 2);
                                } else if (isSelected) {
                                  tileColor = Colors.red.withOpacity(0.2);
                                  textColor = Colors.redAccent;
                                  border = const BorderSide(
                                      color: Colors.redAccent, width: 2);
                                }
                              }

                              return GestureDetector(
                                onTap: showResult
                                    ? null
                                    : () => controller
                                        .checkAnswerAndUpdateScore(option),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  decoration: BoxDecoration(
                                    color: tileColor,
                                    borderRadius: BorderRadius.circular(24.r),
                                    border: Border.fromBorderSide(border),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$option',
                                      style: GoogleFonts.outfit(
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w800,
                                        color: textColor,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 30.h),
                        ],
                      ),
                    ),
                  ),

                  /// 🚀 NAVIGATION BUTTONS
                  Padding(
                    padding: EdgeInsets.only(bottom: 25.h, top: 10.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildNavButton(
                            text: "Skip Question",
                            icon: Icons.skip_next_rounded,
                            color: Colors.white12,
                            onTap: () => controller.nextQuestion(),
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: _buildNavButton(
                            text: controller.isLastQuestion ? "Finish Quiz" : "Next Question",
                            icon: controller.isLastQuestion
                                ? Icons.check_circle_rounded
                                : Icons.arrow_forward_rounded,
                            color: controller.selectedAnswer.value != null
                                ? Colors.amber
                                : Colors.amber.withOpacity(0.3),
                            textColor: controller.selectedAnswer.value != null
                                ? Colors.black87
                                : Colors.white38,
                            onTap: controller.selectedAnswer.value != null
                                ? () {
                                    if (controller.isLastQuestion) {
                                      _showResult(context);
                                    } else {
                                      controller.nextQuestion();
                                    }
                                  }
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required String text,
    required IconData icon,
    required Color color,
    Color? textColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: onTap != null && color != Colors.white12
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: textColor ?? Colors.white,
              ),
            ),
            SizedBox(width: 8.w),
            Icon(icon, size: 18.sp, color: textColor ?? Colors.white),
          ],
        ),
      ),
    );
  }

  void _showResult(BuildContext context) {
    final quizModeController = Get.find<QuizModeController>();
    quizModeController.saveDailyScore(controller.score.value);

    Get.dialog(
      QuizResultDialog(
        score: controller.score.value,
        correct: controller.correctCount.value,
        wrong: controller.wrongCount.value,
        onPlayAgain: () {
          Get.back();
          controller.generateQuestions();
        },
        onBack: () {
          Get.back(); // dialog
          Get.back(); // screen
        },
      ),
      barrierDismissible: false,
    );
  }
}
