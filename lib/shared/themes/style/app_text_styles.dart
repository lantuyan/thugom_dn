// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';

class AppTextStyles {
  static const String fontFamily = 'Inter';

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;
  late var height;

  static TextStyle titleDialog = TextStyle(
    fontSize: 18.sp,
    fontFamily: AppTextStyles.fontFamily,
    fontWeight: FontWeight.w700,
    color: ColorsConstants.kMainColor,
  );

  static TextStyle caption = TextStyle(
    fontSize: 16.sp,
    fontFamily: AppTextStyles.fontFamily,
    fontWeight: FontWeight.w700,
    color: ColorsConstants.kMainColor,
  );
  
  static TextStyle headline1 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    fontFamily: AppTextStyles.fontFamily,
    color: ColorsConstants.kTextMainColor,
  );
  static TextStyle headline2 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    fontFamily: AppTextStyles.fontFamily,
    color: ColorsConstants.kTextMainColor,
  );
  static TextStyle headline3 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
    fontFamily: AppTextStyles.fontFamily,
    color: ColorsConstants.kTextMainColor,
  );

  static TextStyle title = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    fontFamily: AppTextStyles.fontFamily,
    color: ColorsConstants.kTextMainColor,
  );

  static TextStyle bodyText1 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    fontFamily: AppTextStyles.fontFamily,
    color: ColorsConstants.kTextMainColor,
  );
  static TextStyle bodyText2 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    fontFamily: AppTextStyles.fontFamily,
    color: ColorsConstants.kTextMainColor,

  );

  static TextStyle bodyText3 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    fontFamily: AppTextStyles.fontFamily,
    fontStyle: FontStyle.italic,
    color: ColorsConstants.kTextSecondColor,
  );
  static TextStyle bodyText4 = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
    fontFamily: AppTextStyles.fontFamily,
    color: ColorsConstants.kTextSecondColor,
  );

  static TextStyle error = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    fontFamily: AppTextStyles.fontFamily,
    color: ColorsConstants.kErorColor,
  );




}
