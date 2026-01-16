import 'dart:math';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class QuestionAnsController extends GetxController {
  var currentQuestionIndex = 0.obs;
  var score = 0.obs;
  var questions = <Map<String, dynamic>>[].obs;
  var selectedAnswer = ''.obs;
  var showFeedback = false.obs;
  var isCorrect = false.obs;

  final int totalQuestions = 15;
  final int pointPerCorrect = 2;

  /// Save quiz result for this operation
  void saveResult(String operation) {
    final box = Hive.box('quiz_scores');

    int totalCorrect = score.value;
    int totalPoint = totalCorrect * pointPerCorrect;
    double percentage = (totalCorrect / totalQuestions) * 100;

    // Save as map: key = operation
    box.put(operation, {
      'correct': totalCorrect,
      'total': totalQuestions,
      'point': totalPoint,
      'percentage': percentage,
    });
  }

  /// Optional: get saved result
  Map<String, dynamic>? getSavedResult(String operation) {
    final box = Hive.box('quiz_scores');
    return box.get(operation);
  }

  void saveResultWeekly(String operation) {
  final box = Hive.box('quiz_scores');
  final today = DateTime.now().weekday; // 1-7

  int totalCorrect = score.value;
  int totalPoint = totalCorrect * pointPerCorrect;
  double percentage = (totalCorrect / totalQuestions) * 100;

  // Load previous data for operation
  final opData = box.get(operation) ?? {};

  // Save today's result
  opData['day$today'] = {
    'correct': totalCorrect,
    'total': totalQuestions,
    'point': totalPoint,
    'percentage': percentage,
  };

  box.put(operation, opData);
}


  void generateQuestions({required String operation}) {
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
        case '×':
          ans = a * b;
          break;
        case '/':
        case '÷':
          b = b == 0 ? 1 : b; // prevent division by zero
          a = (a ~/ b) * b; // make divisible
          ans = a ~/ b;
          break;
        default:
          throw Exception('Unsupported operation: $operation');
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
      // +/- 5 variation
      int fake = correctAns + random.nextInt(11) - 5;
      if (fake != correctAns) opts.add(fake.toString());
    }

    final list = opts.toList();
    list.shuffle();
    return list;
  }

  void selectAnswer(String answer) {
    selectedAnswer.value = answer;
    isCorrect.value = answer == questions[currentQuestionIndex.value]['answer'];
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

  bool get isLastQuestion => currentQuestionIndex.value == totalQuestions - 1;
}
