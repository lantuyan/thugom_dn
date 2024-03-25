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
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/widgets/item_requestTrash.dart';

class NotificationCollector extends StatefulWidget {
  const NotificationCollector({super.key});

  @override
  State<NotificationCollector> createState() => _NotificationCollectorState();
}

class _NotificationCollectorState extends State<NotificationCollector> {
  final HomeController _homeController = Get.put(HomeController(
      CategoryRepository(CategoryProvider()),
      UserRequestTrashRepository(UserRequestTrashProvider())));
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Hãy xác nhận minh chứng",
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
          padding: EdgeInsets.all(12.sp),
          child: Container(
            child: _homeController.listRequestProcessingCollector.isEmpty
                ? Center(
                    heightFactor: 20.h,
                    child: Text(
                      "Chưa xác nhận yêu cầu thu gom nào!",
                      style: AppTextStyles.caption,
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _homeController.listRequestProcessingCollector.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      UserRequestTrashModel request =
                          _homeController.listRequestProcessingCollector[index];

                      return GestureDetector(
                        onTap: () {
                          Get.toNamed('collector_detail_process',
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
                              top: -4.sp,
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
                                  'Cần chụp minh chứng',
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
