import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/custom_widgets/leading_button_appbar.dart';

class BasicMathScreen extends StatelessWidget {
  const BasicMathScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(600),
        child: SafeArea(child: LeadingButtonAppbar(text: "Basic Mathe")),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Generate for Basic Mathe",
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                  wordSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
