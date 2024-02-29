import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/widgets/dot_widget.dart';
import 'dart:io';

class item_requestTrash extends StatelessWidget {
  final String id;
  final String createAt;
  final String trash_type;
  final String image;
  const item_requestTrash({
    super.key,
    required this.id,
    required this.createAt,
    required this.trash_type,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //date
                Text(createAt!,
                    style: AppTextStyles.bodyText1.copyWith(fontSize: 12.sp)),
                //description
                Text('Thu gom'.tr, style: AppTextStyles.caption),
                Text(trash_type,
                    style: AppTextStyles.bodyText1.copyWith(fontSize: 16.sp)),
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
                    fit: BoxFit.fill,
                    scale: 1.0,
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
