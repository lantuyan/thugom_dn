import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thu_gom/controllers/main/home/home_controller.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/widgets/web_view.dart';
class InfomationScreen extends StatelessWidget {
   InfomationScreen({Key? key}) : super(key: key);
  final GetStorage _getStorage = GetStorage();
  var name ='';
  @override
  Widget build(BuildContext context) {
    name = _getStorage.read('name');
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: ColorsConstants.kBGCardColor,
            child: _userName(name),
          ),
          // Phần hiển thị thông tin bảo vệ môi trường
          Flexible(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey, // Màu sắc của đường viền
                    width: 6.0, // Độ dày của đường viền
                  ),
                  left:  BorderSide(
                    color: Colors.grey, // Màu sắc của đường viền
                    width: 6.0, // Độ dày của đường viền
                  ),
                  top:  BorderSide(
                    color: Colors.grey, // Màu sắc của đường viền
                    width: 6.0, // Độ dày của đường viền
                  ),
                  right:  BorderSide(
                    color: Colors.grey, // Màu sắc của đường viền
                    width: 6.0, // Độ dày của đường viền
                  ),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10.0),
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
                    SizedBox(width: 16.0), // Khoảng cách giữa hình ảnh và văn bản
                    // Nội dung văn bản
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => WebViewPage()),
                              );
                            },
                            child: Text(
                              'Luật bảo vệ môi trường',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            'Môi trường bao gồm các yếu tố vật chất tự nhiên và nhân tạo quan hệ mật thiết với nhau, bao quanh con người, có ảnh hưởng đến đời sống, kinh tế, xã hội, sự tồn tại, phát triển của con người, sinh vật và tự nhiên.',
                            style: Theme.of(context).textTheme.bodyText2,
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),


                  ],
                ),
              ),
            ),
          ),
          // Phần trống còn lại
          Flexible(
            flex: 3, // Chiếm 1/3 chiều cao của màn hình
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 6.0,
                  ),
                  left:  BorderSide(
                    color: Colors.grey,
                    width: 6.0,
                  ),
                  top:  BorderSide(
                    color: Colors.grey,
                    width: 6.0,
                  ),
                  right:  BorderSide(
                    color: Colors.grey,
                    width: 6.0,
                  ),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildInformationContainer(
                      context,
                      'Phí thu gom rác cồng kềnh',
                      'assets/images/blog_2.jpg',

                    ),
                    buildInformationContainer(
                      context,
                      'Thông tư...',
                      'assets/images/blog_3.jpg',

                    ),
                    buildInformationContainer(
                      context,
                      'Thông tư...',
                      'assets/images/blog_4.jpg',

                    ),
                  ],
                ),
              ),

            ),
          ),
        ],
      ),
    );

  }


  Widget buildInformationContainer(BuildContext context, String title, String imagePath) {
    return Container(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hình ảnh
            Image.asset(
              imagePath, // Đường dẫn của hình ảnh
              height: 80, // Độ cao của hình ảnh
              width: 80, // Độ rộng của hình ảnh
              fit: BoxFit.cover, // Hiển thị hình ảnh đúng tỷ lệ
            ),
            SizedBox(width: 16.0), // Khoảng cách giữa hình ảnh và văn bản
            // Nội dung văn bản
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WebViewPage()),
                      );
                    },
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),

                  const SizedBox(height: 8.0),
                ],
              ),
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
          Text(
            "Xin chào," + name,
            style: AppTextStyles.headline1,
          )
        ],
      ),
    );
  }
}



