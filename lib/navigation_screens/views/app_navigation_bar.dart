import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mathe_genius/navigation_screens/controller/navigation_controller.dart';

import '../../features/favourite_screens/views/favourite_screens_view.dart';
import '../../features/home_screens/views/home_screens_view.dart';
import '../../features/progress_screens/views/progress_screens_view.dart';

class AppNavigationBar extends StatelessWidget {
  final NavigationController controller = Get.put(NavigationController());
  AppNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreensView(),
      FavouriteScreensView(),
      ProgressScreensView(),
    ];

    return SafeArea(
      top: false,
      child: Scaffold(
        body: Obx(() => screens[controller.isselectedIndex.value]),
        bottomNavigationBar: Container(
          height: 60.h,
          margin: EdgeInsets.only(bottom: 16.h, left: 12.w, right: 12.w),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 6,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              bottomNavItem(Icons.home, 'Home', 0),
              bottomNavItem(Icons.favorite_outlined, 'Favourite', 1),
              bottomNavItem(Icons.bar_chart_outlined, 'Progress', 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomNavItem(IconData icon, String title, int index) {
    return Obx(() {
      bool isSelected = controller.isselectedIndex.value == index;

      return GestureDetector(
        onTap: () => controller.isselectedIndex.value = index,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.blue,
                size: 22.sp,
              ),
              if (isSelected)
                Padding(
                  padding: EdgeInsets.only(left: 6.w),
                  child: Text(
                    title,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}
