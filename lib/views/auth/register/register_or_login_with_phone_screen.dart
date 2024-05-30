import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:iconly/iconly.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:thu_gom/controllers/register/register_controller.dart';
import 'package:thu_gom/controllers/register/register_or_login_with_phone_controller.dart';
import 'package:thu_gom/shared/themes/Themes.dart';
import 'package:get/get.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';

import '../../../controllers/login/login_controller.dart';
import '../../../shared/constants/color_constants.dart';
import '../../../shared/themes/style/custom_button_style.dart';

class RegisterOrLoginWithPhoneScreen extends StatelessWidget {
  final RegisterOrLoginWithPhoneController _controller = Get.find<RegisterOrLoginWithPhoneController>();
  PhoneNumber number = PhoneNumber(isoCode: 'VN');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: ColorsConstants.ksecondBackgroundColor,
      //   centerTitle: true,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     onPressed: () {
      //       Get.back();
      //     },
      //   ),
      // ),
      backgroundColor: ColorsConstants.ksecondBackgroundColor,
      body: SafeArea(
        child: Padding(
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
                  "assets/images/logo_thugom.png",
                ),
              ),
              Obx(() => Text(_controller.actionType.value == "register"?"Đăng ký tài khoản":"Đăng nhập",
                  style: AppTextStyles.headline1.copyWith(
                      fontSize: 24.sp
                  )
              ),),
              Text(
                _controller.actionType.value == "register"?"Vui lòng chọn loại tài khoản và nhập số điên thoại để tiếp tục":"Vui lòng nhập số điện thoại để tiếp tục",
                style: AppTextStyles.bodyText1.copyWith(
                  fontSize: 16.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.sp,),
              // Login Form
              FormBuilder(
                key: _controller.registerLoginWithPhoneKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx((){
                      if(_controller.actionType.value == 'register'){
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Loại tài khoản',
                              style: AppTextStyles.headline3.copyWith(
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
                                      _controller.roleField.value = 'person';
                                    },
                                    child: Text('Người dân',style: AppTextStyles.bodyText2.copyWith(
                                        fontSize: 14.sp
                                    )),
                                  ),
                                  leading: Radio(
                                    activeColor: ColorsConstants.kMainColor,
                                    value: 'person',
                                    onChanged: (value) {
                                      _controller.roleField.value = value.toString();
                                    },
                                    groupValue: _controller.roleField.value,
                                  ),
                                ),
                            ),
                            Obx(() =>
                                ListTile(
                                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                                  contentPadding: EdgeInsets.zero,
                                  title: GestureDetector(
                                    onTap: () {
                                      _controller.roleField.value = 'collector';
                                    },
                                    child: Text('Người thu gom',style: AppTextStyles.bodyText2.copyWith(
                                        fontSize: 14.sp
                                    )),
                                  ),
                                  leading: Radio(
                                    activeColor: ColorsConstants.kMainColor,
                                    value: 'collector',
                                    onChanged: (value) {
                                      _controller.roleField.value = value.toString();
                                    },
                                    groupValue: _controller.roleField.value,
                                  ),
                                ),
                            ),
                            SizedBox(height: 16.sp,),
                          ],
                        );
                      }else{
                        return Container();
                      }
                    }),
                    Text(
                      'Số điện thoại',
                      style: AppTextStyles.headline3.copyWith(
                          fontSize: 16.sp
                      ),
                    ),
                    SizedBox(height: 20.sp,),
                    // Phone Field
                    InternationalPhoneNumberInput(
                      fieldKey: _controller.phoneFieldKey,
                      initialValue: number,
                      onInputChanged: (PhoneNumber number) {
                      },
                      onSaved: (PhoneNumber number) {
                        _controller.dialCode = number.dialCode;
                        if(_controller.phoneFieldKey.currentState!.value.toString().startsWith('0')){
                          _controller.phoneNumber = _controller.phoneFieldKey.currentState?.value.replaceAll(' ', '');
                        }else{
                          _controller.phoneNumber = ('0'+ _controller.phoneFieldKey.currentState?.value).replaceAll(' ', '');
                        }
                      },
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.DIALOG,
                      ),
                      ignoreBlank: false,
                      selectorTextStyle: TextStyle(color: Colors.black),
                      textFieldController: _controller.phoneFieldController,
                      formatInput: true,
                      keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                      inputBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      inputDecoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12.sp, 0, 12.sp, 0),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Số điện thoại',
                        labelStyle: Themes.lightTheme.textTheme.titleSmall!
                            .copyWith(color: ColorsConstants.kMainColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: ColorsConstants.kMainColor, width: 2)
                        ),
                      ),
                      autoValidateMode: AutovalidateMode.disabled,
                      errorMessage: 'Số điện thoại không hợp lệ',
                    ),
                    SizedBox(height: 30.sp,),
                    SizedBox(
                      width: Get.width,
                      height: 48.sp,
                      child: ElevatedButton(
                        onPressed: () {
                          if(_controller.registerLoginWithPhoneKey.currentState!.saveAndValidate()){
                            if(_controller.actionType.value == 'register'){
                              _controller.registerWithPhone();
                            }else{
                              _controller.loginWithPhone();
                            }
                          }
                        },
                        style: CustomButtonStyle.primaryButton,
                        child: Text(
                          'Gửi mã'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp
                          ),
                        ),
                      ),
                    ),
                    // Login Button
                    SizedBox(height: 50.sp,),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Obx(() => Text(_controller.actionType.value == "register" ? "Đã có tài khoản?":"Chưa có tài khoản?",
                            style: AppTextStyles.headline3.copyWith(
                              fontSize: 13.sp,
                                fontWeight: FontWeight.w700
                            )
                        ),),
                        GestureDetector(
                          onTap: () {
                            if(_controller.actionType.value == "register") {
                              Get.offAllNamed("/registerOrLoginWithPhonePage",arguments: {
                                'actionType': 'login'
                              });
                            } else {
                              Get.offAllNamed("/registerOrLoginWithPhonePage",arguments: {
                                'actionType': 'register'
                              });
                            }
                          },
                          child: Obx(() => Text(
                              _controller.actionType.value == "register"?"Đăng nhập":"Đăng ký",
                            style: AppTextStyles.headline3.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorsConstants.kMainColor,
                              decoration: TextDecoration.underline,
                              decorationColor: ColorsConstants.kMainColor
                            )
                          ),),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Obx(() => Text(_controller.actionType.value == "register"?"Đăng ký bằng":"Đăng nhập bằng",
                          style: AppTextStyles.headline3.copyWith(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700
                          )
                        ),),
                        GestureDetector(
                          onTap: () {
                            if(_controller.actionType.value == "register") {
                              Get.toNamed('/registerPage');
                            } else {
                              Get.toNamed('/loginPage');
                            }
                          },
                          child: Text(
                            'Email',
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
          ),
        ),
      ),
    );
  }
}
