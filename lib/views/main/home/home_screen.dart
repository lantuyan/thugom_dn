import 'package:flutter/material.dart';
import 'package:thu_gom/managers/data_manager.dart';
import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:thu_gom/views/main/home/home_screen_admin.dart';
import 'package:thu_gom/views/main/home/home_screen_collecter.dart';
import 'package:thu_gom/views/main/home/home_screen_person.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final String role = DataManager().getData('role');
  @override
  Widget build(BuildContext context) {
    if(role == "admin"){
      return HomeAdminScreen();
    }else if(role == "person"){
      return HomeScreenPerson();
    }else if(role == "collector"){
      return HomeScreenCollector();
    }else{
      return Center(
        child: CircularProgressIndicator(color: ColorsConstants.kMainColor,),
      );
    }
  }
}