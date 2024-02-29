import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thu_gom/managers/data_manager.dart';
import 'package:thu_gom/models/trash/user_request_trash_model.dart';
import 'package:thu_gom/repositories/user_request_trash_reponsitory.dart';
import 'package:thu_gom/shared/constants/appwrite_constants.dart';
import 'package:thu_gom/widgets/custom_dialogs.dart';
import 'package:uuid/uuid.dart';

class RequestPersonController extends GetxController {
  final UserRequestTrashRepository _requestRepository;

  RequestPersonController(this._requestRepository);

  //Key
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final desriptionFieldKey = GlobalKey<FormBuilderFieldState>();
  final addressFieldKey = GlobalKey<FormBuilderFieldState>();
  final phoneNumberFieldKey = GlobalKey<FormBuilderFieldState>();

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

  @override
  onInit() {
    title = argumentData['categoryTitle'];
    trashType = argumentData['categoryTitle'];
    name.value = DataManager().getData("name");
    userId = DataManager().getData("userId");
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
        updateAt: DateTime.now().toString());
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
}
