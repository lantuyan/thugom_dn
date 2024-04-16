import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thu_gom/managers/data_manager.dart';

import 'package:thu_gom/providers/auth_provider.dart';

import 'package:thu_gom/models/infomation/setting_infomation.dart';
import 'package:thu_gom/models/trash/category_model.dart';
import 'package:thu_gom/models/trash/user_request_trash_model.dart';
import 'package:thu_gom/providers/auth_provider.dart';
import 'package:thu_gom/repositories/category_reponsitory.dart';
import 'package:thu_gom/repositories/infomation_reposistory.dart';

import 'package:thu_gom/repositories/user_request_trash_reponsitory.dart';
import 'package:thu_gom/widgets/custom_dialogs.dart';
// import 'package:uni_links/uni_links.dart';

class InfomationController extends GetxController {

  final UserRequestTrashRepository _requestRepository;
  InfomationController(this._requestRepository);

  final GetStorage _getStorage = GetStorage();
  final InfomationReposistory _infomationReposistory;

  InfomationController(this._infomationReposistory);

  late SettingInformation mainSettingInfommation;
  List<SettingInformation> settingList = [];

  @override
  Future<void> onInit() async {
    print("mainSettingInfommation oninit");
    getSettingInfomation();
    super.onInit();
  }

  Future<void> getSettingInfomation() async {
    try {
      await _infomationReposistory.getInfomationSetting().then((value) {
        print('value $value');
        Map<String, dynamic> data = value.toMap();
        List documents = data['documents'].toList();
        settingList = documents.map((e) => SettingInformation.fromMap(e['data'])).toList();
        print('settingList $settingList');
      });
    } catch (e) {
      print("settingList false ${e}");
      print(e);
    }
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
