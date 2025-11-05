import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../core/custom_widgets/leading_button_appbar.dart';
import '../controller/question_ans_controller.dart';

class QuizQuestionAns extends StatelessWidget {
  final QuestionAnsController controller = Get.put(QuestionAnsController());
  final String operation;

  QuizQuestionAns({super.key, required this.operation});

  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    controller.generateQuestions(operation: operation);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(child: LeadingButtonAppbar(text: "Quiz: $operation")),
      ),
      body: Obx(
            () {
          if (controller.currentQuestionIndex.value >=
              controller.totalQuestions) {
            Future.delayed(Duration.zero, () => _showResultPopup(context));
            return SizedBox.shrink();
          }

          final question =
          controller.questions[controller.currentQuestionIndex.value];

          return Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20.h),
                Text(
                  "Question ${controller.currentQuestionIndex.value + 1} / ${controller.totalQuestions}",
                  style:
                  TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.h),

                /// Question Card Slide-In Animation
                TweenAnimationBuilder(
                  tween: Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0)),
                  duration: Duration(milliseconds: 400),
                  builder: (context, Offset offset, child) {
                    return Transform.translate(
                        offset: Offset(offset.dx * 300, 0), child: child);
                  },
                  child: Card(
                    elevation: 4,
                    color: Colors.blue.shade50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r)),
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Text(
                        question['question'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 28.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30.h),

                /// Options
                ...question['options'].map<Widget>((opt) {
                  bool isSelected = controller.selectedAnswer.value == opt;
                  bool isCorrectAnswer = opt == question['answer'];
                  Color color = Colors.white;

                  if (controller.showFeedback.value) {
                    if (isSelected && controller.isCorrect.value) {
                      color = Colors.green;
                    } else if (isSelected && !controller.isCorrect.value) {
                      color = Colors.red;
                    } else if (!isSelected && !controller.isCorrect.value && isCorrectAnswer) {
                      color = Colors.green.withOpacity(0.6);
                    }
                  }

                  return GestureDetector(
                    onTap: controller.showFeedback.value
                        ? null
                        : () => controller.selectAnswer(opt),
                    child: TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0.95, end: 1.0),
                      duration: Duration(milliseconds: 200),
                      builder: (context, double scale, child) {
                        return Transform.scale(
                            scale: scale, child: child);
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(vertical: 8.h),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                              color: Colors.blueAccent, width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            opt,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: color.computeLuminance() > 0.5
                                  ? Colors.black87
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),

                Spacer(),

                if (controller.showFeedback.value)
                  ElevatedButton(
                    onPressed: () {
                      if (controller.isLastQuestion) {
                        _showResultPopup(context);
                      } else {
                        controller.nextQuestion();
                      }
                    },
                    child: Text(controller.isLastQuestion ? "Finish" : "Next"),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void playSound(bool correct) async {
    String path =
    correct ? "assets/lottie/correct.mp3" : "assets/lottie/wrong.mp3";
    await audioPlayer.play(AssetSource(path));
  }

  void _showResultPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.yellow.shade50,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r)),
          title: Text(
            "Quiz Finished!",
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset("assets/lottie/confetti.json", height: 100.h),
              SizedBox(height: 10.h),
              Text(
                "Your Score: ${controller.score.value} / ${controller.totalQuestions}",
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.back(); // close popup
                  Get.back(); // go to previous screen
                },
                child: Text("OK"),
              ),
            )
          ],
        );
      },
    );
  }
}
