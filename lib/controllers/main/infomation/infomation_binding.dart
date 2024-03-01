
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:thu_gom/controllers/main/infomation/infomation_controller.dart';

class InfomationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfomationController>(() => InfomationController());
  }
}
