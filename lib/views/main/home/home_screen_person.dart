import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thu_gom/controllers/main/home/home_controller.dart';
import 'package:thu_gom/models/trash/category_model.dart';
import 'package:thu_gom/providers/category_provider.dart';
import 'package:thu_gom/providers/user_request_trash_provider.dart';
import 'package:thu_gom/repositories/category_reponsitory.dart';
import 'package:thu_gom/repositories/user_request_trash_reponsitory.dart';
import 'package:thu_gom/shared/constants/appwrite_constants.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:thu_gom/shared/themes/style/app_icons.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/views/main/home/detail_trash.dart';
import 'package:thu_gom/views/main/home/tab/history_user.dart';
import 'package:thu_gom/views/main/home/tab/request_user.dart';

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
                                "Đang tải dữ liệu ...",
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
                                              placeholder: (context, url) =>
                                                  Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  value: 0.5,
                                                  color: ColorsConstants
                                                      .kActiveColor,
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
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
                                                            data: request),
                                                  ));
                                            },
                                            icon: SvgPicture.asset(
                                              'assets/icons/ic_info_information_detail_icon.svg',
                                              color:
                                                  ColorsConstants.kActiveColor,
                                            ),
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
                        // height: 600.h,
                        height: MediaQuery.of(context).size.height * 0.87,
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
                                          "Yêu cầu (${_homeController.listRequestUser.length})",
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
                                          "Lịch Sử (${_homeController.listRequestHistory.length})",
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
              // _homeController.logOut(); // LOGOUT
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
            return Expanded(
              child: Text(
                "Xin chào, ${_homeController.name.value}",
                style: AppTextStyles.headline1,
                overflow: TextOverflow
                    .ellipsis, // Truncate văn bản nếu vượt quá khung
                maxLines: 1, // Giới hạn số dòng hiển thị
              ),
            );
          }),
          Column(
            children: [
              Row(
                children: [
                  Stack(
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          Get.toNamed('confirmm_user');
                        },
                        child: const Icon(
                          AppIcons.ic_alert,
                          size: 28,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 14,
                            minHeight: 14,
                          ),
                          child: Text(
                           "${_homeController.listRequestConfirmUser.length}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20.sp,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
