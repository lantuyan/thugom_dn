import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thu_gom/controllers/main/request_detail/request_detail_controller.dart';
import 'package:get/get.dart';
import 'package:thu_gom/managers/data_manager.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/Themes.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/shared/themes/style/custom_button_style.dart';
import 'package:thu_gom/widgets/custom_dialogs.dart';

class RequestDetailScreen extends StatelessWidget {
  RequestDetailScreen({super.key});
  final RequestDetailController _requestDetailController =
      Get.find<RequestDetailController>();

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
              _requestDetailController.name.value,
              style: AppTextStyles.bodyText1.copyWith(
                  fontSize: 16.sp
              ),
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
                borderRadius: BorderRadius.circular(20)
              ),

              child: Obx((){
                if(_requestDetailController.loading.value){
                  return CircularProgressIndicator(
                    color: ColorsConstants.kMainColor,
                  );
                }else{
                  if(DataManager().getData('role') =='admin'){
                    //Admin
                    return AdminUI(requestDetailController: _requestDetailController);
                  }else if(_requestDetailController.userId.value != _requestDetailController.requestDetailModel.senderId){
                    //Collector
                    return CollectorUI(requestDetailController: _requestDetailController);
                  }else{
                    //Person
                    return PersonUI(requestDetailController: _requestDetailController);
                  }
                }
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class PersonUI extends StatelessWidget {
  const PersonUI({
    super.key,
    required RequestDetailController requestDetailController,
  }) : _requestDetailController = requestDetailController;

  final RequestDetailController _requestDetailController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                  text: _requestDetailController.requestDetailModel.trash_type,
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
        CachedNetworkImage(
          imageUrl: _requestDetailController.requestDetailModel.image,
          imageBuilder: (context, imageProvider) => Container(
            width: ScreenUtil().screenWidth * 0.5,
            height: ScreenUtil().screenWidth * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => CircularProgressIndicator(color: ColorsConstants.kMainColor,),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        SizedBox(
          height: 20.sp,
        ),
        // Description Field
        FormBuilderTextField(
          name: 'description',
          enabled: false,
          maxLines: 3,
          initialValue:_requestDetailController.requestDetailModel.description,
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
          ),
          style: AppTextStyles.bodyText1.copyWith(
            color: ColorsConstants.kTextMainColor, // Màu cho giá trị initialValue
          ),
        ),
        SizedBox(
          height: 30.sp,
        ),
        // Address Field
        FormBuilderTextField(
          name: 'address',
          enabled: false,
          initialValue:_requestDetailController.requestDetailModel.address,
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
          ),
          style: AppTextStyles.bodyText1.copyWith(
            color: ColorsConstants.kTextMainColor, // Màu cho giá trị initialValue
          ),
        ),
        SizedBox(
          height: 30.sp,
        ),
        FormBuilderTextField(
          name: 'phonenumber',
          enabled: false,
          initialValue: _requestDetailController.requestDetailModel.phone_number,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(12.sp, 0, 12.sp, 0),
            filled: true,
            fillColor: Colors.white,
            labelText: 'Số điẹn thoại/zalo liên hệ',
            labelStyle: TextStyle(
                fontSize: 16.sp, color: ColorsConstants.kMainColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: ColorsConstants.kMainColor, width: 2)),
          ),
          style: AppTextStyles.bodyText1.copyWith(
            color: ColorsConstants.kTextMainColor, // Màu cho giá trị initialValue
          ),
        ),
        SizedBox(
          height: 20.sp,
        ),
        Text(
          'Tình trạng thu gom',
            style: AppTextStyles.bodyText1.copyWith(
                fontSize: 16.sp
            )
        ),
        SizedBox(
          height: 10.sp,
        ),
        if (_requestDetailController.requestDetailModel.confirm != null)
          Row(
            children: [
              Expanded(
                  child: SizedBox(
                    height: 48.sp,
                    child: ElevatedButton(
                        onPressed: null,
                        style: CustomButtonStyle.primaryButton,
                        child: Text(
                          'Chờ xử lý',
                          style: TextStyle(
                              color: ColorsConstants.kTextMainColor, fontSize: 16.sp),
                        )
                    ),
                  )
              ),
              SizedBox(
                width: 20.sp,
              ),
              Expanded(
                  child: SizedBox(
                    height: 48.sp,
                    child: ElevatedButton(
                        onPressed: (){},
                        style: CustomButtonStyle.primaryButton,
                        child: Text(
                          'Hoàn thành',
                          style: TextStyle(
                              color: ColorsConstants.kBGCardColor,
                              fontSize: 16.sp),
                        )),
                  )),
            ],
          )
        else if (_requestDetailController.requestDetailModel.status != 'cancel')
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: SizedBox(
                        height: 48.sp,
                        child: ElevatedButton(
                            onPressed: () {},
                            style: CustomButtonStyle.primaryButton,
                            child: Text(
                              'Chờ xử lý',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.sp),
                            )
                        ),
                      )
                  ),
                  SizedBox(
                    width: 20.sp,
                  ),
                  Expanded(
                      child: SizedBox(
                        height: 48.sp,
                        child: ElevatedButton(
                            onPressed: null,
                            style: CustomButtonStyle.primaryButton,
                            child: Text(
                              'Hoàn thành',
                              style: TextStyle(
                                  color: ColorsConstants.kTextMainColor,
                                  fontSize: 16.sp),
                            )),
                      )),
                ],
              ),
              SizedBox(
                height: 20.sp,
              ),
              SizedBox(
                width: ScreenUtil().screenWidth,
                height: 48.sp,
                child: ElevatedButton(
                    onPressed: () {
                      CustomDialogs.confirmDialog(
                          'Xác nhận hủy',
                          Text(
                            'Bạn chắc chắn muốn hủy yêu cầu thu gom này?',
                            style: AppTextStyles.bodyText2.copyWith(
                                fontSize: 12.sp
                            ),
                            textAlign: TextAlign.center,
                          ),
                              (){
                            Get.back();
                            _requestDetailController.cancelRequest(_requestDetailController.requestId);
                          }
                      );
                    },
                    style: CustomButtonStyle.cancelButton,
                    child: Text(
                      'Hủy yêu cầu',
                      style: TextStyle(color: Colors.white, fontSize: 18.sp),
                    )),
              )
            ],
          )
        else
          SizedBox(
            width: ScreenUtil().screenWidth,
            height: 48.sp,
            child: ElevatedButton(
                onPressed: null,
                style: CustomButtonStyle.cancelButton,
                child: Text(
                  'Đã hủy yêu cầu',
                  style: TextStyle(color: ColorsConstants.kTextMainColor, fontSize: 18.sp),
                )),
          ),
      ],
    );
  }
}

