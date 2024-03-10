import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thu_gom/controllers/login/login_controller.dart';
import 'package:thu_gom/controllers/main/infomation/infomation_controller.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/widgets/custom_dialogs.dart';

Padding userName(String name) {
  final InfomationController _homeController = Get.put(InfomationController());

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.sp),
    child: Row(
      children: [
        SizedBox(
          width: 0.w,
        ),
        GestureDetector(
          onTap: () {
            // _loginController.logout(); // LOGOUT
            // CustomDialogs.confirmDialog(
            //     'Đăng xuất',
            //     Text(
            //       'Bạn chắc chắn muốn đăng xuất tài khoản',
            //       style: AppTextStyles.bodyText2.copyWith(fontSize: 12.sp),
            //       textAlign: TextAlign.center,
            //     ), () {
            //   _homeController.logOut();
            // });
          },
          child: Image.asset(
            'assets/images/user-avatar.png',
            height: 40.h,
            width: 40.w,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          "Xin chào: " + name,
          style: AppTextStyles.headline1,
        )
      ],
    ),
  );
}
