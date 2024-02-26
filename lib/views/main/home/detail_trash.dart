import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';

class DetailTrash extends StatefulWidget {
  const DetailTrash({super.key});

  @override
  State<DetailTrash> createState() => _DetailTrashState();
}

class _DetailTrashState extends State<DetailTrash> {
  @override
  Widget build(BuildContext context) {
    String content =
        "FFirst, we create the Stateful widget and give the name to our stateful widget and then pass the name of First, we create the Stateful widget and give the name to our stateful widget and then pass the name of First, we create the Stateful widget and give the name to our stateful widget and then pass the name of, First, we create the Stateful widget and give the name to our stateful widget and then pass the name of First, we create the Stateful widget and give the name to our stateful widget and then pass the name of First, we create the Stateful widget and give the name to our stateful widget and then pass the name of, First, we create the Stateful widget and give the name to our stateful widget and then pass the name of First, we create the Stateful widget and give the name to our stateful widget and then pass the name of First, we create the Stateful widget and give the name to our stateful widget and then pass the name of, First, we create the Stateful widget and give the name to our stateful widget and then pass the name of First, we create the Stateful widget and give the name to our stateful widget and then pass the name of First, we create the Stateful widget and give the name to our stateful widget and then pass the name of, name to our stateful widget and then pass the name of First, we create the Stateful widget and give the name to our stateful widget and then pass the name of, name to our stateful widget and then pass the name of First, we create the Stateful widget and give the name to our stateful widget and then pass the name of, name to our stateful widget and then pass the name of First, we create the Stateful widget and give the name to our stateful widget and then pass the name of, name to our stateful widget and then pass the name of First, we create the Stateful widget and give the name to our stateful widget and then pass the name of, name to our stateful widget and then pass the name of First, we create the Stateful widget and give the name to our stateful widget and then pass the name of, name to our stateful widget and then pass the name of First, we create the Stateful widget and give the name to our stateful widget and then pass the name of, name to our stateful widget and then pass the name of First, we create the Stateful widget and give the name to our stateful widget and then pass the name of, name to our stateful widget and then pass the name of First, we create the Stateful widget and give the name to our stateful widget and then pass the name of, ";
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Rác cồng kềnh",
          style: AppTextStyles.caption,
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: ColorsConstants.kBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          color: ColorsConstants.kBGCardColor,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 8.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 4.sp, right: 4.sp, bottom: 4.sp, top: 8.sp),
                    child: Text(
                      "Thông tin loại rác:",
                      style: AppTextStyles.title,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/trash_metal.png",
                      width: 100.w,
                      height: 80.h,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      width: 10.sp,
                    ),
                    SizedBox(
                      width: 200.w,
                      child: Text(
                        "Rác cồng kềnh",
                        style: AppTextStyles.bodyText1,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.sp),
                child: Text(content,
                    style: AppTextStyles.bodyText4.copyWith(
                        fontSize: 10.sp,
                        color: ColorsConstants.kTextMainColor)),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
