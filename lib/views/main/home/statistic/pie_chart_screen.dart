import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:thu_gom/controllers/main/home/admin/chart/pie_chart_controller.dart';
import 'package:thu_gom/models/chart/pie_chart_model.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/shared/themes/style/custom_button_style.dart';
import 'package:thu_gom/widgets/indicator_widget.dart';

class PieChartScreen extends StatelessWidget {
  final PieChartController _pieChartController = Get.find<PieChartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorsConstants.ksecondBackgroundColor,
        centerTitle: true,
        title: Text('Biểu đồ bánh',style: AppTextStyles.bodyText2.copyWith(
          fontSize: 22.sp,
        ),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: Obx((){
          if(_pieChartController.loading.value){
            return Center(child: CircularProgressIndicator(color: ColorsConstants.kMainColor,),);
          }else if(_pieChartController.pieData.isEmpty){
            return Padding(
              padding: EdgeInsets.fromLTRB(10.sp, 10.sp, 10.sp, 10.sp),
              child: Container(
                padding: EdgeInsets.fromLTRB(24.sp, 24.sp, 24.sp, 30.sp),
                decoration: BoxDecoration(
                  color: ColorsConstants.ksecondBackgroundColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/empty_box.png',
                      height: ScreenUtil().screenHeight/3,
                      width: ScreenUtil().screenHeight/3,
                    ),
                    SizedBox(height: 20), // Khoảng cách giữa hình ảnh và văn bản
                    Text(
                      'Dữ liệu thống kê các loại rác thải trong ngày bạn chọn hiện chưa có dữ liệu',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyText1.copyWith(
                        fontSize: 16.sp
                      ),
                    ),
                    SizedBox(height: 20.sp),
                    SizedBox(
                      width: ScreenUtil().screenWidth,
                      height: 48.sp,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: CustomButtonStyle.primaryButton,
                          child: Text(
                            'Chọn lại ',
                            style: TextStyle(color: Colors.white, fontSize: 18.sp),
                          )
                      ),
                    ),

                  ],
                ),
              )
            );
          }else{
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10.sp, 10.sp, 10.sp, 10.sp),
                child: Container(
                  padding: EdgeInsets.fromLTRB(24.sp, 24.sp, 24.sp, 30.sp),
                  decoration: BoxDecoration(
                      color: ColorsConstants.ksecondBackgroundColor,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    children: [
                      Text('Biểu đồ thống kê loại rác', style: AppTextStyles.title.copyWith(fontSize: 18.sp)),
                      SizedBox(
                        height: ScreenUtil().screenHeight/3,
                        width: ScreenUtil().screenWidth,
                        child: PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    _pieChartController.touchedIndex.value = -1;
                                    return;
                                  }
                                  _pieChartController.touchedIndex.value = pieTouchResponse.touchedSection!.touchedSectionIndex;
                              },
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 40.sp,
                            sections: showingSections(),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.sp,),
                      ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                          (_pieChartController.pieData.length / 2).ceil(), // Số hàng cần hiển thị
                              (index) {
                            final firstIndex = index * 2;
                            final secondIndex = firstIndex + 1;
                            return Row(
                              children: [
                                if (firstIndex < _pieChartController.pieData.length)
                                  Container(
                                    child: Indicator(color: _pieChartController.pieData[firstIndex].color, text: _pieChartController.pieData[firstIndex].name, isSquare: true,),
                                  ),
                                if (secondIndex < _pieChartController.pieData.length)
                                  SizedBox(width: 10), // Khoảng cách giữa các item
                                if (secondIndex < _pieChartController.pieData.length)
                                  Container(
                                    child: Indicator(color: _pieChartController.pieData[secondIndex].color, text: _pieChartController.pieData[secondIndex].name, isSquare: true,),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20.sp,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('Thống kê số lượng yêu cầu',
                            style: AppTextStyles.title.copyWith(
                                fontSize: 18.sp
                            )
                        ),
                      ),
                      SizedBox(height: 10.sp,),
                      ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(_pieChartController.pieData.length, (index) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: _pieChartController.pieData[index].name.toString()+": ",
                                      style: AppTextStyles.bodyText2.copyWith(
                                        fontSize: 16.sp
                                      )
                                  ),
                                  TextSpan(
                                    text: _pieChartController.pieData[index].quantity.toString(),
                                      style: AppTextStyles.bodyText1.copyWith(
                                        fontSize: 16.sp,
                                        color: ColorsConstants.kMainColor
                                      )
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 10.sp,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Tổng yêu cầu: ',
                                  style: AppTextStyles.bodyText1.copyWith(
                                      fontSize: 18.sp
                                  )
                              ),
                              TextSpan(
                                  text: _pieChartController.total.value.toString(),
                                  style: AppTextStyles.bodyText1.copyWith(
                                      fontSize: 18.sp,
                                      color: ColorsConstants.kMainColor
                                  )
                              ),
                            ]
                          )
                        ),
                      ),
                      SizedBox(height: 20.sp,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Chưa xử lý: ',
                                  style: AppTextStyles.bodyText1.copyWith(
                                      fontSize: 18.sp
                                  )
                              ),
                              TextSpan(
                                  text: _pieChartController.totalPending.value.toString(),
                                  style: AppTextStyles.bodyText1.copyWith(
                                      fontSize: 18.sp,
                                      color: ColorsConstants.kErorColor
                                  )
                              ),
                            ]
                          )
                        ),
                      ),
                      SizedBox(height: 20.sp,),
                      // SizedBox(
                      //   width: ScreenUtil().screenWidth,
                      //   height: 48.sp,
                      //   child: ElevatedButton(
                      //       onPressed: () {

                      //       },
                      //       style: CustomButtonStyle.primaryButton,
                      //       child: Text(
                      //         'Xuất báo cáo ',
                      //         style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      //       )
                      //   ),
                      // ),
                    ]
                  )
                ),
              ),
            );
          }
        }),
      ),

    );
  }
  List<PieChartSectionData> showingSections() {
    return _pieChartController.pieData.asMap().map<int,PieChartSectionData>((index, value){
      final isTouched = index == _pieChartController.touchedIndex.value;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 100.0 : 80.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 1)];
      final data = PieChartSectionData(
        value: value.percent,
        color: value.color,
        title: '${value.percent}%',
        titleStyle: AppTextStyles.bodyText1.copyWith(
          fontSize: fontSize,
          shadows: shadows,
        ),
        radius: radius,

      );
      return MapEntry(index, data);
    }).values.toList();
  }
}