class CollectorUI extends StatelessWidget {
  const CollectorUI({
    super.key,
    required RequestDetailController requestDetailController,
  }) : _requestDetailController = requestDetailController;

  final RequestDetailController _requestDetailController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: RichText(
            text: TextSpan(
              text: 'Chi tiết yêu cầu:  ',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: _requestDetailController.requestDetailModel.trash_type,
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
        CachedNetworkImage(
          imageUrl: _requestDetailController.requestDetailModel.image,
          imageBuilder: (context, imageProvider) => Container(
            width: ScreenUtil().screenWidth * 0.5,
            height: ScreenUtil().screenWidth * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => CircularProgressIndicator(color: ColorsConstants.kMainColor,),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        SizedBox(
          height: 20.sp,
        ),
        // Description Field
        FormBuilderTextField(
          name: 'description',
          enabled: false,
          maxLines: 3,
          initialValue:
          _requestDetailController.requestDetailModel.description,
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
          ),
          style: AppTextStyles.bodyText1.copyWith(
            color: ColorsConstants.kTextMainColor, // Màu cho giá trị initialValue
          ),
        ),
        SizedBox(
          height: 30.sp,
        ),
        // Address Field
        FormBuilderTextField(
          name: 'address',
          enabled: false,
          initialValue:_requestDetailController.requestDetailModel.address,
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
          ),
          style: AppTextStyles.bodyText1.copyWith(
            color: ColorsConstants.kTextMainColor, // Màu cho giá trị initialValue
          ),
        ),
        SizedBox(
          height: 30.sp,
        ),
        if(_requestDetailController.requestDetailModel.confirm == _requestDetailController.userId.value)
          Column(
            children: [
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Tình trạng thu gom:  ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Đã được thu gom',
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
                height: 48.sp,
                child: ElevatedButton(
                    onPressed: () {
                      CustomDialogs.contactDialog(
                        _requestDetailController.requestDetailModel.address,
                        _requestDetailController.requestDetailModel.phone_number,
                        _requestDetailController.requestDetailModel.phone_number,
                      );
                    },
                    style: CustomButtonStyle.primaryButton,
                    child: Text(
                      'Liên Hệ',
                      style: TextStyle(
                          color: Colors.white, fontSize: 16.sp),
                    )
                ),
              )
            ],
          )
        else
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: SizedBox(
                        height: 48.sp,
                        child: ElevatedButton(
                            onPressed: () {
                              CustomDialogs.contactDialog(
                                _requestDetailController.requestDetailModel.address,
                                _requestDetailController.requestDetailModel.phone_number,
                                _requestDetailController.requestDetailModel.phone_number,
                              );
                            },
                            style: CustomButtonStyle.primaryButton,
                            child: Text(
                              'Liên Hệ',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.sp),
                            )
                        ),
                      )
                  ),
                  SizedBox(
                    width: 20.sp,
                  ),
                  Expanded(
                      child: SizedBox(
                        height: 48.sp,
                        child: ElevatedButton(
                            onPressed: (){
                              if(_requestDetailController.allowHidden.value){
                                CustomDialogs.confirmDialog(
                                    'Xác nhận bỏ qua',
                                    Text(
                                      'Bạn chắc chắn muốn bỏ qua thu gom yêu cầu này?',
                                      style: AppTextStyles.bodyText2.copyWith(
                                          fontSize: 12.sp
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                        (){
                                      Get.back();
                                      _requestDetailController.hiddenRequest(_requestDetailController.requestDetailModel.requestId,_requestDetailController.requestDetailModel.hidden);
                                    }
                                );
                              }else{
                                null;
                              }
                            },
                            style: CustomButtonStyle.transparentButton,
                            child: Text(
                              'Bỏ qua',
                              style: TextStyle(
                                  color: ColorsConstants.kTextMainColor,
                                  fontSize: 16.sp),
                            )),
                      )),
                ],
              ),
              SizedBox(
                height: 20.sp,
              ),
              Obx(() {
                if(_requestDetailController.allowConfirm.value){
                  return SizedBox(
                    width: ScreenUtil().screenWidth,
                    height: 48.sp,
                    child: ElevatedButton(
                        onPressed: () {
                          CustomDialogs.confirmDialog(
                              'Xác nhận thu gom',
                              Text(
                                'Bạn chắc chắn muốn xác nhận thu gom yêu cầu này? Yêu cầu này sẽ được chuyển vào phần đã xử lý ',
                                style: AppTextStyles.bodyText2.copyWith(
                                    fontSize: 12.sp
                                ),
                                textAlign: TextAlign.center,
                              ),
                                  (){
                                Get.back();
                                _requestDetailController.confirmRequest(_requestDetailController.requestDetailModel.requestId,_requestDetailController.userId.value);
                              }
                          );
                        },
                        style: CustomButtonStyle.primaryButton,
                        child: Text(
                          'Xác nhận thu gom',
                          style:
                          TextStyle(color: Colors.white, fontSize: 18.sp),
                        )),
                  );
                }else{
                  return Container();
                }
              },)
            ],
          )
      ],
    );
  }
}

