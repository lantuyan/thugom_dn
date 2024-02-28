import 'package:get/get.dart';
import 'package:thu_gom/controllers/main/home/home_controller.dart';
import 'package:thu_gom/providers/category_provider.dart';
import 'package:thu_gom/providers/user_request_trash_provider.dart';
import 'package:thu_gom/repositories/category_reponsitory.dart';
import 'package:thu_gom/repositories/user_request_trash_reponsitory.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(
        CategoryRepository(CategoryProvider()),
        UserRequestTrashRepository(UserRequestTrashProvider())));
  }
}
