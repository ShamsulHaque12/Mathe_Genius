import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathe_genius/core/custom_widgets/leading_button_appbar.dart';
import 'package:mathe_genius/features/daily_challenge_screens/controller/daily_challenge_controller.dart';

class DailyChallengeMode extends StatelessWidget {
  DailyChallengeMode({super.key});

  final DailyChallengeController controller =
      Get.put(DailyChallengeController());
  final Random _random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient background for gaming vibe
      body: Container(
        decoration: BoxDecoration(
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

            // Generate 4 options
            List<int> options = [];
            options.add(correct);
            while (options.length < 4) {
              int randomOption = correct + _random.nextInt(10) + 1;
              if (!options.contains(randomOption)) options.add(randomOption);
            }
            options.shuffle();

            return Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // AppBar
                  LeadingButtonAppbar(text: "Daily Quiz"),

                  SizedBox(height: 10.h),

                  // Progress Bar with question count
                  Stack(
                    children: [
                      Container(
                        height: 14.h,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        height: 14.h,
                        width: MediaQuery.of(context).size.width *
                            (controller.currentIndex.value + 1) /
                            controller.questions.length,
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Question ${controller.currentIndex.value + 1} / 15',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Question Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.blue[50]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '${q['a']} ${q['type']} ${q['b']} = ?',
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),

                  // Answer Buttons (2x2)
                  Wrap(
                    spacing: 16.w,
                    runSpacing: 16.h,
                    children: options.map((option) {
                      Color bgColor = Colors.blueAccent;
                      if (controller.selectedAnswer.value != null) {
                        if (option == correct) {
                          bgColor = Colors.green;
                        } else if (option == controller.selectedAnswer.value) {
                          bgColor = Colors.red;
                        } else {
                          bgColor = Colors.blueAccent;
                        }
                      }

                      return SizedBox(
                        width: (MediaQuery.of(context).size.width / 2) - 24,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: bgColor,
                            padding: EdgeInsets.symmetric(vertical: 18.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            elevation: 6,
                          ),
                          onPressed: controller.selectedAnswer.value == null
                              ? () => controller.checkAnswer(option)
                              : null,
                          child: Text(
                            '$option',
                            style: TextStyle(fontSize: 22.sp),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const Spacer(),

                  // Skip & Next Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          controller.nextQuestion();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent,
                          padding: EdgeInsets.symmetric(
                              horizontal: 28.w, vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          elevation: 5,
                        ),
                        child: const Text('Skip'),
                      ),
                      ElevatedButton(
                        onPressed: controller.selectedAnswer.value != null
                            ? () {
                                if (controller.isLastQuestion) {
                                  _showResult(context);
                                } else {
                                  controller.nextQuestion();
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                          padding: EdgeInsets.symmetric(
                              horizontal: 28.w, vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          elevation: 5,
                        ),
                        child: const Text('Next'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  void _showResult(BuildContext context) {
    Get.defaultDialog(
      title: 'Challenge Completed!',
      middleText: 'You have finished all questions 🎉',
      textConfirm: 'OK',
      onConfirm: () {
        Get.back();
        Get.back();
      },
    );
  }
}
