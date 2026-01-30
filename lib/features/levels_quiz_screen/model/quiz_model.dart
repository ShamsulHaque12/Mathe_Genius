class QuizModel {
  final String question;
  final int correctAnswer;
  final List<int>? options;

  QuizModel({
    required this.question,
    required this.correctAnswer,
    this.options,
  });
}
