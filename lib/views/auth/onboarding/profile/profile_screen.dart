import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/shared/themes/style/custom_button_style.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 120.sp,
        padding: EdgeInsets.symmetric(horizontal: 24.sp),
        margin: EdgeInsets.only(bottom: 60.sp),
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 48.sp,
              child: TextButton(
                style: CustomButtonStyle.primaryButton,
                child: Text(
                  "Trang chủ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Get.offAllNamed("/mainPage");
                },
              ),
            ),
          ],
        ),
      ),
      extendBody: false,
      body: Container(
        color: Colors.transparent,
        margin: EdgeInsets.only(bottom: 40.sp),
        padding: EdgeInsets.fromLTRB(24.sp, 20.sp, 24.sp, 0),
        child: Column(
          children: [
            SizedBox(
              height: 80.sp,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Bước 2/2",
                    style: AppTextStyles.headline1,
                  ),
                  SizedBox(height: 8.sp),
                  Text(
                    "Nhập thông tin",
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontFamily: AppTextStyles.fontFamily,
                      fontWeight: FontWeight.w700,
                      color: ColorsConstants.kMainColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
