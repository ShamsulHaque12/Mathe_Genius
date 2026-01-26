import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathe_genius/core/custom_widgets/leading_button_appbar.dart';
import 'package:mathe_genius/features/timer_quiz_screen/controller/timed_quiz_controller.dart';

class TimedQuizScreen extends StatelessWidget {
  TimedQuizScreen({super.key});

  final TimedQuizController controller =
      Get.put(TimedQuizController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            var q = controller.questions[controller.currentIndex.value];
            List<int> options = List<int>.from(q['options']);
            int correct = q['answer'];

            return Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                children: [
                  LeadingButtonAppbar(text: "Timed Quiz"),

                  Text(
                    "Question ${controller.currentIndex.value + 1}/15",
                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  ),

                  SizedBox(height: 10.h),

                  LinearProgressIndicator(
                    value: controller.timeLeft.value / 5,
                    backgroundColor: Colors.white24,
                    color: Colors.orangeAccent,
                    minHeight: 10.h,
                  ),

                  SizedBox(height: 6.h),
                  Text(
                    "⏱ ${controller.timeLeft.value}s",
                    style: TextStyle(color: Colors.white),
                  ),

                  SizedBox(height: 28.h),

                  Container(
                    padding: EdgeInsets.all(24.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22.r),
                    ),
                    child: Text(
                      "${q['a']} ${q['op']} ${q['b']} = ?",
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 28.h),

                  Wrap(
                    spacing: 16.w,
                    runSpacing: 16.h,
                    children: options.map((opt) {
                      Color bg = Colors.blueAccent;

                      if (controller.isAnswered.value) {
                        if (opt == correct) {
                          bg = Colors.green;
                        } else if (opt == controller.selectedAnswer.value) {
                          bg = Colors.red;
                        }
                      }

                      return SizedBox(
                        width:
                            (MediaQuery.of(context).size.width / 2) - 24,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: bg,
                            padding: EdgeInsets.symmetric(vertical: 18.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                          ),
                          onPressed: () =>
                              controller.selectAnswer(opt),
                          child: Text(
                            "$opt",
                            style: TextStyle(fontSize: 22.sp),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
