import 'package:thu_gom/controllers/register/register_controller.dart';
import 'package:thu_gom/controllers/register/register_or_login_with_phone_controller.dart';
import 'package:thu_gom/providers/auth_provider.dart';
import 'package:thu_gom/repositories/auth_reposistory.dart';
import 'package:get/get.dart';

class RegisterOrLoginWithPhoneBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RegisterOrLoginWithPhoneController>(() =>
        RegisterOrLoginWithPhoneController(AuthRepository(AuthProvider())));
  }
}