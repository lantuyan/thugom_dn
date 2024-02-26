import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/widgets/dot_widget.dart';

class item_requestTrash extends StatelessWidget {
  const item_requestTrash({
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
                Text('20/02/2024',
                    style: AppTextStyles.bodyText1.copyWith(fontSize: 12.sp)),
                //description
                Text('Thu gom'.tr, style: AppTextStyles.caption),
                Text('Rác cồng kềnh'.tr,
                    style: AppTextStyles.bodyText1.copyWith(fontSize: 16.sp)),
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
