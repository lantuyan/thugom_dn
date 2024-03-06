import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:thu_gom/managers/data_manager.dart';
import 'package:thu_gom/views/main/home/home_screen_admin.dart';
import 'package:thu_gom/views/main/home/home_screen_person.dart';
import 'package:thu_gom/views/main/home/home_screen_collecter.dart';
import 'package:thu_gom/views/main/infomation/infomation_screen.dart';
import 'package:thu_gom/views/main/map/map_collecter_screen.dart';
import 'package:thu_gom/views/main/map/map_screen.dart';

class MainController extends GetxController {
  // final OfferProvider _offerProvider;
  MainController();

  late PageController pageController;
  late CarouselController carouselController;

  RxInt currentPage = 0.obs;
  var currentBanner = 0.obs;
  String currentRole = DataManager().getData('role');

  List<Widget> pagesUser = [
    HomeScreenPerson(),
    MapScreen(),
    InfomationScreen(),
  ];

  List<Widget> pagesCollector = [
    HomeScreenCollector(),
    MapCollecterScreen(),
    InfomationScreen(),
  ];

  List<Widget> pagesAdmin = [
    HomeAdminScreen(),
    MapCollecterScreen(),
    InfomationScreen(),
  ];

  List<Widget> pages = [];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
    carouselController = CarouselController();

    selectRole(currentRole);
  }

  void selectRole(String role) {
    if (role == "person") {
      pages = pagesUser;
    }
    if (role == "collector") {
      pages = pagesCollector;
    }
    if (role == "admin") {
      pages = pagesAdmin;
    }
  }

  void goToTab(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }

  void changeBanner(int index) {
    currentBanner.value = index;
  }

  // @override
  // void dispose() {
  //   pageController.dispose();

  //   super.dispose();
  // }
}
