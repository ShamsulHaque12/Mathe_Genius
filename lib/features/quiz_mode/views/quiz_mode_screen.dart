import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:mathe_genius/features/daily_challenge_screens/screems/daily_challenge_mode.dart';
import '../../../core/custom_widgets/leading_button_appbar.dart';

class QuizModeScreen extends StatelessWidget {
  const QuizModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: SafeArea(child: LeadingButtonAppbar(text: "Quiz Mode")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
          children: [
            _QuizModeCard(
              title: 'Daily\nChallenge',
              icon: Icons.calendar_today,
              color: Colors.orange,
              onTap: () {
                Get.to(() => DailyChallengeMode());
              },
            ),
            _QuizModeCard(
              title: 'Speed\nRound',
              icon: Icons.timer,
              color: Colors.redAccent,
              onTap: () {
                debugPrint("Speed Round Clicked");
              },
            ),
            _QuizModeCard(
              title: 'Levels\nQuiz',
              icon: Icons.bar_chart,
              color: Colors.blue,
              onTap: () {
                debugPrint("Levels Quiz Clicked");
              },
            ),
            _QuizModeCard(
              title: 'Table\nBattle',
              icon: Icons.flash_on,
              color: Colors.purple,
              onTap: () {
                debugPrint("Table Battle Clicked");
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _QuizModeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _QuizModeCard({
    required this.title,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20.r),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.85), color.withOpacity(0.55)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.25),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 42.sp, color: Colors.white),
              SizedBox(height: 12.h),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
