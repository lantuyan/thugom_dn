import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thu_gom/managers/data_manager.dart';
import 'package:thu_gom/repositories/auth_reposistory.dart';
import 'package:thu_gom/repositories/user_request_trash_reponsitory.dart';
import 'package:thu_gom/shared/constants/appwrite_constants.dart';
import 'package:thu_gom/widgets/custom_dialogs.dart';

class ProfileController extends GetxController {
  final AuthRepository _authRepository;
  final UserRequestTrashRepository _requestRepository;

  ProfileController(this._authRepository, this._requestRepository);
  //Get Storage
  final GetStorage _getStorage = GetStorage();
  // district and sub district list
  List<String> districts = [
    "Quận Cẩm Lệ",
    "Quận Hải Châu",
    "Quận Liên Chiểu",
    "Quận Ngũ Hành Sơn",
    "Quận Sơn Trà",
    "Quận Thanh Khê",
    "Huyện Hòa Vang",
    "Huyện Hoàng Sa"
  ];
  Map<String, List<String>> subDistricts = {
    "Quận Cẩm Lệ": [
      "Phường Hòa Xuân",
      "Phường Khuê Trung",
      "Phường Hòa Thọ Tây",
      "Phường Hòa Thọ Đông",
      "Phường Hòa Phát",
      "Phường Hòa An"
    ],
    "Quận Hải Châu": [
      "Phường Nam Dương",
      "Phường Bình Thuận",
      "Phường Hải Châu I",
      "Phường Hải Châu II",
      "Phường Hòa Thuận Tây",
      "Phường Hòa Thuận Đông",
      "Phường Bình Hiên",
      "Phường Thanh Bình",
      "Phường Thạch Thang",
      "Phường Phước Ninh",
      "Phường Hòa Cường Nam",
      "Phường Hòa Cường Bắc",
      "Phường Thuận Phước"
    ],
    "Quận Liên Chiểu": [
      "Phường Hòa Khánh Bắc",
      "Phường Hòa Khánh Nam",
      "Phường Hòa Hiệp Bắc",
      "Phường Hòa Hiệp Nam",
      "Phường Hòa Minh"
    ],
    "Quận Ngũ Hành Sơn": [
      "Phường Hoà Quý",
      "Phường Mỹ An",
      "Phường Hoà Hải",
      "Phường Khuê Mỹ"
    ],
    "Quận Sơn Trà": [
      "Phường Phước Mỹ",
      "Phường Nại Hiên Đông",
      "Phường An Hải Bắc",
      "Phường An Hải Đông",
      "Phường An Hải Tây",
      "Phường Thọ Quang",
      "Phường Mân Thái"
    ],
    "Quận Thanh Khê": [
      "Phường Tân Chính",
      "Phường Thạc Gián",
      "Phường Hòa Khê",
      "Phường Thanh Khê Đông",
      "Phường Thanh Khê Tây",
      "Phường Vĩnh Trung",
      "Phường Xuân Hà",
      "Phường Tam Thuận",
      "Phường Chính Gián",
      "Phường An Khê"
    ],
    "Huyện Hòa Vang": [
      "Xã Hòa Tiến",
      "Xã Hòa Bắc",
      "Xã Hòa Sơn",
      "Xã Hòa Phong",
      "Xã Hòa Phước",
      "Xã Hòa Nhơn",
      "Xã Hòa Khương",
      "Xã Hòa Ninh",
      "Xã Hòa Liên",
      "Xã Hòa Phú",
      "Xã Hòa Châu"
    ],
  };

  RxString selectedDistrict = ''.obs;
  RxString selectedSubDistrict = ''.obs;
  // Form Key
    final GlobalKey<FormState> formKey = GlobalKey();
  //Key
  final nameFieldKey = GlobalKey<FormFieldState>();
  final phonenumberFieldKey = GlobalKey<FormFieldState>();
  final zalonumberFieldKey = GlobalKey<FormFieldState>();
  final streetFieldKey = GlobalKey<FormFieldState>();

