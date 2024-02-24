import 'package:get/instance_manager.dart';

import 'services/api_servies.dart';
import 'services/base_provider.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BaseProvider(), permanent: true);
    Get.put(ApiService(Get.find()), permanent: true);
  }
}