import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter/material.dart';
import 'package:thu_gom/models/trash/user_request_trash_model.dart';
import 'package:thu_gom/shared/constants/appwrite_constants.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  late LatLng _initialPosition = LatLng(16.0544, 108.2034);
  LatLng get initialPos => _initialPosition;

  GoogleMapController? mapController;
  var activeGPS = true.obs;
  var shouldShowMarkers = false.obs;

  RxString currentAddress = ''.obs;
  late final client = Client()
      .setEndpoint(AppWriteConstants.endPoint)
      .setProject(AppWriteConstants.projectId);
  // user
  late Databases collection_points;
  Set<Marker> markers = {};
  //collecter
  late Databases user_request;
  Set<Marker> markers_user = {};

  var isDataLoaded = false.obs;


  @override
  void onInit() {
    super.onInit();
    getUserLocation();
    userRequest();
    loadMarkersCollecter();
  }

  Future<void> getUserLocation() async {
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
      isDataLoaded.value = true;
      update(); // Cần gọi update để cập nhật UI
    }
  }

  void loadMarkersCollecter() async {
    BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(20 , 20)), // Kích thước mong muốn của biểu tượng
      'assets/images/bin_icon1.jpg',
    );
    try {
      collection_points = Databases(client);
      models.DocumentList documentList = await collection_points.listDocuments(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.collection_point_Id,
      );

      for (var document in documentList.documents) {
        Map<String, dynamic> data = document.data as Map<String, dynamic>;
        double latitude = data['point_lat'];
        double longitude = data['point_lng'];
        String address = data['address'];
        markers.add(
          Marker(
            markerId: MarkerId("$latitude-$longitude"),
            position: LatLng(latitude, longitude),
            icon: customIcon,
            onTap: () {
              currentAddress.value = address;
              shouldShowMarkers.value = true;
            },
          ),
        );
      }
      shouldShowMarkers.value = true;
      update();
      isDataLoaded.value = true;
    } catch (e) {
      print('Error!!! $e');
    }
  }
  void userRequest() async {
    BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(20, 20)), // Kích thước mong muốn của biểu tượng
      'assets/images/bin_icon1.jpg',
    );
    try {
      user_request = Databases(client);
      models.DocumentList documentlistUser = await user_request.listDocuments(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.userRequestTrashCollection,
      );
      for (var documents in documentlistUser.documents) {
        Map<String, dynamic> data = documents.data as Map<String, dynamic>;
        double? pointLat = data['point_lat'] as double?;
        double? pointLng = data['point_lng'] as double?;
        String address = data['address'];
        markers_user.add(
          Marker(
            markerId: MarkerId("$pointLat-$pointLng"),
            position: LatLng(pointLat!, pointLng!),
            icon: customIcon,
            onTap: () {
              currentAddress.value = address;
              shouldShowMarkers.value = true;
            },
          ),
        );

      }

      shouldShowMarkers.value = true;
      isDataLoaded.value = true;
      update();
    } catch (e) {
      print('Error!!! $e');
    }
  }

}
