import 'package:get/get.dart';
import 'package:thu_gom/providers/user_provider.dart';
import 'package:thu_gom/repositories/user_reposistory.dart';

import 'main_controller.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController(UserRepository(UserProvider())));
  }
}
