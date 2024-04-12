import 'dart:io';

import 'package:flutter/material.dart';
import 'package:face_camera/face_camera.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thu_gom/controllers/main/infomation/infomation_controller.dart';
import 'package:thu_gom/providers/user_request_trash_provider.dart';
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
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    final InfomationController _informationController = Get.put(
        InfomationController(
            UserRequestTrashRepository(UserRequestTrashProvider())));
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
                        await _informationController
                            .uploadImageToAppwrite(_capturedImage!);
                        await _informationController.sendImageToAppwrite(
                          _informationController.uid_user,
                        );
                        await Get.offAllNamed('/mainPage');
                      });
                    },
                    child: Text(
                      'Gửi minh chứng',
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
              autoCapture: false,
              defaultCameraLens: CameraLens.front,
              defaultFlashMode: CameraFlashMode.auto,
              showCameraLensControl: false,
              showFlashControl: false,
              onCapture: (File? image) {
                setState(() => _capturedImage = image);
              },
              onFaceDetected: (Face? face) {
                _message("Tuyệt vời, chụp ngay thôi");
              },
              messageBuilder: (context, face) {
                if (face == null) {
                  return _message('Để khuôn mặt của bạn vào máy ảnh');
                }
                if (!face.wellPositioned) {
                  return _message(
                      'Căn giữa khuôn mặt của bạn trong hình vuông');
                }
                return const SizedBox.shrink();
              });
        }));
  }

  Widget _message(String msg) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 55.sp, vertical: 20.sp),
        child: Text(msg,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyText1.copyWith(
                fontSize: 14.sp, color: ColorsConstants.kBackgroundColor)),
      );
}
