import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mathe_genius/features/setting_screens/controller/setting_controller.dart';

class SettingScreenView extends StatelessWidget {
  final SettingController controller = Get.put(SettingController());
  SettingScreenView({super.key});

  final List<Map<String, dynamic>> languages = [
    {"name": "English", "flag": "🇺🇸"},
  ];

  final List<Map<String, dynamic>> voices = [
    {"name": "Men", "icon": Icons.person_rounded},
    {"name": "Women", "icon": Icons.person_3_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          top: 15.h,
          left: 16.w,
          right: 16.w,
          bottom: 110.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🏷 PAGE HEADER
            Text(
              "App Settings",
              style: GoogleFonts.outfit(
                fontSize: 26.sp,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              "Customize your experience and learning preferences.",
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 25.h),

            /// 🌐 LANGUAGE SECTION
            _buildSectionHeader("Language Preference"),
            SizedBox(height: 12.h),
            Obx(
              () => Container(
                padding: EdgeInsets.all(12.w),
                decoration: _glassDecoration(),
                child: Row(
                  children: languages.map((lang) {
                    bool isSelected =
                        controller.selectedLanguage.value == lang["name"];
                    return Expanded(
                      child: _buildChoiceChip(
                        title: lang["name"],
                        prefix: Text(lang["flag"], style: TextStyle(fontSize: 18.sp)),
                        isSelected: isSelected,
                        onTap: () => controller.selectedLanguage.value = lang["name"],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            SizedBox(height: 25.h),

            /// 🔊 VOICE SECTION
            _buildSectionHeader("Voice Character"),
            SizedBox(height: 12.h),
            Obx(
              () => Container(
                padding: EdgeInsets.all(12.w),
                decoration: _glassDecoration(),
                child: Row(
                  children: voices.map((voice) {
                    bool isSelected =
                        controller.selectedVoice.value == voice["name"];
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: voice == voices.last ? 0 : 10.w),
                        child: _buildChoiceChip(
                          title: voice["name"],
                          prefix: Icon(
                            voice["icon"],
                            size: 18.sp,
                            color: isSelected ? Colors.deepPurple : Colors.white70,
                          ),
                          isSelected: isSelected,
                          onTap: () => controller.selectedVoice.value = voice["name"],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            SizedBox(height: 30.h),

            /// 🛡 PRIVACY SECTION
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: _glassDecoration(color: Colors.white.withOpacity(0.08)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.security_rounded, color: Colors.amber, size: 20.sp),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        "Privacy & Safety",
                        style: GoogleFonts.outfit(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  _policyItem("1. Local Storage", "All learning data stays on your device."),
                  _policyItem("2. Ads-Free", "Zero advertisements or third-party tracking."),
                  _policyItem("3. Offline Mode", "No internet connection required to learn."),
                  _policyItem("4. Child Safe", "Verified content safe for all ages."),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 0.5,
      ),
    );
  }

  BoxDecoration _glassDecoration({Color? color}) {
    return BoxDecoration(
      color: color ?? Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20.r),
      border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.5),
    );
  }

  Widget _buildChoiceChip({
    required String title,
    required Widget prefix,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: isSelected
              ? [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefix,
            SizedBox(width: 8.w),
            Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 15.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? Colors.black87 : Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _policyItem(String title, String desc) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_outline_rounded, color: Colors.white38, size: 16.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  desc,
                  style: GoogleFonts.outfit(fontSize: 12.sp, color: Colors.white54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
