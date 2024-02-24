import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to your profile!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Get.offAllNamed('/mainPage');
              },
              child: Text('Go to Main Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
