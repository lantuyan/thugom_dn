import 'package:get/get.dart';
import 'package:thu_gom/controllers/profile/profile_controller.dart';
import 'package:thu_gom/providers/auth_provider.dart';
import 'package:thu_gom/repositories/auth_reposistory.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController(AuthRepository(AuthProvider())));
  }
}