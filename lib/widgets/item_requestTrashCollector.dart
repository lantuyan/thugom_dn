import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/widgets/dot_widget.dart';
import 'package:intl/intl.dart';

class item_requestTrashCollector extends StatelessWidget {
  final String id;
  final String trash_type;
  final String address;
  final String image;
  final String createAt;
  const item_requestTrashCollector({
    super.key,
    required this.trash_type,
    required this.address,
    required this.image,
    required this.createAt,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(createAt);
    var outputFormat = DateFormat('dd/MM/yyyy');

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //date
                Text(outputFormat.format(inputDate), style: AppTextStyles.bodyText1.copyWith(fontSize: 12.sp)),
                Text(trash_type,
                    style: AppTextStyles.caption.copyWith(fontSize: 16.sp)),
                //name sender

                SizedBox(
                  width: 200.w,
                  child: Text(
                    address,
                    style: AppTextStyles.bodyText1.copyWith(fontSize: 14.sp),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                //name
                SizedBox(
                  height: 80.h,
                  width: 100.w,
                  child: Image.network(
                    image,
                    scale: 1.0,
                    cacheHeight: 100,
                    cacheWidth: 100,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) => loadingProgress == null
                        ? child
                        : Center(
                            child: Image.asset("assets/images/placeholder.png")
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 4.h,
        ),
        DotWidget(
          dashColor: Colors.black,
          dashHeight: 1.h,
          dashWidth: 10.w,
          totalWidth: 300.w,
          emptyWidth: 12.w,
        ),
        SizedBox(
          height: 8.h,
        ),
      ],
    );
  }
}
