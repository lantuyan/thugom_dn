import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/shared/themes/style/custom_button_style.dart';
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
              Text('Đang xử lý...',style: AppTextStyles.bodyText1),
            ],
          ),
        ),
      ),
      barrierDismissible: false, // Prevent users from dismissing the dialog by tapping outside
    );
  }
  static void hideLoadingDialog(){
    Get.back();
  }
  static void showSnackBar(int duration,String message,String type){
    Color color;
    Icon icon;
    if (type == 'error') {
      icon = const Icon(Icons.error_outline,color: Colors.white);
      color = Colors.red;
    } else if (type == 'alert') {
      icon = const Icon(Icons.notifications_outlined);
      color = Colors.amber;
    } else if (type == 'success'){
      icon = const Icon(Icons.check_circle_outline,color: Colors.white);
      color = ColorsConstants.kMainColor;
    }else{
      icon = const Icon(Icons.notifications_outlined);
      color = Colors.blue;
    }
    Get.snackbar(
      type == 'error'?"Thông báo lỗi":"Thông báo",
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

  static void confirmDialog(String title,Widget content,Function confirm){
    Get.defaultDialog(
      contentPadding: EdgeInsets.fromLTRB(12.sp, 12.sp, 12.sp, 12.sp),
      title: title,
      titleStyle: AppTextStyles.headline1,
      content: content,
      buttonColor: ColorsConstants.kMainColor,
      cancel: ElevatedButton(
          onPressed: (){
            Get.back();
          },
          style: CustomButtonStyle.transparentButton,
          child: Text(
            'Bỏ qua',
            style: TextStyle(color: ColorsConstants.kMainColor, fontSize: 16.sp),
          )
      ),
      confirm: ElevatedButton(
          onPressed: (){
            confirm();

          },
          style: CustomButtonStyle.primaryButton,
          child: Text(
            'Xác nhận',
            style: TextStyle(color: ColorsConstants.kBGCardColor, fontSize: 16.sp),
          )
      ),

    );
  }
  static void contactDialog(String address,String phonenumber,String zalonumber){
    Get.dialog(
      AlertDialog(
        title: Center(
          child: Text(
            'Thông tin liên hệ',
            style: AppTextStyles.headline1,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Địa chỉ',style: AppTextStyles.headline1,
              ),
              Text(
                address,
                style: AppTextStyles.bodyText2.copyWith(
                    color: ColorsConstants.kMainColor
                ),
              ),
              SizedBox(height: 12.sp,),
              Text(
                'Số điện thoại',style: AppTextStyles.headline1,
              ),
              Text(
                phonenumber,style: AppTextStyles.bodyText2.copyWith(
                  color: ColorsConstants.kMainColor
              ),
              ),
              SizedBox(height: 12.sp,),
              Text(
                'Zalo liên hệ',style: AppTextStyles.headline1,
              ),
              Text(
                phonenumber,style: AppTextStyles.bodyText2.copyWith(
                  color: ColorsConstants.kMainColor
              ),
              ),
            ],
          ),
        ),
      ),
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