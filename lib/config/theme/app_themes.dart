import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final class AppTheme {
  static final ThemeData light = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.blue,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: Colors.blue,
      secondary: const Color(0xFF1D1D1D),
      tertiary: Colors.grey.shade200,
      surface: Colors.white,
      error: Colors.red,
    ),
    iconTheme: IconThemeData(color: const Color(0xFF1D1D1D)),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(foregroundColor: WidgetStateProperty.all(const Color(0xFF1D1D1D))),
    ),
    textTheme: Typography.englishLike2018
        .apply(fontSizeFactor: 1.sp)
        .copyWith(
          bodySmall: TextStyle(fontSize: 14.sp, color: const Color(0xFF1D1D1D)),
          bodyMedium: TextStyle(fontSize: 16.sp, color: const Color(0xFF1D1D1D)),
          bodyLarge: TextStyle(fontSize: 18.sp, color: const Color(0xFF1D1D1D)),
          titleSmall: TextStyle(fontSize: 26.sp, color: const Color(0xFF1D1D1D)),
          titleLarge: TextStyle(fontSize: 30.sp, color: const Color(0xFF1D1D1D)),
        ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 0,
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.blue),
    cardColor: Colors.grey.shade100,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.w500),
      centerTitle: false,
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        minimumSize: Size(double.maxFinite, 56.h),
        textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        minimumSize: Size(double.maxFinite, 56.h),
        side: BorderSide(color: Colors.white, width: 2.w),
        textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.blue,
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
    ),
    dialogTheme: DialogThemeData(backgroundColor: Colors.white),
  );

  static final ThemeData dark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xFF1D1D1D),
    primaryColor: Colors.blue,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: Colors.blue,
      secondary: Colors.white,
      tertiary: Colors.grey.shade800,
      surface: const Color(0xFF1D1D1D),
      error: Colors.red,
    ),
    iconTheme: IconThemeData(color: Colors.white),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.white)),
    ),
    textTheme: Typography.englishLike2018
        .apply(fontSizeFactor: 1.sp)
        .copyWith(
          bodySmall: TextStyle(fontSize: 14.sp, color: Colors.white),
          bodyMedium: TextStyle(fontSize: 16.sp, color: Colors.white),
          bodyLarge: TextStyle(fontSize: 18.sp, color: Colors.white),
          titleSmall: TextStyle(fontSize: 26.sp, color: Colors.white),
          titleLarge: TextStyle(fontSize: 30.sp, color: Colors.white),
        ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 0,
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.white),
    cardColor: Colors.grey.shade800,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.w500),
      centerTitle: false,
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        minimumSize: Size(double.maxFinite, 56.h),
        textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        minimumSize: Size(double.maxFinite, 56.h),
        side: BorderSide(color: Colors.white, width: 2.w),
        textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.blue,
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
    ),
    dialogTheme: DialogThemeData(backgroundColor: Colors.grey.shade800),
  );
}
