import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thu_gom/controllers/main/home/home_controller.dart';
import 'package:thu_gom/controllers/main/infomation/infomation_controller.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/widgets/header_username.dart';
import 'package:thu_gom/widgets/web_view.dart';

class InfomationScreen extends StatelessWidget {
  InfomationScreen({Key? key}) : super(key: key);
  final GetStorage _getStorage = GetStorage();
  final InfomationController _homeController = Get.put(InfomationController());
  var name = '';
  @override
  Widget build(BuildContext context) {
    name = _getStorage.read('name');
    return Scaffold(
      appBar: _getStorage.read('role') == 'admin'
          ? AppBar(
        title: Container(
            color: ColorsConstants.kBGCardColor,
            child: userName(name),
          ),
      )
          : null,
      backgroundColor: ColorsConstants.kBackgroundColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            if (_getStorage.read('role') != 'admin') Container(
                  color: ColorsConstants.kBGCardColor,
                  child: _userName(name),
                ),
            SizedBox(
              height: 8.h,
            ),
            // ĐĂNG KÝ THU GOM
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebViewPage(
                            url:
                                "https://baotainguyenmoitruong.vn/da-nang-trien-khai-luat-bao-ve-moi-truong-cho-cac-doanh-nghiep-khu-cong-nghiep-363363.html",
                          )),
                );
              },
              child: Card(
                color: ColorsConstants.kBGCardColor,
                margin:
                    EdgeInsets.only(left: 10.sp, right: 10.sp, bottom: 10.sp),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Hình ảnh
                          Image.asset(
                            'assets/images/blog_1.jpg', // Đường dẫn của hình ảnh
                            height: 80, // Độ cao của hình ảnh
                            width: 80, // Độ rộng của hình ảnh
                            fit: BoxFit.cover, // Hiển thị hình ảnh đúng tỷ lệ
                          ),
                          SizedBox(
                              width:
                                  16.0), // Khoảng cách giữa hình ảnh và văn bản
                          // Nội dung văn bản
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Luật bảo vệ môi trường',
                                  style: AppTextStyles.headline1,
                                ),
                                const SizedBox(height: 16.0),
                                Text(
                                  'Môi trường bao gồm các yếu tố vật chất tự nhiên và nhân tạo quan hệ mật thiết với nhau, bao quanh con người, có ảnh hưởng đến đời sống, kinh tế, xã hội, sự tồn tại, phát triển của con người, sinh vật và tự nhiên.',
                                  style: AppTextStyles.bodyText1,
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            ProfileCardInfomation(
              image: 'assets/images/trash_bin.png',
              color: ColorsConstants.kActiveColor,
              tapHandler: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebViewPage(
                            url:
                                "https://thanhnien.vn/da-nang-tai-khoi-dong-thu-tien-rac-khong-dung-tien-mat-185230512073636513.htm",
                          )),
                );
              },
              title: 'Thông báo phí thu gom',
            ),
            ProfileCardInfomation(
              image: 'assets/images/check_user.png',
              color: ColorsConstants.kActiveColor,
              tapHandler: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebViewPage(
                            url:
                                "https://tnmt.danang.gov.vn/van-ban-phap-quy/chi-tiet?id=2366&u=nghiinhquyinhvexuphatviphamhanhchinhtronglinhvucbaovemoitruong",
                          )),
                );
              },
              title: 'Thông tư số 01',
            ),
            ProfileCardInfomation(
              image: 'assets/images/check_user.png',
              color: ColorsConstants.kActiveColor,
              tapHandler: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebViewPage(
                            url:
                                "https://tnmt.danang.gov.vn/bai-viet/chi-tiet?id=3438&u=capnhapcacvanbanmoicuabotainguyenvamoitruong",
                          )),
                );
              },
              title: 'Thông tư số 02',
            ),
            ProfileCardInfomation(
              image: 'assets/images/noti_user.png',
              color: ColorsConstants.kActiveColor,
              tapHandler: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebViewPage(
                            url: "https://donaso.vn/",
                          )),
                );
              },
              title: 'Liên hệ',
            ),
            ProfileCardInfomation(
              image: 'assets/images/log_out.png',
              color: ColorsConstants.kDangerous,
              tapHandler: () {
                _homeController.logOut();
              },
              title: 'Đăng xuất',
            ),
          ],
        ),
      ),
    );
  }

  Padding _userName(String name) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.sp),
      child: Row(
        children: [
          SizedBox(
            width: 20.w,
          ),
          GestureDetector(
            onTap: () {
              // _loginController.logout(); // LOGOUT
            },
            child: Image.asset(
              'assets/images/user-avatar.png',
              height: 40.h,
              width: 40.w,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Text(
              "Xin chào, " + name,
              style: AppTextStyles.headline1,
              overflow: TextOverflow.ellipsis, // Truncate văn bản nếu vượt quá khung
              maxLines: 1, // Giới hạn số dòng hiển thị
            ),
          )
        ],
      ),
    );
  }
}

class ProfileCardInfomation extends StatelessWidget {
  final String image;
  final String title;
  final Color color;
  final Function tapHandler;
  const ProfileCardInfomation({
    Key? key,
    required this.image,
    required this.title,
    required this.color,
    required this.tapHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        tapHandler();
      },
      child: Card(
        color: ColorsConstants.kBGCardColor,
        margin: EdgeInsets.only(left: 10.sp, right: 10.sp, bottom: 10.sp),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.sp),
                    decoration: ShapeDecoration(
                      color: color.withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Image.asset(
                      image,
                      color: color,
                      width: 20.sp,
                      height: 20.sp,
                    ),
                  ),
                  SizedBox(
                    width: 32.sp,
                  ),
                  Expanded(
                    child: Text(
                      title,
                      style: AppTextStyles.headline1,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
