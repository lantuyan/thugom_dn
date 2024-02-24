import 'package:thu_gom/shared/constants/color_constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: ColorsConstants.kBackgroundColor,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
             Text(
              'Welcome to your home!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              'This is Người thu gom rác app!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              'This is Người dân app!',
              style: TextStyle(fontSize: 24),
            ),
            ],
          ),
       ),
        ),
    );
  }
}
