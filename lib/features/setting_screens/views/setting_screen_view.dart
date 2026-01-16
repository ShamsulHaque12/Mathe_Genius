import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/setting_controller.dart';

class SettingScreenView extends StatelessWidget {
  final SettingController controller = Get.put(SettingController());
  SettingScreenView({super.key});

  final List<Map<String, dynamic>> languages = [
    {"name": "English", "flag": "🇺🇸"},
  ];

  final List<Map<String, dynamic>> voices = [
    {"name": "Men", "icon": Icons.person},
    {"name": "Women", "icon": Icons.person_4},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Language Title
              Text(
                "Language Setting",
                style: GoogleFonts.outfit(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),

              /// Language Options with Emoji
              Obx(
                () => Row(
                  children: languages.map((lang) {
                    bool isSelected =
                        controller.selectedLanguage.value == lang["name"];
                    return GestureDetector(
                      onTap: () =>
                          controller.selectedLanguage.value = lang["name"],
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.only(right: 10.w),
                        padding: EdgeInsets.symmetric(
                          horizontal: 18.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blueAccent : Colors.white,
                          borderRadius: BorderRadius.circular(14.r),
                          boxShadow: [
                            BoxShadow(
                              color: isSelected
                                  ? Colors.blueAccent.withOpacity(0.45)
                                  : Colors.black.withOpacity(0.05),
                              blurRadius: isSelected ? 8 : 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                          border: Border.all(
                            color: isSelected
                                ? Colors.blue
                                : Colors.grey.shade300,
                            width: 1.2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              lang["flag"],
                              style: TextStyle(fontSize: 20.sp),
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              lang["name"],
                              style: GoogleFonts.outfit(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 10.h),

              Divider(color: Colors.grey.shade300, thickness: 1),

              SizedBox(height: 10.h),

              /// Voice Title
              Text(
                "Voice Setting",
                style: GoogleFonts.outfit(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),

              /// Voice Options with Icons
              Obx(
                () => Wrap(
                  spacing: 10.w,
                  runSpacing: 10.h,
                  children: voices.map((voice) {
                    bool isSelected =
                        controller.selectedVoice.value == voice["name"];
                    return GestureDetector(
                      onTap: () =>
                          controller.selectedVoice.value = voice["name"],
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: EdgeInsets.symmetric(
                          horizontal: 18.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.purpleAccent
                              : Colors.white,
                          borderRadius: BorderRadius.circular(14.r),
                          boxShadow: [
                            BoxShadow(
                              color: isSelected
                                  ? Colors.purpleAccent.withOpacity(0.4)
                                  : Colors.black.withOpacity(0.05),
                              blurRadius: isSelected ? 8 : 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                          border: Border.all(
                            color: isSelected
                                ? Colors.purple
                                : Colors.grey.shade300,
                            width: 1.2,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              voice["icon"],
                              color: isSelected ? Colors.white : Colors.black87,
                              size: 20.sp,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              voice["name"],
                              style: GoogleFonts.outfit(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: 10.h),

              Divider(color: Colors.grey.shade300, thickness: 1),

              SizedBox(height: 10.h),

              /// Theme mode
              Text(
                "Theme Mode",
                style: GoogleFonts.outfit(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              

              SizedBox(height: 10.h),

              Divider(color: Colors.grey.shade300, thickness: 1),

              SizedBox(height: 10.h),

              /// Privacy Policy section stays same
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.privacy_tip, color: Colors.blueAccent),
                        SizedBox(width: 10.w),
                        Text(
                          "Privacy Policy",
                          style: GoogleFonts.outfit(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    _policy(
                      "1. All data is stored locally on this device only",
                    ),
                    _policy("2. No ads or tracking"),
                    _policy("3. No internet connection required"),
                    _policy("4. Safe for children"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _policy(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Text(
        text,
        style: TextStyle(fontSize: 14.sp, color: Colors.grey),
      ),
    );
  }
}
