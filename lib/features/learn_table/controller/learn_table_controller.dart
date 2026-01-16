import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hive/hive.dart';

class LearnTableController extends GetxController {
  final numberController = TextEditingController(text: "0");
  final multiplicationController = TextEditingController(text: "0");

  List<String> tableList = [];
  bool isMale = true;  // Man/Woman
  final FlutterTts tts = FlutterTts();

  int activeButton = 0; // 0: none, 1: Play, 2: Man, 3: Woman, 4: Save

  /// generate table
  void generatedTable() {
    int first = int.tryParse(numberController.text) ?? 0;
    int till = int.tryParse(multiplicationController.text) ?? 0;
    tableList.clear();
    for (int i = 1; i <= till; i++) {
      tableList.add("$first * $i = ${first * i}");
    }
    update();
  }

  /// play voice
  Future<void> playVoice() async {
    await tts.setLanguage("en-US");
    await tts.setSpeechRate(0.45);

    await tts.setVoice({
      "name": isMale ? "en-us-x-sfg#male_1" : "en-us-x-sfg#female_1",
      "locale": "en-US",
    });

    for (String line in tableList) {
      await tts.speak(line);
      await Future.delayed(const Duration(milliseconds: 800));
    }
  }

  /// save table
  void saveTable() {
    final box = Hive.box('tables');
    box.add(tableList);
    update();
  }

  void setActiveButton(int index) {
    activeButton = index;
    update();
  }

  @override
  void onClose() {
    numberController.dispose();
    multiplicationController.dispose();
    super.onClose();
  }
}
