import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:thu_gom/controllers/main/main_controller.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/constants/icon_constants.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainController _mainController = Get.find<MainController>();
  late String isRole = _mainController.currentRole.value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: ColorsConstants.kMainColor,
        //   elevation: 0,
        //   title: Text(
        //     "app_name".tr,
        //     style: TextStyle(
        //         fontSize: 20.sp,
        //         fontWeight: FontWeight.w600,
        //         color: Colors.white),
        //   ),
        //   leading: Container(
        //     padding: EdgeInsets.symmetric(horizontal: 20.sp),
        //     width: 200.sp,
        //     child: Row(
        //       children: [
        //         Image.asset(
        //           "assets/images/logo_new.png",
        //           width: 30.sp,
        //           height: 30.sp,
        //         ),
        //         SizedBox(
        //           width: 10.sp,
        //         ),
        //         Text(
        //           "Nguyễn Văn A",
        //           style: TextStyle(
        //               fontSize: 18.sp,
        //               fontWeight: FontWeight.w600,
        //               color: Colors.white),
        //         ),
        //       ],
        //     ),
        //   ),
        //   centerTitle: true,
        // ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          // notchMargin: 10,
          child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 10.sp, vertical: 0.sp),
              child: Obx(
                () => Row(
                  mainAxisAlignment: isRole == "person"
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _bottomAppBarItem(
                      icon: _mainController.currentPage == 0
                          ? UIIcons.icHomeFill
                          : UIIcons.icHome,
                      page: 0,
                      title: "home_nav".tr,
                    ),
                    if (isRole != "collector" && isRole != "admin")
                      _bottomAppBarItem(
                          icon: _mainController.currentPage == 1
                              ? UIIcons.icMapFill
                              : UIIcons.icMap,
                          page: 1,
                          title: "map_nav".tr),
                    _bottomAppBarItem(
                      icon: _mainController.currentPage == 2
                          ? UIIcons.icNotificationFill
                          : UIIcons.icNotification,
                      page: 2,
                      title: "information_nav".tr,
                    ),
                  ],
                ),
              )),
        ),
        body: PageView(
          controller: _mainController.pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [..._mainController.pages],
        ));
  }

  Widget _bottomAppBarItem({icon, page, title}) {
    return ZoomTapAnimation(
      onTap: () => _mainController.goToTab(page),
      child: Container(
        width: 60.sp,
        height: 50.sp,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _icon(icon),
            Text(
              title,
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: _mainController.currentPage == page
                      ? ColorsConstants.kActiveColor
                      : Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}

Widget _icon(icon) {
  return SvgPicture.asset(
    icon,
    width: 28.sp,
    height: 28.sp,
  );
}
