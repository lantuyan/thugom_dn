import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:thu_gom/controllers/map/map_controller.dart' as controller_map;

class CurrentLocationButton extends StatelessWidget {

  final IconData moveToCurrentLocationIcon;
  final Color? moveToCurrentLocationColor;
  final double padding;
  final Alignment alignment;
  final controller_map.MapController user; // Thêm đối tượng MapController

  const CurrentLocationButton({
    Key? key,
    required this.user, // Nhận đối tượng MapController từ bên ngoài

    this.moveToCurrentLocationIcon = Icons.my_location,
    this.moveToCurrentLocationColor,
    this.padding = 2.0,
    this.alignment = Alignment.topRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = MapController.of(context);
    return Align(
      alignment: alignment,
      child: Padding(
        padding: EdgeInsets.only(left: padding, top: padding, right: padding),
        child: FloatingActionButton(
          mini: false,
          backgroundColor: Colors.white,
          onPressed: () {
            // Move to current location
            controller.move(user.initialPos, 15);
          },
          child: Icon(
            moveToCurrentLocationIcon,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
