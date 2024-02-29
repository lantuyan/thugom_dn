import 'package:appwrite/appwrite.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thu_gom/controllers/login/login_controller.dart';
import 'package:thu_gom/controllers/main/home/home_controller.dart';
import 'package:thu_gom/models/trash/category_model.dart';
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
  final GetStorage _getStorage = GetStorage();
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
                        child: Obx(
                          () {
                            if (_homeController.isLoading.value) {
                              return Center(
                                  child: Text(
                                "ĐANG TẢI DỮ LIỆU",
                                style: AppTextStyles.bodyText1,
                              ));
                            } else {
                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: const BouncingScrollPhysics(),
                                itemCount: _homeController.categoryList.length,
                                itemBuilder: (context, index) {
                                  CategoryModel request =
                                      _homeController.categoryList[index];
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        top: 4.sp, bottom: 4.sp),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed('/requestPersonPage',
                                            arguments: {
                                              'categoryId': request.categoryID,
                                              'categoryTitle':
                                                  request.category_title,
                                              'categoryImage':
                                                  request.category_image,
                                            });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.sp),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.fill,
                                              width: 80.w,
                                              height: 50.h,
                                              imageUrl:
                                                  '${AppWriteConstants.endPoint}/storage/buckets/${AppWriteConstants.categoryBucketId}/files/${request.category_image}/view?project=${AppWriteConstants.projectId}',
                                            ),
                                          ),
                                          SizedBox(
                                            width: 140.w,
                                            child: Text(
                                              request.category_title,
                                              style: AppTextStyles.bodyText1
                                                  .copyWith(fontSize: 16.sp),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          IconButton(
                                            padding:
                                                EdgeInsets.only(right: 10.sp),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailTrash(
                                                      id: request.categoryID,
                                                      image: request
                                                          .category_image,
                                                      title: request
                                                          .category_title,
                                                      description: request
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
                              );
                            }
                          },
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
                        height: 400.h,
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
                                          "Lịch Sử ",
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
                                  tabListHistory(
                                    userController: _homeController,
                                  ),
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
            "Hello".tr + "\ ${_getStorage.read('name')}",
            style: AppTextStyles.headline1,
          )
        ],
      ),
    );
  }
}

class tabListRequest extends StatefulWidget {
  final HomeController userController;
  const tabListRequest({super.key, required this.userController});

  @override
  State<tabListRequest> createState() => _tabListRequestState();
}

class _tabListRequestState extends State<tabListRequest> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (widget.userController.isLoading.value) {
          return SizedBox( child: CircularProgressIndicator());
        } else {
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
            child: widget.userController.listRequestUser.isEmpty
                ? Text(
                    "Bạn chưa có yêu cầu thu gom nào",
                    style: AppTextStyles.bodyText1,
                    textAlign: TextAlign.center,
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: widget.userController.listRequestUser.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      UserRequestTrashModel request =
                          widget.userController.listRequestUser[index];

                      return GestureDetector(
                        onTap: () {
                          Get.toNamed('requestDetailPage',
                              arguments: {'requestDetail': request});
                          // print("GO TO PAGE DETAIL REQUEST");
                        },
                        child: item_requestTrash(
                          id: request.requestId,
                          createAt: request.createAt,
                          trash_type: request.trash_type,
                          image: request.image,
                        ),
                      );
                    },
                  ),
          );
        }
      },
    );
  }
}

class tabListHistory extends StatefulWidget {
  final HomeController userController;
  const tabListHistory({super.key, required this.userController});

  @override
  State<tabListHistory> createState() => _tabListHistoryState();
}

class _tabListHistoryState extends State<tabListHistory> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (widget.userController.isLoading.value) {
          return SizedBox( child: CircularProgressIndicator());
        } else {
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
            child: widget.userController.listRequestHistory.isEmpty
                ? Text(
                    "Hãy tạo yêu cầu thu gom đầu tiên nào!",
                    style: AppTextStyles.bodyText1,
                    textAlign: TextAlign.center,
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: widget.userController.listRequestHistory.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      UserRequestTrashModel request =
                          widget.userController.listRequestHistory[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed('requestDetailPage',
                              arguments: {'requestDetail': request});
                          // print("GO TO PAGE DETAIL REQUEST");
                        },
                        child: item_requestTrash(
                          id: request.requestId,
                          createAt: request.createAt,
                          trash_type: request.trash_type,
                          image: request.image,
                        ),
                      );
                    },
                  ),
          );
        }
      },
    );
  }
}
