import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// GetX Controller for CustomTextField
class CustomTextFieldController extends GetxController {
  final RxBool isDropdownOpen = false.obs;

  void toggleDropdown() {
    isDropdownOpen.value = !isDropdownOpen.value;
  }

  void closeDropdown() {
    isDropdownOpen.value = false;
  }
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
    this.maxLines,
    this.minLines,
    this.height,
    this.isDropdown = false,
    this.dropdownItems,
    this.selectedDropdownValue,
    this.onDropdownChanged,
    this.controllerTag = 'default',
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

  @override
  Widget build(BuildContext context) {
    final CustomTextFieldController controller = Get.put(
      CustomTextFieldController(),
      tag: controllerTag,
    );

    if (isDropdown && selectedDropdownValue != null) {
      textEditingController?.text = selectedDropdownValue!;
    }

    final screenWidth = MediaQuery.of(context).size.width;

    return Obx(() {
      final isOpen = controller.isDropdownOpen.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleText,
            style: context.textTheme.labelSmall!.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          SingleChildScrollView(
            // Wrap the content in SingleChildScrollView
            child: SizedBox(
              height: isDropdown && isOpen
                  ? (height ?? 40.h) +
                        (dropdownItems?.length ?? 0) * 25.h +
                        10.h
                  : height ?? 48.h,
              width: width ?? screenWidth * 0.9,
              child: isDropdown
                  ? Stack(
                      clipBehavior: Clip.none,
                      children: [
                        TextFormField(
                          controller: textEditingController,
                          obscureText: obscureText,
                          maxLines: maxLines ?? 1,
                          minLines: minLines,
                          validator: validator,
                          readOnly: true,
                          onTap: () {
                            onTap?.call();
                            controller.toggleDropdown();
                          },
                          style: GoogleFonts.dmSans(
                            fontSize: fontSize ?? 16.sp,
                            fontWeight: fontWeight ?? FontWeight.w400,
                            height: lineHeight ?? 24.h / 16.h,
                            color: textColor ?? Colors.black,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 5.h,
                              horizontal: 10.w,
                            ),
                            hintText: hintText,
                            hintStyle: GoogleFonts.dmSans(
                              fontSize: fontSize ?? 14.sp,
                              fontWeight: fontWeight ?? FontWeight.w300,
                              height: lineHeight ?? 24.h / 16.h,
                              color: hintTextColor ?? Colors.grey,
                            ),
                            prefixIcon: prefixIconPath != null
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                    ),
                                    child: Image.asset(
                                      prefixIconPath!,
                                      width: 14.w,
                                      height: 14.h,
                                      fit: BoxFit.contain,
                                    ),
                                  )
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: borderSide ?? BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: borderSide ?? BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: borderSide ?? BorderSide.none,
                            ),
                            suffixIcon: suffixIcon,
                            filled: true,
                            fillColor: fillColor ?? const Color(0xFF382D4A),
                          ),
                        ),
                        if (isOpen && dropdownItems != null)
                          Align(
                            alignment: Alignment.topCenter,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final screenHeight = MediaQuery.of(
                                  context,
                                ).size.height;
                                final renderBox =
                                    context.findRenderObject() as RenderBox?;
                                final currentY =
                                    renderBox?.localToGlobal(Offset.zero).dy ??
                                    0;
                                final availableHeight =
                                    screenHeight - currentY - 40.h;

                                return ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxHeight: availableHeight > 150.h
                                        ? 150.h
                                        : availableHeight,
                                  ),
                                  child: Material(
                                    elevation: 4,
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: SingleChildScrollView(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: fillColor ?? Colors.white,
                                          border: Border.all(
                                            color:
                                                borderSide?.color ??
                                                Colors.grey,
                                            width: borderSide?.width ?? 1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            10.r,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: dropdownItems!.map((item) {
                                            return GestureDetector(
                                              onTap: () {
                                                textEditingController?.text =
                                                    item;
                                                onDropdownChanged?.call(item);
                                                controller.closeDropdown();
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 10.h,
                                                  horizontal: 10.w,
                                                ),
                                                child: Text(
                                                  item,
                                                  style: GoogleFonts.dmSans(
                                                    fontSize: fontSize ?? 14.sp,
                                                    fontWeight:
                                                        fontWeight ??
                                                        FontWeight.w300,
                                                    color:
                                                        textColor ??
                                                        Colors.black,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    )
                  : TextFormField(
                      controller: textEditingController,
                      obscureText: obscureText,
                      maxLines: maxLines ?? 1,
                      minLines: minLines,
                      validator: validator,
                      readOnly: readOnly,
                      onTap: onTap,
                      style: GoogleFonts.dmSans(
                        fontSize: fontSize ?? 16.sp,
                        fontWeight: fontWeight ?? FontWeight.w400,
                        height: lineHeight ?? 24.h / 16.h,
                        color: textColor ?? Colors.white,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 5.h,
                          horizontal: 10.w,
                        ),
                        hintText: hintText,
                        hintStyle: GoogleFonts.dmSans(
                          fontSize: fontSize ?? 14.sp,
                          fontWeight: fontWeight ?? FontWeight.w300,
                          height: lineHeight ?? 24.h / 16.h,
                          color: hintTextColor ?? Colors.white,
                        ),
                        prefixIcon: prefixIconPath != null
                            ? Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Image.asset(
                                  prefixIconPath!,
                                  width: 20.w,
                                  height: 20.h,
                                  fit: BoxFit.contain,
                                ),
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: borderSide ?? BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: borderSide ?? BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: borderSide ?? BorderSide.none,
                        ),
                        suffixIcon: suffixIcon,
                        filled: true,
                        fillColor: fillColor ?? const Color(0xFFFFFFFF),
                      ),
                    ),
            ),
          ),
        ],
      );
    });
  }
}
