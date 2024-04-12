import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:thu_gom/controllers/main/infomation/infomation_controller.dart';
import 'package:thu_gom/providers/user_request_trash_provider.dart';
import 'package:thu_gom/repositories/user_request_trash_reponsitory.dart';

class InfomationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfomationController>(() => InfomationController(
        UserRequestTrashRepository(UserRequestTrashProvider())));
  }
}
