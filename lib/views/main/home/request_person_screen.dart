import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:thu_gom/controllers/main/request_person/request_person_controller.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/widgets/custom_dialogs.dart';

class RequestPersonScreen extends StatelessWidget {
  RequestPersonScreen({super.key});
  final RequestPersonController _requestPersonController =
      Get.find<RequestPersonController>();
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsConstants.kBackgroundColor,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: ColorsConstants.ksecondBackgroundColor,
          // elevation: 5,
          // shadowColor: ColorsConstants.kShadowColor,
          title: Obx(() => Text(
                _requestPersonController.name.value,
                style: AppTextStyles.bodyText1.copyWith(fontSize: 16.sp),
              )),
          centerTitle: true, // Đảm bảo title được căn giữa
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.sp, 10.sp, 10.sp, 10.sp),
              child: Container(
                padding: EdgeInsets.fromLTRB(24.sp, 24.sp, 24.sp, 30.sp),
                decoration: BoxDecoration(
                    color: ColorsConstants.ksecondBackgroundColor,
                    borderRadius: BorderRadius.circular(20)),

                // child: Obx((){
                //   if(_requestPersonController.loading.value){
                //     return CircularProgressIndicator();
                //   }else{
                //     if(_requestPersonController.userId.value != _requestPersonController.requestDetailModel.senderId){
                //       //Collector
                //       return CollectorUI(requestDetailController: _requestPersonController);
                //     }else{
                //       //Person
                //       return PersonUI(requestDetailController: _requestPersonController);
                //     }
                //   }
                // }),
                child: FormBuilder(
                  key: _requestPersonController.formKey,
                  child: Column(children: [
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'Đăng ký thu gom:  ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: _requestPersonController.title,
                              style: TextStyle(
                                color: ColorsConstants.kMainColor,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Container(
                        height: 205.sp,
                        width: 205.sp,
                        // color: ColorsConstants.kBackgroundColor,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.sp),
                            color: ColorsConstants.kActiveColor),
                        child: Center(
                          child: SizedBox(
                            height: 200.sp,
                            width: 200.sp,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18.sp),
                              child: Obx(() {
                                if (_requestPersonController.imagePath.value ==
                                    "") {
                                  return Image.asset(
                                      'assets/images/scan_guide.gif');
                                } else {
                                  return _requestPersonController.imageWidget;
                                }
                              }),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 30.sp,
                    ),
                    // Description Field
                    FormBuilderTextField(
                      key: _requestPersonController.desriptionFieldKey,
                      name: 'description',
                      minLines: 1,
                      maxLines: 3,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(12.sp, 10.sp, 12.sp, 10.sp),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Mô tả',
                        labelStyle: TextStyle(
                            fontSize: 16.sp, color: ColorsConstants.kMainColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: ColorsConstants.kMainColor, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: ColorsConstants.kMainColor, width: 2)),
                      ),
                      style: AppTextStyles.bodyText1.copyWith(
                        color: ColorsConstants
                            .kTextMainColor, // Màu cho giá trị initialValue
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "Không được để trống trường này"),
                      ]),
                    ),
                    SizedBox(
                      height: 30.sp,
                    ),
                    // Address Field
                    FormBuilderTextField(
                      key: _requestPersonController.addressFieldKey,
                      name: 'address',
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12.sp, 0, 12.sp, 0),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Địa chỉ',
                        labelStyle: TextStyle(
                            fontSize: 16.sp, color: ColorsConstants.kMainColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: ColorsConstants.kMainColor, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: ColorsConstants.kMainColor, width: 2)),
                      ),
                      style: AppTextStyles.bodyText1.copyWith(
                        color: ColorsConstants
                            .kTextMainColor, // Màu cho giá trị initialValue
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "Không được để trống trường này"),
                      ]),
                    ),
                    SizedBox(
                      height: 30.sp,
                    ),
                    FormBuilderTextField(
                      key: _requestPersonController.phoneNumberFieldKey,
                      name: 'phonenumber',
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12.sp, 0, 12.sp, 0),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Số điện thoại/zalo liên hệ',
                        labelStyle: TextStyle(
                            fontSize: 16.sp, color: ColorsConstants.kMainColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: ColorsConstants.kMainColor, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: ColorsConstants.kMainColor, width: 2)),
                      ),
                      style: AppTextStyles.bodyText1.copyWith(
                        color: ColorsConstants
                            .kTextMainColor, // Màu cho giá trị initialValue
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "Không được để trống trường này"),
                        FormBuilderValidators.maxLength(11,
                            errorText: "Số điện thoại không hợp lệ"),
                        FormBuilderValidators.numeric(
                            errorText: "Số điện thoại không hợp lệ"),
                      ]),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.sp),
                        child: SingleChildScrollView(
                          child: CarouselSlider(
                            carouselController: _carouselController,
                            items: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(65.sp, 65.sp),
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(5.sp),
                                    backgroundColor:
                                        ColorsConstants.kBackgroundColor,
                                    elevation: 2,
                                  ),
                                  onPressed: () {
                                    _carouselController.animateToPage(0);
                                    _requestPersonController.getImageFromCamera();
                                  },
                                  child: SvgPicture.asset(
                                    'assets/icons/ic_scan.svg',
                                    colorFilter: ColorFilter.mode(
                                        ColorsConstants.kMainColor,
                                        BlendMode.srcIn),
                                    width: 40.sp,
                                    height: 40.sp,
                                  )),
                              ElevatedButton(
                                onPressed: () {
                                  _carouselController.animateToPage(1);
                                  _requestPersonController.getImageFromGallery();
                                },
                                child: Icon(Icons.image_outlined,
                                    color: ColorsConstants.kMainColor,
                                    size: 36.sp),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(65.sp, 65.sp),
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(5.sp),
                                  backgroundColor:
                                      ColorsConstants.kBackgroundColor,
                                  elevation: 2,
                                ),
                              )
                            ],
                            options: CarouselOptions(
                                height: 65.sp,
                                enlargeCenterPage: true,
                                viewportFraction: 0.3,
                                enableInfiniteScroll: false),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20.sp,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          _requestPersonController.formKey.currentState
                              ?.saveAndValidate();

                          if (_requestPersonController.imagePath.value == "") {
                            CustomDialogs.showSnackBar(
                                3, "Vui lòng chụp ảnh", 'error');
                          } else if (_requestPersonController
                                  .formKey.currentState
                                  ?.validate() ==
                              true) {
                            _requestPersonController.description.value =
                                _requestPersonController
                                    .desriptionFieldKey.currentState?.value;
                            _requestPersonController.phoneNumber.value =
                                _requestPersonController
                                    .phoneNumberFieldKey.currentState?.value;
                            _requestPersonController.address.value =
                                _requestPersonController
                                    .addressFieldKey.currentState?.value;

                            _requestPersonController.sendRequestToAppwrite();
                          }
                        },
                        child: Text(
                          'Gửi yêu cầu',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsConstants.kMainColor,
                          padding:
                              EdgeInsets.fromLTRB(20.sp, 10.sp, 20.sp, 10.sp),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ),
          ),
        ));
  }
}
