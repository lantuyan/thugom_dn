import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:face_camera/face_camera.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thu_gom/controllers/profile/profile_controller.dart';
import 'package:thu_gom/providers/auth_provider.dart';
import 'package:thu_gom/providers/user_request_trash_provider.dart';
import 'package:thu_gom/repositories/auth_reposistory.dart';
import 'package:thu_gom/repositories/user_request_trash_reponsitory.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/shared/themes/style/app_text_styles.dart';
import 'package:thu_gom/widgets/custom_dialogs.dart';

class PortraitCollectorScreen extends StatefulWidget {
  const PortraitCollectorScreen({super.key});

  @override
  State<PortraitCollectorScreen> createState() => _PortraitCollectorState();
}

class _PortraitCollectorState extends State<PortraitCollectorScreen> {
  File? _capturedImage;
  bool isFaceWellPositioned = false;
  bool isCapture = false;
  Timer? _timer;
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    final ProfileController _profileController = Get.put(ProfileController(
        AuthRepository(AuthProvider()),
        UserRequestTrashRepository((UserRequestTrashProvider()))));
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chụp ảnh chân dung'),
        ),
        body: Builder(builder: (context) {
          if (_capturedImage != null) {
            return Center(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.file(
                    _capturedImage!,
                    width: double.maxFinite,
                    fit: BoxFit.fitWidth,
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => _capturedImage = null),
                    child: const Text(
                      'Chụp lại',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      CustomDialogs.confirmDialog(
                          'Gửi Ảnh Chân dung',
                          Text(
                            'Cập nhật ảnh chân dung',
                            style: AppTextStyles.bodyText1
                                .copyWith(fontSize: 14.sp),
                            textAlign: TextAlign.center,
                          ), () async {
                        await _profileController
                            .uploadImageToAppwrite(_capturedImage!);
                        // await Get.toNamed('/profilePage');
                        // Get.back();
                        Navigator.pop(context);
                        Navigator.pop(context);


                      },"Xác nhận");
                    },
                    child: Text(
                      'Xác nhận',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsConstants.kMainColor,
                      padding: EdgeInsets.fromLTRB(20.sp, 10.sp, 20.sp, 10.sp),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return SmartFaceCamera(
              autoDisableCaptureControl: true,
              showCaptureControl: false,
              performanceMode: FaceDetectorMode.accurate,
              autoCapture: isCapture,
              defaultCameraLens: CameraLens.front,
              defaultFlashMode: CameraFlashMode.auto,
              showCameraLensControl: false,
              showFlashControl: false,
              onCapture: (File? image) {
                setState(() => _capturedImage = image);
              },
            messageBuilder: (context, detectedFace) {
              print("CHECK face ok");
            if (detectedFace == null) {
              isFaceWellPositioned = false;
               print("CHECK face not on camera");
              return _message('Giữ khuôn mặt của bạn vào máy ảnh');
            } else {
              if (detectedFace.wellPositioned) {
                 print("CHECK face isFaceWellPositioned");
                
                if (isFaceWellPositioned == true) {
                     print("CHECK time value");
                    _timer = Timer(Duration(seconds: 2), () {
                      setState(() {
                        print("CHECK time correct");
                        isCapture = true;
                      });
                    });
                } else {
                  print("CHECK time cancel ");
                  if (_timer != null) {
                    _timer!.cancel(); 
                  }
                }
                isFaceWellPositioned = true;
                return _message('Giữ khuôn mặt trong 2 giây để chụp');
              } else {
                isFaceWellPositioned = false;
                 print("CHECK face outside");
                return _message('Giữ khuôn mặt của bạn ở giữa màn hình');
              }
            }
            
            // return const SizedBox.shrink();
          }
            );
        }));
  }

  Widget _message(String msg) => Container(
      height: 50.sp, 
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20), 
      margin: EdgeInsets.symmetric(horizontal: 55.sp, vertical: 20.sp), 
      child: Text(
        msg,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: AppTextStyles.bodyText1.copyWith(
          fontSize: 16.sp, 
          color: ColorsConstants.kActiveColor,
        ),
      ),
    );
}
