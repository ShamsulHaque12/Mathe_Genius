// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool showBackButton;
  final bool? centerTitle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onTap,
    this.showBackButton = true,
    this.centerTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: Row(
          mainAxisAlignment:
              centerTitle == true
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
          children: [
            if (showBackButton) ...[
              GestureDetector(
                onTap: onTap ?? () => Get.back(),
                child: CircleAvatar(
                  radius: 20.r,
                  backgroundColor: const Color(0xFFFFFFFF).withOpacity(0.18),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: Color(0xFFFFFFFF),
                    size: 20,
                  ),
                ),
              ),
            ],
            Expanded(
              child: Align(
                alignment:
                    centerTitle == true
                        ? Alignment.center
                        : Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyle(
                    color: const Color(0xFFF5838C),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
