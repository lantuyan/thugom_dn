import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thu_gom/models/trash/category_model.dart';
import 'package:thu_gom/models/trash/user_request_trash_model.dart';
import 'package:thu_gom/providers/auth_provider.dart';
import 'package:thu_gom/repositories/category_reponsitory.dart';
import 'package:thu_gom/repositories/user_request_trash_reponsitory.dart';
import 'package:thu_gom/widgets/custom_dialogs.dart';
// import 'package:uni_links/uni_links.dart';

class HomeController extends GetxController
    with StateMixin<List<CategoryModel>> {
  final CategoryRepository _categoryRepository;
  final UserRequestTrashRepository _userRequestTrashRepository;
  HomeController(this._categoryRepository, this._userRequestTrashRepository);

  final GetStorage _getStorage = GetStorage();

  late List<CategoryModel> categoryList = [];
  late List<UserRequestTrashModel> userRequestTrashList = [];
  StreamSubscription? _sub;

  void _handleIncomingLinks() {
    if (!kIsWeb) {
      // It will handle app links while the app is already started - be it in
      // the foreground or in the background.
      
      // TODO: - Handle incoming links - recommed using: https://fluttergems.dev/packages/app_links/
      
      // _sub = uriLinkStream.listen((Uri? uri) async {
      //   print('got uri: $uri');

      //   if (uri != null) {
      //     Map<String, String> params = uri.queryParameters;

      //     if (params.containsKey('secret') && params.containsKey('userId')) {
      //       String secret = params['secret']!;
      //       String userId = params['userId']!;

      //       print('UserId >>>> $userId');
      //       print('secret >>>> $secret');

      //       await AuthProvider().validateEmail(userId, secret);
      //       CustomDialogs.showLoadingDialog();
      //       CustomDialogs.hideLoadingDialog();
      //     }
      //   }
      // }, onError: (Object err) {
      //   print(err);
      // });
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _handleIncomingLinks();
  }

  @override
  void onReady() {
    getCategory();
    getUserRequestFromAppwrite();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  getCategory() async {
    try {
      change(null, status: RxStatus.loading());
      await _categoryRepository.getCategory().then((value) {
        Map<String, dynamic> data = value.toMap();
        List d = data['documents'].toList();
        categoryList = d
            .map(
              (e) => CategoryModel.fromMap(e['data']),
            )
            .toList();
        change(categoryList, status: RxStatus.success());
      }).catchError((error) {
        if (error is AppwriteException) {
          change(null, status: RxStatus.error(error.response['message']));
        } else {
          change(null, status: RxStatus.error("Something went wrong"));
        }
      });
    } catch (e) {
      change(null, status: RxStatus.error("Something went wrong"));
    }
  }

  getUserRequestFromAppwrite() async {
    try {
      change(null, status: RxStatus.loading());
      await _userRequestTrashRepository
          .getRequestOfUserFromAppwrite()
          .then((value) {
        Map<String, dynamic> data = value.toMap();
        List listRequest = data['documents'].toList();
        userRequestTrashList = listRequest
            .map(
              (e) => UserRequestTrashModel.fromMap(e['data']),
            )
            .toList();
            print(">>>>>> LIST REQUEST <<<<<<<<< ${userRequestTrashList}");
        change(categoryList, status: RxStatus.success());
      });
    } catch (e) {
      print(e);
      change(null, status: RxStatus.error("Something went wrong"));
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
