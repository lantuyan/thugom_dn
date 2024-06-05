import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thu_gom/managers/data_manager.dart';
import 'package:thu_gom/models/trash/user_request_trash_model.dart';
import 'package:thu_gom/repositories/user_request_trash_reponsitory.dart';
import 'package:thu_gom/shared/constants/appwrite_constants.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/widgets/custom_dialogs.dart';
import 'package:uuid/uuid.dart';

class RequestPersonController extends GetxController {
  final UserRequestTrashRepository _requestRepository;

  RequestPersonController(this._requestRepository);

  //Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final desriptionFieldKey = GlobalKey<FormFieldState>();
  final addressFieldKey = GlobalKey<FormFieldState>();
  final phoneNumberFieldKey = GlobalKey<FormFieldState>();

  final weightFieldKey = GlobalKey<FormFieldState>();
  final TextEditingController weightController = TextEditingController(text: '0');
  RxInt weight = 0.obs;
  RxInt weighMetal = 0.obs;
  RxInt weighPaper = 0.obs;
  RxInt weighBottle = 0.obs;
  RxInt weighHDPE = 0.obs;
  RxInt weighNilon = 0.obs;
  RxInt weighOthers = 0.obs;

  dynamic argumentData = Get.arguments;

  //Handle button
  RxBool loading = true.obs;
  late String title;
  late String requestId;
  late String userId;
  late String imageLink;
  RxString imagePath = "".obs;
  RxString name = "".obs;
  RxString address = "".obs;
  RxString phoneNumber = "".obs;
  RxString description = "".obs;
  late String pointLatitute;
  late String pointLongitute;
  String status = "pending";
  late String trashType;
  late String confirm = "";

  late UserRequestTrashModel requestDetailModel;
  final picker = ImagePicker();
  late File image;
  late Image imageWidget; 

  final GetStorage _getStorage = GetStorage();

  @override
  onInit() async {
    title = argumentData['categoryTitle'] ?? "";
    trashType = argumentData['categoryTitle'] ?? "";
    name.value = DataManager().getData("name");
    userId = DataManager().getData("userId");
    phoneNumber.value = await _getStorage.read('zalonumber');
    address.value = await _getStorage.read('address');
    loading.value = false;
    getUserLocation();

    super.onInit();
  }

  //Person
  Future<void> sendRequestToAppwrite() async {
    CustomDialogs.showLoadingDialog();
    await uploadImageToAppwrite();
    UserRequestTrashModel userRequestTrashModel = UserRequestTrashModel(
        requestId: Uuid().v1(),
        senderId: userId,
        trash_type: trashType,
        image: imageLink,
        phone_number: phoneNumber.value,
        address: address.value,
        description: description.value,
        point_lat: double.parse(pointLatitute),
        point_lng: double.parse(pointLongitute),
        status: status,
        confirm: null,
        hidden: [],
        createAt: DateTime.now().toString(),
        updateAt: DateTime.now().toString(),
        amount_collected: weight.value.toString(),
        metal: weighMetal.value.toString(),
        paper: weighPaper.value.toString(),
        bottle: weighBottle.value.toString(),
        hdpe: weighHDPE.value.toString(),
        nilon: weighNilon.value.toString(),
        others: weighOthers.value.toString()
    );
    print(userRequestTrashModel.toString());

    await _requestRepository
        .sendRequestToAppwrite(userRequestTrashModel)
        .then((value) {
      CustomDialogs.hideLoadingDialog();
      Get.offAllNamed('/mainPage');
      CustomDialogs.showSnackBar(
          2, "Yêu cầu đã được gửi thành công", 'success');
    }).catchError((onError) {
      CustomDialogs.hideLoadingDialog();
      print(onError);
      CustomDialogs.showSnackBar(
          2, "Đã có lỗi xảy ra vui lòng thử lại sau!", 'error');
    });
  }

  Future<void> sendFeedbackToAppwrite() async {
    CustomDialogs.showLoadingDialog();
    await uploadImageToAppwrite();
    UserRequestTrashModel userRequestTrashModel = UserRequestTrashModel(
        requestId: Uuid().v1(),
        senderId: userId,
        trash_type: "",
        image: imageLink,
        phone_number: phoneNumber.value,
        address: address.value,
        description: description.value,
        point_lat: double.parse(pointLatitute),
        point_lng: double.parse(pointLongitute),
        status: "",
        hidden: [],
        createAt: DateTime.now().toString(),
        updateAt: DateTime.now().toString()
        );

    await _requestRepository
        .sendFeedbackToAppwrite(userRequestTrashModel)
        .then((value) {
      CustomDialogs.hideLoadingDialog();
      Get.offAllNamed('/mainPage');
      CustomDialogs.showSnackBar(
          2, "Yêu cầu đã được gửi thành công", 'success');
    }).catchError((onError) {
      CustomDialogs.hideLoadingDialog();
      print(onError);
      CustomDialogs.showSnackBar(
          2, "Đã có lỗi xảy ra vui lòng thử lại sau!", 'error');
    });
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
      // uploadImageToAppwrite();
    }
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
      image = File(pickedFile.path);
      imageWidget = Image.file(
        image,
        fit: BoxFit.fill, 
        cacheHeight: 400, 
        cacheWidth: 400
      );
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

  Future<void> getUserLocation() async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
    } else {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Quyền vị trí bị từ chối');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Quyền vị trí bị từ chối vĩnh viễn, chúng tôi không thể yêu cầu quyền.');
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      DataManager().saveData('latitude', '${position.latitude}');
      DataManager().saveData('longitude', '${position.longitude}');
      pointLatitute = position.latitude.toString();
      pointLongitute = position.longitude.toString();
    }
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
