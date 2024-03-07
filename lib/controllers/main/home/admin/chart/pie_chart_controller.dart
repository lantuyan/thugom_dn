import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thu_gom/models/chart/pie_chart_model.dart';
import 'package:thu_gom/repositories/user_request_trash_reponsitory.dart';

class PieChartController extends GetxController {
  final UserRequestTrashRepository _userRequestTrashRepository;
  PieChartController(this._userRequestTrashRepository);
  //Date Range Data
  RxMap data = {}.obs;
  //
  RxInt rcc = 0.obs;
  RxInt rxd = 0.obs;
  RxInt rtc = 0.obs;
  RxInt rk = 0.obs;
  RxInt total = 0.obs;
  List<PieChartModel> pieData = [];
  final RxBool loading = true.obs;
  final touchedIndex = (-1).obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    data.value = await Get.arguments;
    rcc.value =  await loadRequestByType('rac cong kenh',data.value['dateRange'].toString());
    rxd.value = await loadRequestByType('rac xay dung',data.value['dateRange'].toString());
    rtc.value = await loadRequestByType('rac tai che',data.value['dateRange'].toString());
    rk.value = await loadRequestByType('rac khac',data.value['dateRange'].toString());
    total.value = rcc.value+rxd.value+rtc.value+rk.value;
    if(rcc.value ==0  && rxd.value ==0 && rtc.value ==0 && rk.value==0){
    }else{
      pieData.addAll({
        PieChartModel('Rác Cồng Kềnh',(rcc.value/total.value*100).roundToDouble(),rcc.value,Colors.blue),
        PieChartModel('Rác Xây Dựng',(rxd.value/total.value*100).roundToDouble(),rxd.value,Colors.yellow),
        PieChartModel('Rác Tái Chế',(rtc.value/total.value*100).roundToDouble(),rtc.value,Colors.purple),
        PieChartModel('Rác Khác',(rk.value/total.value*100).roundToDouble(),rk.value,Colors.green),
      });
    }
    loading.value = false;
  }
  Future<int> loadRequestByType(String type,String dateRange) async {
    int quantity = 0 ;
    final response = await _userRequestTrashRepository.loadRequestByType(type,dateRange).then((value){
      quantity = value;
    }).catchError((onError){
      print(onError);
    });
    return quantity;
  }

}