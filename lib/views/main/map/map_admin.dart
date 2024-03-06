import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as controller;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thu_gom/controllers/map/map_controller.dart';
import 'package:thu_gom/controllers/map/time/Time_Picker_Controller.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';

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
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            flex: 2,
            child: Obx(() {
              // Sử dụng isDataLoaded để kiểm tra xem dữ liệu đã tải xong chưa
              if (!user.isDataLoaded.value) {
                return Text('Đang tải dữ liệu...');
              } else {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Thời gian bắt đầu:'),
                                SizedBox(height: 5),
                                InkWell(
                                  onTap: () {
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
                                  child: Text('${timePickerController.startTime.value.day}/${timePickerController.startTime.value.month}/${timePickerController.startTime.value.year}'),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20), // Khoảng cách giữa hai calendar date picker
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Thời gian kết thúc:'),
                                SizedBox(height: 5),
                                InkWell(
                                  onTap: () {
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
                                  child: Text('${timePickerController.endTime.value.day}/${timePickerController.endTime.value.month}/${timePickerController.endTime.value.year}'),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20), // Khoảng cách giữa picker và button

                          // Button "Kiểm tra"
                          ElevatedButton(
                            onPressed: () {
                              user.statistical(timePickerController.startTime.value, timePickerController.endTime.value);
                            },
                            child: Text('Kiểm tra'),
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
