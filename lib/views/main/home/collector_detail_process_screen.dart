import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thu_gom/controllers/main/process_collector/collector_detail_process_controller.dart';
import 'package:thu_gom/controllers/main/request_person/request_person_controller.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/widgets/custom_dialogs.dart';

class CollectorDetailProcessScreen extends StatefulWidget {
  CollectorDetailProcessScreen({super.key});

  @override
  State<CollectorDetailProcessScreen> createState() =>
      _CollectorDetailProcessScreenState();
}

class _CollectorDetailProcessScreenState
    extends State<CollectorDetailProcessScreen> {
  final CollectorDetailProcessController _collectorDetailProcessController =
      Get.find<CollectorDetailProcessController>();

  final CarouselController _carouselController = CarouselController();
  final GetStorage _getStorage = GetStorage();
  late String zalonumber;
  late String address;

  @override
  void initState() {
    super.initState();
    zalonumber = _getStorage.read('zalonumber');
    address = _getStorage.read('address');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsConstants.kBackgroundColor,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: ColorsConstants.ksecondBackgroundColor,
          // elevation: 5,
          // shadowColor: ColorsConstants.kShadowColor,
          title: Text(
            "Minh chứng thu gom",
            style: AppTextStyles.caption.copyWith(fontSize: 16.sp),
          ),
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
                child: Obx(() {
                  if (_collectorDetailProcessController.loading.value) {
                    return CircularProgressIndicator(
                      color: ColorsConstants.kActiveColor,
                    );
                  } else {
                    return FormBuilder(
                      key: _collectorDetailProcessController.formKey,
                      child: Column(children: [
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: 'Minh chứng thu gom:  ',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              children: [
                                TextSpan(
                                  text: _collectorDetailProcessController
                                      .requestDetailModel.trash_type,
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
                                    if (_collectorDetailProcessController
                                            .imagePath.value ==
                                        "") {
                                      return Image.asset(
                                          'assets/images/chupanhminhchung.gif');
                                    } else {
                                      return _collectorDetailProcessController
                                          .imageWidget;
                                    }
                                  }),
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 30.sp,
                        ),
                        // Address Field
                        // FormBuilderTextField(
                        //   name: 'address',
                        //   enabled: false,
                        //   initialValue: _collectorDetailProcessController
                        //       .requestDetailModel.address,
                        //   decoration: InputDecoration(
                        //     contentPadding:
                        //         EdgeInsets.fromLTRB(12.sp, 0, 12.sp, 0),
                        //     filled: true,
                        //     fillColor: Colors.white,
                        //     labelText: 'Địa chỉ',
                        //     labelStyle: TextStyle(
                        //         fontSize: 16.sp,
                        //         color: ColorsConstants.kMainColor),
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //     disabledBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //         borderSide: BorderSide(
                        //             color: ColorsConstants.kMainColor, width: 2)),
                        //   ),
                        //   style: AppTextStyles.bodyText1.copyWith(
                        //     color: ColorsConstants
                        //         .kTextMainColor, // Màu cho giá trị initialValue
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 30.sp,
                        // ),
                        // FormBuilderTextField(
                        //   name: 'phonenumber',
                        //   enabled: false,
                        //   initialValue: _collectorDetailProcessController
                        //       .requestDetailModel.phone_number,
                        //   decoration: InputDecoration(
                        //     contentPadding:
                        //         EdgeInsets.fromLTRB(12.sp, 0, 12.sp, 0),
                        //     filled: true,
                        //     fillColor: Colors.white,
                        //     labelText: 'Số điẹn thoại/zalo liên hệ',
                        //     labelStyle: TextStyle(
                        //         fontSize: 16.sp,
                        //         color: ColorsConstants.kMainColor),
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //     disabledBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //         borderSide: BorderSide(
                        //             color: ColorsConstants.kMainColor, width: 2)),
                        //   ),
                        //   style: AppTextStyles.bodyText1.copyWith(
                        //     color: ColorsConstants
                        //         .kTextMainColor, // Màu cho giá trị initialValue
                        //   ),
                        // ),
                        // Amount Collected Field
                        FormBuilderTextField(
                          key: _collectorDetailProcessController
                              .amountCollectedFieldKey,
                          name: 'amount_collected',
                          minLines: 1,
                          maxLines: 3,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(12.sp, 10.sp, 12.sp, 10.sp),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Khối lượng rác thu gom',
                            labelStyle: TextStyle(
                                fontSize: 16.sp,
                                color: ColorsConstants.kMainColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: ColorsConstants.kMainColor,
                                    width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: ColorsConstants.kMainColor,
                                    width: 2)),
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
                        // Collection Price Field
                         FormBuilderTextField(
                      key: _collectorDetailProcessController.collectionPriceFieldKey,
                      name: 'collection_price',
                      minLines: 1,
                      maxLines: 3,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(12.sp, 10.sp, 12.sp, 10.sp),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Số tiền thu gom',
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
                                        // minimumSize: Size(65.sp, 65.sp),
                                        shape: CircleBorder(),
                                        padding: EdgeInsets.all(5.sp),
                                        backgroundColor:
                                            ColorsConstants.kBackgroundColor,
                                        elevation: 2,
                                      ),
                                      onPressed: () {
                                        _carouselController.animateToPage(0);
                                        _collectorDetailProcessController
                                            .getImageFromCamera();
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
                                      _collectorDetailProcessController
                                          .getImageFromGallery();
                                    },
                                    child: Icon(Icons.image_outlined,
                                        color: ColorsConstants.kMainColor,
                                        size: 36.sp),
                                    style: ElevatedButton.styleFrom(
                                      // minimumSize: Size(65.sp, 65.sp),
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
                              if (_collectorDetailProcessController
                                      .imagePath.value ==
                                  "") {
                                CustomDialogs.showSnackBar(
                                    3, "Vui lòng chụp ảnh", 'error');
                              } else if(_collectorDetailProcessController.formKey.currentState?.validate() == true) {
                                // _collectorDetailProcessController.amountCollected.value = _collectorDetailProcessController.amountCollectedFieldKey.currentState?.value;
                                // _collectorDetailProcessController.collectionPrice.value = _collectorDetailProcessController.collectionPriceFieldKey.currentState?.value;
                                CustomDialogs.confirmDialog(
                                    'Gửi Minh chứng',
                                    Text(
                                      'Gửi minh chứng này cho người dân?',
                                      style: AppTextStyles.bodyText1
                                          .copyWith(fontSize: 14.sp),
                                      textAlign: TextAlign.center,
                                    ), () async {
                                  await _collectorDetailProcessController
                                      .sendComfirmInfo(
                                    _collectorDetailProcessController.requestId,
                                    _collectorDetailProcessController.amountCollectedFieldKey.currentState?.value,
                                     _collectorDetailProcessController.collectionPriceFieldKey.currentState?.value,
                                  );
                                  await Get.offAllNamed('/mainPage');
                                });
                              }
                            },
                            child: Text(
                              'Gửi minh chứng',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsConstants.kMainColor,
                              padding: EdgeInsets.fromLTRB(
                                  20.sp, 10.sp, 20.sp, 10.sp),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        )
                      ]),
                    );
                  }
                }),
              ),
            ),
          ),
        ));
  }
}
