import 'dart:typed_data';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thu_gom/managers/data_manager.dart';
import 'package:thu_gom/models/trash/user_request_trash_model.dart';
import 'package:thu_gom/shared/constants/appwrite_constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/style/custom_button_style.dart';
import 'package:thu_gom/widgets/custom_dialogs.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class MapController extends GetxController {
  late LatLng _initialPosition = LatLng(16.0544, 108.2034);
  LatLng get initialPos => _initialPosition;

  var activeGPS = true.obs;
  var shouldShowMarkers = false.obs;

  RxString currentAddress = ''.obs;
  RxString labels = ''.obs;
  RxString infos = ''.obs;
  Map<String, Uint8List> labelToIconMap = {};

  late final client = Client()
      .setEndpoint(AppWriteConstants.endPoint)
      .setProject(AppWriteConstants.projectId);
  // user
  late Databases points;
  List<Marker> markers = [];
  //collecter
  late Databases user_request;
  List<Marker> markers_user = [];
  //static
  List<Marker> static_user_done = <Marker>[].obs;
  List<Marker> static_user_not = <Marker>[].obs;
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();

  var isDataLoaded = false.obs;
  var isDataLoaded2 = false.obs;
  var isDataLoaded3 = false.obs;

  final GetStorage _getStorage = GetStorage();

  @override
  void onInit() async {
    super.onInit();
    String role = await _getStorage.read('role');
    await getUserLocation();
    if (role == 'person') {
      await loadMarkersCollecter();
    } else if (role == 'collector') {
      await loadMarkersCollecter();
      await userRequest();
      await statistical(startTime, endTime);
    } else if (role == 'admin') {
      await loadMarkersCollecter();
      await userRequest();
      await statistical(startTime, endTime);
    }
  }

  void filterDataByTime() {
    statistical(startTime, endTime);
  }

  // lấy vị trí hiện tại của người dùng
  Future<void> getUserLocation() async {
    CustomDialogs.showLoadingDialog();
    if (!(await Geolocator.isLocationServiceEnabled())) {
      activeGPS.value = false;
    } else {
      activeGPS.value = true;
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Quyền vị trí bị từ chối');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Quyền vị trí bị từ chối vĩnh viễn, chúng tôi không thể yêu cầu quyền.');
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _initialPosition = LatLng(position.latitude, position.longitude);

      // Sau khi _initialPosition được khởi tạo, cập nhật biến isDataLoaded
      // isDataLoaded.value = true;
      update(); // Cần gọi update để cập nhật UI
    }
  }
  // chức năng hiển thị các điểm thu gom của thành phố đà nẵng ở map person gồm MRF,Trạm thu mua và green house ...
  Future<void> loadMarkersCollecter() async {
    try {
      // danh sách của collection_points
      final Storage storage = Storage(client);
      points = Databases(client);
      // danh sách của category points
      models.DocumentList category_points_List = await points.listDocuments(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.categoryPointsCollectionId,
          queries: [
            Query.limit(10),
            Query.offset(0)
          ]
      );
      // vòng for để lưu các icon dựa trên label
      for (var document in category_points_List.documents) {
        Map<String, dynamic> data = document.data as Map<String, dynamic>;
        String label = data['Label'];
        String iconUrl = data['Icon']; // Đường dẫn URL của ảnh

        // Tải ảnh từ URL
        var response = await http.get(Uri.parse(iconUrl));
        if (response.statusCode == 200) {
          Uint8List imageData = response.bodyBytes;
          labelToIconMap[label] = imageData; // Lưu trữ ảnh vào labelToIconMap
        } else {
          print('Failed to load image for label: $label');
        }
      }

      models.DocumentList pointsList = await points.listDocuments(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.collection_point_Id,
          queries: [
            Query.limit(1000),
            Query.offset(0)
          ]
      );

      // vòng for để xét các địa điểm vào các marker tương ứng
      for (var document in pointsList.documents) {
        Map<String, dynamic> data = document.data as Map<String, dynamic>;
        double latitude = data['point_lat'];
        double longitude = data['point_lng'];
        String address = data['address'];
        String label = data['label'];
        String info = data['info'] ?? "";
        // kiểm tra xem label của points và category points có giống nhau hay không
        // nếu giống thì gán imageData với icon tương ứng của label - category points
        if (labelToIconMap.containsKey(label)) {
          Uint8List? imageData = labelToIconMap[label];
          Marker marker = Marker(
            height: 35.sp,
            width: 35.sp,
            point: LatLng(latitude, longitude),
            child: GestureDetector(
              onTap: () {
                currentAddress.value = address;
                infos.value = info;
                // openGoogleMapsApp(_initialPosition.latitude,
                //     _initialPosition.longitude, latitude, longitude);
                showSheet(Get.context, latitude, longitude);
              },
              child: Image.memory(
                imageData!,
                height: 10,
                width: 10,
              ),
            ),
          );
          markers.add(marker);
        }
      }
      isDataLoaded.value = true;
      shouldShowMarkers.value = true;
      CustomDialogs.hideLoadingDialog();
      update();
    } catch (e) {
      print('Error!!! $e');
    }
  }
  // chức năng hiển thị các yêu cầu của người dùng bên map collector
  Future<void> userRequest() async {
    try {
      user_request = Databases(client);
      models.DocumentList documentlistUser = await user_request.listDocuments(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.userRequestTrashCollection,
          queries: [
            Query.limit(10000),
            Query.offset(0)
          ]
      );
      markers_user.clear();
      for (var documents in documentlistUser.documents) {
        Map<String, dynamic> data = documents.data as Map<String, dynamic>;
        UserRequestTrashModel request = UserRequestTrashModel.fromMap(data);
        if (request.status == 'pending')
        {
          Marker marker = Marker(
            point: LatLng(request.point_lat, request.point_lng),
            child: GestureDetector(
              onTap: () {
                currentAddress.value = request.address;
                requestDetail(request);
              },
              child: Image.asset(
                'assets/images/bin.jpg',
                height: 10,
                width: 10,
              ),
            ),
          );
          markers_user.add(marker);
        }
      }
      isDataLoaded2.value = true;
      shouldShowMarkers.value = true;
      update();
    } catch (e) {
      print('Error!!! $e');
    }
  }

  // chức năng thống kê người dùng ở admin map
  Future<void> statistical(DateTime startTime, DateTime endTime) async {
    try {
      user_request = Databases(client);
      models.DocumentList listRequest = await user_request.listDocuments(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.userRequestTrashCollection,
          queries: [
            Query.limit(10000),
            Query.offset(0)
          ]
      );
      static_user_done.clear();
      static_user_not.clear();
      for (var documents in listRequest.documents) {
        Map<String, dynamic> data = documents.data as Map<String, dynamic>;
        UserRequestTrashModel request = UserRequestTrashModel.fromMap(data);
        DateTime documentDateTime = DateTime.parse(request.createAt);
        if (documentDateTime.isAfter(startTime) && documentDateTime.isBefore(endTime)) {
          if (request.status == 'pending' || request.status == 'processing') {
            Marker marker = Marker(
              point: LatLng(request.point_lat, request.point_lng),
              child: GestureDetector(
                onTap: () {
                  currentAddress.value = request.address;
                },
                child: Image.asset(
                  'assets/images/bin.jpg',
                  height: 10,
                  width: 10,
                ),
              ),
            );
            static_user_not.add(marker);
          }
          // Thêm marker vào danh sách tương ứng

          else if(request.status == 'finish' || request.status == 'confirming') {
            Marker marker = Marker(
              point: LatLng(request.point_lat, request.point_lng),
              child: GestureDetector(
                onTap: () {
                  currentAddress.value = request.address;
                },
                child: Image.asset(
                  'assets/images/bin1.jpg',
                  height: 10,
                  width: 10,
                ),
              ),
            );
            static_user_done.add(marker);
          }

        }
      }
      isDataLoaded3.value = true;
      shouldShowMarkers.value = true;
      update();
    } catch (e) {
      print('Error!!! $e');
    }
  }

  // chức năng chuyển hướng googlemap
  Future<void> openGoogleMapsApp(
      double startLat, double startLng, double endLat, double endLng) async {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Xác nhận di chuyển"),
          content: Text("Bạn có chắc chắn muốn di chuyển đến đích này không?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
              },
              child: Text("Hủy"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Đóng dialog
                final url = Uri.parse(
                    'https://www.google.com/maps/dir/?api=1&origin=$startLat,$startLng&destination=$endLat,$endLng');
                try {
                  await launchUrl(url);
                } catch (e) {
                  print('Error launching Google Maps: $e');
                }
              },
              child: Text("Đồng ý"),
            ),
          ],
        );
      },
    );
  }

  // gọi đến yêu cầu chi tiết của người dùng
  Future<void> requestDetail(dynamic request) async {
    await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Chi tiết yêu cầu"),
          content: Text("Bạn muốn xem yêu cầu chi tiết?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
              },
              child: Text("Hủy"),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop(); // Đóng dialog
                Get.toNamed('requestDetailPage', arguments: {
                  'requestDetail': request
                });
              },
              child: Text("Xác nhận"),
            ),
          ],
        );
      },
    );
  }

  void showSheet(context, double latitude, double longitude) {
  showModalBottomSheet(context: context, builder: (BuildContext bc) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsConstants.kMainColor,
                padding: EdgeInsets.fromLTRB(20.sp, 10.sp, 20.sp, 10.sp),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: (){
                openGoogleMapsApp(_initialPosition.latitude,
                    _initialPosition.longitude, latitude, longitude);
              },
              child: Text("Chỉ đường", style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
              ))),
              IconButton(
                style: CustomButtonStyle.transparentButton,
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close, color: ColorsConstants.kActiveColor, size: 30.sp),
              ),
            ],
          ),
          SizedBox(height: 12.sp),
          Center(
            child: Text(
              'Thông tin vị trí',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              )
            ),
          ),
          SizedBox(height: 18.sp),
          Row(
            children:[
              Icon(Icons.location_on, color: ColorsConstants.kActiveColor, size: 30.sp),
              SizedBox(width: 12.sp),
              Expanded(
                child: Text(currentAddress.value, style: TextStyle(
                  fontSize: 16.sp,
                  color: ColorsConstants.kActiveColor,
                )),
              ),
            ],
          ),
          SizedBox(height: 12.sp),
          Row(
            children:[
              Icon(Icons.info, color: ColorsConstants.kActiveColor, size: 30.sp),
              SizedBox(width: 12.sp),
              Expanded(
                child: Text(infos.value, style: TextStyle(
                  fontSize: 16.sp,
                  color: ColorsConstants.kActiveColor,
                )),
              ),
            ],
          ),
        ],
      ),
    );
  });
}
}
