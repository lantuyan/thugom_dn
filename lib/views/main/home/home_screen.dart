import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/views/main/home/detail_trash.dart';
import 'package:thu_gom/widgets/dot_widget.dart';
import 'package:thu_gom/widgets/item_requestTrash.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                // ĐĂNG KÝ THU GOM
                Card(
                  color: ColorsConstants.kBGCardColor,
                  margin:
                      EdgeInsets.only(left: 10.sp, right: 10.sp, bottom: 10.sp),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 8.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 4.sp,
                                right: 4.sp,
                                bottom: 4.sp,
                                top: 8.sp),
                            child: Text(
                              "Đăng ký thu gom",
                              style: AppTextStyles.title,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      _TrashItem("assets/images/trash_wooden.png",
                          "Rác cồng kềnh", "hihihi"),
                      SizedBox(
                        height: 4.h,
                      ),
                      _TrashItem("assets/images/trash_metal.png",
                          "Rác xây dựng", "hihihi"),
                      SizedBox(
                        height: 4.h,
                      ),
                      _TrashItem("assets/images/trash_paper.png", "Rác tái chế",
                          "hihihi"),
                      SizedBox(
                        height: 4.h,
                      ),
                      _TrashItem("assets/images/trash_rubber.png", "Rác khác",
                          "hihihi"),
                      SizedBox(
                        height: 4.h,
                      ),
                    ],
                  ),
                ),
                // DANH SACH YÊU CẦU
                Padding(
                  padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
                  child: Column(
                    children: [
                      Container(
                        height: 300.h,
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
                                          "Yêu cầu",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Container(
                                        width: 250.w,
                                        child: Text(
                                          "Lịch Sử",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: TabBarView(children: [
                                  MyTabOne(),
                                  MyTabTwo(),
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

  Row _TrashItem(
    String image,
    String nameTrash,
    String links,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.sp),
          child: Image.asset(
            image,
            width: 80.w,
            height: 50.h,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          width: 120.w,
          child: Text(
            nameTrash,
            style: AppTextStyles.bodyText1.copyWith(fontSize: 16.sp),
            textAlign: TextAlign.left,
          ),
        ),
        IconButton(
          padding: EdgeInsets.only(right: 10.sp),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailTrash(),
                ));
          },
          icon: SvgPicture.asset(
              'assets/icons/ic_info_information_detail_icon.svg'),
        )
      ],
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
              print("CLICK SANG PAGE PROFILE NÈ!!!!");
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
          Text(
            "Hello".tr + "\ Tấn",
            style: AppTextStyles.headline1,
          )
        ],
      ),
    );
  }
}

class MyTabOne extends StatelessWidget {
  const MyTabOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.sp),
        color: ColorsConstants.kBGCardColor,
        border: Border.all(
          color: ColorsConstants.kShadowColor,
          width: 1,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
      child:  InkWell(
        onTap: () {print("CLICK QUAN PAGE REQUEST");},
        child: SingleChildScrollView(
          child: Column(children: [
            item_requestTrash(),
            item_requestTrash(),
            item_requestTrash(),
            item_requestTrash(),
          ],),
        ),
      ),
    );
  }
}



class MyTabTwo extends StatelessWidget {
  const MyTabTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.sp),
        color: ColorsConstants.kBGCardColor,
        border: Border.all(
          color: ColorsConstants.kShadowColor,
          width: 1,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
      child:  InkWell(
        onTap: () {print("CLICK QUAN PAGE REQUEST");},
        child: SingleChildScrollView(
          child: Column(children: [
            item_requestTrash(),
            item_requestTrash(),
          ],),
        ),
      ),
    );
  }
}
