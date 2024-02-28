import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/widgets/dot_widget.dart';

class item_requestTrashCollector extends StatelessWidget {
  const item_requestTrashCollector({
    super.key,
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
                Text('Rác cồng kềnh'.tr,
                    style: AppTextStyles.caption.copyWith(fontSize: 16.sp)),
                //description
                Text('Nguyen Van A'.tr, style: AppTextStyles.bodyText1),
                Text('15 Kinh Duong Vuong'.tr, style: AppTextStyles.bodyText1),
              ],
            ),
            Column(
              children: [
                //name
                SizedBox(
                  height: 80.h,
                  child: Image.asset(
                    "assets/images/trash_wooden.png",
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
