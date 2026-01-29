import 'package:get/get.dart';
import 'package:hive/hive.dart';

class QuizModeController extends GetxController {
  final box = Hive.box('quiz_progress');

  var dailyScore = 0.obs;
  var speedUnlocked = false.obs;
  var levelsUnlocked = false.obs;
  var tableUnlocked = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadProgress();
  }

  void loadProgress() {
    dailyScore.value = box.get('dailyScore', defaultValue: 0);

    speedUnlocked.value = dailyScore.value >= 00;
    levelsUnlocked.value = dailyScore.value >= 00;
    tableUnlocked.value = dailyScore.value >= 00;
  }

  /// Call after Daily Challenge finished
  void saveDailyScore(int score) {
    if (score > dailyScore.value) {
      dailyScore.value = score;
      box.put('dailyScore', score);
    }
    loadProgress();
  }
}
