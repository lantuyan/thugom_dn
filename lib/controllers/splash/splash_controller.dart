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
      DataManager().saveData('sessionId', getStore.read('sessionId'));
      DataManager().saveData('name', getStore.read('name'));
      DataManager().saveData('role', getStore.read('role'));
      DataManager().saveData('zalonumber', getStore.read('zalonumber'));
      DataManager().saveData('address', getStore.read('address'));
      
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAllNamed('/mainPage');
      });
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        // Get.offAllNamed('/landingPage');
        logOut();
      });
    }
  }

  Future<void> logOut() async {
    try {
        getStore.remove('userId');
        getStore.remove('sessionId');
        getStore.remove('name');
        getStore.remove('role');
        getStore.remove('zalonumber');
        getStore.remove('address');
        DataManager().clearData();
        Get.offAllNamed('/landingPage');
    } catch (error) {

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
