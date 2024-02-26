import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:iconly/iconly.dart';
import 'package:thu_gom/controllers/register/register_controller.dart';

import '../../../shared/constants/color_constants.dart';
import '../../../shared/themes/Themes.dart';
import '../../../shared/themes/style/custom_button_style.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final RegisterController _registerController = Get.find<RegisterController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.sp, 20, 24.sp, 30),
            child: Center(
              child: Column(
                children: [
                  Text('Xin chào !', style: Themes.lightTheme.textTheme.headline6),
                  Text(
                    'Tạo tài khoản', style: Themes.lightTheme.textTheme.headline3,
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
                          style: Themes.lightTheme.textTheme.titleSmall,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(12.sp, 0, 12.sp, 0),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Email',
                            labelStyle: Themes.lightTheme.textTheme.titleSmall?.copyWith(
                              color: ColorsConstants.kMainColor
                            ),
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
                          // style: Themes.lightTheme.textTheme.titleSmall,
                        ),
                        SizedBox(height: 30.sp),
                        // Username Field
                        FormBuilderTextField(
                          key: _registerController.usernameFieldKey,
                          name: 'username',
                          style: Themes.lightTheme.textTheme.titleSmall,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(12.sp, 0, 12.sp, 0),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Tên tài khoản',
                            labelStyle: Themes.lightTheme.textTheme.titleSmall?.copyWith(
                                color: ColorsConstants.kMainColor
                            ),
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
                          // style: Themes.lightTheme.textTheme.titleSmall,
                        ),
                        SizedBox(height: 30.sp),
                        Obx(
                              () => FormBuilderTextField(
                            key: _registerController.passwordFieldKey,
                            name: 'password',
                            obscureText: _registerController.passwordVisible.value,
                            style: Themes.lightTheme.textTheme.titleSmall,
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.fromLTRB(12.sp, 0, 12.sp, 0),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Mật khẩu',
                              labelStyle: Themes.lightTheme.textTheme.titleSmall?.copyWith(
                                  color: ColorsConstants.kMainColor
                              ),
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
                            style: Themes.lightTheme.textTheme.titleSmall,
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.fromLTRB(12.sp, 0, 12.sp, 0),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Xác nhận mật khẩu',
                              labelStyle: Themes.lightTheme.textTheme.titleSmall?.copyWith(
                                  color: ColorsConstants.kMainColor
                              ),
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
                              style: Themes.lightTheme.textTheme.headline6,
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
                                    child: Text('Người dân'),
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
                                    child: Text('Người thu gom'),
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
                        Column(
                          children: [
                            Text('Đã có tài khoản ?',
                                style: Themes.lightTheme.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w700
                                )
                            ),
                            GestureDetector(
                                onTap: () {
                                  Get.offAndToNamed("/loginPage");
                                },
                                child: Text('Đăng nhập ngay',
                                    style: Themes.lightTheme.textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: ColorsConstants.kMainColor,
                                        decoration: TextDecoration.underline,
                                    )
                                )
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
