
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thu_gom/controllers/main/home/home_controller.dart';
import 'package:thu_gom/models/trash/user_request_trash_model.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/widgets/item_requestTrash.dart';

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
          return Center(
              child: Text(
            "ĐANG TẢI DỮ LIỆU",
            style: AppTextStyles.bodyText1,
          ));
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
