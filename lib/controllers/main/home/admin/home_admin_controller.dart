import 'package:appwrite/models.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:thu_gom/repositories/user_request_trash_reponsitory.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/widgets/custom_dialogs.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_file/open_file.dart';

class HomeAdminController extends GetxController {
  final UserRequestTrashRepository _userRequestTrashRepository;
  HomeAdminController(this._userRequestTrashRepository);
  // Form Key
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  // Field Key
  final dateRangeFieldKey = GlobalKey<FormBuilderFieldState>();

  final Rx<DateTimeRange?> selectedDateRange = Rx<DateTimeRange?>(null);
  RxString chartType = 'bar'.obs;

  final CarouselController carouselController = CarouselController();
  var currentIndex = 0.obs;
  final List<String> images = [
    'assets/images/bar_chart.gif',
    'assets/images/line_chart.gif',
    'assets/images/pie_chart.gif',
  ];
  var selectedIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future loadRequestByRange() async {
    CustomDialogs.showLoadingDialog();
    if (formKey.currentState!.saveAndValidate()) {
      final dateRange = dateRangeFieldKey.currentState?.value.toString() ?? '';
      final response =
          await _userRequestTrashRepository.getRequestByDateRange(dateRange);
      if (response.documents.isEmpty) {
        CustomDialogs.hideLoadingDialog();
        CustomDialogs.showSnackBar(2, "Không có dữ liệu trong khoảng thời gian này", 'error');
      } else {
        exportDataToExcel(response,dateRange);
      }
    }
  }

  void exportDataToExcel(DocumentList data, String dateRange) async {
  // Extract start and end dates from the original string
  List<String> dateParts = dateRange.split(" - ");
  String startDate = dateParts[0].substring(0, 10);
  String endDate = dateParts[1].substring(0, 10);

  // Combine the formatted dates
  final formattedDateRange = "$startDate-$endDate";

  final fileName = formattedDateRange.replaceAll(' ', '_');
  final response = await _userRequestTrashRepository.exportRequestToExcel(data, fileName);

  if (response.isNotEmpty) {
    CustomDialogs.hideLoadingDialog();
    CustomDialogs.showSnackBar(2, "Tải xuống báo cáo thành công", 'success');
    // Open the downloaded file 
    // /storage/emulated/0/Download/2024-03-01-2024-03-08.xlsx
  print(response);
  OpenFile.open(response, type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", uti: "com.microsoft.excel.xlsx");

    
  } else {
    CustomDialogs.hideLoadingDialog();
    CustomDialogs.showSnackBar(2, "Xuất báo cáo thất bại", 'error');
  }
  }

}
