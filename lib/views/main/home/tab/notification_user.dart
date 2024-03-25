import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thu_gom/controllers/main/home/home_controller.dart';
import 'package:thu_gom/models/trash/user_request_trash_model.dart';
import 'package:thu_gom/providers/category_provider.dart';
import 'package:thu_gom/providers/user_request_trash_provider.dart';
import 'package:thu_gom/repositories/category_reponsitory.dart';
import 'package:thu_gom/repositories/user_request_trash_reponsitory.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/widgets/item_requestTrash.dart';

class NotificationUser extends StatefulWidget {
  const NotificationUser({super.key});

  @override
  State<NotificationUser> createState() => _NotificationUserState();
}

class _NotificationUserState extends State<NotificationUser> {
  final HomeController _homeController = Get.put(HomeController(
      CategoryRepository(CategoryProvider()),
      UserRequestTrashRepository(UserRequestTrashProvider())));
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Cần đánh giá",
          style: AppTextStyles.caption,
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
               Get.offAllNamed('/mainPage');
            },
          ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 8.sp, left: 20.sp, right: 20.sp),
          child: Container(
            child: _homeController.listRequestConfirmUser.isEmpty
                ? Center(
                    heightFactor: 20.h,
                    child: Text(
                      "Đơn vị thu gom chưa xác nhận",
                      style: AppTextStyles.caption,
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _homeController.listRequestConfirmUser.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      UserRequestTrashModel request =
                          _homeController.listRequestConfirmUser[index];

                      return GestureDetector(
                        onTap: () {
                          Get.toNamed('user_detail_confirm',
                              arguments: {'requestDetail': request});
                        },
                        child: Stack(
                          children: [
                            item_requestTrash(
                              id: request.requestId,
                              createAt: request.createAt,
                              trash_type: request.trash_type,
                              image: request.image,
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 14,
                                  minHeight: 14,
                                ),
                                child: const Text(
                                  'Cần đánh giá',
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
                      );
                    },
                  ),
          ),
        ),
      ),
    ));
  }
}
