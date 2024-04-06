import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thu_gom/managers/data_manager.dart';
import 'package:thu_gom/repositories/auth_reposistory.dart';
import 'package:thu_gom/widgets/custom_dialogs.dart';

class ProfileController extends GetxController {
  final AuthRepository _authRepository;

  ProfileController(this._authRepository);
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
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  //Key
  final nameFieldKey = GlobalKey<FormBuilderFieldState>();
  final phonenumberFieldKey = GlobalKey<FormBuilderFieldState>();
  final zalonumberFieldKey = GlobalKey<FormBuilderFieldState>();
  final streetFieldKey = GlobalKey<FormBuilderFieldState>();
  var role;
  var phonenumber;
  var registerType;
  RxBool isLoading = true.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    selectedDistrict.value = districts.first;
    selectedSubDistrict.value = subDistricts[selectedDistrict.value]!.first;
    role = await _getStorage.read('role');
    registerType = await _getStorage.read('registerType');
    if(registerType == 'sms'){
      phonenumber = await _getStorage.read('phonenumber');
    }
    isLoading.value = false;
  }

  Future<void> updateProfile(Map formValue) async {
    CustomDialogs.showLoadingDialog();
    String address = formValue['street'] +","+selectedDistrict.value+","+selectedSubDistrict.value;
    final userId = await _getStorage.read('userId');
    await _authRepository.updateProfile(formValue, address, userId).then((value) async {
      await _getStorage.write('name', formValue['name']);
      await _getStorage.write('phonenumber', formValue['phonenumber']);
      await _getStorage.write('zalonumber', formValue['zalonumber']);
      await _getStorage.write('address', address);
      DataManager().saveData('userId', userId);
      DataManager().saveData('name', formValue['name']);
      DataManager().saveData('role', await _getStorage.read('role'));
      DataManager().saveData('zalonumber', formValue['zalonumber']);
      DataManager().saveData('phonenumber', formValue['phonenumber']);
      DataManager().saveData('address', address);
      CustomDialogs.hideLoadingDialog();
      Get.offAllNamed('/mainPage');
    }).catchError((onError){
      print(onError); 
      CustomDialogs.hideLoadingDialog();
      CustomDialogs.showSnackBar(2, "Đã có lỗi xảy ra vui lòng thử lại sau!", 'error');
    });
  }
}
