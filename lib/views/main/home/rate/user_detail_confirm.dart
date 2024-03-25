import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thu_gom/controllers/main/request_detail/request_detail_controller.dart';
import 'package:get/get.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/shared/themes/style/custom_button_style.dart';
import 'package:thu_gom/widgets/custom_dialogs.dart';

class UserDetailConfirmScreen extends StatelessWidget {
  UserDetailConfirmScreen({super.key});
  final RequestDetailController _requestDetailController =
      Get.find<RequestDetailController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.kBackgroundColor,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: ColorsConstants.ksecondBackgroundColor,
        title: Obx(() => Text(
              _requestDetailController.name.value,
              style: AppTextStyles.bodyText1.copyWith(fontSize: 16.sp),
            )),
        centerTitle: true, // Đảm bảo title được căn giữa
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAllNamed('/mainPage');
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
                if (_requestDetailController.loading.value) {
                  return CircularProgressIndicator(
                    color: ColorsConstants.kMainColor,
                  );
                } else {
                  return PersonUI(
                      requestDetailController: _requestDetailController);
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
    late double rating = 0;
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
          placeholder: (context, url) => CircularProgressIndicator(
            color: ColorsConstants.kMainColor,
          ),
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
          initialValue: _requestDetailController.requestDetailModel.description,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(12.sp, 10.sp, 12.sp, 10.sp),
            filled: true,
            fillColor: Colors.white,
            labelText: 'Mô tả',
            labelStyle:
                TextStyle(fontSize: 16.sp, color: ColorsConstants.kMainColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    BorderSide(color: ColorsConstants.kMainColor, width: 2)),
          ),
          style: AppTextStyles.bodyText1.copyWith(
            color:
                ColorsConstants.kTextMainColor, // Màu cho giá trị initialValue
          ),
        ),
        SizedBox(
          height: 10.sp,
        ),
        Center(
          child: Text(
            "Đánh giá dịch vụ",
            style: AppTextStyles.caption,
          ),
        ),
        SizedBox(
          height: 10.sp,
        ),
        Center(
          child: RatingBar(
            minRating: 1,
            maxRating: 5,
            initialRating: 3,
            allowHalfRating: true,
            ratingWidget: RatingWidget(
                full: Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                empty: Icon(
                  Icons.star,
                  color: Colors.grey,
                ),
                half: Icon(
                  Icons.star_half,
                  color: Colors.amber,
                )),
            onRatingUpdate: (double value) {
              rating = value;
              print(">>>>>>> RATING NUMBER: ${rating}");
            },
          ),
        ),
        SizedBox(
          height: 30.sp,
        ),
        SizedBox(
          width: ScreenUtil().screenWidth,
          height: 48.sp,
          child: ElevatedButton(
              onPressed: () {
                CustomDialogs.confirmDialog(
                    'Gửi đánh giá',
                    Text(
                      'Gửi đánh giá này cho chúng tôi?',
                      style: AppTextStyles.bodyText2.copyWith(fontSize: 12.sp),
                      textAlign: TextAlign.center,
                    ), () async {
                  await _requestDetailController
                      .userRating(_requestDetailController.requestId, rating);
                  await Get.offAllNamed('/mainPage');
                });
                print(">>>>>>VALUES: ${rating}");
              },
              style: CustomButtonStyle.cancelButton,
              child: Text(
                'Gửi đánh giá',
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              )),
        ),
      ],
    );
  }
}
