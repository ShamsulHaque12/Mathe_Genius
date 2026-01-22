import 'dart:math';
import 'package:get/get.dart';

class DailyChallengeController extends GetxController {
  final Random _random = Random();

  var currentIndex = 0.obs; // current question
  var selectedAnswer = Rxn<int>(); // user selected answer
  final questions = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _generateQuestions();
  }

  void _generateQuestions() {
    questions.clear();
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

  // Return true if correct
  bool checkAnswer(int userAnswer) {
    int correctAnswer = (questions[currentIndex.value]['answer'] as num).toInt();
    selectedAnswer.value = userAnswer;
    return userAnswer == correctAnswer;
  }

  void nextQuestion() {
    if (currentIndex.value < questions.length - 1) {
      currentIndex.value++;
      selectedAnswer.value = null;
    }
  }

  bool get isLastQuestion => currentIndex.value == questions.length - 1;
}
