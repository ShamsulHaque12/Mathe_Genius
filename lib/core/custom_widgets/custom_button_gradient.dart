import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonGradient extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor; // solid background color
  final List<Color>? gradientColors; // optional gradient
  final Color textColor;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final double width;
  final Widget? child;
  final String? prefixIconPath;
  final Widget? suffixIcon;
  final BorderSide? borderSide;
  final bool centerText;
  final String? backgroundImagePath;
  final bool spaceBetweenPrefix;
  final bool spaceBetweenSuffix;
  final double? suffixIconHeight;
  final double? suffixIconWidth;
  final double? prefixIconHeight;
  final double? prefixIconWidth;
  final Color? prefixIconColor;

  const CustomButtonGradient({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.gradientColors,
    this.textColor = Colors.black,
    this.borderRadius = 100,
    this.fontSize = 18,
    this.fontWeight = FontWeight.bold,
    this.height = 50,
    this.width = double.infinity,
    this.child,
    this.prefixIconPath,
    this.suffixIcon,
    this.borderSide,
    this.centerText = false,
    this.backgroundImagePath,
    this.spaceBetweenPrefix = false,
    this.spaceBetweenSuffix = false,
    this.suffixIconHeight,
    this.suffixIconWidth,
    this.prefixIconHeight,
    this.prefixIconWidth,
    this.prefixIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          // If gradientColors is provided, use gradient. Otherwise, use solid backgroundColor
          gradient: gradientColors != null
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradientColors!,
                )
              : null,
          color: gradientColors == null ? backgroundColor : null,
          borderRadius: BorderRadius.circular(borderRadius.r),
          border: borderSide != null
              ? Border.all(
                  color: borderSide!.color,
                  width: borderSide!.width,
                  style: borderSide!.style,
                )
              : null,
          image: backgroundImagePath != null
              ? DecorationImage(
                  image: AssetImage(backgroundImagePath!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius.r),
          child: Center(
            child:
                child ??
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: centerText
                      ? MainAxisAlignment.center
                      : (spaceBetweenPrefix || spaceBetweenSuffix)
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
                  children: [
                    if (prefixIconPath != null)
                      Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Image.asset(
                          prefixIconPath!,
                          color: prefixIconColor,
                          height: prefixIconHeight ?? 24.h,
                          width: prefixIconWidth ?? 24.w,
                        ),
                      ),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                        color: textColor,
                      ),
                    ),
                    if (suffixIcon != null)
                      Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: SizedBox(
                          height: suffixIconHeight ?? 24.h,
                          width: suffixIconWidth ?? 24.w,
                          child: suffixIcon,
                        ),
                      ),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
