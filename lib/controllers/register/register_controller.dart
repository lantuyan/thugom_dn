import 'package:appwrite/appwrite.dart';
import 'package:thu_gom/repositories/auth_reposistory.dart';
import 'package:thu_gom/widgets/custom_dialogs.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RegisterController extends GetxController {
  final AuthRepository _authRepository;

  RegisterController(this._authRepository);
  // Form Key
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  
  final nameFieldKey = GlobalKey<FormBuilderFieldState>();
  final emailFieldKey = GlobalKey<FormBuilderFieldState>();
  final passwordFieldKey = GlobalKey<FormBuilderFieldState>();
  final confirmPasswordFieldKey = GlobalKey<FormBuilderFieldState>();

  RxBool passwordVisible = true.obs;
  RxBool confirmPasswordVisible = true.obs;

  void register(Map<String, dynamic> formData) {
    CustomDialogs.hideLoadingDialog();
    CustomDialogs.showLoadingDialog();
    try {
      // _authRepository.register(formData).then((value) {
      //   CustomDialogs.hideLoadingDialog();
      //   Get.offAllNamed('/register');
      //   CustomDialogs.showSnackBar(2, "register_success".tr, 'success');
      // }).catchError((error) {
      //   if (error is AppwriteException) {
      //     CustomDialogs.hideLoadingDialog();
      //     CustomDialogs.showSnackBar(2, "register_wrong".tr, 'error');
      //   } else {
      //     CustomDialogs.hideLoadingDialog();
      //     CustomDialogs.showSnackBar(2, "wrong".tr, 'error');
      //   }
      // });
    } catch (e) {
      CustomDialogs.hideLoadingDialog();
      CustomDialogs.showSnackBar(2, "wrong".tr, 'error');
      
    }

  }
}
