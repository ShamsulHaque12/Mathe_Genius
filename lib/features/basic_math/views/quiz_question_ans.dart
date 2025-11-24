// quiz_question_ans.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:mathe_genius/core/custom_widgets/custom_button_gradient.dart';
import '../../../core/custom_widgets/leading_button_appbar.dart';
import '../controller/question_ans_controller.dart';

class QuizQuestionAns extends StatefulWidget {
  final String operation;
  const QuizQuestionAns({super.key, required this.operation});

  @override
  State<QuizQuestionAns> createState() => _QuizQuestionAnsState();
}

class _QuizQuestionAnsState extends State<QuizQuestionAns> {
  late QuestionAnsController controller;
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    // Safe controller initialization
    if (Get.isRegistered<QuestionAnsController>()) {
      Get.delete<QuestionAnsController>(force: true);
    }

    controller = Get.put(QuestionAnsController());
    controller.generateQuestions(operation: widget.operation);
  }

  @override
  void dispose() {
    if (Get.isRegistered<QuestionAnsController>()) {
      Get.delete<QuestionAnsController>();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!controller.showFeedback.value &&
            controller.currentQuestionIndex.value < controller.totalQuestions) {
          final result = await showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text("Quit Quiz?"),
              content: Text("Your current progress will be lost."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text("Quit"),
                ),
              ],
            ),
          );
          return result ?? false;
        }
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: SafeArea(
            child: LeadingButtonAppbar(text: "Quiz: ${widget.operation}"),
          ),
        ),
        body: Obx(() {
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
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.h),

                Card(
                  elevation: 4,
                  color: Colors.blue.shade50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Text(
                      question['question'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30.h),

                ...question['options'].map<Widget>((opt) {
                  bool isSelected = controller.selectedAnswer.value == opt;
                  bool isCorrectAnswer = opt == question['answer'];
                  Color color = Colors.white;

                  if (controller.showFeedback.value) {
                    if (isSelected && controller.isCorrect.value) {
                      color = Colors.green;
                    } else if (isSelected && !controller.isCorrect.value) {
                      color = Colors.red;
                    } else if (!isSelected &&
                        !controller.isCorrect.value &&
                        isCorrectAnswer) {
                      color = Colors.green.withOpacity(0.6);
                    }
                  }

                  return GestureDetector(
                    onTap: controller.showFeedback.value
                        ? null
                        : () {
                            controller.selectAnswer(opt);
                            playSound(controller.isCorrect.value);
                          },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8.h),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: Colors.blueAccent,
                          width: 1.5,
                        ),
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
                  );
                }).toList(),

                Spacer(),

                if (controller.showFeedback.value)
                  CustomButtonGradient(
                    height: 40.h,
                    text: (controller.isLastQuestion ? "Finish" : "Next"),
                    onPressed: () {
                      if (controller.isLastQuestion) {
                        _showResultPopup(context);
                      } else {
                        controller.nextQuestion();
                      }
                    },
                    backgroundColor: Colors.blueAccent,
                  ),

                // ElevatedButton(
                //   onPressed: () {
                //     if (controller.isLastQuestion) {
                //       _showResultPopup(context);
                //     } else {
                //       controller.nextQuestion();
                //     }
                //   },
                //   child: Text(controller.isLastQuestion ? "Finish" : "Next"),
                // ),
              ],
            ),
          );
        }),
      ),
    );
  }

  void playSound(bool correct) async {
    String path = correct
        ? "assets/lottie/correct.mp3"
        : "assets/lottie/wrong.mp3";
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
            borderRadius: BorderRadius.circular(20.r),
          ),
          title: Text(
            "Quiz Finished!",
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset("assets/lottie/winer.json", height: 100.h),
              SizedBox(height: 10.h),
              Text(
                "Your Score: ${controller.score.value} / ${controller.totalQuestions}",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            Center(
              child: CustomButtonGradient(
                text: "Ok",
                onPressed: () {
                  Get.back(); // close popup
                  Get.back(); // go to previous screen
                },
                backgroundColor: Colors.blueAccent,
              ),

              // child: ElevatedButton(
              //   onPressed: () {
              //     Get.back(); // close popup
              //     Get.back(); // go to previous screen
              //   },
              //   child: Text("OK"),
              // ),
            ),
          ],
        );
      },
    );
  }
}
