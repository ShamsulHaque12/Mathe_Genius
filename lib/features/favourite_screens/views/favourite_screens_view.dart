import 'package:flutter/material.dart';

class FavouriteScreensView extends StatelessWidget {
  const FavouriteScreensView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("favourite")
          ],
        ),
      ),

    );
  }
}
