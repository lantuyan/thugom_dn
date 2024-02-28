import 'package:flutter/material.dart';
import 'package:thu_gom/managers/data_manager.dart';
import 'package:thu_gom/views/main/map/map_screen.dart';
import 'package:thu_gom/views/main/map/map_collecter_screen.dart';

class Map extends StatelessWidget {
  Map({super.key});

  final String role = DataManager().getData('role');
  @override
  Widget build(BuildContext context) {
    return role == "person" ? MapScreen() : MapCollecterScreen();
  }
}