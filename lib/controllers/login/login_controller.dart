import 'package:appwrite/appwrite.dart';
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
  final phoneFieldKey = GlobalKey<FormFieldState>();
  final TextEditingController phoneFieldController = TextEditingController();

  //
  var checkName = false;
  // Password Visible Bool
  RxBool passwordVisible = true.obs;
  //Get Storage
  final GetStorage _getStorage = GetStorage();
  var phoneNumber;
  var name;
  var pinCode;
  var userId;
  @override
  void onInit() {
    super.onInit();
  }

  //Login method
  login(Map map) async {
    CustomDialogs.hideLoadingDialog();
    CustomDialogs.showLoadingDialog();
    try {
      await _authRepository.login({
            'email': map['email'],
            'password': map['password']
          }).then((value) {
            CustomDialogs.hideLoadingDialog();
            _getStorage.write('userId', value.userId);
            _getStorage.write('sessionId', value.$id);
            Get.offAllNamed('/main');
          }).catchError((error) {
        if (error is AppwriteException) {
          CustomDialogs.hideLoadingDialog();
          CustomDialogs.showSnackBar(2, "login wrong".tr, 'error');
        } else {
          CustomDialogs.hideLoadingDialog();
          CustomDialogs.showSnackBar(2, "wrong".tr, 'error');
        }
      });
    } catch (e) {
      CustomDialogs.hideLoadingDialog();
      CustomDialogs.showSnackBar(2, "wrong".tr, 'error');
    }
  }
  //Login with OAuth2 method
  loginWithOAuth2(String provider) async {
    CustomDialogs.hideLoadingDialog();
    CustomDialogs.showLoadingDialog();
    try{
      await _authRepository.loginOAuth2(provider).then((value){
        _authRepository.getCurrentSession().then((value){
          _getStorage.write('userId', value.userId);
          _getStorage.write('sessionId', value.$id);
          Get.offAllNamed('/main');
        });
      }).catchError((error){
        CustomDialogs.hideLoadingDialog();
        CustomDialogs.showSnackBar(2, "wrong".tr, 'error');
      });
    }catch(e){
      CustomDialogs.hideLoadingDialog();
      CustomDialogs.showSnackBar(2, "wrong".tr, 'error');
    }
  }
  //Login with phone number method
  Future<void> loginWithPhoneNumber(String? phoneNumber,String? name) async {
    if(phoneNumber == null || phoneNumber == "" ){
      CustomDialogs.showSnackBar(2, "wrong".tr, 'error');
    }else{
      try {
        var result = await _authRepository.loginWithPhoneNumber(phoneNumber);
        if(result !=null){
          userId = result;
          Get.offAndToNamed('otp-confirm');
        }
      } catch (e) {
        CustomDialogs.showSnackBar(2, "wrong".tr, 'error');
      }
    }
  }
  Future<void> verifyPhone(String pinCode,String? name) async {
    try {
      await _authRepository.phoneConfirm(pinCode,userId,name!).then((value) async {
        _getStorage.write('userId', value.userId);
        _getStorage.write('sessionId', value.$id);
        await updateUserInfo(value.userId,name);
        Get.offAllNamed('/main');
      });
    } catch (e) {
      CustomDialogs.showSnackBar(2, "wrong".tr, 'error');
    }
  }
  Future<void> updateUserInfo(String userId,String? name) async {
    try{
      await _authRepository.updateUserInfo(userId, name!);
    }catch(e){
      if(e is AppwriteException && e.type == 'document_already_exists'){
        Get.offAllNamed('/main');
      }
    }
  }
  //Logout
  void logout() async {
    CustomDialogs.showLoadingDialog();
    try {
      await _authRepository.logOut(_getStorage.read('sessionId')).then((value){
        CustomDialogs.hideLoadingDialog();
        _getStorage.remove('userId');
        _getStorage.remove('sessionId');
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
