import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingController extends GetxController {
  final getStorage = GetStorage();
  @override
  void onInit() {
    super.onInit();

  }

  onSkip() {
    getStorage.write('isOnboardingComplete', true);
    Get.offAllNamed('/main');
  }

  @override
  void onClose() {
    super.onClose();
  }
}