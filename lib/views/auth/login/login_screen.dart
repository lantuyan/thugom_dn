import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:iconly/iconly.dart';
import 'package:thu_gom/shared/themes/Themes.dart';
import 'package:get/get.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';

import '../../../controllers/login/login_controller.dart';
import '../../../shared/constants/color_constants.dart';
import '../../../shared/themes/style/custom_button_style.dart';

class LoginScreen extends StatelessWidget {
  final LoginController _loginController = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.ksecondBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(24.sp, 80, 24.sp, 20),
                child: Center(
                  child: Image.asset(
                    'assets/images/logo_instruction.png',
                    width: 200.w,
                    height: 200.w,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.sp),
                child: Center(
                  child: Column(
                    children: [
                      Text('Xin chào!',
                          style: AppTextStyles.bodyText1.copyWith(
                            fontSize: 16.sp
                          )
                      ),
                      Text(
                        'Đăng nhập ',
                        style: AppTextStyles.headline1.copyWith(
                            fontSize: 24.sp
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FormBuilder(
                key: _loginController.formKey,
                  child: Column(
                    children: [
                      // Email Field
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.sp),
                        child: FormBuilderTextField(
                          key: _loginController.emailFieldKey,
                          name: 'email',
                          decoration: InputDecoration(
                            contentPadding:
                            EdgeInsets.fromLTRB(12.sp, 0, 12.sp, 0),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Email',
                            labelStyle: AppTextStyles.bodyText1
                                .copyWith(color: ColorsConstants.kMainColor),
                            errorStyle: AppTextStyles.error,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: ColorsConstants.kMainColor, width: 2)),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: "Không được để trống trường này"),
                            FormBuilderValidators.email(errorText: "Email không hợp lệ"),
                          ]),
                          style: AppTextStyles.bodyText1,
                        ),
                      ),
                      SizedBox(height: 30.sp),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.sp),
                        child: Obx(
                              () => FormBuilderTextField(
                            key: _loginController.passwordFieldKey,
                            name: 'password',
                            obscureText: _loginController.passwordVisible.value,
                            style: AppTextStyles.bodyText1,
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.fromLTRB(12.sp, 0, 12.sp, 0),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Mật khẩu',
                              labelStyle: AppTextStyles.bodyText1
                                  .copyWith(color: ColorsConstants.kMainColor),
                              errorStyle: AppTextStyles.error,
                              suffixIcon: Obx(() => IconButton(
                                color: ColorsConstants.kMainColor,
                                icon: _loginController.passwordVisible.value
                                    ? Icon(IconlyLight.show)
                                    : Icon(IconlyLight.hide),
                                onPressed: () {
                                  _loginController.passwordVisible.value =
                                  !_loginController.passwordVisible.value;
                                },
                              )),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: ColorsConstants.kMainColor,
                                      width: 2)),
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: "Không được để trống trường này"),
                              FormBuilderValidators.minLength(8,
                                  errorText: 'Mật khẩu cần dài ít nhất 8 ký tự')
                            ]),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.sp),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.sp),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                              onTap: () {},
                              child: Text('Quên mật khẩu ?',
                                  style: AppTextStyles.headline3.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: ColorsConstants.kMainColor,
                                      decoration: TextDecoration.underline,
                                      decorationColor: ColorsConstants.kMainColor
                                  )
                              )
                          ),
                        ),
                      ),
                      SizedBox(height: 36.sp),
                      SizedBox(
                        width:  ScreenUtil().screenWidth,
                        height: 48.sp,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(24.sp, 0.sp, 24.sp, 0),
                          child: ElevatedButton(
                              onPressed: () {
                                if (_loginController.formKey.currentState!.saveAndValidate()) {
                                  print(_loginController.formKey.currentState!.value);
                                  _loginController.login(_loginController.formKey.currentState!.value);
                                }
                              },
                              style: CustomButtonStyle.primaryButton,
                              child: Text(
                                'Đăng nhập',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.sp),
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 64.sp, 0, 24.sp),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text('Chưa có tài khoản ?',
                                      style: AppTextStyles.headline3.copyWith(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w700,
                                      )
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Get.offAndToNamed("/registerPage");
                                      },
                                      child: Text('Đăng ký ngay',
                                          style: AppTextStyles.headline3.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: ColorsConstants.kMainColor,
                                            decoration: TextDecoration.underline,
                                            decorationColor: ColorsConstants.kMainColor
                                          )
                                      )
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                  children: [
                                    Text('Hoặc tiếp tục bằng?',
                                        style: AppTextStyles.headline3.copyWith(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w700,
                                        )
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          Get.toNamed("/registerOrLoginWithPhonePage",arguments: {
                                            'actionType': 'login'
                                          });
                                        },
                                        child: Text('Số điện thoại',
                                            style: AppTextStyles.headline3.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: ColorsConstants.kMainColor,
                                                decoration: TextDecoration.underline,
                                                decorationColor: ColorsConstants.kMainColor
                                            ),
                                          textAlign: TextAlign.center,
                                        )
                                    )
                                  ],
                                ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
