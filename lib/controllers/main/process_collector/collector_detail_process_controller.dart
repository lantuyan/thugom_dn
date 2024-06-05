import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thu_gom/controllers/main/home/home_controller.dart';
import 'package:thu_gom/managers/data_manager.dart';
import 'package:thu_gom/models/trash/user_request_trash_model.dart';
import 'package:thu_gom/repositories/user_request_trash_reponsitory.dart';
import 'package:thu_gom/shared/constants/appwrite_constants.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
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

  final TextEditingController weightController = TextEditingController(text: '0');
  RxInt weight = 0.obs;
  RxInt weighMetal = 0.obs;
  RxInt weighPaper = 0.obs;
  RxInt weighBottle = 0.obs;
  RxInt weighHDPE = 0.obs;
  RxInt weighNilon = 0.obs;
  RxInt weighOthers = 0.obs;
  RxString requestType = "".obs;

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
    weight.value = int.tryParse(requestDetailModel.amount_collected ?? "") ?? 0;
    weighMetal.value = int.tryParse(requestDetailModel.metal ?? "") ?? 0;
    weighPaper.value = int.tryParse(requestDetailModel.paper ?? "") ?? 0;
    weighBottle.value = int.tryParse(requestDetailModel.bottle ?? "") ?? 0;
    weighHDPE.value = int.tryParse(requestDetailModel.hdpe ?? "") ?? 0;
    weighNilon.value = int.tryParse(requestDetailModel.nilon ?? "") ?? 0;
    weighOthers.value = int.tryParse(requestDetailModel.others ?? "") ?? 0;
    weightController.text = weight.value.toString();
    loading.value = false;
    requestId = requestDetailModel.requestId;
    requestType.value = requestDetailModel.trash_type;
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 25);
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
      imageWidget = Image.file(image, fit: BoxFit.fill, cacheHeight: 400, cacheWidth: 400);
    }
  }

  Future<void> uploadImageToAppwrite() async {
    CustomDialogs.showLoadingDialog();
    try {
      // Add the 'await' keyword to wait for the upload to complete
      var value = await _requestRepository.uploadImageToAppwrite(imagePath.value);

      imageLink = 'https://cloud.appwrite.io/v1/storage/' + 'buckets/${AppWriteConstants.userRequestTrashBucketId}/' + 'files/${value.$id}/view?project=${AppWriteConstants.projectId}';

      CustomDialogs.hideLoadingDialog();
    } catch (onError) {
      CustomDialogs.hideLoadingDialog();
      print(onError);
    }
  }

  Future<void> sendComfirmInfo(String requestId, String collection_price) async {
    CustomDialogs.showLoadingDialog();
    await uploadImageToAppwrite();
    String pathPhoto = imageLink;
    await _requestRepository
        .sendComfirmInfo(requestId, pathPhoto, weight.value.toString(), collection_price, requestDetailModel.confirm, weighMetal.value.toString(), weighPaper.value.toString(), weighBottle.value.toString(), weighHDPE.value.toString(), weighNilon.value.toString(), weighOthers.value.toString())
        .then((value) {
      CustomDialogs.hideLoadingDialog();
      Get.offNamed('/mainPage');
      requestDetailModel.status = 'confirming';
      _homeController.listRequestProcessingCollector.remove(requestDetailModel);
      _homeController.listRequestConfirmUser.insert(0, requestDetailModel);
      print(">>>>>>>> UPDATE MODEL COMFIRM: ${_homeController.listRequestConfirmUser}");
      CustomDialogs.showSnackBar(2, "Cảm ơn bạn đã đánh giá", 'success');
    }).catchError((onError) {
      CustomDialogs.hideLoadingDialog();
      print(onError);
      CustomDialogs.showSnackBar(2, "Đã có lỗi xảy ra vui lòng thử lại sau!", 'error');
    });
  }

  void showWeightDialog() {
    final TextEditingController metalField = TextEditingController(text: weighMetal.value.toString());
    final TextEditingController paperField = TextEditingController(text: weighPaper.value.toString());
    final TextEditingController bottleField = TextEditingController(text: weighBottle.value.toString());
    final TextEditingController hdpeField = TextEditingController(text: weighHDPE.value.toString());
    final TextEditingController nilonField = TextEditingController(text: weighNilon.value.toString());
    final TextEditingController othersField = TextEditingController(text: weighOthers.value.toString());

    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Nhập các giá trị khối lượng',
            style: TextStyle(color: ColorsConstants.kActiveColor),
          ),
          content: SingleChildScrollView(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      TextField(
                        controller: metalField,
                        decoration: const InputDecoration(
                          labelText: 'Kim Loại',
                          labelStyle: TextStyle(color: ColorsConstants.kActiveColor),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorsConstants.kActiveColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorsConstants.kActiveColor),
                          ),
                        ),
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        onTap: () {
                          // set value to emty string
                          if (metalField.text == '0') metalField.text = '';
                        },
                      ),
                      SizedBox(height: 8.sp), // Adding some space between the fields
                      TextField(
                        controller: paperField,
                        decoration: const InputDecoration(
                          labelText: 'Giấy',
                          labelStyle: TextStyle(color: ColorsConstants.kActiveColor),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorsConstants.kActiveColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorsConstants.kActiveColor),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onTap: () {
                          // set value to emty string
                          if (paperField.text == '0') paperField.text = '';
                        },
                      ),
                      SizedBox(height: 8.sp),
                      TextField(
                        controller: bottleField,
                        decoration: const InputDecoration(
                          labelText: 'Chai PET',
                          labelStyle: TextStyle(color: ColorsConstants.kActiveColor),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorsConstants.kActiveColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorsConstants.kActiveColor),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onTap: () {
                          // set value to emty string
                          if (bottleField.text == '0') bottleField.text = '';
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.sp),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      TextField(
                        controller: hdpeField,
                        decoration: const InputDecoration(
                          labelText: 'Nhựa cứng(HDPE)',
                          labelStyle: TextStyle(color: ColorsConstants.kActiveColor),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorsConstants.kActiveColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorsConstants.kActiveColor),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onTap: () {
                          // set value to emty string
                          if (hdpeField.text == '0') hdpeField.text = '';
                        },
                      ),
                      SizedBox(height: 8.sp),
                      TextField(
                        controller: nilonField,
                        decoration: const InputDecoration(
                          labelText: 'Túi nilon',
                          labelStyle: TextStyle(color: ColorsConstants.kActiveColor),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorsConstants.kActiveColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorsConstants.kActiveColor),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onTap: () {
                          // set value to emty string
                          if (nilonField.text == '0') nilonField.text = '';
                        },
                      ),
                      SizedBox(height: 8.sp),
                      TextField(
                        controller: othersField,
                        decoration: const InputDecoration(
                          labelText: 'Khác',
                          labelStyle: TextStyle(color: ColorsConstants.kActiveColor),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorsConstants.kActiveColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorsConstants.kActiveColor),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onTap: () {
                          // set value to emty string
                          if (othersField.text == '0') othersField.text = '';
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Hủy',
                style: TextStyle(color: ColorsConstants.kActiveColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsConstants.kMainColor,
                padding: EdgeInsets.fromLTRB(20.sp, 10.sp, 20.sp, 10.sp),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                double totalWeight = 0;
                totalWeight += double.tryParse(metalField.text) ?? 0;
                totalWeight += double.tryParse(paperField.text) ?? 0;
                totalWeight += double.tryParse(bottleField.text) ?? 0;
                totalWeight += double.tryParse(hdpeField.text) ?? 0;
                totalWeight += double.tryParse(nilonField.text) ?? 0;
                totalWeight += double.tryParse(othersField.text) ?? 0;
                weightController.text = totalWeight.toString();

                weighMetal.value = int.tryParse(metalField.text) ?? 0;
                weighPaper.value = int.tryParse(paperField.text) ?? 0;
                weighBottle.value = int.tryParse(bottleField.text) ?? 0;
                weighHDPE.value = int.tryParse(hdpeField.text) ?? 0;
                weighNilon.value = int.tryParse(nilonField.text) ?? 0;
                weighOthers.value = int.tryParse(othersField.text) ?? 0;
                weight.value = totalWeight.toInt();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
