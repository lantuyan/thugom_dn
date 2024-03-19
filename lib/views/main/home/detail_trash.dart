import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:thu_gom/controllers/main/home/home_controller.dart';
import 'package:thu_gom/models/trash/category_model.dart';
import 'package:thu_gom/models/trash/category_price_model.dart';
import 'package:thu_gom/providers/category_provider.dart';
import 'package:thu_gom/providers/user_request_trash_provider.dart';
import 'package:thu_gom/repositories/category_reponsitory.dart';
import 'package:thu_gom/repositories/user_request_trash_reponsitory.dart';
import 'package:thu_gom/shared/constants/appwrite_constants.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class DetailTrash extends StatefulWidget {
  // const DetailTrash(
  //     {super.key,
  //     required this.id,
  //     required this.image,
  //     required this.title,
  //     required this.description});
  const DetailTrash({super.key, required this.data});
  // final String id;
  // final String image;
  // final String title;
  // final String description;
  final CategoryModel data;

  @override
  State<DetailTrash> createState() => _DetailTrashState();
}

class _DetailTrashState extends State<DetailTrash> {
  @override
  Widget build(BuildContext context) {
    final HomeController _homeController = Get.put(HomeController(
        CategoryRepository(CategoryProvider()),
        UserRequestTrashRepository(UserRequestTrashProvider())));
    List<CategoryPriceModel> request = _homeController
        .getDataFromTableCategoryTrash(widget.data.categoryPrice!);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Thông tin: " + widget.data.category_title,
          style: AppTextStyles.caption,
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: ColorsConstants.kBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
            color: ColorsConstants.kBGCardColor,
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Bảng Giá Thu Gom",
                      style: AppTextStyles.caption,
                    ),
                  ),
                  DataTable(
                    horizontalMargin: 10,
                    columnSpacing: 8.sp,
                    headingRowHeight: 40.h,
                    dataRowHeight: 50.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    dataRowColor:
                        MaterialStateProperty.all(ColorsConstants.kBGCardColor),
                    columns: [
                      DataColumn(
                        label: Text(
                          "Vật phẩm",
                          style: AppTextStyles.bodyText1,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Giá mua",
                          style: AppTextStyles.bodyText1,
                        ),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                        request.length,
                        (index) => DataRow(cells: <DataCell>[
                              DataCell(SizedBox(
                                child: Text(
                                  request[index].name,
                                  style: AppTextStyles.bodyText1
                                      .copyWith(fontSize: 12.sp),
                                  maxLines: 3,
                                ),
                                width: 200.w,
                              )),
                              DataCell(Text(
                                request[index].price,
                                style: AppTextStyles.bodyText1,
                              )),
                            ])),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: Text(
                      "Thông tin",
                      style: AppTextStyles.caption,
                    ),
                  ),
                  HtmlWidget(
                    widget.data.category_description,
                  ),
                ],
              ),
            )),
      ),
    ));
  }
}
