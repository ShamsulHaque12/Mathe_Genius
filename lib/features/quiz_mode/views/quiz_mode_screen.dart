import 'package:flutter/material.dart';

import '../../../core/custom_widgets/leading_button_appbar.dart';

class QuizModeScreen extends StatelessWidget {
  const QuizModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(600),
        child: SafeArea(child: LeadingButtonAppbar(text: "Quiz Mode",)),
      ),
    );
  }
}
