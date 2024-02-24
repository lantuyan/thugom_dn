// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';

class Themes {

  static const String fontFamily = 'Inter';

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static TextStyle textStyle = TextStyle(
     
  );

  static ThemeData lightTheme = ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
          titleTextStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.grey.shade50,
          elevation: 0),
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)),
          hintStyle: TextStyle(
            fontSize: 14.sp,
          )),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.red),
      textTheme: TextTheme(
          headline1: TextStyle(
              letterSpacing: -1.5,
              fontSize: 48.sp,
              color: ColorsConstants.kTextMainColor,
              fontWeight: _bold),
          headline2: TextStyle(
              letterSpacing: -1.0,
              fontSize: 40.sp,
              color: ColorsConstants.kTextMainColor,
              fontWeight: _bold),
          headline3: TextStyle(
              letterSpacing: -1.0,
              fontSize: 32.sp,
              color: ColorsConstants.kTextMainColor,
              fontWeight: _bold),
          headline4: TextStyle(
              letterSpacing: -1.0,
              color: ColorsConstants.kTextMainColor,
              fontSize: 28.sp,
              fontWeight: _semiBold),
          headline5: TextStyle(
              letterSpacing: -1.0,
              color: ColorsConstants.kTextMainColor,
              fontSize: 24.sp,
              fontWeight: _medium),
          headline6: TextStyle(
              color: ColorsConstants.kTextMainColor, fontSize: 18.sp, fontWeight: _medium),
          subtitle1: TextStyle(
              color: ColorsConstants.kTextMainColor, fontSize: 16.sp, fontWeight: _medium),
          subtitle2: TextStyle(
              color: ColorsConstants.kTextMainColor, fontSize: 14.sp, fontWeight: _medium),
          bodyText1: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 16.sp,
              fontWeight: _regular),
          bodyText2: TextStyle(
              color: ColorsConstants.kTextSecondColor,
              fontSize: 14.sp,
              fontWeight: _regular),
          button: TextStyle(
              color: ColorsConstants.kSecondColor, fontSize: 14.sp, fontWeight: _semiBold),
          caption: TextStyle(
              color: ColorsConstants.kTextMainColor,
              fontSize: 12.sp,
              fontWeight: _regular),
          overline: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 10.sp,
              fontWeight: _semiBold,
              letterSpacing: -0.5),
          ));

  static ThemeData darkTheme = ThemeData(
    primaryColor: Colors.blue,
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey.shade900,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade900,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.white
      ),
    ),
    bottomAppBarColor: Colors.grey.shade800,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10)
      ),
      hintStyle: TextStyle(
        fontSize: 14,
      )
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Colors.white
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        letterSpacing: -1.5,
        fontSize: 48,
        color: Colors.grey.shade50,
        fontWeight: FontWeight.bold
      ),
      headline2: TextStyle(
        letterSpacing: -1.0,
        fontSize: 40,
        color: Colors.grey.shade50,
        fontWeight: FontWeight.bold
      ),
      headline3: TextStyle(
        letterSpacing: -1.0,
        fontSize: 32,
        color: Colors.grey.shade50,
        fontWeight: FontWeight.bold
      ),
      headline4: TextStyle(
        letterSpacing: -1.0,
        color: Colors.grey.shade50,
        fontSize: 28,
        fontWeight: FontWeight.w600
      ),
      headline5: TextStyle(
        letterSpacing: -1.0,
        color: Colors.grey.shade50,
        fontSize: 24,
        fontWeight: FontWeight.w500
      ),
      headline6: TextStyle(
        color: Colors.grey.shade50,
        fontSize: 18,
        fontWeight: FontWeight.w500
      ),
      subtitle1: TextStyle(
        color: Colors.grey.shade50,
        fontSize: 16,
        fontWeight: FontWeight.w500
      ),
      subtitle2: TextStyle(
        color: Colors.grey.shade50,
        fontSize: 14,
        fontWeight: FontWeight.w500
      ),
      bodyText1: TextStyle(
        color: Colors.grey.shade50,
        fontSize: 16,
        fontWeight: FontWeight.w400
      ),
      bodyText2: TextStyle(
        color: Colors.grey.shade50,
        fontSize: 14,
        fontWeight: FontWeight.w400
      ),
      button: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600
      ),
      caption: TextStyle(
        color: Colors.grey.shade50,
        fontSize: 12,
        fontWeight: FontWeight.w500
      ),
      overline: TextStyle(
        color: Colors.grey.shade50,
        fontSize: 10,
        fontWeight: FontWeight.w400
      )
    ),
  );
}
