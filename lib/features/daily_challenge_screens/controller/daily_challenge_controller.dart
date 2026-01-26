import 'dart:math';
import 'package:get/get.dart';

class DailyChallengeController extends GetxController {
  final Random _random = Random();

  var currentIndex = 0.obs; 
  var selectedAnswer = Rxn<int>(); 
  final questions = <Map<String, dynamic>>[].obs;

  // Score tracking
  var score = 0.obs;
  var correctCount = 0.obs;
  var wrongCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    generateQuestions();
  }

  void generateQuestions() {
    questions.clear();
    score.value = 0;
    correctCount.value = 0;
    wrongCount.value = 0;
    currentIndex.value = 0;
    selectedAnswer.value = null;

    for (int i = 0; i < 15; i++) {
      int a = _random.nextInt(20) + 1;
      int b = _random.nextInt(20) + 1;
      List<String> types = ['+', '-', '*'];
      String type = types[_random.nextInt(types.length)];

      int answer;
      switch (type) {
        case '+':
          answer = a + b;
          break;
        case '-':
          answer = a - b;
          break;
        default:
          answer = a * b;
      }

      questions.add({
        'a': a,
        'b': b,
        'type': type,
        'answer': answer,
      });
    }
  }

  /// Check answer & update score
  void checkAnswerAndUpdateScore(int userAnswer) {
    if (selectedAnswer.value != null) return; // already answered

    int correctAnswer = (questions[currentIndex.value]['answer'] as num).toInt();
    selectedAnswer.value = userAnswer;

    if (userAnswer == correctAnswer) {
      correctCount.value++;
      score.value += 5; // correct = +5
    } else {
      wrongCount.value++;
      score.value -= 3; // wrong = -3
    }
  }

  void nextQuestion() {
    if (currentIndex.value < questions.length - 1) {
      currentIndex.value++;
      selectedAnswer.value = null;
    }
  }

  bool get isLastQuestion => currentIndex.value == questions.length - 1;
}
