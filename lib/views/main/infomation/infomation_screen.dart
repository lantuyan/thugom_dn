import 'package:flutter/material.dart';

class InfomationScreen extends StatelessWidget {
  const InfomationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome to your infomation!',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}