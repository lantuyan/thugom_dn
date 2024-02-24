import 'package:thu_gom/controllers/login/login_controller.dart';
import 'package:thu_gom/providers/auth_provider.dart';
import 'package:thu_gom/repositories/auth_reposistory.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(AuthRepository(AuthProvider())));
  }
}