import 'package:thu_gom/repositories/auth_reposistory.dart';
import 'package:thu_gom/widgets/custom_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class ResetPassWordController extends GetxController {
  final AuthRepository _authRepository;
  ResetPassWordController(this._authRepository);

  // Form Key
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  // Field Key
  final passwordFieldKey = GlobalKey<FormBuilderFieldState>();
  final confirmPasswordFieldKey = GlobalKey<FormBuilderFieldState>();

  // Password Visible Bool
  RxBool passwordVisible = true.obs;
  //Get Storage
  // ignore: unused_field
  final GetStorage _getStorage = GetStorage();
  static String? userId;
  static String? secret;

  reset_password(Map map) async {
    print("CLICK");
    print("USER ID: $userId secret: $secret");
    CustomDialogs.hideLoadingDialog();
    CustomDialogs.showLoadingDialog();
    try {
      await _authRepository.resetPassword(
        {
          'password': map['password'],
          'passwordAgain': map['password'],
        },
        userId!,
        secret!,
      ).then((value) {
        CustomDialogs.hideLoadingDialog();
        Get.toNamed('/confirm-success');
      });
    } catch (e) {
      CustomDialogs.hideLoadingDialog();
      CustomDialogs.showSnackBar(2, "wrong".tr, 'error');
    }
  }
}