class AdminUI extends StatelessWidget {
  const AdminUI({
    super.key,
    required RequestDetailController requestDetailController,
  }) : _requestDetailController = requestDetailController;

  final RequestDetailController _requestDetailController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: RichText(
            text: TextSpan(
              text: 'Chi tiết yêu cầu:  ',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: _requestDetailController.requestDetailModel.trash_type,
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
        CachedNetworkImage(
          imageUrl: _requestDetailController.requestDetailModel.image,
          imageBuilder: (context, imageProvider) => Container(
            width: ScreenUtil().screenWidth * 0.5,
            height: ScreenUtil().screenWidth * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => CircularProgressIndicator(color: ColorsConstants.kMainColor,),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        SizedBox(
          height: 20.sp,
        ),
        // Description Field
        FormBuilderTextField(
          name: 'description',
          enabled: false,
          maxLines: 3,
          initialValue:
          _requestDetailController.requestDetailModel.description,
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
          ),
          style: AppTextStyles.bodyText1.copyWith(
            color: ColorsConstants.kTextMainColor, // Màu cho giá trị initialValue
          ),
        ),
        SizedBox(
          height: 30.sp,
        ),
        // Address Field
        FormBuilderTextField(
          name: 'address',
          enabled: false,
          initialValue:_requestDetailController.requestDetailModel.address,
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
          ),
          style: AppTextStyles.bodyText1.copyWith(
            color: ColorsConstants.kTextMainColor, // Màu cho giá trị initialValue
          ),
        ),
        SizedBox(
          height: 30.sp,
        ),
        if(_requestDetailController.requestDetailModel.confirm == _requestDetailController.userId.value)
          Column(
            children: [
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Tình trạng thu gom:  ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Đã được thu gom',
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
                height: 48.sp,
                child: ElevatedButton(
                    onPressed: () {
                      CustomDialogs.contactDialog(
                        _requestDetailController.requestDetailModel.address,
                        _requestDetailController.requestDetailModel.phone_number,
                        _requestDetailController.requestDetailModel.phone_number,
                      );
                    },
                    style: CustomButtonStyle.primaryButton,
                    child: Text(
                      'Liên Hệ',
                      style: TextStyle(
                          color: Colors.white, fontSize: 16.sp),
                    )
                ),
              )
            ],
          )
        else
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: SizedBox(
                        height: 48.sp,
                        child: ElevatedButton(
                            onPressed: () {
                              CustomDialogs.contactDialog(
                                _requestDetailController.requestDetailModel.address,
                                _requestDetailController.requestDetailModel.phone_number,
                                _requestDetailController.requestDetailModel.phone_number,
                              );
                            },
                            style: CustomButtonStyle.primaryButton,
                            child: Text(
                              'Liên Hệ',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.sp),
                            )
                        ),
                      )
                  ),
                ],
              ),
              SizedBox(
                height: 20.sp,
              ),
            ],
          )
      ],
    );
  }
}
