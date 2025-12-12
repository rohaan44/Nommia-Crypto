import 'package:flutter/material.dart';
import 'package:nommia_crypto/utils/color_utils.dart';
import 'package:sizer/sizer.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Inter',

    scaffoldBackgroundColor: AppColor.fieldBg,

    splashFactory: NoSplash.splashFactory,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,

    colorScheme: const ColorScheme.dark(
      background: AppColor.background,
      primary: AppColor.gold, // gold/yellow accent
      secondary: AppColor.darkGrey, // card surfaces
      error: AppColor.red,
    ),

    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColor.gold,
      selectionColor: AppColor.darkGrey,
      selectionHandleColor: AppColor.gold,
    ),

    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: AppColor.white,
      ),
      displayMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColor.white,
      ),
      displaySmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColor.white,
      ),
      bodyLarge: TextStyle(fontSize: 12.sp, color: AppColor.lightGrey),
      bodyMedium: TextStyle(fontSize: 11.sp, color: AppColor.lightGrey),
      bodySmall: TextStyle(fontSize: 10.sp, color: AppColor.lightGrey),
      labelLarge: TextStyle(
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
        color: AppColor.white,
      ),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.background,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
        color: AppColor.white,
      ),
      iconTheme: const IconThemeData(color: AppColor.white),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.gold,
        foregroundColor: AppColor.black,
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 1.4.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColor.darkGrey,
      hintStyle: TextStyle(color: AppColor.lightGrey, fontSize: 11.sp),
      contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.6.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: AppColor.darkGrey,
      selectedColor: AppColor.gold,
      disabledColor: AppColor.darkGrey,
      labelStyle: TextStyle(fontSize: 10.sp, color: AppColor.white),
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.8.h),
      showCheckmark: false,
      side: BorderSide.none,
    ),
  );
}
