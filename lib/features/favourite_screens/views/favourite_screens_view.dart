import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavouriteScreensView extends StatelessWidget {
  const FavouriteScreensView({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('tables');

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Favourite",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 15.h),

              /// 📜 SAVED TABLE LIST
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: box.listenable(),
                  builder: (context, Box tableBox, _) {
                    if (tableBox.isEmpty) {
                      return Center(
                        child: Text(
                          "No saved tables yet",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: tableBox.length,
                      itemBuilder: (context, index) {
                        List table = tableBox.getAt(index);

                        return Container(
                          margin: EdgeInsets.only(bottom: 12.h),
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade100,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              /// 🔢 INDEX NUMBER + DELETE ICON
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${index + 1}.",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  // ❌ Delete icon
                                  GestureDetector(
                                    onTap: () {
                                      tableBox.deleteAt(index);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 22.sp,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 6.h),

                              /// 📋 TABLE CONTENT
                              Column(
                                children: table.map<Widget>((line) {
                                  return Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      line,
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
