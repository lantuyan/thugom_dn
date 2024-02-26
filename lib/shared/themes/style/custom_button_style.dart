import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';

class CustomButtonStyle {
    static ButtonStyle primaryButton = ElevatedButton.styleFrom(
        // padding: EdgeInsets.symmetric(vertical: 18.sp),
        backgroundColor: ColorsConstants.kActiveColor,
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        shadowColor: ColorsConstants.kMainColor
    );

    static ButtonStyle transparentButton = ElevatedButton.styleFrom(
        backgroundColor: ColorsConstants.ksecondBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: ColorsConstants.kActiveColor,
          ),
        ),
        elevation: 0,
        // shadowColor: Colors.transparent,
        foregroundColor: ColorsConstants.kActiveColor,
    );

    static ButtonStyle socialButton = ElevatedButton.styleFrom(
        minimumSize: Size(40.sp,30.sp),
        backgroundColor: ColorsConstants.kBackgroundColor,
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        shadowColor: ColorsConstants.kShadowColor,
        padding: EdgeInsets.all(5.sp)
    );
}
