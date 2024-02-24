import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:thu_gom/views/main/home/home_screen.dart';
import 'package:thu_gom/views/main/infomation/infomation_screen.dart';
import 'package:thu_gom/views/main/map/map_screen.dart';

class MainController extends GetxController {
  // final OfferProvider _offerProvider;
  MainController();

  late PageController pageController;
  late CarouselController carouselController;

  var currentPage = 0.obs;
  var currentBanner = 0.obs;
  RxString currentRole = "person".obs;

  List<Widget> pages = [
    HomeScreen(),
    MapScreen(),
    InfomationScreen(),
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
    carouselController = CarouselController();
    changeRole("person");
  }

  void changeRole(String role) {
    if (role == "person") {
      // pages.removeAt(1);
    }
    if (role == "collector") {
      pages.removeAt(1);
      currentRole.value = "collector";
    }
    if (role == "admin") {
      pages.removeAt(1);
    }
  }

  void goToTab(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }

  void changeBanner(int index) {
    currentBanner.value = index;
  }

  @override
  void dispose() {
    pageController.dispose();

    super.dispose();
  }
}
