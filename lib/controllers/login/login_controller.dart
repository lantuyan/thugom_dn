import 'package:appwrite/appwrite.dart';
import 'package:thu_gom/managers/data_manager.dart';
import 'package:thu_gom/models/user/user_model.dart';
import 'package:thu_gom/repositories/auth_reposistory.dart';
import 'package:thu_gom/widgets/custom_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository;
  LoginController(this._authRepository);

  // Form Key
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> formLoginWithPhoneKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormState> formPinCodeKey = GlobalKey<FormState>();
  // Field Key
  final emailFieldKey = GlobalKey<FormBuilderFieldState>();
  final passwordFieldKey = GlobalKey<FormBuilderFieldState>();
  final nameFieldKey = GlobalKey<FormBuilderFieldState>();
  // Password Visible Bool
  RxBool passwordVisible = true.obs;
  //Get Storage
  final GetStorage _getStorage = GetStorage();
  @override
  void onInit() {
    super.onInit();
  }

  //Login method
  Future<void> login(Map map) async {
    try {
      CustomDialogs.showLoadingDialog();
      var value = await _authRepository.login({
        'email': map['email'],
        'password': map['password']
      });
      bool isBlackList = await _authRepository.checkUserBlackList(value.userId);
      if (isBlackList) {
        CustomDialogs.hideLoadingDialog();
        CustomDialogs.showSnackBar(2, "Tài khoản của bạn đã bị khóa", 'error');
      } else {
      _getStorage.write('userId', value.userId);
      _getStorage.write('sessionId', value.$id);
      var userModel = await getUserModel(value.userId);
      await _getStorage.write('name', userModel.name);
      await _getStorage.write('role', userModel.role);
      await _getStorage.write('zalonumber', userModel.zalonumber);
      await _getStorage.write('address', userModel.address);
      CustomDialogs.hideLoadingDialog();
      DataManager().saveData('userId', value.userId);
      DataManager().saveData('sessionId', value.$id);
      DataManager().saveData('name', userModel.name);
      DataManager().saveData('role', userModel.role);
      DataManager().saveData('zalonumber', userModel.zalonumber);
      DataManager().saveData('address', userModel.address);

      Get.offAllNamed('/mainPage');
      }
    } catch (error) {
      CustomDialogs.hideLoadingDialog();
      print(error);
      if (error is AppwriteException && error.type == 'user_invalid_credentials') {
        CustomDialogs.showSnackBar(2, "Thông tin không hợp lệ. Vui lòng kiểm tra email và mật khẩu", 'error');
      } else {
        CustomDialogs.showSnackBar(2, "Đã có lỗi xảy ra vui lòng thử lại sau!", 'error');
      }
    }
  }
  Future<UserModel> getUserModel(String userId) async {
    var userModel = await _authRepository.getUserModel(userId);
    return userModel;
  }

  // Future<void> updateUserInfo(String userId,String? name) async {
  //   try{
  //     await _authRepository.updateUserInfo(userId, name!);
  //   }catch(e){
  //     if(e is AppwriteException && e.type == 'document_already_exists'){
  //       Get.offAllNamed('/main');
  //     }
  //   }
  // }
  //Logout
  void logout() async {
    CustomDialogs.showLoadingDialog();
    try {
      await _authRepository.logOut(_getStorage.read('sessionId')).then((value){
        CustomDialogs.hideLoadingDialog();
        _getStorage.remove('userId');
        _getStorage.remove('sessionId');
        _getStorage.remove('name');
        _getStorage.remove('role');
        _getStorage.remove('zalonumber');
        _getStorage.remove('address');
        DataManager().clearData();
        Get.offAllNamed("/login");
      }).catchError((onError){
        print(onError);
        CustomDialogs.hideLoadingDialog();
        CustomDialogs.showSnackBar(2, "wrong".tr, 'error');
      });
    }catch(error){
      print(error);
      CustomDialogs.hideLoadingDialog();
      CustomDialogs.showSnackBar(2, "wrong".tr, 'error');
    }
  }

}
