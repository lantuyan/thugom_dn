import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thu_gom/managers/data_manager.dart';
import 'package:thu_gom/providers/auth_provider.dart';
import 'package:thu_gom/repositories/user_reposistory.dart';
import 'package:thu_gom/views/main/analysis/analysis_screen.dart';
import 'package:thu_gom/views/main/home/home_screen_admin.dart';
import 'package:thu_gom/views/main/home/home_screen_person.dart';
import 'package:thu_gom/views/main/home/home_screen_collecter.dart';
import 'package:thu_gom/views/main/infomation/infomation_screen.dart';
import 'package:thu_gom/views/main/map/map_admin.dart';
import 'package:thu_gom/views/main/map/map_collecter_screen.dart';
import 'package:thu_gom/views/main/map/map_screen.dart';
import 'package:thu_gom/widgets/custom_dialogs.dart';

class MainController extends GetxController {
  // final OfferProvider _offerProvider;
  final UserRepository _userRepository;
  MainController(this._userRepository);

  final getStore = GetStorage();

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
    MapAdminScreen(),
    AnalysisScreen(),
    InfomationScreen()
  ];

  List<Widget> pages = [];

  @override
  void onInit() async {
    super.onInit();
    pageController = PageController(initialPage: 0);
    carouselController = CarouselController();

    selectRole(currentRole);
    bool checkSession = await _userRepository.checkSessionUserIfExists();
    String userId = await getStore.read('userId');
    bool checkBlackList = await _userRepository.checkUserBlacklist(userId);
    if (!checkSession || checkBlackList) {
      logOut();
    }
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

  Future<void> logOut() async {
    CustomDialogs.showLoadingDialog();
    try {
      await AuthProvider().logOut(getStore.read('sessionId')).then((value) {
        CustomDialogs.hideLoadingDialog();
        getStore.remove('userId');
        getStore.remove('sessionId');
        getStore.remove('name');
        getStore.remove('role');
        getStore.remove('phonenumber');
        getStore.remove('zalonumber');
        getStore.remove('address');
        DataManager().clearData();
        Get.offAllNamed('/landingPage');
      }).catchError((onError) {
        print("Error: $onError");
        CustomDialogs.hideLoadingDialog();
        CustomDialogs.showSnackBar(2, "wrong".tr, 'error');
      });
    } catch (error) {
      print("Error: $error");
      CustomDialogs.hideLoadingDialog();
      CustomDialogs.showSnackBar(2, "wrong".tr, 'error');
    }
  }

  // @override
  // void dispose() {
  //   pageController.dispose();

  //   super.dispose();
  // }
}
