import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thu_gom/controllers/main/analysis/analysis_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:thu_gom/providers/user_request_trash_provider.dart';
import 'package:thu_gom/repositories/user_request_trash_reponsitory.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/shared/themes/style/custom_button_style.dart';
import 'package:thu_gom/widgets/custom_dialogs.dart';
import 'package:thu_gom/widgets/header_userName.dart';

class AnalysisScreen extends StatefulWidget {
  @override
  _AnalysisScreen createState() => _AnalysisScreen();
}

class _AnalysisScreen extends State<AnalysisScreen> {
  final AnalysisController _analysisController = Get.put<AnalysisController>(
      AnalysisController(
          UserRequestTrashRepository(UserRequestTrashProvider())));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Container(
            color: ColorsConstants.kBGCardColor,
            child: userName(_analysisController.name.value),
          ),
        ),
      ),
      backgroundColor: ColorsConstants.ksecondBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.sp, 20, 24.sp, 20),
            child: FormBuilder(
              key: _analysisController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Xuất báo cáo ',
                      style: AppTextStyles.headline1.copyWith(fontSize: 24.sp),
                    ),
                  ),
                  SizedBox(height: 20.sp),
                  Text('Xuất báo cáo excel',
                      style: AppTextStyles.bodyText1.copyWith(fontSize: 16.sp)),
                  SizedBox(height: 10.sp),
                  Center(
                    child: Image.asset(
                      'assets/images/download_file.gif',
                      fit: BoxFit.cover,
                      width: 200.sp,
                      height: 200.sp,
                    ),
                  ),
                  SizedBox(height: 20.sp),
                  Text('Thời gian',
                      style: AppTextStyles.bodyText1.copyWith(fontSize: 16.sp)),
                  SizedBox(height: 20.sp),
                  Obx(() {
                    return FormBuilderDateRangePicker(
                      key: _analysisController.dateRangeFieldKey,
                      name: 'dateRange',
                      firstDate: DateTime(2020, 1, 1),
                      lastDate: DateTime.now(),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12.sp, 0, 12.sp, 0),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Thời gian thống kê',
                        labelStyle: AppTextStyles.bodyText1
                            .copyWith(color: ColorsConstants.kMainColor),
                        errorStyle: AppTextStyles.error,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: _analysisController
                                    .selectedDateRange.value !=
                                null
                            ? IconButton(
                                color: ColorsConstants.kMainColor,
                                icon: Icon(Icons.clear), // Icon xóa
                                onPressed: () {
                                  _analysisController.selectedDateRange.value =
                                      null; // Xóa dữ liệu đã chọn
                                  _analysisController
                                      .dateRangeFieldKey.currentState
                                      ?.reset();
                                },
                              )
                            : IconButton(
                                color: ColorsConstants.kMainColor,
                                icon: Icon(Icons.calendar_month),
                                onPressed: () {
                                  _analysisController
                                      .dateRangeFieldKey.currentState
                                      ?.focus();
                                },
                              ), // Nếu không có dữ liệu, không hiển thị icon xóa
                      ),
                      onChanged: (DateTimeRange? value) {
                        _analysisController.selectedDateRange.value = value;
                      },
                      style: AppTextStyles.bodyText1,
                    );
                  }),
                  SizedBox(height: 36.sp),
                  SizedBox(
                    width: ScreenUtil().screenWidth,
                    height: 48.sp,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_analysisController.selectedDateRange.value ==
                              null) {
                            CustomDialogs.showSnackBar(
                                2,
                                "Vui lòng chọn thời gian xuất báo cáo",
                                'error');
                          } else {
                            _analysisController.loadRequestByRange();
                          }
                        },
                        style: CustomButtonStyle.primaryButton,
                        child: Text(
                          'Xuất báo cáo',
                          style:
                              TextStyle(color: Colors.white, fontSize: 18.sp),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
