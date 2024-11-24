import 'package:flutter/material.dart';

class DemoHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Dashboard'),
      ),
      body: Center(
        child: Text(
          'Chỉ Admin mới sử dụng được ứng dụng này.',
          style: TextStyle(fontSize: 20, color: Colors.red),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
