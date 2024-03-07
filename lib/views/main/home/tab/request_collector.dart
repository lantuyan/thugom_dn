import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thu_gom/controllers/main/home/home_controller.dart';
import 'package:thu_gom/models/trash/user_request_trash_model.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/widgets/item_requestTrashCollector.dart';

class listRequest extends StatefulWidget {
  final HomeController userController;
  const listRequest({super.key, required this.userController});

  @override
  State<listRequest> createState() => _tabListRequestState();
}

class _tabListRequestState extends State<listRequest> {
  final ScrollController _scrollController = ScrollController();
  bool _isVisible = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController..addListener((_scrollListener));

    if (widget.userController.hasNextPage.value == false) {
      // Đặt thời gian biến mất sau 5 giây
      Future.delayed(Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _isVisible = false;
          });
        }
      });
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        (_scrollController.position.maxScrollExtent * 0.75)) {
      setState(() {
        widget.userController.getMoreData();
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (widget.userController.isLoading.value) {
          return Center(
              child: Text(
            "Đang tải dữ liệu ...",
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
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: widget.userController.listRequestColletor.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      UserRequestTrashModel request =
                          widget.userController.listRequestColletor[index];

                      return GestureDetector(
                        onTap: () {
                          Get.toNamed('requestDetailPage',
                              arguments: {'requestDetail': request});
                        },
                        child: item_requestTrashCollector(
                          id: request.requestId,
                          createAt: request.createAt,
                          trash_type: request.trash_type,
                          image: request.image,
                          address: request.address,
                        ),
                      );
                    },
                    controller: _scrollController,
                  ),
                ),
                if (widget.userController.isLoadMoreRunning == true)
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (widget.userController.hasNextPage == false)
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    opacity: _isVisible ? 1.0 : 0.0,
                    child: Center(
                      child:
                          Text('Đã Hết Yêu Cầu...', style: AppTextStyles.error),
                    ),
                  )
              ],
            ),
          );
        }
      },
    );
  }
}
