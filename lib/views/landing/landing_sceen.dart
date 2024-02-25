import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/Themes.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.kBackgroundColor,
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 240.sp,
        padding: EdgeInsets.symmetric(horizontal: 24.sp),
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 18.sp),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/registerPage');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: ColorsConstants.kActiveColor,
                  padding: EdgeInsets.symmetric(vertical: 18.sp),
                  backgroundColor: ColorsConstants.kActiveColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                ),
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
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/loginPage');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  backgroundColor: ColorsConstants.kBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: ColorsConstants.kActiveColor,
                    ),
                  ),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  foregroundColor: ColorsConstants.kActiveColor,
                ),
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
                    color: ColorsConstants.kMainColor
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
