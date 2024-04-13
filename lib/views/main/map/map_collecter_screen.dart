import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as controller;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thu_gom/controllers/map/map_controller.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:thu_gom/widgets/flutter_map_zoom_buttons.dart';
import 'package:thu_gom/widgets/flutter_map_location_button.dart';


class MapCollecterScreen extends StatelessWidget {
  MapCollecterScreen({Key? key}) : super(key: key);
  final GetStorage _getStorage = GetStorage();
  var name = '';
  @override
  Widget build(BuildContext context) {
    name = _getStorage.read('name');
    final user = Get.put(MapController());
    user.userRequest();
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

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: ColorsConstants.kBGCardColor,
            child: _userName(name),
          ),
          !user.isDataLoaded.value
              ? Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Center(
              child: CircularProgressIndicator(
                color: ColorsConstants.kActiveColor,
              ),
            ),
          )
              : user.initialPos == null
              ? const Center(
            child: Text(
              'Không thể tải bản đồ do thiếu thông tin vị trí.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorsConstants.kActiveColor,
              ),
            ),
          )
              : Expanded(
            flex: 4,
            child: Stack(
              children: [
                controller.FlutterMap(
                  options: controller.MapOptions(
                    initialCenter: user.initialPos,
                    initialZoom: 16.0,
                  ),

                  children: [
                    controller.TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    ),
                    if (user.markers_user.isNotEmpty)
                    MarkerClusterLayerWidget(
                    options: MarkerClusterLayerOptions(
                      maxClusterRadius: 45,
                      size: const Size(40, 40),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(50),
                      maxZoom: 15,
                      markers: user.markers_user,
                      builder: (context, markers) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.green),
                        child: Center(
                        child: Text(
                          markers.length.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        ),
                      );
                      },
                    ),
                    ),
                    controller.MarkerLayer(
                    markers: [
                      controller.Marker(
                      point: user.initialPos,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.redAccent,
                        size: 20,
                      ),
                      ),
                    ],
                    ),
                    Stack(
                      children: [
                        Positioned(
                          bottom: 8.0, // Điều chỉnh vị trí dưới cùng của nút phóng to và thu nhỏ
                          right: 8.0, // Điều chỉnh vị trí bên phải của nút phóng to và thu nhỏ
                          child: FlutterMapZoomButtons(
                            minZoom: 1,
                            maxZoom: 18,
                            mini: true,
                            padding: 8.0,
                            alignment: Alignment.bottomRight,
                            zoomInIcon: Icons.add,
                            zoomOutIcon: Icons.remove,
                          ),
                        ),
                        Positioned(
                          bottom: 120.0, // Điều chỉnh vị trí dưới cùng của nút vị trí hiện tại
                          right: 8.0, // Điều chỉnh vị trí bên phải của nút vị trí hiện tại
                          child: CurrentLocationButton(
                            user: user,
                            padding: 8.0,
                            moveToCurrentLocationIcon: Icons.location_on,
                          ),
                        ),
                      ],
                    )
                  ],
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
                      'Số người yêu cầu thu gom: ${user.markers_user.length}',
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
              if (!user.isDataLoaded.value) {
                return Text('Đang tải dữ liệu...');
              } else {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 24, // Chiều cao cố định cho tiêu đề
                        child: Text(
                          'Thông tin vị trí',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 5), // Khoảng cách giữa tiêu đề và nội dung
                      Obx(() {
                        return Text(
                          user.currentAddress.value,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
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
