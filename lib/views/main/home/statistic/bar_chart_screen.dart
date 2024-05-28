import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:thu_gom/controllers/main/home/admin/chart/bar_chart_controller.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/shared/themes/style/custom_button_style.dart';
import 'package:thu_gom/widgets/indicator_widget.dart';

class BarChartScreen extends StatelessWidget {
  final BarChartController _barChartController = Get.find<BarChartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorsConstants.ksecondBackgroundColor,
        centerTitle: true,
        title: Text(
          'Biểu đồ cột',
          style: AppTextStyles.bodyText2.copyWith(
            fontSize: 22.sp,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: Obx(
          () {
            if (_barChartController.loading.value) {
              return Center(
                child: CircularProgressIndicator(
                  color: ColorsConstants.kMainColor,
                ),
              );
            } else if (_barChartController.barData.isEmpty) {
              return Padding(
                  padding: EdgeInsets.fromLTRB(10.sp, 10.sp, 10.sp, 10.sp),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(24.sp, 24.sp, 24.sp, 30.sp),
                    decoration: BoxDecoration(
                        color: ColorsConstants.ksecondBackgroundColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/empty_box.png',
                          height: ScreenUtil().screenHeight / 3,
                          width: ScreenUtil().screenHeight / 3,
                        ),
                        SizedBox(
                            height: 20), // Khoảng cách giữa hình ảnh và văn bản
                        Text(
                          'Dữ liệu thống kê theo ngày không vượt quá 7 ngày!',
                          textAlign: TextAlign.center,
                          style:
                              AppTextStyles.bodyText1.copyWith(fontSize: 16.sp),
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.sp),
                              )),
                        ),
                      ],
                    ),
                  ));
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.sp, 10.sp, 10.sp, 10.sp),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(24.sp, 24.sp, 24.sp, 30.sp),
                    decoration: BoxDecoration(
                        color: ColorsConstants.ksecondBackgroundColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Text('Biểu đồ thống kê loại rác',
                            style:
                                AppTextStyles.title.copyWith(fontSize: 18.sp)),
                        SizedBox(
                            height: ScreenUtil().screenHeight / 3,
                            width: ScreenUtil().screenWidth,
                            child: BarChart(
                              BarChartData(
                                  barTouchData: barTouchData,
                                  titlesData: titlesData,
                                  barGroups: barGroups,
                                  gridData: const FlGridData(show: true),
                                  alignment: BarChartAlignment.spaceAround,
                                  maxY: 20,
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 248, 183)),
                            )),
                        SizedBox(
                          height: 20.sp,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text('Thống kê số lượng yêu cầu',
                              style: AppTextStyles.title
                                  .copyWith(fontSize: 18.sp)),
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                              _barChartController.barData.length, (index) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: DateFormat('dd/MM/yy')
                                                .format(DateTime.parse(
                                                    _barChartController
                                                        .barData[index].date))
                                                .toString() +
                                            ": ",
                                        style: AppTextStyles.bodyText2
                                            .copyWith(fontSize: 16.sp)),
                                    TextSpan(
                                        text: _barChartController
                                            .barData[index].quantity
                                            .toString(),
                                        style: AppTextStyles.bodyText1.copyWith(
                                            fontSize: 18.sp,
                                            color: ColorsConstants.kMainColor)),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: 'Tổng yêu cầu: ',
                                style: AppTextStyles.bodyText1
                                    .copyWith(fontSize: 18.sp)),
                            TextSpan(
                                text: _barChartController.totalRequest
                                    .reduce((value, element) => value + element)
                                    .toString(),
                                style: AppTextStyles.bodyText1.copyWith(
                                    fontSize: 18.sp,
                                    color: ColorsConstants.kMainColor)),
                          ])),
                        ),
                        SizedBox(
                          height: 20.sp,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: 'Chưa xử lý: ',
                                style: AppTextStyles.bodyText1
                                    .copyWith(fontSize: 18.sp)),
                            TextSpan(
                                text: _barChartController.totalrequestPendingNumber.value.toString(),
                                style: AppTextStyles.bodyText1.copyWith(
                                    fontSize: 18.sp,
                                    color: ColorsConstants.kErorColor)),
                          ])),
                        ),
                        SizedBox(
                          height: 20.sp,
                        ),
                        // SizedBox(
                        //   width: ScreenUtil().screenWidth,
                        //   height: 48.sp,
                        //   child: ElevatedButton(
                        //       onPressed: () {},
                        //       style: CustomButtonStyle.primaryButton,
                        //       child: Text(
                        //         'Xuất báo cáo ',
                        //         style: TextStyle(
                        //             color: Colors.white, fontSize: 18.sp),
                        //       )),
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

BarTouchData get barTouchData => BarTouchData(
      enabled: false,
      touchTooltipData: BarTouchTooltipData(
        tooltipBgColor: Colors.transparent,
        tooltipPadding: EdgeInsets.zero,
        tooltipMargin: 8,
        getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
        ) {
          return BarTooltipItem(
            rod.toY.round().toString(),
            const TextStyle(
              color: ColorsConstants.kMainColor,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    );

Widget getTitles(double value, TitleMeta meta) {
  final style = TextStyle(
    color: ColorsConstants.kMainColor,
    fontWeight: FontWeight.bold,
    fontSize: 12.sp,
  );
  final BarChartController _barChartController = Get.find<BarChartController>();
  String text = '';

  for (int i = 0; i < _barChartController.dateList.length; i++) {
    if (value.toInt() == i) {
      text = _barChartController.dateList[i];
    }
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 4,
    child: Text(text, style: style),
  );
}

FlTitlesData get titlesData => const FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: getTitles,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );

LinearGradient get _barsGradient => LinearGradient(
      colors: [
        ColorsConstants.kActiveColor,
        Color.fromARGB(255, 101, 253, 185),
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );

List<BarChartGroupData> get barGroups {
  List<BarChartGroupData> groups = [];
  final BarChartController _barChartController = Get.find<BarChartController>();
  for (int i = 0; i < _barChartController.dateList.length; i++) {
    BarChartGroupData groupData = BarChartGroupData(
      x: i,
      barRods: [
        BarChartRodData(
          toY: _barChartController.totalRequest[i].toDouble(),
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    );
    groups.add(groupData);
  }
  return groups;
}
