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

  // =========================================================
  // ✅ SAVE ONLY LAST 7 QUIZ ATTEMPTS (ROLLING SYSTEM)
  // =========================================================
  void saveResultRecent7(String operation) {
  final box = Hive.box('quiz_scores');

  int totalCorrect = score.value;
  int totalPoint = totalCorrect * pointPerCorrect;
  double percentage = (totalCorrect / totalQuestions) * 100;

  /// 🟢 Load old data safely
  final rawOpData = box.get(operation);
  Map<String, dynamic> opData = rawOpData != null
      ? Map<String, dynamic>.from(rawOpData)
      : {};

  /// 🟢 Load attempts safely & convert types
  List<Map<String, dynamic>> attempts = [];

  if (opData['attempts'] != null) {
    attempts = (opData['attempts'] as List)
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  /// ❌ Remove oldest if already 7
  if (attempts.length >= 7) {
    attempts.removeAt(0);
  }

  /// ✅ Add new attempt
  attempts.add({
    'correct': totalCorrect,
    'total': totalQuestions,
    'point': totalPoint,
    'percentage': percentage,
    'time': DateTime.now().toIso8601String(),
  });

  /// 🟢 Save back
  opData['attempts'] = attempts;
  box.put(operation, opData);
}

  // =========================================================
  // 🧠 QUIZ LOGIC (UNCHANGED)
  // =========================================================
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
          b = b == 0 ? 1 : b;
          a = (a ~/ b) * b;
          ans = a ~/ b;
          break;
        default:
          throw Exception('Unsupported operation');
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
      int fake = correctAns + random.nextInt(11) - 5;
      if (fake != correctAns) opts.add(fake.toString());
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
