import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:thu_gom/controllers/register/register_or_login_with_phone_controller.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/shared/themes/style/custom_button_style.dart';

class OtpConfirmScreen extends StatelessWidget{
  OtpConfirmScreen({super.key});

  final RegisterOrLoginWithPhoneController _controller = Get.find<RegisterOrLoginWithPhoneController>();
  final GlobalKey<FormState> formPinCodeKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
            'Xác thực số điện thoại'.toUpperCase(),
            style: AppTextStyles.title.copyWith(color: ColorsConstants.kMainColor,)
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Navigate back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.sp, 10.sp, 24.sp, 10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 125.sp,
              width: 125.sp,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Image.asset(
                "assets/images/logo_new.png",
              ),
            ),
            Text("Xác thực!",
                style: AppTextStyles.headline1.copyWith(
                    fontSize: 24.sp
                )
            ),
            Text(
              "Vui lòng nhập mã được gửi tới",
              style: AppTextStyles.bodyText1.copyWith(
                fontSize: 16.sp,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              _controller.phoneNumber,
              style: AppTextStyles.bodyText1.copyWith(
                  fontWeight: FontWeight.w700,
                  color: ColorsConstants.kTextMainColor),
            ),
            SizedBox(height: 16.sp,),
            Form(
              key: formPinCodeKey,
              child: PinCodeTextField(
                keyboardType: TextInputType.number,
                appContext: context,
                length: 6,
                cursorHeight: 19,
                enableActiveFill: true,
                textStyle: AppTextStyles.title.copyWith(
                    color: ColorsConstants.kTextMainColor),
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    fieldWidth: 50.sp,
                    inactiveColor: Colors.grey,
                    selectedColor: ColorsConstants.kThirdColor,
                    activeFillColor: ColorsConstants.kThirdColor,
                    selectedFillColor: ColorsConstants.kThirdColor,
                    inactiveFillColor: Colors.grey.shade100,
                    borderWidth: 1,
                    borderRadius: BorderRadius.circular(10)
                ),
                onSaved: (value) {
                  _controller.pinCode = value;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Không nhận được mã? ",
                  style: AppTextStyles.headline1.copyWith(
                      fontWeight: FontWeight.w700,
                      color: ColorsConstants.kTextSecondColor),
                ),
                GestureDetector(
                  onTap: () {
                    if(_controller.actionType.value == 'register'){
                      _controller.registerWithPhone();
                    }else{
                      _controller.loginWithPhone();
                    }
                  },
                  child: Text('Gửi lại mã',
                      style: AppTextStyles.headline1.copyWith(
                          color: ColorsConstants.kMainColor,
                          fontWeight: FontWeight.w700)),
                )
              ],
            ),
            SizedBox(height: 20.sp,),
            // verification Button
            SizedBox(
              width: Get.width,
              height: 48.sp,
              child: ElevatedButton(
                onPressed: () {
                  formPinCodeKey.currentState?.save();
                  if(_controller.actionType.value == 'register'){
                    _controller.registerWithPhoneConfirm();
                  }else{
                    _controller.loginWithPhoneConfirm();
                  }
                },
                style: CustomButtonStyle.primaryButton,
                child: Text(
                  'Xác thực'.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}