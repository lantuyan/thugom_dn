import 'package:appwrite/appwrite.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thu_gom/managers/data_manager.dart';
import 'package:thu_gom/repositories/auth_reposistory.dart';
import 'package:thu_gom/widgets/custom_dialogs.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../models/user/user_model.dart';

class RegisterController extends GetxController {
  final AuthRepository _authRepository;

  RegisterController(this._authRepository);
  // Form Key
  final GlobalKey<FormState> formKey = GlobalKey();
  //Get Storage
  final GetStorage _getStorage = GetStorage();
  //Key
  final nameFieldKey = GlobalKey<FormFieldState>();
  final emailFieldKey = GlobalKey<FormFieldState>();
  final usernameFieldKey = GlobalKey<FormFieldState>();
  final passwordFieldKey = GlobalKey<FormFieldState>();
  final confirmPasswordFieldKey = GlobalKey<FormFieldState>();

  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController usernameController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();
  // final TextEditingController confirmPasswordController = TextEditingController();

  RxBool passwordVisible = true.obs;
  RxBool confirmPasswordVisible = true.obs;
  RxString roleField = 'person'.obs;
  Future<void> register() async {

    CustomDialogs.showLoadingDialog();
    Map<String, dynamic> formData = {
      "email" : emailFieldKey.currentState!.value, 
      "username" : usernameFieldKey.currentState!.value, 
      "password" : passwordFieldKey.currentState!.value
    };
    _authRepository.register(formData,roleField.value).then((value) async {
      await _authRepository.login({
        'email': formData['email'],
        'password': formData['password']
      }).then((value) async {
        _getStorage.write('userId', value.userId);
        _getStorage.write('sessionId', value.$id);
        final userModel = await getUserModel(value.userId);
        await _getStorage.write('name', userModel.name);
        await _getStorage.write('role', userModel.role);
        await _getStorage.write('zalonumber', userModel.zalonumber);
        await _getStorage.write('address', userModel.address);

        DataManager().saveData('userId', value.userId);
        DataManager().saveData('sessionId', value.$id);
        DataManager().saveData('role', userModel.role);
        DataManager().saveData('name', userModel.name);
        DataManager().saveData('zalonumber', userModel.zalonumber);
        DataManager().saveData('address', userModel.address);
      });
      Get.offAllNamed('/introPage');
      CustomDialogs.showSnackBar(2, "Đăng ký tài khoàn thành công", 'success');
    }).catchError((error) {
      print(error);
      CustomDialogs.hideLoadingDialog();
      if (error is AppwriteException && error.type == 'user_already_exists') {
        CustomDialogs.showSnackBar(2,"Người dùng đã tồn tại, hãy thử lại với email khác", 'error');
      } else {
        CustomDialogs.showSnackBar(2, "Đã có lỗi xảy ra vui lòng thử lại sau!", 'error');
      }
    });
  }
  Future<UserModel> getUserModel(String userId) async {
    var userModel = await _authRepository.getUserModel(userId);
    return userModel;
  }
}
