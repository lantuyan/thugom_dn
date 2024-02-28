import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thu_gom/managers/data_manager.dart';

class SplashController extends GetxController with GetSingleTickerProviderStateMixin {
  final getStore = GetStorage();
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void onInit() {
    super.onInit();
    checkUserId();
  }

  void checkUserId() {
    if (getStore.read('userId') != null) {
      DataManager().saveData('userId', getStore.read('userId'));
      DataManager().saveData('role', getStore.read('role'));
      
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAllNamed('/mainPage');
      });
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAllNamed('/landingPage');
      });
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
