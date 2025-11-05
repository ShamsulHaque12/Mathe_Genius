import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/custom_widgets/leading_button_appbar.dart';

class LearnTableScreen extends StatelessWidget {
  const LearnTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(600),
        child: SafeArea(child: LeadingButtonAppbar(text: "Learn Table",)),
      ),
    );
  }
}
