import 'package:get/get.dart';
import 'package:thu_gom/controllers/profile/profile_controller.dart';
import 'package:thu_gom/providers/auth_provider.dart';
import 'package:thu_gom/providers/user_request_trash_provider.dart';
import 'package:thu_gom/repositories/auth_reposistory.dart';
import 'package:thu_gom/repositories/user_request_trash_reponsitory.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController(
        AuthRepository(AuthProvider()),
        UserRequestTrashRepository(UserRequestTrashProvider())));
  }
}
