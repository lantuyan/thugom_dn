import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:thu_gom/controllers/profile/profile_controller.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/Themes.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/shared/themes/style/custom_button_style.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController _profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.transparent,
        margin: EdgeInsets.only(bottom: 40.sp),
        padding: EdgeInsets.fromLTRB(24.sp, 20.sp, 24.sp, 0),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _profileController.formKey,
            child: Obx((){
              if(_profileController.isLoading.value){
                return Center(child: CircularProgressIndicator(color: ColorsConstants.kMainColor,));
              }else{
                return Column(
                  children: [
                    SizedBox(
                      height: 80.sp,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Bước 2/2",
                            style: AppTextStyles.headline1,
                          ),
                          SizedBox(height: 8.sp),
                          Text(
                            "Nhập thông tin",
                            style: TextStyle(
                              fontSize: 32.sp,
                              fontFamily: AppTextStyles.fontFamily,
                              fontWeight: FontWeight.w700,
                              color: ColorsConstants.kMainColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.sp,),
                    // Name Field
                    FormBuilderTextField(
                      key: _profileController.nameFieldKey,
                      name: 'name',
                      style: AppTextStyles.bodyText1,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12.sp, 0, 12.sp, 0),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Tên đầy đủ',
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
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(errorText: "Không được để trống trường này"),
                      ]),
                    ),
                    SizedBox(height: 30.sp),
                    // Phone number Field
                    FormBuilderTextField(
                      key: _profileController.phonenumberFieldKey,
                      initialValue: _profileController.phonenumber,
                      onChanged: (value) {
                        print(_profileController.phonenumberFieldKey.currentState?.value);
                        _profileController.zalonumberFieldKey.currentState?.setValue(value);
                        print(_profileController.zalonumberFieldKey.currentState?.value);
                      },
                      name: 'phonenumber',
                      style: AppTextStyles.bodyText1,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12.sp, 0, 12.sp, 0),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Số điện thoại',
                        labelStyle: AppTextStyles.bodyText1.copyWith(
                            color: ColorsConstants.kMainColor
                        ),
                        hintText: 'Nhập số điện thoại',
                        hintStyle: AppTextStyles.bodyText1.copyWith(
                            color: ColorsConstants.kTextSecondColor
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
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(errorText: "Không được để trống trường này"),
                        FormBuilderValidators.maxLength(13,errorText: "Số điện thoại không hợp lệ"),
                        FormBuilderValidators.numeric(errorText: "Số điện thoại không hợp lệ"),
                      ]),
                    ),
                    SizedBox(height: 30.sp),
                    // Zalo number Field
                    FormBuilderTextField(
                      key: _profileController.zalonumberFieldKey,
                      initialValue: _profileController.phonenumber??'',
                      name: 'zalonumber',
                      style: AppTextStyles.bodyText1,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12.sp, 0, 12.sp, 0),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Tài khoản zalo',
                        labelStyle: AppTextStyles.bodyText1.copyWith(
                            color: ColorsConstants.kMainColor
                        ),
                        hintText: 'Nhập số điện thoại đăng ký zalo ',
                        hintStyle: AppTextStyles.bodyText1.copyWith(
                            color: ColorsConstants.kTextSecondColor
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
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(errorText: "Không được để trống trường này"),
                        FormBuilderValidators.maxLength(13,errorText: "Số điện thoại không hợp lệ"),
                        FormBuilderValidators.numeric(errorText: "Số điện thoại không hợp lệ"),
                      ]),
                    ),
                    SizedBox(height: 26.sp),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Địa chỉ', style: AppTextStyles.title.copyWith(
                            fontSize: 16.sp
                        ),)
                    ),
                    SizedBox(height: 16.sp),
                    Row(
                      children: [
                        Expanded(
                            child: DropdownButtonFormField(
                              value: _profileController.selectedDistrict.value,
                              isExpanded: true,
                              style: AppTextStyles.bodyText1,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(12.sp, 0, 12.sp, 0),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Quận, huyện',
                                hintStyle: AppTextStyles.bodyText1?.copyWith(
                                    color: ColorsConstants.kMainColor
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: ColorsConstants.kMainColor, width: 2)),
                              ),
                              items: _profileController.districts.map((district) {
                                return DropdownMenuItem(
                                  value: district,
                                  child: Tooltip(
                                    message: district, // Hiển thị toàn bộ văn bản khi người dùng di chuyển con trỏ chuột qua mục
                                    child: Text(
                                      district,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                _profileController.selectedDistrict.value = newValue.toString();
                                if(_profileController.subDistricts[_profileController.selectedDistrict.value] != null){
                                  _profileController.selectedSubDistrict.value = _profileController.subDistricts[_profileController.selectedDistrict.value]!.first;
                                }else{
                                  _profileController.selectedSubDistrict.value ='';
                                }
                              },
                            )
                        ),
                        SizedBox(width: 16.sp,),
                        Expanded(
                            child: Obx(() => DropdownButtonFormField(
                                value: _profileController.selectedSubDistrict.value ?? '',
                                isExpanded: true,
                                isDense: true,
                                style: AppTextStyles.bodyText1,
                                // value: _profileController.selectedSubDistrict,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(12.sp, 0, 12.sp, 0),
                                  fillColor: Colors.white,
                                  hintText: 'Quận, huyện',
                                  hintStyle: AppTextStyles.bodyText1?.copyWith(
                                      color: ColorsConstants.kMainColor
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: ColorsConstants.kMainColor, width: 2)),
                                ),
                                items: [
                                  ...(_profileController.subDistricts[_profileController.selectedDistrict.value] ?? [])
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Tooltip(
                                        message: value, // Hiển thị toàn bộ văn bản khi người dùng di chuyển con trỏ chuột qua mục
                                        child: Text(
                                          value,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    );
                                  })
                                ],
                                onChanged: (newValue) {
                                  _profileController.selectedSubDistrict.value = newValue.toString();
                                }
                            ),)
                        )
                      ],
                    ),
                    SizedBox(height: 20.sp),
                    // Street Field
                    FormBuilderTextField(
                      key: _profileController.streetFieldKey,
                      name: 'street',
                      style: AppTextStyles.bodyText1,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12.sp, 0, 12.sp, 0),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Số nhà, đường',
                        hintText: 'Nhập số nhà và tên đường',
                        hintStyle: AppTextStyles.bodyText1.copyWith(
                            color: ColorsConstants.kTextSecondColor
                        ),
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
                      ]),
                      // style: AppTextStyles.bodyText1,
                    ),
                    SizedBox(height: 46.sp),
                    SizedBox(
                      width:  ScreenUtil().screenWidth,
                      height: 48.sp,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_profileController.formKey.currentState!.saveAndValidate()) {
                              _profileController.updateProfile(_profileController.formKey.currentState!.value);
                            }
                          },
                          style: CustomButtonStyle.primaryButton,
                          child: Text(
                            'Đến trang chủ',
                            style: TextStyle(color: Colors.white, fontSize: 18.sp),
                          )
                      ),
                    ),
                  ],
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
