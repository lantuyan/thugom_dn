import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:thu_gom/models/chart/bar_chart_model.dart';
import 'package:thu_gom/repositories/user_request_trash_reponsitory.dart';

class BarChartController extends GetxController {
  final UserRequestTrashRepository _userRequestTrashRepository;
  BarChartController(this._userRequestTrashRepository);
  //Date Range Data
  RxMap data = {}.obs;
  List<BarChartModel> barData = [];
  final RxBool loading = true.obs;

  List<String> dateList = [];
  late List<String> dates;
  late DateTime startDate;
  late DateTime endDate;
  List<int> totalRequest = [];
  RxInt requestNumber = 0.obs;
  RxInt totalrequestPendingNumber = 0.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    data.value = await Get.arguments;
    // GET DATE FROM ADMIN SCREEN
    dates = data.value['dateRange'].toString().split(" - ");
    startDate = DateTime.parse(dates[0]);
    endDate = DateTime.parse(dates[1]);

    // CHECK FILTER KHÔNG QUÁ 7 NGÀY
    Duration difference = endDate.difference(startDate);
    if (difference.inDays >= 8) {
    } else {
      for (DateTime date = startDate;
          date.isBefore(endDate) || date.isAtSameMomentAs(endDate);
          date = date.add(Duration(days: 1))) {
        String formattedDateRequest = DateFormat('yyyy-MM-dd').format(date);
        String formattedDate = DateFormat('dd/M').format(date);
        dateList.add(formattedDate);
        requestNumber.value = await loadRequestByDate(formattedDateRequest);
        totalrequestPendingNumber.value = totalrequestPendingNumber.value + await loadRequestPendingByDate(formattedDateRequest);
        barData.add(BarChartModel(formattedDateRequest, requestNumber.value));
        totalRequest.add(requestNumber.value);
      }
    }
    loading.value = false;
  }

// TRẢ VỀ LƯỢT REQUEST
  Future<int> loadRequestByDate(String date) async {
    int quantityRX = 0;
    final response =
        await _userRequestTrashRepository.loadRequestByDate(date).then((value) {
      quantityRX = value;
    }).catchError((onError) {
      print(onError);
    });
    return quantityRX;
  }

  Future<int> loadRequestPendingByDate(String date) async {
    try {
      final value = await _userRequestTrashRepository.loadRequestPendingByDate(date);
      return value;
    } catch (e) {
      print("Error $e");
      return 0;
    }
  }
}
