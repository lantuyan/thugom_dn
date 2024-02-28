import 'package:get/get.dart';
import 'package:thu_gom/controllers/main/request_detail/request_detail_controller.dart';
import 'package:thu_gom/providers/user_request_trash_provider.dart';
import 'package:thu_gom/repositories/user_request_trash_reponsitory.dart';

class RequestDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RequestDetailController>(() => RequestDetailController(UserRequestTrashRepository(UserRequestTrashProvider())));
  }
}