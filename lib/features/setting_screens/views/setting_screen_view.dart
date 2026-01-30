import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mathe_genius/features/setting_screens/controller/setting_controller.dart';

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
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff6D83F2), Color(0xff9A63F7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Language Title
                Text(
                  "Language Setting",
                  style: GoogleFonts.outfit(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12.h),

                /// Language Options
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
                            horizontal: 20.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.white
                                : Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(14.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 10,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Text(lang["flag"],
                                  style: TextStyle(fontSize: 20.sp)),
                              SizedBox(width: 8.w),
                              Text(
                                lang["name"],
                                style: GoogleFonts.outfit(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                SizedBox(height: 20.h),
                Divider(color: Colors.white.withOpacity(0.4)),
                SizedBox(height: 20.h),

                /// Voice Title
                Text(
                  "Voice Setting",
                  style: GoogleFonts.outfit(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12.h),

                /// Voice Options
                Obx(
                  () => Wrap(
                    spacing: 12.w,
                    runSpacing: 12.h,
                    children: voices.map((voice) {
                      bool isSelected =
                          controller.selectedVoice.value == voice["name"];
                      return GestureDetector(
                        onTap: () =>
                            controller.selectedVoice.value = voice["name"],
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.white
                                : Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(14.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 10,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                voice["icon"],
                                size: 20.sp,
                                color: Colors.black87,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                voice["name"],
                                style: GoogleFonts.outfit(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                SizedBox(height: 20.h),
                Divider(color: Colors.white.withOpacity(0.4)),
                SizedBox(height: 20.h),

                /// Privacy Policy
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.privacy_tip,
                              color: Colors.deepPurple),
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
                      _policy("1. All data is stored locally"),
                      _policy("2. No ads or tracking"),
                      _policy("3. No internet required"),
                      _policy("4. Safe for children"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _policy(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }
}
