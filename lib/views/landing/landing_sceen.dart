import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/style/custom_button_style.dart';
import 'package:thu_gom/shared/themes/Themes.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.ksecondBackgroundColor,
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
              // margin: EdgeInsets.only(bottom: 18.sp),
              width: MediaQuery.of(context).size.width,
              height: 48.sp,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/registerPage');
                },
                style: CustomButtonStyle.primaryButton,
                child: Text(
                  'Đăng ký',
                  style: TextStyle(
                    color: ColorsConstants.kSecondColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 18.sp,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 48.sp,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/loginPage');
                },
                style: CustomButtonStyle.transparentButton,
                child: Text(
                  'Đăng nhập',
                  style: TextStyle(
                    color: ColorsConstants.kMainColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      extendBody: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.sp, 28.sp, 24.sp, 0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 28.sp),
                  child: Image.asset(
                    'assets/images/logo_instruction.png',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                  ),
                ),
                Text(
                  'Tham gia Thu Gom ngay!',
                  style: Themes.lightTheme.textTheme.headlineMedium?.copyWith(
                    color: ColorsConstants.kMainColor,
                    fontSize: 27.sp,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Cùng nhau xây dựng một môi trường sống bền vững và giúp giảm thiểu lượng rác thải',
                    style: Themes.lightTheme.textTheme.titleSmall,
                    textAlign: TextAlign.center,
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
