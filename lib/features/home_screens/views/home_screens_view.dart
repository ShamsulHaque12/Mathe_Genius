import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreensView extends StatelessWidget {
  const HomeScreensView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Home")
          ],
        ),
      ),
    );
  }
}
