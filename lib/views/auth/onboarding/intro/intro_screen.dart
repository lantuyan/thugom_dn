import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // intro screen with onboarding logic
    return Scaffold(
      appBar: AppBar(
        title: Text('Intro'),
      ),
      body: // button move to profile screen
      Center(
        child: ElevatedButton(
          onPressed: () {
            Get.toNamed('/profilePage');
          },
          child: Text('To Profile Screen'),
        ),
      ),
    );
  }
}