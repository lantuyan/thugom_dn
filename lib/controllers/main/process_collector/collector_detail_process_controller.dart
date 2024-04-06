import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thu_gom/controllers/main/home/home_controller.dart';
import 'package:thu_gom/managers/data_manager.dart';
import 'package:thu_gom/models/trash/user_request_trash_model.dart';
import 'package:thu_gom/repositories/user_request_trash_reponsitory.dart';
import 'package:thu_gom/shared/constants/appwrite_constants.dart';
import 'package:thu_gom/widgets/custom_dialogs.dart';
import 'package:uuid/uuid.dart';

class CollectorDetailProcessController extends GetxController {
  final UserRequestTrashRepository _requestRepository;

  CollectorDetailProcessController(this._requestRepository);
  final HomeController _homeController = Get.find<HomeController>();

  //Key
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final amountCollectedFieldKey = GlobalKey<FormBuilderFieldState>();
  final collectionPriceFieldKey = GlobalKey<FormBuilderFieldState>();

  late String imageLink;
  RxBool loading = true.obs;
  RxMap data = {}.obs;
  RxString imagePath = "".obs;
  // RxInt amountCollected = 0.obs;
  // RxString collectionPrice = "".obs;

  late String requestId;

  late UserRequestTrashModel requestDetailModel;

  final picker = ImagePicker();
  late File image;
  late Image imageWidget;

  final GetStorage _getStorage = GetStorage();

  @override
  Future<void> onInit() async {
    super.onInit();
    data.value = await Get.arguments;
    requestDetailModel = await data.value['requestDetail'];
    loading.value = false;
    requestId = requestDetailModel.requestId;
  }

  Future getImageFromCamera() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 25);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
      image = File(pickedFile.path);
      imageWidget = Image.file(
        image,
        fit: BoxFit.fill,
        cacheHeight: 400,
        cacheWidth: 400,
      );
    }
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
      image = File(pickedFile.path);
      imageWidget = Image.file(image,
          fit: BoxFit.fill, cacheHeight: 400, cacheWidth: 400);
    }
  }

  Future<void> uploadImageToAppwrite() async {
    CustomDialogs.showLoadingDialog();
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

  Future<void> sendComfirmInfo(String requestId, String amount_collected, String collection_price) async {
    CustomDialogs.showLoadingDialog();
    await uploadImageToAppwrite();
    String pathPhoto = imageLink;
    await _requestRepository
        .sendComfirmInfo(requestId, pathPhoto, amount_collected, collection_price)
        .then((value) {
      CustomDialogs.hideLoadingDialog();
      Get.offNamed('/mainPage');
      requestDetailModel.status = 'confirming';
      _homeController.listRequestProcessingCollector.remove(requestDetailModel);
      _homeController.listRequestConfirmUser.insert(0,requestDetailModel);
      print(
          ">>>>>>>> UPDATE MODEL COMFIRM: ${_homeController.listRequestConfirmUser}");
      CustomDialogs.showSnackBar(2, "Cảm ơn bạn đã đánh giá", 'success');
    }).catchError((onError) {
      CustomDialogs.hideLoadingDialog();
      print(onError);
      CustomDialogs.showSnackBar(
          2, "Đã có lỗi xảy ra vui lòng thử lại sau!", 'error');
    });
  }
}
