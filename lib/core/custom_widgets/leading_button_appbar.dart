import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LeadingButtonAppbar extends StatelessWidget {
  const LeadingButtonAppbar({super.key, this.text});
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8.r),
                border: BoxBorder.all(color: Color(0xffD1D6DB), width: 1.w),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 16.sp,
              ),
            ),
          ),
          SizedBox(width: 16.h),
          Text(
            text ?? '',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xff2C3E50),
            ),
          ),
        ],
      ),
    );
  }
}
