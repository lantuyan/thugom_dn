import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thu_gom/controllers/main/home/home_controller.dart';
import 'package:thu_gom/providers/category_provider.dart';
import 'package:thu_gom/providers/user_request_trash_provider.dart';
import 'package:thu_gom/repositories/category_reponsitory.dart';
import 'package:thu_gom/repositories/user_request_trash_reponsitory.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/views/main/home/tab/comfirmed_collector.dart';
import 'package:thu_gom/views/main/home/tab/request_collector.dart';

class HomeScreenCollector extends StatefulWidget {
  @override
  State<HomeScreenCollector> createState() => _HomeScreenCollectorState();
}

class _HomeScreenCollectorState extends State<HomeScreenCollector> {
  final HomeController _homeController = Get.put(HomeController(
      CategoryRepository(CategoryProvider()),
      UserRequestTrashRepository(UserRequestTrashProvider())));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsConstants.kBackgroundColor,
        body: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  color: ColorsConstants.kBGCardColor,
                  child: _userName(),
                ),
                SizedBox(
                  height: 8.h,
                ),
                // DANH SACH YÊU CẦU
                Padding(
                  padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.78,
                        child: DefaultTabController(
                          length: 2,
                          child: Column(
                            children: [
                              Container(
                                height: 50.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorsConstants.kBGCardColor,
                                ),
                                child: TabBar(
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicator: BoxDecoration(
                                    color: ColorsConstants.kActiveColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelColor: ColorsConstants.kBGCardColor,
                                  dividerColor: ColorsConstants.kActiveColor,
                                  tabs: [
                                    Tab(
                                      child: Container(
                                        width: 250.w,
                                        child: Text(
                                          "Yêu Cầu",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            fontFamily:
                                                AppTextStyles.fontFamily,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Container(
                                        width: 250.w,
                                        child: Text(
                                          "Đã Xử Lý",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            fontFamily:
                                                AppTextStyles.fontFamily,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: TabBarView(children: [
                                  listRequest(userController: _homeController),
                                  listComfirmed(
                                      userController: _homeController),
                                ]),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _userName() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.sp),
      child: Row(
        children: [
          SizedBox(
            width: 20.w,
          ),
          GestureDetector(
            onTap: () {
              _homeController.logOut(); // LOGOUT
            },
            child: Image.asset(
              'assets/images/user-avatar.png',
              height: 40.h,
              width: 40.w,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Obx(() {
            return Text(
              "Xin chào: ${_homeController.name.value}",
              style: AppTextStyles.headline1,
            );
          })
        ],
      ),
    );
  }
}




