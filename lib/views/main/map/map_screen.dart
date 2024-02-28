import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thu_gom/controllers/map/map_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

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
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4, // Sử dụng flex để chiếm 3/4 màn hình
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: user.initialPos,
                    zoom: 16.0,
                  ),
                  markers: {
                    // Tạo marker cho vị trí hiện tại của người dùng
                    Marker(
                      markerId: MarkerId("user_location"),
                      position: user.initialPos,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueRed),
                    ),
                    ...user.markers,
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
                      'Số lượng Marker: ${user.markers.length}',
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
            child: Container(
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
                  // Hiển thị thông tin address
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
            ),
          ),
        ],
      ),
    );
  }
}
