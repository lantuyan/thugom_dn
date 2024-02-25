import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/shared/themes/style/custom_button_style.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  final controller = PageController();
  int currentPage = 0;
  int numberOfPages = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 120.sp,
        padding: EdgeInsets.symmetric(horizontal: 18.sp),
        margin: EdgeInsets.only(bottom: 60.sp),
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            buildActionButton(),
          ],
        ),
      ),
      extendBody: false,
      body: Container(
        color: Colors.transparent,
        margin: EdgeInsets.only(bottom: 40.sp),
        padding: EdgeInsets.fromLTRB(18.sp, 20.sp, 18.sp, 0),
        child: Column(
          children: [
            Container(
              height: 80.sp,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Bước 1/2",
                    style: AppTextStyles.headline1,
                  ),
                  SizedBox(height: 8.sp),
                  Text(
                    "Hướng dẫn",
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontFamily: AppTextStyles.fontFamily,
                      fontWeight: FontWeight.w700,
                      color: ColorsConstants.kMainColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: buildPages(),
            ),
            buildIndicator(),
          ],
        ),
      ),
    );
  }

  Widget buildActionButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 48.sp,
      child: TextButton(
        style: currentPage == numberOfPages - 1
            ? CustomButtonStyle.primaryButton
            : CustomButtonStyle.transparentButton,
        child: Text(
          currentPage == numberOfPages - 1
              ? 'Nhập thông tin'.tr
              : 'Tiếp tục'.tr,
          style: currentPage == numberOfPages - 1
              ? TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                )
              : TextStyle(
                  color: ColorsConstants.kMainColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
        ),
        onPressed: () {
          if (currentPage == numberOfPages - 1) {
            Get.toNamed("/profilePage");
          } else {
            controller.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          }
        },
      ),
    );
  }

  Widget buildPages() {
    return PageView(
      controller: controller,
      onPageChanged: (value) {
        setState(() {
          currentPage = value;
        });
      },
      children: [
        onboardPageView(const AssetImage('assets/images/onboarding_1.jpg')),
        onboardPageView(const AssetImage('assets/images/onboarding_2.jpg')),
        onboardPageView(const AssetImage('assets/images/onboarding_3.jpg')),
      ],
    );
  }

  Widget onboardPageView(ImageProvider<Object> imageProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20.sp),
        Image(
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5,
          image: imageProvider,
        ),
      ],
    );
  }

  Widget buildIndicator() {
    return SmoothPageIndicator(
      controller: controller,
      count: numberOfPages,
      effect: const WormEffect(
        activeDotColor: ColorsConstants.kActiveColor,
      ),
    );
  }
}
