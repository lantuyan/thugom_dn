import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/widgets/dot_widget.dart';

class item_requestTrashCollector extends StatelessWidget {
  final String id;
  final String trash_type;
  final String address;
  final String image;
  final String senderId;
  const item_requestTrashCollector({
    super.key,
    required this.trash_type,
    required this.address,
    required this.image,
    required this.senderId,
    required this.id,
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
                Text(trash_type,
                    style: AppTextStyles.caption.copyWith(fontSize: 16.sp)),
                //name sender
                Text(senderId, style: AppTextStyles.bodyText1),

                SizedBox(
                  width: 200.w,
                  child: Text(
                    address,
                    style: AppTextStyles.bodyText1.copyWith(fontSize: 12.sp),
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
                  child: Image.network(
                    image,
                    width: 100.w,
                    fit: BoxFit.cover,
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
