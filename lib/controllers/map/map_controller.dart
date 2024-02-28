import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:thu_gom/shared/constants/appwrite_constants.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapController extends GetxController {
  late LatLng _initialPosition = LatLng(16.054423472460357, 108.20344334328267);
  LatLng get initialPos => _initialPosition;

  GoogleMapController? mapController;
  var activeGPS = true.obs;
  var shouldShowMarkers = false.obs;
  RxString currentAddress = ''.obs;
  late final client = Client()
      .setEndpoint(AppWriteConstants.endPoint)
      .setProject(AppWriteConstants.projectId);
  late Databases collection_points;
  Set<Marker> markers = {};

  @override
  void onInit() {
    super.onInit();
    getUserLocation();
    loadMarkers();
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
      update();
    }
  }

  void loadMarkers() async {
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
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            onTap: () {
              currentAddress.value = address;
              shouldShowMarkers.value = true;
            },
          ),
        );
      }
      shouldShowMarkers.value = true;
      update();
    } catch (e) {
      print('Error!!! $e');
    }
  }
}
