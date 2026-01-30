import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';
import 'package:mathe_genius/features/timer_quiz_screen/widgets/quiz_result_dialog.dart';

class TimedQuizController extends GetxController {
  final Random _random = Random();

  final int totalQuestions = 15;
  final int timePerQuestion = 5;

  var currentIndex = 0.obs;
  var timeLeft = 5.obs;

  var selectedAnswer = RxnInt();
  var isAnswered = false.obs;

  var score = 0.obs;
  var correctCount = 0.obs;
  var wrongCount = 0.obs;

  Timer? _timer;

  final questions = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    generateQuestions();
    startTimer();
  }

  /// Generate random questions
  void generateQuestions() {
    questions.clear();
    score.value = 0;
    correctCount.value = 0;
    wrongCount.value = 0;
    currentIndex.value = 0;
    selectedAnswer.value = null;
    isAnswered.value = false;

    for (int i = 0; i < totalQuestions; i++) {
      int a = _random.nextInt(20) + 1;
      int b = _random.nextInt(20) + 1;
      List<String> ops = ['+', '-', '*'];
      String op = ops[_random.nextInt(ops.length)];

      int answer;
      switch (op) {
        case '+':
          answer = a + b;
          break;
        case '-':
          answer = a - b;
          break;
        default:
          answer = a * b;
      }

      // Generate options
      List<int> options = [answer];
      while (options.length < 4) {
        int v = answer + _random.nextInt(10) - 5;
        if (!options.contains(v)) options.add(v);
      }
      options.shuffle();

      questions.add({
        'a': a,
        'b': b,
        'op': op,
        'answer': answer,
        'options': options,
      });
    }
  }

  /// Start countdown timer for current question
  void startTimer() {
    timeLeft.value = timePerQuestion;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timeLeft.value--;

      if (timeLeft.value <= 0) {
        // Time over, mark as wrong
        wrongCount.value++;
        score.value -= 3;

        timer.cancel();
        nextQuestion();
      }
    });
  }

  /// Select answer & update score
  void selectAnswer(int answer) {
    if (isAnswered.value) return;

    isAnswered.value = true;
    selectedAnswer.value = answer;
    _timer?.cancel();

    int correct = questions[currentIndex.value]['answer'];

    if (answer == correct) {
      correctCount.value++;
      score.value += 5;
    } else {
      wrongCount.value++;
      score.value -= 3;
    }

    // Wait 0.8s to show feedback
    Future.delayed(const Duration(milliseconds: 800), () {
      nextQuestion();
    });
  }

  /// Go to next question or finish quiz
  void nextQuestion() {
    selectedAnswer.value = null;
    isAnswered.value = false;

    if (currentIndex.value < totalQuestions - 1) {
      currentIndex.value++;
      startTimer();
    } else {
      finishQuiz();
    }
  }

  /// Show final result
  void finishQuiz() {
    _timer?.cancel();

    Get.dialog(
      QuizResultDialog(
        level: "Timed",
        score: score.value,
        correct: correctCount.value,
        wrong: wrongCount.value,
        onPlayAgain: () {
          Get.back();
          generateQuestions();
          startTimer();
        },
        onBack: () {
          Get.back();
          Get.back();
        },
      ),
    );
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
