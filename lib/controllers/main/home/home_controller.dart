import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thu_gom/models/trash/category_model.dart';
import 'package:thu_gom/models/trash/user_request_trash_model.dart';
import 'package:thu_gom/providers/auth_provider.dart';
import 'package:thu_gom/repositories/category_reponsitory.dart';
import 'package:thu_gom/repositories/user_request_trash_reponsitory.dart';
import 'package:thu_gom/widgets/custom_dialogs.dart';
// import 'package:uni_links/uni_links.dart';

class HomeController extends GetxController {
  // with StateMixin<List<CategoryModel>> {
  final CategoryRepository _categoryRepository;
  final UserRequestTrashRepository _userRequestTrashRepository;
  HomeController(this._categoryRepository, this._userRequestTrashRepository);

  final GetStorage _getStorage = GetStorage();

  late List<CategoryModel> categoryList = [];
  late List<UserRequestTrashModel> userRequestTrashList = [];
  late List<UserRequestTrashModel> listRequestUser = [];
  late List<UserRequestTrashModel> listRequestHistory = [];

  late List<UserRequestTrashModel> listRequestColletor = [];
  late List<UserRequestTrashModel> listRequestConfirmColletor = [];
  RxBool isLoading = true.obs; // Sử dụng Rx để theo dõi
  var count = 0.obs;
  StreamSubscription? _sub;
  RxString name = ''.obs;
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
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    _handleIncomingLinks();
    name.value = await _getStorage.read('name');
  }

  @override
  void onReady() async {
    await getCategory();
    await getUserRequestFromAppwrite();
    await getRequestWithStatusPending();
    await getRequestHistory();

    await getRequestListColletor();
    await getRequestListConfirmColletor();
   
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future getCategory() async {
    try {
      await _categoryRepository.getCategory().then((value) {
        Map<String, dynamic> data = value.toMap();
        List d = data['documents'].toList();
        categoryList = d
            .map(
              (e) => CategoryModel.fromMap(e['data']),
            )
            .toList();
        // Dữ liệu đã được tải xong, đặt isLoading thành false
        // isLoading.value = false;
        print(">>>>>> LIST CATE <<<<<<<<< ${categoryList}");
        update(categoryList);
        print(">>>>>>>> COUNT ${categoryList.length}");
      });
    } catch (e) {
      print(e);
    }
  }

  Future getUserRequestFromAppwrite() async {
    try {
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
        // isLoading.value = false;
        print(">>>>>> LIST REQUEST  <<<<<<<<< ${userRequestTrashList}");
        update(userRequestTrashList);
      });
    } catch (e) {
      print(e);
    }
  }

  Future getRequestWithStatusPending() async {
    try {
      await _userRequestTrashRepository
          .getRequestWithStatusPending()
          .then((value) {
        Map<String, dynamic> data = value.toMap();
        List listRequest = data['documents'].toList();
        listRequestUser = listRequest
            .map(
              (e) => UserRequestTrashModel.fromMap(e['data']),
            )
            .toList();
        // isLoading.value = false;
        update(listRequestUser);
      });
    } catch (e) {
      print(e);
    }
  }

  Future getRequestHistory() async {
    try {
      await _userRequestTrashRepository.getRequestHistory().then((value) {
        Map<String, dynamic> data = value.toMap();
        List listRequest = data['documents'].toList();
        listRequestHistory = listRequest
            .map(
              (e) => UserRequestTrashModel.fromMap(e['data']),
            )
            .toList();
        // isLoading.value = false;
        update(listRequestHistory);
      });
    } catch (e) {
      print(e);
    }
  }

  Future getRequestListColletor() async {
    try {
      await _userRequestTrashRepository.getRequestListColletor().then((value) {
        final GetStorage _getStorage = GetStorage();
        final userID = _getStorage.read('userId');
        Map<String, dynamic> data = value.toMap();
        List listRequest = data['documents'].toList();
        listRequestColletor = listRequest
            .map(
              (e) => UserRequestTrashModel.fromMap(e['data']),
            ).where((request) => request.hidden!.every((element) => element != userID))
            .toList();
        // isLoading.value = false;
        print(">>>>>> LIST REQUEST PENDING  <<<<<<<<< ${listRequestColletor}");
        update(listRequestColletor);
      });
    } catch (e) {
      print(e);
    }
  }

  Future getRequestListConfirmColletor() async {
    try {
      await _userRequestTrashRepository
          .getRequestListConfirmColletor()
          .then((value) {
        Map<String, dynamic> data = value.toMap();
        List listRequest = data['documents'].toList();
        listRequestConfirmColletor = listRequest
            .map(
              (e) => UserRequestTrashModel.fromMap(e['data']),
            )
            .toList();
        isLoading.value = false;
        print(
            ">>>>>> LIST REQUEST PENDING  <<<<<<<<< ${listRequestConfirmColletor}");
        update(listRequestConfirmColletor);

      });
    } catch (e) {
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
