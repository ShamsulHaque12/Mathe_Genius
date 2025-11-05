import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/custom_widgets/leading_button_appbar.dart';

class ProgressScreensView extends StatelessWidget {
  const ProgressScreensView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(600),
        child: SafeArea(child: LeadingButtonAppbar(text: "Progress",)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("progress")
          ],
        ),
      ),
    );
  }
}
