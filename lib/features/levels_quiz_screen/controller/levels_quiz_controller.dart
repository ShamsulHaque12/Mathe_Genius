import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mathe_genius/features/timer_quiz_screen/widgets/quiz_result_dialog.dart';
import '../model/quiz_model.dart';
import '../screens/quiz_play_screen.dart';

class LevelsQuizController extends GetxController {
  final score = 0.obs;
  final currentIndex = 0.obs;

  RxBool normalUnlocked = false.obs;
  RxBool hardUnlocked = false.obs;

  late Box box;
  List<QuizModel> quizzes = [];

  // Track correct & wrong answers
  int correctCount = 0;
  int wrongCount = 0;

  @override
  void onInit() async {
    super.onInit();
    box = await Hive.openBox('levelBox');

    normalUnlocked.value = box.get('normal', defaultValue: false);
    hardUnlocked.value = box.get('hard', defaultValue: false);
  }

  // ---------------- QUIZ GENERATOR ----------------
  List<QuizModel> generateQuiz(String level) {
    final random = Random();
    List<QuizModel> list = [];

    for (int i = 0; i < 15; i++) {
      int a = random.nextInt(20) + 1;
      int b = random.nextInt(20) + 1;
      int c = random.nextInt(10) + 1;

      String q;
      int ans;
      List<int>? options;

      if (level == "easy") {
        if (random.nextBool()) {
          q = "$a + $b - $c";
          ans = a + b - c;
        } else {
          q = "$a - $c + $b";
          ans = a - c + b;
        }
      } else if (level == "normal") {
        int type = random.nextInt(3);
        if (type == 0) {
          q = "$a * 2 - $c";
          ans = a * 2 - c;
        } else if (type == 1) {
          q = "$a - $c + $a";
          ans = a - c + a;
        } else {
          q = "$c + $a * $a";
          ans = c + a * a;
        }
        options = _generateOptions(ans);
      } else {
        int type = random.nextInt(4);
        if (type == 0) {
          q = "$a + $b - $c * 2";
          ans = a + b - c * 2;
        } else if (type == 1) {
          q = "$a * 2 - $c + $b";
          ans = a * 2 - c + b;
        } else if (type == 2) {
          q = "$b + $a * $c - 2";
          ans = b + a * c - 2;
        } else {
          q = "$c * $a + $b - 2";
          ans = c * a + b - 2;
        }
        options = _generateOptions(ans);
      }

      list.add(
        QuizModel(
          question: q,
          correctAnswer: ans,
          options: options,
        ),
      );
    }
    return list;
  }

  List<int> _generateOptions(int correct) {
    final random = Random();
    Set<int> opts = {correct};

    while (opts.length < 4) {
      opts.add(correct + random.nextInt(10) - 5);
    }
    return opts.toList()..shuffle();
  }

  // ---------------- START QUIZ ----------------
  void startQuiz(String level) {
    score.value = 0;
    currentIndex.value = 0;
    correctCount = 0;
    wrongCount = 0;
    quizzes = generateQuiz(level);

    Get.to(() => QuizPlayScreen(), arguments: level);
  }

  // ---------------- SUBMIT ANSWER ----------------
  void submitAnswer(int userAnswer, String level) {
    final correctAnswer = quizzes[currentIndex.value].correctAnswer;

    if (userAnswer == correctAnswer) {
      score.value += 5; // +5 per correct
      correctCount++;
    } else {
      score.value -= 3; // -3 per wrong
      wrongCount++;
    }

    if (currentIndex.value == 14) {
      unlockLevel(level);

      // Show result popup
      Get.dialog(
        QuizResultDialog(
          level: level,
          score: score.value,
          correct: correctCount,
          wrong: wrongCount,
          onBack: () {
            Get.back(); 
            Get.back(); // Go back to level screen
          }, 
          onPlayAgain: () {
            Get.back();
            startQuiz(level); // Restart same level
          },
        ),
        barrierDismissible: false,
      );
    } else {
      currentIndex.value++;
    }
  }

  // ---------------- UNLOCK LOGIC ----------------
  void unlockLevel(String level) {
    if (level == "easy" && score.value >= 55) {
      box.put('normal', true);
      normalUnlocked.value = true;
    }

    if (level == "normal" && score.value >= 65) {
      box.put('hard', true);
      hardUnlocked.value = true;
    }
  }

  // ---------------- LOCK POPUP ----------------
  void showLockedDialog(String msg) {
  Get.dialog(
    Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Color(0xff1D2671), Color(0xffC33764)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.lock, color: Colors.amber, size: 60),
              const SizedBox(height: 12),
              Text(
                "Locked 🔒",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                msg,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "OK",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: false, // prevent tapping outside
  );
}

}
