import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as controller;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thu_gom/controllers/map/map_controller.dart';
import 'package:thu_gom/controllers/map/time/Time_Picker_Controller.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/shared/themes/style/custom_button_style.dart';
import 'package:thu_gom/widgets/header_username.dart';
import 'package:thu_gom/widgets/flutter_map_zoom_buttons.dart';
import 'package:thu_gom/widgets/flutter_map_location_button.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

class MapAdminScreen extends StatefulWidget {
  const MapAdminScreen({Key? key}) : super(key: key);

  @override
  _MapAdminScreenState createState() => _MapAdminScreenState();
}

class _MapAdminScreenState extends State<MapAdminScreen> {
  final GetStorage _getStorage = GetStorage();
  late String name;
  late MapController user;

  @override
  void initState() {
    super.initState();
    name = _getStorage.read('name') ?? '';
    user = Get.put(MapController());
    user.userRequest();
  }

  @override
  Widget build(BuildContext context) {
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
    final TimePickerController timePickerController = Get.put(TimePickerController());
    return Scaffold(
      appBar: AppBar(
        title:
        Container(
          color: ColorsConstants.kBGCardColor,
          child: userName(name),
        ),

      ),
      body: SafeArea(
        child: Column(
          children: [
            // Container(
            //   color: ColorsConstants.kBGCardColor,
            //   child: _userName(name),
            // ),
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
              flex: 3,
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
                      controller.MarkerLayer(
                        markers:[
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
                      controller.MarkerLayer(markers: user.static_user_not),
                      controller.MarkerLayer(markers: user.static_user_done),
                      MarkerClusterLayerWidget(
                        options: MarkerClusterLayerOptions(
                          maxClusterRadius: 45,
                          size: const Size(40, 40),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(50),
                          maxZoom: 15,
                          markers: user.static_user_not,
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
                      MarkerClusterLayerWidget(
                        options: MarkerClusterLayerOptions(
                          maxClusterRadius: 45,
                          size: const Size(40, 40),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(50),
                          maxZoom: 15,
                          markers: user.static_user_done,
                          builder: (context, markers) {
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey),
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
                ],
              ),
            ),

            Expanded(
              flex: 1,
              child: Obx(() {
                // Sử dụng isDataLoaded để kiểm tra xem dữ liệu đã tải xong chưa
                if (!user.isDataLoaded.value) {
                  return Text('Đang tải dữ liệu...');
                } else {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thời gian',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 10), // Khoảng cách giữa các widget

                        // Hàng chứa hai calendar date picker
                        Row(
                          children: [

                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  // Hiển thị date picker và cập nhật giá trị cho biến startTime
                                  showDatePicker(
                                    context: context,
                                    initialDate: timePickerController.startTime.value,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  ).then((selectedDate) {
                                    if (selectedDate != null) {
                                      timePickerController.updateStartTime(selectedDate);
                                    }
                                  });
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Bắt đầu:'),
                                    SizedBox(height: 5),
                                    // Biểu tượng lịch trước picker bắt đầu
                                    Icon(Icons.calendar_today),
                                    Text('${timePickerController.startTime.value.day}/${timePickerController.startTime.value.month}/${timePickerController.startTime.value.year}')
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 20), // Khoảng cách giữa hai calendar date picker
                            Expanded(
                              child: InkWell(
                                onTap:(){
                                  // Hiển thị date picker và cập nhật giá trị cho biến endTime
                                  showDatePicker(
                                    context: context,
                                    initialDate: timePickerController.endTime.value,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  ).then((selectedDate) {
                                    if (selectedDate != null) {
                                      timePickerController.updateEndTime(selectedDate);
                                    }
                                  });
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Kết thúc:'),
                                    SizedBox(height: 5),
                                    Icon(Icons.calendar_today),
                                    Text('${timePickerController.endTime.value.day}/${timePickerController.endTime.value.month}/${timePickerController.endTime.value.year}')
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20), // Khoảng cách giữa picker và button
                            // Button "Kiểm tra"
                            ElevatedButton(
                              style: CustomButtonStyle.primaryButton,
                              onPressed: () {
                                setState(() {
                                  user.statistical(timePickerController.startTime.value, timePickerController.endTime.value);
                                });
                              },
                              child: Text('Kiểm tra',style: TextStyle(
                                  color: Colors.white
                              ),),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              }),
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
            "Xin chào: " + name,
            style: AppTextStyles.headline1,
          )
        ],
      ),
    );
  }
}
