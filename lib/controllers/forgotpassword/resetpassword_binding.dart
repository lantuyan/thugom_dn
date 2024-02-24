import 'package:thu_gom/controllers/forgotpassword/resetpassword_controller.dart';
import 'package:thu_gom/providers/auth_provider.dart';
import 'package:thu_gom/repositories/auth_reposistory.dart';
import 'package:get/get.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPassWordController>(
        () => ResetPassWordController(AuthRepository(AuthProvider())));
  }


}
