import 'package:thu_gom/controllers/forgotpassword/forgot_password_controller.dart';
import 'package:thu_gom/providers/auth_provider.dart';
import 'package:thu_gom/repositories/auth_reposistory.dart';
import 'package:get/get.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(
        () => ForgotPasswordController(AuthRepository(AuthProvider())));
  }
}
