import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:thu_gom/controllers/main/home/admin/home_admin_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/shared/themes/style/custom_button_style.dart';
import 'package:thu_gom/widgets/custom_dialogs.dart';

class HomeAdminScreen extends StatefulWidget {
  @override
  _HomeAdminScreenState createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  final HomeAdminController _homeAdminController =
      Get.put<HomeAdminController>(HomeAdminController());
  final List<RxBool> _pressedList = [
    false.obs,
    false.obs,
    false.obs,
  ];
  @override
  Widget build(BuildContext context) {
    bool _pressed = false;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.sp, 20, 24.sp, 20),
            child: FormBuilder(
              key: _homeAdminController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Thống kê ',
                      style: AppTextStyles.headline1.copyWith(fontSize: 24.sp),
                    ),
                  ),
                  SizedBox(height: 20.sp),
                  Text('Biểu đồ',
                      style: AppTextStyles.bodyText1.copyWith(
                          fontSize: 16.sp
                      )
                  ),
                  SizedBox(height: 10.sp),
                  CarouselSlider(
                    carouselController: _homeAdminController.carouselController,
                    options: CarouselOptions(
                      aspectRatio: 1.2,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      onPageChanged: (index, reason) {
                        _homeAdminController.currentIndex.value = index;
                      },
                      // enableInfiniteScroll: false,
                      scrollPhysics:NeverScrollableScrollPhysics()
                    ),
                    items: _homeAdminController.images.map((imagePath) {
                      return Builder(
                        builder: (BuildContext context) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Obx(() => IconButton(
                            iconSize: 42.sp,
                            onPressed: () {
                              _homeAdminController.currentIndex.value = 0;
                              _homeAdminController.carouselController.animateToPage(_homeAdminController.currentIndex.value,curve: Curves.easeInOut);
                              _homeAdminController.chartType.value = 'bar';
                            },
                            icon: Tooltip(
                              message: 'Biểu đồ cột',
                              child: Icon(Icons.bar_chart),
                            ),
                            color: _homeAdminController.currentIndex.value == 0 ? ColorsConstants.kMainColor : Colors.grey,
                          ),
                          ),
                          Text('Cột',
                              style: AppTextStyles.bodyText1.copyWith(
                                  fontSize: 14.sp
                              )
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Obx(() => IconButton(
                            iconSize: 42.sp,
                              onPressed: () {
                                _homeAdminController.currentIndex.value = 1;
                                _homeAdminController.carouselController.animateToPage(_homeAdminController.currentIndex.value,curve: Curves.easeInOut);
                                _homeAdminController.chartType.value = 'line';
                                },
                              icon: Tooltip(
                                message: 'Biểu đồ đường',
                                child: Icon(Icons.stacked_line_chart),
                              ),
                              color: _homeAdminController.currentIndex.value == 1 ? ColorsConstants.kMainColor : Colors.grey,
                            ),),
                          Text('Đường',
                              style: AppTextStyles.bodyText1.copyWith(
                                  fontSize: 14.sp
                              )
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Obx(() => IconButton(
                            iconSize: 42.sp,
                              onPressed: () {
                                _homeAdminController.currentIndex.value = 2;
                                _homeAdminController.carouselController.animateToPage(_homeAdminController.currentIndex.value,curve: Curves.easeInOut);
                                _homeAdminController.chartType.value = 'pie';
                                },
                              icon: Tooltip(
                                message: 'Biểu đồ Bánh',
                                  child: Icon(Icons.pie_chart)
                              ),
                              color: _homeAdminController.currentIndex.value == 2 ? ColorsConstants.kMainColor : Colors.grey,
                            ),),
                          Text('Bánh',
                              style: AppTextStyles.bodyText1.copyWith(
                                  fontSize: 14.sp
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.sp),
                  Text('Thời gian',
                      style: AppTextStyles.bodyText1.copyWith(
                          fontSize: 16.sp
                      )
                  ),
                  SizedBox(height: 10.sp),
                  FormBuilderDateRangePicker(
                    key: _homeAdminController.dateRangeFieldKey,
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
                      suffixIcon: _homeAdminController.selectedDateRange.value != null
                          ? IconButton(
                              color: ColorsConstants.kMainColor,
                              icon: Icon(Icons.clear), // Icon xóa
                              onPressed: () {
                                _homeAdminController.selectedDateRange.value = null; // Xóa dữ liệu đã chọn
                                _homeAdminController
                                    .dateRangeFieldKey.currentState
                                    ?.reset();
                              },
                            )
                          : IconButton(
                            color: ColorsConstants.kMainColor,
                            icon: Icon(Icons.calendar_month), // Icon xóa
                            onPressed: () {
                              _homeAdminController.dateRangeFieldKey.currentState?.focus();
                            },
                          ), // Nếu không có dữ liệu, không hiển thị icon xóa
                    ),
                    onChanged: (DateTimeRange? value) {
                      _homeAdminController.selectedDateRange.value = value;
                    },
                    style: AppTextStyles.bodyText1,
                  ),
                  SizedBox(height: 36.sp),
                  SizedBox(
                    width:  ScreenUtil().screenWidth,
                    height: 48.sp,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(24.sp, 0.sp, 24.sp, 0),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_homeAdminController.selectedDateRange.value ==
                                null) {
                              CustomDialogs.showSnackBar(
                                  2, "Vui lòng chọn thời gian thống kê", 'error');
                            } else {
                              switch (_homeAdminController.chartType.value) {
                                case 'bar':
                                  Get.toNamed('/barChartPage',arguments: {
                                    'dateRange': _homeAdminController.selectedDateRange.value
                                  });
                                  break;
                                case 'line':
                                  Get.toNamed('/lineChartPage',arguments: {
                                    'dateRange': _homeAdminController.selectedDateRange.value
                                  });
                                  break;
                                case 'pie':
                                  Get.toNamed('/pieChartPage',arguments: {
                                    'dateRange': _homeAdminController.selectedDateRange.value
                                  });
                                  break;
                                default:
                                  CustomDialogs.showSnackBar(2, "Đã có lỗi xảy ra vui lòng thử lại sau!", 'error');
                              }
                            }
                          },
                          style: CustomButtonStyle.primaryButton,
                          child: Text(
                            'Xem thống kê',
                            style: TextStyle(
                                color: Colors.white, fontSize: 18.sp),
                          )
                      ),
                    ),
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
