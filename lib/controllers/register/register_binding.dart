import 'package:thu_gom/controllers/register/register_controller.dart';
import 'package:thu_gom/providers/auth_provider.dart';
import 'package:thu_gom/repositories/auth_reposistory.dart';
import 'package:get/get.dart';

class RegisterBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => 
                RegisterController(AuthRepository(AuthProvider())));
  }
}