  final TextEditingController phonenumberController = TextEditingController(
    text: DataManager().getData('phonenumber')
  );
  final TextEditingController zalonumberController = TextEditingController(
    text: DataManager().getData('zalonumber')
  );

  var role;
  RxString phonenumber = ''.obs;
  RxString zalonumber = ''.obs;

  var registerType;
  RxBool isLoading = true.obs;

  // chan dung
  
  late String imageLink;
  RxString imagePath = "".obs;
  late String uid_user;
  RxMap data = {}.obs;
  late File imageFiles;


  @override
  Future<void> onInit() async {
    super.onInit();
    uid_user = await _getStorage.read('uid');
    selectedDistrict.value = districts.first;
    selectedSubDistrict.value = subDistricts[selectedDistrict.value]!.first;
    role = await _getStorage.read('role');
    registerType = await _getStorage.read('registerType');
    if (registerType == 'sms') {
      phonenumber.value = await _getStorage.read('phonenumber');
      zalonumber.value = phonenumber.value;
    }
    isLoading.value = false;

    phonenumberController.addListener(() {
      if (zalonumber.value.isEmpty) {
        zalonumberController.text = phonenumberController.text;
      }
    });
  }

  @override
  void onClose() {
    phonenumberController.dispose();
    zalonumberController.dispose();
    super.onClose();
  }

  Future<void> uploadImageToAppwrite(File imageFile) async {
    CustomDialogs.showLoadingDialog();
    imagePath.value = imageFile.path;
    imageFiles = File(imageFile.path);
    
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
      // Get.offNamed('/mainPage');

      CustomDialogs.showSnackBar(2, "Gửi thành công", 'success');
    }).catchError((onError) {
      CustomDialogs.hideLoadingDialog();
      print(onError);
      CustomDialogs.showSnackBar(
          2, "Đã có lỗi xảy ra vui lòng thử lại sau!", 'error');
    });
  }

  Future<void> updateProfile() async {
    CustomDialogs.showLoadingDialog();
    // sendImageToAppwrite(uid_user);
    Map<String, dynamic> formValue = {
      "name" : nameFieldKey.currentState!.value,
      "phonenumber" : phonenumberFieldKey.currentState!.value,
      "zalonumber" : zalonumberFieldKey.currentState!.value,
      "street" : streetFieldKey.currentState!.value,
    };

    print("formValue: $formValue");

    String address = formValue['street'] +","+selectedDistrict.value+","+selectedSubDistrict.value;
    final userId = await _getStorage.read('userId');
    if(await _authRepository.checkUserExist(formValue['phonenumber'])){
        CustomDialogs.hideLoadingDialog();
        CustomDialogs.showSnackBar(2,"Số điện thoại đã tồn tại, hãy thử lại với số khác", 'error');
    } else{
        await _authRepository.updateProfile(formValue, address, userId,imageLink ).then((value) async {
        await _getStorage.write('name', formValue['name']);
        await _getStorage.write('phonenumber', formValue['phonenumber']);
        await _getStorage.write('zalonumber', formValue['zalonumber']);
        await _getStorage.write('address', address);
        await _getStorage.write('avatar', imageLink);

        DataManager().saveData('userId', userId);
        DataManager().saveData('name', formValue['name']);
        DataManager().saveData('role', await _getStorage.read('role'));
        DataManager().saveData('zalonumber', formValue['zalonumber']);
        DataManager().saveData('phonenumber', formValue['phonenumber']);
        DataManager().saveData('address', address);
        DataManager().saveData('avatar', imageLink);
        
        CustomDialogs.hideLoadingDialog();
        Get.offAllNamed('/mainPage');
        }).catchError((onError){
          print(onError); 
          CustomDialogs.hideLoadingDialog();
          CustomDialogs.showSnackBar(2, "Đã có lỗi xảy ra vui lòng thử lại sau!", 'error');
        });
    }
  }
}
