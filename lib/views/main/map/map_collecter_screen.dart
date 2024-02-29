import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:thu_gom/controllers/map/map_controller.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';

class MapCollecterScreen extends StatelessWidget {
  const MapCollecterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Get.put(MapController());
    return Obx(() => Scaffold(
      body: user.activeGPS.value == false
          ? _buildNoGpsView(user)
          : _buildMapView(context, user),
    ));
  }

  Widget _buildNoGpsView(MapController user) {
    return Container(
      height: Get.height,
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 250,
              width: 250,
              child: Image.asset('assets/images/nogps.png'),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Yêu cầu kích hoạt định vị',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                user.getUserLocation();
              },
              child: const Text('Thử lại'),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMapView(BuildContext context, MapController user) {
    if (!user.isDataLoaded.value) {
      return Center(child: CircularProgressIndicator());
    }
    // Kiểm tra xem _initialPosition có được khởi tạo hay không
    if (user.initialPos == null) {
      // Nếu chưa được khởi tạo, hiển thị màn hình trống hoặc thông báo lỗi
      return Center(
        child: Text('Không thể tải bản đồ do thiếu thông tin vị trí.'),
      );
    }
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: ColorsConstants.kBGCardColor,
            child: _userName(),
          ),
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: user.initialPos,
                    zoom: 16.0,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId("user_location"),
                      position: user.initialPos,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueRed),
                    ),
                    ...user.markers_user,
                  },
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Số lượng Marker: ${user.markers_user.length}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Obx(() {
              // Sử dụng isDataLoaded để kiểm tra xem dữ liệu đã tải xong chưa
              if (!user.isDataLoaded.value) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Thông tin vị trí',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Obx(() {
                        return Text(
                          user.currentAddress.value,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        );
                      }),
                    ],
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
  Padding _userName() {
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
            "Hello".tr + "\ Nghĩa",
            style: AppTextStyles.headline1,
          )
        ],
      ),
    );
  }
}
