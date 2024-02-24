import 'package:thu_gom/repositories/auth_reposistory.dart';
import 'package:thu_gom/widgets/custom_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ForgotPasswordController extends GetxController {
  final AuthRepository _authRepository;

  ForgotPasswordController(this._authRepository);

  // Form Key
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  // Field Key
  final emailFieldKey = GlobalKey<FormBuilderFieldState>();

  //Get Storage
  // ignore: unused_field
  final GetStorage _getStorage = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  sendLinkResetPassword(Map map) async {
    try {
      print("VÀO");
      await _authRepository.sendLinkResetPassword({
        'email' : map['email'],
      }).then((value){
        print(">>>>>>>>>VALUE: ${value}");
        CustomDialogs.alertDialogeMail();
        CustomDialogs.hideLoadingDialog();
        Get.toNamed('/reset-password');
      });
    } catch (e) {
      CustomDialogs.hideLoadingDialog();
      CustomDialogs.showSnackBar(2, "wrong".tr, 'error');
      print(">>>>>>>>>>>>>>>>ERROR: $e");
    }
  }

}
