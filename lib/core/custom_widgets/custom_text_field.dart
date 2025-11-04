import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFieldController extends GetxController {
  final RxBool isDropdownOpen = false.obs;

  void toggleDropdown() => isDropdownOpen.toggle();
  void closeDropdown() => isDropdownOpen.value = false;
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    required this.titleText,
    this.textEditingController,
    this.fontSize,
    this.fontWeight,
    this.lineHeight,
    this.bacgroundColor = const Color(0xFFE9EBF0),
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIconPath,
    this.width,
    this.fillColor,
    this.textColor,
    this.hintTextColor,
    this.borderSide,
    this.readOnly = false,
    this.onTap,
    this.maxLines = 1,
    this.minLines,
    this.height,
    this.isDropdown = false,
    this.dropdownItems,
    this.selectedDropdownValue,
    this.onDropdownChanged,
    this.controllerTag = 'default',
    this.keyboardType,
  });

  final String? hintText;
  final String titleText;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? lineHeight;
  final TextEditingController? textEditingController;
  final Color? bacgroundColor;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? prefixIconPath;
  final double? height;
  final double? width;
  final Color? fillColor;
  final Color? textColor;
  final Color? hintTextColor;
  final BorderSide? borderSide;
  final bool readOnly;
  final VoidCallback? onTap;
  final int? maxLines;
  final int? minLines;
  final bool isDropdown;
  final List<String>? dropdownItems;
  final String? selectedDropdownValue;
  final void Function(String?)? onDropdownChanged;
  final String controllerTag;
  final TextInputType? keyboardType; // ✅ FIXED TYPE

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomTextFieldController(), tag: controllerTag);

    /// ✅ Update dropdown text from outside
    if (isDropdown && selectedDropdownValue != null) {
      textEditingController?.text = selectedDropdownValue!;
    }

    final screenWidth = MediaQuery.of(context).size.width;

    return Obx(() {
      final isOpen = controller.isDropdownOpen.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Label
          Text(
            titleText,
            style: GoogleFonts.dmSans(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.h),

          /// 🔹 Text Field + Dropdown Overlay Support
          Stack(
            children: [
              SizedBox(
                width: width ?? screenWidth,
                child: TextFormField(
                  controller: textEditingController,
                  obscureText: obscureText,
                  readOnly: isDropdown ? true : readOnly,
                  onTap: () {
                    if (isDropdown) controller.toggleDropdown();
                    onTap?.call();
                  },
                  keyboardType: keyboardType,
                  validator: validator,
                  style: GoogleFonts.dmSans(
                    fontSize: fontSize ?? 16.sp,
                    fontWeight: fontWeight ?? FontWeight.w400,
                    color: textColor ?? Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: GoogleFonts.dmSans(
                      fontSize: fontSize ?? 14.sp,
                      fontWeight: FontWeight.w300,
                      color: hintTextColor ?? Colors.grey,
                    ),
                    suffixIcon: isDropdown
                        ? Icon(
                      isOpen
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    )
                        : suffixIcon,
                    prefixIcon: prefixIconPath != null
                        ? Padding(
                      padding: EdgeInsets.only(left: 8.w, right: 5.w),
                      child: Image.asset(prefixIconPath!,
                          width: 20.w, height: 20.h),
                    )
                        : null,
                    filled: true,
                    fillColor: fillColor ?? Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w, vertical: 12.h),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: borderSide ?? BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),

              /// 🔹 Dropdown list
              if (isDropdown && isOpen && dropdownItems != null)
                Positioned(
                  top: height ?? 55.h,
                  width: width ?? screenWidth,
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: 160.h, // ✅ Scroll limit
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.grey),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6,
                          offset: Offset(0, 4),
                          color: Colors.black.withOpacity(0.1),
                        )
                      ],
                    ),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: dropdownItems!
                          .map(
                            (item) => InkWell(
                          onTap: () {
                            textEditingController?.text = item;
                            onDropdownChanged?.call(item);
                            controller.closeDropdown();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12.h, horizontal: 10.w),
                            child: Text(
                              item,
                              style: GoogleFonts.dmSans(
                                fontSize: 14.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      )
                          .toList(),
                    ),
                  ),
                ),
            ],
          ),
        ],
      );
    });
  }
}
