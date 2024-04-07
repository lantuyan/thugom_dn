import 'package:appwrite/appwrite.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thu_gom/managers/data_manager.dart';
import 'package:thu_gom/repositories/auth_reposistory.dart';
import 'package:thu_gom/widgets/custom_dialogs.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../models/user/user_model.dart';

class RegisterOrLoginWithPhoneController extends GetxController {
  final AuthRepository _authRepository;

  RegisterOrLoginWithPhoneController(this._authRepository);
  // Form Key
  final GlobalKey<FormBuilderState> registerLoginWithPhoneKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormState> formPinCodeKey = GlobalKey<FormState>();
  //Get Storage
  final GetStorage _getStorage = GetStorage();
  RxString roleField = 'person'.obs;
  RxString actionType = "".obs;
  final phoneFieldKey = GlobalKey<FormFieldState>();
  final TextEditingController phoneFieldController = TextEditingController();
  var phoneNumber;
  var dialCode;
  var pinCode;
  var userId;
  @override
  void onInit() async {
    actionType.value = await Get.arguments['actionType']??"";
  }
  Future <void> registerWithPhone() async {
    CustomDialogs.showLoadingDialog();
    try{
      if(await _authRepository.checkUserExist(phoneNumber)){
        CustomDialogs.hideLoadingDialog();
        CustomDialogs.showSnackBar(2,"Người dùng đã tồn tại, hãy thử lại với số khác", 'error');
      }else{
        userId = await _authRepository.registerOrLoginWithPhoneNumber(dialCode+phoneNumber);
        if(userId != null ){
          Get.offAndToNamed('/otpConfirmPage');
        }
      }
    }catch(e){
      print(e);
      CustomDialogs.hideLoadingDialog();
      CustomDialogs.showSnackBar(2, "Đã có lỗi xảy ra vui lòng thử lại sau!", 'error');
    }
  }
  Future <void> registerWithPhoneConfirm() async {
    CustomDialogs.showLoadingDialog();
    try{
      await _authRepository.phoneConfirm(pinCode, userId).then((value) async {
        _getStorage.write('userId', value.userId);
        _getStorage.write('sessionId', value.$id);
        // Đoạn này lưu thông tin để qua trang profile check sms với person hay collector
        await _getStorage.write('registerType', 'sms');
        await _getStorage.write('role', roleField.value);
        await _getStorage.write('phonenumber',phoneNumber);
        DataManager().saveData('userId', value.userId);
        DataManager().saveData('sessionId', value.$id);
        DataManager().saveData('role', roleField.value);
        await _authRepository.registerWithPhone({
          'userId' : value.userId,
          'role' : roleField.value,
          'phonenumber' : phoneNumber,
        });
        CustomDialogs.hideLoadingDialog();
        Get.offAllNamed('/introPage');
        CustomDialogs.showSnackBar(2, "Đăng ký tài khoàn thành công", 'success');
      });
    }catch(e){
      print(e);
      CustomDialogs.hideLoadingDialog();
      if(e is AppwriteException && (e.type =="user_invalid_token"||e.type =="general_argument_invalid")){
        CustomDialogs.showSnackBar(2, "Mã xác thực không đúng, vui lòng kiểm tra lại", 'error');
      }else{
        CustomDialogs.showSnackBar(2, "Đã có lỗi xảy ra vui lòng thử lại sau!", 'error');
      }
    }
  }
  Future<void> loginWithPhone() async {
    CustomDialogs.showLoadingDialog();
    try{
      if(await _authRepository.checkUserExist(phoneNumber)){
        userId = await _authRepository.registerOrLoginWithPhoneNumber(dialCode+phoneNumber);
        if(userId != null ){
          Get.offAndToNamed('/otpConfirmPage');
        }
      }else{
        CustomDialogs.hideLoadingDialog();
        CustomDialogs.showSnackBar(2, "Người dùng chưa đăng ký tài khoản!", 'error');
      }
    }catch(e){
      print(e);
      CustomDialogs.hideLoadingDialog();
      CustomDialogs.showSnackBar(2, "Đã có lỗi xảy ra vui lòng thử lại sau!", 'error');
    }
  }
  Future<void> loginWithPhoneConfirm() async {
    CustomDialogs.showLoadingDialog();
    try{
      await _authRepository.phoneConfirm(pinCode, userId).then((value) async {
        final userModel = await _authRepository.getUserModel(value.userId);
        await _getStorage.write('name', userModel.name);
        await _getStorage.write('role', userModel.role);
        await _getStorage.write('sessionId', value.$id);
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
      });
    }catch(e){
      print(e);
      CustomDialogs.hideLoadingDialog();
      CustomDialogs.showSnackBar(2, "Đã có lỗi xảy ra vui lòng thử lại sau!", 'error');
    }
  }
}
