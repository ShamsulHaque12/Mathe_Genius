import 'dart:math';
import 'package:get/get.dart';

class QuestionAnsController extends GetxController {
  var currentQuestionIndex = 0.obs;
  var score = 0.obs;
  var questions = <Map<String, dynamic>>[].obs;
  var selectedAnswer = ''.obs;
  var showFeedback = false.obs;
  var isCorrect = false.obs;

  final int totalQuestions = 15;

  @override
  void onInit() {
    super.onInit();
  }

  void generateQuestions({String operation = '+'}) {
    final random = Random();
    questions.clear();
    for (int i = 0; i < totalQuestions; i++) {
      int a = random.nextInt(20) + 1;
      int b = random.nextInt(20) + 1;

      late int ans;
      switch (operation) {
        case '+':
          ans = a + b;
          break;
        case '-':
          ans = a - b;
          break;
        case '*':
          ans = a * b;
          break;
        case '/':
          a = (a ~/ b) * b; // divisible
          ans = a ~/ b;
          break;
      }

      questions.add({
        'question': '$a $operation $b',
        'answer': ans.toString(),
        'options': generateOptions(ans),
      });
    }
    currentQuestionIndex.value = 0;
    score.value = 0;
    selectedAnswer.value = '';
    showFeedback.value = false;
  }

  List<String> generateOptions(int correctAns) {
    final random = Random();
    Set<String> opts = {correctAns.toString()};
    while (opts.length < 4) {
      int fake = correctAns + random.nextInt(10) - 5;
      if (fake != correctAns && fake > 0) opts.add(fake.toString());
    }
    final list = opts.toList();
    list.shuffle();
    return list;
  }

  void selectAnswer(String answer) {
    selectedAnswer.value = answer;
    isCorrect.value =
        answer == questions[currentQuestionIndex.value]['answer'];
    if (isCorrect.value) score.value++;
    showFeedback.value = true;
  }

  void nextQuestion() {
    showFeedback.value = false;
    selectedAnswer.value = '';
    if (currentQuestionIndex.value < totalQuestions - 1) {
      currentQuestionIndex.value++;
    }
  }

  bool get isLastQuestion =>
      currentQuestionIndex.value == totalQuestions - 1;
}
