import 'package:get/get.dart';
import 'package:thu_gom/controllers/main/request_person/request_person_controller.dart';
import 'package:thu_gom/providers/user_request_trash_provider.dart';
import 'package:thu_gom/repositories/user_request_trash_reponsitory.dart';

class RequestPersonBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RequestPersonController>(() 
    => RequestPersonController(UserRequestTrashRepository(UserRequestTrashProvider())));
  }
}