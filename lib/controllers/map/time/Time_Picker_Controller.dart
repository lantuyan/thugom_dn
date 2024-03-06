import 'package:get/get.dart';

class TimePickerController extends GetxController {
  final Rx<DateTime> startTime = DateTime.now().obs;
  final Rx<DateTime> endTime = DateTime.now().obs;

  void updateStartTime(DateTime newTime) {
    startTime.value = newTime;
  }

  void updateEndTime(DateTime newTime) {
    endTime.value = newTime;
  }
}
