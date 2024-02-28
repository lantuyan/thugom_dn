import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:thu_gom/controllers/login/login_controller.dart';
import 'package:thu_gom/controllers/main/home/home_controller.dart';
import 'package:thu_gom/models/trash/user_request_trash_model.dart';
import 'package:thu_gom/providers/auth_provider.dart';
import 'package:thu_gom/providers/category_provider.dart';
import 'package:thu_gom/providers/user_request_trash_provider.dart';
import 'package:thu_gom/repositories/auth_reposistory.dart';
import 'package:thu_gom/repositories/category_reponsitory.dart';
import 'package:thu_gom/repositories/user_request_trash_reponsitory.dart';
import 'package:thu_gom/shared/constants/appwrite_constants.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/views/main/home/detail_trash.dart';
import 'package:thu_gom/widgets/dot_widget.dart';
import 'package:thu_gom/widgets/item_requestTrash.dart';

class HomeScreenPerson extends StatefulWidget {
  @override
  State<HomeScreenPerson> createState() => _HomeScreenPersonState();
}

class _HomeScreenPersonState extends State<HomeScreenPerson> {
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
                      SizedBox(
                        height: 240.h,
                        child: _homeController.obx(
                          (state) => ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    EdgeInsets.only(top: 4.sp, bottom: 4.sp),
                                child: GestureDetector(
                                  onTap: () {
                                    print("CLICK GO TO PAGE HOME REQUEST");
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.sp),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.fill,
                                          width: 80.w,
                                          height: 50.h,
                                          imageUrl:
                                              '${AppWriteConstants.endPoint}/storage/buckets/${AppWriteConstants.categoryBucketId}/files/${state![index].category_image}/view?project=${AppWriteConstants.projectId}',
                                        ),
                                      ),
                                      SizedBox(
                                        width: 140.w,
                                        child: Text(
                                          state![index].category_title,
                                          style: AppTextStyles.bodyText1
                                              .copyWith(fontSize: 16.sp),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      IconButton(
                                        padding: EdgeInsets.only(right: 10.sp),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailTrash(
                                                  id: state![index].categoryID,
                                                  image: state![index]
                                                      .category_image,
                                                  title: state![index]
                                                      .category_title,
                                                  description: state![index]
                                                      .category_description,
                                                ),
                                              ));
                                        },
                                        icon: SvgPicture.asset(
                                            'assets/icons/ic_info_information_detail_icon.svg'),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
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
                                          "Yêu cầu (3)",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            fontFamily:
                                                AppTextStyles.fontFamily,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Container(
                                        width: 250.w,
                                        child: Text(
                                          "Lịch Sử (1)",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            fontFamily:
                                                AppTextStyles.fontFamily,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: TabBarView(children: [
                                  tabListRequest(
                                    userController: _homeController,
                                  ),
                                  tabListHistory(),
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
          Text(
            "Hello".tr + "\ Tấn",
            style: AppTextStyles.headline1,
          )
        ],
      ),
    );
  }
}

class tabListRequest extends StatelessWidget {
  final HomeController userController;
  const tabListRequest({super.key, required this.userController});

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
      child: InkWell(
        onTap: () {
          print("CLICK QUAN PAGE REQUEST");
        },
        child: SingleChildScrollView(
          // child: Obx(() {
          //   return ListView.builder(
          //       scrollDirection: Axis.vertical,
          //       itemCount: userController.userRequestTrashList.length,
          //       itemBuilder: (context, index) {
          //         UserRequestTrashModel request =
          //             userController.userRequestTrashList[index];
          //         return item_requestTrash(
          //           // id: request.requestId,
          //           // createAt: request.createAt,
          //           // trash_type: request.trash_type,
          //           // image: request.image,
          //         );
          //       });
          // }),
          child: Column(
            children: [
              item_requestTrash(),
              item_requestTrash(),
              item_requestTrash(),
            ],
          ),
        ),
      ),
    );
  }
}

class tabListHistory extends StatelessWidget {
  const tabListHistory({super.key});

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
      child: InkWell(
        onTap: () {
          print("CLICK QUAN PAGE REQUEST");
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              item_requestTrash(),
              // item_requestTrash(),
            ],
          ),
        ),
      ),
    );
  }
}
