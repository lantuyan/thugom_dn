import 'package:get/get.dart';
import 'package:thu_gom/controllers/main/home/admin/chart/pie_chart_controller.dart';
import 'package:thu_gom/controllers/main/home/home_controller.dart';
import 'package:thu_gom/providers/user_request_trash_provider.dart';
import 'package:thu_gom/repositories/user_request_trash_reponsitory.dart';

class PieChartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PieChartController>(() => PieChartController(UserRequestTrashRepository(UserRequestTrashProvider())));
  }
}