import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class HomeAdminController extends GetxController {
  // Form Key
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  // Field Key
  final dateRangeFieldKey = GlobalKey<FormBuilderFieldState>();

  final Rx<DateTimeRange?> selectedDateRange = Rx<DateTimeRange?>(null);
  RxString chartType ='bar'.obs;

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

}