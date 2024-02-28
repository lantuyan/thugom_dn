import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thu_gom/shared/constants/appwrite_constants.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class DetailTrash extends StatefulWidget {
  const DetailTrash(
      {super.key,
      required this.id,
      required this.image,
      required this.title,
      required this.description});
  final String id;
  final String image;
  final String title;
  final String description;

  @override
  State<DetailTrash> createState() => _DetailTrashState();
}

class _DetailTrashState extends State<DetailTrash> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Thông tin: " + widget.title,
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
              Padding(
                padding: EdgeInsets.all(10.sp),
                child: HtmlWidget(
                  widget.description,
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
