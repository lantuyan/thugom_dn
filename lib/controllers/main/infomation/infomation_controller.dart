import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thu_gom/managers/data_manager.dart';
import 'package:thu_gom/models/trash/category_model.dart';
import 'package:thu_gom/models/trash/user_request_trash_model.dart';
import 'package:thu_gom/providers/auth_provider.dart';
import 'package:thu_gom/repositories/category_reponsitory.dart';
import 'package:thu_gom/repositories/user_request_trash_reponsitory.dart';
import 'package:thu_gom/widgets/custom_dialogs.dart';
// import 'package:uni_links/uni_links.dart';

class InfomationController extends GetxController {
  InfomationController();

  final GetStorage _getStorage = GetStorage();

  Future<void> logOut() async {
    CustomDialogs.showLoadingDialog();
    try {
      await AuthProvider().logOut(_getStorage.read('sessionId')).then((value) {
        CustomDialogs.hideLoadingDialog();
        _getStorage.remove('userId');
        _getStorage.remove('sessionId');
        _getStorage.remove('name');
        _getStorage.remove('role');
        _getStorage.remove('zalonumber');
        _getStorage.remove('address');
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
}
