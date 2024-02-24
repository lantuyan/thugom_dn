import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
class CustomDialogs{
  static void showLoadingDialog(){
    Get.dialog(
      AlertDialog(
        content: Container(
          width: Get.width *0.5.sp,
          height: Get.width *0.5.sp,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: ColorsConstants.kMainColor,),
              SizedBox(height: 10.sp),
              Text('loading'.tr+" ..."),
            ],
          ),
        ),
      ),
      barrierDismissible: false, // Prevent users from dismissing the dialog by tapping outside
    );
  }
  static void hideLoadingDialog(){
    Get.back(closeOverlays: true);
  }
  static void showSnackBar(int duration,String message,String type){
    Color color;
    Icon icon;
    if (type == 'error') {
      icon = const Icon(Icons.error_outline);
      color = Colors.red;
    } else if (type == 'alert') {
      icon = const Icon(Icons.notifications_outlined);
      color = Colors.amber;
    } else if (type == 'success'){
      icon = const Icon(Icons.check_circle_outline);
      color = ColorsConstants.kMainColor;
    }else{
      icon = const Icon(Icons.notifications_outlined);
      color = Colors.blue;
    }
    Get.snackbar(
      type == 'error'?"error notification".tr:"notification".tr,
      message,
      icon: icon,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: color,
      borderRadius: 10.sp,
      margin: EdgeInsets.all(15.sp),
      colorText: Colors.white,
      duration: Duration(seconds: duration),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static void alertDialogeMail() async {
    Get.dialog(
      AlertDialog(
        content: Container(
          width: Get.width *0.5.sp,
          height: Get.width *0.5.sp,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: ColorsConstants.kMainColor,),
              SizedBox(height: 10.sp),
              Text('PASSWORD RESET LINK SENT! CHECK YOUR EMAIL'),
            ],
          ),
        ),
      ),
      barrierDismissible: false, // Prevent users from dismissing the dialog by tapping outside
    );
  }
}