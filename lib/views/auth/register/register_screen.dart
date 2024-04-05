import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:iconly/iconly.dart';
import 'package:thu_gom/controllers/register/register_controller.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';

import '../../../shared/constants/color_constants.dart';
import '../../../shared/themes/Themes.dart';
import '../../../shared/themes/style/custom_button_style.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final RegisterController _registerController = Get.find<RegisterController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.ksecondBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.sp, 20, 24.sp, 30),
            child: Center(
              child: Column(
                children: [
                  Text('Xin chào !', style: AppTextStyles.bodyText1.copyWith(
                      fontSize: 16.sp
                    )
                  ),
                  Text(
                    'Tạo tài khoản', style: AppTextStyles.headline1.copyWith(
                      fontSize: 24.sp
                    )
                  ),
                  SizedBox(height: 20.sp),
                  FormBuilder(
                    key: _registerController.formKey,
                    child: Column(
                      children: [
                        // Email Field
                        FormBuilderTextField(
                          key: _registerController.emailFieldKey,
                          name: 'email',
                          style: AppTextStyles.bodyText1,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(12.sp, 0, 12.sp, 0),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Email',
                            labelStyle: AppTextStyles.bodyText1.copyWith(
                              color: ColorsConstants.kMainColor
                            ),
                            errorStyle: AppTextStyles.error,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: ColorsConstants.kMainColor, width: 2)
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: "Không được để trống trường này"),
                            FormBuilderValidators.email(errorText: "Email không hợp lệ"),
                          ]),
                        ),
                        SizedBox(height: 30.sp),
                        // Username Field
                        FormBuilderTextField(
                          key: _registerController.usernameFieldKey,
                          name: 'username',
                          style: AppTextStyles.bodyText1,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(12.sp, 0, 12.sp, 0),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Tên tài khoản',
                            labelStyle: AppTextStyles.bodyText1.copyWith(
                                color: ColorsConstants.kMainColor
                            ),
                            errorStyle: AppTextStyles.error,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: ColorsConstants.kMainColor, width: 2)
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: "Không được để trống trường này"),
                            FormBuilderValidators.maxWordsCount(254,errorText: "Tên không hợp lệ"),
                          ]),
                        ),
                        SizedBox(height: 30.sp),
                        Obx(
                              () => FormBuilderTextField(
                            key: _registerController.passwordFieldKey,
                            name: 'password',
                            obscureText: _registerController.passwordVisible.value,
                            style: AppTextStyles.bodyText1,
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.fromLTRB(12.sp, 0, 12.sp, 0),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Mật khẩu',
                              labelStyle: AppTextStyles.bodyText1.copyWith(
                                  color: ColorsConstants.kMainColor
                              ),
                              errorStyle: AppTextStyles.error,
                              suffixIcon: Obx(() => IconButton(
                                color: ColorsConstants.kMainColor,
                                icon: _registerController.passwordVisible.value
                                    ? Icon(IconlyLight.show)
                                    : Icon(IconlyLight.hide),
                                onPressed: () {
                                  _registerController.passwordVisible.value = !_registerController.passwordVisible.value;
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
                              FormBuilderValidators.required(errorText: "Không được để trống trường này"),
                              FormBuilderValidators.minLength(8, errorText: 'Mật khẩu cần dài ít nhất 8 ký tự')
                            ]),
                          ),
                        ),
                        SizedBox(height: 30.sp),
                        Obx(
                              () => FormBuilderTextField(
                            key: _registerController.confirmPasswordFieldKey,
                            name: 'confirmpassword',
                            obscureText: _registerController.confirmPasswordVisible.value,
                            style: AppTextStyles.bodyText1,
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.fromLTRB(12.sp, 0, 12.sp, 0),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Xác nhận mật khẩu',
                              labelStyle: AppTextStyles.bodyText1.copyWith(
                                  color: ColorsConstants.kMainColor
                              ),
                              errorStyle: AppTextStyles.error,
                              suffixIcon: Obx(() => IconButton(
                                color: ColorsConstants.kMainColor,
                                icon: _registerController.confirmPasswordVisible.value
                                    ? Icon(IconlyLight.show)
                                    : Icon(IconlyLight.hide),
                                onPressed: () {
                                  _registerController.confirmPasswordVisible.value = !_registerController.confirmPasswordVisible.value;
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
                              (val) {
                                if (val != _registerController.formKey.currentState?.fields['password']!.value) {
                                  return 'Mật khẩu không khớp';
                                }
                                return null;
                              },
                              FormBuilderValidators.required(errorText: "Không được để trống trường này"),
                              FormBuilderValidators.minLength(8, errorText: 'Mật khẩu cần dài ít nhất 8 ký tự'),
                            ]),

                          ),
                        ),
                        SizedBox(height: 24.sp),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Đăng ký tài khoản',
                              style: AppTextStyles.title.copyWith(
                                fontSize: 16.sp
                              ),
                            ),
                            SizedBox(height: 6.sp),
                            Obx(() =>
                                ListTile(
                                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                                  contentPadding: EdgeInsets.zero,
                                  title: GestureDetector(
                                    onTap: () {
                                      _registerController.roleField.value = 'person';
                                    },
                                    child: Text('Người dân',style: AppTextStyles.title.copyWith(
                                      fontSize: 14.sp
                                    )),
                                  ),
                                  leading: Radio(
                                    activeColor: ColorsConstants.kMainColor,
                                    value: 'person',
                                    onChanged: (value) {
                                      _registerController.roleField.value = value.toString();
                                    },
                                    groupValue: _registerController.roleField.value,
                                  ),
                                ),
                            ),
                            Obx(() =>
                                ListTile(
                                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                                  contentPadding: EdgeInsets.zero,
                                  title: GestureDetector(
                                    onTap: () {
                                      _registerController.roleField.value = 'collector';
                                    },
                                    child: Text('Người thu gom',style: AppTextStyles.title.copyWith(
                                        fontSize: 14.sp
                                    )),
                                  ),
                                  leading: Radio(
                                    activeColor: ColorsConstants.kMainColor,
                                    value: 'collector',
                                    onChanged: (value) {
                                      _registerController.roleField.value = value.toString();
                                    },
                                    groupValue: _registerController.roleField.value,
                                  ),
                                ),
                            )
                          ],
                        ),
                        SizedBox(height: 36.sp),
                        SizedBox(
                          width:  ScreenUtil().screenWidth,
                          height: 48.sp,
                          child: ElevatedButton(
                              onPressed: () {
                                // Get.toNamed('/profilePage');
                                if (_registerController.formKey.currentState!.saveAndValidate()) {
                                  _registerController.register(_registerController.formKey.currentState!.value);
                                }
                              },
                              style: CustomButtonStyle.primaryButton,
                              child: Text(
                                'Đăng ký',
                                style: TextStyle(color: Colors.white, fontSize: 18.sp),
                              )
                          ),
                        ),
                        SizedBox(height: 40.sp),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text('Đã có tài khoản ?',
                                      style: AppTextStyles.headline3.copyWith(
                                        fontSize: 13.sp,
                                          fontWeight: FontWeight.w700
                                      )
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Get.offAndToNamed("/loginPage");
                                      },
                                      child: Text('Đăng nhập ngay',
                                          style: AppTextStyles.headline3.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: ColorsConstants.kMainColor,
                                              decoration: TextDecoration.underline,
                                              decorationColor: ColorsConstants.kMainColor
                                          )
                                      )
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text('Hoặc đăng ký bằng',
                                      style: AppTextStyles.headline3.copyWith(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w700
                                      )
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Get.toNamed("/registerOrLoginWithPhonePage",arguments: {
                                          'actionType': 'register'
                                        });
                                      },
                                      child: Text('Số điện thoại',
                                        style: AppTextStyles.headline3.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: ColorsConstants.kMainColor,
                                          decoration: TextDecoration.underline,
                                          decorationColor: ColorsConstants.kMainColor,
                                        ),
                                        textAlign: TextAlign.center,
                                      )
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
