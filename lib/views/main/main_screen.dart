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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _mainController.pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [..._mainController.pages],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            selectedItemColor: ColorsConstants.kActiveColor,
            currentIndex: _mainController.currentPage.value,
            onTap: (index) {
              if (_mainController.currentPage.value != index) {
                _mainController.goToTab(index);
                _mainController.currentPage.value = index;
                if (index == 0 && _mainController.currentRole != "admin") {
                  Get.offAllNamed('/mainPage', );
                }
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: _icon(_mainController.currentPage.value == 0
                    ? UIIcons.icHomeFill
                    : UIIcons.icHome),
                label: "home_nav".tr,
              ),
              BottomNavigationBarItem(
                icon: _icon(_mainController.currentPage.value == 1
                    ? UIIcons.icMapFill
                    : UIIcons.icMap),
                label: "map_nav".tr,
              ),
              if ( _mainController.currentRole != "admin")
                BottomNavigationBarItem(
                  icon: _icon(_mainController.currentPage.value == 2
                      ? UIIcons.icPersonFill
                      : UIIcons.icPerson),
                  label: "information_nav".tr,
                ),
              if (_mainController.currentRole == "admin") 
              BottomNavigationBarItem(
                  icon: _icon(_mainController.currentPage.value == 2
                      ? UIIcons.icDownloadFill
                      : UIIcons.icDownload),
                  label: "Tải xuống".tr,
                ),
              if (_mainController.currentRole == "admin") 
              BottomNavigationBarItem(
                  icon: _icon(_mainController.currentPage.value == 3
                      ? UIIcons.icPersonFill
                      : UIIcons.icPerson),
                  label: "information_nav".tr,
              ),
                
            ],
          ),
        ));
  }

  Widget _icon(icon) {
    return SvgPicture.asset(
      icon,
      width: 28.sp,
      height: 28.sp,
    );
  }
}
