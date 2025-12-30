import 'package:pos/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: ColorsManager.white,
  primaryColor: ColorsManager.mainBlue,
  appBarTheme: AppBarTheme(
    backgroundColor: ColorsManager.white,
    elevation: 0,
    iconTheme: IconThemeData(color: ColorsManager.mainBlue),
    titleTextStyle: TextStyle(
      color: ColorsManager.mainBlue,
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(fontSize: 16.sp, color: ColorsManager.darkBlue),
    bodyMedium: TextStyle(
      fontSize: 14.sp,
      color: ColorsManager.darkBlue,
    ), // changed from gray
    titleLarge: TextStyle(fontSize: 20.sp, color: ColorsManager.mainBlue),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: ColorsManager.mainBlue,
      ), // changed from lightGray
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorsManager.mainBlue),
    ),
    labelStyle: TextStyle(color: ColorsManager.darkBlue), // changed from gray
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: ColorsManager.mainBlue,
      textStyle: TextStyle(fontSize: 14.sp),
    ),
  ),
  colorScheme: ColorScheme.light(
    primary: ColorsManager.mainBlue,
    secondary: ColorsManager.lightBlue,
    error: ColorsManager.red,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: ColorsManager.black,
  primaryColor: ColorsManager.white,
  appBarTheme: AppBarTheme(
    backgroundColor: ColorsManager.black,
    elevation: 0,
    iconTheme: IconThemeData(color: ColorsManager.white),
    titleTextStyle: TextStyle(
      color: ColorsManager.white,
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(fontSize: 16.sp, color: ColorsManager.white),
    bodyMedium: TextStyle(
      fontSize: 14.sp,
      color: ColorsManager.white,
    ), // changed from lighterGray
    titleLarge: TextStyle(fontSize: 20.sp, color: ColorsManager.white),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorsManager.white), // changed from gray
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorsManager.white),
    ),
    labelStyle: TextStyle(color: ColorsManager.white), // changed from lightGray
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: ColorsManager.white,
      textStyle: TextStyle(fontSize: 14.sp),
    ),
  ),
  colorScheme: ColorScheme.dark(
    surface: ColorsManager.black,
    primary: ColorsManager.white,
    secondary: ColorsManager.lighterGray,
    error: ColorsManager.red,
  ),
);
