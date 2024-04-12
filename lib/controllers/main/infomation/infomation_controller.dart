import 'dart:async';
import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thu_gom/managers/data_manager.dart';
import 'package:thu_gom/models/trash/category_model.dart';
import 'package:thu_gom/models/trash/user_request_trash_model.dart';
import 'package:thu_gom/models/user/user_model.dart';
import 'package:thu_gom/providers/auth_provider.dart';
import 'package:thu_gom/repositories/category_reponsitory.dart';
import 'package:thu_gom/repositories/user_request_trash_reponsitory.dart';
import 'package:thu_gom/shared/constants/appwrite_constants.dart';
import 'package:thu_gom/widgets/custom_dialogs.dart';
// import 'package:uni_links/uni_links.dart';

class InfomationController extends GetxController {
  final UserRequestTrashRepository _requestRepository;
  InfomationController(this._requestRepository);

  final GetStorage _getStorage = GetStorage();
  late String imageLink;
  RxString imagePath = "".obs;
  late String uid_user;
  RxMap data = {}.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    uid_user = _getStorage.read('uid');
    
  }

  Future<void> uploadImageToAppwrite(File imageFile) async {
    CustomDialogs.showLoadingDialog();
    imagePath.value = imageFile.path;
    try {
      // Add the 'await' keyword to wait for the upload to complete
      var value =
          await _requestRepository.uploadImageToAppwrite(imagePath.value);

      imageLink = 'https://cloud.appwrite.io/v1/storage/' +
          'buckets/${AppWriteConstants.userRequestTrashBucketId}/' +
          'files/${value.$id}/view?project=${AppWriteConstants.projectId}';

      CustomDialogs.hideLoadingDialog();
    } catch (onError) {
      CustomDialogs.hideLoadingDialog();
      print(onError);
    }
  }

  Future<void> sendImageToAppwrite(String uid_user) async {
    CustomDialogs.showLoadingDialog();
    // await uploadImageToAppwrite();
    String pathPhoto = imageLink;
    await _requestRepository
        .updateAvatarCollector(uid_user, pathPhoto)
        .then((value) {
      CustomDialogs.hideLoadingDialog();
      Get.offNamed('/mainPage');

      CustomDialogs.showSnackBar(2, "Gửi thành công", 'success');
    }).catchError((onError) {
      CustomDialogs.hideLoadingDialog();
      print(onError);
      CustomDialogs.showSnackBar(
          2, "Đã có lỗi xảy ra vui lòng thử lại sau!", 'error');
    });
  }

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
        DataManager().clearData();
        Get.offAllNamed('/landingPage');
      });
    } catch (error) {
      print("Error: $error");
      CustomDialogs.hideLoadingDialog();
      CustomDialogs.showSnackBar(2, "wrong".tr, 'error');
      DataManager().clearData();
      Get.offAllNamed('/landingPage');
    }
  }
}
