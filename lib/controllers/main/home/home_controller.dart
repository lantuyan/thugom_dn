import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thu_gom/managers/data_manager.dart';
import 'package:thu_gom/models/trash/category_model.dart';
import 'package:thu_gom/models/trash/category_price_model.dart';
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
  late List<UserRequestTrashModel> listRequestConfirmUser = [];
  late List<UserRequestTrashModel> listRequestHistory = [];

  // COLLECTOR
  late List<UserRequestTrashModel> listRequestColletor = [];
  late List<UserRequestTrashModel> listRequestConfirmColletor = [];
  late List<UserRequestTrashModel> listRequestProcessingCollector = [];

  late List<CategoryPriceModel> listCategoryPrice = [];

  RxBool isLoading = true.obs; // Sử dụng Rx để theo dõi
  StreamSubscription? _sub;
  RxString name = ''.obs;
  RxString role = ''.obs;
  RxBool hasNextPage = true.obs;
  RxBool isLoadMoreRunning = false.obs;
  final int offsetSize = 10;
  int currentPage = 1;
  RxInt countRequestUser = 0.obs;
  RxInt countHistoryUser = 0.obs;
  RxInt countNotificateUser = 0.obs;
  RxInt countRequestCollector = 0.obs;
  RxInt countComfirmCollector = 0.obs;
  RxInt countNotificateCollector = 0.obs;

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
    name.value = DataManager().getData('name');
    role.value = DataManager().getData('role');
  }

  @override
  void onReady() async {
    CustomDialogs.showLoadingDialog();
    try {
      if (role.value == 'person') {
        print("Value of person");
        await getCategory();
        await getRequestWithStatusPending();
        countRequestUser.value = await listRequestUser.length;
        await getRequestHistory();
        countHistoryUser.value = await listRequestHistory.length;
        await getRequestWithStatusComfirmming();
        countNotificateUser.value = await listRequestConfirmUser.length;
      }
      if (role.value == 'collector') {
        print("Value of colelctor");
        await getRequestListColletor();
        countRequestCollector.value = await listRequestColletor.length;
        await getRequestListProcessingCollector();
        countNotificateCollector.value =
            await listRequestProcessingCollector.length;
        await getRequestListConfirmColletor();
        countComfirmCollector.value = await listRequestConfirmColletor.length;
        await getMoreData();
      }
      await hideLoading();
    } catch (e) {
      hideLoading();
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future hideLoading() async {
    isLoading.value = false;
    CustomDialogs.hideLoadingDialog();
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
        update(categoryList);
      });
    } catch (e) {
      print(e);
    }
  }

  List<CategoryPriceModel> getDataFromTableCategoryTrash(List listCategories) {
    listCategoryPrice.clear();
    listCategoryPrice.addAll(
        listCategories.map((e) => CategoryPriceModel.fromMap(e)).toList());
    return listCategoryPrice;
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
        print(">>>> TAB YEU CAU USER: ${listRequestUser}");
      });
    } catch (e) {
      print(e);
    }
  }

  Future getRequestWithStatusComfirmming() async {
    try {
      await _userRequestTrashRepository
          .getRequestWithStatusComfirmming()
          .then((value) {
        Map<String, dynamic> data = value.toMap();
        List listRequest = data['documents'].toList();
        listRequestConfirmUser = listRequest
            .map(
              (e) => UserRequestTrashModel.fromMap(e['data']),
            )
            .toList();
        update(listRequestUser);
        print(">>>> TAB CONFIRM<: ${listRequestConfirmUser}");
      });
    } catch (e) {
      print("LOI TAB NOTIFICATION ${e}");
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
        print(">>>> TAB LICHSU<: ${listRequestHistory}");
      });
    } catch (e) {
      print(">>> LOI TAB HISTORY: ${e}");
    }
  }

  Future getRequestListColletor() async {
    try {
      await _userRequestTrashRepository
          .getRequestListColletor(0, currentPage)
          .then((value) {
        final GetStorage _getStorage = GetStorage();
        final userID = _getStorage.read('userId');
        Map<String, dynamic> data = value.toMap();
        List listRequest = data['documents'].toList();
        listRequestColletor.assignAll(listRequest
            .map(
              (e) => UserRequestTrashModel.fromMap(e['data']),
            )
            .where((request) =>
                request.hidden!.every((element) => element != userID))
            .toList());
        update(listRequestColletor);
      });
    } catch (e) {
      print(e);
    }
  }

  Future getMoreData() async {
    if (hasNextPage == true && isLoadMoreRunning == false) {
      isLoadMoreRunning.value = true;

      try {
        await _userRequestTrashRepository
            .getRequestListColletor(offsetSize, currentPage)
            .then((value) {
          final GetStorage _getStorage = GetStorage();
          final userID = _getStorage.read('userId');
          Map<String, dynamic> data = value.toMap();
          List listRequest = data['documents'].toList();
          bool hasMoreData = listRequest.length > offsetSize;
          if (listRequest.isNotEmpty) {
            listRequestColletor.addAll(listRequest
                .map(
                  (e) => UserRequestTrashModel.fromMap(e['data']),
                )
                .where((request) =>
                    request.hidden!.every((element) => element != userID))
                .toList());
            print(
                ">>>>>> LIST REQUEST PENDING GET MORE DATA <<<<<<<<< ${listRequestColletor}");
            currentPage++;
          } else {
            hasNextPage.value = false;
          }
        });
      } catch (e) {
        print(e);
      }
      isLoadMoreRunning.value = false;
    }
  }

  Future getRequestListProcessingCollector() async {
    try {
      await _userRequestTrashRepository
          .getRequestWithStatusProcessingCollector()
          .then((value) {
        Map<String, dynamic> data = value.toMap();
        List listRequest = data['documents'].toList();
        listRequestProcessingCollector = listRequest
            .map(
              (e) => UserRequestTrashModel.fromMap(e['data']),
            )
            .toList();
        isLoading.value = false;
        print(
            ">>>>>> LIST REQUEST PENDING PROCESSING COLLECTOR <<<<<<<<< ${listRequestProcessingCollector}");
        update(listRequestProcessingCollector);
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
        // isLoading.value = false;
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
